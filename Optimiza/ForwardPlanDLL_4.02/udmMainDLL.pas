unit udmMainDLL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmFwdPlanDLL, DB, IBCustomDataSet, IBSQL, IBDatabase, IBQuery,
  IBStoredProc,FwdPlan;

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
    qryStockBuild: TIBSQL;
    trnOptimiza: TIBTransaction;
    qrySelectLocation: TIBQuery;
    srcSelectLocation: TDataSource;
    prcFireEvent: TIBStoredProc;
    CalendarEnd: TIBSQL;
    //qryItem1DIVISION: TIBStringField;
    qryItem: TIBSQL;
    qryGetLocation: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FDbDescription:String;
    procedure GetBuildInfo(var V1, V2, V3, V4: Word);
    procedure SetItemStuff;
  public
    { Public declarations }
    Lex_UseBom:Boolean;
    Lex_UseDrp:Boolean;
    Lex_UseFC:Boolean;
    Lex_UseCO:Boolean;
    Lex_IgnoreMOQMult:Boolean;
    Lex_CalcAsNonStock:Boolean;
    Lex_FCRatio:Integer;
    Lex_CurrentForecast:Real;
    function kfVersionInfo: String;
    property DbDescription: String read FDbDescription write FDbDescription;
    function DLL_Calc:Integer;
  published
    function FireEvent(SuccessFail: Char):Boolean;
    function GetLocationNo(Location: String):Integer;

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
  Lex_IgnoreMOQMult:=False;
  Lex_CalcAsNonStock:=False;
  Lex_FCRatio:=-1;
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

  //Lexian Overides Here
  if Lex_FCRatio >= 0 then
    FParams.FCRAtio := Lex_FCRatio;

  NoDays := (FNoPeriodsFC * FNoDaysInPeriod) + (FParams.LTDays + FParams.SSDays + FParams.RCDays);

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
          OpenCOQuery;
          OpenPOQuery;

          if (FUseBOM) and (Lex_UseBom) then
            SetupBOMFC;
          if (FUseDRP) and (Lex_UseBom) then
            SetupDRPFC;

          if (Lex_UseFC) then
            SetupFC;

          if (Lex_UseCO) then
            SetupCO;

          SetupPO;

//          if NoDays > MAX_DAYS_ARRAY_SIZE then
//            NoDays := MAX_DAYS_ARRAY_SIZE;

          if NoDays < FFP.Cnt then
            FFP.Cnt := NoDays;


          {$ifdef debug}
          QryStartTime := GetTickCount();
          {$endif}

          //convert the perc of LT to look forward to the number of days based on
          //the LT
          FParams.FWDPODays := Trunc(FParams.FWDPOPercentage * FParams.LTDays);
          //NOTE Params.EffectiveLTDay is set in load demand and for that to
          // happen we must set Params.FWDPODays here
          LoadDemand(FFP, FFC, FCO, FBOM, FDRP, FPO, FParams);
          // This is the same for all forward plans and can be done before the levels is calculated
          // Calculate the Initial Level
          if (FParams.ZeroNegStock) and (FParams.SOH < 0) then
            FParams.SOH := 0;
          FParams.Level := FParams.SOH - FParams.BO - FParams.CBO + OverPO;

          // Call the apropriate Forward plan projection
          Result := FPProject(FFP, FPO, FParams);
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

  //SaveResultsToFile('test.out');
  //SaveToFile('O:\PacBrands\Export\MismatchPB\TestOutput\test.fwd');
end;

procedure TdmMainDLL.SetItemStuff;
begin

    ItemNo := dmMainDll.qryItem.FieldByName('ITEMNO').AsInteger;
    SalesToDate   := dmMainDll.qryItem.FieldByName('SalesAmount_0').AsFloat;
    LocationNo := dmMainDll.qryItem.FieldByName('LocationNO').AsInteger;

    if Lex_CalcAsNonStock then
      Stocked := False
    else
      Stocked := dmMainDll.qryItem.FieldByName('StockingIndicator').AsString = 'Y';

    Pareto  := dmMainDll.qryItem.FieldByName('ParetoCategory').AsString[1];

    SSDays        := Trunc(ELRound(dmMainDll.qryItem.FieldByName('SAFETYSTOCK').AsFloat * FNoDaysInPeriod));
    RCDays        := Trunc(ELRound(dmMainDll.qryItem.FieldByName('REPLENISHMENTCYCLE').AsFloat * FNoDaysInPeriod));
    RPDays        := Trunc(ELRound(dmMainDll.qryItem.FieldByName('REVIEWPERIOD').AsFloat * FNoDaysInPeriod));
    LTDays        := Trunc(ELRound(dmMainDll.qryItem.FieldByName('LEADTIME').AsFloat * FNoDaysInPeriod));
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

    FUseFixedLevels := False;
    UseFixedLevels := False;
    //if FUseFixedLevels then begin
      FixedSS := 0;
      FixedSSRC := 0;
    //end;

    CalcIdealArrival := dmMainDll.qryItem.FieldByName('CALC_IDEAL_ARRIVAL_DATE').AsString = 'Y';

    UseStockBuild := False;

    if (qryItem.FieldByName('STOCK_BUILDNO').AsInteger > 0) then
    begin
      UseStockBuild := True;
      BuildStartDate := dmMainDll.qryItem.FieldByName('START_BUILD').AsDateTime;
      ShutdownStart := dmMainDll.qryItem.FieldByName('START_SHUTDOWN').AsDateTime;
      ShutdownEnd := dmMainDll.qryItem.FieldByName('END_SHUTDOWN').AsDateTime;
      OrdersDuringShutdown := dmMainDll.qryItem.FieldByName('ORDERS_DURING_SHUTDOWN').asString='Y';
    end;

    StockOnOrder := dmMainDll.qryItem.FieldByName('STOCKONORDER').AsInteger;
    StockOnOrderOther := 0; //dmMainDll.qryItem.FieldByName('STOCKONORDER_OTHER').AsInteger;
    StockOnOrderInLT := dmMainDll.qryItem.FieldByName('STOCKONORDERINLT').AsInteger;
    StockOnOrderInLTOther := 0; //dmMainDll.qryItem.FieldByName('STOCKONORDERINLT_OTHER').AsInteger;

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

    ProductCode := dmMainDll.qryItem.FieldByName('PRODUCTCODE').AsString;
    LocationCode := dmMainDll.qryItem.FieldByName('LOCATIONCODE').AsString;

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

end.
