unit uDmUpdateForecast;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery,
  IBSQL;

type
  TdmUpdateForecast = class(TdmOptimiza)
    qryAllLocations: TIBQuery;
    srcAllLocations: TDataSource;
    qrySearchProduct: TIBQuery;
    srcSearchProduct: TDataSource;
    qryTargetLocations: TIBQuery;
    srcTargetLocations: TDataSource;
    qryCheckTarget: TIBQuery;
    srcCheckTarget: TDataSource;
    qryPeriod: TIBQuery;
    srcPeriod: TDataSource;
    prcUpdateFC: TIBStoredProc;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OpenPeriod;

  public
    { Public declarations }
    procedure OpenSearchProd(KeyData: String);
    procedure UpdateFC(SrcLoc, SrcProd,FreezeInd: String;MonthCount,Offset:Integer;Perc:Real);
    procedure CommitFc;
    function CheckTarget(LocCode, ProdCode: String): Boolean;
  end;

var
  dmUpdateForecast: TdmUpdateForecast;

implementation

uses uStatus;

{$R *.DFM}

procedure TdmUpdateForecast.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryAllLocations.Open;
  OpenPeriod;
end;

procedure TdmUpdateForecast.OpenSearchProd(KeyData: String);
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

procedure TdmUpdateForecast.UpdateFC(SrcLoc, SrcProd,FreezeInd: String;MonthCount,Offset:Integer;Perc:Real);
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  try
    with prcUpdateFC do
    begin
       ParamByName('SourceLocationCode').AsString := SrcLoc;
       ParamByName('SourceProductCode').AsString := SrcProd;
       ParamByName('MonthCount').AsInteger := MonthCount;
       ParamByName('Offset').AsInteger := Offset;
       Prepare;
       ExecProc;
    end;
    frmStatus.ListBox1.Items.Add('Updated Product '+SrcProd + ' in ' +SrcLoc);
    frmStatus.Show;


  except
    frmStatus.ListBox1.Items.Add(SrcProd + ' From ' +SrcLoc+ ' not Updated');
    frmStatus.Show;

  end;


end;

procedure TdmUpdateForecast.CommitFc;
begin
  if trnOptimiza.InTransaction then
    trnOptimiza.commit;

  frmStatus.ListBox1.Items.Add('...Done');
   qryAllLocations.Open;
end;

function TdmUpdateForecast.CheckTarget(LocCode, ProdCode: String): Boolean;
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
procedure TdmUpdateForecast.OpenPeriod;
var
  StartPeriod, EndPeriod: Integer;
begin
  StartPeriod := GetCurrentPeriod;
  EndPeriod := StartPeriod + 18;

  qryPeriod.Close;
  qryPeriod.ParamByName('StartPeriod').AsInteger := StartPeriod;
  qryPeriod.ParamByName('EndPeriod').AsInteger := EndPeriod;
  qryPeriod.Prepare;
  qryPeriod.Open;

end;


end.
