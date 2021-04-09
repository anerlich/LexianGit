unit udmMainDLL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery,Math;

type
  TdmMainDLL = class(TdmOptimiza)
    GetItemData: TIBSQL;
    Calendar: TIBDataSet;
    GetFC: TIBSQL;
    GetPOData: TIBDataSet;
    GetCOData: TIBDataSet;
    qryGetDownloadDate: TIBSQL;
    GetConfig: TIBSQL;
    qryCO: TIBSQL;
    qryUpdate: TIBQuery;
    qryUpdate2: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetDownloadDateAsDate: TDateTime;
    function GetConfigAsString(ConfigNo:Integer):String;
    function GetConfigAsInteger(ConfigNo:Integer):Integer;
    function GetConfigAsDateTime(ConfigNo:Integer):TDate;
    function GetConfigAsFloat(ConfigNo:Integer):Real;





  end;

var
  dmMainDLL: TdmMainDLL;

implementation

{$R *.dfm}

{ TdmDummyPO }



{ TdmDummyPO }



function TdmMainDLL.GetConfigAsString(ConfigNo: Integer): String;
begin


  with GetConfig do
  begin
    ParamByName('ConfigNo').AsInteger := ConfigNo;
    ExecQuery;
    Result := FieldByName('TypeOfString').AsString;
    Close;
  end;

end;

function TdmMainDLL.GetConfigAsDateTime(ConfigNo: Integer): TDate;
begin
  with GetConfig do
  begin
    ParamByName('ConfigNo').AsInteger := ConfigNo;
    ExecQuery;
    Result := FieldByName('TypeOfDate').AsDate;
    Close;
  end;

end;

function TdmMainDLL.GetConfigAsFloat(ConfigNo: Integer): Real;
begin
  with GetConfig do
  begin
    ParamByName('ConfigNo').AsInteger := ConfigNo;
    ExecQuery;
    Result := FieldByName('TypeOfFloat').AsFloat;
    Close;
  end;

end;

function TdmMainDLL.GetConfigAsInteger(ConfigNo: Integer): Integer;
begin
 
  with GetConfig do
  begin
    ParamByName('ConfigNo').AsInteger := ConfigNo;
    ExecQuery;
    Result := FieldByName('TypeOfInteger').AsInteger;
    Close;
  end;

end;

function TdmMainDLL.GetDownloadDateAsDate: TDateTime;
begin


  with qrygetDownloadDate do
  begin
    ExecQuery;
    result := FieldByName('TypeOfDate').asDate;
    Close;
  end;

end;

end.
