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
    FCalendarNo:Integer;
    FCurrentForecast:Double;

    //Overrides
    FIgnoreMOQMult:Boolean;
    FCalcAsNonStock:Boolean;
    FUseBom:Boolean;
    FUseDrp:Boolean;
    procedure Say(Line : string);
    procedure OpenLogFile(Fname:String);
    procedure CloseLogFile;
  published
    procedure BuildOutData(var OutData: String; FieldData: String);
    procedure SetAllParameters;
    procedure SetCalendar;
    procedure SetItemStuff;
    procedure SetPOStuff;
    procedure SetCOStuff;
    procedure SetLocalFC;
    procedure SetBOMFC;
    procedure SetDRPFC;
    procedure SetMonthlyCO;
    procedure SetMonthlyDemand;
    procedure SetDailyPO(DownDate:TDateTime);
    procedure SetDemandAndLevel;
    procedure SetDownloadDateAdjustment;
    function BuildCalendar: Integer;

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
  Application.ProcessMessages;
end;


procedure TfrmMainDLL.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  FIgnoreMOQMult := False;
  FUseBom := False;
  FUseDrp := False;
  FCalcAsNonStock:= False;
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

  //Overides ? here ???
  if FIgnoreMOQMult then
  begin
    dmMainDll.FUseMult := False;
    dmMainDll.FUseMOQ := False;
  end;

  FCalendarNo := dmMainDLL.FCurrentPeriod;


end;


procedure TfrmMainDLL.SetBOMFC;
begin
  dmMainDLL.OpenDRPQuery;
  dmMainDLL.SetupBOMFC;
end;

procedure TfrmMainDLL.SetCalendar;
begin
  dmMainDLL.SetupTradingDays;
  SetDownloadDateAdjustment;

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

procedure TfrmMainDLL.SetItemStuff;
begin

  with dmMainDLL do begin
    ItemNo := dmMainDll.getItemData.FieldByName('ITEMNO').AsInteger;
    SalesToDate   := dmMainDll.getItemData.FieldByName('S0').AsFloat;

    if FCalcAsNonStock then
      Stocked := False
    else
      Stocked := dmMainDll.getItemData.FieldByName('StockingIndicator').AsString = 'Y';

    Pareto  := dmMainDll.getItemData.FieldByName('ParetoCategory').AsString[1];

    SSDays        := Trunc(dmMainDll.getItemData.FieldByName('SAFETYSTOCK').AsFloat * FNoDaysInPeriod);
    RCDays        := Trunc(dmMainDll.getItemData.FieldByName('REPLENISHMENTCYCLE').AsFloat * FNoDaysInPeriod);
    RPDays        := Trunc(dmMainDll.getItemData.FieldByName('REVIEWPERIOD').AsFloat * FNoDaysInPeriod);
    LTDays        := Trunc(dmMainDll.getItemData.FieldByName('LEADTIME').AsFloat * FNoDaysInPeriod);
    SSLTDays      := SSDays + LTDays;
    SSRCDays      := SSDays + RCDays;
    SSHalfRCDays  := SSDays + trunc(RCDays/2);
    SSRPDays      := SSDays + RPDays;
    SSLTRPDays    := SSDays + LTDays + RPDays;
    SSLTRCDays    := SSDays + LTDays + RCDays;

    TransitLTDays := Trunc(dmMainDll.getItemData.FieldByName('TransitLT').AsFloat * FNoDaysInPeriod);
    SOH           := Trunc(dmMainDll.getItemData.FieldByName('STOCKONHAND').AsFloat);
    BO            := Trunc(dmMainDll.getItemData.FieldByName('BACKORDER').AsFloat);
    CBO           := Trunc(dmMainDll.getItemData.FieldByName('CONSOLIDATEDBRANCHORDERS').AsFloat);
    Bin           := Trunc(dmMainDll.getItemData.FieldByName('BINLEVEL').AsFloat);
    MOQ           := Trunc(dmMainDll.getItemData.FieldByName('MINIMUMORDERQUANTITY').AsFloat);
    Mult          := Trunc(dmMainDll.getItemData.FieldByName('ORDERMULTIPLES').AsFloat);
    Min           := Trunc(dmMainDll.getItemData.FieldByName('ABSOLUTEMINIMUMQUANTITY').AsFloat);


    if not dmMainDll.getItemData.FieldByName('BACKORDERRATIO').IsNull then
      FFCRAtio := dmMainDll.getItemData.FieldByName('BACKORDERRATIO').AsFloat
    else
      FFCRatio := FConfigFCRatio;


    if not dmMainDll.getItemData.FieldByName('BOMBACKORDERRATIO').IsNull then
      FBOMRatio := dmMainDll.getItemData.FieldByName('BOMBACKORDERRATIO').AsFloat
    else
      FBOMRatio := FConfigBOMRatio;

    if not dmMainDll.getItemData.FieldByName('DRPBACKORDERRATIO').IsNull then
      FDRPRatio := dmMainDll.getItemData.FieldByName('DRPBACKORDERRATIO').AsFloat
    else
      FDRPRatio := FConfigDRPRatio;

    UseStockBuild := dmMainDll.getItemData.FieldByName('STOCK_BUILDNO').AsInteger > 0 ;

    if UseStockBuild then begin
      BuildStartDate := dmMainDll.getItemData.FieldByName('START_BUILD').AsDateTime;
      ShutdownStart := dmMainDll.getItemData.FieldByName('START_SHUTDOWN').AsDateTime;
      ShutdownEnd := dmMainDll.getItemData.FieldByName('END_SHUTDOWN').AsDateTime;
      OrdersDuringShutdown := dmMainDll.getItemData.FieldByName('ORDERS_DURING_SHUTDOWN').asString='Y';
    end;


    UseFixedLevels := False;
    if UseFixedLevels then begin
      //FixedSS := StrToInt(edtFixedSS.Text);
      //FixedSSRC := StrToInt(edtFixedSSRC.Text);
    end;

    CalcIdealArrival := dmMainDll.getItemData.FieldByName('CALC_IDEAL_ARRIVAL_DATE').AsString = 'Y';

    StockOnOrder := dmMainDll.getItemData.FieldByName('STOCKONORDER').AsInteger;
    StockOnOrderOther := dmMainDll.getItemData.FieldByName('STOCKONORDER_OTHER').AsInteger;
    StockOnOrderInLT := dmMainDll.getItemData.FieldByName('STOCKONORDERINLT').AsInteger;
    StockOnOrderInLTOther := dmMainDll.getItemData.FieldByName('STOCKONORDERINLT_OTHER').AsInteger;

    ProductCode := dmMainDll.getItemData.FieldByName('PRODUCTCODE').AsString;
    LocationCode := dmMainDll.getItemData.FieldByName('LOCATIONCODE').AsString;

  end;

  dmMainDll.LoadConfigParams;  // Some params need to be reset
  dmMainDll.LoadItemParams;
  BuildCalendar;  // Item specific based on LT and other policy ???

