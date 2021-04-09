program OptimizaAlertManager;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmdata in 'uDmdata.pas' {dmData: TDataModule},
  uEditSchedule in 'uEditSchedule.pas' {frmEditSchedule},
  uEditDrive in 'uEditDrive.pas' {frmEditDrive},
  uInterval in 'uInterval.pas' {frmInterval},
  uSelectFolder in '..\..\Optimiza\OptimizaAlertManager\uSelectFolder.pas' {frmSelectFolder},
  uEmail in '..\..\Optimiza\OptimizaAlertManager\uEmail.pas' {frmEmail},
  uSelectProcess in '..\..\Optimiza\OptimizaAlertManager\uSelectProcess.pas' {frmSelectProcess};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmOptimiza, dmOptimiza);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmEditSchedule, frmEditSchedule);
  Application.CreateForm(TfrmEditDrive, frmEditDrive);
  Application.CreateForm(TfrmInterval, frmInterval);
  Application.CreateForm(TfrmSelectFolder, frmSelectFolder);
  Application.CreateForm(TfrmEmail, frmEmail);
  Application.CreateForm(TfrmSelectProcess, frmSelectProcess);
  Application.Run;
end.
