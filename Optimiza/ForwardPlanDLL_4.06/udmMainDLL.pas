unit udmMainDLL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmFwdPlanDLL, DB, IBCustomDataSet, IBSQL, IBDatabase, IBQuery,
  IBStoredProc,FwdPlan,Math;

type
  TdmMainDLL = class(TFwdPlanDLLDataModule)
    qryTest: TIBDataSet;
    qryTestCALENDARNO: TIntegerField;
    qryTestSTARTDATE: TDateTimeField;
    qryTestWEEKNO: TIntegerField;
    qryTestDVAL: TIntegerField;
    qryTestFACTOR: TIntegerField;
    qryTestOPENING: TIntegerField;
    qryTestCLOSING: TIntegerField;
    qryTestORDERS: TIntegerField;
    qryTestRECEIPTS: TIntegerField;
    qryTestEXCESS: TIntegerField;
    qryTestBO: TIntegerField;
    qryTestLOSTSALES: TIntegerField;
    qryTestFWDPO: TIntegerField;
    qryTestPO: TIntegerField;
    qryTestCO: TIntegerField;
    qryTestFC: TIntegerField;
    qryTestDRPFC: TIntegerField;
    qryTestBOMFC: TIntegerField;
    qryTestMINIMUM: TIntegerField;
    qryTestMAXIMUM: TIntegerField;
    qryTestBUILDTOT: TIntegerField;
    qryTestSS: TIntegerField;
    qryTestTOT: TIntegerField;
    qryTestFCIN: TIntegerField;
    qryTestDAYNO: TIntegerField;
    dscTest: TDataSource;
    qryLocation: TIBDataSet;
    qryLocationLOCATIONNO: TIntegerField;
    qryLocationDESCRIPTION: TIBStringField;
    qryLocationLOCATIONCODE: TIBStringField;
    qryLocationCURRENCYNO: TIntegerField;
    dscLocation: TDataSource;
    qryItem1: TIBDataSet;
    qryItem1ITEMNO: TIntegerField;
    qryItem1LOCATIONCODE: TIBStringField;
    qryItem1LDESCRIPTION: TIBStringField;
    qryItem1PRODUCTCODE: TIBStringField;
    qryItem1PDESCRIPTION: TIBStringField;
    qryItem1STOCKINGINDICATOR: TIBStringField;
    qryItem1PARETOCATEGORY: TIBStringField;
    qryItem1SAFETYSTOCK: TFloatField;
    qryItem1LEADTIME: TFloatField;
    qryItem1REPLENISHMENTCYCLE: TFloatField;
    qryItem1REVIEWPERIOD: TFloatField;
    qryItem1STOCKONHAND: TFloatField;
    qryItem1BACKORDER: TFloatField;
    qryItem1MINIMUMORDERQUANTITY: TFloatField;
    qryItem1ORDERMULTIPLES: TFloatField;
    qryItem1CONSOLIDATEDBRANCHORDERS: TFloatField;
    qryItem1BINLEVEL: TFloatField;
    qryItem1SALESAMOUNT_0: TFloatField;
    qryItem1FORWARD_SS: TFloatField;
    qryItem1FORWARD_SSRC: TFloatField;
    qryItem1RECOMMENDEDORDER: TFloatField;
    qryItem1TOPUPORDER: TFloatField;
    qryItem1IDEALORDER: TFloatField;
    qryItem1LOCATIONNO: TIntegerField;
    qryItem1ABSOLUTEMINIMUMQUANTITY: TFloatField;
    qryItem1CALC_IDEAL_ARRIVAL_DATE: TIBStringField;
    qryItem1TRANSITLT: TFloatField;
    qryItem1STOCKONORDER: TFloatField;
    qryItem1STOCKONORDERINLT: TFloatField;
    qryItem1BACKORDERRATIO: TIntegerField;
    qryItem1BOMBACKORDERRATIO: TIntegerField;
    qryItem1DRPBACKORDERRATIO: TIntegerField;
    qryItem1STOCK_BUILDNO: TIntegerField;
    dscItem: TDataSource;
    qryPOGrid: TIBDataSet;
    qryPOGridPURCHASEORDERNO: TIntegerField;
    qryPOGridORDERNUMBER: TIBStringField;
    qryPOGridORDERDATE: TDateTimeField;
    qryPOGridEXPECTEDARRIVALDATE: TDateTimeField;
    qryPOGridIDEAL_ARRIVAL_DATE: TDateTimeField;
    qryPOGridQUANTITY: TFloatField;
    qryPOGridEXPEDITED: TIBStringField;
    dscPOGrid: TDataSource;
    trnOptimiza: TIBTransaction;
    qrySelectLocation: TIBQuery;
    srcSelectLocation: TDataSource;
    prcFireEvent: TIBStoredProc;
    CalendarEnd: TIBSQL;
    //qryItem1DIVISION: TIBStringField;
    qryItem: TIBSQL;
    qryGetLocation: TIBQuery;
    sqlDRPLexDailyDemand: TIBSQL;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FDbDescription:String;
    procedure GetBuildInfo(var V1, V2, V3, V4: Word);
    procedure SetItemStuff;
    procedure ZeroFC;
  public
    { Public declarations }
    Lex_UseBom:Boolean;
    Lex_UseDrp:Boolean;
    Lex_UseFC:Boolean;
    Lex_UseCO:Boolean;
    Lex_UsePO:Boolean;
    Lex_IgnoreMOQMult:Boolean;
    Lex_CalcAsNonStock:Boolean;
    Lex_FCRatio:Integer;
    Lex_CurrentForecast:Real;
    Lex_ForceBacko:Boolean;
    Lex_TypeOfSimulation:String;
    Lex_OverCOIs:String;
    Lex_OverFromSDD:String;
    Lex_OpenBackOrder:Integer;
    Lex_UseZeroMTDsales:Boolean;
    Lex_UseOwnDrp:Boolean;
    Lex_CurrFCUsage: TCurrFCUsage;
    Lex_Override_CurrFCUsage:Boolean;
    function kfVersionInfo: String;
    property DbDescription: String read FDbDescription write FDbDescription;
    function DLL_Calc:Integer;
    function GetCurrentPeriod:Integer;
    procedure Setup_Lex_DRPFC;
    procedure Open_Lex_DRPQuery;
  published
    function FireEvent(SuccessFail: Char):Boolean;
    function GetLocationNo(Location: String):Integer;
    procedure Calc_Lex_BO;
  end;

