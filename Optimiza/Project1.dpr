program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  FwdPlan in 'ForwardPlanDLL_4.00\FwdPlan.pas',
  ELMessages in 'ForwardPlanDLL_4.00\ELMessages.pas',
  ELConstants in 'ForwardPlanDLL_4.00\ELConstants.pas',
  ELFunctions in 'ForwardPlanDLL_4.00\ELFunctions.pas',
  DataStructures in 'ForwardPlanDll_3.82\DataStructures.pas',
  udmMainDLL in 'ForwardPlanDLL_4.00\UDMMAINDLL.pas' {dmMainDLL: TDataModule},
  uMainDLL in 'ForwardPlanDLL_4.00\uMainDLL.pas' {frmMainDLL};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmMainDLL, dmMainDLL);
  Application.Run;
end.
