unit uDmCopySalesHist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery;

type
  TdmCopySalesHist = class(TdmOptimiza)
    qryAllLocations: TIBQuery;
    srcAllLocations: TDataSource;
    qrySearchProduct: TIBQuery;
    srcSearchProduct: TDataSource;
    qryTargetLocations: TIBQuery;
    srcTargetLocations: TDataSource;
    prcUpdateSales: TIBStoredProc;
    qryCheckTarget: TIBQuery;
    srcCheckTarget: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenSearchProd(KeyData: String);
    procedure UpdateSale(SrcLoc, TgtLoc, SrcProd, TgtProd: String);
    procedure CommitSale;
    function CheckTarget(LocCode, ProdCode: String): Boolean;
  end;

var
  dmCopySalesHist: TdmCopySalesHist;

implementation

uses uStatus;

{$R *.DFM}

procedure TdmCopySalesHist.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryAllLocations.Open;
end;

procedure TdmCopySalesHist.OpenSearchProd(KeyData: String);
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

procedure TdmCopySalesHist.UpdateSale(SrcLoc, TgtLoc, SrcProd, TgtProd: String);
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  try
    with prcUpdateSales do
    begin
       prcUpdateSales.ParamByName('SourceLocationCode').AsString := SrcLoc;
       prcUpdateSales.ParamByName('TargetLocationCode').AsString := TgtLoc;
       prcUpdateSales.ParamByName('SourceProductCode').AsString := SrcProd;
       prcUpdateSales.ParamByName('TargetProductCode').AsString := TgtProd;
       prcUpdateSales.Prepare;
       prcUpdateSales.ExecProc;
    end;
    frmStatus.ListBox1.Items.Add('Copied Product '+SrcProd + ' From ' +SrcLoc+' to Product '+TgtProd+' in ' + TgtLoc);
    frmStatus.Show;


  except

  end;


end;

procedure TdmCopySalesHist.CommitSale;
begin
  if trnOptimiza.InTransaction then
    trnOptimiza.commit;

  frmStatus.ListBox1.Items.Add('...Done');
   qryAllLocations.Open;
end;

function TdmCopySalesHist.CheckTarget(LocCode, ProdCode: String): Boolean;
var
 TestCode: String;
begin

  Result := False;

  try
    qryCheckTarget.Close;
    qrycheckTarget.ParamByName('LocCode').AsString := LocCode;
    qrycheckTarget.ParamByName('ProdCode').AsString := ProdCode;
    qryCheckTarget.Prepare;
    qryCheckTarget.Open;

    TestCode := Trim(qryCheckTarget.FieldByName('ItemNo').AsString);

    if TestCode <> '' then Result := True;

  except

    Result := False;
  end;

  if result = False then
    MessageDlg('Product Code: '+ProdCode+' Does not exist in Location '+LocCode,
         mtError,[mbOK],0);
end;


end.
