program ImportExcel;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uParameters in 'uParameters.pas' {frmParameters},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmDataImport in 'uDmDataImport.pas' {dmDataImport: TDataModule},
  uExelManip in 'uExelManip.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TdmDataImport, dmDataImport);
  Application.Run;
end.
