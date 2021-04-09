program PolicyByTemplate;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  UDMOPTIMIZA in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmData in 'udmData.pas' {dmData: TDataModule},
  uSelectTemplate in 'uSelectTemplate.pas' {frmSelectTemplate},
  uSelectLocationListOpt in '..\uSelectLocationListOpt.pas' {frmSelectLocationList},
  uPolicy in 'uPolicy.pas' {frmPolicy},
  uStatus in 'uStatus.pas' {frmStatus},
  ExtEdit in 'ExtEdit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmSelectTemplate, frmSelectTemplate);
  Application.CreateForm(TfrmSelectLocationList, frmSelectLocationList);
  Application.CreateForm(TfrmPolicy, frmPolicy);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
