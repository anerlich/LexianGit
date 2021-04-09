unit udmRunSql;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBDatabase, IBStoredProc, IBCustomDataSet, IBQuery,
  IBSQLMonitor, IBSQL;

type
  TdmOptimiza2 = class(TdmOptimiza)
    qryUpdate: TIBQuery;
    IBSQLMonitor1: TIBSQLMonitor;
    IBSQL1: TIBSQL;
    IBTransaction1: TIBTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateIt(MemoData: TStrings);
  end;

var
  dmOptimiza2: TdmOptimiza2;

implementation

uses uMonitor;



{$R *.DFM}

procedure TdmOptimiza2.UpdateIt(MemoData: TStrings);
begin
   if not trnOptimiza.InTransaction then
     trnOptimiza.StartTransaction;

   qryUpdate.SQL.Clear;
   qryUpdate.SQL.AddStrings(MemoData);
   qryUpdate.Prepare;
   qryUpdate.ExecSQL;
   //try
      trnOptimiza.Commit;
   //except
   //end;
   Form2.ShowModal;


end;
end.
