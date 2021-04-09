program TestDLL;

uses
  Forms,
  TestForm in 'TestForm.pas' {Form1},
  udmMainDLL in 'udmMainDLL.pas' {dmMainDLL: TDataModule},
  uDmOptimiza in 'UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  udmTest in 'udmTest.pas' {dmTest: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMainDLL, dmMainDLL);
  Application.CreateForm(TdmTest, dmTest);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
