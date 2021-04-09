program CopyMultipleForecast;

uses
  Forms,
  uCopyMultipleForecast in 'uCopyMultipleForecast.pas' {frmCopyForecast},
  uHelp in 'uHelp.pas' {frmHelp},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmCopyForecast in 'uDmCopyForecast.pas' {dmCopyForecast: TDataModule},
  uStatus in 'uStatus.pas' {frmStatus};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCopyForecast, frmCopyForecast);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.CreateForm(TdmOptimiza, dmOptimiza);
  Application.CreateForm(TdmCopyForecast, dmCopyForecast);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
