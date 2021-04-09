unit uDmdata;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, DB, IBCustomDataSet, IBDatabase, IBStoredProc,
  IBQuery, IBEvents, IBSQL;

type
  TdmData = class(TdmOptimiza)
    qrySchedule: TIBQuery;
    srcSchedule: TDataSource;
    qryConfig: TIBQuery;
    srcConfig: TDataSource;
    trnConfig: TIBTransaction;
    procedure OptimizaAlertEventAlert(Sender: TObject; EventName: String;
      EventCount: Integer; var CancelAlerts: Boolean);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurrentSchedule:String;
    function GetSchedulerStatus: Integer;
    
  end;

var
  dmData: TdmData;

implementation

uses uDBError;

{$R *.dfm}

function TdmData.GetSchedulerStatus: Integer;
var
  ConfigID: Integer;
begin
  Result := -1;

  with dmData.srcConfig.DataSet do
  begin

    Try
      dmData.dbOptimiza.Connected := True;

      if not dmData.trnConfig.InTransaction then
        dmData.trnConfig.StartTransaction;

      Open;
      ConFigID := FieldByName('ConfigurationNo').AsInteger;
      CurrentSchedule := '';

      if ConfigID = 291 then
      begin
        CurrentSchedule := FieldByName('TypeOfLongString').AsString;
        Result := FieldByName('TypeOfInteger').AsInteger;
      end;

      Close;

      if dmData.trnConfig.InTransaction then
        dmData.trnConfig.Commit;

      dmData.dbOptimiza.Connected := False;
    except
       Result := -1;
    end;

  end;


end;

procedure TdmData.OptimizaAlertEventAlert(Sender: TObject;
  EventName: String; EventCount: Integer; var CancelAlerts: Boolean);
begin
  inherited;
  //frmDBError.EventLog.LogEvent('Optimiza Scheduler has failed');
  //frmDBError.ShowModal;
end;

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  inherited;
  CurrentSchedule := '';
end;

end.
