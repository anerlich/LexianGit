unit uLookupProduct;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, StdCtrls, Buttons, Grids, DBGrids;

type
  TfrmLookupProduct = class(TForm)
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    DBNavigator1: TDBNavigator;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLookupProduct: TfrmLookupProduct;

implementation

uses udmAddNewProduct;

{$R *.DFM}

procedure TfrmLookupProduct.BitBtn1Click(Sender: TObject);
begin
  dmAddNewProduct.OpenSearchProd(Edit1.text);
end;

procedure TfrmLookupProduct.Edit1Exit(Sender: TObject);
begin
  Edit1.text := UpperCase(Edit1.text);
end;

end.
