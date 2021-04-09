program DiagLoad;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uDmOptimiza in '..\UDMOPTIMIZA.pas' {dmOptimiza: TDataModule},
  uDmData in 'uDmData.pas' {dmData: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmData, dmData);
  Application.Run;
end.
