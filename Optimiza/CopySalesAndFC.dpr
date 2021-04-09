program CopySalesAndFC;

uses
  Forms,
  uSaleAndFC in 'uSaleAndFC.pas' {frmCopySaleAndFC},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmSaleAndFC in 'uDmSaleAndFC.pas' {dmCopySaleAndFC: TDataModule},
  uStatus in 'uStatus.pas' {frmStatus};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCopySaleAndFC, frmCopySaleAndFC);
  Application.CreateForm(TdmCopySaleAndFC, dmCopySaleAndFC);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
