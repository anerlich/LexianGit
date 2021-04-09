unit uSystray;

interface

uses
  Windows, Messages,SysUtils,Classes,Graphics, Controls, Forms, Dialogs,
  Menus, ShellAPI, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGrids,StrUtils,IniFiles,
  afpEventLog,DateUtils, OnlyOpenOnce, MainInstance;

type
  TProcessStatus = (psDailyStart,psDailyEnd, psMonthlyStart, psMonthlyEnd, psNone);

  TForm1 = class(TForm)
    PopupMenu: TPopupMenu;
    pmnuiOpen: TMenuItem;
    pmnuiExit: TMenuItem;
    Timer: TTimer;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    Button2: TButton;
    memDrive: TMemo;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Button1: TButton;
    memDaily: TMemo;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edtInterval: TEdit;
    Button3: TButton;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    memMonthly: TMemo;
    GroupBox4: TGroupBox;
    edtPath: TEdit;
    Button5: TButton;
    EventLog: TafpEventLog;
    Button4: TButton;
    MainInstance1: TMainInstance;
    Button6: TButton;
    Button7: TButton;
    CurrentStatus1: TMenuItem;
    GroupBox5: TGroupBox;
    Button8: TButton;
    memEmail: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure pmnuiOpenClick(Sender: TObject);
    procedure pmnuiExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1Exit(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure CurrentStatus1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
    FFirstShow: Boolean;
    IniFile:TIniFile;
    FProcessStatus:TProcessStatus;
    FStartDate: TDateTime;
    FSchedStatus:Integer;
    FFirebirdShutDown: Boolean;
    procedure RefreshDrive;
    procedure RefreshSched;
    procedure RefreshInterval;
    procedure UpdateSchedule(SchedType: String);
    procedure SetTimeInterval;
    procedure CheckDrives;
    procedure CheckProcess;
    procedure LogError(EventID:Integer;Param1: String);
    procedure LogInformation(EventID:Integer;Param1: String);
    procedure CheckScheduler;
    function CheckStart(AProcess: String):Boolean;
    function CheckEnd:Boolean;
    procedure RefreshPath;
    procedure IBShutDown(var Msg: tMessage); message wmMainInstanceMessage;
    procedure ChangeIconHint(NewMessage:String);
    procedure RefreshEmail;

  protected
    procedure WndProc(var Msg: TMessage); override;
  public
    { Public declarations }
    IconData: TNotifyIconData;
  end;

var
  Form1: TForm1;

const
  OA_General      = 1000;
  OA_NotStarted   = 1001;
  OA_NotFinished  = 1002;
  OA_Stopped      = 1003;
  OA_Failed       = 1004;
  OA_AlertStart   = 1005;
  OA_AlertStop    = 1006;

implementation

uses uDmdata, uEditDrive, uInterval, uEditSchedule, uSelectFolder,
  uDriveSpace, uEmail;

{$R *.DFM}
{$R MyRes.RES}
{$R Optimiza.res}

procedure TForm1.WndProc(var Msg: TMessage);
var
  p: TPoint;
begin
  case Msg.Msg of
    WM_USER + 1:
      case Msg.lParam of
        WM_RBUTTONDOWN:
          begin
            // Popup the popup menu
            SetForegroundWindow(Handle);
            GetCursorPos(p);
            PopupMenu.Popup(p.x, p.y);
            PostMessage(Handle, WM_NULL, 0, 0);
          end;
        WM_LBUTTONDBLCLK:
          begin
            pmnuiOpen.Click;
          end;
      end;
  end;
  inherited;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  IniFileName: String;
begin
  // Define the system tray icon
  IconData.cbSize := sizeof(IconData);
  IconData.Wnd := Handle;
  IconData.uID := 100;
  IconData.uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
  // Define our internal message number that we will receive at WndProc
  IconData.uCallbackMessage := WM_USER + 1;
  IconData.hIcon := LoadIcon(HInstance, Pchar(287)); // The icon
  StrPCopy(IconData.szTip, 'Optimiza Alert Manager');
  Shell_NotifyIcon(NIM_ADD, @IconData);
  FFirstShow := True;
  StatusBar1.Panels[0].Text := dmData.dbOptimiza.DatabaseName;
  IniFileName := ParamStr(0);
  IniFileName := Copy(IniFileName,1,Length(IniFileName)-3) + 'ini';
  IniFile := TIniFile.Create(IniFileName);
  FProcessStatus := psNone;
  FFirebirdShutDown := False;

  LogInformation(OA_General,'Optimiza Alert Manager has started');

end;

procedure TForm1.pmnuiOpenClick(Sender: TObject);
begin
  dmData.dbOptimiza.Connected := True;

  Form1.Show;
  ShowWindow(Application.Handle, SW_HIDE);


end;

procedure TForm1.pmnuiExitClick(Sender: TObject);
begin
  Application.ProcessMessages;
  Application.Terminate;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  Form1.Hide;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @IconData);
  LogInformation(OA_General,'Optimiza Alert Manager has stopped');

