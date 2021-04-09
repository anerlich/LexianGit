unit uFieldSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmFieldSelect = class(TForm)
    Label1: TLabel;
    cmbFieldName: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtFieldName: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFieldSelect: TfrmFieldSelect;

implementation

{$R *.dfm}

end.