var
  dmMainDLL: TdmMainDLL;

implementation

{$R *.dfm}

function TdmMainDLL.FireEvent(SuccessFail: Char):Boolean;
begin

  //prcFireEvent.Params.Clear;
  try
    With prcFireEvent do begin

      if  not trnOptimiza.InTransaction then
        trnOptimiza.StartTransaction;

      Params[0].Value :=SuccessFail;
      Prepare;
      ExecProc;
      trnOptimiza.Commit;
      Result := True;
    end;
  except
    Result := False;
  end;



end;

procedure TdmMainDLL.GetBuildInfo(var V1, V2, V3, V4: Word);
var
   VerInfoSize, VerValueSize, Dummy : DWORD;
   VerInfo : Pointer;
   VerValue : PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

  With VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;

  FreeMem(VerInfo, VerInfoSize);

end;

function TdmMainDLL.kfVersionInfo: String;
var
  V1,       // Major Version
  V2,       // Minor Version
  V3,       // Release
  V4: Word; // Build Number
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.'
            + IntToStr(V2); // + '.';
            //+ IntToStr(V3) + '.'
            //+ IntToStr(V4);
end;

procedure TdmMainDLL.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FDbDescription := SVPDatabase.DatabaseName;
  Lex_UseBom:=True;
  Lex_UseDrp:=True;
  Lex_UseFC:=True;
  Lex_UseCO:=True;
  Lex_UsePO:=True;
  Lex_IgnoreMOQMult:=False;
  Lex_CalcAsNonStock:=False;
  Lex_FCRatio:=-1;
  Lex_ForceBacko:=False;
  Lex_TypeOfSimulation := '';    //use the system setting from config table if blank
  Lex_OverCOIs:=''; //use the system setting from config table if blank
  Lex_OverFromSDD:='';  //use the system setting from config table if blank
  Lex_OpenBackOrder := -1; //use the system value from table if -1
  Lex_UseZeroMTDSales := False;
  Lex_UseOwnDrp := False;
  Lex_Override_CurrFCUsage:=False;