end;

procedure TForm1.TimerTimer(Sender: TObject);
begin
  if FFirstShow then
  begin
    dmData.dbOptimiza.Connected := False;
    FFirstShow := False;
    SetTimeInterval;
    Hide;
  end;

  CheckScheduler;
  CheckProcess;
  CheckDrives;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LstCount: Integer;
  SelDrive, SelMB: String;
  TheResult: Integer;
begin
  for LstCount := 0 to listBox1.Count - 1 do
  begin

    if listbox1.Selected[LstCount] then
    begin
      SelDrive := listBox1.Items.Strings[LstCount];
      SelDrive := AnsiReplaceStr(SelDrive,' ','');
      SelDrive := AnsiReplaceStr(SelDrive,':','');
      break;
    end;

  end;

  if SelDrive = '' then
    MessageDlg('Please Select a Drive to Edit',mtWarning,[mbOK],0)
  else
  begin

    with frmEditDrive do
    begin
      SelMB := '';
      Edit1.Text := SelDrive;
      edtMB.Text := Trim(IniFile.ReadString('DiskSpace',SelDrive,''));
      TheResult := ShowModal;

      if TheREsult = mrOK then
      begin

        if edtMB.Text <> '' then
          IniFile.WriteString('DiskSpace',SelDrive,Trim(edtMB.text));

        RefreshDrive;
      end;

      if FormResult = mrYes then
      begin

        IniFile.DeleteKey('DiskSpace',SelDrive);

        RefreshDrive;
      end;

    end;

  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin

  with frmInterval do
  begin
    edtInterval.Text := IniFile.ReadString('TimeInterval','Time','');

    if ShowModal = mrOK then
    begin
      IniFile.WriteString('TimeInterval','Time',Trim(edtInterval.text));

    end;
  end;

  RefreshInterval;


end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  IniFile.UpdateFile;
  SetTimeInterval;
  FProcessStatus := psNone;
  Hide;
end;

procedure TForm1.RefreshDrive;
begin
  MemDrive.Clear;
  IniFile.ReadSectionValues('DiskSpace', MemDrive.Lines);

end;

procedure TForm1.RefreshInterval;
begin
 edtInterval.Text := IniFile.ReadString('TimeInterval','Time','');
end;

procedure TForm1.RefreshSched;
begin
  memDaily.clear;
  IniFile.ReadSectionValues('Daily', MemDaily.Lines);
  memMonthly.clear;
  IniFile.ReadSectionValues('Monthly', MemMonthly.Lines);

end;

procedure TForm1.FormHide(Sender: TObject);
begin
  dmData.srcSchedule.DataSet.Close;
   dmData.dbOptimiza.Connected := False;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  dmData.srcSchedule.DataSet.Open;
  RefreshDrive;
  RefreshSched;
  RefreshInterval;
  RefreshPath;
  RefreshEmail;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  UpdateSchedule('Daily');
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  RefreshSched;

end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  RefreshSched;

end;

procedure TForm1.DBGrid1Exit(Sender: TObject);
begin
  RefreshSched;

end;

procedure TForm1.UpdateSchedule(SchedType: String);

begin

  with frmEditSchedule do
  begin
    Edit1.Text := IniFile.ReadString('Daily','Process','');
    Edit2.Text := IniFile.ReadString('Monthly','Process','');
    edtStart.Text := IniFile.ReadString('Daily','StartNoLaterThan','');
    edtDayEnd.Text :=IniFile.ReadString('Daily','EndNoLaterThan','');
    edtMthEnd.Text :=IniFile.ReadString('Monthly','EndNoLaterThan','');

    if ShowModal = mrOK then
    begin
      IniFile.WriteString('Daily','Process',Edit1.text);
      IniFile.WriteString('Monthly','Process',Edit2.text);
      IniFile.WriteString('Daily','StartNoLaterThan',edtStart.text);
      IniFile.WriteString('Monthly','StartNoLaterThan',edtStart.text);
      IniFile.WriteString('Daily','EndNoLaterThan',edtDayEnd.text);
      IniFile.WriteString('Monthly','EndNoLaterThan',edtMthEnd.text);
      RefreshSched;
    end;
  end;

