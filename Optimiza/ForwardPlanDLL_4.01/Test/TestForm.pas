unit TestForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Buttons, ExtCtrls, StdCtrls, DBCtrls, ComCtrls,
  Mask, Series, TeEngine, TeeProcs, Chart;

const
  GraphLen = 365; { 0 to }  

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    tabCalendar: TTabSheet;
    tabConfig: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    btnData: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    DBEdit1: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBEdit3: TDBEdit;
    Label23: TLabel;
    edtCurrPeriod: TEdit;
    edtNoPeriodsFc: TEdit;
    edtDaysInPeriod: TEdit;
    edtAvgFCPeriods: TEdit;
    edtFirstPeriodRatio: TEdit;
    cbUseMOQ: TCheckBox;
    cbUseMult: TCheckBox;
    cbZeroNeg: TCheckBox;
    cbUseDependant: TCheckBox;
    edtPODays: TEdit;
    cbUseBOM: TCheckBox;
    cbUseDRP: TCheckBox;
    tabItem: TTabSheet;
    rgProrateFC: TRadioGroup;
    rgOverrideCO: TRadioGroup;
    rgDateCO: TRadioGroup;
    tabGraph: TTabSheet;
    rgCO: TRadioGroup;
    rgCOOverride: TRadioGroup;
    rbMOQRound: TRadioGroup;
    rgMultRound: TRadioGroup;
    rgTypeOrder: TRadioGroup;
    cbExcessUses: TCheckBox;
    Label4: TLabel;
    edtBackorderRatio: TEdit;
    Label10: TLabel;
    edtBOMBackorderRatio: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtCOBackorderRatio: TEdit;
    edtDRPBackorderRatio: TEdit;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    cbStocked: TCheckBox;
    Label16: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtSTD: TEdit;
    edtSOH: TEdit;
    edtBO: TEdit;
    edtCBO: TEdit;
    edtBinLevel: TEdit;
    edtMOQ: TEdit;
    edtOrderMult: TEdit;
    edtSSDays: TEdit;
    edtRCDays: TEdit;
    edtRPDays: TEdit;
    edtLTDays: TEdit;
    PageControl2: TPageControl;
    tabDailyGraph: TTabSheet;
    tabWeeklyGraph: TTabSheet;
    tabMonthlyGraph: TTabSheet;
    chrtDaily: TChart;
    DExcessSeries: TAreaSeries;
    DLeadTimeSeries: TAreaSeries;
    DModelSeries: TLineSeries;
    DOrderSeries: TBarSeries;
    DReceiptSeries: TBarSeries;
    DSOHSeries: TLineSeries;
    DPOSeries: TBarSeries;
    chrtMonthly: TChart;
    MStockBuildSeries: TAreaSeries;
    MDemandSeries: TAreaSeries;
    MForecastSeries: TLineSeries;
    MDRPSeries: TLineSeries;
    MBOMSeries: TLineSeries;
    MCOSeries: TBarSeries;
    MBOSeries: TBarSeries;
    MExcessSeries: TBarSeries;
    MProjectedOrderSeries: TBarSeries;
    MShipmentSeries: TBarSeries;
    MReceiptsSeries: TBarSeries;
    MOnHandSeries: TLineSeries;
    chrtWeekly: TChart;
    WStockBuildSeries: TAreaSeries;
    WDemandSeries: TAreaSeries;
    WForecastSeries: TLineSeries;
    WDRPSeries: TLineSeries;
    WBOMSeries: TLineSeries;
    WCOSeries: TBarSeries;
    WBOSeries: TBarSeries;
    WExcessSeries: TBarSeries;
    WProjectedOrderSeries: TBarSeries;
    WShipmentSeries: TBarSeries;
    WReceiptsSeries: TBarSeries;
    WOnHandSeries: TLineSeries;
    DMinSeries: TLineSeries;
    DSSSeries: TLineSeries;
    btnLoadItem: TSpeedButton;
    edtProductCode: TEdit;
    cbUseMin: TCheckBox;
    cbFixedLevels: TCheckBox;
    rbAPareto: TRadioButton;
    rbBPareto: TRadioButton;
    rbCPAreto: TRadioButton;
    rbDPareto: TRadioButton;
    rbEPareto: TRadioButton;
    rbFPareto: TRadioButton;
    rbMPareto: TRadioButton;
    rbXPareto: TRadioButton;
    Label29: TLabel;
    edtMinQty: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    edtFixedSS: TEdit;
    edtFixedSSRC: TEdit;
    DSSRCSeries: TLineSeries;
    Label32: TLabel;
    edtMinimumDays: TEdit;
    DIdealArrivalSeries: TBarSeries;
    cbCalcIdealArrival: TCheckBox;
    Label33: TLabel;
    edtIdealArrival: TEdit;
    tabExpedite: TTabSheet;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    cbExpedite: TCheckBox;
    edtPercentagelt: TEdit;
    edtMinDaysLT: TEdit;
    edtRecChanges: TEdit;
    edtMinDaysRec: TEdit;
    Label34: TLabel;
    Label38: TLabel;
    edtTransitLT: TEdit;
    rgTypeSim: TRadioGroup;
    Label39: TLabel;
    edtFixedHorizon: TEdit;
    DPOExpeditedSeries: TBarSeries;
    DPODeExpeditedSeries: TBarSeries;
    tabPO: TTabSheet;
    tabStockBuild: TTabSheet;
    cbStockBuild: TCheckBox;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    edtBuildStart: TDateTimePicker;
    edtShutdownStart: TDateTimePicker;
    edtShutdownEnd: TDateTimePicker;
    DBuildSeries: TAreaSeries;
    DShutdownSeries: TAreaSeries;
    grpNonStockModel: TRadioGroup;
    cbSBOrders: TCheckBox;
    btnLoadFromFile: TSpeedButton;
    btnSaveParamsToFile: TSpeedButton;
    btnSaveResultsToFile: TSpeedButton;
    dlgLoad: TOpenDialog;
    dlgSaveParams: TSaveDialog;
    dlgSaveResults: TSaveDialog;
    ItemForecast: TCheckBox;
    Label43: TLabel;
    edtRedistLevel: TEdit;
    edtDD: TDateTimePicker;
    Label44: TLabel;
    Label45: TLabel;
    edtItemBackorderRatio: TEdit;
    edtItemBOMBackorderRatio: TEdit;
    Label46: TLabel;
    edtItemDRPBackorderRatio: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnDataClick(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
    procedure btnLoadItemClick(Sender: TObject);
    procedure rgTypeSimClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveParamsToFileClick(Sender: TObject);
    procedure btnSaveResultsToFileClick(Sender: TObject);
    procedure btnLoadFromFileClick(Sender: TObject);
    procedure ItemForecastClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowConfigParams;
    procedure SetConfigParams;
    procedure ShowItemParams;
    procedure ShowLoadedItemParams;
    procedure SetItemParams;
    procedure PopulateDailyGrid;
    procedure PopulatePOGrid;
    procedure ShowDailyGraph;
    procedure ShowWeeklyGraph;
    procedure ShowMonthlyGraph;
    procedure OpenItemTable;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses udmMainDLL, udmTest;


{$R *.DFM}

function iMax(V1, v2 : Integer) : Integer;
begin
  if V1 > v2 then begin
    Result := V1;
  end else begin
    Result := V2;
  end;
end;

procedure TForm1.ShowConfigParams;
begin
  with dmMainDLL do begin
    edtDD.Date := FStockDownloadDate;
    edtCurrPeriod.Text := IntToStr(FCurrentPeriod);
    edtNoPeriodsFc.Text := IntToStr(FNoPeriodsFC);
    edtDaysInPeriod.Text := IntToStr(FNoDaysInPeriod);
    edtAvgFCPeriods.Text := IntToStr(FAvrFCPeriod);
    rgprorateFC.ItemIndex := FCurrFCUsage;
    edtFirstPeriodRatio.Text := FloatToStr(FFirstRatio);
    rgOverrideCO.ItemIndex :=  FOverCOIs;
    if FOverFromSDD then
      rgDateCO.ItemIndex := 0
    else
      rgDateCO.ItemIndex := 1;
    rgCO.ItemIndex := FCOUsage;
    rgCOOverride.ItemIndex := FCOOverride;
    if FUseMOQ then
      cbUseMOQ.Checked := True
    else
      cbUseMOQ.Checked := False;
    if FUseMult then
      cbUseMult.Checked := True
    else
      cbUseMult.Checked := False;
    if FUseMin then
      cbUseMin.Checked := True
    else
      cbUseMin.Checked := False;
    if FZeroNegStock then
      cbZeroNeg.Checked := True
    else
      cbZeroNeg.Checked := False;

    if FUseFirmInSS then
      cbUseDependant.Checked := True
    else
      cbUseDependant.Checked := False;

    edtPODays.Text := IntToStr(FFWDPODays);

    if FUseBOM then
      cbUseBOM.Checked := True
    else
      cbUseBOM.Checked := False;
    if FUseDRP then
      cbUseDRP.Checked := True
    else
      cbUseDRP.Checked := False;

    rbMOQRound.ItemIndex := FRoundMOQ;
    rgMultRound.ItemIndex := FRoundMult;
    if FExcessAboveRC then
      cbExcessUses.Checked := True
    else
      cbExcessUses.Checked := False;
    rgTypeOrder.ItemIndex := FOrderMethod;
    edtBackorderRatio.Text := FloatToStr(FFCRAtio);
    edtBOMBackorderRatio.Text := FloatToStr(FBOMRatio);
    edtDRPBackorderRatio.Text := FloatToStr(FDRPRatio);
    edtCOBackorderRatio.Text := FloatToStr(FCORatio);
    edtRedistLevel.Text := IntToStr(FRedistributableStockLevel);
    edtMinimumDays.Text := IntToStr(FMinimumDays);

    edtPercentagelt.Text := FloatToStr(FPercentageLT);
    edtMinDaysLT.Text := IntToStr(FMinDaysLT);
    edtRecChanges.Text := FloatToStr(FPercentageRecChanges);
    edtMinDaysRec.Text := IntToStr(FMinDaysRecChanges);

    rgTypeSim.ItemIndex := FTypeOfSimulation;
    grpNonStockModel.ItemIndex := FNonStockedModel;
  end;
end;

procedure TForm1.SetConfigParams;
begin
  with dmMainDLL do begin
    FStockDownloadDate := trunc(edtDD.Date);
    FCurrentPeriod := StrToInt(edtCurrPeriod.Text);
    FNoPeriodsFC := StrToInt(edtNoPeriodsFc.Text);
    FNoDaysInPeriod := StrToInt(edtDaysInPeriod.Text);
    FAvrFCPeriod := StrToInt(edtAvgFCPeriods.Text);
    FCurrFCUsage := rgprorateFC.ItemIndex;
    FFirstRatio := StrToFloat(edtFirstPeriodRatio.Text);
    FOverCOIs := rgOverrideCO.ItemIndex;
    FOverFromSDD := rgDateCO.ItemIndex = 0;
    FCOUsage := rgCO.ItemIndex;
    FCOOverride := rgCOOverride.ItemIndex;
    FUseMOQ := cbUseMOQ.Checked;
    FUseMult := cbUseMult.Checked;
    FUseMin := cbUseMin.Checked;
    FZeroNegStock:= cbZeroNeg.Checked;
    FUseFirmInSS := cbUseDependant.Checked;

    FFWDPODays := StrToInt(edtPODays.Text);

    FUseBOM := cbUseBOM.Checked;
    FUseDRP := cbUseDRP.Checked;

    FRoundMOQ := rbMOQRound.ItemIndex;
    FRoundMult := rgMultRound.ItemIndex;
    FExcessAboveRC := cbExcessUses.Checked;
    FOrderMethod := rgTypeOrder.ItemIndex;

    if edtItemBackorderRatio.Text = '' then
      FFCRAtio := StrToFloat(edtBackorderRatio.Text)
    else
      FFCRAtio := StrToFloat(edtItemBackorderRatio.Text);

    if edtItemBOMBackorderRatio.Text = '' then
      FBOMRatio := StrToFloat(edtBOMBackorderRatio.Text)
    else
      FBOMRatio := StrToFloat(edtItemBOMBackorderRatio.Text);

    if edtItemDRPBackorderRatio.Text = '' then
      FDRPRatio := StrToFloat(edtDRPBackorderRatio.Text)
    else
      FDRPRatio := StrToFloat(edtItemDRPBackorderRatio.Text);

    FCORatio := StrToFloat(edtCOBackorderRatio.Text);
    FRedistributableStockLevel := StrToInt(edtRedistLevel.Text);

    FMinimumDays := StrToInt(edtMinimumDays.Text);

    FPercentageLT := StrToFloat(edtPercentagelt.Text);
    FMinDaysLT := StrToInt(edtMinDaysLT.Text);
    FPercentageRecChanges := StrToFloat(edtRecChanges.Text);
    FMinDaysRecChanges := StrToInt(edtMinDaysRec.Text);

    FTypeOfSimulation := rgTypeSim.ItemIndex;
    if FTypeOfSimulation = 3 then
      FFixedHorizon := StrToInt(edtFixedHorizon.Text);
    FUseFixedLevels := cbFixedLevels.Checked;
    FExpeditePO := cbExpedite.Checked;
    FNonStockedModel := grpNonStockModel.ItemIndex;
  end;
end;

procedure TForm1.ShowItemParams;
begin
  with dmMainDLL do begin

    edtSTD.Text := IntToStr(qryItem.FieldByName('SALESAMOUNT_0').AsInteger);
    if qryItem.FieldByName('STOCKINGINDICATOR').AsString = 'Y' then
      cbStocked.Checked := True
    else
      cbStocked.Checked := False;
    case qryItem.FieldByName('PARETOCATEGORY').AsString[1] of
      'A' : rbAPAreto.Checked := True;
      'B' : rbBPAreto.Checked := True;
      'C' : rbCPAreto.Checked := True;
      'D' : rbDPAreto.Checked := True;
      'E' : rbEPAreto.Checked := True;
      'F' : rbFPAreto.Checked := True;
      'M' : rbMPAreto.Checked := True;
      'X' : rbXPAreto.Checked := True;
    end;
    edtSSDays.Text := IntToStr(Trunc(qryItem.FieldByName('SAFETYSTOCK').AsFloat * FNoDaysInPeriod));
    edtRCDays.Text := IntToStr(Trunc(qryItem.FieldByName('REPLENISHMENTCYCLE').AsFloat * FNoDaysInPeriod));
    edtRPDays.Text := IntToStr(Trunc(qryItem.FieldByName('REVIEWPERIOD').AsFloat * FNoDaysInPeriod));
    edtLTDays.Text := IntToStr(Trunc(qryItem.FieldByName('LEADTIME').AsFloat * FNoDaysInPeriod));
    edtTransitLT.Text := IntToStr(Trunc(qryItem.FieldByName('TRANSITLT').AsFloat * FNoDaysInPeriod));
    edtSOH.Text := IntToStr(Trunc(qryItem.FieldByName('STOCKONHAND').AsFloat));
    edtBO.Text := IntToStr(Trunc(qryItem.FieldByName('BACKORDER').AsFloat));
    edtCBO.Text := IntToStr(Trunc(qryItem.FieldByName('CONSOLIDATEDBRANCHORDERS').AsFloat));
    edtBinLevel.Text := IntToStr(Trunc(qryItem.FieldByName('BINLEVEL').AsFloat));
    edtMOQ.Text := IntToStr(Trunc(qryItem.FieldByName('MINIMUMORDERQUANTITY').AsFloat));
    edtOrderMult.Text := IntToStr(Trunc(qryItem.FieldByName('ORDERMULTIPLES').AsFloat));
    edtMinQty.Text := IntToStr(Trunc(qryItem.FieldByName('ABSOLUTEMINIMUMQUANTITY').AsFloat));
    cbCalcIdealArrival.Checked := qryItem.FieldByName('CALC_IDEAL_ARRIVAL_DATE').AsString = 'Y';

    edtItemBackorderRatio.Text := '';
    edtItemBOMBackorderRatio.Text := '';
    edtItemDRPBackorderRatio.Text := '';
    
    if not qryItem.FieldByName('BACKORDERRATIO').IsNull then
      edtItemBackorderRatio.Text := FloatToStr(qryItem.FieldByName('BACKORDERRATIO').AsFloat);
    if not qryItem.FieldByName('BOMBACKORDERRATIO').IsNull then
      edtItemBOMBackorderRatio.Text := FloatToStr(qryItem.FieldByName('BOMBACKORDERRATIO').AsFloat);
    if not qryItem.FieldByName('DRPBACKORDERRATIO').IsNull then
      edtItemDRPBackorderRatio.Text := FloatToStr(qryItem.FieldByName('DRPBACKORDERRATIO').AsFloat);

    UseStockBuild := cbStockBuild.Checked;
    if UseStockBuild then begin
      BuildStartDate := edtBuildStart.DateTime;
      ShutdownStart := edtShutdownStart.DateTime;
      ShutdownEnd := edtShutdownEnd.DateTime;
      OrdersDuringShutdown := cbSBOrders.Checked;
    end;

    cbStockBuild.Checked := False;
    if (qryItem.FieldByName('STOCK_BUILDNO').AsInteger > 0) then begin
      trnOptimiza.StartTransaction;
      try
        qryStockBuild.Close;
        qryStockBuild.ParamByName('STOCK_BUILDNO').AsInteger := qryItem.FieldByName('STOCK_BUILDNO').AsInteger;
        qryStockBuild.ExecQuery;
        cbStockBuild.Checked := True;
        cbSBOrders.Checked := (qryStockBuild.FieldByName('ORDERS_DURING_SHUTDOWN').AsString='Y');
        edtBuildStart.DateTime := qryStockBuild.FieldByName('START_BUILD').AsDateTime;
        edtShutdownStart.DateTime := qryStockBuild.FieldByName('START_SHUTDOWN').AsDateTime;
        edtShutdownEnd.DateTime := qryStockBuild.FieldByName('END_SHUTDOWN').AsDateTime;
      finally
        trnOptimiza.Commit;
        trnOptimiza.StartTransaction;
      end;
    end;

  end;
end;

procedure TForm1.SetItemParams;
begin
  with dmMainDLL do begin
    ItemNo := qryItem.FieldByName('ITEMNO').AsInteger;
    SalesToDate   := StrToInt(edtSTD.Text);
    Stocked := cbStocked.Checked;
    Pareto        := 'A';
    if rbAPAreto.Checked then
      Pareto        := 'A';
    if rbBPAreto.Checked then
      Pareto        := 'B';
    if rbCPAreto.Checked then
      Pareto        := 'C';
    if rbDPAreto.Checked then
      Pareto        := 'D';
    if rbEPAreto.Checked then
      Pareto        := 'E';
    if rbFPAreto.Checked then
      Pareto        := 'F';
    if rbMPAreto.Checked then
      Pareto        := 'M';
    if rbXPAreto.Checked then
      Pareto        := 'X';
    SSDays        := StrToInt(edtSSDays.Text);
    RCDays        := StrToInt(edtRCDays.Text);
    RPDays        := StrToInt(edtRPDays.Text);
    LTDays        := StrToInt(edtLTDays.Text);
    SSLTDays      := SSDays + LTDays;
    SSRCDays      := SSDays + RCDays;
    SSHalfRCDays  := SSDays + trunc(RCDays/2);
    SSRPDays      := SSDays + RPDays;
    SSLTRPDays    := SSDays + LTDays + RPDays;
    SSLTRCDays    := SSDays + LTDays + RCDays;

    TransitLTDays := StrToInt(edtTransitLT.Text);
    SOH           := StrToInt(edtSOH.Text);
    BO            := StrToInt(edtBO.Text);
    CBO           := StrToInt(edtCBO.Text);
    Bin           := StrToInt(edtBinLevel.Text);
    MOQ           := StrToInt(edtMOQ.Text);
    Mult          := StrToInt(edtOrderMult.Text);
    Min           := StrToInt(edtMinQty.Text);
    UseFixedLevels := cbFixedLevels.Checked;
    if UseFixedLevels then begin
      FixedSS := StrToInt(edtFixedSS.Text);
      FixedSSRC := StrToInt(edtFixedSSRC.Text);
    end;
    CalcIdealArrival := cbCalcIdealArrival.Checked;
    UseStockBuild := cbStockBuild.Checked;
    if UseStockBuild then begin
      BuildStartDate := edtBuildStart.DateTime;
      ShutdownStart := edtShutdownStart.DateTime;
      ShutdownEnd := edtShutdownEnd.DateTime;
      OrdersDuringShutdown := cbSBOrders.Checked;
    end;

    StockOnOrder := qryItem.FieldByName('STOCKONORDER').AsInteger;
    StockOnOrderOther := qryItem.FieldByName('STOCKONORDER_OTHER').AsInteger;
    StockOnOrderInLT := qryItem.FieldByName('STOCKONORDERINLT').AsInteger;
    StockOnOrderInLTOther := qryItem.FieldByName('STOCKONORDERINLT_OTHER').AsInteger;

    ProductCode := qryItem.FieldByName('PRODUCTCODE').AsString;
    LocationCode := dmTest.qryGetLocation.FieldByName('LOCATIONCODE').AsString;

  end;
end;


procedure TForm1.PopulateDailyGrid;
var
  i : integer;
begin
  with dmMainDLL do begin
    if not trnOptimiza.inTransaction then
      trnOptimiza.StartTransaction;
    try
      dmTest.qryTest.Close;
      dmTest.qryTest.Open;

      for i := 0 to FFP.Cnt-1 do begin
        dmTest.qryTest.Insert;
        dmTest.qryTest.FieldByName('CalendarNo').AsInteger := FFP.Cal[i].CalNo;
        dmTest.qryTest.FieldByName('StartDate').AsDateTime := trunc(FFP.Cal[i].Date);
        dmTest.qryTest.FieldByName('DayNo').AsInteger := i;
        dmTest.qryTest.FieldByName('WeekNo').AsInteger := FFP.Cal[i].WeekNo;
        dmTest.qryTest.FieldByName('DVal').AsInteger := FFP.Cal[i].DVal;
        dmTest.qryTest.FieldByName('Factor').AsFloat := FFP.Cal[i].Fact;
        dmTest.qryTest.FieldByName('BO').AsInteger := FFP.Dat[i].BO;
        dmTest.qryTest.FieldByName('PO').AsInteger := FFP.Dat[i].PO;
        dmTest.qryTest.FieldByName('CO').AsInteger := FFP.Dat[i].CO;
        dmTest.qryTest.FieldByName('FC').AsFloat := FFP.Dat[i].FC;
        dmTest.qryTest.FieldByName('BOMFC').AsInteger := FFP.Dat[i].BOM;
        dmTest.qryTest.FieldByName('DRPFC').AsInteger := FFP.Dat[i].DRP;
        dmTest.qryTest.FieldByName('OPENING').AsInteger := FFP.Dat[i].Open;
        dmTest.qryTest.FieldByName('CLOSING').AsInteger := FFP.Dat[i].Close;
        dmTest.qryTest.FieldByName('ORDERS').AsInteger := FFP.Dat[i].Order;
        dmTest.qryTest.FieldByName('RECEIPTS').AsInteger := FFP.Dat[i].Receive;
        dmTest.qryTest.FieldByName('MINIMUM').AsInteger := FFP.Dat[i].SS;
        dmTest.qryTest.FieldByName('MAXIMUM').AsInteger := FFP.Dat[i].Max;
        dmTest.qryTest.FieldByName('TOT').AsInteger := FFP.Dat[i].Tot;
        dmTest.qryTest.FieldByName('FCIn').AsFloat := FFP.Dat[i].FCIn;
        dmTest.qryTest.FieldByName('FCNew').AsFloat := FFP.Dat[i].FCNew;
        dmTest.qryTest.FieldByName('LostSales').AsFloat := FFP.Dat[i].Lost;
        dmTest.qryTest.FieldByName('Excess').AsFloat := FFP.Dat[i].Excess;
        dmTest.qryTest.Post;
      end;
      dmTest.qryTest.First;
    finally
      //dmTest.DefaultTrans.Commit;
    end;
  end;
end;

procedure TForm1.PopulatePOGrid;
var
  i : integer;
begin
  with dmMainDLL  do begin
    if not dmtest.trnOptimiza.InTransaction then
     dmtest.trnOptimiza.StartTransaction;
    try
      dmTest.qryPOGrid.Close;
      dmTest.qryPOGrid.Open;
      for i := 0 to FPO.Cnt-1 do begin
        if FPO.Arr[i].PODate >= FStockDownloadDate then begin
          dmTest.qryPOGrid.Insert;
          dmTest.qryPOGrid.FieldByName('ORDERNUMBER').AsString := IntToStr(FPO.Arr[I].PONo);
          dmTest.qryPOGrid.FieldByName('ORDERDATE').AsDateTime := FPO.Arr[i].PODate;
          dmTest.qryPOGrid.FieldByName('EXPECTEDARRIVALDATE').AsDateTime := FPO.Arr[i].PODate;
          dmTest.qryPOGrid.FieldByName('IDEAL_ARRIVAL_DATE').AsDateTime := FPO.Arr[i].POIdealDate;
          dmTest.qryPOGrid.FieldByName('QUANTITY').AsFloat := FPO.Arr[i].POQty;
          dmTest.qryPOGrid.FieldByName('EXPEDITED').AsString := FPO.Arr[i].POExpedited;
          dmTest.qryPOGrid.Post;
        end;
      end;
      dmTest.qryPOGrid.First;
    finally
      // dmTest.DefaultTrans.Commit;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ErrMsg          : string;
begin
  if dmMainDLL = nil then
    dmMainDLL := TdmMainDLL.Create(Self);

  {if FwdPlanDLLDataModule.DLLVersion <> ELConstants.FWD_PLAN_VERSION then
  begin
    ErrMsg := Format(GetMessage(msg_FwdPlanVersionMismatchDLL),[FwdPlanDLLDataModule.DLLVersion,ELConstants.FWD_PLAN_VERSION]);
    Error(ErrMsg, 0);
  end; }
  dmTest.OpenLocation;
  dmMainDLL.LocationNo := dmTest.qryGetLocation.FieldBYName('LOCATIONNO').AsInteger;
  dmMainDLL.GetConfigParams;
  ShowConfigParams;

  OpenItemTable;
  edtProductCode.Text := dmMainDLL.qryItem.FieldByName('PRODUCTCODE').AsString;

end;

procedure TForm1.btnDataClick(Sender: TObject);
var
  DoCalcResult : integer;
begin
  try
    SetConfigParams;
    SetItemParams;
    DoCalcResult := dmMainDLL.DoCalc;
    if DoCalcResult = 0 then begin
      edtIdealArrival.Text := DateToStr(dmMainDLL.FParams.IdealArrivalDate);
      PopulateDailyGrid;
      PopulatePOGrid;
      ShowDailyGraph;
      ShowWeeklyGraph;
      ShowMonthlyGraph;
      btnSaveParamsToFile.Enabled := True;
      btnSaveResultsToFile.Enabled := True;
    end
    else begin
      Case DoCalcResult of
        -1 : ShowMessage('The start date is larger that the end date for a period');
        -2 : ShowMessage('There is a gap between the end of one period and the start of the next');
        -3 : ShowMessage('The stock download date is not in the first period');
        -4 : ShowMessage('No calendar specified to create a day calendar from');
        -5 : ShowMessage('Stock build dates invalid');
      end;
    end;
  except
    on e:exception do
      ShowMessage(e.Message);
  end;
end;

procedure TForm1.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  edtProductCode.Text := dmMainDLL.qryItem.FieldByName('PRODUCTCODE').AsString;
  ShowItemParams;
end;

procedure TForm1.DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
begin
  dmMainDLL.LocationNo := dmTest.qryLocationLOCATIONNO.AsInteger;
  dmMainDLL.GetConfigParams;
  ShowConfigParams;
  OpenItemTable;
  btnLoadItem.Click;
end;


procedure TForm1.ShowDailyGraph;
var
  Cnt : integer;
  GraphDate, GraphIdealDate : TDateTime;
  TotPO, TotExpeditedPO, TotDeExpeditedPO : integer;
begin
  chrtWeekly.BottomAxis.Increment := DateTimeStep[ dtOneDay ];
  DExcessSeries.Clear;
  DLeadTimeSeries.Clear;
  DModelSeries.Clear;
  DOrderSeries.Clear;
  DReceiptSeries.Clear;
  DSOHSeries.Clear;
  DPOSeries.Clear;
  DMinSeries.Clear;
  DSSSeries.Clear;
  DSSRCSeries.Clear;
  DIdealArrivalSeries.Clear;
  DPOExpeditedSeries.Clear;
  DPODeExpeditedSeries.Clear;
  DBuildSeries.Clear;
  DShutdownSeries.Clear;
  with dmMainDll do begin
    if FParams.CalcIdealArrival then
      DIdealArrivalSeries.AddXY(Trunc(FParams.IdealArrivalDate), 1, FormatDateTime('DD-MMM',FParams.IdealArrivalDate), $00C080FF);
    for Cnt := 0 to GraphLen do begin
      if Cnt < FFP.Cnt-1 then begin
(*        if Cnt < FParams.LTDays then begin
          DLeadTimeSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), 1, '');
        end else begin
          DLeadTimeSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), 0, '');
        end;   *)  
        DExcessSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Excess, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        DOrderSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Order, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        DReceiptSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Receive, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        DSOHSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Close, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        DMinSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Min, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        DSSSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].SS, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        DSSRCSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Max, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        if (FParams.Stocked) and (FParams.Pareto <> 'M') then begin
          DModelSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Model, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        end;
      end;
    end;
    if FPO.Cnt > 0 then begin
      GraphDate := Trunc(FPO.Arr[0].PODate);
      TotPO := 0;
      for Cnt:= 0 to FPO.Cnt-1 do begin
        if Trunc(FPO.Arr[Cnt].PODate) <> GraphDate then begin
          DPOSeries.AddXY(GraphDate, TotPO, FormatDateTime('DD-MMM', GraphDate));
          TotPO := FPO.Arr[Cnt].POQty;
          GraphDate := Trunc(FPO.Arr[Cnt].PODate);
        end
        else begin
          TotPO := TotPO + FPO.Arr[Cnt].POQty;
        end;
      end;
      if TotPO > 0 then
        DPOSeries.AddXY(GraphDate, TotPO, FormatDateTime('DD-MMM', GraphDate));
      GraphIdealDate := Trunc(FPO.Arr[0].POIdealDate);
      TotExpeditedPO := 0;
      TotDeExpeditedPO := 0;
      for Cnt:= 0 to FPO.Cnt-1 do begin
        if FPO.Arr[Cnt].POIdealDate <> FPO.Arr[Cnt].PODate then begin
          if Trunc(FPO.Arr[Cnt].POIdealDate) <> GraphIdealDate then begin
            if FPO.Arr[Cnt].POIdealDate < FPO.Arr[Cnt].PODate then begin
              DPOExpeditedSeries.AddXY(GraphIdealDate, TotExpeditedPO, FormatDateTime('DD-MMM', GraphIdealDate));
              TotExpeditedPO := FPO.Arr[Cnt].POQty;
            end
            else begin
              DPODeExpeditedSeries.AddXY(GraphIdealDate, TotDeExpeditedPO, FormatDateTime('DD-MMM', GraphIdealDate));
              TotDeExpeditedPO := FPO.Arr[Cnt].POQty;
            end;
            GraphIdealDate := Trunc(FPO.Arr[Cnt].POIdealDate);
          end
          else begin
            if Trunc(FPO.Arr[Cnt].POIdealDate) < GraphIdealDate then
              TotExpeditedPO := TotExpeditedPO + FPO.Arr[Cnt].POQty
            else
              TotDeExpeditedPO := TotDeExpeditedPO + FPO.Arr[Cnt].POQty
          end;
        end;
      end;
      if TotExpeditedPO > 0 then
        DPOExpeditedSeries.AddXY(GraphIdealDate, TotExpeditedPO, FormatDateTime('DD-MMM', GraphIdealDate));
      if TotDeExpeditedPO > 0 then
        DPODeExpeditedSeries.AddXY(GraphIdealDate, TotDeExpeditedPO, FormatDateTime('DD-MMM', GraphIdealDate));
    end;
