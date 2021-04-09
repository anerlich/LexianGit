unit uMainDLL;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils, DataStructures,Math;

function GetRecommendedOrders(EnginePointer : Pointer;
                              LocationParams : PLocationParams;
                              ItemParams : PItemParams;
                              PurchaseOrder : PPurchaseOrder;
                              CustomerOrder : PCustomerOrder;
                              LocalForecast : PForecast;
                              BOMForecast : PForecast;
                              DRPForecast : PForecast;
                              RecommendedOrders : PRecommendedOrders;
                              OpeningStock : POpeningStock;
                              CalculatedReceipts : PCalculatedReceipts;
                              BackOrders : PBackOrders;
                              CumLostSales : PCumLostSales;
                              Excess : PExcess) : integer; stdcall; external 'OptimizaFP.DLL';
function InitialiseEngine(var EnginePointer : Pointer;
                          LocationParams : PLocationParams;
                          Calendar : PCalendar) : integer; stdcall; external 'OptimizaFP.DLL';
function FinaliseEngine(EnginePointer : Pointer) : integer; stdcall; external 'OptimizaFP.DLL';

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
    FNoPeriodsToFC : integer;
    FCurrentPeriod : integer;
    FLocationParams : TLocationParams;
    FCalendar : TCalendar;
    FItemParams : TItemParams;
    FPurchaseOrder : TPurchaseOrder;
    FCustomerOrder : TCustomerOrder;
    FMonthlyCO:TMonthlyCo;
    FMonthlyDemand:TMonthlyDemand;
    FLocalForecast : TForecast;
    FBOMForecast : TForecast;
    FDRPForecast : TForecast;
    FCurrentForecast:Real;
    FRecommendedOrders : TRecommendedOrders;
    FDailyPurchaseOrders : TDailyPurchaseOrders;
    FOpeningStock : TOpeningStock;
    FCalculatedReceipts : TCalculatedReceipts;
    FBackOrders : TBackOrders;
    FCumLostSales : TCumLostSales;
    FExcess : TExcess;
    FIgnoreMOQMult:Boolean;
    FDailyCO:Boolean;
    FPareto : String;
    FSystemWeeks:String;
    FOrdersDuringShutdown : String;
    NewCal : array [0..150] of TCalendarEntry;
    NewPO : array [0..2000] of TPurchaseOrderEntry;
    NewCO : array [0..2000] of TCustomerOrderEntry;
    COByDay: array[0..342] of TCustomerOrderDetail;
    PercentUnsatisfiedOrdersBackOrdered:Double;
    
    g_sExcessUses,
    g_sUseMOQ,
    g_sTypeOfOrdering,
    g_sRoundMOQ,
    g_sRoundMult,
    g_sTypeOfSimulation,
    g_sUseOfCustomerOrders,
    g_sOverdueCustomerOrderDate,
    g_sLocalMonthFactorMode,
    g_sBOMMonthFactorMode,
    g_sDRPMonthFactorMode,
    g_sBOMFillMode,
    g_sCustomerOrdersOverride,
    g_sOverdueCustomerOrdersImport,
    g_sUseBOM,
    g_sUseDRP,
    g_sUseDRPBackOrders,
    g_sUseMult,
    g_sTreatNegativeStockAsZero,
    g_sApplyBackorderPercentToDependantForecasts,
    g_sBackOrderAllCustomerOrders,
    g_sIgnoreCustomerOrdersForSafetyStock,
    g_sUseDependantForecastsForSafetyStock,
    g_sForceDailyReviewPeriod,
    g_sUseMOQplusBinLevelForExcess : String;
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

  end;

