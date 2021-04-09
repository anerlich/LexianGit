program MultipleForecastUpdate;

uses
  Forms,
  uMultipleForecastUpdate in 'uMultipleForecastUpdate.pas' {frmMultipleForecastUpdate};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMultipleForecastUpdate, frmMultipleForecastUpdate);
  Application.Run;
end.
