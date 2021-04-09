unit uSystray;

interface

uses
  Windows, Messages,SysUtils,Classes,Graphics, Controls, Forms, Dialogs,
  Menus, ShellAPI, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGrids,StrUtils,IniFiles,
  DateUtils, OnlyOpenOnce, afpEventLog,MainInstance, ValEdit;

  //

// Ver 3.2 - Messages to screen close after a few seconds so we do not wait for a prompt.
// Ver 3.5 - Updated so this is a frontend for the ini file create and should not be run.
type
  TProcessStatus = (psDailyStart,psDailyEnd, psMonthlyStart, psMonthlyEnd, psNone);

type

  TfrmSystray = class(TForm)
    PopupMenu: TPopupMenu;
    pmnuiOpen: TMenuItem;
    pmnuiExit: TMenuItem;
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
    Button4: TButton;
    //MainInstance1: TMainInstance;
    Button6: TButton;
    Button7: TButton;
    GroupBox5: TGroupBox;
    Button8: TButton;
    memEmail: TMemo;
    Label7: TLabel;
    edtEventLog: TEdit;
    EventLog: TafpEventLog;
    Timer: TTimer;
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
    procedure Button8Click(Sender: TObject);
    procedure edtPathChange(Sender: TObject);
  private
    { Private declarations }
    FFirstShow: Boolean;
    procedure RefreshDrive;
    procedure RefreshSched;
    procedure RefreshInterval;
    procedure RefreshEmail;
    procedure UpdateSchedule(SchedType: String);
    procedure SetTimeInterval;
    procedure RefreshPath;
    procedure IBShutDown(var Msg: tMessage); message wmMainInstanceMessage;
    procedure GetBuildInfo(var V1, V2, V3, V4: Word);
    function kfVersionInfo: String;
    procedure ChangeIconHint(NewMessage:String);
    procedure ShowTheMessage(aMsg:String);

  protected
    procedure WndProc(var Msg: TMessage); override;
  public
    { Public declarations }
    IconData: TNotifyIconData;
 end;

var
  frmSystray: TfrmSystray;
  FSchedStatus:Integer;
  FFirebirdShutDown: Boolean;
  FEventLog,FSendEmail:Boolean;
  IniFile: TIniFile;
  vleIniFile1: TIniFile;
  //vleIniFile: TValueListEditor;
  //Timer1: TTimer;
  FProcessStatus:TProcessStatus;
  edtPathText : string;
  FStartDate: TDateTime;
  //EventLog: TafpEventLog;

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
  uDriveSpace, uEmail, uFileWait, uShowMessage, AlertCommon;

{$R *.DFM}
{$R MyRes.RES}
{$R Optimiza.res}

procedure TfrmSystray.WndProc(var Msg: TMessage);
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

procedure TfrmSystray.FormCreate(Sender: TObject);
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
  Caption := 'Optimiza Alert - Configuration '+'(Ver '+kfVersionInfo+')';
  LogInformation(OA_General,'Optimiza Alert Manager has started');
  Timer.Enabled := true;

end;

procedure TfrmSystray.pmnuiOpenClick(Sender: TObject);
begin
  dmData.dbOptimiza.Connected := True;
  
  frmSystray.Show;
  ShowWindow(Application.Handle, SW_HIDE);


end;

procedure TfrmSystray.pmnuiExitClick(Sender: TObject);
begin
  Application.ProcessMessages;
  Application.Terminate;
end;

procedure TfrmSystray.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  frmSystray.Hide;
end;

procedure TfrmSystray.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @IconData);
  LogInformation(OA_General,'Optimiza Alert Manager has stopped');

end;

procedure TfrmSystray.TimerTimer(Sender: TObject);
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

procedure TfrmSystray.Button2Click(Sender: TObject);
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

procedure TfrmSystray.Button3Click(Sender: TObject);
begin

  with frmInterval do
  begin
    edtInterval.Text := IniFile.ReadString('TimeInterval','Time','');
    chkEventLog.Checked := IniFile.ReadString('EventLog','Write','')='Yes';

    if ShowModal = mrOK then
    begin
      IniFile.WriteString('TimeInterval','Time',Trim(edtInterval.text));

      if ChkEventLog.Checked then
        IniFile.WriteString('EventLog','Write','Yes')
      else
        IniFile.WriteString('EventLog','Write','No');

    end;

  end;

  RefreshInterval;


end;

procedure TfrmSystray.BitBtn1Click(Sender: TObject);
begin
  IniFile.UpdateFile;
  SetTimeInterval;
  FProcessStatus := psNone;
  Hide;