var
  frmMainDLL: TfrmMainDLL;

  const
    _ExcessUses	        = 195;
    _UseMOQ	        = 184;
    _TypeOfOrdering     = 189;
    _RoundMOQ	        = 185;
    _RoundMult	        = 187;
    _TypeOfSimulation	= 188;
    _UseOfCustomerOrders	= 198;
    _OverdueCustomerOrderDate	= 153;
    _LocalMonthFactorMode	= 191;
    _BOMMonthFactorMode	        = 205;
    _DRPMonthFactorMode  	= 207;
    _BOMFillMode         	= 204;
    _CustomerOrdersOverride	        = 199;
    _OverdueCustomerOrdersImport	= 152;
    _UseBOM	                        = 203;
    _UseDRP	                        = 206;
    _UseDRPBackOrders            	= 232;
    _UseMult	                        = 186;
    _TreatNegativeStockAsZero	        = 190;
    _ApplyBackOrderPercentToDependantForecasts	= 197;
    _BackOrderAllCustomerOrders	                = 201;
    _IgnoreCustomerOrdersForSafetyStock	        = 202;
    _UseDependantForecastsForSafetyStock	= 196;
    _ForceDailyReviewPeriod             	= 285;
    _NoPeriodsForecast	                        = 101;
    _MaxForwardCover                    	= 264;
    _NumberofPeriodsInYear               	= 236;
    _PeriodsForAverageForecast          	= 193;
    _PercentUnsatisfiedOrdersBackOrdered	= 124;
    _StockDownloadDate                  	= 104;
    _AddPercToLTFence                   	= 188;
    _OrderThreshold                      	= 296;
    _DaysInPer                                  = 102;

    _ExportParams      =	'N';
    _ExportResults     =	'N';
    _ShowErrorMessage  =	'N';


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
  FIgnoreMOQMult:=False;
  FSystemWeeks:='M';
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
  FDailyCo := False;

  FLocationParams.ExportParams := 'N';
  FLocationParams.ExportResults := 'N';
  FLocationParams.ShowErrorMessage := 'N';
  FCurrentPeriod := dmMainDLL.GetConfigAsInteger(100);
  FNoPeriodsToFC := dmMainDLL.GetConfigAsInteger(101) - 1;
  FLocationParams.NoPeriodsForecast := FNoPeriodsToFC;
  FLocationParams.MaxForwardCover := trunc(dmMainDLL.GetConfigAsFloat(264)) + 1;

  g_sExcessUses := dmMainDLL.GetConfigAsString(195);
  FLocationParams.ExcessUses := PChar(g_sExcessUses);
   //Force this param
  if FIgnoreMOQMult then
    g_sUseMOQ :=  'N'
  else
  begin
    g_sUseMOQ := dmMainDLL.GetConfigAsString(184);
  end;

  FLocationParams.UseMOQ := PChar(g_sUseMOQ);

  g_sTypeOfOrdering := dmMainDLL.GetConfigAsString(189);
  FLocationParams.TypeOfOrdering := PChar(g_sTypeOfOrdering);

  g_sRoundMOQ := dmMainDLL.GetConfigAsString(185);
  FLocationParams.RoundMOQ := PChar(g_sRoundMOQ);

  g_sRoundMult := dmMainDLL.GetConfigAsString(187);
  FLocationParams.RoundMult := PChar(g_sRoundMult);

  g_sTypeOfSimulation := dmMainDLL.GetConfigAsString(188);
  FLocationParams.TypeOfSimulation := PChar(g_sTypeOfSimulation);

  g_sUseOfCustomerOrders := dmMainDLL.GetConfigAsString(198);
  FLocationParams.UseOfCustomerOrders := PChar(g_sUseOfCustomerOrders);

  g_sOverdueCustomerOrderDate :=  dmMainDLL.GetConfigAsString(153);
  FLocationParams.OverdueCustomerOrderDate := PChar(g_sOverdueCustomerOrderDate);

  g_sLocalMonthFactorMode := dmMainDLL.GetConfigAsString(191);
  FLocationParams.LocalMonthFactorMode := PChar(g_sLocalMonthFactorMode);

  g_sBOMMonthFactorMode := dmMainDLL.GetConfigAsString(205);
  FLocationParams.BOMMonthFactorMode := PChar(g_sBOMMonthFactorMode);

  g_sDRPMonthFactorMode := dmMainDLL.GetConfigAsString(207);
  FLocationParams.DRPMonthFactorMode := PChar(g_sDRPMonthFactorMode);

  g_sBOMFillMode :=  dmMainDLL.GetConfigAsString(204);
  FLocationParams.BOMFillMode := PChar(g_sBOMFillMode);

  g_sCustomerOrdersOverride := dmMainDLL.GetConfigAsString(199);
  FLocationParams.CustomerOrdersOverride := PChar(g_sCustomerOrdersOverride);

  g_sOverdueCustomerOrdersImport :=  dmMainDLL.GetConfigAsString(152);
  FLocationParams.OverdueCustomerOrdersImport := PChar(g_sOverdueCustomerOrdersImport);

  g_sUseBOM := dmMainDLL.GetConfigAsString(203);
  FLocationParams.UseBOM := PChar(g_sUseBOM);

  g_sUseDRP := dmMainDLL.GetConfigAsString(206);
  FLocationParams.UseDRP := PChar(g_sUseDRP);

  g_sUseDRPBackOrders := dmMainDLL.GetConfigAsString(232);
  FLocationParams.UseDRPBackOrders := PChar(g_sUseDRPBackOrders);

  //Force this param
  if FIgnoreMOQMult then
    g_sUseMult :=  'N'
  else
  begin
    g_sUseMult := dmMainDLL.GetConfigAsString(186);
  end;

  FLocationParams.UseMult := PChar(g_sUseMult);

  g_sTreatNegativeStockAsZero :=  dmMainDLL.GetConfigAsString(190);
  FLocationParams.TreatNegativeStockAsZero := PChar(g_sTreatNegativeStockAsZero);

  FLocationParams.ApplyBackOrderPercentToDependantForecasts := 'Y';

  g_sBackOrderAllCustomerOrders := dmMainDLL.GetConfigAsString(201);
  FLocationParams.BackOrderAllCustomerOrders := PChar(g_sBackOrderAllCustomerOrders);

  g_sIgnoreCustomerOrdersForSafetyStock :=  dmMainDLL.GetConfigAsString(202);
  FLocationParams.IgnoreCustomerOrdersForSafetyStock := PChar(g_sIgnoreCustomerOrdersForSafetyStock);

  g_sUseDependantForecastsForSafetyStock :=  dmMainDLL.GetConfigAsString(196);
  FLocationParams.UseDependantForecastsForSafetyStock := PChar(g_sUseDependantForecastsForSafetyStock);

  g_sForceDailyReviewPeriod := dmMainDLL.GetConfigAsString(285);
  FLocationParams.ForceDailyReviewPeriod := PChar(g_sForceDailyReviewPeriod);

  FLocationParams.SystemWeeks := PChar(FSystemWeeks);

  FLocationParams.NumberofPeriodsInYear := dmMainDLL.GetConfigAsInteger(236);
  FLocationParams.PeriodsForAverageForecast := dmMainDLL.GetConfigAsInteger(193);
  PercentUnsatisfiedOrdersBackOrdered := dmMainDLL.GetConfigAsFloat(124);
  FLocationParams.PercentUnsatisfiedOrdersBackOrdered := Trunc(PercentUnsatisfiedOrdersBackOrdered);
  FLocationParams.StockDownloadDate := dmMainDLL.GetConfigAsDateTime(104);
  FLocationParams.AddPercToLTFence := dmMainDLL.GetConfigAsFloat(188);

  FLocationParams.DaysinPer := dmMainDLL.GetConfigAsInteger(102);

  g_sUseMOQplusBinLevelForExcess := dmMainDLL.GetConfigAsString(267);
  FLocationParams.UseMOQplusBinLevelForExcess := PChar(g_sUseMOQplusBinLevelForExcess);

  FLocationParams.OrderThreshold := dmMainDLL.GetConfigAsFloat(296);

