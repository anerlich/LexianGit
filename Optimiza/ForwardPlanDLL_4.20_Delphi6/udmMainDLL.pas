unit udmMainDLL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  DB, IBCustomDataSet, IBSQL, IBDatabase, IBQuery,      dmFwdPlanDLL,
  IBStoredProc,FwdPlan,Math,StrUtils,iniFiles;

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
    ReadConfig: TIBSQL;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FDbDescription:String;
    procedure GetBuildInfo(var V1, V2, V3, V4: Word);
    procedure SetItemStuff;
    procedure ZeroFC;
    function ReadConfigLongStr(ConfigNo: integer): string;
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
    function GetLogFileName:String;
    procedure SaveToFile(Filename:string);
    procedure SaveResultsToFile(Filename:String);
  published
    function FireEvent(SuccessFail: Char):Boolean;
    function GetLocationNo(Location: String):Integer;
    procedure Calc_Lex_BO;

  end;

var
  dmMainDLL: TdmMainDLL;

implementation

{$R *.dfm}
{$undef EnableMemoryLeakReporting}

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


          //{$ifdef debug}
          //QryStartTime := GetTickCount();
          //{$endif}

          //convert the perc of LT to look forward to the number of days based on
          //the LT
          FParams.FWDPODays := Trunc(FParams.FWDPOPercentage * (FParams.LT*FParams.NoDaysInPeriod));
          FFWDPODays := FParams.FWDPODays;
          //NOTE Params.EffectiveLTDay is set in load demand and for that to
          // happen we must set Params.FWDPODays here
          Application.ProcessMessages;
          LoadDemand(FFP, FFC, FCO, FBOM, FDRP, FPO, FParams);
          // This is the same for all forward plans and can be done before the levels is calculated
          // Calculate the Initial Level
          if (FParams.ZeroNegStock) and (FParams.SOH < 0) then
            FParams.SOH := 0;
          FParams.Level := FParams.SOH - FParams.BO - FParams.CBO + OverPO;

          // Call the appropriate Forward plan projection
          Application.ProcessMessages;
          Result := FPProject(FFP, FPO, FParams, FCal);
          if CalculateWeekly  then
            CalculateWeeklyTotals;
          if CalculateMonthly then
            CalculateMonthlyTotals;
          //{$ifdef debug}
          //QryStopTime := GetTickCount();
          //FwdPlanElapsedTime := FwdPlanElapsedTime + (QryStopTime - QryStartTime);
          //{$endif}
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
  OrdersDuringShutdown := False;
  if (qryItem.FieldByName('STOCK_BUILDNO').AsInteger > 0) then
  begin
    UseStockBuild := True;
    GetStockBuild(dmMainDll.qryItem.FieldByName('STOCK_BUILDNO').AsInteger);
    BuildStartDate := qryStockBuild.FieldByName('START_BUILD').AsDateTime;
    ShutdownStart := qryStockBuild.FieldByName('START_SHUTDOWN').AsDateTime;
    ShutdownEnd := qryStockBuild.FieldByName('END_SHUTDOWN').AsDateTime;
    OrdersDuringShutdown := (qryStockBuildORDERS_DURING_SHUTDOWN.asstring = 'Y');  end
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
function TdmMainDLL.GetLogFileName: String;
var
  Year,Month,Day:Word;
  FCount:Integer;
  aFileName, aFilePath:String;
  MonthStr,DayStr,LogPath:String;