(*    if FParams.UseStockBuild then begin
      MaxValue := chrtDaily.LeftAxis.Maximum;
      FirstDate := FFP.Cal[0].Date;
      StartBuildLoop := Trunc(FParams.BuildStartDate - FirstDate);
      EndBuildLoop := Trunc(FParams.EffShutdownStart - FirstDate);
      EndShutdownLoop := Trunc(FParams.EffShutdownEnd - FirstDate);

      for I := StartBuildLoop to EndBuildLoop do begin
        DBuildSeries..AddXY(Trunc(FFP.Cal[I].Date), MaxValue, FormatDateTime('DD-MMM',FFP.Cal[I].Date), $00FF8080);
      end;
      for I := EndBuildLoop+1 to EndShutdownLoop do begin
        DShutdownSeries.AddXY(Trunc(FFP.Cal[I].Date), MaxValue, FormatDateTime('DD-MMM',FFP.Cal[I].Date), $00C080FF);
      end;
    end; *)
  end;

end;


procedure TForm1.ShowWeeklyGraph;
var
  Cnt, NoWeeks : integer;
begin
  chrtWeekly.BottomAxis.Increment := DateTimeStep[ dtOneWeek ];
  WStockBuildSeries.Clear;
  WDemandSeries.Clear;
  WForecastSeries.Clear;
  WDRPSeries.Clear;
  WBOMSeries.Clear;
  WCOSeries.Clear;
  WBOSeries.Clear;
  WExcessSeries.Clear;
  WProjectedOrderSeries.Clear;
  WShipmentSeries.Clear;
  WReceiptsSeries.Clear;
  WOnHandSeries.Clear;
  with dmMainDll do begin
    NoWeeks := trunc((FFP.Cnt)/7);
    for Cnt := 0 to NoWeeks do begin
      WDemandSeries.AddXY(WeekDate[Cnt], WeekFC[Cnt] + WeekBOM[Cnt] + WeekDRP[Cnt], '');
      WForecastSeries.AddXY(WeekDate[Cnt], WeekFC[Cnt], '');
      WDRPSeries.AddXY(WeekDate[Cnt], WeekDRP[Cnt], '');
      WBOMSeries.AddXY(WeekDate[Cnt], WeekBOM[Cnt], '');
      WCOSeries.AddXY(WeekDate[Cnt], WeekCO[Cnt], '');
      WBOSeries.AddXY(WeekDate[Cnt], WeekBO[Cnt], '');
      WExcessSeries.AddXY(WeekDate[Cnt], WeekExcess[Cnt], '');
      WProjectedOrderSeries.AddXY(WeekDate[Cnt], WeekOrder[Cnt], '');
      WShipmentSeries.AddXY(WeekDate[Cnt], WeekPO[Cnt], '');
      WReceiptsSeries.AddXY(WeekDate[Cnt], WeekReceive[Cnt], '');
      WOnHandSeries.AddXY(WeekDate[Cnt], WeekClose[Cnt], '');
    end;
  end;
