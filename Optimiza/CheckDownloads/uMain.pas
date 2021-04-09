unit uMain;
// Version 1.2 - Allow Daily to wait for all files
// Version 1.3 - Change way program works, wait for either a Monthly or Daily set of files but only wait till a set time
// Version 1.4 - Make sure the Successful trigger get sent

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils,Math,
  Grids, ValEdit, Buttons;


type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Label1: TLabel;
    vleIniFile: TValueListEditor;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

  private
    LogFile : TextFile;
    FirstShow:Boolean;
    FUserAbort:Boolean;
    procedure Say(Line : string);
    procedure StartProcess;
    procedure OpenLogFile;
    function MonthlyTriggerFound:Boolean;
    function DailyTriggerFound: Boolean;
    procedure LoopUntilAllFound;
    procedure LoopUntilAllDailyFound;
    procedure SendEmail(FCount:Integer;Msg: TStringList);
    function CheckForFiles(CheckType:String;MailSent:Boolean):Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

uses udmData, uParameters, uFileWait;

{$R *.DFM}

procedure TfrmMain.Say(Line : string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Application.ProcessMessages;
end;

procedure TfrmMain.StartProcess;
var
  AllFound,MailSent:Boolean;
  LoopTime:String;
  StartTime, CurTime, AbortTime:TDateTime;
  TrigName:String;
  TrigFile:TextFile;
  MailMsg:TStringList;
begin

  try
    MailMsg := TStringList.Create;


    Say('Parameter File: '+frmParameters.edtIniFile.Text);
    frmParameters.LoadParam;
    MailSent := False;

    AbortTime := timeof(frmParameters.dteDailyEnd.Time);
    CurTime := timeof(now);
    // Keep checking for a set of feed files up until cutoff time
    Repeat
      AllFound := false;
      TrigName := '';
      // Check for a monthly trigger if found wait for all monthly files
      if MonthlyTriggerFound then
      begin
        LoopUntilAllFound;
        If FUserAbort then
          raise ERangeError.Create('Aborted by user');
        Repeat
          AllFound := CheckForFiles('Monthly',Mailsent);
          If FUserAbort then
            raise ERangeError.Create('Aborted by user');
          //only send the mail once
          MailSent := True;
          if not AllFound then
          begin
            LoopTime := frmParameters.edtDailyLoop.text;
            Say('Not ALL MONTHLY download files were present, will check again in '+LoopTime+ ' Minutes');
            Say('...');
            StartTime := IncMinute(Time,StrToInt(LoopTime));
            Application.ProcessMessages;
            While Time < StartTime do
            begin
              //Every 5 seconds, check to see if cancel button is clicked
              if SecondOf(Now) mod 5 = 0 then
              begin
                Application.ProcessMessages;
                If FUserAbort then
                  raise ERangeError.Create('Aborted by user');
              end;
            end;
          end;
          CurTime := timeof(now);
        Until AllFound or (CurTime > AbortTime);
        if allFound then TrigName := frmParameters.edtMonthlyTrig.Text;
      end

      // Else check for a Daily trigger and if found wait for all files
      else if DailyTriggerFound then
      begin
        LoopUntilAllDailyFound;
        If FUserAbort then
          raise ERangeError.Create('Aborted by user');
        Repeat
          AllFound := CheckForFiles('Daily',Mailsent);
          If FUserAbort then
            raise ERangeError.Create('Aborted by user');
          //only send the mail once
          MailSent := True;
          if not AllFound then
          begin
            LoopTime := frmParameters.edtDailyLoop.text;
            Say('Not ALL Daily download files were present, will check again in '+LoopTime+ ' Minutes');
            Say('...');
            StartTime := IncMinute(Time,StrToInt(LoopTime));
            Application.ProcessMessages;
            While Time < StartTime do
            begin
              //Every 5 seconds, check to see if cancel button is clicked
              if SecondOf(Now) mod 5 = 0 then
              begin
                Application.ProcessMessages;
                If FUserAbort then
                  raise ERangeError.Create('Aborted by user');
              end;
            end;
          end;
          CurTime := timeof(now);
        Until AllFound or (CurTime > AbortTime);
        if allFound then TrigName := frmParameters.edtDailyTrig.Text;
      end;
      CurTime := timeof(now);
      If FUserAbort then
        raise ERangeError.Create('Aborted by user');
    Until allFound or (CurTime > AbortTime);


    if not allFound then
    begin
      Say('Trigger(s) not Received before cut off time ('+frmParameters.vleParameters.Values['Daily End']+')');
      MailMsg.Clear;
      MailMsg.Add('Trigger(s) not Received before cut off time ('+frmParameters.vleParameters.Values['Daily End']+')');
      // TODO get email working again
      SendEmail(1, MailMsg);
      dmData.FireEvent('S');
      Exit;
    end
    else if TrigName <> '' then
    begin
      AssignFile(TrigFile,TrigName);
      rewrite(TrigFile);
      WriteLn(TrigFile,'Start Process');
      CloseFile(TrigFile);
    end;

    dmData.FireEvent('S');

  except
      on e: exception do begin
        Say('***  failed');
        Say('*** ' + e.Message);
        dmData.FireEvent('F');
      end;
  end;


end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  StartTime : TDateTime;
  RunProcess:Boolean;
  FName:String;
begin
  
  if FirstShow then
  begin

    Caption := Caption + ' ' + dmData.DbDescription;
    FirstShow := False;

    if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) then
    begin
      frmParameters.edtIniFile.Text := ParamStr(1);
      RunProcess := True;
      frmParameters.LoadParam;

    end
    else
    Begin

      Memo1.Lines.add('Parameter Setup');
      frmParameters.Caption := 'Parameter Setup';

       if UpperCase(ParamStr(1)) = '-Z' then
       begin

        frmParameters.edtIniFile.Text := ParamStr(3);


       end;

      frmParameters.ShowModal;

      RunProcess := frmParameters.CreateOutput;

    end;

    if RunProcess then
    begin
      OpenLogFile;

      StartTime := Now;
      Say(FName+' started on ' + DateTimeToStr(StartTime));

      StartProcess;

      Say(FName+' finished on ' + DateTimeToStr(Now));
      Say(Format('Elapsed Time: %.2f seconds', [(Now - StartTime) * 86400]));

      CloseFile(LogFile);
      Close;
    end
    else
      Close;


  end;



