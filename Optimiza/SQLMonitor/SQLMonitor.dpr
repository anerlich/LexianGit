program SQLMonitor;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmSQLMonitor};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSQLMonitor, frmSQLMonitor);
  Application.Run;
end.