end;

procedure TForm1.ShowMonthlyGraph;
var
  Cnt : integer;
  TitleDate : TDateTime;
begin
  chrtMonthly.BottomAxis.Increment := DateTimeStep[ dtOneMonth ];
  MStockBuildSeries.Clear;
  MDemandSeries.Clear;
  MForecastSeries.Clear;
  MDRPSeries.Clear;
  MBOMSeries.Clear;
  MCOSeries.Clear;
  MBOSeries.Clear;
  MExcessSeries.Clear;
  MProjectedOrderSeries.Clear;
  MShipmentSeries.Clear;
  MReceiptsSeries.Clear;
  MOnHandSeries.Clear;
  with dmMainDll do begin
    TitleDate := FFP.Cal[0].Date;
    MOnHandSeries.AddXY(TitleDate-30, FFP.Dat[0].Open, 'Overdue');
    MDemandSeries.AddXY(TitleDate-30, 0, 'Overdue');
    MForecastSeries.AddXY(TitleDate-30, 0, 'Overdue');
    MDRPSeries.AddXY(TitleDate-30, 0, 'Overdue');
    MBOMSeries.AddXY(TitleDate-30, 0, 'Overdue');
    MCOSeries.AddXY(TitleDate-30, 0, 'Overdue');
    MBOSeries.AddXY(TitleDate-30, FParams.BO, 'Overdue');
    MExcessSeries.AddXY(TitleDate-30, 0, 'Overdue');
    MProjectedOrderSeries.AddXY(TitleDate-30, 0, 'Overdue');
    MShipmentSeries.AddXY(TitleDate-30, 0, 'Overdue');
    MReceiptsSeries.AddXY(TitleDate-30, 0, 'Overdue');

    for Cnt := 0 to FNoPeriodsFC do begin
      MDemandSeries.AddXY(MonthDate[Cnt], MonthFC[Cnt] + MonthBOM[Cnt] + MonthDRP[Cnt], FormatDateTime('MMM-YY', MonthDate[Cnt]));
      MForecastSeries.AddXY(MonthDate[Cnt], MonthFC[Cnt], '');
      MDRPSeries.AddXY(MonthDate[Cnt], MonthDRP[Cnt], '');
      MBOMSeries.AddXY(MonthDate[Cnt], MonthBOM[Cnt], '');
      MCOSeries.AddXY(MonthDate[Cnt], MonthCO[Cnt], '');
      MBOSeries.AddXY(MonthDate[Cnt], MonthBO[Cnt], '');
      MExcessSeries.AddXY(MonthDate[Cnt], MonthExcess[Cnt], '');
      MProjectedOrderSeries.AddXY(MonthDate[Cnt], MonthOrder[Cnt], '');
      MShipmentSeries.AddXY(MonthDate[Cnt], MonthPO[Cnt], '');
      MReceiptsSeries.AddXY(MonthDate[Cnt], MonthReceive[Cnt], '');
      MOnHandSeries.AddXY(MonthDate[Cnt], MonthClose[Cnt], '');
    end;
  end;
