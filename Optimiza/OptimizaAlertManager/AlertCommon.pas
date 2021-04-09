unit AlertCommon;

interface

uses uDmdata, afpEventLog,IniFiles, SysUtils, ValEdit, Dialogs, DateUtils,
  uFileWait, ExtCtrls, StrUtils;

procedure LogInformation(EventID:Integer;Param1:String);
procedure LogError(EventID:Integer;Param1:String);
procedure LogEmailMessage(aMessage: String);
procedure CheckScheduler;
procedure CheckProcess;
procedure CheckDrives;

implementation

{$IFDEF AlertService}
uses uService;
{$ELSE}
uses uSystray;
{$ENDIF}

procedure LogError(EventID:Integer;Param1:String);
begin
{$IFDEF AlertService}
with OptimizaServiceAlert do begin
{$ELSE}
with frmSystray do begin
{$ENDIF}
  if FEventLog then
  begin
    EventLog.EventType := etError;
    EventLog.EventID := EventID;
    EventLog.LogEvent(Param1);
  end;
  end;
end;

procedure LogInformation(EventID:Integer;Param1:String);
begin
{$IFDEF AlertService}
with OptimizaServiceAlert do begin
{$ELSE}
with frmSystray do begin
{$ENDIF}

  EventLog.EventType := etInformation;
  EventLog.EventID := EventID;
  EventLog.LogEvent(Param1);
  end;
end;

procedure LogEmailMessage(aMessage: String);
var
  AppStr, vleIniFileName:String;
begin
{$IFDEF AlertService}
with OptimizaServiceAlert do begin
{$ELSE}
with frmSystray do begin
{$ENDIF}
  if FSendEmail then
  begin
    AppStr := IniFile.ReadString('Email','Path for Emailer.exe','');
    vleIniFileName := IniFile.ReadString('Email','Parameter File for Emailer.exe','');
    vleIniFile1 := TIniFile.Create(vleIniFileName);
    if not FileExists(AppStr) then
      LogError(OA_General,'File not Found '+Appstr)
    else
    begin
      if not FileExists(vleIniFileName) then
        LogError(OA_General,'File not Found '+vleIniFileName)
      else
      begin
        vleIniFile1.WriteString('Email','Subject','Actrol Optimiza Error: ' + aMessage);
        vleIniFile1.WriteString('Email','Message','"'+aMessage+'"');
        vleIniFile1.Free;
        //vleIniFile.Strings.LoadFromFile(IniStr);
        //vleIniFile.Values['Subject'] := 'Actrol Optimiza Error: ' + aMessage;
        //vleIniFile.Values['Message'] := '"'+aMessage+'"';
        //vleIniFile.Strings.SaveToFile(IniStr);
        AppStr := AppStr + ' "'+vleIniFileName+'" "NOFIREEVENT"';
        ExecuteFileWait(AppStr,'');
      end;
    end;
  end;
  end;
end;


function CheckStart(AProcess: String):Boolean;
var
  LogFile, ProcessName, StartNoLater, EndNoLater: String;
  Year, Month, Day, Hour, Minute : word;
  PosChar: Integer;
begin
{$IFDEF AlertService}
with OptimizaServiceAlert do begin
  //LogError(OA_General,'CheckStart');
{$ELSE}
with frmSystray do begin
{$ENDIF}
  Result := True;
  if FProcessStatus = psNone then
  begin
    //Is scheduler running(2), waiting(1) or has it failed(4)?
    if FSchedStatus > 0 then
    begin
      ProcessName := IniFile.ReadString(AProcess,'Process','');
      StartNoLater := IniFile.ReadString(AProcess,'StartNoLaterThan','');
      EndNoLater := IniFile.ReadString(AProcess,'EndNoLaterThan','');
      DecodeDate(Now, Year, Month, Day);
      //Log file for the current day
      LogFile := edtPathText + '\' +
                 FloatToStr(Year)+
                 RightStr('0'+FloatToStr(Month),2)+
                 RightStr('0'+FloatToStr(Day),2)+ ' '+
                 ProcessName + '.1.log';
      //if it exists then it must have started
      if (FileExists(LogFile)) then
      begin
        FStartDate := Now;
        if AProcess = 'Daily' then
          FProcessStatus := psDailyStart
        else
          FProcessStatus := psMonthlyStart;
      end
      else
      begin
        PosChar := Pos(':',StartNoLater);
        Hour := StrToInt(Copy(StartNoLater,1,PosChar-1));
        Minute := StrToInt(Copy(StartNoLater,PosChar+1,Length(StartNoLater)));
        if (DayOfTheWeek(Now) <> DaySaturday) and (DayOfTheWeek(Now) <> DaySunday) then
        begin
          //Current Time exceed the start no later than time
          if Time > EncodeTime(Hour,Minute,0,0) then
          begin
            Result := False;
          end;
        end;
      end;
    end; //if shedstatus
  end;
  end;
end;

function CheckEnd: Boolean;
var
  EndNoLater: String;
  Hour, Minute: Word;
  PosChar: Integer;