begin

  aFileName := ExtractFileName(ParamStr(0));
  aFileName := AnsiReplaceStr(aFileName,'.exe','');

  //see if parameter is setup
  aFilePath := Trim(ReadConfigLongStr(286));

  //if not then use the exe path
  if aFilePath = '' then
    aFilePath := Trim(ExtractFilePath(ParamStr(0)));

  if RightStr(aFilePath,1) <> '\' then AFilePath := aFilePath + '\';

  DecodeDate(Now, Year, Month, Day);
  MonthStr := RightStr('0'+IntToStr(Month),2); //Pad with 0
  DayStr := RightStr('0'+IntToStr(Day),2);

  aFileName := aFilePath+Format('%d%s%s '+aFileName+'.log', [Year, Monthstr, DayStr]);

  //if all 100 files exist then we will use 100
  for FCount := 1 to 100 do
  begin

    If FileExists(aFileName) then
    begin

      if FCount = 1 then
        aFileName := AnsiReplaceStr(aFileName,'.log',IntToStr(FCount)+'.log')
      else
        aFileName := AnsiReplaceStr(aFileName,IntToStr(FCount-1)+'.log',IntToStr(FCount)+'.log');


    end
    else
      Break;

  end;

  Result := aFileName;

end;

function TdmMainDLL.ReadConfigLongStr(
  ConfigNo: integer): string;
var
  InTrans : boolean;
begin

  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFLONGSTRING').AsString;
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;

end;

procedure TdmMainDLL.SaveResultsToFile(Filename:String);
// To save all the projections to an Ascii file
Var
  i : integer;
  ResultsFile : textFile;
  hr,min,Secs,Msec:word;
  NeedMessage : boolean;
  NoWeeks : integer;
