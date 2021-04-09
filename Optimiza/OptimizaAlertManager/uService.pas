unit uService;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,IniFiles,ValEdit,StrUtils,
  ExtCtrls,DateUtils, afpEventLog;

  const
  OA_General    = 1000;
  OA_NotStarted   = 1001;
  OA_NotFinished  = 1002;
  OA_Stopped      = 1003;
  OA_Failed       = 1004;
  OA_AlertStart   = 1005;
  OA_AlertStop    = 1006;

type
  TProcessStatus = (psDailyStart,psDailyEnd, psMonthlyStart, psMonthlyEnd, psNone);

  TOptimizaServiceAlert = class(TService)
    EventLog: TafpEventLog;
    Timer: TTimer;
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure TimerTimer(Sender: TObject);
    function SetTimeInterval():integer;
    procedure RefreshPath;
  private
    FFirstShow: Boolean;
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  OptimizaServiceAlert: TOptimizaServiceAlert;
  FSchedStatus:Integer;
  FFirebirdShutDown: Boolean;
  FEventLog,FSendEmail:Boolean;
  IniFile: TIniFile;
  vleIniFile1: TIniFile;
  //Timer1: TTimer;
  FProcessStatus:TProcessStatus;
  edtPathText : string;
  FStartDate: TDateTime;
  //EventLog: TafpEventLog;

implementation

uses uDmdata, uFileWait, AlertCommon;

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  OptimizaServiceAlert.Controller(CtrlCode);
end;

function TOptimizaServiceAlert.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TOptimizaServiceAlert.ServiceCreate(Sender: TObject);
begin
  //MessageDlg('Create',mtInformation,[mbOK],0);
end;

procedure TOptimizaServiceAlert.ServiceExecute(Sender: TService);
var
  Count: Integer;
  IniFileName,vleIniFileName: String;
begin
  IniFileName := ParamStr(0);
  IniFileName := Copy(IniFileName,1,Length(IniFileName)-3) + 'ini';
  IniFile := TIniFile.Create(IniFileName);

  FProcessStatus := psNone;
  FFirebirdShutDown := False;

  Count := 0;
  while not Terminated do
  begin
    //LogMessage('Your message goes here SUCC', EVENTLOG_SUCCESS, 0, 1);
    //LogInformation(OA_General,'Optimiza Alert Manager has looped');
    Inc(Count);
    if Count >= SetTimeInterval then
    begin
      FEventLog := IniFile.ReadString('EventLog','Write','') = 'Yes';
      FSendEmail := IniFile.ReadString('Email','Send email when error occurs','') = 'Yes';
      Count := 0;

      if FFirstShow then
      begin
        dmData.dbOptimiza.Connected := False;
        FFirstShow := False;
      end;

      RefreshPath;

      CheckScheduler;
      CheckProcess;
      CheckDrives;
    end;
    Sleep(1000);
    ServiceThread.ProcessRequests(False);
  end;
end;

procedure TOptimizaServiceAlert.RefreshPath;
begin
  edtPathText := IniFile.ReadString('Paths','LogFiles','');
end;

procedure TOptimizaServiceAlert.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  //MessageDlg('Started',mtInformation,[mbOK],0);
  LogInformation(OA_General,'Optimiza Alert Manager has started');
end;

procedure TOptimizaServiceAlert.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  //MessageDlg('Stop',mtInformation,[mbOK],0);
  LogInformation(OA_General,'Optimiza Alert Manager has stopped');
end;

procedure TOptimizaServiceAlert.TimerTimer(Sender: TObject);
begin
  {if FFirstShow then
  begin
    dmData.dbOptimiza.Connected := False;
    FFirstShow := False;
    SetTimeInterval;
  end;

  CheckScheduler;
  CheckProcess;
  CheckDrives; }
  Timer.Enabled := False;
end;

function TOptimizaServiceAlert.SetTimeInterval():integer;
var
 TempInt, TempNum: Cardinal;
 TempStr: String;
begin
  TempStr := IniFile.ReadString('TimeInterval','Time','');
  //ChangeIconHint('Optimiza Alert Checking Every ('+TempStr+') minutes');
  TempNum := 160;
  TempInt := 1;
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
   result := (TempInt * 60);
end;

end.
