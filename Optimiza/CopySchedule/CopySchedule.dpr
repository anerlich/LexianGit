program CopySchedule;

uses
  Forms,
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmCopySchedule in 'o:\Optimiza\CopySchedule\uDmCopySchedule.pas' {dmCopySchedule: TDataModule},
  uCopySchedule in 'o:\Optimiza\CopySchedule\uCopySchedule.pas' {frmCopySchedule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmCopySchedule, dmCopySchedule);
  Application.CreateForm(TfrmCopySchedule, frmCopySchedule);
  Application.Run;
end.
