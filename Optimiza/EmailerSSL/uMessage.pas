unit uMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,StrUtils;

type
  TfrmMessage = class(TForm)
    Panel1: TPanel;
    Label4: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label5: TLabel;
    edtTo: TEdit;
    edtCC: TEdit;
    edtBcc: TEdit;
    edtAttach: TEdit;
    edtSubject: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtMessage: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    BitBtn3: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
        procedure GetRecipients;

  public
    { Public declarations }
  end;

var
  frmMessage: TfrmMessage;

implementation

uses uRecipient;

{$R *.dfm}

procedure TfrmMessage.Button1Click(Sender: TObject);
begin
  GetRecipients;
end;

procedure TfrmMessage.Button2Click(Sender: TObject);
begin
  GetRecipients;

end;

procedure TfrmMessage.Button3Click(Sender: TObject);
begin
  GetRecipients;
end;

procedure TfrmMessage.GetRecipients;
begin
    with frmRecipient do
    begin
      ListBox1.Items.CommaText := AnsiReplaceStr(frmMessage.edtTo.Text,';',',');
      ListBox2.Items.CommaText := AnsiReplaceStr(frmMessage.edtCC.Text,';',',');
      ListBox3.Items.CommaText := AnsiReplaceStr(frmMessage.edtBCC.Text,';',',');

      if ShowModal = mrOK then
      begin
        frmMessage.edtTo.Text := frmRecipient.ListBox1.Items.CommaText;
        frmMessage.edtCC.Text := frmRecipient.ListBox2.Items.CommaText;
        frmMessage.edtBCC.Text := frmRecipient.ListBox3.Items.CommaText;
      end;

    end;

end;

procedure TfrmMessage.BitBtn3Click(Sender: TObject);
begin
    if opendialog1.Execute then
      edtAttach.Text := opendialog1.Files.DelimitedText;


end;

end.
