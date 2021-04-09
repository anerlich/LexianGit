unit uEditSuppliers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, DBCtrls, StdCtrls, Buttons, ExtCtrls,db;

type
  TfrmEditSuppliers = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    BitBtn3: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateSupplierCode(SupplierNo: Integer);
  public
    { Public declarations }
  end;

var
  frmEditSuppliers: TfrmEditSuppliers;

implementation

uses uLookupSupplier, udmAddNewProduct;

{$R *.DFM}

procedure TfrmEditSuppliers.BitBtn3Click(Sender: TObject);
begin

  if frmLookupSupplier.ShowModal = mrOK then
  begin
    UpdateSupplierCode(dmAddNewProduct.srcSearchsupplier.DataSet.FieldByName('SupplierNo').AsInteger);
  end;

end;

procedure TfrmEditSuppliers.UpdateSupplierCode(SupplierNo: Integer);
var
  i, j, ItemNo: Integer;
  s: string;
begin
  if DBGrid1.SelectedRows.Count>0 then
  begin

    if not dmAddNewProduct.trnOptimiza.InTransaction then
      dmAddNewProduct.trnOptimiza.StartTransaction;

    with DBGrid1.DataSource.DataSet do
      for i:=0 to DBGrid1.SelectedRows.Count-1 do
      begin
        GotoBookmark(pointer(DBGrid1.SelectedRows.Items[i]));
        ItemNo := dbgrid1.DataSource.DataSet.FieldByName('ItemNo').AsInteger;
        dmAddNewProduct.UpdateSupplier(ItemNo, SupplierNo);
      end;

      dmAddNewProduct.trnOptimiza.Commit;
      dmAddnewProduct.qryShowProduct.Open;


  end
  else
    MessageDlg('No records were updated',mtinformation,[mbOk],0);

end;

procedure TfrmEditSuppliers.BitBtn1Click(Sender: TObject);
begin
  dmAddNewProduct.srcUpdate.DataSet.Locate('ProductCode',Edit1.text,[loCaseInsensitive, loPartialKey]);
end;

end.
