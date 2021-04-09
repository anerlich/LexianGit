unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery, IBTable,StrUtils;

type
  TdmData = class(TdmOptimiza)
    qryProd: TIBQuery;
  private
    { Private declarations }
    FLocationList:TStringList;
    
  public
    { Public declarations }
    function FindProduct(LocCode,ProdCode:String):Boolean;
    procedure BuildLocationList;
    function GetLocationOffset(LocationCode:String):Integer;
    procedure LocationListFree;
  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

{ TdmExport }



{ TdmExport }



{ TdmData }


{ TdmData }

procedure TdmData.BuildLocationList;
begin
  FLocationList := TStringList.Create;

  with dmData.qrySelectLocation do
  begin
    SQL.Clear;
    SQL.Add('Select * from Location Order By LocationNo');
    Open;

    while not eof do
    begin
      FLocationList.Add(FieldByName('LocationCode').AsString);
      //FLocationList.Values[FieldByName('LocationCode').AsString] := FieldByName('LocationNo').AsString;
      next;
    end;

    Close;

  end;

end;

function TdmData.FindProduct(LocCode, ProdCode: String): Boolean;
begin
  Result := False;

  with qryProd do
  begin
    ParamByName('LocCode').AsString := LocCode;
    ParamByName('ProdCode').AsString := ProdCode;
    Open;

    if FieldByName('ItemNo').AsInteger > 0 then
      Result := True;

    Close;
  end;

end;

function TdmData.GetLocationOffset(LocationCode: String): Integer;
begin

  try
    //Get relative offset of location code
    Result := FLocationList.IndexOf(LocationCode);
    Result := Result + 1;
  except
    Result := -1;
  end;

end;

procedure TdmData.LocationListFree;
begin
  FLocationList.Free;
end;

end.
