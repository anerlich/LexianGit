program PolicyByPareto;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmPolicyByPareto in 'udmPolicyByPareto.pas' {dmPolicyByPareto: TDataModule},
  uStatus in 'uStatus.pas' {frmStatus},
  uSelectOneLocation in '..\uSelectOneLocation.pas' {frmSelectOneLocation};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSelectOneLocation, frmSelectOneLocation);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.CreateForm(TdmPolicyByPareto, dmPolicyByPareto);
  Application.Run;
end.
