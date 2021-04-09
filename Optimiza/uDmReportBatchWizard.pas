unit uDmReportBatchWizard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery;

type
  TdmOptimiza2 = class(TdmOptimiza)
    qryAllLocations: TIBQuery;
    srcAllLocations: TDataSource;
    qryUsers: TIBQuery;
    srcUsers: TDataSource;
    qryReports: TIBQuery;
    qryTemplate: TIBQuery;
    srcReports: TDataSource;
    srcTemplate: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenTemplate(ReportNo: Integer);
  end;

var
  dmOptimiza2: TdmOptimiza2;

implementation

{$R *.DFM}

procedure TdmOptimiza2.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryallLocations.Open;
  qryUsers.Open;
  qryReports.Open;
  OpenTemplate(srcReports.dataset.fieldbyname('REPORTNO').AsInteger);
end;

procedure TdmOptimiza2.OpenTemplate(ReportNo: Integer);
begin
    With qrytemplate do begin
      Active := False;
      ParamByName('ReportNo').AsInteger := ReportNo;
      Active := True;
    end;
end;

end.
