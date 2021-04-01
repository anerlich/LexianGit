unit udmExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery, IBTable,StrUtils;

type
  TdmExport = class(TdmOptimiza)
    qryEndDate: TIBQuery;
    qryCapacityOrder: TIBQuery;
    qryPotentialStockout: TIBQuery;
    qrySurplusStock: TIBQuery;
    qryExpediteOrder: TIBQuery;
    qryLocationList: TIBQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    procedure OpenPotentialStockout(LocCode:String);
    procedure OpenSurplusStock(LocCode:String);
    procedure OpenExpediteOrder(LocCode:String);
    procedure OpenLocationList(LocCodes:String);
    function GetEndDate:TDateTime;

  end;

var
  dmExport: TdmExport;

implementation

{$R *.dfm}

{ TdmDummyPO }



{ TdmDummyPO }



{ TdmExport }

function TdmExport.GetEndDate: TDateTime;
begin

  with qryEndDate do
  begin
    Open;
    Result := FieldByName('EndDate').AsDateTime;
    Close;
  end;

end;


procedure TdmExport.OpenExpediteOrder(LocCode: String);
begin

  With qryExpediteOrder do
  begin
    close;
    ParamByName('LocCode').AsString := LocCode;
    Prepare;
    Open;
  end;

end;

procedure TdmExport.OpenLocationList(LocCodes: String);
begin

  with qryLocationList do
  begin
    SQL.Clear;
    SQL.Add('Select * from Location ');
    SQL.Add(' where LocationCode in ('+LocCodes+')');
    Open;
  end;

end;

procedure TdmExport.OpenPotentialStockout(LocCode: String);
begin

  With qryPotentialStockout do
  begin
    close;
    ParamByName('LocCode').AsString := LocCode;
    Prepare;
    Open;
  end;

end;

procedure TdmExport.OpenSurplusStock(LocCode: String);
begin

  With qrySurplusStock do
  begin
    close;
    ParamByName('LocCode').AsString := LocCode;
    Prepare;
    Open;
  end;

end;

end.
