unit uInterval;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask;

type
  TfrmInterval = class(TForm)
    Label5: TLabel;
    Label6: TLabel;
    edtInterval: TMaskEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    chkEventLog: TCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInterval: TfrmInterval;

implementation

{$R *.dfm}

procedure TfrmInterval.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  strHour, strMin: String;
  PosChar: Integer;
begin
CanClose := True;

try
  If (StrToInt(edtInterval.text) > 60) or (StrToInt(edtInterval.Text) < 1) then
    CanClose := False;
except
  CanClose := False;
end;

if not CanClose then
  MessageDlg('Invalid Time Interval.',mtError,[mbOK],0);

end;

end.
