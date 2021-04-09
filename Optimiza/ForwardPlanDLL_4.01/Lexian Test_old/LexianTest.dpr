program LexianTest;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FwdPlan in 'FwdPlan.pas',
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uMainDLL in 'uMainDLL.pas' {frmMainDLL},
  udmMainDLL in 'udmMainDLL.pas' {dmMainDLL: TDataModule},
  uCalculateRequirement in 'uCalculateRequirement.pas' {frmCalculateRequirement};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMainDLL, dmMainDLL);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmCalculateRequirement, frmCalculateRequirement);
  Application.Run;
end.
