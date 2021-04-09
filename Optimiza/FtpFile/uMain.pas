unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmMain = class(TForm)
    edtFtpSite: TEdit;
    edtUser: TEdit;
    edtPassword: TEdit;
    edtPath: TEdit;
    edtFile: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin

  if Opendialog1.Execute then
    edtFile.Text := OpenDialog1.FileName;



end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  FtpFile:TextFile;
  FName:String;
begin

   Fname := Trim(ParamStr(0));
   FName := Copy(FName,1,Length(FName)-3) + 'txt';

   AssignFile(FtpFile,FName);
   Rewrite(FtpFile);

   WriteLn(edtUser.text);
   WriteLn(edtPassword.text);
   WriteLn('cd '+Trim(edtPath.text));
   CloseFile(FtpFile);


   
   DeleteFile(FName);




end;

end.
