unit uEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ShellAPI, Grids, ValEdit,Clipbrd,StrUtils;

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
    vleIniFile: TValueListEditor;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmail: TfrmEmail;

implementation

uses uFileWait;

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
    //RunCommand('Emailer',Edit1.Text+' -z -w');
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


procedure TfrmEmail.Button3Click(Sender: TObject);
var
  AppStr, IniStr:String;
begin

  AppStr := Edit1.Text;
  IniStr := Edit2.Text;

  if not FileExists(AppStr) then
    MessageDlg('File not Found '+Appstr,mtError,[mbOK],0)
  else
  begin
    if Trim(IniStr) <> '' then
    begin
      //if file not there show message but allow app to load
      if not FileExists(IniStr) then
      begin
        MessageDlg('File not Found '+IniStr,mtError,[mbOK],0);
        AppStr := AppStr + ' -z -w ';
      end
      else
        AppStr := AppStr + ' -z -w "'+IniStr+'"';


    end
    else
    begin
      AppStr := AppStr + ' -z -w ';
    end;
     ExecuteFileWait(AppStr,'');
   end;

  if Copy(Clipboard.AsText,1,8)= 'Optimiza' then
    Edit2.Text := AnsiReplaceStr(Copy(Clipboard.AsText,11,Length(Clipboard.AsText)),'"','');

end;

end.
