unit uDmCopyForecast;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery;

type
  TdmCopyForecast = class(TdmOptimiza)
    qryAllLocations: TIBQuery;
    srcAllLocations: TDataSource;
    qrySearchProduct: TIBQuery;
    srcSearchProduct: TDataSource;
    qryTargetLocations: TIBQuery;
    srcTargetLocations: TDataSource;
    prcCopyFC: TIBStoredProc;
    qryCheckTarget: TIBQuery;
    srcCheckTarget: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure OpenSearchProd(KeyData: String);
    procedure UpdateFC(SrcLoc, SrcProd, TgtProd, FreezeInd, AddInd: String;MonthCount:Integer);
    procedure CommitFc;
    function CheckTarget(LocCode, ProdCode: String): Boolean;
  end;

var
  dmCopyForecast: TdmCopyForecast;

implementation

uses uStatus;

{$R *.DFM}

procedure TdmCopyForecast.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryAllLocations.Open;
end;

procedure TdmCopyForecast.OpenSearchProd(KeyData: String);
var
  cSql: String;
begin

  With qrySearchProduct do
  begin
    Close;
    cSql := 'Select ProductCode, ProductDescription, ProductNo  From Product where ProductCode >= "'+KeyData+'" Order by ProductCode';
    SQL.Clear;
    SQL.Add(cSql);
    Open;
  end;

end;

procedure TdmCopyForecast.UpdateFC(SrcLoc, SrcProd, TgtProd, FreezeInd, AddInd: String;MonthCount:Integer);
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  try
    with prcCopyFC do
    begin
       ParamByName('SourceLocationCode').AsString := SrcLoc;
       ParamByName('SourceProductCode').AsString := SrcProd;
       ParamByName('TargetProductCode').AsString := TgtProd;
       ParamByName('FreezeInd').AsString := FreezeInd;
       ParamByName('AddInd').AsString := AddInd;
       ParamByName('MonthCount').AsInteger := MonthCount;
       Prepare;
       ExecProc;
    end;
    frmStatus.ListBox1.Items.Add('Copied Product '+SrcProd + ' From ' +SrcLoc+' to Product '+TgtProd+' in ' + SrcLoc);
    frmStatus.Show;


  except
    frmStatus.ListBox1.Items.Add(SrcProd + ' From ' +SrcLoc+' to Product '+TgtProd+' in ' + SrcLoc+ ' not Copied');
    frmStatus.Show;

  end;


end;

procedure TdmCopyForecast.CommitFc;
begin
  if trnOptimiza.InTransaction then
    trnOptimiza.commit;

  frmStatus.ListBox1.Items.Add('...Done');
   qryAllLocations.Open;
end;

function TdmCopyForecast.CheckTarget(LocCode, ProdCode: String): Boolean;
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
    frmStatus.ListBox1.Items.Add('Product Code: '+ProdCode+' Does not exist in Location: '+LocCode)

end;


end.
