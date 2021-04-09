program CalculateRequirement;

uses
  Forms,
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uMainDLL in 'UMAINDLL.pas' {frmMainDLL},
  udmMainDLL in 'udmMainDLL.pas' {dmMainDLL: TDataModule},
  uParameters in 'uParameters.pas' {frmParameters},
  uSelectOneLocation in '..\uSelectOneLocation.pas' {frmSelectOneLocation},
  uCalculateRequirement in 'uCalculateRequirement.pas' {frmCalculateRequirement};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMainDLL, dmMainDLL);
  Application.CreateForm(TfrmCalculateRequirement, frmCalculateRequirement);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TfrmSelectOneLocation, frmSelectOneLocation);
  Application.Run;
end.