end;

procedure TForm1.btnLoadItemClick(Sender: TObject);
begin
    ShowItemParams;
   // btnData.Click;
end;

procedure TForm1.rgTypeSimClick(Sender: TObject);
begin
  if rgTypeSim.ItemIndex = 3 then
    edtFixedHorizon.Enabled := True
  else
    edtFixedHorizon.Enabled := False;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  edtBuildStart.Date :=   dmMainDll.FStockDownloadDate;
  edtShutdownStart.Date := dmMainDll.FStockDownloadDate;
  edtShutdownEnd.Date := dmMainDll.FStockDownloadDate;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if dmMainDll <> nil then begin
    dmMainDll.Free;
    dmMainDll := nil;
  end;
end;

procedure TForm1.btnSaveParamsToFileClick(Sender: TObject);
begin
  if dlgSaveParams.Execute then
    dmMainDll.SaveToFile(dlgSaveParams.FileName);
end;

procedure TForm1.btnSaveResultsToFileClick(Sender: TObject);
begin
  if dlgSaveResults.Execute then
    dmMainDll.SaveResultsToFile(dlgSaveResults.FileName);
end;

procedure TForm1.ShowLoadedItemParams;
begin
  with dmMainDll do begin
    edtSTD.Text := FloatToStr(SalesToDate);
    if Stocked then
      cbStocked.Checked := True
    else
      cbStocked.Checked := False;
    case Pareto of
      'A' : rbAPAreto.Checked := True;
      'B' : rbBPAreto.Checked := True;
      'C' : rbCPAreto.Checked := True;
      'D' : rbDPAreto.Checked := True;
      'E' : rbEPAreto.Checked := True;
      'F' : rbFPAreto.Checked := True;
      'M' : rbMPAreto.Checked := True;
      'X' : rbXPAreto.Checked := True;
    end;
    edtSSDays.Text := IntToStr(SSDays);
    edtRCDays.Text := IntToStr(RCDays);
    edtRPDays.Text := IntToStr(RPDays);
    edtLTDays.Text := IntToStr(LTDays);
    edtTransitLT.Text := IntToStr(TransitLTDays);
    edtSOH.Text := IntToStr(SOH);
    edtBO.Text := IntToStr(BO);
    edtCBO.Text := IntToStr(CBO);
    edtBinLevel.Text := IntToStr(Bin);
    edtMOQ.Text := IntToStr(MOQ);
    edtOrderMult.Text := IntToStr(Mult);
    edtMinQty.Text := IntToStr(Min);
    edtFixedSS.Text := '0';
    edtFixedSSRC.Text := '0';
    edtIdealArrival.Text := '';
    cbCalcIdealArrival.Checked := CalcIdealArrival;
    if UseStockBuild then
      cbStockBuild.Checked;
    if UseStockBuild then begin
      edtBuildStart.DateTime := BuildStartDate;
      edtShutdownStart.DateTime := ShutdownStart;
      edtShutdownEnd.DateTime := ShutdownEnd;
      cbSBOrders.Checked := OrdersDuringShutdown;
    end;
    edtProductCode.Text := ProductCode;
  end;