end;

procedure TfrmMainDLL.SetLocalFC;
begin
  dmMainDLL.OpenFCQuery(FCalendarNo);
  dmMainDLL.SetupFC;
  FCurrentForecast := dmMainDLL.FFC.Arr[0];

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
  FName := ExtractFileName(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.exe','');
  DecodeDate(Now, Year, Month, Day);
  FName := Format('%d%d%d '+FName+'.log', [Year, Month, Day]);

  for FCount := 1 to 100 do
  begin

    If FileExists(FName) then
    begin

      if FCount = 1 then
        FName := AnsiReplaceStr(FName,'.log',IntToStr(FCount)+'.log')
      else
        FName := AnsiReplaceStr(FName,IntToStr(FCount-1)+'.log',IntToStr(FCount)+'.log');


    end
    else
      Break;

  end;


  AssignFile(LogFile,FName );
  Rewrite(LogFile);

end;

procedure TfrmMainDLL.SetMonthlyCO;
begin
end;

procedure TfrmMainDLL.SetDailyPO(DownDate:TDateTime);
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
        FMonthlyDemand.PeriodDemand[n] := Max(dmMainDLL.MonthCO[n],FCurrentForecast)
      else
        FMonthlyDemand.PeriodDemand[n] := Max(dmMainDLL.MonthCO[n],dmMainDLL.MonthFC[n]);

      //Overides?
      if FUseBOM then
      begin
        FMonthlyDemand.PeriodDemand[n] := FMonthlyDemand.PeriodDemand[n] + dmMainDLL.MonthBOM[n];
      end;

      if FUseDRP then
      begin
        FMonthlyDemand.PeriodDemand[n] := FMonthlyDemand.PeriodDemand[n] +  dmMainDLL.MonthDRP[n];
      end;

    end;

end;

procedure TfrmMainDLL.SetDemandAndLevel;
begin

  with dmMainDLL do
  begin
    FParams.FWDPODays := Trunc(FParams.FWDPOPercentage * FParams.LTDays);

    LoadDemand(FFP, FFC, FCO, FBOM, FDRP, FPO, FParams);

    if (FParams.ZeroNegStock) and (FParams.SOH < 0) then
      FParams.SOH := 0;

    FParams.Level := FParams.SOH - FParams.BO - FParams.CBO + OverPO;
  end;

end;

procedure TfrmMainDLL.SetDownloadDateAdjustment;
begin

  with dmMainDLL do
  begin

    FAdjustedDownloadDateStart := False;
    FAdjustedDownloadDateEnd := False;

    qryCalendar.Open;

    qryCalendar.First;
    if trunc(FStockDownloadDate) < trunc(qryCalendar.FieldByName('STARTDATE').AsDateTime) then begin
      FStockDownloadDate := trunc(qryCalendar.FieldByName('STARTDATE').AsDateTime);
      FAdjustedDownloadDateStart := True;
    end;
    if trunc(FStockDownloadDate) > trunc(qryCalendar.FieldByName('ENDDATE').AsDateTime) then begin
      FStockDownloadDate := trunc(qryCalendar.FieldByName('ENDDATE').AsDateTime);
      FAdjustedDownloadDateEnd := True;
    end;

  end;

end;

function TfrmMainDLL.BuildCalendar: Integer;
var
  NoDays:Integer;
begin

  with dmMainDLL do
  begin

    NoDays := (FNoPeriodsFC * FNoDaysInPeriod) + (FParams.LTDays + FParams.SSDays + FParams.RCDays);

    if NoDays > MAX_DAYS_ARRAY_SIZE then
      NoDays := MAX_DAYS_ARRAY_SIZE;

    FFP.Cnt := NoDays;
    Result := MakeCal(FFP, FCal, FFact, FParams);
  end;

end;

end.
