program MasterDataSLH;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uParameters in 'uParameters.pas' {frmParameters},
  udmData in 'udmData.pas' {dmData: TDataModule},
  uDmOptimiza in '..\..\..\Optimiza\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uSelectOneLocation in '..\..\..\Optimiza\uSelectOneLocation.pas' {frmSelectOneLocation},
  uCompany in '..\..\uCompany.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TdmOptimiza, dmOptimiza);
  Application.CreateForm(TfrmSelectOneLocation, frmSelectOneLocation);
  Application.Run;
end.