begin
  if Filename = '' then begin
    //Find a unique file name
    DecodeTime(time,hr,min,secs,msec);
    filename := ExtractFilepath(Application.exename)+'Fwdpln'+Inttostr(hr)+InttoStr(min)+inttostr(Secs);
    while fileexists(filename+'.fwr') do begin
      inc(min);
      filename := 'Fwdpln'+Inttostr(hr)+InttoStr(min)+inttostr(Secs);
    end;
    filename := filename + '.fwr';
    NeedMessage := True;
  end else
    NeedMessage := False;

  AssignFile(ResultsFile,FileName);
  Rewrite(ResultsFile);
  Try
    //Periods
    Writeln(ResultsFile,'[Periods...]');
    Writeln(ResultsFile,0,
            Format( '%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s',
            ['Open', 'Close', 'Receipts', 'POs', 'FC', 'DRPFC', 'DRPBOFC', 'DRPLSFC',
            'BOMFC', 'BOMBOFC', 'BOMLSFC', 'ConfOrd', 'RecOrd', 'TopOrd', 'IdealOrd', 'COs', 'LostSales',
            'Excess', 'Redis_Exc', 'BO', 'AccumBO', 'AccumLS', 'SS', 'RC', 'AvgStk', 'ROP', 'OrdUpTo',
            'Min', 'Max', 'CloseStkPer', 'AdjOrd']));
    for I := -1 to FNoPeriodsFC-1 do
      Writeln(ResultsFile,i,
              MonthOpen[i]:10,
              MonthClose[i]:10,
              MonthReceive[i]:10,
              MonthPO[i]:10,
              MonthFC[i]:10,
              MonthDRP[i]:10,
              0:10, // FP.Dat[i].DRPBackorderedForecast:10:0,
              0:10, // DRPLostSalesForecast:10:0,
              MonthBOM[i]:10,
              0:10, // BOMBackOrderedForecast:10:0,
              0:10, // BOMLostSalesForecast:10:0,
              0:10, // ProjConfirmedOrders:10:0,
              MonthOrder[i]:10,
              FParams.NowTopup:10, // TopUpPurchases:10:0,
              FParams.NowIdeal:10, // IdealPurchases:10:0,
              MonthCO[i]:10,
              MonthLostSales[i]:10,
              MonthExcess[i]:10,
              0:10, // Redistro_Excess:10:0,
              MonthBO[i]:10,
              0:10, // AccumBackOrders:10:0,
              0:10, // AccumlostSales:10:0,
              FFP.Dat[0].SS:10,
              FParams.RCDays:10,
              0:10, //  AverageStock:10:0,
              0:10, //  ReOrderPoint:10:0,
              0:10, //  OrderUptoPoint:10:0,
              0:10, //  MinStock:10:0,
              0:10, //  MaxStock:10:0,
              0:10, //  ClosingStockPeriods:10:2,
              0:10 //  Adjustedorders:10:0
              );
    //Weeks
    Writeln(ResultsFile,'[Weeks]');
    Writeln(ResultsFile,0,
            Format( '%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s',
            ['Open', 'Close', 'Receipts', 'POs', 'FC', 'DRPFC', 'DRPBOFC', 'DRPLSFC',
            'BOMFC', 'BOMBOFC', 'BOMLSFC', 'ConfOrd', 'RecOrd', 'TopOrd', 'IdealOrd', 'COs', 'LostSales',
            'Excess', 'ReDis_Exc', 'BO', 'AccumBO', 'AccumLS', 'SS', 'RC', 'AvgStk', 'ROP', 'OrdUpTo',
            'Min', 'Max', 'CloseStkPer', 'AdjOrd']));
    NoWeeks := trunc((FFP.Cnt)/7);
    for I := -1 to NoWeeks-1 do
      Writeln(ResultsFile,i,
              WeekOpen[i]:10,
              WeekClose[i]:10,
              WeekReceive[i]:10,
              WeekPO[i]:10,
              WeekFC[i]:10,
              WeekDRP[i]:10,
              0:10, // FP.Dat[i].DRPBackorderedForecast:10:0,
              0:10, // DRPLostSalesForecast:10:0,
              WeekBOM[i]:10,
              0:10, // BOMBackOrderedForecast:10:0,
              0:10, // BOMLostSalesForecast:10:0,
              0:10, // ProjConfirmedOrders:10:0,
              WeekOrder[i]:10,
              FParams.NowTopup:10, // TopUpPurchases:10:0,
              FParams.NowIdeal:10, // IdealPurchases:10:0,
              WeekCO[i]:10,
              WeekLostSales[i]:10,
              WeekExcess[i]:10,
              0:10, // Redistro_Excess:10:0,
              WeekBO[i]:10,
              0:10, // AccumBackOrders:10:0,
              0:10, // AccumlostSales:10:0,
              FFP.Dat[0].SS:10,
              FParams.RCDays:10,
              0:10, //  AverageStock:10:0,
              0:10, //  ReOrderPoint:10:0,
              0:10, //  OrderUptoPoint:10:0,
              0:10, //  MinStock:10:0,
              0:10, //  MaxStock:10:0,
              0:10, //  ClosingStockPeriods:10:2,
              0:10 //  Adjustedorders:10:0
              );
    //Days
    Writeln(ResultsFile,'[Days]');
    Writeln(ResultsFile,0,
            Format( '%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s',
            ['Open', 'Close', 'Receipts', 'POs', 'FC', 'DRPFC', 'DRPBOFC', 'DRPLSFC',
            'BOMFC', 'BOMBOFC', 'BOMLSFC', 'ConfOrd', 'RecOrd', 'TopOrd', 'IdealOrd', 'COs', 'LostSales',
            'Excess', 'Redis_Exc', 'BO', 'AccumBO', 'AccumLS', 'SS', 'RC', 'AvgStk', 'ROP', 'OrdUpTo',
            'Min', 'Max', 'CloseStkPer', 'AdjOrd']));
    for I := 0 to FFP.Cnt-1 do
      Writeln(ResultsFile,i,
              FFP.Dat[i].Open:10,
              FFP.Dat[i].Close:10,
              FFP.Dat[i].Receive:10,
              FFP.Dat[i].PO:10,
              FFP.Dat[i].FC:10,
              FFP.Dat[i].DRP:10,
              0:10, // FFP.Dat[i].DRPBackorderedForecast:10:0,
              0:10, // DRPLostSalesForecast:10:0,
              FFP.Dat[i].BOM:10,
              0:10, // BOMBackOrderedForecast:10:0,
              0:10, // BOMLostSalesForecast:10:0,
              0:10, // ProjConfirmedOrders:10:0,
              FFP.Dat[i].Order:10,
              FParams.NowTopup:10, // TopUpPurchases:10:0,
              FParams.NowIdeal:10, // IdealPurchases:10:0,
              FFP.Dat[i].CO:10,
              FFP.Dat[i].Lost:10,
              FFP.Dat[i].Excess:10,
              0:10, // Redistro_Excess:10:0,
              FFP.Dat[i].BO:10,
              0:10, // AccumBackOrders:10:0,
              FFP.Dat[i].Lost:10, // AccumlostSales:10:0,
              FFP.Dat[i].SS:10,
              FFP.Dat[i].SSRC:10,
              FFP.Dat[i].Model:10, //  AverageStock:10:0,
              0:10, //  ReOrderPoint:10:0,
              0:10, //  OrderUptoPoint:10:0,
              FFP.Dat[i].Min:10, //  MinStock:10:0,
              FFP.Dat[i].Max:10, //  MaxStock:10:0,
//              FParams.PeriodsOnHand:10, //  ClosingStockPeriods:10:2,
              0:10 //  Adjustedorders:10:0
              );

    if NeedMessage then
    {$ifndef DataOnly}
      Showmessage('The forward plan engine parameter file is saved to the following path:' + #13#10 + filename + #13#10 +
                  'Please email this file to ' + SupportEmail +
                  ' with an indication of what you think is wrong.');
    {$endif}
  finally
    CloseFile(ResultsFile);
  end
