unit udefault;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmDefault = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    FParamNo:Integer;
  end;

var
  frmDefault: TfrmDefault;

implementation

{$R *.dfm}

procedure TfrmDefault.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Edit1.Text := '[default]';
    Edit1.Enabled := False;
  end
  else
    Edit1.Enabled := True;

end;

end.
