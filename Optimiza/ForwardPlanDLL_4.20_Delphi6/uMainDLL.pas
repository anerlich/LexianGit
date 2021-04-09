unit uMainDLL;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils, FwdPlan,Math;

type
  TMonthlyCO = record
    PeriodCO : array [0..51] of double;
  end;

  TMonthlyDemand = record
    PeriodDemand : array [0..51] of double;
  end;

type
  TfrmMainDLL = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);

  private

  public
    { Public declarations }
    LogFile : TextFile;
    FirstShow:Boolean;
    FMonthlyDemand:TMonthlydemand;
    procedure OpenLogFile(Fname:String);
    procedure CloseLogFile;
  published

    procedure Say(Line : string);
    procedure BuildOutData(var OutData: String; FieldData: String);
    procedure SetAllParameters;
    procedure SetCalendar;
    procedure SetPOStuff;
    procedure SetCOStuff;
    procedure SetLocalFC;
    procedure SetBOMFC;
    procedure SetDRPFC;
    procedure SetMonthlyCO;
    procedure SetMonthlyDemand;
    procedure SetDemandAndLevel;

  end;

var
  frmMainDLL: TfrmMainDLL;

implementation

uses udmMainDLL;


{$R *.DFM}

procedure TfrmMainDLL.Say(Line : string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  flush(LogFile);
  Application.ProcessMessages;
end;


procedure TfrmMainDLL.FormCreate(Sender: TObject);
begin

  FirstShow := True;


end;

procedure TfrmMainDLL.BuildOutData(var OutData: String; FieldData: String);
begin

    FieldData := Trim(FieldData);

    If OutData <> '' then
      FieldData := ','+FieldData;

   OutData := OutData + FieldData;


end;

procedure TfrmMainDLL.SetAllParameters;
begin

  dmMainDll.GetConfigParams;
  dmMainDLL.CalculateWeekly := False;    //default this - most wont require weekly numbers

  //Force this param
  if dmMainDLL.Lex_IgnoreMOQMult then
  begin
    dmMainDll.FUseMult := False;
    dmMainDll.FUseMOQ := False;
  end;


end;


procedure TfrmMainDLL.SetBOMFC;
begin
  dmMainDLL.OpenDRPQuery;
  dmMainDLL.SetupBOMFC;
end;

procedure TfrmMainDLL.SetCalendar;
begin
  dmMainDLL.SetupTradingDays;

end;

procedure TfrmMainDLL.SetCOStuff;
begin
  dmMainDLL.OpenCOQuery;
  dmMainDLL.SetupCO;
end;

procedure TfrmMainDLL.SetDRPFC;
begin
  dmMainDLL.OpenDRPQuery;
  dmMainDLL.SetupDRPFC;
end;


procedure TfrmMainDLL.SetLocalFC;
begin
  dmMainDLL.SetupFC;

end;

procedure TfrmMainDLL.SetPOStuff;
begin
  dmMainDLL.OpenPOQuery;
  dmMainDLL.SetupPO;
end;

procedure TfrmMainDLL.CloseLogFile;
begin
  CloseFile(LogFile);
end;

procedure TfrmMainDLL.OpenLogFile(Fname: String);
var
  Year,Month,Day:Word;
  FCount:Integer;
begin
  FName := dmMainDLL.GetLogFileName;

  AssignFile(LogFile,FName );
  Rewrite(LogFile);

end;

procedure TfrmMainDLL.SetMonthlyCO;
begin
end;

procedure TfrmMainDLL.SetMonthlyDemand;
var
  n:Integer;
begin

    for n := 0 to dmMainDll.FParams.NoPeriodsFC do
    begin

      //Use full forecast for 1st month  (Kevin Tomaino 12-11-03)
      if n = 0 then
        FMonthlyDemand.PeriodDemand[n] := Max(dmMainDLL.MonthCO[n],dmMainDll.Lex_CurrentForecast)
      else
        FMonthlyDemand.PeriodDemand[n] := Max(dmMainDLL.MonthCO[n],dmMainDLL.MonthFC[n]);

      if dmMainDLL.FUseBOM then
      begin
        FMonthlyDemand.PeriodDemand[n] := FMonthlyDemand.PeriodDemand[n] + dmMainDLL.MonthBOM[n];
      end;

      if dmMainDLL.FUseDRP then
      begin
        FMonthlyDemand.PeriodDemand[n] := FMonthlyDemand.PeriodDemand[n] +  dmMainDLL.MonthDRP[n];
      end;

    end;

end;

procedure TfrmMainDLL.SetDemandAndLevel;
begin
end;

end.