begin
{$IFDEF AlertService}
with OptimizaServiceAlert do begin
  //LogError(OA_General,'CheckEnd');
{$ELSE}
with frmSystray do begin
{$ENDIF}
  Result := True;
  if FProcessStatus = psDailyStart then
    EndNoLater := IniFile.ReadString('Daily','EndNoLaterThan','')
  else
    EndNoLater := IniFile.ReadString('Monthly','EndNoLaterThan','');
  //Make sure we are on the next day !!!
  if DateOf(Now) > DateOf(FStartDate) then
  begin
    PosChar := Pos(':',EndNoLater);
    Hour := StrToInt(Copy(EndNoLater,1,PosChar-1));
    Minute := StrToInt(Copy(EndNoLater,PosChar+1,Length(EndNoLater)));
    //then we check time
    if Time > EncodeTime(Hour,Minute,0,0) then
    begin
      Result := False;
    end;
  end;
  end;
end;


procedure CheckScheduler;
var
  aMsg:String;
begin
{$IFDEF AlertService}
with OptimizaServiceAlert do begin
{$ELSE}
with frmSystray do begin
{$ENDIF}
  FSchedStatus := dmData.GetSchedulerStatus;

  //if we started shutdown sequence and scheduler status returns -1
  // then we have an error Else we have restarted successfully, so
  // we reset indicator
  if (FFirebirdShutdown) and (FSchedStatus > -1) then
    FFirebirdShutdown := False;

  if FSchedStatus = -1 then
  begin
    LogError(OA_Stopped,'');
    Timer.Enabled := False;
    aMsg := 'Database Server and Guardian has stopped';
    LogEmailMessage(aMsg);
    //Timer.Enabled := True;
    FProcessStatus := psNone;
  end;

  //Scheduler values
  // 0 = Scheduler not running
  // 1 = Waiting for next Schedule to begin
  // 2 = Busy Running
  // 3 = Finished with Warning ????
  // 4 = Error - Scheduler failed

  if FSchedStatus = 0 then
  begin
    LogError(OA_Stopped,'');
    Timer.Enabled := False;
    aMsg:= 'Optimiza Scheduler has stopped';
    LogEmailMessage(aMsg);

    //Timer.Enabled := True;
    FProcessStatus := psNone;
  end;

  if FSchedStatus = 4 then
  begin
    LogError(OA_Failed,'Scheduler has Failed');
    Timer.Enabled := False;
    aMsg := 'Optimiza Scheduler has Failed';
    LogEmailMessage(aMsg);
    //Timer.Enabled := True;
    FProcessStatus := psNone;
  end;
  end;
end;

procedure CheckProcess;
var
  StartNoLater, EndNoLater,aMsg: String;
begin
{$IFDEF AlertService}
with OptimizaServiceAlert do begin
  //LogInformation(OA_General,'CheckProcess');
{$ELSE}
with frmSystray do begin
{$ENDIF}
  //if nothing has started yet then check if either month end
  // or daily has started by the given time frame.
  if FProcessStatus = psNone then
  begin
    //check if either daily or montly log file exists.
    // if it doesn't exist and the start time is exceeded then
    // we raise alert.
    if (not CheckStart('Daily')) or (not CheckStart('Monthly')) then
    begin
      StartNoLater := IniFile.ReadString('Daily','StartNoLaterThan','');
        Timer.Enabled := False;

      LogError(OA_NotStarted,'');
      aMsg := 'Scheduler has not started! Needs to start no later than '+
               StartNoLater;
      LogEmailMessage(aMsg);
        //Timer.Enabled := True;
    end;
  end;
  if FProcessStatus in [psDailyStart,psMonthlyStart] then
  begin
    //now check if scheduler is still processing
    //waiting for next schedule .ie must have completed the run??
    //
    if FSchedStatus = 1 then
    begin
      FProcessStatus := psNone;
    end
    else
    begin
      if not CheckEnd then
      begin
        if FProcessStatus = psDailyStart then
        begin
          EndNoLater := IniFile.ReadString('Daily','EndNoLaterThan','');
          LogError(OA_NotFinished,'Daily');
        end
        else
        begin
          EndNoLater := IniFile.ReadString('Monthly','EndNoLaterThan','');
          LogError(OA_NotFinished,'Monthly');
        end;

        Timer.Enabled := False;
        aMsg := 'Scheduler has not Finished! Needs to finish no later than '+
                 EndNoLater;

        LogEmailMessage(aMsg);
        //Timer.Enabled := True;
      end;
    end;
  end;
  end;
end;

procedure CheckDrives;
var
  DriveCount, DriveSize:Integer;
  DriveChar, DriveTest,aMsg: String;
begin
{$IFDEF AlertService}
with OptimizaServiceAlert do begin
{$ELSE}
with frmSystray do begin
{$ENDIF}
  //LogInformation(OA_General,'CheckDrives');
  //Check drives C to M
  for DriveCount := 3 to 13 do
  begin
    DriveChar := 'Drive'+Chr(64+DriveCount);
    DriveTest := IniFile.ReadString('DiskSpace',DriveChar,'');
    DriveChar := Chr(64+DriveCount) + ':';
    if DriveTest <> '' then
    begin
      //Convert to MB
      DriveSize := StrToInt(DriveTest);
      if (DiskFree(DriveCount)/1000000) < DriveSize then
      begin
        LogError(OA_General,'Available Disk Space on '+DriveChar+' Running Low '+FormatFloat('###.## MB',(DiskFree(DriveCount)/1000000)));
        Timer.Enabled := False;
        aMsg := 'Available Disk Space of '+
                     FormatFloat('###.## MB',(DiskFree(DriveCount)/1000000))+
                      ' on ' + DriveChar +
                     ' is below the threshold setting of ' + DriveTest + 'MB';
        LogEmailMessage(aMsg);
        //Timer.Enabled := True;
      end;
    end;
  end;
  end;
end;

end.
