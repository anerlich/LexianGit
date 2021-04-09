program LexianTest;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  FwdPlan in 'FwdPlan.pas',
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uMainDLL in 'uMainDLL.pas' {frmMainDLL},
  udmMainDLL in 'udmMainDLL.pas' {dmMainDLL: TDataModule},
  uCalculateRequirement in 'uCalculateRequirement.pas' {frmCalculateRequirement};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMainDLL, dmMainDLL);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfrmCalculateRequirement, frmCalculateRequirement);
  Application.Run;
end.
