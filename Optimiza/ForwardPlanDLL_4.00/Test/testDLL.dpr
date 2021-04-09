program testDLL;

uses
  Forms,
  dmFwdPlanDLL in 'dmFwdPlanDLL.pas',
  dmSVPMainDataModuleTemplate in 'DMSVPMAINDATAMODULETEMPLATE.pas' {SVPMainDataModuleTemplate: TDataModule},
  dmSVPDataModuleTemplate in 'DMSVPDATAMODULETEMPLATE.pas' {SVPDataModuleTemplate: TDataModule},
  ELMessages in 'ELMessages.pas',
  ELFunctions in 'ELFunctions.pas',
  ELConstants in 'ELConstants.pas',
  FwdPlan in 'FwdPlan.pas',
  TestForm in 'TestForm.pas' {Form1},
  TestDM in 'TestDM.pas' {dmTest: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TSVPMainDataModuleTemplate, SVPMainDataModuleTemplate);
  Application.CreateForm(TSVPDataModuleTemplate, SVPDataModuleTemplate);
  Application.CreateForm(TdmTest, dmTest);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
