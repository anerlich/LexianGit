program UnfreezeMultipleForecast;

uses
  Forms,
  uHelp in 'uHelp.pas' {frmHelp},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmUpdateForecast in 'uDmUpdateForecast.pas' {dmUpdateForecast: TDataModule},
  uUpdateMultipleForecast in 'uUpdateMultipleForecast.pas' {frmUpdateForecast},
  uEdit in 'uEdit.pas' {frmEdit},
  uStatus in 'uStatus.pas' {frmStatus};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmUpdateForecast, frmUpdateForecast);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.CreateForm(TdmOptimiza, dmOptimiza);
  Application.CreateForm(TdmUpdateForecast, dmUpdateForecast);
  Application.CreateForm(TfrmEdit, frmEdit);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
