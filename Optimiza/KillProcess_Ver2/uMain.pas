unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, TlHelp32, Grids, Buttons, ExtCtrls,AccCtrl,ACLAPI,
  CheckLst;

const
  SE_DEBUG_NAME = 'SeDebugPrivilege';
  SE_SHUTDOWN = 'SeShutdownPrivilege';

  _Max_fb_inet_server=30;

type
  TRUSTEE_A=record
	pMultipleTrustee, //			DWORD	?	; PTR TRUSTEE_A
	MultipleTrusteeOperation, //	DWORD	?	; MULTIPLE_TRUSTEE_OPERATION
	TrusteeForm, //					DWORD	?	; TRUSTEE_FORM
	TrusteeType:cardinal; // //					DWORD	?	; TRUSTEE_TYPE
  case integer of
  1:(ptstrName:pansichar);
  2:(psid:^cardinal);
  end;
  pTRUSTEE_A=^TRUSTEE_A;



  EXPLICIT_ACCESS_A=record
  grfAccessPermissions,
  grfAccessMode,
  grfInheritance:Cardinal;
  Trustee:TRUSTEE_A;
  end;
  pEXPLICIT_ACCESS_A=^EXPLICIT_ACCESS_A;

function BuildExplicitAccessWithNameA (var ea:EXPLICIT_ACCESS_A;sTrustee:pansichar;accessPermission,
accessMode,inheritance:cardinal):longbool;stdcall;external 'advapi32.dll';
function SetEntriesInAclA(cCountOfExplicitEntries:cardinal;pListOfExplicitEntries:pointer;OldAcl:pacl;var NewAcl:pacl):longbool;stdcall;external 'advapi32.dll';

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Label6: TLabel;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label7: TLabel;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    chkTasks: TCheckListBox;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    ListBox1: TListBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Hidden: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure HiddenClick(Sender: TObject);
  private
    { Private declarations }
    FScreenPrompt:Boolean;
    FirstShow:Boolean;
    function NTSetPrivilege(ProcID:Integer; sPrivilege: string; bEnabled: Boolean): Boolean;
    function OpenProcessWithEnoughRights(ProcId:Integer):Integer; //:THandle;
    procedure KillOptimizaProcess(AProcess:String);
    function GetOptimizaProcessID(AProcess:String):Integer;
    procedure SayMessage(MsgStr:String);
    procedure SayError(ErrStr:String);
    function GoToOptimizaProcess(AProcess:String):Integer;
    procedure PerformTask(CommandStr:String);
    procedure FirebirdAction(CommandStr:String);
    procedure KillAll_ib_net;
    function FindTheFirstProcess(AProcess:String):Integer;


  public
    { Public declarations }
    procedure ListTheProcesses;
  end;

var
  Form1: TForm1;

implementation

uses uFileWait;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var //hSnapshot:THandle;
  //pe32:TProcessEntry32;
  PModName:String;
begin

  ListTheProcesses;


end;

procedure TForm1.FormCreate(Sender: TObject);
var
  CCount:Integer;
begin

  FScreenPrompt := True;
  FirstShow := True;

  for CCount := 0 to chkTasks.Count-1 do
    chkTasks.Checked[cCount] := True;
    
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var hProcess:THandle;
  ProcId:Integer;
