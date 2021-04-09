program RunProgram;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uParameters in 'uParameters.pas' {frmParameters},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmData in 'udmData.pas' {dmData: TDataModule},
  uSelectDayListOpt in '..\uSelectDayListOpt.pas' {frmSelectDayList};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TdmOptimiza, dmOptimiza);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmSelectDayList, frmSelectDayList);
  Application.Run;
end.
