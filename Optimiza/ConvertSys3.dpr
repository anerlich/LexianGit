program ConvertSys3;

uses
  Forms,
  uConvertSys3 in 'uConvertSys3.pas' {Form1},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDMConvertSys3 in 'uDMConvertSys3.pas' {dmOptimiza1: TDataModule},
  uGetFilePath in '..\ACTROL\UGETFILEPATH.pas' {frmGetFilePath},
  uGetMlsysdir in 'uGetMlsysdir.pas' {frmFileName};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmFileName, frmFileName);
  Application.CreateForm(TdmOptimiza1, dmOptimiza1);
  Application.Run;
end.
