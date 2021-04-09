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
    FIgnoreMOQMult:Boolean;
    FMonthlyDemand:TMonthlydemand;
    FCurrentForecast:Double;
    FCalcAsNonStock:Boolean;
    {NewCal : array [0..150] of TCalendarEntry;
    NewPO : array [0..2000] of TPurchaseOrderEntry;
    NewCO : array [0..2000] of TCustomerOrderEntry;
    COByDay: array[0..342] of TCustomerOrderDetail;}
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
  dmMainDLL.FDailyCO :=False;

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

  //Force this param
  if FIgnoreMOQMult then
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
  dmMainDll.SetDownloadDateAdjustment;
  
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
    ItemNo := dmMainDll.GetItemData.FieldByName('ITEMNO').AsInteger;
    SalesToDate   := dmMainDll.GetItemData.FieldByName('S0').AsFloat;

    if FCalcAsNonStock then
      Stocked := False
    else
      Stocked := dmMainDll.GetItemData.FieldByName('StockingIndicator').AsString = 'Y';

    Pareto  := dmMainDll.GetItemData.FieldByName('ParetoCategory').AsString[1];

    SSDays        := Trunc(dmMainDll.GetItemData.FieldByName('SAFETYSTOCK').AsFloat * FNoDaysInPeriod);
    RCDays        := Trunc(dmMainDll.GetItemData.FieldByName('REPLENISHMENTCYCLE').AsFloat * FNoDaysInPeriod);
    RPDays        := Trunc(dmMainDll.GetItemData.FieldByName('REVIEWPERIOD').AsFloat * FNoDaysInPeriod);
    LTDays        := Trunc(dmMainDll.GetItemData.FieldByName('LEADTIME').AsFloat * FNoDaysInPeriod);
    SSLTDays      := SSDays + LTDays;
    SSRCDays      := SSDays + RCDays;
    SSHalfRCDays  := SSDays + trunc(RCDays/2);
    SSRPDays      := SSDays + RPDays;
    SSLTRPDays    := SSDays + LTDays + RPDays;
    SSLTRCDays    := SSDays + LTDays + RCDays;

    TransitLTDays := Trunc(dmMainDll.GetItemData.FieldByName('TransitLT').AsFloat * FNoDaysInPeriod);
    SOH           := Trunc(dmMainDll.GetItemData.FieldByName('STOCKONHAND').AsFloat);
    BO            := Trunc(dmMainDll.GetItemData.FieldByName('BACKORDER').AsFloat);
    CBO           := Trunc(dmMainDll.GetItemData.FieldByName('CONSOLIDATEDBRANCHORDERS').AsFloat);
    Bin           := Trunc(dmMainDll.GetItemData.FieldByName('BINLEVEL').AsFloat);
    MOQ           := Trunc(dmMainDll.GetItemData.FieldByName('MINIMUMORDERQUANTITY').AsFloat);
    Mult          := Trunc(dmMainDll.GetItemData.FieldByName('ORDERMULTIPLES').AsFloat);
    Min           := Trunc(dmMainDll.GetItemData.FieldByName('ABSOLUTEMINIMUMQUANTITY').AsFloat);


    if not dmMainDll.GetItemData.FieldByName('BACKORDERRATIO').IsNull then
      FFCRAtio := dmMainDll.GetItemData.FieldByName('BACKORDERRATIO').AsFloat
    else
      FFCRatio := FConfigFCRatio;


    if not dmMainDll.GetItemData.FieldByName('BOMBACKORDERRATIO').IsNull then
      FBOMRatio := dmMainDll.GetItemData.FieldByName('BOMBACKORDERRATIO').AsFloat
    else
      FBOMRatio := FConfigBOMRatio;

    if not dmMainDll.GetItemData.FieldByName('DRPBACKORDERRATIO').IsNull then
      FDRPRatio := dmMainDll.GetItemData.FieldByName('DRPBACKORDERRATIO').AsFloat
    else
      FDRPRatio := FConfigDRPRatio;

    UseStockBuild := dmMainDll.GetItemData.FieldByName('STOCK_BUILDNO').AsInteger > 0 ;

    if UseStockBuild then begin
      BuildStartDate := dmMainDll.GetItemData.FieldByName('START_BUILD').AsDateTime;
      ShutdownStart := dmMainDll.GetItemData.FieldByName('START_SHUTDOWN').AsDateTime;
      ShutdownEnd := dmMainDll.GetItemData.FieldByName('END_SHUTDOWN').AsDateTime;
      OrdersDuringShutdown := dmMainDll.GetItemData.FieldByName('ORDERS_DURING_SHUTDOWN').asString='Y';
    end;


    UseFixedLevels := False;
    if UseFixedLevels then begin
      //FixedSS := StrToInt(edtFixedSS.Text);
      //FixedSSRC := StrToInt(edtFixedSSRC.Text);
    end;

    CalcIdealArrival := dmMainDll.GetItemData.FieldByName('CALC_IDEAL_ARRIVAL_DATE').AsString = 'Y';

    StockOnOrder := dmMainDll.GetItemData.FieldByName('STOCKONORDER').AsInteger;
    StockOnOrderOther := dmMainDll.GetItemData.FieldByName('STOCKONORDER_OTHER').AsInteger;
    StockOnOrderInLT := dmMainDll.GetItemData.FieldByName('STOCKONORDERINLT').AsInteger;
    StockOnOrderInLTOther := dmMainDll.GetItemData.FieldByName('STOCKONORDERINLT_OTHER').AsInteger;

    ProductCode := dmMainDll.GetItemData.FieldByName('PRODUCTCODE').AsString;
    LocationCode := dmMainDll.GetItemData.FieldByName('LOCATIONCODE').AsString;

  end;

  dmMainDll.LoadConfigParams;  // Some params need to be reset
  dmMainDll.LoadItemParams;
  dmMainDll.BuildCalendar;  // Item specific based on LT and other policy ???

end;

procedure TfrmMainDLL.SetLocalFC;
begin
  dmMainDLL.OpenFCQuery;
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
        FMonthlyDemand.PeriodDemand[n] := Max(dmMainDLL.MonthCO[n],dmMainDLL.MonthFCIn[n]);

      if dmMainDLL.FParams.UseBOM then
      begin
        FMonthlyDemand.PeriodDemand[n] := FMonthlyDemand.PeriodDemand[n] + dmMainDLL.MonthBOM[n];
      end;

      if dmMainDLL.FParams.UseDRP then
      begin
        FMonthlyDemand.PeriodDemand[n] := FMonthlyDemand.PeriodDemand[n] +  dmMainDLL.MonthDRP[n];
      end;

    end;

end;

procedure TfrmMainDLL.SetDemandAndLevel;
begin
  dmMainDll.LoadDemandAndLevel;
end;

end.