end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  FUserAbort := False;
end;



procedure TfrmMain.OpenLogFile;
var
  FName:String;
  Year,Month,Day:Word;
  FCount:Integer;
begin
  FName := dmData.GetLogFileName;
  AssignFile(LogFile,FName );
  Rewrite(LogFile);

end;

function TfrmMain.MonthlyTriggerFound: Boolean;
var
  FCount:Integer;
begin

  Result := False;

  with frmParameters.grdFile do
  begin

    for FCount := 1 to RowCount -1 do
    begin

      //If any of the monthly triggers exist then we know its a monthly
      if Cells[0,FCount] = 'Monthly' then
      begin
        if FileExists(Cells[1,FCount]) then
        begin
          Say('MONTHLY File Check Activated by '+Cells[1,FCount]);
          Result := True;
          Break;
        end;

      end;

    end;

  end;

end;

function TfrmMain.DailyTriggerFound: Boolean;
var
  FCount:Integer;
begin

  Result := False;

  with frmParameters.grdFile do
  begin

    for FCount := 1 to RowCount -1 do
    begin

      //If any of the daily triggers exist
      if Cells[0,FCount] = 'Daily' then
      begin
        if FileExists(Cells[1,FCount]) then
        begin
          Say('Daily trigger found '+Cells[1,FCount]);
          Result := True;
          Break;
        end;

      end;

    end;

  end;

end;

procedure TfrmMain.LoopUntilAllDailyFound;
var
  FCount, FCount1:Integer;
  AllFilesPresent:Boolean;
  LoopTime:String;
  StartTime, AbortTime, CurTime : TDateTime;
  EmailSent:Boolean;
  MailMsg:TStringList;
