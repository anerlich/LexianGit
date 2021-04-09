unit udmCopyMultipleHistory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery,
  IBSQL;

type
  TdmCopyMultipleHistory = class(TdmOptimiza)
    qryAllLocations: TIBQuery;
    qryProduct: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCopyMultipleHistory: TdmCopyMultipleHistory;

implementation

{$R *.DFM}

procedure TdmCopyMultipleHistory.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryAllLocations.Open;
end;

end.
