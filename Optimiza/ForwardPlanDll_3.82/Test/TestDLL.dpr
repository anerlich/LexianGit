program TestDLL;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  dmFPTestDLL in 'dmFPTestDLL.pas',
  TestFP in 'TestFP.pas' {frmTestFP};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmTestFP, frmTestFP);
  Application.Run;
end.
