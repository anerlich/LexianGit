program PlaceChaseCancelDelayPB;

uses
  Forms,
  uDmOptimiza in '..\..\..\..\OPTIMIZA\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uParameters in '..\uParameters.pas' {frmParameters},
  uSelectOneLocation in '..\..\..\..\Optimiza\uSelectOneLocation.pas' {frmSelectOneLocation},
  udmExport in '..\V4Code\udmExport.pas' {dmExport: TDataModule},
  uMainDLL in '..\..\..\..\OPTIMIZA\FORWARDPLANDLL_4.04\uMainDLL.pas' {frmMainDLL},
  uMainNew in '..\V4Code\uMainNew.pas' {frmMainNew},
  udmMainDLL in '..\..\..\..\OPTIMIZA\FORWARDPLANDLL_4.04\udmMainDLL.pas' {dmMainDLL: TDataModule},
  uSelectLocationList in '..\..\..\..\Optimiza\uSelectLocationList.pas' {frmSelectLocationList},
  uCompany in '..\..\..\uCompany.pas',
  FwdPlan in '..\..\..\..\Optimiza\ForwardPlanDLL_4.04\FwdPlan.pas';

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
