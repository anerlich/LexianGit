program TestFWDDLLProject;


uses
  Forms,
  TestForm in 'TestForm.pas' {Form1},
  FwdPlan in '..\FwdPlan.pas',
  dmFwdPlanDLL in '..\dmFwdPlanDLL.pas' {FwdPlanDLLDataModule: TDataModule},
  TestDM in 'TestDM.pas' {dmTest: TDataModule};

{$R *.RES}


begin
  Application.Initialize;
  Application.CreateForm(TdmTest, dmTest);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

