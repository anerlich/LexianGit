program KillProcess;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uFileWait in 'uFileWait.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
