unit udmAddNewProduct;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery,
  IBSQL;

type
  TdmaddNewProduct = class(TdmOptimiza)
    srcSearchProduct: TDataSource;
    qrySearchProduct: TIBQuery;
    qrySearchItem: TIBQuery;
    srcSearchItem: TDataSource;
    qrySearchsupplier: TIBQuery;
    srcSearchsupplier: TDataSource;
    qryMajor: TIBQuery;
    qryMinor1: TIBQuery;
    qryMinor2: TIBQuery;
    srcMajor: TDataSource;
    srcMinor1: TDataSource;
    srcMinor2: TDataSource;
    qryUser: TIBQuery;
    srcUser: TDataSource;
    qryAllLocations: TIBQuery;
    srcAllLocations: TDataSource;
    qryInsertProduct: TIBQuery;
    qryInsertItem: TIBQuery;
    qryValidateLocs: TIBQuery;
    srcValidateLocs: TDataSource;
    srcUpdate: TDataSource;
    qryGetMaxItem: TIBQuery;
    qryShowProduct: TIBQuery;
    qryUpdateSupplier: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function ValidateLocs(Locs: TStrings;ProdNo: Integer):Boolean;
  public
    { Public declarations }
    procedure OpenSearchProd(KeyData: String);
    procedure OpenSearchItem(ProdNo: Integer);
    procedure OpenSearchsupp(KeyData: String);
    procedure OpenSearchMaj(KeyData: String);
    procedure OpenSearchMin1(KeyData: String);
    procedure OpenSearchMin2(KeyData: String);
    procedure OpenAllLocations;
    procedure CloseAllLocations;
    function InsertProduct(Locs: TStrings;
              Major, Minor1, Minor2, Supplier: Integer;
              ProductCode, ProductDescr, Pareto, Stocked, LTCat: String;
              Min, Mult, Cost, Retail, CostPer: Extended):Boolean;
    procedure UpdateSupplier(ItemNo, SupplierNo: Integer);
  end;

var
  dmaddNewProduct: TdmaddNewProduct;
  MaxItemNo: Integer;

implementation

{$R *.DFM}

procedure TdmaddNewProduct.OpenSearchProd(KeyData: String);
var
  cSql: String;
begin

  With qrySearchProduct do
  begin
    Close;
    cSql := 'Select ProductNo, ProductCode, ProductDescription From Product where ProductCode >= "'+KeyData+'" Order by ProductCode';
    SQL.Clear;
    SQL.Add(cSql);
    Open;
  end;

end;

procedure TdmaddNewProduct.OpenSearchItem(ProdNo: Integer);
var
  cSql: String;
begin

  With qrySearchItem do
  begin
    Close;
    ParambyName('ProductNo').AsInteger := ProdNo;
    Prepare;
    Open;
  end;

end;

procedure TdmaddNewProduct.OpenSearchsupp(KeyData: String);
var
  cSql: String;
begin

  With qrySearchSupplier do
  begin
    Close;
    cSql := 'Select supplierNo, SupplierCode, SupplierName From supplier where supplierCode >= "'+KeyData+'" Order by SupplierCode';
    SQL.Clear;
    SQL.Add(cSql);
    Open;
  end;

end;

procedure TdmaddNewProduct.OpenSearchMaj(KeyData: String);
var
  cSql: String;
begin

  With qryMajor do
  begin
    Close;
    cSql := 'Select GroupNo, GroupCode, Description From GroupMajor where GroupCode >= "'+KeyData+'" Order by GroupCode';
    SQL.Clear;
    SQL.Add(cSql);
    Open;
  end;

end;

procedure TdmaddNewProduct.OpenSearchMin1(KeyData: String);
var
  cSql: String;
begin

  With qryMinor1 do
  begin
    Close;
    cSql := 'Select GroupNo, GroupCode, Description From GroupMinor1 where GroupCode >= "'+KeyData+'" Order by GroupCode';
    SQL.Clear;
    SQL.Add(cSql);
    Open;
  end;

end;

procedure TdmaddNewProduct.OpenSearchMin2(KeyData: String);
var
  cSql: String;
begin

  With qryMinor2 do
  begin
    Close;
    cSql := 'Select GroupNo, GroupCode, Description From GroupMinor2 where GroupCode >= "'+KeyData+'" Order by GroupCode';
    SQL.Clear;
    SQL.Add(cSql);
    Open;
  end;

end;

procedure TdmaddNewProduct.OpenAllLocations;
begin
  qryAllLocations.Open
end;

procedure TdmaddNewProduct.CloseAllLocations;
begin

  qryAllLocations.Close;
end;

function TdmaddNewProduct.InsertProduct(Locs: TStrings;
  Major, Minor1, Minor2, Supplier: Integer;
  ProductCode, ProductDescr, Pareto, Stocked, LTCat: String;
  Min, Mult, Cost, Retail, CostPer: Extended):Boolean;
