unit uEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ShellAPI;

type
  TfrmEmail = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function RunCommand(Title,CmdLine:String):Boolean;
  end;

var
  frmEmail: TfrmEmail;

implementation

{$R *.dfm}

procedure TfrmEmail.Button1Click(Sender: TObject);
Var
  I : Integer;
  S : String;
begin

  with OpenDialog1 do
  begin
    DefaultExt := '*.exe';
    Title := 'Open Emailer.exe';
    FileName := 'Emailer.exe';
    Filter := ' Applications (*.exe)|*.exe';

    if Edit1.Text <> '' then
      InitialDir := ExtractFilePath(Edit1.Text);

    if Execute then
      Edit1.Text := FileName;

  end;

  if Edit1.Text <> '' then
  begin
    RunCommand('Emailer',Edit1.Text);
  end;


end;

procedure TfrmEmail.Button2Click(Sender: TObject);
begin
  with OpenDialog1 do
  begin
    DefaultExt := '*.ini';
    Title := 'Open Emailer Parameter File';
    Filter := ' INI Files (*.ini)|*.ini';

    if Edit2.Text <> '' then
      InitialDir := ExtractFilePath(Edit2.Text);

    if Execute then
      Edit2.Text := FileName;
  end;

end;

function TfrmEmail.RunCommand(Title, CmdLine: String): Boolean;
var  SInfo: TStartupInfo;
     PInfo: TProcessInformation;
     VInfo: TOSVersionInfo;
     RunStr:String;
begin

  Result := True;
  VInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VInfo);

  SInfo.cb := sizeof(TStartupInFo);
  SInfo.lpReserved := Nil;
  SInfo.lpReserved2 := Nil;
  SInfo.lpDesktop := Nil;
  SInfo.dwFlags := 0;
  SInFo.lpTitle := PChar(Title);
  RunStr := Edit1.text;

 // if Edit2.Text <> '' then
 //   RunStr := RunStr + ' ' + Edit2.text;

    if CreateProcess( Nil,
               PChar(Edit1.text),
               Nil,
               Nil,
               True,
               NORMAL_PRIORITY_CLASS,
               Nil,
               Nil,
               SInfo,
               PInfo) then
    begin

      if WaitForSingleObject(PInfo.hProcess,INFINITE) = WAIT_FAILED then
        Result := False
      else
        Result := True;

    end
    else
    begin
      ShowMessage('Cannot Execute '+CmdLine);
        Result := False;
    end;



end;

end.