end;


procedure TfrmMainDLL.SetBOMFC;
var
n : integer;
begin
  with dmMainDLL do begin
    for n := 0 to High(FBOMForecast.PeriodForecast) do
      FBOMForecast.PeriodForecast[n] := 0.00;

    GetFC.Close;
    GetFC.Params.ByName('ITEMNO').AsInteger := GetItemData.FieldByName('ITEMNO').AsInteger;
    GetFC.Params.ByName('CALENDARNO').AsInteger := FCurrentPeriod;
    GetFC.Params.ByName('FORECASTTYPENO').AsInteger := 2;
    GetFC.ExecQuery;
    for n := 0 to FNoPeriodsToFC do
      FBOMForecast.PeriodForecast[n] := GetFC.FieldByName('FORECAST_' + IntToStr(n)).AsFloat;
  end;
end;

procedure TfrmMainDLL.SetCalendar;
var
n : integer;
FEndOfTimePeriod : integer;
begin
  with dmMainDLL do begin
    Calendar.Close;
    Calendar.Params.ByName('CALENDARNO1').AsInteger := FCurrentPeriod;
    Calendar.Params.ByName('CALENDARNO2').AsInteger := FCurrentPeriod;

    FendOfTimePeriod := 150;
    Calendar.Params.ByName('NOPERIODS').AsInteger := FendOfTimePeriod;
    Calendar.Open;
    n := 0;
    Calendar.First;
    while not Calendar.eof do begin
      NewCal[n].CalNo := n;
      NewCal[n].StartDate := Calendar.FieldByName('STARTDATE').AsDateTime;
      NewCal[n].EndDate := Calendar.FieldByName('ENDDATE').AsDateTime;
      Inc(n);
      Calendar.Next;
    end;
    FCalendar.NoEntries := n;
    FCalendar.FirstEntry := @NewCal;
  end;

