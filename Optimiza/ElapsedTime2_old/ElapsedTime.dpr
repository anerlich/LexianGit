program ElapsedTime;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uScanSelect in 'uScanSelect.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
