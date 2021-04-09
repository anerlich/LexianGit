program SearchScript;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uParameters in 'uParameters.pas' {frmParameters};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParameters, frmParameters);
  Application.Run;
end.