begin

  LoopTime := frmParameters.edtDailyLoop.text;
  Say('Checking for ALL Daily trigger files');
  EmailSent := True;
  MailMsg := TStringList.Create;
  AbortTime := timeof(frmParameters.dteDailyEnd.Time);
  with frmParameters.grdFile do
  begin

    Repeat
      FCount1:=-1;
      AllFilesPresent := True;

      for FCount := 1 to RowCount -1 do
      begin

        //If any of the daily triggers do not exist then we wait until it arrives
        if Cells[0,FCount] = 'Daily' then
        begin
          if not FileExists(Cells[1,FCount]) then
          begin
            Say('Daily Trigger not found for '+Cells[1,FCount]);
            AllFilesPresent := False;
            FCount1:=FCount;
            if not EmailSent then
            begin
              MailMsg.Clear;
              MailMsg.Add('Daily Trigger not found '+Cells[1,FCount]+'. ');
              SendEmail(FCount, MailMsg);
            end;

          end;

        end;

      end;

      if not AllFilesPresent then
      begin
        EmailSent := True;
        Say('Not ALL DAILY trigger files were present, will check again in '+LoopTime+ ' Minutes');
        Say('...');
        StartTime := IncMinute(Time,StrToInt(LoopTime));
        Application.ProcessMessages;
        While Time < StartTime do
        begin
            //Every 5 seconds, check to see if cancel button is clicked
            if SecondOf(Now) mod 5 = 0 then
            begin
              Application.ProcessMessages;
              If FUserAbort then
                Exit;

            end;
        end;
        CurTime := timeof(now);
        if CurTime > AbortTime then
        begin
          Say('Daily Trigger(s) not Received before cut off time ('+frmParameters.vleParameters.Values['Daily End']+')');
          AllFilesPresent := False;
          MailMsg.Clear;
          MailMsg.Add('Daily Trigger(s) not Received before cut off time ('+frmParameters.vleParameters.Values['Daily End']+')');
          // TODO get email working again
          SendEmail(FCount1, MailMsg);
          Exit;
        end;
      end
      else
        Say('ALL DAILY trigger files were present');

    until AllFilesPresent;

  end;

  MailMsg.Free;

end;

procedure TfrmMain.LoopUntilAllFound;
var
  FCount, FCount1:Integer;
  AllFilesPresent:Boolean;
  LoopTime:String;
  StartTime, AbortTime, CurTime : TDateTime;
  EmailSent:Boolean;
  MailMsg:TStringList;
begin

  LoopTime := frmParameters.edtDailyLoop.text;
  Say('Checking for ALL MONTHLY trigger files');
  EmailSent := True;
  MailMsg := TStringList.Create;
  AbortTime := timeof(frmParameters.dteDailyEnd.Time);

  with frmParameters.grdFile do
  begin

    Repeat
      AllFilesPresent := True;
      FCount1:=-1;

      for FCount := 1 to RowCount -1 do
      begin

        //If any of the monthly triggers do not exist then we wait until it arrives
        if Cells[0,FCount] = 'Monthly' then
        begin
          if not FileExists(Cells[1,FCount]) then
          begin
            Say('MONTHLY Trigger not found for '+Cells[1,FCount]);
            AllFilesPresent := False;
            FCount1:=FCount;
            if not EmailSent then
            begin
              MailMsg.Clear;
              MailMsg.Add('MONTHLY Trigger not found '+Cells[1,FCount]+'. ');
              SendEmail(FCount, MailMsg);
            end;

          end;

        end;

      end;

      if not AllFilesPresent then
      begin
        EmailSent := True;
        Say('Not ALL MONTHLY trigger files were present, will check again in '+LoopTime+ ' Minutes');
        Say('...');
        StartTime := IncMinute(Time,StrToInt(LoopTime));
        Application.ProcessMessages;
        While Time < StartTime do
        begin
            //Every 5 seconds, check to see if cancel button is clicked
            if SecondOf(Now) mod 5 = 0 then
            begin
              Application.ProcessMessages;
              If FUserAbort then
                Exit;

            end;
        end;
        CurTime := timeof(now);
        if CurTime > AbortTime then
        begin
          Say('Monthly Trigger(s) not Received before cut off time ('+frmParameters.vleParameters.Values['Daily End']+')');
          AllFilesPresent := False;
          MailMsg.Clear;
          MailMsg.Add('Monthly Trigger(s) not Received before cut off time ('+frmParameters.vleParameters.Values['Daily End']+')');
          // TODO get email working again
          SendEmail(FCount1, MailMsg);
          Exit;
        end;

      end
      else
        Say('ALL MONTHLY trigger files were present');

    until AllFilesPresent;

  end;

  MailMsg.Free;

