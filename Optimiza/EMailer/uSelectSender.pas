unit uSelectSender;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TfrmSelectSender = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelectSender: TfrmSelectSender;

implementation

uses uSelectUser;

{$R *.dfm}

procedure TfrmSelectSender.Button1Click(Sender: TObject);
begin
  if frmSelectUser.ShowModal = mrOK then
  begin
    Edit1.Text := frmSelectUser.DBGrid1.DataSource.DataSet.FieldByName('UserName').AsString;
    Edit2.Text := frmSelectUser.DBGrid1.DataSource.DataSet.FieldByName('Eaddr').AsString;
  end;

end;

end.
