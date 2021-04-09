// Ver 1.0 Initial version

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, shellAPI; //ExtActns;


type
  TString = class(TObject)
  private
    fStr: String;
  public
    constructor Create(const AStr: String) ;
    property Str: String read FStr write FStr;
  end;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    LogFile : TextFile;
    FirstShow:Boolean;
    procedure Say(Line : string;ToScreen:Boolean=True);
    procedure OpenLogFile;
    procedure StartProcess;
    function GetParam(ParamName: String): String;
    function ExecAndWait(const CommandLine: string) : Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses udmData, uParameters, uSelectDayListOpt;

{$R *.dfm}

constructor TString.Create(const AStr: String) ;
begin
   inherited Create;
   FStr := AStr;
end;

procedure TfrmMain.Say(Line : string;ToScreen:Boolean=True);
begin
  if ToScreen then
    Memo1.Lines.Add(Line);
    WriteLn(LogFile, Line);
    Application.ProcessMessages;
end;

procedure TfrmMain.OpenLogFile;
var
  FName:String;
  //Year,Month,Day:Word;
  //FCount:Integer;
begin
  FName := dmdata.GetLogFileName;
  AssignFile(LogFile,FName );
  Rewrite(LogFile);

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
    begin
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
end;

procedure TfrmMain.StartProcess;
var
  CmdLine: string;
//    FileRun: TFileRun;

begin
  Say('Start');
  frmParameters.LoadParam;
  Say('Parameter File: '+frmParameters.edtIniFile.Text);
  if (frmSelectDayList.OKToRun(GetParam('Run On Days'))) then
  begin

    try
      try
        cmdLine := trim(GetParam('Program to run') + ' ' + GetParam('Parameters') + ' ' + GetParam('Program ini file'));
        if execAndWait(cmdLine) then
        begin
          // What ever was run MUST fire the Optimiza event for Success or Failure
          //dmData.FireEvent('S');
        end
        else
        begin
          dmData.FireEvent('F');
        end;
      except
        on e: exception do begin
          Say('*** ' + e.Message);
          dmData.FireEvent('F');
        end;
      end;
    finally
    end;
  end
  else
  begin
    Say('*** Not Run on '+ Days[DayOfWeek(date)]);
    dmData.FireEvent('S');
  end;
end;

function TfrmMain.GetParam(ParamName: String): String;
begin
  Result := frmParameters.vleParameters.Values[ParamName];
end;

function TfrmMain.ExecAndWait(const CommandLine: string) : Boolean;
var
  StartupInfo: Windows.TStartupInfo;        // start-up info passed to process
  ProcessInfo: Windows.TProcessInformation; // info about the process
  ProcessExitCode: Windows.DWord;           // process's exit code
begin
  // Set default error result
  Result := False;
  // Initialise startup info structure to 0, and record length
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  // Execute application commandline
  if Windows.CreateProcess(nil, PChar(CommandLine),
    nil, nil, False, 0, nil, nil,
    StartupInfo, ProcessInfo) then
  begin
    try
      // Now wait for application to complete
      if Windows.WaitForSingleObject(ProcessInfo.hProcess, INFINITE)
        = WAIT_OBJECT_0 then
        // It's completed - get its exit code
        if Windows.GetExitCodeProcess(ProcessInfo.hProcess,
          ProcessExitCode) then
          // Check exit code is zero => successful completion
          if ProcessExitCode = 0 then
            Result := True;
    finally
      // Tidy up
      Windows.CloseHandle(ProcessInfo.hProcess);
      Windows.CloseHandle(ProcessInfo.hThread);
    end;
  end;
end;

end.
