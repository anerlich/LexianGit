program OptimizaAlertService;

uses
  SvcMgr,
  uService in 'uService.pas' {OptimizaServiceAlert: TService},
  Optimiza in '..\..\Optimiza\OptimizaAlertManager\Optimiza.pas',
  uDmOptimiza in '..\..\Optimiza\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uFileWait in '..\..\Optimiza\OptimizaAlertManager\uFileWait.pas',
  AlertCommon in 'AlertCommon.pas',
  uDmdata in '..\..\Optimiza\OptimizaAlertManager\uDmdata.pas' {dmData: TDataModule},
  afpEventLog in '..\..\KevDev\Downloads\EventLog\afpEventLog.pas',
  MainInstance in '..\..\Optimiza\OptimizaAlertManager35\MainInstance.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TOptimizaServiceAlert, OptimizaServiceAlert);
  Application.CreateForm(TdmOptimiza, dmOptimiza);
  Application.CreateForm(TdmData, dmData);
  Application.Run;
end.
