program ImportLeadTimeAnalysis;

uses
  Forms,
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uMain in 'uMain.pas' {frmMain},
  uParameters in 'uParameters.pas' {frmParameters},
  uSelectOneLocation in '..\uSelectOneLocation.pas' {frmSelectOneLocation},
  udmImport in 'udmImport.pas' {dmImport: TDataModule},
  uFieldSetup in 'uFieldSetup.pas' {frmFieldSetup},
  uFieldSelect in 'uFieldSelect.pas' {frmFieldSelect},
  uSetAppend in 'uSetAppend.pas' {frmSetAppend};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TfrmSelectOneLocation, frmSelectOneLocation);
  Application.CreateForm(TdmImport, dmImport);
  Application.CreateForm(TfrmFieldSetup, frmFieldSetup);
  Application.CreateForm(TfrmFieldSelect, frmFieldSelect);
  Application.CreateForm(TfrmSetAppend, frmSetAppend);
  Application.Run;
end.