end;


procedure TfrmMain.SendEmail(FCount:Integer;Msg: TStringList);
var
  AppName, IniFileName:String;
begin
  IniFileName := frmParameters.grdFile.Cells[3,FCount];
  if FileExists(IniFileName) then
  begin
    vleIniFile.Strings.LoadFromFile(IniFileName);
    Msg.Insert(0,'This check was performed at '+DateTimeToStr(Now)+'. ');
    Msg.Add('');
    Msg.Add('This message was delivered to you by Optimiza. ');
    vleIniFile.Values['Message'] := Msg.CommaText;

    vleIniFile.Strings.SaveToFile(IniFileName);

    AppName := frmParameters.edtEmailApp.text + ' "'+IniFileName+'" "NOFIREEVENT"';

    ExecuteFileWait(AppName,'');
  end
  else
  begin
    Say('*** Error Email Ini File not found '+IniFileName);
  end;

end;

function TfrmMain.CheckForFiles(CheckType: String;MailSent:Boolean): Boolean;
var
  FCount,ACount:Integer;
  StartTime,EndTime:TDateTime;
  AFileList,MailMsg:TStringList;
  AFileName:String;
begin
  Result := True;
  AFileList := TStringList.Create;
  MailMsg  := TStringList.Create;

  Say('Checking for '+CheckType+' download files');
  StartTime := frmParameters.GetStartTime(CheckType);
  EndTime := frmParameters.GetEndTime(CheckType);

  with frmParameters.grdFile do
  begin

      for FCount := 1 to RowCount -1 do
      begin

        if Cells[0,FCount] = CheckType then
        begin
        //If any of the monthly triggers do not exist then we wait until it arrives
          if not FileExists(Cells[1,FCount]) then
          begin
            Result:=False;
          end;

          MailMsg.Clear;
          AFileList.Clear;
          AFileList.CommaText := Cells[2,FCount];

          for ACount := 0 to AFileList.Count-1 do
          begin
            AFileName:= Trim(AFileList.Strings[ACount]);

            if AFileName <> '' then
            begin

              if not FileExists(AFileName) then
              begin
                Say(CheckType+' File not Found '+AFileName);
                MailMsg.Add(CheckType+' File not Found '+AFileName+'. ');
                Result:=False;
              end
              else
              begin

                if (FileDateToDateTime(FileAge(AFileName)) < StartTime) then
                begin
                  Say(CheckType+' File '+AFileName+
                      ' appears to be an old revision. Date Stamp '+
                      DateTimeToStr(FileDateToDateTime(FileAge(AFileName))) );
                  MailMsg.Add(CheckType+' File '+AFileName+
                             ' appears to be an old revision. Date Stamp '+
                             DateTimeToStr(FileDateToDateTime(FileAge(AFileName)))+'. ' );
                  Result:=False;
                end;

              end;

            end;

          end;  //for Acount

          if (not MailSent) and (MailMsg.Count > 0) then
          begin
            Say(CheckType+' files are supposed to arrive between '+DateTimeToStr(StartTime)+' and '+DateTimeToStr(EndTime)+'. ');
            MailMsg.Insert(0,CheckType+' files are supposed to arrive between '+DateTimeToStr(StartTime)+' and '+DateTimeToStr(EndTime)+'. ');

            MailMsg.Insert(0,'NOTE: Files are critical. Optimiza will not process until ALL files are available. ');


            MailMsg.Insert(2,'');
            SendEMail(FCount, MailMsg);
          end;

        end;  //if Checktype

      end;  //next for FCount

      if Result = True then
        Say('ALL '+CheckType+' download files were present');


  end;  //With

  AFileList.Free;

end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  Say('*** Aborted by user');
  FUserAbort := True;
end;

end.
