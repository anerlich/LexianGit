unit TestFP;

interface

uses
  ShareMem,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OvcBase, ExtCtrls, StdCtrls, DataStructures, DBCtrls;


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
  TfrmTestFP = class(TForm)
    OvcController1: TOvcController;
    dlgSave: TSaveDialog;
    btnMany: TButton;
    lblProductCode: TLabel;
    cmbTemplates: TDBLookupComboBox;
    lcbLocation: TDBLookupComboBox;
    lblLocation: TLabel;
    lblTemplate: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnManyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FNoPeriodsToFC : integer;
    FCurrentPeriod : integer;
    FLocationParams : TLocationParams;
    FCalendar : TCalendar;
    FItemParams : TItemParams;
    FPurchaseOrder : TPurchaseOrder;
    FCustomerOrder : TCustomerOrder;
    FLocalForecast : TForecast;
    FBOMForecast : TForecast;
    FDRPForecast : TForecast;
    FRecommendedOrders : TRecommendedOrders;
    FOpeningStock : TOpeningStock;
    FCalculatedReceipts : TCalculatedReceipts;
    FBackOrders : TBackOrders;
    FCumLostSales : TCumLostSales;
    FExcess : TExcess;
    FPareto, FOrdersDuringShutdown : string;
    NewCal : array [0..150] of TCalendarEntry;
    NewPO : array [0..2000] of TPurchaseOrderEntry;
    NewCO : array [0..2000] of TCustomerOrderEntry;

    PercentUnsatisfiedOrdersBackOrdered : double;
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
    g_sBackOrderAllCustomerOrders,
    g_sIgnoreCustomerOrdersForSafetyStock,
    g_sUseDependantForecastsForSafetyStock,
    g_sForceDailyReviewPeriod,
    g_UseMOQplusBinLevelForExcess : String;

    procedure SetAllParameters;
    procedure SetCalendar;
    procedure SetItemStuff;
    procedure SetPOStuff;
    procedure SetCOStuff;
    procedure SetLocalFC;
    procedure SetBOMFC;
    procedure SetDRPFC;
  public
  end;

var
  frmTestFP: TfrmTestFP;


implementation

uses dmFPTestDLL, uTemplateSQL, dmSVPMain, dmSVPMainDataModuleTemplate;

{$R *.DFM}

procedure TfrmTestFP.SetCalendar;
var
  n : integer;
  FEndOfTimePeriod : integer;
begin
  with FPTestDLLDataModule do begin
    Calendar.Close;
    Calendar.Params.ByName('CALENDARNO').AsInteger := FCurrentPeriod;

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

procedure TfrmTestFP.SetItemStuff;
begin
  with FPTestDLLDatamodule do begin
    FPareto := GetItemData.FieldByName('PARETOCATEGORY').AsString;
    FItemParams.Pareto := PChar(FPareto);
    FItemParams.Redistro_Excess_MAX_plus := 3;
    FItemParams.ConfirmationHorizon := FNoPeriodsToFC;
    FItemParams.StockOnHand := GetItemData.FieldByName('StockOnHand').AsFloat;
    FItemParams.DRPBackOrders := GetItemData.FieldByName('ConsolidatedBranchOrders').AsFloat;
    FItemParams.OpenBackOrders := GetItemData.FieldByName('BackOrder').AsFloat;
    FItemParams.SlowMovingLevel := GetItemData.FieldByName('BinLevel').AsFloat;
    FItemParams.SafetyStock := GetItemData.FieldByName('SafetyStock').AsFloat;
    FItemParams.LeadTime := GetItemData.FieldByName('LeadTime').AsFloat;
    FItemParams.TransitLT := GetItemData.FieldByName('TransitLT').AsFloat;
    FItemParams.ReviewPeriod := GetItemData.FieldByName('ReviewPeriod').AsFloat;
    FItemParams.ReplenishmentCycle := GetItemData.FieldByName('ReplenishmentCycle').AsFloat;
    FItemParams.OrderMinimum := GetItemData.FieldByName('MINIMUMORDERQUANTITY').AsFloat;
    FItemParams.OrderMultiple := GetItemData.FieldByName('OrderMultiples').AsFloat;
    FItemParams.StockBuildNo := GetItemData.FieldByName('STOCK_BUILDNO').AsInteger;
    if (GetItemData.FieldByName('STOCK_BUILDNO').AsInteger > 0) then begin
      FItemParams.StartBuild := GetStockBuild.FieldByName('START_BUILD').AsDateTime;
      FItemParams.StartShutdown := GetStockBuild.FieldByName('START_SHUTDOWN').AsDateTime;
      FItemParams.EndShutdown := GetStockBuild.FieldByName('END_SHUTDOWN').AsDateTime;
      FOrdersDuringShutdown := GetStockBuild.FieldByName('ORDERS_DURING_SHUTDOWN').AsString;
      FItemParams.OrdersDuringShutdown := PChar(FOrdersDuringShutdown);
    end;
    FItemParams.SalesToDate := GetItemData.FieldByName('SALESAMOUNT_0').AsFloat;
    if GetItemData.FieldByName('BACKORDERRATIO').IsNull then
      FItemParams.BackorderRatio := trunc(PercentUnsatisfiedOrdersBackOrdered)
    else
      FItemParams.BackorderRatio := GetItemData.FieldByName('BACKORDERRATIO').AsInteger;

  end;