end;

function TdmMainDLL.DLL_Calc: Integer;
var
  NoDays : integer;
  CalCreateResult : integer;
  Intrans : boolean;
begin
  FAdjustedDownloadDateStart := False;
  FAdjustedDownloadDateEnd   := False;



  qryCalendar.First;
  if trunc(FStockDownloadDate) < trunc(qryCalendar.FieldByName('STARTDATE').AsDateTime) then begin
    FStockDownloadDate := trunc(qryCalendar.FieldByName('STARTDATE').AsDateTime);
    FAdjustedDownloadDateStart := True;
  end;
  if trunc(FStockDownloadDate) > trunc(qryCalendar.FieldByName('ENDDATE').AsDateTime) then begin
    FStockDownloadDate := trunc(qryCalendar.FieldByName('ENDDATE').AsDateTime);
    FAdjustedDownloadDateEnd := True;
  end;


  SetItemStuff;
  LoadConfigParams;
  LoadItemParams;

  if Lex_OpenBackOrder <> -1 then
  begin
    FParams.BO := Lex_OpenBackOrder;
  end;

  // Override Simulation setting if necessary
  if Lex_TypeOfSimulation <> '' then
  begin

     case Lex_TypeOfSimulation[1] of
      'S': FParams.TypeOfSimulation := tsCurrent;
      'P': FParams.TypeOfSimulation := tsProjection;
      'I': FParams.TypeOfSimulation := tsIdeal;
    end;

  end;

  // Override Back order setting Backo, Current or Ignore
  if Lex_OverCOIs <> '' then
  begin

    case Lex_OverCOIs[1] of
      'B': FOverCOIs := 0;    //Overdue COs as Backos
      'C': FOverCOIs := 1;    //Overdue COs in Current Period
      'I': FOverCOIs := 2;    //Ignore Overdue COs
    end;

  end;

  if Lex_OverFromSDD <> '' then
  begin
    FOverFromSDD := Lex_OverFromSDD = 'S'; //Use (S)stock download or (P)eriod start
  end;

  //Lexian Overides Here
  if Lex_FCRatio >= 0 then
    FParams.FCRAtio := Lex_FCRatio;

  //Override Current Month FC = (fcUseProrate, fcUseSalesToDate, fcUseFull);
  if Lex_Override_CurrFCUsage then
    FParams.CurrFCUsage := Lex_CurrFCUsage;

  NoDays := (FNoPeriodsFC * FNoDaysInPeriod) + (trunc(FParams.LT + FParams.SS + FParams.RC)*FNoDaysInPeriod);

  if NoDays > MAX_CAL_ARRAY_SIZE then
    NoDays := MAX_CAL_ARRAY_SIZE;

  Intrans := DefaultTrans.InTransaction;
  if not Intrans then
    DefaultTrans.StartTransaction;
  try
    try
      OpenFCQuery(FCurrentPeriod);

      Lex_CurrentForecast := sqlFC.fieldByName('Forecast_0').AsFloat;


      try
        FFP.Cnt := NoDays; //PK Check this out.
        CalCreateResult := MakeCal(FFP, FCal, FFact, FParams);

        if CalCreateResult = 0 then begin
          if (Lex_UseCO) then
            OpenCOQuery;

          if (Lex_UsePO) then
            OpenPOQuery;

          if (FUseBOM) and (Lex_UseBom) then
            SetupBOMFC;

          if (FUseDRP) and (Lex_UseDrp) then
          begin
            if Lex_UseOwnDrp then
              Setup_Lex_DRPFC
            else
              SetupDRPFC;
          end;

          if (Lex_UseFC) then
            SetupFC
          else
          begin

            ZeroFC;
          end;



          if (Lex_UseCO) then
            SetupCO;

          if (Lex_UsePO) then
            SetupPO;


          if NoDays < FFP.Cnt then
            FFP.Cnt := NoDays;


          {$ifdef debug}
          QryStartTime := GetTickCount();
          {$endif}

          //convert the perc of LT to look forward to the number of days based on
          //the LT
          FParams.FWDPODays := Trunc(FParams.FWDPOPercentage * (FParams.LT*FParams.NoDaysInPeriod));
          FFWDPODays := FParams.FWDPODays;
          //NOTE Params.EffectiveLTDay is set in load demand and for that to
          // happen we must set Params.FWDPODays here
          LoadDemand(FFP, FFC, FCO, FBOM, FDRP, FPO, FParams);
          // This is the same for all forward plans and can be done before the levels is calculated
          // Calculate the Initial Level
          if (FParams.ZeroNegStock) and (FParams.SOH < 0) then
            FParams.SOH := 0;
          FParams.Level := FParams.SOH - FParams.BO - FParams.CBO + OverPO;

          // Call the apropriate Forward plan projection
          Result := FPProject(FFP, FPO, FParams, FCal);
          if CalculateWeekly  then
            CalculateWeeklyTotals;
          if CalculateMonthly then
            CalculateMonthlyTotals;
          {$ifdef debug}
          QryStopTime := GetTickCount();
          FwdPlanElapsedTime := FwdPlanElapsedTime + (QryStopTime - QryStartTime);
          {$endif}
        end
        else
          Result := CalCreateResult;
      except
        on e:exception do begin
          Result := ErrUnknownError;
          LastErrorMessage := e.Message;
        end;
      end;
    finally
    end;
  finally
    if not Intrans then
      DefaultTrans.Commit;
  end;
