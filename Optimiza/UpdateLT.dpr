program UpdateLT;

uses
  Forms,
  uUpdateLT in 'uUpdateLT.pas' {frmUpdateLT},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmUpdateLT in 'uDmUpdateLT.pas' {dmUpdateLT: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmUpdateLT, frmUpdateLT);
  Application.CreateForm(TdmUpdateLT, dmUpdateLT);
  Application.Run;
end.
