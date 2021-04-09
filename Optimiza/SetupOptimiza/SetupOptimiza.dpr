program SetupOptimiza;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmData in 'udmData.pas' {dmData: TDataModule},
  uFolders in 'uFolders.pas' {frmFolders},
  uSelectFolder in '..\OptimizaAlertManager2\uSelectFolder.pas' {frmSelectFolder},
  uBackup in 'uBackup.pas' {frmBackup};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmFolders, frmFolders);
  Application.CreateForm(TfrmSelectFolder, frmSelectFolder);
  Application.CreateForm(TfrmBackup, frmBackup);
  Application.Run;
end.