end;


procedure TForm1.btnLoadFromFileClick(Sender: TObject);
var
  DoCalcResult : integer;
begin
  if dlgLoad.Execute then begin
    dmMainDll.ReadFromFile(dlgLoad.FileName);
    ShowConfigParams;
    ShowLoadedItemParams;
    DoCalcResult := dmMainDll.DoWICalc;
    if DoCalcResult = 0 then begin
      edtIdealArrival.Text := DateToStr(dmMainDll.FParams.IdealArrivalDate);
      PopulateDailyGrid;
      PopulatePOGrid;
      ShowDailyGraph;
      ShowWeeklyGraph;
      ShowMonthlyGraph;
      btnSaveParamsToFile.Enabled := True;
      btnSaveResultsToFile.Enabled := True;
    end
    else
      ShowMessage(IntToStr(DoCalcResult));
  end
  else
    ShowMessage('File not loaded');
end;

procedure TForm1.ItemForecastClick(Sender: TObject);
begin
  if ItemForecast.Checked then begin
    ItemForecast.Caption := 'ItemDailyForecast';
    dmMainDll.UseDailyBOMDRP := True;
  end
  else begin
    ItemForecast.Caption := 'ItemForecast';
    dmMainDll.UseDailyBOMDRP := False;
  end;
end;