end;

procedure TfrmTestFP.SetPOStuff;
var
  n : integer;
begin
  with FPTestDLLDatamodule do begin
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

procedure TfrmTestFP.SetCOStuff;
var
  n : integer;
begin
  with FPTestDLLDatamodule do begin
    GetCOData.Close;
    GetCOData.Params.ByName('ITEMNO').AsInteger := GetItemData.FieldByName('ITEMNO').AsInteger;
    GetCOData.Open;
    n := 0;
    GetCOData.First;
    while not GetCOData.eof do begin
      NewCO[n].OrderDate := GetCOData.FieldByName('OrderDate').AsDateTime;
      NewCO[n].ExpectedDeliveryDate := GetCOData.FieldByName('ExpectedDeliveryDate').AsDateTime;
      NewCO[n].OrderQty := GetCOData.FieldByName('Quantity').AsFloat;
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

procedure TfrmTestFP.SetLocalFC;
var
  n : integer;
begin
  with FPTestDLLDatamodule do begin
    for n := 0 to 51 do
      FLocalForecast.PeriodForecast[n] := 0.00;
    GetFC.Close;
    GetFC.Params.ByName('ITEMNO').AsInteger := GetItemData.FieldByName('ITEMNO').AsInteger;
    GetFC.Params.ByName('CALENDARNO').AsInteger := FCurrentPeriod;
    GetFC.Params.ByName('FORECASTTYPENO').AsInteger := 1;
    GetFC.ExecQuery;
    for n := 0 to FNoPeriodsToFC do
      FLocalForecast.PeriodForecast[n] := GetFC.FieldByName('FORECAST_' + IntToStr(n)).AsFloat;
  end;
end;

procedure TfrmTestFP.SetBOMFC;
var
  n : integer;
begin
  with FPTestDLLDatamodule do begin
    for n := 0 to 51 do
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

procedure TfrmTestFP.SetDRPFC;
var
  n : integer;
begin
  with FPTestDLLDatamodule do begin
    for n := 0 to 51 do
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

procedure TfrmTestFP.FormCreate(Sender: TObject);
begin
  SetAllParameters;
end;

