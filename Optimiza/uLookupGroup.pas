unit uLookupGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DBCtrls;

type
  TfrmLookupGroup = class(TForm)
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLookupGroup: TfrmLookupGroup;

implementation

uses udmAddNewProduct;

{$R *.DFM}

procedure TfrmLookupGroup.BitBtn1Click(Sender: TObject);
begin
  Case Radiogroup1.ItemIndex of
    0: dmAddNewProduct.OpenSearchMaj(Edit1.text);
    1: dmAddNewProduct.OpenSearchMin1(Edit1.text);
    2: dmAddNewProduct.OpenSearchMin2(Edit1.text);
  end;

end;

end.
