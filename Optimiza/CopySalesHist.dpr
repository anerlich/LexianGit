program CopySalesHist;

uses
  Forms,
  uCopySalesHist in 'uCopySalesHist.pas' {frmCopySalesHist},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmCopySalesHist in 'uDmCopySalesHist.pas' {dmCopySalesHist: TDataModule},
  uLookupProd in 'uLookupProd.pas' {frmLookupProduct},
  uStatus in 'uStatus.pas' {frmStatus};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCopySalesHist, frmCopySalesHist);
  Application.CreateForm(TdmCopySalesHist, dmCopySalesHist);
  Application.CreateForm(TfrmLookupProduct, frmLookupProduct);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
