program SearchDB;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmOptimiza, dmOptimiza);
  Application.Run;
end.
