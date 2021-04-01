program PlaceChaseCancelDelayPB;

uses
  Forms,
  uDmOptimiza in '..\..\..\..\OPTIMIZA\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uParameters in '..\uParameters.pas' {frmParameters},
  uSelectOneLocation in '..\..\..\..\Optimiza\uSelectOneLocation.pas' {frmSelectOneLocation},
  udmExport in '..\udmExport.pas' {dmExport: TDataModule},
  uMainDLL in '..\..\..\..\OPTIMIZA\FORWARDPLANDLL_3.64\uMainDLL.pas' {frmMainDLL},
  uMainNew in '..\uMainNew.pas' {frmMainNew},
  udmMainDLL in '..\..\..\..\OPTIMIZA\FORWARDPLANDLL_3.64\UDMMAINDLL.pas' {dmMainDLL: TDataModule},
  uSelectLocationList in '..\..\..\..\Optimiza\uSelectLocationList.pas' {frmSelectLocationList},
  uCompany in '..\..\..\uCompany.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMainDLL, dmMainDLL);
  Application.CreateForm(TfrmMainNew, frmMainNew);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TfrmSelectOneLocation, frmSelectOneLocation);
  Application.CreateForm(TdmExport, dmExport);
  Application.CreateForm(TfrmSelectLocationList, frmSelectLocationList);
  Application.Run;
end.