end;

procedure TfrmMainDLL.SetCOStuff;
var
n, nDay : integer;
begin
  with dmMainDLL do begin
    GetCOData.Close;
    GetCOData.Params.ByName('ITEMNO').AsInteger := GetItemData.FieldByName('ITEMNO').AsInteger;
    GetCOData.Open;
    n := 0;
    GetCOData.First;
    while not GetCOData.eof do begin
      NewCO[n].OrderDate := GetCOData.FieldByName('OrderDate').AsDateTime;
      NewCO[n].ExpectedDeliveryDate := GetCOData.FieldByName('ExpectedDeliveryDate').AsDateTime;
      NewCO[n].OrderQty := GetCOData.FieldByName('Quantity').AsFloat;

      if FDailyCO then
      begin
        nDay := Round(NewCO[n].ExpectedDeliveryDate-FLocationParams.StockDownloadDate);

        //Overdue must go into 1st bucket
        if nDay < 0 then
          nDay := 0;

        if nDay <= 342 then
        begin
          COByDay[nDay].ExpectedDeliveryDate :=NewCO[n].ExpectedDeliveryDate;
          CoByDay[nDay].OrderQty := CoByDay[nDay].OrderQty+ NewCO[n].OrderQty;
          COByDay[nDay].OrderNumber := GetCOData.FieldByName('OrderReference').AsString;
        end;

      end;

      inc(n);
      GetCOData.Next;
    end;
    if n > 0 then begin
      FCustomerOrder.NoEntries := n;
      FCustomerOrder.FirstEntry := @NewCO;
    end
    else
      FCustomerOrder.NoEntries := 0;
  end;
end;

procedure TfrmMainDLL.SetDRPFC;
var
n : integer;
begin
  with dmMainDLL do begin
    for n := 0 to High(FDRPForecast.PeriodForecast) do
      FDRPForecast.PeriodForecast[n] := 0.00;
    GetFC.Close;
    GetFC.Params.ByName('ITEMNO').AsInteger := GetItemData.FieldByName('ITEMNO').AsInteger;
    GetFC.Params.ByName('CALENDARNO').AsInteger := FCurrentPeriod;
    GetFC.Params.ByName('FORECASTTYPENO').AsInteger := 3;
    GetFC.ExecQuery;
    for n := 0 to FNoPeriodsToFC do
      FDRPForecast.PeriodForecast[n] := GetFC.FieldByName('FORECAST_' + IntToStr(n)).AsFloat;
  end;
