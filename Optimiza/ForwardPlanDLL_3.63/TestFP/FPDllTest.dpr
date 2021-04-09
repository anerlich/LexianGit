program FPDllTest;

uses
  ShareMem,
  Forms,
  TestFP in 'TestFP.pas' {frmTestFP},
  dmSVPDataModuleTemplate in 'DMSVPDATAMODULETEMPLATE.pas' {SVPDataModuleTemplate: TDataModule},
  dmFPTestDLL in 'dmFPTestDLL.pas' {FPTestDLLDatamodule: TDataModule},
  DataStructures in 'DataStructures.pas',
  frmDialogTemplate in '..\optimiza\FRMDIALOGTEMPLATE.pas' {DialogTemplate},
  frmAuthenticate in '..\optimiza\frmAuthenticate.pas' {Authenticate},
  DMSVPMAINDATAMODULETEMPLATE in '..\TEMPLATES\DMSVPMAINDATAMODULETEMPLATE.pas' {SVPMainDataModuleTemplate: TDataModule},
  dmSVPMain in '..\optimiza\dmSVPMain.pas' {SVPMainDataModule: TDataModule},
  ELMessages in '..\optimiza\ELMessages.pas',
  uTermsReplacer in '..\optimiza\uTermsReplacer.pas',
  HtmlHlp in '..\optimiza\HtmlHlp.pas',
  ELConstants in '..\optimiza\ELConstants.pas',
  uTemplateSQL in '..\optimiza\uTemplateSQL.pas',
  uAuthenticate in '..\Authenticate\uAuthenticate.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSVPMainDataModuleTemplate, SVPMainDataModuleTemplate);
  Application.CreateForm(TSVPDataModuleTemplate, SVPDataModuleTemplate);
  Application.CreateForm(TFPTestDLLDatamodule, FPTestDLLDatamodule);
  Application.CreateForm(TfrmTestFP, frmTestFP);
  Application.CreateForm(TDialogTemplate, DialogTemplate);
  Application.CreateForm(TSVPMainDataModule, SVPMainDataModule);
  Application.Run;
end.