var
  LocNum, LocCount, ProdNo: Integer;
  ProdCodeInFile: String;
begin
  Result := False;

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  With srcSearchProduct.DataSet do
  begin

    try
      ProdCodeinFile := '';
      ProdCodeInFile := FieldbyName('ProductCode').AsString;
      ProdNo := FieldbyName('ProductNo').AsInteger;
    except
      ProdCodeinFile := '';
    end;


    if ProductCode <>  ProdCodeInFile then
    begin
      OpenSearchProd(ProductCode);


      try
        ProdCodeinFile := '';
        ProdCodeInFile := FieldbyName('ProductCode').AsString;
        ProdNo := FieldbyName('ProductNo').AsInteger;
      except
        ProdCodeinFile := '';
      end;

      //not found so we insert.
      if ProductCode <> ProdCodeInFile then
      begin
        qryInsertProduct.Close;
        qryInsertProduct.ParamByName('ProductCode').AsString := ProductCode;
        qryInsertProduct.ParamByName('ProductDescription').AsString := ProductDescr;
        qryInsertProduct.ExecSQL;

        OpenSearchProd(ProductCode);
        ProdNo := FieldbyName('ProductNo').AsInteger;

      end;

    end;

  end;

  if ValidateLocs(Locs,ProdNo) then
  begin

    for LocCount := 0 to (Locs.count -1) do
    begin
      LocNum := StrToInt(Locs[LocCount]);

     with qryInsertItem do
     begin
       Close;
       ParambyName('ProductNo').AsInteger := ProdNo;
       ParambyName('LocationNo').AsInteger := LocNum;
       ParambyName('PARETOCATEGORY').AsString := Pareto;
       ParambyName('STOCKINGINDICATOR').Asstring :=  Stocked;
       ParambyName('MINIMUMORDERQUANTITY').AsFloat := Min;
       ParambyName('ORDERMULTIPLES').AsFloat := Mult;
       ParambyName('COSTPRICE').AsFloat := Cost;
       ParambyName('COSTPER').AsFloat :=  CostPer;
       ParambyName('RETAILPRICE').AsFloat := Retail;
       ParambyName('GROUPMAJOR').AsInteger := Major;
       ParambyName('GROUPMINOR1').AsInteger := Minor1;
       ParambyName('GROUPMINOR2').AsInteger := Minor2;
       ParambyName('SUPPLIERNO1').AsInteger :=  Supplier;
       ParambyName('LEADTIMECATEGORY').AsString :=  LTCat;
       ExecSQL;

     end;

   end;

    trnOptimiza.Commit;
    Result := True;
    qryShowProduct.Prepare;
    qryShowProduct.Open;

  end
  else
    Result := False;


end;

function TdmaddNewProduct.ValidateLocs(Locs: TStrings;ProdNo: Integer):Boolean;
Var cSql, cLocs, ProdCodeInFile: String;
  LocCount: Integer;

begin
  cLocs := '';

  for LocCount := 0 to (Locs.count -1) do
  begin
    if cLocs <> '' then
     cLocs := cLocs + ', ';

    cLocs := cLocs + Locs[LocCount];

  end;


  cSql := 'Select l.LocationCode, p.ProductCode, i.LocationNo, i.ProductNo ';
  cSql := cSql + 'from item i left outer join Product P on i.ProductNo = P.ProductNo ';
  cSql := cSql + 'left outer join Location L on i.LocationNo = L.LocationNo ';
  cSql := cSql + 'where i.ProductNo = ' + IntToStr(ProdNo);
  cSql := cSql + ' and i.LocationNo in ('+cLocs+')';

  qryValidateLocs.close;
  qryValidateLocs.SQL.Clear;
  qryValidateLocs.SQL.Add(cSql);
  qryValidateLocs.Prepare;
  qryValidateLocs.Open;

  try
    ProdCodeinFile := '';
    ProdCodeInFile := srcValidateLocs.Dataset.FieldbyName('ProductCode').AsString;
  except
    ProdCodeinFile := '';
  end;

  if ProdCodeInFile <> '' then
    Result := False
  else
    Result := True;


end;

procedure TdmaddNewProduct.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryGetMaxItem.Open;
  MaxItemNo := qryGetMaxItem.FieldByName('Max').asInteger;
  qryGetMaxItem.Close;
  qryShowProduct.Close;
  qryShowProduct.ParamByName('ItemNo').asInteger := MaxItemNo;
  qryShowProduct.Open;
end;

procedure TdmaddNewProduct.UpdateSupplier(ItemNo, SupplierNo: Integer);
begin
  qryUpdateSupplier.close;
  qryUpdateSupplier.ParamByName('ItemNo').asInteger := ItemNo;
  qryUpdateSupplier.ParamByName('SupplierNo').asInteger := SupplierNo;
  qryUpdateSupplier.ExecSQL;
end;

end.
