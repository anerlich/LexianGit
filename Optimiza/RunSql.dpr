program RunSql;

uses
  Forms,
  uRunSQL in 'uRunSQL.pas' {Form1},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmRunSql in 'udmRunSql.pas' {dmOptimiza2: TDataModule},
  uSQLFilePath in 'uSQLFilePath.pas' {frmSQLFilePath},
  uMonitor in 'uMonitor.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmOptimiza2, dmOptimiza2);
  Application.CreateForm(TfrmSQLFilePath, frmSQLFilePath);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