procedure TfrmTestFP.SetAllParameters;
begin
  FLocationParams.ExportParams := 'N';
  FLocationParams.ExportResults := 'N';
  FLocationParams.ShowErrorMessage := 'Y';
  FCurrentPeriod := SVPMainDataModuleTemplate.ReadConfigInt(100);;
  FNoPeriodsToFC := SVPMainDataModuleTemplate.ReadConfigInt(101) - 1;
  FLocationParams.NoPeriodsForecast := FNoPeriodsToFC;
  FLocationParams.MaxForwardCover := trunc(SVPMainDataModuleTemplate.ReadConfigFloat(264)) + 1;

  g_sExcessUses := SVPMainDataModuleTemplate.ReadConfigStr(195);
  FLocationParams.ExcessUses := PChar(g_sExcessUses);

  g_UseMOQplusBinLevelForExcess := SVPMainDataModuleTemplate.ReadConfigStr(267);
  FLocationParams.UseMOQplusBinLevelForExcess := PChar(g_UseMOQplusBinLevelForExcess);

  g_sUseMOQ := SVPMainDataModuleTemplate.ReadConfigStr(184);
  FLocationParams.UseMOQ := PChar(g_sUseMOQ);

  g_sTypeOfOrdering := SVPMainDataModuleTemplate.ReadConfigStr(189);
  FLocationParams.TypeOfOrdering := PChar(g_sTypeOfOrdering);

  g_sRoundMOQ := SVPMainDataModuleTemplate.ReadConfigStr(185);
  FLocationParams.RoundMOQ := PChar(g_sRoundMOQ);

  g_sRoundMult := SVPMainDataModuleTemplate.ReadConfigStr(187);
  FLocationParams.RoundMult := PChar(g_sRoundMult);

  g_sTypeOfSimulation := SVPMainDataModuleTemplate.ReadConfigStr(188);
  FLocationParams.TypeOfSimulation := PChar(g_sTypeOfSimulation);

  g_sUseOfCustomerOrders := SVPMainDataModuleTemplate.ReadConfigStr(198);
  FLocationParams.UseOfCustomerOrders := PChar(g_sUseOfCustomerOrders);

  g_sOverdueCustomerOrderDate :=  SVPMainDataModuleTemplate.ReadConfigStr(153);
  FLocationParams.OverdueCustomerOrderDate := PChar(g_sOverdueCustomerOrderDate);

  g_sLocalMonthFactorMode := SVPMainDataModuleTemplate.ReadConfigStr(191);
  FLocationParams.LocalMonthFactorMode := PChar(g_sLocalMonthFactorMode);

  g_sBOMMonthFactorMode := SVPMainDataModuleTemplate.ReadConfigStr(205);
  FLocationParams.BOMMonthFactorMode := PChar(g_sBOMMonthFactorMode);

  g_sDRPMonthFactorMode := SVPMainDataModuleTemplate.ReadConfigStr(207);
  FLocationParams.DRPMonthFactorMode := PChar(g_sDRPMonthFactorMode);

  g_sBOMFillMode :=  SVPMainDataModuleTemplate.ReadConfigStr(204);
  FLocationParams.BOMFillMode := PChar(g_sBOMFillMode);

  g_sCustomerOrdersOverride := SVPMainDataModuleTemplate.ReadConfigStr(199);
  FLocationParams.CustomerOrdersOverride := PChar(g_sCustomerOrdersOverride);

  g_sOverdueCustomerOrdersImport :=  SVPMainDataModuleTemplate.ReadConfigStr(152);
  FLocationParams.OverdueCustomerOrdersImport := PChar(g_sOverdueCustomerOrdersImport);

  g_sUseBOM := SVPMainDataModuleTemplate.ReadConfigStr(203);
  FLocationParams.UseBOM := PChar(g_sUseBOM);

  g_sUseDRP := SVPMainDataModuleTemplate.ReadConfigStr(206);
  FLocationParams.UseDRP := PChar(g_sUseDRP);

  g_sUseDRPBackOrders := SVPMainDataModuleTemplate.ReadConfigStr(232);
  FLocationParams.UseDRPBackOrders := PChar(g_sUseDRPBackOrders);

  g_sUseMult := SVPMainDataModuleTemplate.ReadConfigStr(186);
  FLocationParams.UseMult := PChar(g_sUseMult);

  g_sTreatNegativeStockAsZero :=  SVPMainDataModuleTemplate.ReadConfigStr(190);
  FLocationParams.TreatNegativeStockAsZero := PChar(g_sTreatNegativeStockAsZero);

  FLocationParams.ApplyBackOrderPercentToDependantForecasts := 'Y';

  g_sBackOrderAllCustomerOrders := SVPMainDataModuleTemplate.ReadConfigStr(201);
  FLocationParams.BackOrderAllCustomerOrders := PChar(g_sBackOrderAllCustomerOrders);

  g_sIgnoreCustomerOrdersForSafetyStock :=  SVPMainDataModuleTemplate.ReadConfigStr(202);
  FLocationParams.IgnoreCustomerOrdersForSafetyStock := PChar(g_sIgnoreCustomerOrdersForSafetyStock);

  g_sUseDependantForecastsForSafetyStock :=  SVPMainDataModuleTemplate.ReadConfigStr(196);
  FLocationParams.UseDependantForecastsForSafetyStock := PChar(g_sUseDependantForecastsForSafetyStock);

  g_sForceDailyReviewPeriod := SVPMainDataModuleTemplate.ReadConfigStr(285);
  FLocationParams.ForceDailyReviewPeriod := PChar(g_sForceDailyReviewPeriod);

  FLocationParams.OrderThreshold := SVPMainDataModuleTemplate.ReadConfigFloat(296);
  
  FLocationParams.SystemWeeks := 'D';
  FLocationParams.NumberofPeriodsInYear := SVPMainDataModuleTemplate.ReadConfigInt(236);
  FLocationParams.PeriodsForAverageForecast := SVPMainDataModuleTemplate.ReadConfigInt(193);
  PercentUnsatisfiedOrdersBackOrdered := SVPMainDataModuleTemplate.ReadConfigFloat(124);
  FLocationParams.StockDownloadDate := SVPMainDataModuleTemplate.ReadConfigDate(104);
  FLocationParams.AddPercToLTFence := SVPMainDataModuleTemplate.ReadConfigFloat(188);
  FLocationParams.DaysInPer := SVPMainDataModuleTemplate.ReadConfigInt(102);
