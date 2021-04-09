program DataPrepare;

uses
  Forms,
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmData in 'uDmData.pas' {dmData: TDataModule},
  uMain in 'uMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
