program PlaceChaseCancelDelayDevCPB;

uses
  Forms,
  uDmOptimiza in '..\..\..\..\OPTIMIZA\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uParameters in '..\uParameters.pas' {frmParameters},
  uSelectOneLocation in '..\..\..\..\Optimiza\uSelectOneLocation.pas' {frmSelectOneLocation},
  udmExport in '..\V4Code\udmExport.pas' {dmExport: TDataModule},
  uMainDLL in '..\..\..\..\OPTIMIZA\FORWARDPLANDLL_4.20\uMainDLL.pas' {frmMainDLL},
  uMainNew in '..\V4Code\uMainNew.pas' {frmMainNew},
  udmMainDLL in '..\..\..\..\OPTIMIZA\FORWARDPLANDLL_4.20\udmMainDLL.pas' {dmMainDLL: TDataModule},
  uSelectLocationList in '..\..\..\..\Optimiza\uSelectLocationList.pas' {frmSelectLocationList},
  uCompany in '..\..\..\uCompany.pas',
  FwdPlan in '..\..\..\..\Optimiza\ForwardPlanDLL_4.20\FwdPlan.pas',
  dmFwdPlanDLL in '..\..\..\..\Optimiza\ForwardPlanDLL_4.20\dmFwdPlanDLL.pas' {FwdPlanDLLDataModule: TDataModule},
  uFilter in '..\uFilter.pas' {frmFilter};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFwdPlanDLLDataModule, FwdPlanDLLDataModule);
  Application.CreateForm(TdmMainDLL, dmMainDLL);
  Application.CreateForm(TfrmMainNew, frmMainNew);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TdmExport, dmExport);
  Application.CreateForm(TfrmSelectLocationList, frmSelectLocationList);
  Application.CreateForm(TfrmFilter, frmFilter);
  Application.Run;
end.
