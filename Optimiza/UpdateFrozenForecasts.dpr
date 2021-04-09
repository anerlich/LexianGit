program UpdateFrozenForecasts;

uses
  Forms,
  uUpdateFrozenForecasts in 'uUpdateFrozenForecasts.pas' {frmFrzForecast},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmFrozenForecasts in 'uDmFrozenForecasts.pas' {dmFrozenForecast: TDataModule},
  uGetFilePath in '..\ACTROL\UGETFILEPATH.pas' {frmGetFilePath},
  uGetFrzFile in 'uGetFrzFile.pas' {frmGetFrzFile};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFrzForecast, frmFrzForecast);
  Application.CreateForm(TfrmGetFrzFile, frmGetFrzFile);
  Application.CreateForm(TdmFrozenForecast, dmFrozenForecast);
  Application.Run;
end.