end;

procedure TfrmMainDLL.SetItemStuff;
var
  OrdShutDown:String;
begin
 with dmMainDLL do begin

    //Pareto is used to determine Stocked Ind.
    if GetItemData.FieldByName('StockingIndicator').AsString = 'N' then
      FPareto := 'N'
    else
      FPareto := GetItemData.FieldByName('PARETOCATEGORY').AsString;
    FItemParams.StockBuildNo := 100;
    
    FItemParams.Pareto := PChar(FPareto);
    FItemParams.Redistro_Excess_MAX_plus := 3;
    FItemParams.ConfirmationHorizon := FNoPeriodsToFC;
    FItemParams.StockBuildNo := GetItemData.FieldByName('Stock_BuildNo').AsInteger;
    FItemParams.StockOnHand := GetItemData.FieldByName('StockOnHand').AsFloat;
    FItemParams.DRPBackOrders := GetItemData.FieldByName('ConsolidatedBranchOrders').AsFloat;
    FItemParams.OpenBackOrders := GetItemData.FieldByName('BackOrder').AsFloat;
    FItemParams.SlowMovingLevel := GetItemData.FieldByName('BinLevel').AsFloat;
    FItemParams.SafetyStock := GetItemData.FieldByName('SafetyStock').AsFloat;
    FItemParams.LeadTime := GetItemData.FieldByName('LeadTime').AsFloat;
    FItemParams.ReviewPeriod := GetItemData.FieldByName('ReviewPeriod').AsFloat;
    FItemParams.ReplenishmentCycle := GetItemData.FieldByName('ReplenishmentCycle').AsFloat;
    FItemParams.OrderMinimum := GetItemData.FieldByName('MINIMUMORDERQUANTITY').AsFloat;
    FItemParams.OrderMultiple := GetItemData.FieldByName('OrderMultiples').AsFloat;
    FItemParams.TransitLT := GetItemData.FieldByName('TransitLT').AsFloat;
    FItemParams.SalesToDate := GetItemData.fieldByName('S0').AsFloat;
    if (GetItemData.FieldByName('STOCK_BUILDNO').AsInteger > 0) then begin
    FItemParams.StartBuild := GetItemData.FieldByName('Start_Build').AsDateTime;
    FItemParams.StartShutDown := GetItemData.FieldByName('Start_ShutDown').AsDateTime;
    FItemParams.EndShutDown := GetItemData.FieldByName('End_ShutDown').AsDateTime;
    end;
    OrdShutDown := GetItemData.FieldByName('Orders_During_Shutdown').AsString;

    if Trim(OrdShutDown) = 'Y' then
      OrdShutDown := 'Y'
    else
      OrdShutDown := 'N';

    FItemParams.OrdersDuringShutdown := PChar(OrdShutDown);
    OrdShutDown := GetItemData.FieldByName('Orders_During_Shutdown').AsString;

   // if GetItemData.FieldByName('BACKORDERRATIO').IsNull then
    //  FItemParams.BackorderRatio := trunc(PercentUnsatisfiedOrdersBackOrdered);
   // else
   //   FItemParams.BackorderRatio := GetItemData.FieldByName('BACKORDERRATIO').AsInteger;


  end;
end;

procedure TfrmMainDLL.SetLocalFC;
var
n,MaxFC : integer;
begin

  with dmMainDLL do begin
    MaxFC := High(FLocalForecast.PeriodForecast);

    for n := 0 to MaxFC do
      FLocalForecast.PeriodForecast[n] := 0.00;
      
    GetFC.Close;
    GetFC.Params.ByName('ITEMNO').AsInteger := GetItemData.FieldByName('ITEMNO').AsInteger;
    GetFC.Params.ByName('CALENDARNO').AsInteger := FCurrentPeriod;
    GetFC.Params.ByName('FORECASTTYPENO').AsInteger := 1;
    GetFC.ExecQuery;
    for n := 0 to FNoPeriodsToFC do
      FLocalForecast.PeriodForecast[n] := GetFC.FieldByName('FORECAST_' + IntToStr(n)).AsFloat;

    //Store Current Forecast
    FCurrentForecast := FLocalForecast.PeriodForecast[0];

    //if Sales to Date then reduce forecast.
    {if g_sLocalMonthFactorMode = 'S' then
    begin
      FLocalForecast.PeriodForecast[0] := FLocalForecast.PeriodForecast[0] - GetItemData.fieldByName('S0').AsFloat;

      if FLocalForecast.PeriodForecast[0] < 0 then FLocalForecast.PeriodForecast[0] := 0;

    end;
    }

  end;