end;

procedure TdmMainDLL.SaveToFile(Filename:string);
//write all engine properties out to ini file
Var
  hr,min,Secs,Msec:word;
  FwdPlnIniFile : tIniFile;
  i : integer;
  SaveDateformat: string;
  SaveDteSeparator : Char;
  NeedMessage : boolean;
  ResultsFile : textFile;
begin
  if Filename = '' then begin
    //Find a unique file name
    DecodeTime(time,hr,min,secs,msec);
    filename := ExtractFilepath(Application.exename)+'Fwdpln'+Inttostr(hr)+InttoStr(min)+inttostr(Secs);
    while fileexists(filename+'.fwd') do begin
      inc(min);
      filename := 'Fwdpln'+Inttostr(hr)+InttoStr(min)+inttostr(Secs);
    end;
    filename := filename + '.fwd';
    NeedMessage := True;
  end else
    NeedMessage := False;

  {$IFDEF VER140}
  
  SaveDateformat := ShortDateformat;

{$ELSE}

SaveDateformat := FormatSettings.ShortDateformat;

{$ENDIF}
  SaveDteSeparator := 
  {$IFDEF VER140}
  DateSeparator
  {$ELSE}
  FormatSettings.DateSeparator
  {$ENDIF}
  ;
  {$IFDEF VER140}
  ShortDateFormat := 'dd/mm/yyyy';
  {$ELSE}
FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
{$ENDIF}
  
  {$IFDEF VER140}
DateSeparator
{$ELSE}
FormatSettings.DateSeparator
{$ENDIF}
 := '/';
  FwdPlnIniFile := nil;
  try //finally
    try
      FwdPlnIniFile := tIniFile.Create(filename);
    except
