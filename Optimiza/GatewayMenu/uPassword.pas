unit uPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,DBLogDlg;

type
  TfrmPassword = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FCanclose:Boolean;
  public
    { Public declarations }
  end;

var
  frmPassword: TfrmPassword;

implementation

{$R *.dfm}

procedure TfrmPassword.BitBtn1Click(Sender: TObject);
var
  TheMessage,UserName,UserPassword:String;
begin
  UserName := UpperCase(Edit1.Text);
  UserPassword := UpperCase(Edit2.Text);
  TheMessage:= '';

  if UpperCase(UserName) = 'ADMIN' then
  begin

       While True do
       begin

         if not LoginDialogEx('Optimiza',UserName,UserPassword,True) then
         begin
           TheMessage := 'User logon cancelled';
           break;
         end
         else
         begin
           if UpperCase(UserPassword) = 'LEXADMIN' then
           begin
             TheMessage := '';
             break;
           end
           else
             MessageDlg('Invalid Password',mtError,[mbOK],0);

         end;

       end;

  end;

  FCanClose := True;

  if TheMessage <> '' then
  begin
    FCanClose := False;
    MessageDlg(TheMessage,mtError,[mbOK],0);
  end;

end;

procedure TfrmPassword.FormActivate(Sender: TObject);
begin
  FCanClose := True;
end;

procedure TfrmPassword.BitBtn2Click(Sender: TObject);
begin
  FCanClose := True;
end;

procedure TfrmPassword.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose := FCanClose;
end;

end.
