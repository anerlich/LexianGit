program Project1;

uses
  Forms,
  FwdPlan in '..\FwdPlan.pas',
  dmFwdPlanDLL in '..\dmFwdPlanDLL.pas' {FwdPlanDLLDataModule: TDataModule},
  TestForm in 'TestForm.pas' {Form1},
  TestDM in 'TestDM.pas' {dmTest: TDataModule},
  udmMainDLL in '..\udmMainDLL.pas' {dmMainDLL: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFwdPlanDLLDataModule, FwdPlanDLLDataModule);
  Application.CreateForm(TdmTest, dmTest);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