end;



procedure TdmMainDLL.SetItemStuff;
begin

    ItemNo := dmMainDll.qryItem.FieldByName('ITEMNO').AsInteger;

    //negative causes and issu!
    if Lex_UseZeroMTDSales then
      SalesToDate := 0
    else
      SalesToDate   := dmMainDll.qryItem.FieldByName('SalesAmount_0').AsFloat;

    LocationNo := dmMainDll.qryItem.FieldByName('LocationNO').AsInteger;

    if Lex_CalcAsNonStock then
      Stocked := False
    else
      Stocked := dmMainDll.qryItem.FieldByName('StockingIndicator').AsString = 'Y';

    Pareto  := dmMainDll.qryItem.FieldByName('ParetoCategory').AsString[1];

    //v4.04 Code
    {FParams.SS := ELRoundPer(dmMainDll.qryItem.FieldByName('SAFETYSTOCK').AsFloat,2);
    FParams.RC := ELRoundPer(dmMainDll.qryItem.FieldByName('REPLENISHMENTCYCLE').AsFloat,2);
    FParams.RP := ELRoundPer(dmMainDll.qryItem.FieldByName('REVIEWPERIOD').AsFloat,2);
    FParams.LT := ELRoundPer(dmMainDll.qryItem.FieldByName('LEADTIME').AsFloat,2) ;

    SSDays := trunc(ELRound(FParams.SS * FNoDaysInPeriod));
    RCDays := trunc(ELRound(FParams.RC * FNoDaysInPeriod));
    RPDays := trunc(ELRound(FParams.RP * FNoDaysInPeriod));
    LTDays := trunc(ELRound(FParams.LT * FNoDaysInPeriod));}

  FParams.SS := dmMainDll.qryItem.FieldByName('SAFETYSTOCK').AsFloat;
  FParams.RC := dmMainDll.qryItem.FieldByName('REPLENISHMENTCYCLE').AsFloat;
  FParams.RP := dmMainDll.qryItem.FieldByName('REVIEWPERIOD').AsFloat;
  FParams.LT := dmMainDll.qryItem.FieldByName('LEADTIME').AsFloat;
  FParams.EffectiveRC := dmMainDll.qryItem.FieldByName('EFFECTIVERC').AsFloat;

  SSDays := Trunc(ELRound(dmMainDll.qryItem.FieldByName('SAFETYSTOCK').AsFloat * FNoDaysInPeriod));
  RCDays := Trunc(ELRound(dmMainDll.qryItem.FieldByName('REPLENISHMENTCYCLE').AsFloat * FNoDaysInPeriod));
  EffRCDays := Trunc(ELRound(dmMainDll.qryItem.FieldByName('EFFECTIVERC').AsFloat * FNoDaysInPeriod));
  RPDays := Trunc(ELRound(dmMainDll.qryItem.FieldByName('REVIEWPERIOD').AsFloat * FNoDaysInPeriod));
  LTDays := Trunc(ELRound(dmMainDll.qryItem.FieldByName('LEADTIME').AsFloat * FNoDaysInPeriod));

  SSLTDays      := SSDays + LTDays;
  SSRCDays      := SSDays + RCDays;
  SSHalfRCDays  := SSDays + trunc(RCDays/2);
  SSRPDays      := SSDays + RPDays;
  SSLTRPDays    := SSDays + LTDays + RPDays;
  SSLTRCDays    := SSDays + LTDays + RCDays;

  TransitLTDays := Trunc(dmMainDll.qryItem.FieldByName('TransitLT').AsFloat * FNoDaysInPeriod);

  SOH           := Trunc(dmMainDll.qryItem.FieldByName('STOCKONHAND').AsFloat);
  BO            := Trunc(dmMainDll.qryItem.FieldByName('BACKORDER').AsFloat);
  CBO           := Trunc(dmMainDll.qryItem.FieldByName('CONSOLIDATEDBRANCHORDERS').AsFloat);
  Bin           := Trunc(dmMainDll.qryItem.FieldByName('BINLEVEL').AsFloat);
  MOQ           := Trunc(dmMainDll.qryItem.FieldByName('MINIMUMORDERQUANTITY').AsFloat);
  Mult          := Trunc(dmMainDll.qryItem.FieldByName('ORDERMULTIPLES').AsFloat);
  Min           := Trunc(dmMainDll.qryItem.FieldByName('ABSOLUTEMINIMUMQUANTITY').AsFloat);
  StockOnOrder := dmMainDll.qryItem.FieldByName('STOCKONORDER').AsInteger;
  StockOnOrderInLT := dmMainDll.qryItem.FieldByName('STOCKONORDERINLT').AsInteger;
  StockOnOrderOther := dmMainDll.qryItem.FieldByName('STOCKONORDER_OTHER').AsInteger;
  StockOnOrderInLTOther := dmMainDll.qryItem.FieldByName('STOCKONORDERINLT_OTHER').AsInteger;

  UseFixedLevels :=  False;
  if UseFixedLevels then begin
    FixedSS := 0;
    FixedSSRC := 0;
  end;

  if not dmMainDll.qryItem.FieldByName('BACKORDERRATIO').IsNull then
    FFCRAtio := dmMainDll.qryItem.FieldByName('BACKORDERRATIO').AsFloat
  else
    FFCRatio := FConfigFCRatio;

  if not dmMainDll.qryItem.FieldByName('BOMBACKORDERRATIO').IsNull then
    FBOMRatio := dmMainDll.qryItem.FieldByName('BOMBACKORDERRATIO').AsFloat
  else
    FBOMRatio := FConfigBOMRatio;

  if not dmMainDll.qryItem.FieldByName('DRPBACKORDERRATIO').IsNull then
    FDRPRatio := dmMainDll.qryItem.FieldByName('DRPBACKORDERRATIO').AsFloat
  else
    FDRPRatio := FConfigDRPRatio;

  CalcIdealArrival := False;
  UseStockBuild := False;
  if (qryItem.FieldByName('STOCK_BUILDNO').AsInteger > 0) then
  begin
    UseStockBuild := True;
    GetStockBuild(dmMainDll.qryItem.FieldByName('STOCK_BUILDNO').AsInteger);
    BuildStartDate := qryStockBuild.FieldByName('START_BUILD').AsDateTime;
    ShutdownStart := qryStockBuild.FieldByName('START_SHUTDOWN').AsDateTime;
    ShutdownEnd := qryStockBuild.FieldByName('END_SHUTDOWN').AsDateTime;
  end
  else begin
    BuildStartDate := 0;
    ShutdownStart := 0;
    ShutdownEnd := 0;
    FParams.EffShutdownStart := 0;
    FParams.EffShutdownEnd := 0;
  end;

  ProductCode := dmMainDll.qryItem.FieldByName('PRODUCTCODE').AsString;
  LocationCode := dmMainDll.qryItem.FieldByName('LOCATIONCODE').AsString;

    //Force this param
  if dmMainDLL.Lex_IgnoreMOQMult then
  begin
    dmMainDll.FUseMult := False;
    dmMainDll.FUseMOQ := False;
  end;

