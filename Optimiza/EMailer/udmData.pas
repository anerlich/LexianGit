unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery, IBTable,StrUtils;//, DBTables;

type
  TdmData = class(TdmOptimiza)
    qryUser: TIBQuery;
    srcUser: TDataSource;
    qryHost: TIBQuery;
    qryAccount: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FConnectionIssue:Boolean;
    function GetHostName:String;
    function GetUserID:String;
    function ReadConfigLongStr(ConfigNo: integer): string;

  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

{ TdmExport }



{ TdmExport }



{ TdmData }


{ TdmData }


{ TdmData }

function TdmData.GetHostName: String;
begin
  Result := '';

  with qryHost do
  begin
    Open;

    if Length(FieldByName('TypeOfLongString').AsString) > 0 then
      Result := FieldByName('TypeOfLongString').AsString
    else
      Result := FieldByName('TypeOfString').AsString;

    Close;

  end;

end;

function TdmData.GetUserID: String;
begin
  Result := '';

  with qryAccount do
  begin
    Open;

    if Length(FieldByName('TypeOfLongString').AsString) > 0 then
      Result := FieldByName('TypeOfLongString').AsString
    else
      Result := FieldByName('TypeOfString').AsString;

    Close;

  end;


end;

procedure TdmData.DataModuleCreate(Sender: TObject);
begin

  try
    fConnectionIssue := False;
    inherited;
  except
    fConnectionIssue := True;
  end;

end;

function TdmData.ReadConfigLongStr(
  ConfigNo: integer): string;
var
  InTrans : boolean;
begin

  InTrans := trnOptimiza.InTransaction;
  if not InTrans then
    trnOptimiza.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFLONGSTRING').AsString;
  finally
    if not InTrans then
      trnOptimiza.Commit;
  end;

end;

end.
