program CheckDownloads;

uses
  Forms,
  uDmOptimiza in '..\..\OPTIMIZA\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uMain in 'uMain.pas' {frmMain},
  uParameters in 'uParameters.pas' {frmParameters},
  uSelectOneLocation in '..\..\Optimiza\uSelectOneLocation.pas' {frmSelectOneLocation},
  udmData in 'udmData.pas' {dmData: TDataModule},
  uEditType in 'uEditType.pas' {frmEditType},
  uSelectFolder in 'uSelectFolder.pas' {frmFolder},
  uFileWait in 'uFileWait.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TfrmSelectOneLocation, frmSelectOneLocation);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmEditType, frmEditType);
  Application.CreateForm(TfrmFolder, frmFolder);
  Application.Run;
end.
