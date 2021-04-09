unit uParameters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,Clipbrd, Buttons;

type
  TfrmParameters = class(TForm)
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    chkIgnore: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParameters: TfrmParameters;

implementation

uses uSelectOneLocation;

{$R *.dfm}

procedure TfrmParameters.Button1Click(Sender: TObject);
begin
  if frmSelectOneLocation.ShowModal = mrOK then
    Edit1.Text := frmSelectOneLocation.LocationCode;
end;

procedure TfrmParameters.Button2Click(Sender: TObject);
begin
  if opendialog1.Execute then
    edit2.Text := opendialog1.FileName;
end;

procedure TfrmParameters.BitBtn2Click(Sender: TObject);
var
  OrderType,IgNore:String;
begin

  case radiogroup1.ItemIndex of
    0: OrderType := 'ROCO';
    1: OrderType := 'ROOD';
    2: OrderType := 'STANDARD';
  end;

  if chkIgnore.Checked then
    IgNore := 'IGNORE'
  else
    Ignore := 'USE';

  Clipboard.AsText := 'Optimiza:"'+OrderType+'" "'+edit1.Text+'" "'+edit2.Text+'" "'+Ignore+'"';

end;

end.
