program ImportLTAnalysis;

uses
  Forms,
  uImportLTAnalysis in 'uImportLTAnalysis.pas' {Form1},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDMLtAnal in 'uDMLtAnal.pas' {dmLTAnal: TDataModule},
  uGetFilePath in '..\ACTROL\uGetFilePath.pas' {frmGetFilePath},
  uGetLTFile in 'uGetLTFile.pas' {frmGetLTFile},
  uLTStatus in 'uLTStatus.pas' {frmStatus};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmGetLTFile, frmGetLTFile);
  Application.CreateForm(TdmLTAnal, dmLTAnal);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