end;

procedure TForm1.SetTimeInterval;
var
 TempInt, TempNum: Cardinal;
 TempStr: String;

begin
  TempStr := IniFile.ReadString('TimeInterval','Time','');

  ChangeIconHint('Optimiza Alert Checking Every ('+TempStr+') minutes');
  TempNum := 160;

  if TempStr <> '' then
  begin
    try
      TempInt := StrToInt(Trim(TempStr));
      TempNum := (TempInt * 60);
      TempNum := TempNum * 1000;
    except
      TempNum := 160;
    end;

  end;

   Timer.Interval := TempNum;


end;

procedure TForm1.CheckDrives;
var
  DriveCount, DriveSize:Integer;
  DriveChar, DriveTest: String;
begin

  //Check drives C to M

  for DriveCount := 3 to 13 do
  begin

    DriveChar := 'Drive'+Chr(64+DriveCount);

    DriveTest := IniFile.ReadString('DiskSpace',DriveChar,'');

    if DriveTest <> '' then
    begin

      //Convert to MB
      DriveSize := StrToInt(DriveTest);


      if (DiskFree(DriveCount)/1000000) < DriveSize then
      begin
        LogError(OA_General,'Available Disk Space on '+DriveChar+' Running Low '+FormatFloat('###.## MB',(DiskFree(DriveCount)/1000000)));
        Timer.Enabled := False;
        MessageDlg('Available Disk Space of '+
                     FormatFloat('###.## MB',(DiskFree(DriveCount)/1000000))+
                      ' on ' + DriveChar +
                     ' is below the threshold setting of ' + DriveTest + 'MB',
                      mtError,[mbOK],0);
        Timer.Enabled := True;
      end;
    end;

  end;

end;
//--------------------------------------------------------------
procedure TForm1.CheckProcess;
var
  StartNoLater, EndNoLater: String;
begin

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
      MessageDlg('Scheduler has not started! Needs to start no later than '+
               StartNoLater, mtError,[mbOK],0);
        Timer.Enabled := True;
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

        MessageDlg('Scheduler has not Finished! Needs to finish no later than '+
                 EndNoLater, mtError,[mbOK],0);
        Timer.Enabled := True;
      end;

    end;

  end;

end;

procedure TForm1.LogError(EventID:Integer;Param1:String);
begin
  EventLog.EventType := etError;
  EventLog.EventID := EventID;
  EventLog.LogEvent(Param1);
end;

procedure TForm1.LogInformation(EventID:Integer;Param1:String);
begin
  EventLog.EventType := etInformation;
  EventLog.EventID := EventID;
  EventLog.LogEvent(Param1);
end;

procedure TForm1.CheckScheduler;
begin


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
    MessageDlg('Database Server and Guardian has stopped',mtError,[mbOK],0);
    Timer.Enabled := True;
    FProcessStatus := psNone;
  end;

  //Scheduler values
  // 0 = Scheduler not running
  // 1 = Waiting for next Schedule to begin
  // 2 = Busy Running
  // 3 = Finished with Warning ????
  // 4 = Error - Schduler failed
  
  if FSchedStatus = 0 then
  begin
    LogError(OA_Stopped,'');
    Timer.Enabled := False;
    MessageDlg('Optimiza Scheduler has stopped',mtError,[mbOK],0);
    Timer.Enabled := True;
    FProcessStatus := psNone;
  end;

  if FSchedStatus = 4 then
  begin
    LogError(OA_Failed,'Scheduler has Failed');
    Timer.Enabled := False;
    MessageDlg('Optimiza Scheduler has Failed',mtError,[mbOK],0);
    Timer.Enabled := True;
    FProcessStatus := psNone;
  end;





end;
//---------------------------------------------------------------
function TForm1.CheckStart(AProcess: String):Boolean;
var
  LogFile, ProcessName, StartNoLater, EndNoLater: String;
  Year, Month, Day, Hour, Minute : word;
  PosChar: Integer;
begin

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
      LogFile := edtPath.Text + '\' +
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

procedure TForm1.Button5Click(Sender: TObject);
begin

  if frmSelectFolder.showmodal = mrOK then
  begin
    edtPath.Text := frmSelectFolder.ShellTreeView1.SelectedFolder.PathName;
    IniFile.WriteString('Paths','LogFiles',edtPath.Text);
  end;

end;

procedure TForm1.RefreshPath;
begin
  edtPath.Text := IniFile.ReadString('Paths','LogFiles','');
end;
//-------------------------------------------------------------
function TForm1.CheckEnd: Boolean;
var
  EndNoLater: String;
  Hour, Minute: Word;
  PosChar: Integer;
