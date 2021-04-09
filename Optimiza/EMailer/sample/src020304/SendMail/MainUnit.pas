unit MainUnit;

interface

uses
  inifiles, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient,
  IdSMTP, ComCtrls, StdCtrls, Buttons, ExtCtrls, IdBaseComponent, IdMessage;

type
  TMailerForm = class(TForm)
    MailMessage: TIdMessage;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    ledHost: TLabeledEdit;
    Body: TMemo;
    ledAttachment: TLabeledEdit;
    btnAttachment: TBitBtn;
    SMTP: TIdSMTP;
    ledFrom: TLabeledEdit;
    ledTo: TLabeledEdit;
    ledCC: TLabeledEdit;
    ledSubject: TLabeledEdit;
    btnSendMail: TBitBtn;
    StatusMemo: TMemo;
    AttachmentDialog: TOpenDialog;
    procedure btnSendMailClick(Sender: TObject);
    procedure SMTPStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure btnAttachmentClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure GetSettings;
    procedure SaveSettings;
  public
    { Public declarations }
  end;

var
  MailerForm: TMailerForm;

implementation

{$R *.dfm}

procedure TMailerForm.btnSendMailClick(Sender: TObject);
begin
  StatusMemo.Clear;

  //setup SMTP
  SMTP.Host := ledHost.Text;
  SMTP.Port := 25;

  //setup mail message
  MailMessage.From.Address := ledFrom.Text;
  MailMessage.Recipients.EMailAddresses := ledTo.Text + ',' + ledCC.Text;

  MailMessage.Subject := ledSubject.Text;
  MailMessage.Body.Text := Body.Text;

  if FileExists(ledAttachment.Text) then
    TIdAttachment.Create(MailMessage.MessageParts, ledAttachment.Text);

  //send mail
  try
    try
      SMTP.Connect();
      SMTP.Send(MailMessage);
    except on E:Exception do
      StatusMemo.Lines.Insert(0, 'ERROR: ' + E.Message);
    end;
  finally
    if SMTP.Connected then SMTP.Disconnect;
  end;

end; (* btnSendMail Click *)

procedure TMailerForm.SMTPStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: String);
begin
  StatusMemo.Lines.Insert(0,'Status: ' + AStatusText);
end; (* SMTP Status *)

procedure TMailerForm.btnAttachmentClick(Sender: TObject);
begin
  if AttachmentDialog.Execute then
    ledAttachment.Text := AttachmentDialog.FileName;
end;

procedure TMailerForm.FormCreate(Sender: TObject);
begin
  GetSettings;
end;

procedure TMailerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveSettings;
end;

procedure TMailerForm.GetSettings;
var
  ini : TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    ledHost.Text := ini.ReadString('SMTP','Host','');

    ledFrom.Text := ini.ReadString('MAIL','From','');
    ledTo.Text := ini.ReadString('MAIL','To','');
    ledCC.Text := ini.ReadString('MAIL','CC','');
  finally
    ini.Free;
  end;
end; (* GetSettings *)

procedure TMailerForm.SaveSettings;
var
  ini : TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    ini.WriteString('SMTP','Host',ledHost.Text);

    ini.WriteString('MAIL','From',ledFrom.Text);
    ini.WriteString('MAIL','To',ledTo.Text);
    ini.WriteString('MAIL','CC',ledCC.Text);
  finally
    ini.Free;
  end;
end; (* SaveSettings *)

end.
