program Backup_Optimiza;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uProperties in 'uProperties.pas' {frmProperties},
  uFolderSelect in 'uFolderSelect.pas' {frmFolder},
  uZipFile in 'uZipFile.pas' {frmZipFile},
  uExist in 'uExist.pas' {frmExist},
  uStatus in 'uStatus.pas' {frmStatus},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uAbout in 'uAbout.pas' {frmAbout};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Optimiza Backup Utility';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmProperties, frmProperties);
  Application.CreateForm(TfrmFolder, frmFolder);
  Application.CreateForm(TfrmZipFile, frmZipFile);
  Application.CreateForm(TfrmExist, frmExist);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.CreateForm(TdmOptimiza, dmOptimiza);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
