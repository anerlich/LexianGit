program OptimizaAlert;

uses
  Forms,
  uSystray in 'uSystray.pas' {frmSystray},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmdata in 'uDmdata.pas' {dmData: TDataModule},
  uEditDrive in 'uEditDrive.pas' {frmEditDrive},
  uInterval in 'uInterval.pas' {frmInterval},
  uEditSchedule in 'uEditSchedule.pas' {frmEditSchedule},
  uSelectProcess in 'uSelectProcess.pas' {frmSelectProcess},
  uSelectFolder in 'uSelectFolder.pas' {frmSelectFolder},
  uDriveSpace in 'uDriveSpace.pas' {frmDriveSpace},
  uEmail in 'uEmail.pas' {frmEmail},
  uFileWait in 'uFileWait.pas',
  uShowMessage in 'uShowMessage.pas' {frmShowMessage},
  afpEventLog in '..\..\KevDev\Downloads\EventLog\afpEventLog.pas',
  MainInstance in '..\..\Optimiza\OptimizaAlertManager35\MainInstance.pas',
  AlertCommon in '..\..\Optimiza\OptimizaAlertManager\AlertCommon.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmSystray, frmSystray);
  Application.CreateForm(TfrmEditDrive, frmEditDrive);
  Application.CreateForm(TfrmInterval, frmInterval);
  Application.CreateForm(TfrmEditSchedule, frmEditSchedule);
  Application.CreateForm(TfrmSelectProcess, frmSelectProcess);
  Application.CreateForm(TfrmSelectFolder, frmSelectFolder);
  Application.CreateForm(TfrmDriveSpace, frmDriveSpace);
  Application.CreateForm(TfrmEmail, frmEmail);
  Application.CreateForm(TfrmShowMessage, frmShowMessage);
  Application.Run;
end.