end;

procedure TfrmTestFP.btnManyClick(Sender: TObject);
var
  FileName, ResultString : String;
  ResultFile: TextFile;
  Counter, n : integer;
  SQL, JoinClause : TStringList;
  MyCursor : TCursor;
  Engine : Pointer;
  ErrorCode : integer;
begin
  if dlgSave.Execute then begin
    FileName := dlgSave.FileName;
    AssignFile(ResultFile,FileName);

    myCursor := Cursor;
    Engine := nil;
    Cursor := crSQLWait;
    Application.ProcessMessages;
    SVPMainDatamodule.DefaultTrans.StartTransaction;
    try
      SetCalendar;
      InitialiseEngine(Engine, @FLocationParams, @FCalendar);
      if Engine <> nil then begin
        try
          Rewrite(ResultFile);

          with FPTestDLLDatamodule do begin
            SQL := TStringList.Create;
            JoinClause := TStringList.Create;
            CreateTemplateSQL(GetTemplates.FieldByName('TemplateNo').AsInteger, 1, lcbLocation.KeyValue, SVPMainDatamodule.SVPDatabase, SQL, JoinClause);
            GetItemData.Close;
            GetItemData.SQL.Add(SQL[1]);
            for n := 0 to JoinClause.Count-1 do
              GetItemData.SQL.Add(JoinClause[n]);
            GetItemData.SQL.Add('left outer join ItemSales s on i.ItemNo = s.ItemNo');
            for n := 2 to SQL.Count-1 do
              GetItemData.SQL.Add(SQL[n]);
            GetItemData.SQL.Add('Order by ProductCode');
            GetItemData.ExecQuery;
            Counter := 0;
            while not GetItemData.eof do begin
              lblProductCode.Caption := GetItemData.FieldByName('ProductCode').AsString;
              if (GetItemData.FieldByName('STOCK_BUILDNO').AsInteger > 0) then begin
                GetStockBuild.Close;
                GetStockBuild.Params.ByName('STOCKBUILDNO').AsInteger := GetItemData.FieldByName('STOCK_BUILDNO').AsInteger;
                GetStockBuild.ExecQuery;
              end;
              SetItemStuff;
              SetPOStuff;
              SetCOStuff;
              SetLocalFC;
              SetBOMFC;
              SetDRPFC;
              for n:= 1 to 342 do begin
                FRecommendedOrders.RO[n] := 0;
{ivb}           FOpeningStock.OS[n] := 0;
{ivb}           FCalculatedReceipts.CR[n] := 0;
{ivb}           FBackOrders.BO[n] := 0;
{ivb}           FCumLostSales.CLS[n] := 0;
{ivb}           FExcess.EX[n] := 0;
              end;  {for}
