unit udmDummyPO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery,Math;

type
  TdmDummyPO = class(TdmOptimiza)
    GetItemData: TIBSQL;
    Calendar: TIBDataSet;
    GetFC: TIBSQL;
    GetPOData: TIBDataSet;
    GetCOData: TIBDataSet;
    qryGetDownloadDate: TIBSQL;
    GetConfig: TIBSQL;
    GetItemData2: TIBSQL;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetDownloadDateAsDate: TDateTime;
    function GetConfigAsString(ConfigNo:Integer):String;
     function GetConfigAsPChar(ConfigNo:Integer):String;
    function GetConfigAsInteger(ConfigNo:Integer):Integer;
    function GetConfigAsDateTime(ConfigNo:Integer):TDate;
    function GetConfigAsFloat(ConfigNo:Integer):Real;


  end;

var
  dmDummyPO: TdmDummyPO;

implementation

{$R *.dfm}

{ TdmDummyPO }



{ TdmDummyPO }



function TdmDummyPO.GetConfigAsString(ConfigNo: Integer): String;
begin


  with GetConfig do
  begin
    ParamByName('ConfigNo').AsInteger := ConfigNo;
    ExecQuery;
    Result := FieldByName('TypeOfString').AsString;
    Close;
  end;

end;

function TdmDummyPO.GetConfigAsDateTime(ConfigNo: Integer): TDate;
begin
  with GetConfig do
  begin
    ParamByName('ConfigNo').AsInteger := ConfigNo;
    ExecQuery;
    Result := FieldByName('TypeOfDate').AsDate;
    Close;
  end;

end;

function TdmDummyPO.GetConfigAsFloat(ConfigNo: Integer): Real;
begin
  with GetConfig do
  begin
    ParamByName('ConfigNo').AsInteger := ConfigNo;
    ExecQuery;
    Result := FieldByName('TypeOfFloat').AsFloat;
    Close;
  end;

end;

function TdmDummyPO.GetConfigAsInteger(ConfigNo: Integer): Integer;
begin
 
  with GetConfig do
  begin
    ParamByName('ConfigNo').AsInteger := ConfigNo;
    ExecQuery;
    Result := FieldByName('TypeOfInteger').AsInteger;
    Close;
  end;

end;

function TdmDummyPO.GetDownloadDateAsDate: TDateTime;
begin


  with qrygetDownloadDate do
  begin
    ExecQuery;
    result := FieldByName('TypeOfDate').asDate;
    Close;
  end;

end;
function TdmDummyPO.GetConfigAsPChar(ConfigNo: Integer): String;
var
  TempString: String;
  ArrString: Array[0..1] of Char;
  SCount, SLen:Integer;
begin

  with GetConfig do
  begin
    ParamByName('ConfigNo').AsInteger := ConfigNo;
    ExecQuery;
    TempString := Trim(FieldByName('TypeOfString').AsString);
    SLen := Min(Length(TempString),9);

    for SCount := 0 to SLen do
    begin
      ArrString[SCount] := UpCase(TempString[SCount+1]);
    end;

    ArrString[SCount] := #0; //Null Terminated
    TempString := ArrString;
    //Result := ArrString;
    Result := TempString;
    Close;
  end;

end;

end.
