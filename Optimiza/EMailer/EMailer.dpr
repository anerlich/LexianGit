program EMailer;

uses
  Forms,
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uMain in 'uMain.pas' {frmMain},
  uParameters in 'UPARAMETERS.pas' {frmParameters},
  udmData in 'udmData.pas' {dmData: TDataModule},
  udefault in 'udefault.pas' {frmDefault},
  uSelectSender in 'uSelectSender.pas' {frmSelectSender},
  uSelectUser in 'uSelectUser.pas' {frmSelectUser},
  uRecipient in 'uRecipient.pas' {frmRecipient},
  uMessage in 'uMessage.pas' {frmMessage},
  uFileWait in 'uFileWait.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmDefault, frmDefault);
  Application.CreateForm(TfrmSelectSender, frmSelectSender);
  Application.CreateForm(TfrmSelectUser, frmSelectUser);
  Application.CreateForm(TfrmRecipient, frmRecipient);
  Application.CreateForm(TfrmMessage, frmMessage);
  Application.Run;
end.
