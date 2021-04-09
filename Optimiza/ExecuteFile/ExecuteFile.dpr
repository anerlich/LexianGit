program ExecuteFile;

uses
  Forms,
  uExecuteFile in 'uExecuteFile.pas' {frmExecuteFile};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmExecuteFile, frmExecuteFile);
  Application.Run;
end.