procedure TForm1.OpenItemTable;
begin

  //This needs to open here so we can customize and build filters
  with dmMainDLL.qryItem do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select p.ProductCode, p.ProductDescription,');
    SQL.Add('         l.LocationCode,           ');
    SQL.Add('         s.SupplierCode as Vendor,   ');
    SQL.Add('         i.ItemNo,              ');
    SQL.Add('         i.ParetoCategory, ');
    SQL.Add('         i.StockingIndicator, ');
    SQL.Add('         i.StockOnHand, ');
    SQL.Add('         i.CONSOLIDATEDBRANCHORDERS,');
    SQL.Add('         i.BackOrder,');
    SQL.Add('         i.BinLevel,');
    SQL.Add('         i.SafetyStock,');
    SQL.Add('         i.LeadTime,');
    SQL.Add('         i.ReviewPeriod,');
    SQL.Add('         i.ReplenishmentCycle,');
    SQL.Add('         i.MINIMUMORDERQUANTITY,');
    SQL.Add('         i.OrderMultiples,');
    SQL.Add('         i.LeadTime * 30.4 as LTDays,');
    SQL.Add('         sale.SalesAmount_0 as S0,');
    SQL.Add('         sale.SalesAmount_0,');
    SQL.Add('         i.TransitLT,');
    SQL.Add('          i.Stock_BuildNo,');
    SQL.Add('          sb.Start_Build,');
    SQL.Add('          sb.Start_ShutDown,');
    SQL.Add('          sb.End_Shutdown,');
    SQL.Add('          sb.Orders_During_Shutdown');
    SQL.Add('         ,i.BackOrderRatio');
    SQL.Add('         ,i.Forward_SS,');
    SQL.Add('         i.FOrward_SSRC,');
    SQL.Add('         i.RecommendedOrder,');
    SQL.Add('         i.TopupOrder,');
    SQL.Add('         i.IdealOrder,');
    SQL.Add('         i.AbsoluteMinimumQuantity,');
    SQL.Add('         i.CALC_IDEAL_ARRIVAL_DATE,');
    SQL.Add('         i.StockOnOrder,');
    SQL.Add('         i.StockOnOrder_Other,');
    SQL.Add('         i.StockOnOrderInLT,');
    SQL.Add('         i.StockOnOrderInLT_Other,');
    SQL.Add('         i.BOMBackOrderRatio,');
    SQL.Add('         i.DRPBackOrderRatio');

    SQL.Add(' from Item i join product p on p.productno = i.productno');
    SQL.Add('               join location l on l.locationno=i.locationno');
    SQL.Add('               join ItemSales sale on i.Itemno=sale.ItemNo');
    SQL.Add('               join Supplier S on s.SupplierNo=i.SupplierNo1');
    SQL.Add('               left Join Stock_Build sb on i.Stock_BuildNo=sb.Stock_BuildNo');

    SQL.Add(' where locationno = :LocNo');
    SQL.Add('  and i.StockingUnitFactor > 0.0000');

    //NB must be in prodcode sequence for other processes
    SQL.Add(' order by p.ProductCode');

    ParamByName('LocNo').AsInteger := dmTest.qryGetLocation.FieldBYName('LOCATIONNO').AsInteger;
    ExecQuery;

  end;

end;

end.
