program Project1;

uses
  Forms,
  uStandardMain in 'uStandardMain.pas' {frmStandardMain},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uAbout in '..\uAbout.pas' {frmAbout};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmStandardMain, frmStandardMain);
  Application.CreateForm(TdmOptimiza, dmOptimiza);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
