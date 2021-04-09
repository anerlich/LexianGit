unit uLookupSupplier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, StdCtrls, Buttons, Grids, DBGrids;

type
  TfrmLookupSupplier = class(TForm)
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    DBNavigator1: TDBNavigator;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLookupSupplier: TfrmLookupSupplier;

implementation

uses udmAddNewProduct;

{$R *.DFM}

procedure TfrmLookupSupplier.BitBtn1Click(Sender: TObject);
begin
  dmAddNewProduct.OpenSearchSupp(Edit1.text);
end;

end.
