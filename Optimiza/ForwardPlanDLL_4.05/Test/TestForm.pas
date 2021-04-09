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
    edtPOPerc: TEdit;
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
    edtSS: TEdit;
    edtRC: TEdit;
    edtRP: TEdit;
    edtLT: TEdit;
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
    CheckBox1: TCheckBox;
    DBuildSeries: TBarSeries;
    Label47: TLabel;
    Label48: TLabel;
    edtEffSS: TEdit;
    edtEffSE: TEdit;
    Button1: TButton;
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
    procedure CheckBox1Click(Sender: TObject);
    procedure cbStockBuildClick(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    { This function round a floating value to nearist Integer }
    function ELRound(Val : Double) : Double;
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
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses TestDM, dmFwdPlanDLL;

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
  with FwdPlanDLLDataModule do begin
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

    edtPOPerc.Text := FloatToStr(FFWDPOPercentage*100);

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
  with FwdPlanDLLDataModule do begin
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

    FFWDPOPercentage := StrToFloat(edtPOPerc.Text)/100;

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
  with FwdPlanDLLDataModule do begin
    edtSTD.Text := IntToStr(dmTest.qryItemSALESAMOUNT_0.AsInteger);
    if dmTest.qryItemSTOCKINGINDICATOR.AsString = 'Y' then
      cbStocked.Checked := True
    else
      cbStocked.Checked := False;
    case dmTest.qryItemPARETOCATEGORY.AsString[1] of
      'A' : rbAPAreto.Checked := True;
      'B' : rbBPAreto.Checked := True;
      'C' : rbCPAreto.Checked := True;
      'D' : rbDPAreto.Checked := True;
      'E' : rbEPAreto.Checked := True;
      'F' : rbFPAreto.Checked := True;
      'M' : rbMPAreto.Checked := True;
      'X' : rbXPAreto.Checked := True;
    end;
    edtSS.Text := FloatToStr(dmTest.qryItemSAFETYSTOCK.AsFloat);
    edtRC.Text := FloatToStr(dmTest.qryItemREPLENISHMENTCYCLE.AsFloat);
    edtRP.Text := FloatToStr(dmTest.qryItemREVIEWPERIOD.AsFloat);
    edtLT.Text := FloatToStr(dmTest.qryItemLEADTIME.AsFloat);

    edtTransitLT.Text := IntToStr(Trunc(ELRound(dmTest.qryItemTRANSITLT.AsFloat * FNoDaysInPeriod)));
    edtSOH.Text := IntToStr(Trunc(dmTest.qryItemSTOCKONHAND.AsFloat));
    edtBO.Text := IntToStr(Trunc(dmTest.qryItemBACKORDER.AsFloat));
    edtCBO.Text := IntToStr(Trunc(dmTest.qryItemCONSOLIDATEDBRANCHORDERS.AsFloat));
    edtBinLevel.Text := IntToStr(Trunc(dmTest.qryItemBINLEVEL.AsFloat));
    edtMOQ.Text := IntToStr(Trunc(dmTest.qryItemMINIMUMORDERQUANTITY.AsFloat));
    edtOrderMult.Text := IntToStr(Trunc(dmTest.qryItemORDERMULTIPLES.AsFloat));
    edtMinQty.Text := IntToStr(Trunc(dmTest.qryItemABSOLUTEMINIMUMQUANTITY.AsFloat));
    cbCalcIdealArrival.Checked := dmTest.qryItemCALC_IDEAL_ARRIVAL_DATE.AsString = 'Y';

    edtItemBackorderRatio.Text := '';
    edtItemBOMBackorderRatio.Text := '';
    edtItemDRPBackorderRatio.Text := '';
    
    if not dmTest.qryItem.FieldByName('BACKORDERRATIO').IsNull then
      edtItemBackorderRatio.Text := FloatToStr(dmTest.qryItem.FieldByName('BACKORDERRATIO').AsFloat);
    if not dmTest.qryItem.FieldByName('BOMBACKORDERRATIO').IsNull then
      edtItemBOMBackorderRatio.Text := FloatToStr(dmTest.qryItem.FieldByName('BOMBACKORDERRATIO').AsFloat);
    if not dmTest.qryItem.FieldByName('DRPBACKORDERRATIO').IsNull then
      edtItemDRPBackorderRatio.Text := FloatToStr(dmTest.qryItem.FieldByName('DRPBACKORDERRATIO').AsFloat);

    UseStockBuild := cbStockBuild.Checked;
//    if UseStockBuild then begin
      BuildStartDate := edtBuildStart.DateTime;
      ShutdownStart := edtShutdownStart.DateTime;
      ShutdownEnd := edtShutdownEnd.DateTime;
      OrdersDuringShutdown := cbSBOrders.Checked;
//    end else begin
//      BuildStartDate := 0;
//      ShutdownStart  := 0;
//      ShutdownEnd    := 0;
//      OrdersDuringShutdown := True;
//    end;

    cbStockBuild.Checked := False;
    if (dmTest.qryItem.FieldByName('STOCK_BUILDNO').AsInteger > 0) then begin
      dmTest.DefaultTrans.StartTransaction;
      try
        dmTest.qryStockBuild.Close;
        dmTest.qryStockBuild.ParamByName('STOCK_BUILDNO').AsInteger := dmTest.qryItem.FieldByName('STOCK_BUILDNO').AsInteger;
        dmTest.qryStockBuild.ExecQuery;
        cbStockBuild.Checked := True;
        cbSBOrders.Checked := (dmTest.qryStockBuild.FieldByName('ORDERS_DURING_SHUTDOWN').AsString='Y');
        edtBuildStart.DateTime := dmTest.qryStockBuild.FieldByName('START_BUILD').AsDateTime;
        edtShutdownStart.DateTime := dmTest.qryStockBuild.FieldByName('START_SHUTDOWN').AsDateTime;
        edtShutdownEnd.DateTime := dmTest.qryStockBuild.FieldByName('END_SHUTDOWN').AsDateTime;
      finally
        dmTest.DefaultTrans.Commit;
      end;
    end;

  end;
end;

procedure TForm1.SetItemParams;
begin
  with FwdPlanDLLDataModule do begin
    ItemNo := dmTest.qryItemITEMNO.AsInteger;
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

    FParams.SS := StrToFloat(edtSS.Text);
    FParams.RC := StrToFloat(edtRC.Text);
    FParams.RP := StrToFloat(edtRP.Text);
    FParams.LT := StrToFloat(edtLT.Text);

    SSDays := trunc(ELRound(FParams.SS * FNoDaysInPeriod));
    RCDays := trunc(ELRound(FParams.RC * FNoDaysInPeriod));
    RPDays := trunc(ELRound(FParams.RP * FNoDaysInPeriod));
    LTDays := trunc(ELRound(FParams.LT * FNoDaysInPeriod));

    SSLTDays      := SSDays + LTDays;
    SSRCDays      := SSDays + RCDays;
    SSHalfRCDays  := SSDays + (RCDays div 2);
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
    end else begin
      BuildStartDate := 0;
      ShutdownStart := 0;
      ShutdownEnd := 0;
      OrdersDuringShutdown := True;
      FParams.EffShutdownStart := 0;
      FParams.EffShutdownEnd := 0;
    end;

    StockOnOrder := dmTest.qryItem.FieldByName('STOCKONORDER').AsInteger;
    StockOnOrderOther := 0;//dmTest.qryItem.FieldByName('STOCKONORDER_OTHER').AsInteger;
    StockOnOrderInLT := dmTest.qryItem.FieldByName('STOCKONORDERINLT').AsInteger;
    StockOnOrderInLTOther := 0; //dmTest.qryItem.FieldByName('STOCKONORDERINLT_OTHER').AsInteger;

    ProductCode := dmTest.qryItem.FieldByName('PRODUCTCODE').AsString;
    LocationCode := dmTest.qryLocation.FieldByName('LOCATIONCODE').AsString;

  end;
end;


procedure TForm1.PopulateDailyGrid;
var
  i : integer;
begin
  with FwdPlanDLLDataModule do begin
    if not dmTest.DefaultTrans.inTransaction then
      dmTest.DefaultTrans.StartTransaction;
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
        dmTest.qryTest.FieldByName('FWDPO').AsInteger := FFP.Dat[i].FwdPO;
        dmTest.qryTest.FieldByName('CO').AsInteger := FFP.Dat[i].COOverride;
        dmTest.qryTest.FieldByName('FC').AsFloat := FFP.Dat[i].FCOverride;
        dmTest.qryTest.FieldByName('BOMFC').AsInteger := FFP.Dat[i].BOM;
        dmTest.qryTest.FieldByName('DRPFC').AsInteger := FFP.Dat[i].DRP;
        dmTest.qryTest.FieldByName('OPENING').AsInteger := FFP.Dat[i].Open;
        dmTest.qryTest.FieldByName('CLOSING').AsInteger := FFP.Dat[i].Close;
        dmTest.qryTest.FieldByName('ORDERS').AsInteger := FFP.Dat[i].Order;
        dmTest.qryTest.FieldByName('RECEIPTS').AsInteger := FFP.Dat[i].Receive;
        if FParams.Pareto <> 'M' then begin
          dmTest.qryTest.FieldByName('MINIMUM').AsInteger := FFP.Dat[i].SS;
          dmTest.qryTest.FieldByName('MAXIMUM').AsInteger := FFP.Dat[i].SSRC;
        end
        else begin
          dmTest.qryTest.FieldByName('MINIMUM').AsInteger := FFP.Dat[i].Min;
          dmTest.qryTest.FieldByName('MAXIMUM').AsInteger := FFP.Dat[i].Max;
        end;
        dmTest.qryTest.FieldByName('TOT').AsInteger := FFP.Dat[i].Tot;
        dmTest.qryTest.FieldByName('FCIn').AsFloat := FFP.Dat[i].FCIn;
        dmTest.qryTest.FieldByName('LostSales').AsFloat := FFP.Dat[i].Lost;
        dmTest.qryTest.FieldByName('Excess').AsFloat := FFP.Dat[i].Excess;
        dmTest.qryTest.FieldByName('NEXTSSPOINT').AsInteger := FFP.Dat[i].NextSSPoint;
        dmTest.qryTest.FieldByName('NEXTRCPOINT').AsInteger := FFP.Dat[i].NextRCPoint;
        dmTest.qryTest.FieldByName('NEXTRPPOINT').AsInteger := FFP.Dat[i].NextRPPoint;
        dmTest.qryTest.FieldByName('PREVLTPOINT').AsInteger := FFP.Dat[i].PrevLTPoint;
        dmTest.qryTest.FieldByName('ORIGRCPOINT').AsInteger := FFP.Dat[i].OrigRCPoint;
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
  with FwdPlanDLLDataModule do begin
    if not dmTest.DefaultTrans.Intransaction then
      dmTest.DefaultTrans.StartTransaction;
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
      //dmTest.DefaultTrans.Commit;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ErrMsg : string;
begin
  if FwdPlanDLLDataModule = nil then
    FwdPlanDLLDataModule := TFwdPlanDLLDataModule.Create(Self);
  if FwdPlanDLLDataModule.DLLVersion <> FwdPlanDLLDataModule.FWD_PLAN_VERSION then
  begin
    ErrMsg := Format('The DLL internal version (%s) does not match the expected version (%s). Errors could occur, please make sure the correct DLL is in place.',[FwdPlanDLLDataModule.DLLVersion,FwdPlanDLLDataModule.FWD_PLAN_VERSION]);
    MessageDlg(ErrMsg, mtError, [mbOk], 0);
  end;
  dmTest.OpenLocation;
  FwdPlanDLLDataModule.LocationNo := dmTest.qryLocationLOCATIONNO.AsInteger;
  FwdPlanDLLDataModule.GetConfigParams;
  ShowConfigParams;
  //dmTest.OpenItemQuery;
  //edtProductCode.Text := dmTest.dscItem.DataSet.FieldByName('PRODUCTCODE').AsString;
//PJK
  //edtProductCode.Text := '0007';
  //btnLoadItem.Click;
end;

procedure TForm1.btnDataClick(Sender: TObject);
var
  DoCalcResult : integer;
begin
  try
    FwdPlanDLLDataModule.SetItemInfo(dmTest.qryItem, TRUE); // Sets the item parameters into the engine from the dataset
    SetConfigParams; // Will reset the system parameters from the screen
    SetItemParams;  // Will reset the item parameters from the screen - will override the previous item set when changes have been made
    DoCalcResult := FwdPlanDLLDataModule.DoCalc;
    if DoCalcResult = 0 then begin
      edtIdealArrival.Text := DateToStr(FwdPlanDLLDataModule.FParams.IdealArrivalDate);
//      edtPOPerc.Text := FloatToStr(FwdPlanDLLDataModule.FFWDPOPercentage);
      PopulateDailyGrid;
      PopulatePOGrid;
      ShowDailyGraph;
      ShowWeeklyGraph;
      ShowMonthlyGraph;
      edtEffSS.Text := DateToStr(FwdPlanDLLDataModule.FParams.EffShutdownStart);
      edtEffSE.Text := DateToStr(FwdPlanDLLDataModule.FParams.EffShutdownEnd);
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
  edtProductCode.Text := dmTest.dscItem.DataSet.FieldByName('PRODUCTCODE').AsString;
  ShowItemParams;
  btnData.Click;
end;

procedure TForm1.DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
begin
  FwdPlanDLLDataModule.LocationNo := dmTest.qryLocationLOCATIONNO.AsInteger;
  FwdPlanDLLDataModule.GetConfigParams;
  ShowConfigParams;
  dmTest.OpenItemQuery;
  if not dmTest.dscItem.DataSet.Locate('PRODUCTCODE', edtproductCode.Text,[]) then
    dmTest.dscItem.DataSet.First;
  edtProductCode.Text := dmTest.dscItem.DataSet.FieldByName('PRODUCTCODE').AsString;
  btnLoadItem.Click;
end;


procedure TForm1.ShowDailyGraph;
var
  Cnt : integer;
  GraphDate, GraphIdealDate : TDateTime;
  TotPO, TotExpeditedPO, TotDeExpeditedPO : integer;

  FirstDate : TDateTime;
  StartBuildLoop : integer;
  EndBuildLoop : Integer;
  EndShutdownLoop : integer;
begin
{  for I := 0 to chrtWeekly.SeriesList.Count -1 do begin
    chrtWeekly.SeriesList.Series[I].Clear;
  end;
  with FwdPlanDLLDataModule do begin
    FirstDate := FFP.Cal[0].Date;

    StartBuildLoop := Trunc(FParams.BuildStartDate - FirstDate);
    EndBuildLoop := Trunc(FParams.EffShutdownStart - FirstDate);
    EndShutdownLoop := Trunc(FParams.EffShutdownEnd - FirstDate);

    for Cnt := 0 to GraphLen do begin
      if Cnt < FFP.Cnt-1 then begin
//        DBuildSeries.AddXY(Cnt, 1, '', clRed);
//        DExcessSeries.AddXY(Cnt, FFP.Dat[Cnt].Excess, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));

        if Cnt < StartBuildLoop then begin
          DBuildSeries.AddXY(Cnt, 0, '');
        end else if Cnt < EndBuildLoop then begin
          DBuildSeries.AddXY(Cnt, 1, '', clRed);
        end else if Cnt < EndShutdownLoop then begin
          DBuildSeries.AddXY(Cnt, 1, '', clBlue);
        end else begin
          DBuildSeries.AddXY(Cnt, 0, '');
        end;  (**)
      end;
    end;
  end;    }


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

  with FwdPlanDLLDataModule do begin
    FirstDate := FFP.Cal[0].Date;
    StartBuildLoop := Trunc(FParams.BuildStartDate - FirstDate);
    EndBuildLoop := Trunc(FParams.EffShutdownStart - FirstDate);
    EndShutdownLoop := Trunc(FParams.EffShutdownEnd - FirstDate);

(*    Showmessage(
      IntToStr(StartBuildLoop) + #13#10 +
      IntToStr(EndBuildLoop) + #13#10 +
      IntToStr(EndShutdownLoop) + #13#10
    );*)
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
//        DSOHSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Open - FFP.Dat[Cnt].Tot, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        DMinSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Min, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        DSSSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].SS, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        DSSRCSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Max, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
//        DSSRCSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Max-FFP.Dat[Cnt].Tot, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        if (FParams.Stocked) and (FParams.Pareto <> 'M') then begin
          DModelSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), FFP.Dat[Cnt].Model, FormatDateTime('DD-MMM', FFP.Cal[Cnt].Date));
        end;
      end;
      if Cnt < StartBuildLoop then begin
        DBuildSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), 0, '');
      end else if Cnt < EndBuildLoop then begin
        DBuildSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), 1, '', $00FF8080);
      end else if Cnt < EndShutdownLoop then begin
        DBuildSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), 1, '', $00C080FF);
      end else begin
        DBuildSeries.AddXY(Trunc(FFP.Cal[Cnt].Date), 0, '');
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

      for I := 0 to StartBuildLoop -1 do begin
        DBuildSeries.AddXY(I, 0, '', $00FF8080);
      end;
      for I := StartBuildLoop to EndBuildLoop do begin
        DBuildSeries.AddXY(I, MaxValue, '', $00FF8080);
      end;
      for I := EndBuildLoop+1 to EndShutdownLoop do begin
        DShutdownSeries.AddXY(I, MaxValue, '', $00C080FF);
      end;
      for I := EndShutdownLoop to FPO.Cnt-1 do begin
        DBuildSeries.AddXY(I, 0, '', $00FF8080);
      end;
    end; (**)
  end;
 {}
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
  with FwdPlanDLLDataModule do begin
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
  with FwdPlanDLLDataModule do begin
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
  if dmTest.dscItem.DataSet.Locate('PRODUCTCODE', edtproductCode.Text,[]) then begin
    ShowItemParams;
    btnData.Click;
  end
  else
    ShowMessage('Product code not found');
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
(*PJK
  edtBuildStart.Date :=   FwdPlanDLLDataModule.FStockDownloadDate;
  edtShutdownStart.Date := FwdPlanDLLDataModule.FStockDownloadDate;
  edtShutdownEnd.Date := FwdPlanDLLDataModule.FStockDownloadDate;
  (**)
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if FwdPlanDLLDataModule <> nil then begin
    FwdPlanDLLDataModule.Free;
    FwdPlanDLLDataModule := nil;
  end;
end;

procedure TForm1.btnSaveParamsToFileClick(Sender: TObject);
begin
  if dlgSaveParams.Execute then
    FwdPlanDLLDataModule.SaveToFile(dlgSaveParams.FileName);
end;

procedure TForm1.btnSaveResultsToFileClick(Sender: TObject);
begin
  if dlgSaveResults.Execute then
    FwdPlanDLLDataModule.SaveResultsToFile(dlgSaveResults.FileName);
end;

procedure TForm1.ShowLoadedItemParams;
begin
  with FwdPlanDLLDataModule do begin
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
    edtSS.Text := FloatToStr(FParams.SS);
    edtRC.Text := FloatToStr(FParams.RC);
    edtRP.Text := FloatToStr(FParams.RP);
    edtLT.Text := FloatToStr(FParams.LT);

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
    FwdPlanDLLDataModule.ReadFromFile(dlgLoad.FileName);
    ShowConfigParams;
    ShowLoadedItemParams;
    DoCalcResult := FwdPlanDLLDataModule.DoWICalc;
    if DoCalcResult = 0 then begin
      edtIdealArrival.Text := DateToStr(FwdPlanDLLDataModule.FParams.IdealArrivalDate);
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
    FwdPlanDLLDataModule.UseDailyBOMDRP := True;
  end
  else begin
    ItemForecast.Caption := 'ItemForecast';
    FwdPlanDLLDataModule.UseDailyBOMDRP := False;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if cbStockBuild.Checked <> CheckBox1.Checked then begin
    cbStockBuild.Checked := CheckBox1.Checked;
  end;
end;

procedure TForm1.cbStockBuildClick(Sender: TObject);
begin
  if cbStockBuild.Checked <> CheckBox1.Checked then begin
    CheckBox1.Checked := cbStockBuild.Checked;
  end;
end;

procedure TForm1.Panel3Click(Sender: TObject);
begin
  ShowMessage(dmTest.SVPDatabase.DatabaseName);
end;

function TForm1.ELRound(Val : Double) : Double;
begin
  { Do the Increment if nececarry }
  if Val < 0.0 then begin
    { If Negitive value the increment is actualy a decrement }
    if Abs(Frac(Val)) >= 0.5 then begin
      Val := Val - 1;
    end;
  end else begin
    { Else it is a true increment }
    if Abs(Frac(Val)) >= 0.5 then begin
      Val := Val + 1;
    end;
  end;
  Result := Trunc(Val); { Get rid of unwanted decimals }
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  dmTest.OpenItemQuery;
end;

end.
