program ImportScheduleSet;

uses
  Forms,
  uDmOptimiza in 'o:\OPTIMIZA\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uMain in 'uMain.pas' {frmMain},
  uParameters in 'uParameters.pas' {frmParameters},
  uSelectOneLocation in 'o:\Optimiza\uSelectOneLocation.pas' {frmSelectOneLocation},
  udmData in 'udmData.pas' {dmData: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TfrmSelectOneLocation, frmSelectOneLocation);
  Application.CreateForm(TdmData, dmData);
  Application.Run;
end.