end;

procedure TfrmMainDLL.SetPOStuff;
var
n : integer;
begin
  with dmMainDLL do begin
    GetPOData.Close;
    GetPOData.Params.ByName('ITEMNO').AsInteger := GetItemData.FieldByName('ITEMNO').AsInteger;
    GetPOData.Open;
    n := 0;
    GetPOData.First;
    while not GetPOData.eof do begin
      NewPO[n].OrderDate := GetPOData.FieldByName('OrderDate').AsDateTime;
      NewPO[n].ExpectedArrivalDate := GetPOData.FieldByName('ExpectedArrivalDate').AsDateTime;
      NewPO[n].OrderQty := GetPOData.FieldByName('Quantity').AsFloat;
      inc(n);
      GetPOData.Next;
    end;
    if n > 0 then begin
      FPurchaseOrder.NoEntries := n;
      FPurchaseOrder.FirstEntry := @NewPO;
    end
    else
      FPurchaseOrder.NoEntries := 0;


  end;
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
var
n : integer;
begin

  with dmMainDLL.qryCO do begin

    for n := 0 to FNoPeriodsToFC do
      FMonthlyCO.PeriodCO[n] := 0.00;

    Close;
    Params.ByName('ITEMNO').AsInteger := dmMainDLL.GetItemData.FieldByName('ITEMNO').AsInteger;
    ExecQuery;

    for n := 0 to 25 do
       FMonthlyCO.PeriodCO[n] := FieldByName('CustomerOrder_' + IntToStr(n)).AsFloat;

  end;

end;

procedure TfrmMainDLL.SetDailyPO(DownDate:TDateTime);
var
n, DayOffset : integer;
TempDate:TDateTime;
begin

  with dmMainDLL.GetPOData do begin

    first;

    for n := 0 to _MaxDailyPO do
      FDailyPurChaseOrders.PO[n] := 0;

    while not eof do
    begin

     TempDate := FieldByName('ExpectedArrivalDate').AsDateTime;
     DayOffset := Round((TempDate - DownDate)+1);

     if DayOffSet < 0 Then
       DayOffSet := 0;

     FDailyPurChaseOrders.PO[DayOffSet] := FDailyPurChaseOrders.PO[DayOffSet] + FieldByName('Quantity').AsFloat;


      next;

    end;

  end;

end;

procedure TfrmMainDLL.SetMonthlyDemand;
var
  n:Integer;
begin

    for n := 0 to FNoPeriodsToFC do
    begin

      //Use full forecast for 1st month  (Kevin Tomaino 12-11-03)
      if n = 0 then
        FMonthlyDemand.PeriodDemand[n] := Max(FMonthlyCO.PeriodCO[n],FCurrentForecast)
      else
        FMonthlyDemand.PeriodDemand[n] := Max(FMonthlyCO.PeriodCO[n],FLocalForecast.PeriodForecast[n]);

      if FLocationParams.UseBOM = 'Y' then
      begin
        FMonthlyDemand.PeriodDemand[n] := FMonthlyDemand.PeriodDemand[n] + FBOMForecast.PeriodForecast[n];
      end;

      if FLocationParams.UseDRP = 'Y' then
      begin
        FMonthlyDemand.PeriodDemand[n] := FMonthlyDemand.PeriodDemand[n] +  FDRPForecast.PeriodForecast[n];
      end;

    end;

end;

end.
