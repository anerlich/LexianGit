program ReportBatchWizard;

uses
  Forms,
  uReportBatchWizard in 'uReportBatchWizard.pas' {Form1},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmReportBatchWizard in 'uDmReportBatchWizard.pas' {dmOptimiza2: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmOptimiza2, dmOptimiza2);
  Application.Run;
end.