begin

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

procedure TForm1.Button4Click(Sender: TObject);
Var
  I : Integer;
  S : String;
begin
  SetLength(S,Max_Path);
  SetLength(S,GetSystemDirectory(PChar(S),Max_Path));
  If (S <> '') Then S := S+'\';
  S := S+'eventvwr.exe';
  I := ShellExecute(Handle,nil,PChar(S),'','',sw_ShowDefault);
  If (I < 32) Then ShowMessage('Could not execute Event Viewer ('+IntToStr(I)+').');
end;

procedure TForm1.IBShutDown(var Msg: tMessage);
var S: String;
    PC: array[0..MAX_PATH]of Char;
begin
  GlobalGetAtomName(Msg.wParam, PC, MAX_PATH);
  S:= StrPas(PC);
  FFirebirdShutDown := True;

  //restart the timer
  Timer.Enabled := False;
  Timer.Enabled := True;
//MessageDlg(S,mtInformation,[mbOK],0);

end;

procedure TForm1.Button6Click(Sender: TObject);
var
  DriveCount, DriveSize:Integer;
  DriveChar, DriveTest, TempStr: String;
begin

  //Check drives C to M

  frmDriveSpace.ListBox1.Clear;
  frmDriveSpace.ListBox1.Items.Add('Drive  Free Space   Warning At');
  frmDriveSpace.ListBox1.Items.Add('-----  ----------   ----------');

  for DriveCount := 3 to 13 do
  begin

    DriveChar := 'Drive'+Chr(64+DriveCount);
    DriveTest := IniFile.ReadString('DiskSpace',DriveChar,'');
    DriveSize := 0;
    DriveChar := Chr(64+DriveCount) + ':';

    if DriveTest <> '' then
    begin
      //Convert to MB
      DriveSize := StrToInt(DriveTest);
    end;

    TempStr := Format('%-6s  %7.2fMB  %7sMB', [DriveChar,
                      DiskFree(DriveCount)/1000000,
                      IntToStr(DriveSize)
                      ]);

    frmDriveSpace.ListBox1.Items.Add(TempStr);
  end;

  frmDriveSpace.ShowModal;

end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  LogError(OA_General,'Test Message');
  Timer.Enabled := False;
  MessageDlg('Test Message Sent to Event Log',
              mtInformation,[mbOK],0);
  Timer.Enabled := True;
end;

procedure TForm1.ChangeIconHint(NewMessage: String);
begin
  StrPCopy(IconData.szTip,NewMessage);
  Shell_NotifyIcon(NIM_MODIFY, @IconData);

end;

procedure TForm1.CurrentStatus1Click(Sender: TObject);
var
  aMessage:String;
begin
  CheckScheduler;
  CheckProcess;

  aMessage := '';

  Case FSchedStatus of
    0: aMessage := 'Scheduler not Running.';
    1: aMessage := 'Scheduler Waiting.';
    2: aMessage := 'Scheduler Running Process.';
    3: aMessage := 'Scheduler had a Warning.';
    4: aMessage := 'Scheduler Failed.';
  end;

  if aMessage <> '' then aMessage := AMessage + #10;

   Case FProcessStatus of
     psDailyStart: aMessage := aMessage + 'Daily has started, checking end time.';
     psMonthlyStart: aMessage := aMessage + 'Monthly has started, checking end time.';
     psNone: aMessage := aMessage + 'Running checks every ('+
                        IniFile.ReadString('TimeInterval','Time','')+
                        ') Minutes';
   end;
  MessageDlg(aMessage,mtInformation,[mbOK],0);

end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  with frmEmail do
  begin
    CheckBox1.Checked :=  UpperCase(IniFile.ReadString('Email','Send email when error occurs',''))='YES';
    Edit1.Text := IniFile.ReadString('Email','Path for Emailer.exe','');
    Edit2.Text := IniFile.ReadString('Email','Parameter File for Emailer.exe','');

    if ShowModal = mrOK then
    begin
      if CheckBox1.Checked then
        IniFile.WriteString('Email','Send email when error occurs','Yes')
      else
        IniFile.WriteString('Email','Send email when error occurs','No');

      IniFile.WriteString('Email','Path for Emailer.exe',Edit1.text);
      IniFile.WriteString('Email','Parameter File for Emailer.exe',Edit2.text);


      RefreshEmail;
    end;
  end;

end;

procedure TForm1.RefreshEmail;
begin
  MemEmail.Clear;
  IniFile.ReadSectionValues('Email', MemEmail.Lines);

end;

end.

