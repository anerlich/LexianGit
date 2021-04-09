unit uEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmEdit = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnRemove: TBitBtn;
    cmbBusiness: TComboBox;
    cmbMailType: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEdit: TfrmEdit;

implementation

{$R *.dfm}

end.
