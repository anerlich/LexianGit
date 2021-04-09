unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery;

type
  TdmData = class(TdmOptimiza)
    qryAllLocations: TIBSQL;
    qryLoc: TIBQuery;
    qryInstallProc: TIBSQL;
    qryGetProc: TIBQuery;
    qryCreateProc: TIBSQL;
    prcUpdate: TIBStoredProc;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetLocCode(LocNo:Integer):String;
    function createProc:Boolean;
    procedure UpdateError(LocNo:Integer;Increase,Cap:String;Perc,CapPerc:Real);
  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

{ TdmData }

function TdmData.createProc:Boolean;
var
  Installed:Boolean;
begin

  Installed := False;

  try


    qryGetProc.Open;

    if Trim(qryGetProc.FieldByName('rdb$Procedure_Name').AsString) = 'UP_MODELFCERROR' then
      Installed := True;

    qryGetProc.Close;

  except

  end;

  if not Installed then
  begin
    if MessageDlg('Setup - Forecast Error Modeller'+#10+#10+
                   'This appears to be a new installation !'+#10+
                   'Do you wish to install the new procedures?',
                   mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin

      try

        if not trnOptimiza.InTransaction then
          trnOptimiza.StartTransaction;

        qryCreateProc.ExecQuery;
        trnOptimiza.Commit;
        trnOptimiza.StartTransaction;
        Installed := True;

      except
        Installed := False;
      end;

    end;

    if not Installed then MessageDlg('The installation process has failed!'+#10+
                              'Please Contact your Optimiza Administrator',
                              mtError,[MbOK],0);

  end;

  Result := Installed;

end;

function TdmData.GetLocCode(LocNo: Integer): String;
begin
  Result := '';

  with qryLoc do
  begin
    close;
    ParamByName('LocNo').AsInteger := LocNo;
    Prepare;
    Open;
    Result := FieldByName('LocationCode').AsString;
  end;

end;

procedure TdmData.UpdateError(LocNo: Integer; Increase, Cap: String; Perc,
  CapPerc: Real);
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  with prcUpdate do
  begin
    ParambyName('LocNo').AsInteger := LocNo;
    ParambyName('Increase').AsString := Increase;
    ParambyName('Cap').AsString := Cap;
    ParamByName('Perc').asFloat := Perc;
    ParambyName('CapPerc').AsFloat := CapPerc;
    ExecProc;


  end;

  trnOptimiza.Commit;

end;

end.