begin

  if MessageDlg('Kill '+Edit1.Text+'('+Edit2.Text+')',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    ProcId := StrToInt(Edit2.Text);

    if NTSetPrivilege(ProcId,SE_DEBUG_NAME,True) then
    begin

      hProcess := OpenProcess(PROCESS_TERMINATE, False, ProcId);

      if not GetLastError = ERROR_SUCCESS then
        raise Exception.Create(SysErrorMessage(GetLastError));

      TerminateProcess(hProcess, 0);

      CloseHandle(hPRocess);

      ListTheProcesses;
      //Button1Click(nil);
      //StringGrid1.Row := 1;
    end;

  end;

end;

procedure TForm1.BitBtn3Click(Sender: TObject);

var hProcess:THandle;
  ProcId,sCount:Integer;
begin

  if MessageDlg('Kill all instances of '+Edit3.Text,mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin

    {for SCount := 1 to StringGrid1.RowCount-1 do
    begin

      if UpperCase(StringGrid1.Cells[0,SCount]) = UpperCase(Edit3.Text) then
      begin
        ProcId := StrToInt(StringGrid1.Cells[1,SCount]);
        hProcess := OpenProcess(PROCESS_ALL_ACCESS, TRUE, ProcId);

        if hProcess <> null then
          TerminateProcess(hProcess, 0);

        CloseHandle(hPRocess);

      end;

    end;
     }
    ListTheProcesses;
    //Button1Click(nil);

  end;

end;

function TForm1.NTSetPrivilege(ProcID:Integer;sPrivilege: string; bEnabled: Boolean): Boolean;
var
  hProcess1: THandle;
begin

  // Only for Windows NT/2000/XP and later.
  if not (Win32Platform = VER_PLATFORM_WIN32_NT) then
  begin
    Result := False;
    Exit;
  end;

  //hProcess := OpenProcessWithEnoughRights(ProcId);
  OpenProcessWithEnoughRights(ProcId);

  //CloseHandle(hProcess);

  Result := GetLastError = ERROR_SUCCESS;

  if not Result then
    SayError(SysErrorMessage(GetLastError));

end;


function TForm1.OpenProcessWithEnoughRights(ProcId:Integer):Integer; //:THandle;
var hProcess:THandle;
  pDacl: PACL;
  pNewDacl: PACL;
  dwRes: DWORD;
  ea: EXPLICIT_ACCESS_A;

begin
  Result := -1;

  hProcess := OpenProcess(WRITE_DAC, False, ProcId);

  if not GetLastError = ERROR_SUCCESS then
  begin
    if FScreenPrompt then
      raise Exception.Create(SysErrorMessage(GetLastError))
    else
      SayError(SysErrorMessage(GetLastError));

  end;

  pDacl := nil;
  pNewDacl := nil;

  BuildExplicitAccessWithNameA(ea,pansichar('Guest'),
               PROCESS_ALL_ACCESS,
                cardinal(SET_ACCESS),0);



  if not GetLastError = ERROR_SUCCESS then
    SayError('BuildExplicitAccessWithNameA:'+SysErrorMessage(GetLastError));


  ea.grfAccessPermissions := PROCESS_ALL_ACCESS;
  ea.grfAccessMode := cardinal(SET_ACCESS);
  ea.grfInheritance := NO_INHERITANCE;
  ea.Trustee.pMultipleTrustee := 0;
  ea.Trustee.MultipleTrusteeOperation := cardinal(NO_MULTIPLE_TRUSTEE);
  ea.Trustee.TrusteeForm := cardinal(TRUSTEE_IS_SID);
  ea.Trustee.TrusteeType := cardinal(TRUSTEE_IS_USER);
  ea.Trustee.ptstrName := pansichar('Guest');

  if SetEntriesInAclA(1,addr(ea), pDacl,pNewDacl) then
      Result := 0;
      //Result := hProcess;

  if not GetLastError = ERROR_SUCCESS then
    SayError('SetEntriesInAclA'+SysErrorMessage(GetLastError));

  dwRes := SetSecurityInfo (hProcess, SE_KERNEL_OBJECT, DACL_SECURITY_INFORMATION, nil, nil, pNewDacl, nil);
    localfree(cardinal(pNewDacl));
    localfree(cardinal(pDacl));


  if not GetLastError = ERROR_SUCCESS then
    SayError('SetSecurityInfo:'+SysErrorMessage(GetLastError));

  if ERROR_SUCCESS = dwRes then
      Result := 0;
      //Result := hProcess;

  CloseHandle(hProcess);

  
  if not GetLastError = ERROR_SUCCESS then
    SayError('Close Handle:'+SysErrorMessage(GetLastError));




end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  TaskNo:Integer;
  TaskName,CommandStr:String;
begin
  Memo1.Clear;
  Memo2.Clear;
  ListTheProcesses;
  //Button1Click(Sender);   // get list of processes

  for TaskNo:= 0 to chkTasks.Count -1 do
  begin
    CommandStr :=Copy(chkTasks.Items.Strings[TaskNo],
                 Pos('=',chkTasks.Items.Strings[TaskNo])+1,
                 Length(chkTasks.Items.Strings[TaskNo]));
    TaskName := UpperCase(CommandStr);

    if Pos('FB_INET_SERVER.EXE',TaskName) > 0 then
    begin
      KillAll_ib_net;
    end
    else
    begin
      if (Pos('NET STOP "FIREBIRD',TaskName) > 0) or
        (Pos('NET START "FIREBIRD',TaskName) > 0) then
      begin
        FireBirdAction(CommandStr);
      end
      else
      begin
        KillOptimizaProcess(CommandStr);
      end;

    end;

  end;

  SayMessage('------------------------');
  SayMessage(' Done with task list ');
  SayMessage('------------------------');

  Memo1.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'KillProcess.log');
  ListTheProcesses;

end;

procedure TForm1.KillOptimizaProcess(AProcess:String);
var hProcess:THandle;
  ProcId:Integer;
begin

  SayMessage('Killing '+AProcess);
  //Sleep(1000);




  GoToOptimizaProcess(AProcess);
  //ProcId := GetOptimizaProcessID(AProcess);

  if Edit2.text <> '' then
  begin
    ProcId := StrToInt(Edit2.Text);
    SayMessage('ProcID: '+Edit2.Text);
    Edit2.Text := IntToStr(ProcID);
    Edit1.Text :=AProcess;
    HiddenClick(Nil);

    {if (ProcID > 0) and (NTSetPrivilege(ProcId,SE_DEBUG_NAME,True)) then
    begin

      hProcess := OpenProcess(PROCESS_TERMINATE, False, ProcId);

      if not GetLastError = ERROR_SUCCESS then
      begin
        SayError('Error for '+AProcess+' ,Process ID:'+IntToStr(ProcId));
        SayError(SysErrorMessage(GetLastError));
      end;

      TerminateProcess(hProcess, 0);

      CloseHandle(hPRocess);


    end;

    ListBox1.Clear;
    Sleep(4000);
     }

  end;

  //Sleep(4000);

end;

function TForm1.GetOptimizaProcessID(AProcess: String): Integer;
var
  SCount:Integer;
begin
  Result := -1;

  //SCount := StringGrid1.Cols[0].IndexOf(AProcess);
  SCount := FindTheFirstProcess(AProcess);

  if SCount >= 0 then
  begin

    try
      //Result := StrToInt(StringGrid1.Cells[1,SCount]);
      Result := StrToInt(Trim(Copy(ListBox1.Items.Strings[SCount],1,10)));
    except
      Result := -1;
    end;

  end;

  if Result = -1 then
    SayMessage('Warning - '+AProcess+' Not Found');


end;

procedure TForm1.SayError(ErrStr: String);
begin
  Memo2.Lines.Add(ErrStr);
  Application.ProcessMessages;

end;

procedure TForm1.SayMessage(MsgStr: String);
begin
  Memo1.Lines.Add(MsgStr);
  Application.ProcessMessages;

end;

function TForm1.GoToOptimizaProcess(AProcess: String):Integer;
var
  SCount:Integer;
begin

  Result := -1;

  //SCount := StringGrid1.Cols[0].IndexOf(AProcess);
  SCount := FindTheFirstProcess(AProcess);

  if SCount >= 0 then
  begin
    Edit1.Text := AProcess;
    Edit2.Text := Trim(Copy(ListBox1.Items.Strings[SCount],1,10));
    //Edit2.Text := StringGrid1.Cells[1,SCount];
    //StringGrid1.Row := SCount;
    Result := StrToInt(Edit2.Text);
  end
  else
  begin
    Result := -1;
    SayMessage('Warning - '+AProcess+' Not Found');
    Edit1.Text := '';
    Edit2.Text := '';
  end;

end;

procedure TForm1.PerformTask(CommandStr:String);
begin
  Memo1.Clear;
  Memo2.Clear;
  ListTheProcesses;
  //Button1Click(Nil);   // refresh list of processes

  KillOptimizaProcess(CommandStr);

end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  PerformTask('Scheduler.exe');
  SayMessage('### Done with Scheduler');
  ListTheProcesses;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  PerformTask('Optimiza.exe');
  SayMessage('### Done with Optimiza');
  ListTheProcesses;
end;

procedure TForm1.FirebirdAction(CommandStr:String);
var
  CurrentDirectory:String;
begin

  CurrentDirectory := ExtractFilePath(ParamStr(0));


  SayMessage('Current Directory ' + CurrentDirectory);
  SayMessage('Executing ' + CommandStr);
  Sleep(3000);

  ExecuteFileWait(CommandStr,CurrentDirectory)  ;
  Sleep(3000);

//  ListTheProcesses;
//  Button1Click(nil);  //Refresh process list
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
var
  CommandStr,TaskName:String;
  TaskNo:Integer;
begin

  CommandStr := '';

  //Find in task list first to get command line
  // Some sites may not be running FB guardian

  for TaskNo := 0 to chkTasks.Count-1 do
  begin
    TaskName := UpperCase(chkTasks.Items.Strings[TaskNo]);
    if Pos('STOP',TaskName)> 0 then
    begin
      if Pos('FIREBIRD',TaskName)> 0 then
      begin
        CommandStr :=Copy(chkTasks.Items.Strings[TaskNo],
                 Pos('=',chkTasks.Items.Strings[TaskNo])+1,
                 Length(chkTasks.Items.Strings[TaskNo]));

      end;

    end;

  end;

  if CommandStr <> '' then
  begin
    FirebirdAction(CommandStr);
    SayMessage('### Done with Firebird Stop');
  end
  else
    SayMessage('### Cant FIND this task in  Killtasklist.txt');

  ListTheProcesses;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
var
  CommandStr,TaskName:String;
  TaskNo:Integer;
begin

  CommandStr := '';


  //Find in task list first to get command line
  // Some sites may not be running FB guardian
  for TaskNo := 0 to chkTasks.Count-1 do
  begin
    TaskName := UpperCase(chkTasks.Items.Strings[TaskNo]);
    if Pos('START',TaskName)> 0 then
    begin
      if Pos('FIREBIRD',TaskName)> 0 then
      begin
        CommandStr :=Copy(chkTasks.Items.Strings[TaskNo],
                 Pos('=',chkTasks.Items.Strings[TaskNo])+1,
                 Length(chkTasks.Items.Strings[TaskNo]));

      end;

    end;

  end;

  if CommandStr <> '' then
  begin
    FirebirdAction(CommandStr);
    SayMessage('### Done with Firebird Start');
  end
  else
    SayMessage('### Cant FIND this task in  Killtasklist.txt');

  ListTheProcesses;
  ListBox1.ItemIndex := ListBox1.Count-2;


end;

procedure TForm1.KillAll_ib_net;
var
  ProcIdArr:Array[0.._Max_fb_inet_server] of Integer;
  ACount,lCount,ProcID:Integer;
  TestStr:String;
  hProcess:THandle;
begin

  for ACount := 0 to _Max_fb_inet_server do
    ProcIdArr[ACount] := -1;

  ListTheProcesses;
  Application.ProcessMessages;
  ACount := -1;

  for lCount := 0 to listBox1.Count-1 do
  begin
    TestStr := Trim(Copy(ListBox1.Items.Strings[lCount],12,60));

    if TestStr = 'fb_inet_server.exe' then
    begin
      inc(ACount);
      ProcIDArr[ACount] := StrToInt(Trim(Copy(ListBox1.Items.Strings[lCount],1,10)));
    end;

  end;

  SayMessage('Starting ib_inet cleanup ');
  //Sleep(5000);

  for ACount := _Max_fb_inet_server downto 0 do
  begin

    if ProcIdArr[ACount] > 0 then
    begin
      SayMessage('ProcID: '+IntToStr(ProcIdArr[ACount]));
      ProcId := ProcIdArr[ACount];
      Edit2.Text := IntToStr(ProcID);
      Edit1.Text :='fb_inet_server.exe';
      HiddenClick(Nil);

      {if NTSetPrivilege(ProcId,SE_DEBUG_NAME,True) then
      begin

        hProcess := OpenProcess(PROCESS_TERMINATE, False, ProcId);

        if not GetLastError = ERROR_SUCCESS then
          raise Exception.Create(SysErrorMessage(GetLastError));

        TerminateProcess(hProcess, 0);

        CloseHandle(hPRocess);

      end;

      Sleep(4000);}

    end;



  end;


end;
{procedure TForm1.KillAll_ib_net;
var
  MaxInstances:Integer;
begin
  MaxInstances := 0;

  While (MaxInstances < _Max_fb_inet_server) do
  begin

    Inc(MaxInstances);
    Button1Click(nil);

    if (GoToOptimizaProcess('fb_inet_server.exe') > 0) then
    begin

      KillOptimizaProcess('fb_inet_server.exe');
      SayMessage('Attempt '+IntToStr(MaxInstances));

    end
    else
      MaxInstances := _Max_fb_inet_server;



  end;


end;}

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
  ListTheProcesses;
  KillAll_ib_net;
  SayMessage('### Done with Killing ib_net_server');
  ListTheProcesses;
end;

procedure TForm1.FormActivate(Sender: TObject);
var
  LogFileName,TaskFile:String;
begin

  if FirstShow then
  begin
    FirstShow := False;
    chkTasks.Items.Clear;
    LogFileName := ExtractFilePath(ParamStr(0))+'KillTaskList.txt';
    chkTasks.Items.LoadFromFile(LogFileName);

  end;

  if Uppercase(ParamStr(1)) = 'KILLTASKLIST' then
  begin
      Memo2.Clear;
      FScreenPrompt := False;
      Show;
      Application.ProcessMessages;

      BitBtn2Click(Nil); // Execute task list kill

      LogFileName := ExtractFilePath(ParamStr(0))+'KillTaskList.err';

      if FileExists(LogFileName) then
        DeleteFile(LogFileName);

      if Memo2.Lines.Count > 0 then
      begin
        Memo2.Lines.SaveToFile(LogFileName);
      end;
       
      Close;
  end;


end;

procedure TForm1.ListBox1Click(Sender: TObject);
var
  CurrentItem:String;
begin

  CurrentItem := ListBox1.Items.Strings[ListBox1.ItemIndex];

  Edit2.Text := Trim(Copy(CurrentItem,1,10));
  Edit1.Text := Trim(Copy(CurrentItem,12,60));

end;

function TForm1.FindTheFirstProcess(AProcess: String): Integer;
var
  IndexNo:Integer;
  TestStr:String;
begin
  Result := -1;

  for IndexNo := 0 to ListBox1.Count-1 do
  begin

    TestStr := Trim(Copy(ListBox1.Items.Strings[IndexNo],12,60));
    if UpperCase(TestStr) = UpperCase(AProcess) then
    begin
      Result := IndexNo;
      ListBox1.ItemIndex := IndexNo;
      ListBox1.TopIndex := IndexNo;
      Break;
    end;

  end;

end;

procedure TForm1.ListTheProcesses;
var hSnapshot:THandle;
  pe32:TProcessEntry32;
  ModName:String;
  rCount:Integer;
begin
  hSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);

  if hSnapShot = -1 then
    SayMessage('Could not load snapshot of all processes');

  pe32.dwSize := SizeOf(pe32);

  if not Process32First(hSnapshot, pe32) then
    SayMessage('Could not load FIRST snapshot of all processes');

  //StringGrid1.RowCount := 5;
  //StringGrid1.Row := 1;
  ListBox1.Clear;

  RCount := 0;

  while Process32Next(hSnapshot, pe32) do
  begin

    ModName := pe32.szExeFile;

    ListBox1.Items.Add(Format('%-10s %-60s',[IntToStr(pe32.th32ProcessID),ModName]));
  end;

  CloseHandle(hSnapShot);

  ListBox1.Refresh;
  Application.ProcessMessages;

end;


procedure TForm1.HiddenClick(Sender: TObject);
var hProcess:THandle;
  ProcId:Integer;
begin

    ProcId := StrToInt(Edit2.Text);

    if NTSetPrivilege(ProcId,SE_DEBUG_NAME,True) then
    begin

      hProcess := OpenProcess(PROCESS_TERMINATE, False, ProcId);

      if not GetLastError = ERROR_SUCCESS then
        SayError(SysErrorMessage(GetLastError));
       

      TerminateProcess(hProcess, 0);

      CloseHandle(hPRocess);

      ListTheProcesses;
    end;


end;

end.
