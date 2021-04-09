unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery, IBTable,StrUtils;

type
  TdmData = class(TdmOptimiza)
    qryProd: TIBQuery;
    qrySupplier: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FLocationList:TStringList;
    FLocCode:String;
    FLocNo:Integer;

  public
    { Public declarations }
    function FindProduct(LocCode,ProdCode:String):Boolean;
    procedure BuildLocationList;
    function GetLocationOffset(LocationCode:String):Integer;
    procedure LocationListFree;
    function GetSupplier(LocCode,ProdCode: String): String;
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

function TdmData.GetSupplier(LocCode,ProdCode: String): String;
begin
  Result := '';

  //Only get locno once and when needed
  if LocCode <> FLocCode then
    FLocNo := GetLocationNo(LocCode);

  with qrySupplier do
  begin
    parambyname('ProdCode').AsString := ProdCode;
    parambyname('LocNo').AsInteger := FLocNo;
    Open;

    if FieldByName('SupplierNo').IsNull then
      Result := ''
    else
      Result := FieldByName('SupplierCode').AsString;

    Close;
  end;



end;

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FLocCode := '';
  FLocNo := 0;
end;

end.