end;

function TdmMainDLL.GetLocationNo(Location: String):Integer;
begin

    With qryGetLocation do begin
      Active := False;
      ParamByName('iLocation').AsString := Location;
      Active := True;
      Result := FieldByName('LocationNo').AsInteger;
      Active := False;
    end;

end;

procedure TdmMainDLL.Calc_Lex_BO;
var
  Cnt     : integer;
  CalNo   : integer;
  LastCal : integer;
begin
  for Cnt := -1 to MAX_MONTHS_ARRAY_SIZE do begin
    MonthDate[Cnt]      :=FFP.Cal[0].Date;
    MonthBO[Cnt]        := 0;
  end;


  LastCal := -1;
  for Cnt := 0 to FFP.Cnt-1 do begin //Loop thru all days
    CalNo := FFP.Cal[Cnt].CalNo;   //Get the Month no. of the day
    if CalNo <= MAX_MONTHS_ARRAY_SIZE then begin
      if CalNo <> LastCal then begin
        MonthDate[FFP.Cal[Cnt].CalNo] := FFP.Cal[Cnt].Date;
        LastCal := CalNo;
      end;
      //Use Last number for month
      MonthBO[CalNo]      := FFP.Dat[Cnt].BO;
    end;

  end;

end;

procedure TdmMainDLL.ZeroFC;
var
  n:Integer;