end;

procedure TfrmSystray.RefreshDrive;
begin
  MemDrive.Clear;
  IniFile.ReadSectionValues('DiskSpace', MemDrive.Lines);

end;

procedure TfrmSystray.RefreshInterval;
begin
 edtInterval.Text := IniFile.ReadString('TimeInterval','Time','');
 edtEventLog.Text := IniFile.ReadString('EventLog','Write','');
 FEventLog := edtEventLog.Text = 'Yes';
end;

procedure TfrmSystray.RefreshSched;
begin
  memDaily.clear;
  IniFile.ReadSectionValues('Daily', MemDaily.Lines);
  memMonthly.clear;
  IniFile.ReadSectionValues('Monthly', MemMonthly.Lines);

end;

procedure TfrmSystray.FormHide(Sender: TObject);
begin
  dmData.srcSchedule.DataSet.Close;
   dmData.dbOptimiza.Connected := False;
end;

procedure TfrmSystray.FormShow(Sender: TObject);
begin
  dmData.srcSchedule.DataSet.Open;
  RefreshDrive;
  RefreshSched;
  RefreshInterval;
  RefreshPath;
  RefreshEmail;
end;

procedure TfrmSystray.Button1Click(Sender: TObject);
begin
  UpdateSchedule('Daily');
end;

procedure TfrmSystray.DBGrid1CellClick(Column: TColumn);
begin
  RefreshSched;

end;

procedure TfrmSystray.DBGrid1DblClick(Sender: TObject);
begin
  RefreshSched;

end;

procedure TfrmSystray.DBGrid1Exit(Sender: TObject);
begin
  RefreshSched;

end;

procedure TfrmSystray.UpdateSchedule(SchedType: String);

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

procedure TfrmSystray.SetTimeInterval;
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


procedure TfrmSystray.Button5Click(Sender: TObject);
begin

  if frmSelectFolder.showmodal = mrOK then
  begin
    edtPath.Text := frmSelectFolder.ShellTreeView1.SelectedFolder.PathName;
    edtPathText := frmSelectFolder.ShellTreeView1.SelectedFolder.PathName;
    IniFile.WriteString('Paths','LogFiles',edtPath.Text);
  end;

end;

procedure TfrmSystray.RefreshPath;
begin
  edtPath.Text := IniFile.ReadString('Paths','LogFiles','');
  edtPathText := IniFile.ReadString('Paths','LogFiles','');
end;
//-------------------------------------------------------------

procedure TfrmSystray.Button4Click(Sender: TObject);
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

procedure TfrmSystray.IBShutDown(var Msg: tMessage);
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

procedure TfrmSystray.Button6Click(Sender: TObject);
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

procedure TfrmSystray.Button7Click(Sender: TObject);
begin
  LogError(OA_General,'Test Message');
  Timer.Enabled := False;
  LogEmailMessage('Test Message');

  MessageDlg('Test Message Sent to Event Log',
              mtInformation,[mbOK],0);
  Timer.Enabled := True;
end;

procedure TfrmSystray.RefreshEmail;
begin
  MemEmail.Clear;
  IniFile.ReadSectionValues('Email', MemEmail.Lines);
  FSendEmail := IniFile.ReadString('Email','Send email when error occurs','') = 'Yes';
end;

procedure TfrmSystray.ChangeIconHint(NewMessage: String);
begin
  StrPCopy(IconData.szTip,NewMessage);
  Shell_NotifyIcon(NIM_MODIFY, @IconData);

end;

procedure TfrmSystray.Button8Click(Sender: TObject);
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

procedure TfrmSystray.GetBuildInfo(var V1, V2, V3, V4: Word);
var
   VerInfoSize, VerValueSize, Dummy : DWORD;
   VerInfo : Pointer;
   VerValue : PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

  With VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;

  FreeMem(VerInfo, VerInfoSize);

end;

function TfrmSystray.kfVersionInfo: String;
var
  V1,       // Major Version
  V2,       // Minor Version
  V3,       // Release
  V4: Word; // Build Number
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.'
            + IntToStr(V2); // + '.';
            //+ IntToStr(V3) + '.'
            //+ IntToStr(V4);
end;


procedure TfrmSystray.ShowTheMessage(aMsg: String);
begin
  frmShowMessage.Panel1.Caption := aMsg;
  frmShowMessage.Show;
end;

procedure TfrmSystray.edtPathChange(Sender: TObject);
begin
  edtPathText := edtPath.text;
end;

end.

