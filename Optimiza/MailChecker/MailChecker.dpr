program MailChecker;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uEdit in 'uEdit.pas' {frmEdit},
  uStatus in 'uStatus.pas' {frmStatus},
  uDmData in 'uDmData.pas' {dmData: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmEdit, frmEdit);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.CreateForm(TdmData, dmData);
  Application.Run;
end.