begin

  FFC.Cnt := 0;

  for n := 0 to FNoPeriodsFC-1 do begin
    FFC.Arr[n] := 0;
  end;
  FFC.Cnt := FNoPeriodsFC;


  //MakeDemStruc(FCO, MAX_CO_ARRAY_SIZE);
  //MakeDemStruc(FBOM, MAX_DAYS_ARRAY_SIZE);
  //MakeDemStruc(FDRP, MAX_DAYS_ARRAY_SIZE);
  //MakePOStruc(FPO, MAX_PO_ARRAY_SIZE);
  //MakeIntStruc(FFact, MAX_DAYS_ARRAY_SIZE);

end;

function TdmMainDLL.GetCurrentPeriod: Integer;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;

  try
      with sqlConfig do
      begin
        Close;
        SQL.Text := 'select TYPEOFINTEGER ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = 100';
        ExecQuery;
        Result := FieldByName('TYPEOFINTEGER').AsInteger;
        Close;
      end;

  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;

end;

procedure TdmMainDLL.Setup_Lex_DRPFC;
var
  n : integer;
begin

  Open_Lex_DRPQuery;
  n := 0;
  while not sqlDRPDailyDemand.Eof do begin
    FDRP.Arr[n].DemDate := trunc(sqlDRPDailyDemand.FieldByName('FORECASTDATE').AsDateTime);
    FDRP.Arr[n].DemQty := trunc(sqlDRPDailyDemand.FieldByName('FCVALUE').AsFloat);
    if FDRP.Arr[n].DemQty < 0 then //Ofset excess in cwh consolidations can make forecasts negative values
      FDRP.Arr[n].DemQty := 0;
    inc(n);
    sqlDRPDailyDemand.Next;
  end;
  FDRP.Cnt := n;

end;

procedure TdmMainDLL.Open_Lex_DRPQuery;
begin

  sqlDRPLexDailyDemand.Close;
  sqlDRPLexDailyDemand.ParamByName('LOCATIONNO').AsInteger := LocationNo;
  sqlDRPLexDailyDemand.ParamByName('ITEMNO').AsInteger := ItemNo;
  sqlDRPLexDailyDemand.ParamByName('STOCKDOWNLOADDATE').AsDateTime := trunc(FStockDownloadDate);
  sqlDRPLexDailyDemand.ExecQuery;

end;

end.
