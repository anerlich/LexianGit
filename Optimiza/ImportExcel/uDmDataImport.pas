unit uDmDataImport;

interface

uses
  Windows, Messages, SysUtils, StrUtils,Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMData, Provider, DBClient, IBTable, IBCustomDataSet,
  IBUpdateSQL, IBSQL, DB, IBDatabase, IBStoredProc, IBQuery, udmOptimiza,
  ADODB;

type
  TdmDataImport = class(TdmOptimiza)
    qryGetItemNo: TIBQuery;
    qryGetRepCatNos: TIBQuery;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    qryInsertExcelData: TIBSQL;
  private
    { Private declarations }
  public
    function GetItemNo(LocCode,ProdCode: String):Integer;
    procedure ConnectToExcel(FilePath : string);
    procedure DisconnectFromExcel();
  end;

var
  dmDataImport: TdmDataImport;

implementation

{$R *.dfm}

procedure TdmDataImport.ConnectToExcel(FilePath : string);
var
  strCon : widestring;
begin
  strCon := 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source='+ FilePath + ';Extended Properties="Excel 12.0 Xml;HDR=YES";';
  AdoConnection1.Connected := False;
  AdoConnection1.ConnectionString := strCon;
  try
    AdoConnection1.Open;
  except
    raise;
  end;
end;

procedure TdmDataImport.DisconnectFromExcel();
begin
  AdoQuery1.Close;
  AdoConnection1.Connected := False;
end;


function TdmDataImport.GetItemNo(LocCode,ProdCode: String):Integer;
begin
    With qryGetItemNo do begin
      Active := False;
      ParamByName('loccode').AsString := LocCode;
      ParamByName('prodcode').AsString := ProdCode;
      Active := True;
      Result := FieldByName('ItemNo').AsInteger;
      Active := False;
    end;
end;




end.
