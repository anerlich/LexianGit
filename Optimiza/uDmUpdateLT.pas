unit uDmUpdateLT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBDatabase, IBStoredProc, IBCustomDataSet, IBQuery, stdctrls;

type
  TdmUpdateLT = class(TdmOptimiza)
    qryAllLocations: TIBQuery;
    srcAllLocations: TDataSource;
    qrySuppliers: TIBQuery;
    srcsuppliers: TDataSource;
    qryUpdateLT: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateLt(LeadTime:Real;LocationList, supplierList: TListBox);
  end;

var
  dmUpdateLT: TdmUpdateLT;

implementation

{$R *.DFM}

procedure TdmUpdateLT.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryAllLocations.Active := True;
  qrysuppliers.Active := True;
end;

procedure TdmUpdateLT.UpdateLt(LeadTime:Real;LocationList, supplierList: TListBox);
var
  SupplierSQL, LocationSQL, LTSQL: String;
  CountItem: Integer;
  Save_Cursor:TCursor;
begin

  LocationSQL := '';

  for CountItem := 0 to (LocationList.Items.Count - 1) do
  begin

    If LocationSQL <> '' then LocationSQL := LocationSQL + ',';

    LocationSQL := LocationSQL + '"' + Copy(LocationList.Items.Strings[CountItem],1,Pos(';',LocationList.Items.Strings[CountItem])-2) + '"';

  end;

  LocationSQL := 'Select LocationNo From LOCATION where LocationCode in ('+LocationSQL+')';

  SupplierSQL := '';

  for CountItem := 0 to (supplierList.Items.Count - 1) do
  begin

    If SupplierSQL <> '' then supplierSQL := SupplierSQL + ',';

    supplierSQL := SupplierSQL + '"' + SupplierList.Items.Strings[CountItem]+'"';

  end;

  SupplierSQL := 'Select SupplierNo From SUPPLIER where SupplierCode in ('+SupplierSQL+')';


  LTSQL := 'Update ITEM set LeadTime = '+FloatToStr(LeadTime) + ' where ';
  LTSQL := LTSQL + 'SupplierNo1 in ('+SupplierSQL+') and ';
  LTSQL := LTSQL + 'LocationNo in ('+LocationSQL+')';

  Save_Cursor := Screen.Cursor;

  Screen.Cursor := crSQLWait;    { Show SQL cursor }

  try
    qryUpdateLt.SQL.Clear;
    qryUpdateLt.SQL.Add(LTSQL);
    qryUpdateLt.Prepare;
    qryUpdateLt.ExecSQL;

    trnOptimiza.Commit;

  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;

end;

end.
