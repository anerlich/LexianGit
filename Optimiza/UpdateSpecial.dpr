program UpdateSpecial;

uses
  Forms,
  uUpdateSpecial in 'uUpdateSpecial.pas' {Form1},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmUpdateSpecial in 'uDmUpdateSpecial.pas' {dmUpdateSpecial: TDataModule},
  uStatus in 'uStatus.pas' {frmStatus},
  uGroup in 'uGroup.pas' {frmGroup},
  uAndOr in 'uAndOr.pas' {frmAndOr},
  uAbout in 'uAbout.pas' {frmAbout},
  uAddRec in 'uAddRec.pas' {frmAddRec},
  uProducts in 'uProducts.pas' {frmProducts};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmUpdateSpecial, dmUpdateSpecial);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.CreateForm(TfrmGroup, frmGroup);
  Application.CreateForm(TfrmAndOr, frmAndOr);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmAddRec, frmAddRec);
  Application.CreateForm(TfrmProducts, frmProducts);
  Application.Run;
end.
