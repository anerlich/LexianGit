program RunScript;

uses
  Forms,
  uRunScript in 'uRunScript.pas' {frmRunScript},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmRunScript in 'udmRunScript.pas' {dmRunScript: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmRunScript, frmRunScript);
  Application.CreateForm(TdmRunScript, dmRunScript);
  Application.Run;
end.