//      ErrorHandler(ErrObjectInstantiationfailed)
    end;
    //Save each parameter
    FwdPlnIniFile.WriteString('FwdplnParams','Version',DLLVersion);

    FwdPlnIniFile.WriteString('FwdplnParams','ProductCode',ProductCode);
    FwdPlnIniFile.WriteString('FwdplnParams','LocationCode',LocationCode);
    FwdPlnIniFile.WriteInteger('FwdplnParams','ItemNo',ItemNo);

    FwdPlnIniFile.WriteInteger('FwdplnParams','PeriodsToProject', FNoPeriodsFC);
    FwdPlnIniFile.WriteInteger('FwdplnParams','NoDaysinPeriod', FNoDaysInPeriod);
    FwdPlnIniFile.WriteInteger('FwdplnParams','TypeofSimulation',ord(FTypeofSimulation));

    FwdPlnIniFile.WriteInteger('FwdPlnParams','TypeofOrdering',ord(FOrderMethod));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','ExcessUses',ord(FExcessAboveRC));

    FwdPlnIniFile.WriteBool('FwdplnParams','UseBOM',FUseBOM);
    FwdPlnIniFile.WriteBool('FwdplnParams','UseDRP',FUseDRP);
    FwdPlnIniFile.WriteString('FwdPlnParams','StockdownloadDate',DateToStr(FStockdownloadDate));
    FwdPlnIniFile.WriteBool('FwdplnParams','SurplusOrdersOutsideLT',FSurplusOrdersOutsideLT);
    FwdPlnIniFile.WriteBool('FwdplnParams','UseMinimumStock',FUseMin);
    FwdPlnIniFile.WriteBool('FwdplnParams','UseMOQ',FUseMOQ);
    FwdPlnIniFile.WriteBool('FwdplnParams','UseMULT',FUseMULT);
    FwdPlnIniFile.WriteInteger('FwdPlnParams','RoundMOQ',ord(FRoundMOQ));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','RoundMULT',ord(FRoundMULT));
    FwdPlnIniFile.WriteBool('FwdplnParams','TreatNegativeStockAsZero',FZeroNegStock);

    FwdPlnIniFile.WriteInteger('FwdPlnParams','LocalMonthFactor',ord(FCurrFCUsage));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','BOMMonthFactorMode',ord(FCurrFCUsage));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','DRPMonthFactorMode',ord(FCurrFCUsage));

    FwdPlnIniFile.WriteInteger('FwdPlnParams','PeriodsforAverageForecast',FAvrFCPeriod);
    FwdPlnIniFile.WriteString('FwdPlnParams','FirstPerioRatio',FloatToStr(FFirstRatio));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','MinimumDaysRO',FMinimumDays);

    FwdPlnIniFile.WriteInteger('FwdPlnParams','UseOfCustomerOrders',ord(FCOUsage));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','OverdueCustomerOrderDate',ord(FOverFromSDD));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','CustomerOrdersoverride',ord(FCOOverride));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','OverdueCustomerOrdersImport',ord(FOverCOIs));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','ModelCalcNonStocked',ord(FNonStockedModel));

    FwdPlnIniFile.WriteBool('FwdplnParams','UseDependantForecastsForSafetyStock',FUseFirmInSS);
    FwdPlnIniFile.WriteBool('FwdplnParams','UseDependantForecastsForSafetyStock',FUseFirmInSS);
    FwdPlnIniFile.WriteInteger('FwdplnParams','FwdPODays',FFWDPODays);
    FwdPlnIniFile.WriteString('FwdplnParams','LocalBORatio',FloatToStr(FFCRatio));
    FwdPlnIniFile.WriteString('FwdplnParams','BOMBORatio',FloatToStr(FBOMRatio));
    FwdPlnIniFile.WriteString('FwdplnParams','DRPBORatio',FloatToStr(FDRPRatio));
    FwdPlnIniFile.WriteString('FwdplnParams','RedistributableStockLevel',IntToStr(FRedistributableStockLevel));
    FwdPlnIniFile.WriteInteger('FwdplnParams','FwdCODays',FFWDCODays);


    for I := 0 to FFC.Cnt-1 do
      FwdPlnIniFile.WriteString('PeriodLocalForecasts',inttostr(I),floattostr(FFC.Arr[I]));
    for I := 0 to FBOM.Cnt-1 do
      FwdPlnIniFile.WriteString('PeriodBOMForecastsBackOrdered',inttostr(I),floattostr(FBOM.Arr[I].DemQty));
    for I := 0 to FDRP.Cnt-1 do
      FwdPlnIniFile.WriteString('PeriodDRPForecastsBackOrdered',inttostr(I),floattostr(FDRP.Arr[I].DemQty));

    FwdPlnIniFile.WriteInteger('DayForecasts','Count', FFP.Cnt-1);
    for I := 0 to FFP.Cnt-1 do begin
      FwdPlnIniFile.WriteString('DayForecastDate',inttostr(I),DateToStr(FFP.Cal[I].Date));
      FwdPlnIniFile.WriteString('DayBOMForecasts',inttostr(I),floattostr(FFP.Dat[I].BOM));
      FwdPlnIniFile.WriteString('DayDRPForecasts',inttostr(I),floattostr(FFP.Dat[I].DRP));
    end;

    if FParams.UseStockBuild then begin
      FwdPlnIniFile.WriteInteger('StockBuild','Count', 1);
      FwdPlnIniFile.WriteString('StockBuild0','BuildStartDate', DateToStr(FParams.BuildStartDate));
      FwdPlnIniFile.WriteString('StockBuild0','CloseStartDate', DateToStr(FParams.ShutdownStart));
      FwdPlnIniFile.WriteString('StockBuild0','CloseEndDate', DateToStr(FParams.ShutdownEnd));
      FwdPlnIniFile.WriteString('StockBuild0','EffCloseStartDate', DateToStr(FParams.EffShutdownStart));
      FwdPlnIniFile.WriteString('StockBuild0','EffCloseEndDate', DateToStr(FParams.EffShutdownEnd));
      FwdPlnIniFile.WriteBool('StockBuild','CloseDownOrderingAllowed',OrdersDuringShutdown);
      FwdPlnIniFile.WriteBool('StockBuild','Provide_For_Shortfall', Provide_For_Shortfall);
      FwdPlnIniFile.WriteBool('StockBuild','Allow_Catchup', AllowCatchup);
    end;

    FwdPlnIniFile.WriteInteger('PurchaseOrders','Count',FPO.Cnt);
    for i := 0 to FPO.Cnt-1 do begin
      FwdPlnIniFile.WriteString('PurchaseOrder'+inttostr(i),'OrderDate'  ,DateToStr(FPO.Arr[I].PODate));
      FwdPlnIniFile.WriteString('PurchaseOrder'+inttostr(i),'ArrivalDate',DateToStr(FPO.Arr[I].PODate));
      FwdPlnIniFile.WriteString('PurchaseOrder'+inttostr(i),'Quantity'   ,FloatToStr(FPO.Arr[I].POQty));
    end;

    FwdPlnIniFile.WriteInteger('CustomerOrders','Count',FCO.Cnt);
    for i := 0 to FCO.Cnt-1 do begin
      FwdPlnIniFile.WriteString('CustomerOrder'+inttostr(i),'OrderDate'  ,DateToStr(FCO.Arr[I].DemDate));
      FwdPlnIniFile.WriteString('CustomerOrder'+inttostr(i),'ArrivalDate',DateToStr(FCO.Arr[I].DemDate));
      FwdPlnIniFile.WriteString('CustomerOrder'+inttostr(i),'Quantity'   ,FloatToStr(FCO.Arr[I].DemQty));
    end;

    FwdPlnInifile.WriteString('FwdPlnParams','Pareto',FParams.Pareto);
    FwdPlnInifile.WriteInteger('FwdPlnParams','Stocked',ord(FParams.Stocked));
    FwdPlnInifile.WriteString('FwdPlnParams','StockOnHand',FloatToStr(FParams.SOH));
    FwdPlnInifile.WriteString('FwdPlnParams','BackOrders',FloatToStr(FParams.BO));
    FwdPlnInifile.WriteString('FwdPlnParams','ConsolidatedBranchOrders ',FloatToStr(FParams.CBO));
    FwdPlnInifile.WriteString('FwdPlnParams','SalestoDate',FloatToStr(FParams.SalesToDate));

    FwdPlnInifile.WriteString('FwdPlnParams','OrderMultiple',FloatToStr(FParams.Mult));
    FwdPlnInifile.WriteString('FwdPlnParams','SlowMovingLevel',FloatToStr(FParams.Bin));

    FwdPlnIniFile.WriteString('FwdPlnParams','SafetyStock'       ,FloattoStr(FParams.SS));
    FwdPlnIniFile.WriteString('FwdPlnParams','LeadTime'          ,FloattoStr(FParams.LT));
    FwdPlnIniFile.WriteString('FwdPlnParams','TransitLeadTime'   ,FloattoStr(FParams.TransitLTDays/FNoDaysinPeriod));
    FwdPlnIniFile.WriteString('FwdPlnParams','ReplenishmentCycle',FloattoStr(FParams.RC));
    FwdPlnIniFile.WriteString('FwdPlnParams','ReviewPeriod',FloattoStr(FParams.RP));
    FwdPlnIniFile.WriteString('FwdPlnParams','OrderMinimum',FloattoStr(FParams.MOQ));
    FwdPlnIniFile.WriteString('FwdPlnParams','MinimumStock',FloattoStr(FParams.Min));
    FwdPlnIniFile.WriteBool('FwdPlnParams','CalcIdealArrival',CalcIdealArrival);

    FwdPlnIniFile.WriteInteger('Calendar','NumberofPeriods',FCal.Max);
    for i := 0 to FCal.Max-1 do begin
      FwdPlnIniFile.WriteString('Calendar','begin'+IntToStr(i),datetostr(FCal.Arr[i].CalStart));
      FwdPlnIniFile.WriteString('Calendar','end'+IntToStr(i),datetostr(FCal.Arr[i].CalEnd));
    end;

    FwdPlnIniFile.WriteInteger('TradingDays','NumberofDays',FFact.Max);
    for i := 0 to FFact.Max-1 do begin
      FwdPlnIniFile.WriteString('TradingDays','Factor'+IntToStr(i),IntToStr(FFact.Arr[i]));
    end;

    FwdPlnIniFile.WriteInteger('FwdPlnParams','ActualweeksToProject',trunc(FFP.Cnt/7));
    FwdPlnIniFile.WriteInteger('FwdPlnParams','ActualDaysToProject',FFP.Cnt);


    ////////////////////////
    //Days

    FwdPlnIniFile.Free;
    AssignFile(ResultsFile, filename);
    Append(ResultsFile);

    Writeln(ResultsFile,
            Format( '%10.10s%20.20s%20.20s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s%10.10s',
            ['No...','FCIn','CO','DRP','BOM','FC','TOT','BuildTot','SS','SSRC','RC','FWDPO','PO','Firm','FirmRP','Min','Max','Bin','EffBin','FirmLT','NewSS','ShutdSS','ShutdSSRC','ShutdMax','??']));

    for I := 0 to FFP.Cnt-1 do
      Writeln(ResultsFile,IntToStr(i):10,
              FloattoStr(FFP.Dat[i].FcIn):20,
              FFP.Dat[i].CO:10,
              FFP.Dat[i].DRP:10,
              FFP.Dat[i].BOM:10,
              FFP.Dat[i].FC:10,
              FFP.Dat[i].Tot:10,
              FFP.Dat[i].BuildTot:10,
              FFP.Dat[i].SS:10,
              FFP.Dat[i].SSRC:10,
              FFP.Dat[i].RC:10,
              FFP.Dat[i].FwdPO:10,
              FFP.Dat[i].PO:10,
              FFP.Dat[i].Firm:10,
              FFP.Dat[i].FirmRP:10,
              FFP.Dat[i].Min:10,
              FFP.Dat[i].Max:10,
              FFP.Dat[i].Bin:10,
              FFP.Dat[i].EffBin:10,
              FFP.Dat[i].FirmLt:10
              );

    ////////////////////////
    CloseFile(ResultsFile);

    if NeedMessage then
    {$ifndef DataOnly}
      Showmessage('The forward plan engine parameter file is saved to the following path:' + #13#10 + filename + #13#10 +
                  'Please email this file to ' + SupportEmail +
                  ' with an indication of what you think is wrong.');
    {$endif}
  finally
    //FwdPlnIniFile.free;
    {$IFDEF VER140}
	ShortDateformat := SaveDateformat;
	{$ELSE}
	FormatSettings.ShortDateformat := SaveDateformat;
{$ENDIF}
    
{$IFDEF VER140}
	DateSeparator
	{$ELSE}
	FormatSettings.DateSeparator
	{$ENDIF}
	:= SaveDteSeparator;
  end;
end;

end.
