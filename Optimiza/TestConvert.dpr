program TestConvert;

uses
  Forms,
  uCnv in 'uCnv.pas' {frmConvertDBF};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmConvertDBF, frmConvertDBF);
  Application.Run;
end.
