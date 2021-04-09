program OptimizaAlert;

uses
  Forms,
  uSystray in 'uSystray.pas' {Form1},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmdata in 'uDmdata.pas' {dmData: TDataModule},
  uEditDrive in 'uEditDrive.pas' {frmEditDrive},
  uInterval in 'uInterval.pas' {frmInterval},
  uEditSchedule in 'uEditSchedule.pas' {frmEditSchedule},
  uSelectProcess in 'uSelectProcess.pas' {frmSelectProcess},
  uSelectFolder in 'uSelectFolder.pas' {frmSelectFolder},
  uDriveSpace in 'uDriveSpace.pas' {frmDriveSpace};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmEditDrive, frmEditDrive);
  Application.CreateForm(TfrmInterval, frmInterval);
  Application.CreateForm(TfrmEditSchedule, frmEditSchedule);
  Application.CreateForm(TfrmSelectProcess, frmSelectProcess);
  Application.CreateForm(TfrmSelectFolder, frmSelectFolder);
  Application.CreateForm(TfrmDriveSpace, frmDriveSpace);
  Application.Run;
end.