(*              if GetItemData.FieldByName('ProductCode').AsString = '0810150000' then begin
                FLocationParams.ExportParams := 'Y';
                FLocationParams.ExportResults := 'Y';
              end
              else begin
                FLocationParams.ExportParams := 'N';
                FLocationParams.ExportResults := 'N';
              end;*)

              ErrorCode := GetRecommendedOrders(Engine, @FLocationParams, @FItemParams,
                                      @FPurchaseOrder,  @FCustomerOrder, @FLocalForecast,
                                      @FBOMForecast, @FDRPForecast, @FRecommendedOrders,
                                      @FOpeningStock,@FCalculatedReceipts,@FBackOrders,
                                      @FCumLostSales,@FExcess);

              if ErrorCode = 0 then begin
                ResultString := FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTCODE').AsString + ',' +
                                FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTDESCRIPTION').AsString + ',' +
                                'Recommended Orders';
                for n := 0 to 74 do begin
{ivb}              ResultString := ResultString + ',' + Format('%10.0f',[FRecommendedOrders.RO[n]]);
                end;  {for}
                WriteLn(ResultFile, ResultString);

(*                ResultString := FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTCODE').AsString + ',' +
                                FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTDESCRIPTION').AsString + ',' +
                                'Opening Stock';
                for n := 0 to 74 do begin
{ivb}                  ResultString := ResultString + ',' + Format('%10.0f',[FOpeningStock.OS[n]]);
                end;  {for}
                WriteLn(ResultFile, ResultString);

                ResultString := FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTCODE').AsString + ',' +
                                FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTDESCRIPTION').AsString + ',' +
                                'Calculated Receipts';
                for n := 0 to 74 do begin
{ivb}                  ResultString := ResultString + ',' + Format('%10.0f',[FCalculatedReceipts.CR[n]]);
                end;  {for}
                WriteLn(ResultFile, ResultString);

                ResultString := FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTCODE').AsString + ',' +
                                FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTDESCRIPTION').AsString + ',' +
                                'Back Orders';
                for n := 0 to 74 do begin
{ivb}                  ResultString := ResultString + ',' + Format('%10.0f',[FBackOrders.BO[n]]);
                end;  {for}
                WriteLn(ResultFile, ResultString);

                ResultString := FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTCODE').AsString + ',' +
                                FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTDESCRIPTION').AsString + ',' +
                                'Cum. Lost Sales';
                for n := 0 to 74 do begin
{ivb}                  ResultString := ResultString + ',' + Format('%10.0f',[FCumLostSales.CLS[n]]);
                end;  {for}
                WriteLn(ResultFile, ResultString);

                ResultString := FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTCODE').AsString + ',' +
                                FPTestDLLDatamodule.GetItemData.FieldByName('PRODUCTDESCRIPTION').AsString + ',' +
                                'Excess';
                for n := 0 to 74 do begin
{ivb}                  ResultString := ResultString + ',' + Format('%10.0f',[FExcess.EX[n]]);
                end;  {for}
                WriteLn(ResultFile, ResultString);
  *)

              end;
              Inc(Counter);
              if Counter >= 50 then begin
                Application.ProcessMessages;
                Counter := 0;
              end;
              GetItemData.Next;
            end;
          end;
        finally
          FinaliseEngine(Engine);
          CloseFile(ResultFile);
          Cursor := MyCursor;
        end;
      end;
    finally
      SVPMainDatamodule.DefaultTrans.Commit;
    end;
    ShowMessage('Finished');
  end;
end;

procedure TfrmTestFP.FormShow(Sender: TObject);
begin
  SVPMainDatamodule.DefaultTrans.StartTransaction;
  FPTestDLLDatamodule.GetTemplates.Open;
  FPTestDLLDatamodule.GetLocations.Open;
  SVPMainDatamodule.DefaultTrans.Commit;
end;

end.
