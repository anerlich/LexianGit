unit dmFwdPlanDLL;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, IBCustomDataSet, IBSQL, IBDatabase, Registry, FwdPlan, math;

//IMPORTANT NOTE: as at May 2020, the units that interface to the FwdPlanDLL will NOT work with Delphi 10.
//They give unpredictable and manifestly strange results if compiled with RAD Studio and Delphi 10.3.

//Use Delphi 6 to develop and compile any such programs, NOT Delphi 10.
  
type
  TFwdPlanBackOrderDisplayMode = (bdmMaximumValue, bdmFinalValue);

  TFwdPlanDLLDataModule = class(TDataModule)
    SVPDatabase: TIBDatabase;
    DefaultTrans: TIBTransaction;
    sqlConfig: TIBSQL;
    sqlFC: TIBSQL;
    qryExclPO: TIBDataSet;
    qryExclPOPO_EXCLUDE_IND: TIBStringField;
    sqlCO: TIBSQL;
    sqlPO: TIBSQL;
    sqlBOMDailyDemand: TIBSQL;
    qryBOMDailyDemand: TIBDataSet;
    qryBOMDailyDemandFORECASTDATE: TDateTimeField;
    qryBOMDailyDemandFCVALUE: TFloatField;
    qryBOMDailyDemandITEMNO: TIntegerField;
    qryDRPDailyDemand: TIBDataSet;
    qryDRPDailyDemandFORECASTDATE: TDateTimeField;
    qryDRPDailyDemandFCVALUE: TFloatField;
    qryDRPDailyDemandITEMNO: TIntegerField;
    sqlDRPDailyDemand: TIBSQL;
    qryTradingDays: TIBDataSet;
    qryTradingDaysTRADECALENDARDETAILNO: TIntegerField;
    qryTradingDaysCALENDARDATE: TDateTimeField;
    qryTradingDaysCALENDARNO: TIntegerField;
    qryTradingDaysRATIO: TIntegerField;
    qryTradingDaysDAYNO: TIntegerField;
    qryTradingDaysWEEKNO: TIntegerField;
    qryTradingDaysTRADECALENDARNO: TIntegerField;
    qryTradingDaysDESCRIPTION: TIBStringField;
    qryCalendar: TIBDataSet;
    qryCalendarCALENDARNO: TIntegerField;
    qryCalendarPERIOD: TIntegerField;
    qryCalendarSTARTDATE: TDateTimeField;
    qryCalendarENDDATE: TDateTimeField;
    qryCalendarDESCRIPTION: TIBStringField;
    qryCalendarCALENDARYEAR: TIntegerField;
    Get_MonthFactor: TIBSQL;
    qryStockBuild: TIBDataSet;
    qryStockBuildSTART_BUILD: TDateTimeField;
    qryStockBuildSTART_SHUTDOWN: TDateTimeField;
    qryStockBuildEND_SHUTDOWN: TDateTimeField;
    qryStockBuildSTOCK_BUILDNO: TIntegerField;
    qryStockBuildORDERS_DURING_SHUTDOWN: TIBStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure OpenDatabase;
    procedure CloseDatabase;
  private
    { Private declarations }
    FOpenedPOexcludeList : Boolean;
    FSystemInWeeks : boolean;
    fBODisplayMode: TFwdPlanBackOrderDisplayMode;
    //{$ifdef debug}
    QryStartTime, QryStopTime : TDateTime;
    //{$endif}
    { This function round a floating value to nearist Value }
    //function ELRoundPer(Val : Double; Per : Byte) : Double;   //### Lexian Change
    { This function round a floating value to nearist Integer } //###  Both moved to public
    //function ELRound(Val : Double) : Double;                  //###Lexian Change
    function ReadConfigInt(ConfigNo : Integer;
						   LocationNo : Integer = -1) : Integer;

    function ReadConfigFloat(ConfigNo : Integer; 
							 LocationNo : Integer = -1) : Double;

    function ReadConfigStr(ConfigNo : Integer; 
						   LocationNo : Integer = -1) : String;

    function ReadConfigLongStr(ConfigNo : Integer; LocationNo : Integer = -1) : String;

    function ReadConfigDate(ConfigNo : Integer; LocationNo : Integer = -1) : TDateTime;

    function GetDataPath(var DatabasePath, Password : string) : boolean;
    function CalculateDayPolicy(PolicyValue : double) : integer;
    //procedure GetStockBuild(l_iStockBuildNo : Integer);  ### Lexian Change - moved to public

  public
    { Public declarations }
    FWD_PLAN_VERSION: String;
    DatabaseDescription : String;
    DaysToExpiry : integer;
    // All Arrays must be pre allocated even if they are passed as var
    FFP      : TFPStruc;    // Forward plan structure
    FCal     : TCalStruc;   // The input calendar
    FParams  : TFPParams;   // Input and output paramaters
    FFC      : TFltStruc;   // Local forecast
    FCO      : TDemStruc;   // Customer orders
    FBOM     : TDemStruc;   // Bill of material
    FDRP     : TDemStruc;   // Central wharecouse branch demand
    FPO      : TPOStruc;    // existing purchase orders
    FFact    : TIntStruc;   // Traid factors

    // This array is up to 250 because max fc periods is 52, multiplied by 30, divided by 7 (days in week)
    // I rounded this up to 250.
    WeekDate      : Array [-1..MAX_WEEKS_ARRAY_SIZE] of TDateTime;
    WeekFC        : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekBOM       : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekDRP       : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekCO        : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekBO        : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekPO        : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekExcess    : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekOrder     : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekReceive   : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekClose     : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekOpen      : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;
    WeekLostSales : Array [-1..MAX_WEEKS_ARRAY_SIZE] of integer;

    MonthDate      : Array [-1..MAX_MONTHS_ARRAY_SIZE] of TDateTime;
    MonthFC        : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthBOM       : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthDRP       : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthCO        : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthBO        : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthPO        : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthExcess    : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthOrder     : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthReceive   : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthClose     : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthOpen      : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;
    MonthLostSales : Array [-1..MAX_MONTHS_ARRAY_SIZE] of integer;

    FProductCode               : string;
    FLocationNo                : integer;
    ItemNo                     : integer;
    FStockDownloadDate         : TDateTime;
    FSurplusOrdersOutsideLT    : Boolean;
    FAdjustedDownloadDateStart : boolean;
    FAdjustedDownloadDateEnd   : boolean;
    FCurrentPeriod             : integer;
    FWeekStartDay              : Integer;
    FNoPeriodsFC               : integer;
    FOriginalHorizon           : integer; // Stores the original horizon
    FNoDaysInPeriod            : integer;
    FMinimumDays               : integer;
    FAvrFCPeriod               : Integer;
    FFixedHorizon              : integer;
    FCurrFCUsage               : integer;
    FFirstRatio                : Double;
    FOverCOIs                  : integer;
    FOverFromSDD               : Boolean;
    FExcludePseudoFwdPO        : boolean;
    FCOUsage                   : integer;
    FCOOverride                : integer;
(*    FCOMethod                  : integer; *)
    FUseMOQ                    : Boolean;
    FUseMult                   : Boolean;
    FUseMin                    : Boolean;
    FZeroNegStock              : Boolean;
    FUseFirmInSS               : Boolean;
    FFWDPOPercentage           : Double;  //Added Parameter 26 Jan 2006
    FFWDCOPercentage           : double;
    FFWDPODays                 : Integer;
    FFWDCODays                 : integer;
    FUseBOM                    : Boolean;
    FUseDRP                    : Boolean;
    FRoundMOQ                  : integer;
    FRoundMult                 : integer;
    FExcessAboveRC             : Boolean;
    FOrderMethod               : integer;
    FFCRatio                   : Double;
    FDRPRatio                  : Double;
    FBOMRatio                  : Double;
    FConfigFCRatio             : Double;
    FConfigDRPRatio            : Double;
    FConfigBOMRatio            : Double;
    FCORatio                   : Double;
    FPercentageLT              : Double;   //       319 - % of LT above transit LT to use as minimum
    FMinDaysLT                 : integer;  //       320 - Minimum number of days to add to the transit lead time
    FPercentageRecChanges      : Double;   //       321 - Only recommend changes to dates greater than X percent
    FMinDaysRecChanges         : integer;  //       322 - Minimum number of days for items with short lead times and to prevent daily changes being  recommended
    FTypeOfSimulation          : integer; //     D 188 - Type of simulation
    FNonStockedModel           : integer; //        271 - Model non stock
    FUseFixedLevels            : boolean;
    FExpeditePO                : boolean;
    FRedistributableStockLevel : integer;
    SupportEmail               : String;
    FSplitStockBuildReceipts   : Boolean;

    SalesToDate                : Double;         //   B     -=-     -=- Self explanatory (Use SalesAmount_0)
    OverPO                     : Integer;
    OverCO                     : Integer;         //       D -=-     -=- Overdue Purchase Orders (Calculated while loading Purchase Order Info) (This may potentially be an output of B and then an input to D)
    Stocked                    : Boolean;         //       D -=-     -=- Is this a stocked item
    Pareto                     : Char;            //       D -=-     -=- The Pareto Category
    SSDays                     : Integer;         //       D -=-     -=- Days for Safety stock
    RCDays                     : Integer;         //       D -=-     -=- Days to order for
    EffRCDays                  : Integer;         //       D -=-     -=- Days to order for
    UseFixedLevels             : boolean;
    FixedSS                    : Integer;         //       The fixed level safety stock
    FixedSSRC                  : Integer;         //       The fixed level safety stock and replenishment cycle
    RPDays                     : Integer;         //       D -=-     -=- Days before Look to order again
    LTDays                     : Integer;         //       D -=-     -=- Leadtime in days
    SSLTDays                   : Integer;         //        Days for Safety stock + Lead time
    SSRCDays                   : Integer;         //        Days for Safety stock + Replenishment cycle
    SSHalfRCDays               : Integer;         //        Days for Safety stock + half replenishment cycle
    SSRPDays                   : Integer;         //        Days for Safety stock + Review period
    SSLTRPDays                 : Integer;         //        Days for Safety stock + Lead time + Review period
    SSLTRCDays                 : Integer;         //        Days for Safety stock + Lead time + Replenishment cycle
    TransitLTDays              : Integer;         //       D -=-     -=- Transit lead time in days
    SOH                        : Integer;         //       D -=-     -=- Current Stock on hand
    BO                         : Integer;         //       D -=-     -=- Current Back orders
    CBO                        : Integer;         //       D -=-     -=- Consolidated Branch orders
    Bin                        : Integer;         //       D -=-     -=- The Bin level of the Item
    MOQ                        : Integer;         //       D -=-     -=- Minimum order quantity
    Mult                       : Integer;         //       D -=-     -=- Order multipls
    Min                        : Integer;         //       D -=-     -=- Minimum stock
    CalcIdealArrival           : boolean;         //       D -=-     -=- Calculate idela arrival date
    UseStockBuild              : boolean;         //         Do a model without stock builds, even if one exists 
    ModelWithoutStockBuild     : boolean;
    BuildStartDate             : TDateTime;    //       D -=-     -=- The stock build start date.
    ShutdownStart              : TDateTime;    //       D -=-     -=- The stock build shutdown period start date.
    ShutdownEnd                : TDateTime;    //       D -=-     -=- The stock build shutdown period end date.
(*    EffShutdownStart           : TDateTime;    //       D -=-     -=- The stock build shutdown period start date.
    EffShutdownEnd             : TDateTime;    //       D -=-     -=- The stock build shutdown period end date. *)
    OrdersDuringShutdown       : boolean;
    Provide_For_Shortfall      : Boolean;
    AllowCatchup               : Boolean;

    StockOnOrder               : Integer;         //        Stock on order
    StockOnOrderOther          : Integer;         //        Stock on order (other & Pseudo)
    StockOnOrderInLT           : Integer;         //        Stock on order in LT
    StockOnOrderInLTOther      : Integer;         //        Stock on order in LT (other & Pseudo)

    CalculateWeekly            : boolean;
    CalculateMonthly           : boolean;
    DLLVersion                 : String;

    UseDailyBOMDRP             : boolean;

    RunFromRO                  : boolean;
    RONowOrder                 : boolean;
    FromFC                     : Boolean;

    FLocationCode : String;
    LastErrorMessage : String;

    {$ifdef debug}
    FwdPlanElapsedTime,
    ConfigQueryElapsedTime,
    COQueryElapsedTime,
    POQueryElapsedTime,
    FCQueryElapsedTime,
    BOMFCQueryElapsedTime,
    DRPFCQueryElapsedTime,
    FCLoadElapsedTime,
    FCBOMLoadElapsedTime,
    FCDRPLoadElapsedTime,
    COLoadElapsedTime,
    POLoadElapsedTime : double;
   {$endif}
    //### Lexian Specific - need these as public
    { This function round a floating value to nearist Value }
    function ELRoundPer(Val : Double; Per : Byte) : Double;
    { This function round a floating value to nearist Integer }
    function ELRound(Val : Double) : Double;
    procedure GetStockBuild(l_iStockBuildNo : Integer);
    //### Lexian End

    function CalculateAvgForecast(const TotalForeCast: double): double;
    function CalculateCarryVal(var IntVal: double;
      const DoubleVal: currency): double;

    // This is used only when created
    function GetMonthFactor : double; // Checked OK
    procedure GetConfigParams;        // Checked OK
    procedure CreateFCSQL;            // Checked OK
    procedure CreateCalendarStruc;    // Checked OK

    procedure SetupTradingDays;                  // Checked OK

    procedure OpenFCQuery(CalendarNo : integer); // Checked OK
    procedure OpenBOMQuery;                      // Checked OK
    procedure OpenDRPQuery;                      // Checked OK
    procedure OpenCOQuery;                       // Checked OK
    procedure OpenPOQuery;                       // Checked OK
    function  MustExcludePOfromSurplus(IndicatorToExclude: String): Boolean;

    procedure SetItemInfo(DataSet : TIBDataSet; SetCalcIdealArrival : boolean);
    procedure LoadConfigParams;                  // Checked OK
    procedure LoadItemParams;                    // Checked OK

    procedure SetupFC;     // Checked OK  do not open FC
    procedure SetupBOMFC;  // Checked OK         open BOM
    procedure SetupDRPFC;  // Checked OK         open DRP
    procedure SetupCO;         // Need attention
    procedure SetupPO;         // Need attention

    procedure CalculateWeeklyTotals;   // Checked OK
    procedure CalculateMonthlyTotals;  // Checked OK

    procedure SetLocationNo(Value : integer); // Checked OK                        // Because of every location having its own Trade calendar the Calendar must be recreated when location change
    procedure LoadFCWI;    // Need Attention
    procedure SetLocationCode(Value : String); // Need Attention

    //PK Why is this needed as public and the others not
    procedure OpenBOMDataSet;  // Checked OK
    procedure OpenDRPDataSet;  // Checked OK

    procedure ResetCOStruc;    // Checked OK
    procedure ResetPOStruc;    // Checked OK
    procedure ResetFCStruc;    // Checked OK
    procedure ResetBOMStruc;   // Checked OK
    procedure ResetDRPStruc;   // Checked OK

    procedure ReloadPO;        // Checked OK
    procedure ReloadBOM;       // Checked OK
    procedure ReloadDRP;       // Checked OK

    function DoCalc(l_iNoDays : Integer = -1) : integer;
    function DoWICalc : integer;
    function GetIntFCIBsql(DataSet : TIBSQL; NoPeriodFC : Integer) : Boolean;
    function GetNumDaysOrder(ANumDays : Integer) : Double;

    procedure ReadFromFile(Filename:string);
    procedure SaveToFile(Filename:string);
    procedure SaveResultsToFile(Filename:String);

    property LocationCode : string read FLocationCode write SetLocationCode;
    property LocationNo : integer read FLocationNo write SetLocationNo;
    property ProductCode : string read FProductCode write FProductCode;
    property BackOrderDisplayMode : TFwdPlanBackOrderDisplayMode read fBODisplayMode write fBODisplayMode;
  end;

var
  FwdPlanDLLDataModule: TFwdPlanDLLDataModule;

implementation

{$R *.DFM}
{$undef EnableMemoryLeakReporting}
uses
  IniFiles;


function ELRoundForFP(Val : Double) : Double;
begin
  //ELFunctions.ELRound() provides the functionality as this one, but that unit
  // cannot be included here as inclusion will compromise ceretain other EXEs
  // at build time as well as complicating the Forward plan Test Project that
  // gets distributed to Australia for custom development.

  // As a result, maintenance of this code should be done here as well as on the
  // ELfunctions.ELRound() should it be neccessary.

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

function TFwdPlanDLLDataModule.GetIntFCIBsql(DataSet : TIBSQL; NoPeriodFC : Integer) : Boolean;
var
  i : Integer;

begin
// NOTE: ELFunctions.GetIntFC uses the exact-same logic as this procedure, only we cannot include that unit inside this one due to developer rules.
//       IF this logic should change, ELFunctions.GetIntFC must be reviewed and updated where neccessary as well!
  Result := False;
  if DataSet.RecordCount > 0 then begin
//    CarryVal := 0;
  //  DifVal := 0;
  {  if not (Dataset) then begin
        Dataset.Edit;
    end;          }
    for i := 0 to NoPeriodFC -1 do begin
      DataSet.FieldByName('FORECAST_' + IntToStr(i)).AsDouble :=  ELROUNDforFP(DataSet.FieldByName('FORECAST_' + IntToStr(i)).AsDouble);
  end;
  end;
end;


procedure TFwdPlanDLLDataModule.DataModuleCreate(Sender: TObject);
begin
  FWD_PLAN_VERSION := '5.1.0.2';
  OpenDatabase;
  // Make sure that the Max of all the FP arrays is zero
  // this prevent the Free method from being called when
  // we initially Freate the Structures
  FFP.Max   := 0;
  FCal.Max  := 0;
  FFC.Max   := 0;
  FCO.Max   := 0;
  FBOM.Max  := 0;
  FDRP.Max  := 0;
  FPO.Max   := 0;
  FFact.Max := 0;
  EffRCDays := -1;

  RunFromRO        := False;
  RONowOrder       := False;
  UseDailyBOMDRP   := True;
  FExpeditePO      := False;
  FOpenedPOexcludeList := False;
  DLLVersion       := GetDLLVersion; // DLL Call
  CalculateWeekly  := True;
  CalculateMonthly := True;
  ModelWithoutStockBuild := False;
  FLocationNo      := -1;  //Set this to -1, as GetConfigParams will get the system default for location-specific parameters
                           //At this stage we don't know what the location no is
    //###Lexian Change
  if not defaulttrans.InTransaction then
    defaulttrans.StartTransaction;
  //###Lexian Change

  GetConfigParams;
  CreateCalendarStruc;

  MakeFltStruc(FFC, FNoPeriodsFC);
  MakeDemStruc(FCO, MAX_CO_ARRAY_SIZE);
  MakeDemStruc(FBOM, MAX_DAYS_ARRAY_SIZE);
  MakeDemStruc(FDRP, MAX_DAYS_ARRAY_SIZE);
  MakePOStruc(FPO, MAX_PO_ARRAY_SIZE);
  MakeIntStruc(FFact, MAX_DAYS_ARRAY_SIZE);

  MakeFPStruc(FFP, MAX_DAYS_ARRAY_SIZE);
  FFP.Cnt := MAX_DAYS_ARRAY_SIZE;
  SetupTradingDays;
  CreateFCSQL;

end;

procedure TFwdPlanDLLDataModule.OpenDatabase;
var
  DataPath, Password : string;
begin
  with SVPDatabase do begin
    // statemement below allows time for database to be fully opened before access is attempted. Without it
    // an access violation occurs with Delphi 10.3
    Application.ProcessMessages;
    if Connected then
      Close;
    if GetDataPath(DataPath, Password) then begin
      if (length(DataPath) > 2) then
        if (UpCase(DataPath[1]) in ['A'..'Z']) and (DataPath[2] = ':') then // if we are using a direct path in windows then change it to a tcp/ip connection, for multi-threading
          DataPath := 'localhost:' + DataPath;
      DatabaseName := DataPath;
      Params.Clear;
      Params.Add('user_name=SYSDBA');
      if (Password = '') then begin
        Params.Add('password=masterkey');
      end
      else begin
        Params.Add('password=' + Password);
      end;
      Application.ProcessMessages;
      Open;
    end;
  end;
end;


procedure TFwdPlanDLLDataModule.DataModuleDestroy(Sender: TObject);
begin

  FreeCalStruc(FCal);
  FreeFltStruc(FFC);
  FreeDemStruc(FCO);
  FreeDemStruc(FBOM);
  FreeDemStruc(FDRP);
  FreePOStruc(FPO);
  FreeFPStruc(FFP);
  FreeIntStruc(FFact);
  CloseDatabase;
  inherited;
end;

procedure TFwdPlanDLLDataModule.CloseDatabase;
begin
  if DefaultTrans.InTransaction then
    DefaultTrans.Commit;

  if SVPDatabase.Connected then
    SVPDatabase.Close;
end;

procedure TFwdPlanDLLDataModule.ReloadBOM;
var
  n        : integer;
  Cnt      : integer;
  WeekNo   : integer;
  CalNo    : integer;
  FirstDay : integer;
  dummy    : Word;
  MonthTest: Word;
  CurrentMonth : Word;
begin
  for Cnt := -1 to MAX_WEEKS_ARRAY_SIZE do
    WeekBOM[Cnt] := 0;

  for Cnt := -1 to MAX_MONTHS_ARRAY_SIZE do
    MonthBOM[Cnt] := 0;

    DecodeDate(FFP.Cal[0].date,dummy,CurrentMonth,dummy);
    Calno := 0;
  if FFP.Cnt > 0 then begin
    FirstDay := Trunc(FFP.Cal[0].Date);
    for n := 0 to FBOM.Cnt-1 do begin
      Cnt := Trunc(FBOM.Arr[n].DemDate) - FirstDay;
      if (Cnt < FFP.Cnt) and (Cnt >= 0) then begin
        WeekNo := FFP.Cal[Cnt].WeekNo;   //Get the week no. of the day
      if FSystemInWeeks then
       begin
         DecodeDate(FFP.Cal[Cnt].date,dummy,MonthTest,dummy);
         If CurrentMonth <> Monthtest then
           begin
             inc(calno, abs(CurrentMonth - Monthtest));
             CurrentMonth := MonthTest;
           end;
       end
         else
          begin
            CalNo := FFP.Cal[Cnt].CalNo;   //Get the calendar no. of the day
          end;
        WeekBOM[WeekNo] := WeekBOM[WeekNo] + FBOM.Arr[n].DemQty;
        MonthBOM[CalNo] := MonthBOM[CalNo] + FBOM.Arr[n].DemQty;
      end;
    end;
  end;
end;

procedure TFwdPlanDLLDataModule.ReloadDRP;
var
  n        : integer;
  Cnt      : integer;
  WeekNo   : integer;
  CalNo    : integer;
  FirstDay : integer;
  dummy    : Word;
  MonthTest: Word;
  CurrentMonth : Word;
begin
  for Cnt := -1 to MAX_WEEKS_ARRAY_SIZE do
    WeekDRP[Cnt] := 0;

  for Cnt := -1 to MAX_MONTHS_ARRAY_SIZE do
    MonthDRP[Cnt] := 0;

    DecodeDate(FFP.Cal[0].date,dummy,CurrentMonth,dummy);
    Calno := 0;
  if FFP.Cnt > 0 then begin
    FirstDay := Trunc(FFP.Cal[0].Date);
    for n:= 0 to FDRP.Cnt-1 do begin
      Cnt := Trunc(FDRP.Arr[n].DemDate) - FirstDay;
      if (Cnt < FFP.Cnt) and (Cnt >= 0) then begin
        WeekNo := FFP.Cal[Cnt].WeekNo;   //Get the week no. of the day
      if FSystemInWeeks then
       begin
         DecodeDate(FFP.Cal[Cnt].date,dummy,MonthTest,dummy);
         If CurrentMonth <> Monthtest then
           begin
             inc(calno, abs(CurrentMonth - Monthtest));
             CurrentMonth := MonthTest;
           end;
       end
         else
          begin
            CalNo := FFP.Cal[Cnt].CalNo;   //Get the calendar no. of the day
          end;
        WeekDRP[WeekNo] := WeekDRP[WeekNo] + FDRP.Arr[n].DemQty;
        MonthDRP[CalNo] := MonthDRP[CalNo] + FDRP.Arr[n].DemQty;
      end;
    end;
  end;
end;

procedure TFwdPlanDLLDataModule.ReloadPO;
var
  n         : integer;
  Cnt       : integer;
  WeekNo    : integer;
  CalNo     : integer;
  FirstDate : Integer;
  dummy    : Word;
  MonthTest: Word;
  CurrentMonth : Word;  
begin
  for Cnt := -1 to MAX_WEEKS_ARRAY_SIZE do
    WeekPO[Cnt] := 0;

  for Cnt := -1 to MAX_MONTHS_ARRAY_SIZE do
    MonthPO[Cnt] := 0;

    DecodeDate(FFP.Cal[0].date,dummy,CurrentMonth,dummy);
    Calno := 0;
  if FFP.Cnt > 0 then begin
    FirstDate := Trunc(FFP.Cal[0].Date);
    for n := 0 to FPO.Cnt-1 do begin
      Cnt :=  Trunc(FPO.Arr[n].PODate) - FirstDate;
      if (Cnt < FFP.Cnt) and (Cnt >= 0) then begin
        WeekNo := FFP.Cal[Cnt].WeekNo;  //Get the week no. of the day
      if FSystemInWeeks then
       begin
         DecodeDate(FFP.Cal[Cnt].date,dummy,MonthTest,dummy);
         If CurrentMonth <> Monthtest then
           begin
             inc(calno, abs(CurrentMonth - Monthtest));
             CurrentMonth := MonthTest;
           end;
       end
         else
          begin
            CalNo := FFP.Cal[Cnt].CalNo;   //Get the calendar no. of the day
          end;
        WeekPO[WeekNo] := WeekPO[WeekNo] + FPO.Arr[n].POQty;
        MonthPO[CalNo] := MonthPO[CalNo] + FPO.Arr[n].POQty;
      end;
    end;
  end;
end;

procedure TFwdPlanDLLDataModule.CalculateWeeklyTotals;
var
  Cnt      : integer;
  WeekNo   : integer;
  LastWeek : Integer;
begin
  for Cnt := -1 to MAX_WEEKS_ARRAY_SIZE do begin
    WeekDate[Cnt]      := FFP.Cal[0].Date;
    WeekFC[Cnt]        := 0;
    WeekBOM[Cnt]       := 0;
    WeekDRP[Cnt]       := 0;
    WeekCO[Cnt]        := 0;
    WeekBO[Cnt]        := 0;
    WeekPO[Cnt]        := 0;
    WeekExcess[Cnt]    := 0;
    WeekOrder[Cnt]     := 0;
    WeekReceive[Cnt]   := 0;
    WeekClose[Cnt]     := 0;
    WeekOpen[Cnt]      := 0;
    WeekLostSales[Cnt] := 0;
  end;

  WeekClose[-1] := FParams.SOH - FParams.BO + OverPO - FParams.CBO;
  if WeekClose[-1] < 0 then
    WeekClose[-1] := 0;

  WeekOpen[-1] := FParams.SOH;
  WeekCO[-1]   := OverCO;
  WeekBO[-1]   := FParams.BO;
  WeekDRP[-1]  :=  FParams.CBO;
  WeekPO[-1]   := OverPO;

  
  LastWeek := -1;
  for Cnt := 0 to FFP.Cnt-1 do begin //Loop thru all days
    if FSystemInWeeks then
      WeekNo := FFP.Cal[Cnt].CalNo   //Get the calendarno (which is the week no.) of the day
    else
      WeekNo := FFP.Cal[Cnt].WeekNo;   //Get the week no. of the day
    if WeekNo <= MAX_WEEKS_ARRAY_SIZE then begin
      if WeekNo <> LastWeek then begin
        if FSystemInWeeks then begin
          WeekOpen[FFP.Cal[Cnt].CalNo] := FFP.Dat[Cnt].Open;
          WeekDate[FFP.Cal[Cnt].CalNo] := FFP.Cal[Cnt].Date;
        end
        else begin
          WeekOpen[FFP.Cal[Cnt].WeekNo] := FFP.Dat[Cnt].Open;
          WeekDate[FFP.Cal[Cnt].WeekNo] := FFP.Cal[Cnt].Date;
        end;
        LastWeek := WeekNo;
      end;

      //Accum totals into the correct week
      WeekFC[WeekNo]      := WeekFC[WeekNo] + FFP.Dat[Cnt].FC;
      WeekBOM[WeekNo]     := WeekBOM[WeekNo] + FFP.Dat[Cnt].BOM;
      WeekDRP[WeekNo]     := WeekDRP[WeekNo] + FFP.Dat[Cnt].DRP;
      WeekCO[WeekNo]      := WeekCO[WeekNo] + FFP.Dat[Cnt].CO;
      WeekPO[WeekNo]      := WeekPO[WeekNo] + FFP.Dat[Cnt].PO;
      WeekOrder[WeekNo]   := WeekOrder[WeekNo] + FFP.Dat[Cnt].Order;
      WeekReceive[WeekNo] := WeekReceive[WeekNo] + FFP.Dat[Cnt].Receive;

      // Use values from the last day
      WeekExcess[WeekNo]    := FFP.Dat[Cnt].Excess;
      WeekClose[WeekNo]     := FFP.Dat[Cnt].Close;
      WeekLostSales[WeekNo] := FFP.Dat[Cnt].Lost;

      // set back order value for the period
      if fBODisplayMode = bdmMaximumValue then
        WeekBO[WeekNo] := Max(WeekBO[WeekNo], FFP.Dat[Cnt].BO)
      else
        WeekBO[WeekNo]      := FFP.Dat[Cnt].BO;
    end;
  end;
end;

procedure TFwdPlanDLLDataModule.CalculateMonthlyTotals;
var
  Cnt     : integer;
  CalNo   : integer;
  LastCal : integer;
  CurrentMonth :Word;
  MonthTest : Word;
  dummy : word;
  xq: String;
begin
    for Cnt := -1 to MAX_MONTHS_ARRAY_SIZE do begin
      MonthDate[Cnt]      :=FFP.Cal[0].Date;
      MonthFC[Cnt]        := 0;
      MonthBOM[Cnt]       := 0;
      MonthDRP[Cnt]       := 0;
      MonthCO[Cnt]        := 0;
      MonthBO[Cnt]        := 0;
      MonthPO[Cnt]        := 0;
      MonthExcess[Cnt]    := 0;
      MonthOrder[Cnt]     := 0;
      MonthReceive[Cnt]   := 0;
      MonthClose[Cnt]     := 0;
      MonthOpen[Cnt]      := 0;
      MonthLostSales[Cnt] := 0;
    end;

    MonthClose[-1] := FParams.SOH - FParams.BO + OverPO - FParams.CBO;
    if MonthClose[-1] < 0 then
      MonthClose[-1] := 0;

    MonthOpen[-1] := FParams.SOH;
    MonthCO[-1]   := OverCO;
    MonthBO[-1]   := FParams.BO;
    MonthDRP[-1]  :=  FParams.CBO;
    MonthPO[-1]   := OverPO;

    LastCal := -1;
    Calno := 0;
    DecodeDate(FFP.Cal[0].date,dummy,CurrentMonth,dummy);
    for Cnt := 0 to FFP.Cnt-1 do begin //Loop thru all days
      if FSystemInWeeks then
       begin
         DecodeDate(FFP.Cal[Cnt].date,dummy,MonthTest,dummy);
         If CurrentMonth <> Monthtest then
           begin
             CurrentMonth := MonthTest;
             inc(calno);
           end;
       end
         else
         CalNo := FFP.Cal[Cnt].CalNo;   //Get the Month no. of the day
      if CalNo <= MAX_MONTHS_ARRAY_SIZE then begin
       if CalNo <> LastCal then begin
         if FsystemInWeeks then
           begin
             MonthOpen[Calno] := FFP.Dat[Cnt].Open;
             MonthDate[Calno] := FFP.Cal[Cnt].Date;
           end
            else
           begin
             MonthOpen[FFP.Cal[Cnt].CalNo] := FFP.Dat[Cnt].Open;
             MonthDate[FFP.Cal[Cnt].CalNo] := FFP.Cal[Cnt].Date;
           end;
             xq := FormatDateTime( 'ddddd',FFP.Cal[Cnt].Date);
         LastCal := CalNo;

       end;

      //Accum totals into the correct Month

      MonthFC[CalNo]      := MonthFC[CalNo] + FFP.Dat[Cnt].FC;
      MonthBOM[CalNo]     := MonthBOM[CalNo] + FFP.Dat[Cnt].BOM;
      MonthDRP[CalNo]     := MonthDRP[CalNo] + FFP.Dat[Cnt].DRP;
      MonthCO[CalNo]      := MonthCO[CalNo] + FFP.Dat[Cnt].CO;
      MonthPO[CalNo]      := MonthPO[CalNo] + FFP.Dat[Cnt].PO;
      MonthOrder[CalNo]   := MonthOrder[CalNo] + FFP.Dat[Cnt].Order;
      MonthReceive[CalNo] := MonthReceive[CalNo] + FFP.Dat[Cnt].Receive;

      MonthExcess[CalNo]    := FFP.Dat[Cnt].Excess;
      MonthClose[CalNo]     := FFP.Dat[Cnt].Close;
      MonthLostSales[CalNo] := FFP.Dat[Cnt].Lost;

      // set back order value for the period
      if fBODisplayMode = bdmMaximumValue then
        MonthBO[CalNo] := Max(MonthBO[CalNo], FFP.Dat[Cnt].BO)
      else
        MonthBO[CalNo]      := FFP.Dat[Cnt].BO;
      end;
  end;
end;

procedure TFwdPlanDLLDataModule.ResetFCStruc;
begin
  FreeFltStruc(FFC);
  MakeFltStruc(FFC, FNoPeriodsFC);
end;

procedure TFwdPlanDLLDataModule.ResetBOMStruc;
begin
  FreeDemStruc(FBOM);
  MakeDemStruc(FBOM, MAX_DAYS_ARRAY_SIZE);
end;

procedure TFwdPlanDLLDataModule.ResetDRPStruc;
begin
  FreeDemStruc(FDRP);
  MakeDemStruc(FDRP, MAX_DAYS_ARRAY_SIZE);
end;

procedure TFwdPlanDLLDataModule.ResetPOStruc;
begin
  OverPO := 0;
  FreePOStruc(FPO);
  MakePOStruc(FPO, MAX_PO_ARRAY_SIZE);
end;

procedure TFwdPlanDLLDataModule.ResetCOStruc;
begin
  OverCO := 0;
  FreeDemStruc(FCO);
  MakeDemStruc(FCO, MAX_CO_ARRAY_SIZE);
end;

procedure TFwdPlanDLLDataModule.SaveResultsToFile(Filename:String);
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
    Writeln(ResultsFile,'[Periods]');
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

procedure TFwdPlanDLLDataModule.SaveToFile(Filename:string);
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
            ['No','FCIn','CO','DRP','BOM','FC','TOT','BuildTot','SS','SSRC','RC','FWDPO','PO','Firm','FirmRP','Min','Max','Bin','EffBin','FirmLT','NewSS','ShutdSS','ShutdSSRC','ShutdMax','??']));

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

procedure TFwdPlanDLLDataModule.ReadFromFile(Filename:string);
  //Select file and read all properties back into engine
  // returns file name should that be needed
  Var
    FwdPlnIniFile : tiniFile;
    i, CalCnt, NoCalPeriods, NoDays, DayCnt : integer;
    SaveDateformat : string;
    SS, LT, TransitLT, RP, RC : double;
    BOMCnt, DRPCnt : integer;
begin
  if not fileExists(filename) then begin
  {$ifndef DataOnly}
    Showmessage('The following file was not found and could not be loaded:' + #13#10 + filename);
  {$endif}
    exit
  end;

  {$IFDEF VER140}
SaveDateformat := ShortDateformat;
{$ELSE}
SaveDateformat := FormatSettings.ShortDateformat;
{$ENDIF}
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
  try//except
    FwdPlnIniFile := tIniFile.Create(filename);
    try//finally
      FNoPeriodsFC := FwdPlnIniFile.ReadInteger('Calendar','NumberofPeriods',12);
      //See if calendar info provided, else rely on the default one.
      if FwdPlnIniFile.ReadString('Calendar','begin0','***') <> '***' then begin
        NoCalPeriods := FwdPlnIniFile.ReadInteger('Calendar','NumberofPeriods',0);
        FreeCalStruc(FCal);
        MakeCalStruc(FCal, NoCalPeriods);
        CalCnt := 0;
        for i := 0 to FNoPeriodsFC-1 do begin
          if FwdPlnIniFile.ReadString('Calendar','begin'+IntToStr(i),'****')= '****' then
            break;
          FCal.Arr^[CalCnt].CalStart := StrToDate(FwdPlnIniFile.ReadString('Calendar','begin'+IntToStr(i),'1/1/1899'));
          FCal.Arr^[CalCnt].CalEnd   := StrToDate(FwdPlnIniFile.ReadString('Calendar','end'+IntToStr(i),'1/1/1899'));
          FCal.Arr^[CalCnt].NoDaysInPeriod   := trunc(FCal.Arr^[CalCnt].CalEnd - FCal.Arr^[CalCnt].CalStart)+1;
          Inc(CalCnt);
        end;
        FCal.Max := CalCnt;
        FCal.Cnt := FNoPeriodsFC;
      end;

      NoDays := FwdPlnIniFile.ReadInteger('TradingDays','NumberofDays',0);
      If NoDays > 0 then begin
        FreeIntStruc(FFact);
        MakeIntStruc(FFact, MAX_DAYS_ARRAY_SIZE);
        DayCnt := 0;
        for i := 0 to NoDays - 1 do begin
          FFact.Arr[DayCnt] := FwdPlnIniFile.ReadInteger('TradingDays','Factor'+IntToStr(i),1);
          Inc(DayCnt);
        end;
        FFact.Cnt := DayCnt-1;
        FFact.Max := DayCnt-1;
      end;

      ProductCode := FwdPlnIniFile.ReadString('FwdplnParams','ProductCode','');
      LocationCode := FwdPlnIniFile.ReadString('FwdplnParams','LocationCode','');
      ItemNo := FwdPlnIniFile.ReadInteger('FwdplnParams','ItemNo',-1);

      FNoPeriodsFC := FwdPlnIniFile.ReadInteger('FwdPlnParams','PeriodsToProject', 12);
      FNoDaysInPeriod := FwdPlnIniFile.ReadInteger('FwdPlnParams','NoDaysinPeriod', 30);
      FExcessAboveRC := FwdPlnIniFile.ReadBool('FwdPlnParams','ExcessUses', True);
      FOrderMethod := FwdPlnIniFile.ReadInteger('FwdPlnParams','TypeofOrdering',0);
      FRoundMOQ := FwdPlnIniFile.ReadInteger('FwdPlnParams','RoundMOQ',0);
      FRoundMULT := FwdPlnIniFile.ReadInteger('FwdPlnParams','RoundMULT',0);
      FTypeofSimulation := FwdPlnIniFile.ReadInteger('FwdplnParams','TypeofSimulation',0);
      FCOUsage := FwdPlnIniFile.ReadInteger('FwdPlnParams','UseOfCustomerOrders',0);
      FOverFromSDD := FwdPlnIniFile.ReadBool('FwdPlnParams','OverdueCustomerOrderDate',True);
      FCurrFCUsage := FwdPlnIniFile.ReadInteger('FwdPlnParams','LocalMonthFactor',0);
      FCOOverride := FwdPlnIniFile.ReadInteger('FwdPlnParams','CustomerOrdersoverride',0);
      FOverCOIs := FwdPlnIniFile.ReadInteger('FwdPlnParams','OverdueCustomerOrdersImport',0);
      FNonStockedModel := FwdPlnIniFile.ReadInteger('FwdPlnParams','ModelCalcNonStocked',0);

      FUseBOM := FwdPlnIniFile.ReadBool('FwdplnParams','UseBOM',False);
      FUseDRP := FwdPlnIniFile.ReadBool('FwdplnParams','UseDRP',False);
      FStockdownloadDate := StrtoDate(FwdPlnIniFile.ReadString('FwdPlnParams','StockdownloadDate',''));
      FSurplusOrdersOutsideLT := FwdPlnIniFile.ReadBool('FwdplnParams','SurplusOrdersOutsideLT',False);
      FUseMin := FwdPlnIniFile.ReadBool('FwdplnParams','UseMinimumStock',False);
      FUseMOQ := FwdPlnIniFile.ReadBool('FwdplnParams','UseMOQ',False);
      FUseMULT := FwdPlnIniFile.ReadBool('FwdplnParams','UseMULT',False);
      FZeroNegStock := FwdPlnIniFile.ReadBool('FwdplnParams','TreatNegativeStockAsZero',False);
      FAvrFCPeriod := FwdPlnIniFile.ReadInteger('FwdPlnParams','PeriodsforAverageForecast',0);
      FFirstRatio := StrToFloat(FwdPlnIniFile.ReadString('FwdPlnParams','FirstPerioRatio','0'));
      FMinimumDays := FwdPlnIniFile.ReadInteger('FwdPlnParams','MinimumDaysRO',0);

      FUseFirmInSS := FwdPlnIniFile.ReadBool('FwdplnParams','UseDependantForecastsForSafetyStock',False);
      FFWDPODays := FwdPlnIniFile.ReadInteger('FwdplnParams','FwdPODays',0);
      FFWDCODays := FwdPlnIniFile.ReadInteger('FwdplnParams','FwdCODays',0);
      FFCRAtio := StrToFloat(FwdPlnIniFile.ReadString('FwdplnParams','LocalBORatio','0'));
      FBOMRAtio := StrToFloat(FwdPlnIniFile.ReadString('FwdplnParams','BOMBORatio','0'));
      FDRPRAtio := StrToFloat(FwdPlnIniFile.ReadString('FwdplnParams','DRPBORatio','0'));
      FRedistributableStockLevel := StrToInt(FwdPlnIniFile.ReadString('FwdplnParams','RedistributableStockLevel', '0'));

      ResetCOStruc;
      FCO.Cnt := 0;
      for i := 0 to FwdPlnIniFile.ReadInteger('CustomerOrders','Count',0)-1 do begin
        FCO.Arr[FCO.Cnt].DemDate := StrToDate(FwdPlnIniFile.ReadString('CustomerOrder'+inttostr(i),'OrderDate'  ,''));
        FCO.Arr[FCO.Cnt].DemQty  := FwdPlnIniFile.ReadInteger('CustomerOrder'+inttostr(i),'Quantity' ,0);
        Inc(FCO.Cnt);
      end;

      SalestoDate := StrtoFloat(FwdPlnInifile.ReadString('FwdPlnParams','SalestoDate','0'));

      ResetFCStruc;
      FFC.Cnt := FNoPeriodsFC;
      for i := 0 to FNoPeriodsFC-1 do begin
        FFC.Arr[i] := StrToFloat(FwdPlnIniFile.ReadString('PeriodLocalForecasts',inttostr(i),'0'));
      end;

      NoDays := FwdPlnIniFile.ReadInteger('DayForecasts','Count', 0);
      ResetBOMStruc;
      BOMCnt := 0;
      for I := 0 to NoDays do begin
        if FUseBOM then begin
          FBOM.Arr[I].DemDate := StrToDate(FwdPlnIniFile.ReadString('DayForecastDate',inttostr(I),''));
          FBOM.Arr[I].DemQty := StrToInt(FwdPlnIniFile.ReadString('DayBOMForecasts',inttostr(i),'0'));
          Inc(BOMCnt);
        end;
      end;
      FBOM.Cnt := BOMCnt;

      ResetDRPStruc;
      DRPCnt := 0;
      for I := 0 to NoDays do begin
        if FUseDRP then begin
          FDRP.Arr[I].DemDate := StrToDate(FwdPlnIniFile.ReadString('DayForecastDate',inttostr(I),''));
          FDRP.Arr[I].DemQty := StrToInt(FwdPlnIniFile.ReadString('DayDRPForecasts',inttostr(i),'0'));
          Inc(DRPCnt);
        end;
      end;
      FDRP.Cnt := DRPCnt;

      if FwdPlnIniFile.ReadString('StockBuild0','BuildStartDate','') <> '' then begin
        UseStockBuild := True;
        BuildStartdate := StrToDate(FwdPlnIniFile.ReadString('StockBuild0','BuildStartDate',''));
        ShutdownStart := StrToDate(FwdPlnIniFile.ReadString('StockBuild0','CloseStartDate',''));
        ShutdownEnd := StrToDate(FwdPlnIniFile.ReadString('StockBuild0','CloseEndDate'  ,''));
//PJK        EffShutdownStart := StrToDate(FwdPlnIniFile.ReadString('StockBuild0','EffCloseStartDate',''));
//PJK        EffShutdownEnd := StrToDate(FwdPlnIniFile.ReadString('StockBuild0','EffCloseEndDate'  ,''));
        OrdersDuringShutdown  := FwdPlnIniFile.ReadBool('StockBuild','CloseDownOrderingAllowed',False);
        Provide_For_Shortfall := FwdPlnIniFile.ReadBool('StockBuild','Provide_For_Shortfall',False);
        AllowCatchup          := FwdPlnIniFile.ReadBool('StockBuild', 'Allow_Catchup', false);
      end
      else
        UseStockBuild := False;

      ResetPOStruc;
      FPO.Cnt := 0;
      for i := 0 to FwdPlnIniFile.ReadInteger('PurchaseOrders','Count',0)-1 do begin
        FPO.Arr[FPO.Cnt].PODate := StrToDate(FwdPlnIniFile.ReadString('PurchaseOrder'+inttostr(i),'OrderDate',''));
        FPO.Arr[FPO.Cnt].POQty := StrToInt(FwdPlnIniFile.ReadString('PurchaseOrder'+inttostr(i),'Quantity','0'));
        FPO.Arr[FPO.Cnt].POMovedQty := 0;
        FPO.Arr[FPO.Cnt].PONo := 0;
        FPO.Arr[FPO.Cnt].POIdealDate := StrToDate(FwdPlnIniFile.ReadString('PurchaseOrder'+inttostr(i),'ArrivalDate',''));
        FPO.Arr[FPO.Cnt].POExpedited := 'N';
        Inc(FPO.Cnt);
      end;

      Pareto := FwdPlnInifile.ReadString('FwdPlnParams','Pareto','A')[1];
      Stocked := FwdPlnIniFile.ReadBool('FwdPlnParams','Stocked', True);
      SOH := StrToInt(FwdPlnInifile.ReadString('FwdPlnParams','StockOnHand','0'));
      BO := StrToInt(FwdPlnInifile.ReadString('FwdPlnParams','BackOrders','0'));
      CBO := StrToInt(FwdPlnInifile.ReadString('FwdPlnParams','ConsolidatedBranchOrders','0'));
      Bin := StrToInt(FwdPlnInifile.ReadString('FwdPlnParams','SlowMovingLevel','0'));

      SS := StrToFloat(FwdPlnIniFile.ReadString('FwdPlnParams','SafetyStock','0'));
      SSDays := Round(SS * FNoDaysInPeriod);

      LT := StrToFloat(FwdPlnIniFile.ReadString('FwdPlnParams','LeadTime','0'));
      LTDays := Round(LT * FNoDaysInPeriod);

      TransitLT := StrToFloat(FwdPlnIniFile.ReadString('FwdPlnParams','TransitLeadTime','0'));
      TransitLTDays := Round(TransitLT * FNoDaysInPeriod);

      RP := StrToFloat(FwdPlnIniFile.ReadString('FwdPlnParams','ReviewPeriod','0'));
      RPDays := Round(RP * FNoDaysInPeriod);

      RC := StrToFloat(FwdPlnIniFile.ReadString('FwdPlnParams','ReplenishmentCycle','0'));
      RCDays := Round(RC * FNoDaysInPeriod);

      MOQ := StrToInt(FwdPlnIniFile.ReadString('FwdPlnParams','OrderMinimum','0'));
      Mult := StrToInt(FwdPlnInifile.ReadString('FwdPlnParams','OrderMultiple','0'));
      Min := StrToInt(FwdPlnIniFile.ReadString('FwdPlnParams','MinimumStock','0'));
      CalcIdealArrival := FwdPlnIniFile.ReadBool('FwdPlnParams','CalcIdealArrival',False);
    finally
    end;
  except
    //ErrorHandler(ErrObjectInstantiationfailed)
  end;
end;

function TFwdPlanDLLDataModule.GetMonthFactor : double;
begin
  Get_MonthFactor.Close;
  Get_MonthFactor.ExecQuery;
  Result := ELRoundPer(Get_MonthFactor.FieldByName('MONTHFACTOR').AsFloat, 3);
end;

{ This function round a floating value to nearist Value }
function TFwdPlanDLLDataModule.ELRoundPer(Val : Double; Per : Byte) : Double;
var X, I : Integer;
begin
  { Calculate the displacement }
  X := 1;
  for I := 1 to Per do X := X * 10;

  { Displace the value }
  Val := Val * X;

  { Round the Value }
  Val := ELRound(Val);

  { Reverce the displaysement }
  Result := Val / X;
end;

function TFwdPlanDLLDataModule.ELRound(Val : Double) : Double;
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

procedure TFwdPlanDLLDataModule.GetConfigParams;
var
  Intrans : boolean;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  Intrans := DefaultTrans.InTransaction;
  if not Intrans then
    DefaultTrans.StartTransaction;
  try
    FStockDownloadDate := ReadConfigDate(104);
    FCurrentPeriod     := ReadConfigInt(100);
    FSurplusOrdersOutsideLT := (ReadConfigStr(304) = 'Y');
    FExcludePseudoFwdPO   := (ReadConfigStr(335, FLocationNo) = 'Y');
    FOriginalHorizon := ReadConfigInt(101);
    IF readconfigstr(388) = 'Y' then
      begin
        FNoPeriodsFC := Readconfigint(388);
      end                  
       else
      begin
        FNoPeriodsFC       := ReadConfigInt(101);
      end;
    FNoDaysInPeriod    := ReadConfigInt(102);
    FSystemInWeeks     := ReadConfigStr(102) = 'W';
    FAvrFCPeriod       := ReadConfigInt(193);
    FWeekStartDay      := ReadConfigInt(334);
    case ReadConfigStr(191)[1] of
      'P': FCurrFCUsage := 0;
      'S': FCurrFCUsage := 1;
      'F': FCurrFCUsage := 2;
    end;

    FFirstRatio        := GetMonthFactor;

    case ReadConfigStr(152)[1] of
      'B': FOverCOIs := 0;
      'C': FOverCOIs := 1;
      'I': FOverCOIs := 2;
    end;

    FOverFromSDD := ReadConfigStr(153) = 'S';

    case ReadConfigStr(198)[1] of
      'N': FCOUsage := 0;
      'A': FCOUsage := 1;
      'I': FCOUsage := 2;
    end;

    case ReadConfigStr(199)[1] of
      'D' : FCOOverride := 0;
      'W' : FCOOverride := 1;
      'M' : FCOOverride := 2;
    end;

  //  FCOMethod      : TCOOverride;     //     C   -=-     -=- What override to do (Use the above two parameters to determine what override to do) See Consirns

    FUseMOQ       := ReadConfigStr(184) = 'Y';
    FUseMult      := ReadConfigStr(186) = 'Y';
    FUseMin       := ReadConfigStr(324) = 'Y';

    FZeroNegStock := ReadConfigStr(190) = 'Y';
    FUseFirmInSS  := ReadConfigStr(196) = 'Y';
    FFWDPOPercentage := (ReadConfigFloat(188));  // Set percentage of Orders outside of leadtime
   // FFWDPODays    := Round(ReadConfigFloat(188) * FNoDaysInPeriod); //Check if this should only be days now and not this calculation (Yvette 26 Jan 2006)
    FFWDCOPercentage := (ReadConfigFloat(385));
    FUseBOM       := ReadConfigStr(203) = 'Y';
    FUseDRP       := ReadConfigStr(206)[1] = 'Y';
    FSplitStockBuildReceipts := trim(ReadConfigStr(464)) = 'Y';

    case ReadConfigStr(185)[1] of
      'U' : FRoundMOQ := 0;
      'D' : FRoundMOQ := 1;
      'N' : FRoundMOQ := 2;
    end;

    case ReadConfigStr(187)[1] of
      'U' : FRoundMult := 0;
      'D' : FRoundMult := 1;
      'N' : FRoundMult := 2;
    end;

    FExcessAboveRC := ReadConfigStr(195)[1] = 'Y';
    case ReadConfigStr(189)[1] of
      'R' : FOrderMethod := 0;
      'T' : FOrderMethod := 1;
      'A' : FOrderMethod := 2;
    end;
    FFCRatio        := ReadConfigFloat(124);
    FDRPRatio       := ReadConfigFloat(326);
    FBOMRatio       := ReadConfigFloat(325);
    FConfigFCRatio  := FFCRatio;
    FConfigDRPRatio := FDRPRatio;
    FConfigBOMRatio := FBOMRatio;

    FCORatio        := 1;
    FMinimumDays    := ReadConfigInt(318);

    FPercentageLT   := ReadConfigFloat(319, FLocationNo);
    FMinDaysLT      := ReadConfigInt(320, FLocationNo);
    FPercentageRecChanges := ReadConfigFloat(321, FLocationNo);
    FMinDaysRecChanges    := ReadConfigInt(322, FLocationNo);
    case ReadConfigStr(188)[1] of
      'S' : FTypeOfSimulation := 0;
      'P' : FTypeOfSimulation := 1;
      'I' : FTypeOfSimulation := 2;
    end;
    case ReadConfigStr(271)[1] of
      'Z' : FNonStockedModel := 0;
      'L' : FNonStockedModel := 1;
      'R' : FNonStockedModel := 2;
    end;
    FRedistributableStockLevel := ReadConfigInt(281);
    SupportEmail               := ReadConfigLongStr(311);
    fBODisplayMode := TFwdPlanBackOrderDisplayMode(ReadConfigInt(463));
  finally
    if not Intrans then
      DefaultTrans.Commit;
  end;
  {$ifdef debug}
  QryStopTime := GetTickCount();
  ConfigQueryElapsedTime := ConfigQueryElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

function TFwdPlanDLLDataModule.ReadConfigInt(ConfigNo : Integer;
                                                  LocationNo : Integer = -1) : integer;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFINTEGER ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := FieldByName('TYPEOFINTEGER').AsInteger;
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFINTEGER ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := FieldByName('TYPEOFINTEGER').AsInteger;
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TFwdPlanDLLDataModule.ReadConfigFloat(ConfigNo : Integer;
                                                    LocationNo : Integer = -1) : Double;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFFLOAT ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := FieldByName('TYPEOFFLOAT').AsFloat;
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFFLOAT ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := FieldByName('TYPEOFFLOAT').AsFloat;
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TFwdPlanDLLDataModule.ReadConfigStr(ConfigNo : Integer;
                                                  LocationNo : Integer = -1) : String;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFSTRING ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := trim(FieldByName('TYPEOFSTRING').AsString);
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFSTRING ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := trim(FieldByName('TYPEOFSTRING').AsString);
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TFwdPlanDLLDataModule.ReadConfigLongStr(ConfigNo : Integer;
                                                      LocationNo : Integer = -1) : String;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFLONGSTRING ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO ';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := trim(FieldByName('TYPEOFLONGSTRING').AsString);
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFLONGSTRING ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO ';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := trim(FieldByName('TYPEOFLONGSTRING').AsString);
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TFwdPlanDLLDataModule.ReadConfigDate(ConfigNo : Integer;
                                                   LocationNo : Integer = -1) : TDateTime;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select DESCRIPTION, TYPEOFSTRING, TYPEOFINTEGER, TYPEOFFLOAT, TYPEOFDATE, TYPEOFLONGSTRING ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO ';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := FieldByName('TYPEOFDATE').AsDateTime;
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFSTRING, TYPEOFINTEGER, TYPEOFFLOAT, TYPEOFDATE,TYPEOFLONGSTRING ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := FieldByName('TYPEOFDATE').AsDateTime;
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

procedure TFwdPlanDLLDataModule.CreateFCSQL;
var
  FFCSql          : String;
  I               : integer;
begin
  FFCSql := 'select FORECASTTYPENO,';
  for I := 0 to FOriginalHorizon-1 do begin
    FFCSql := FFCSql + 'FORECAST_' + IntToStr(I);
    if I < FOriginalHorizon -1 then begin
      FFCSql := FFCSql + ',';
    end;
  end;
  FFCSql := FFCSql + ' from ITEMFORECAST '
                   + ' where ITEMNO = ?ITEMNO '
                   + '   and CALENDARNO = ?CALENDARNO ';
  FFCSql := FFCSql + ' and FORECASTTYPENO = 1 ';

  sqlFC.SQL.Clear;
  sqlFC.SQL.Text := FFCSql;
end;

procedure TFwdPlanDLLDataModule.SetLocationCode(Value : String);
begin
  FLocationCode := Value;
end;

procedure TFwdPlanDLLDataModule.CreateCalendarStruc;
var
  CalCnt  : integer;
  n       : integer;
  InTrans : boolean;
begin
  Intrans := DefaultTrans.InTransaction;
  if not Intrans then
    DefaultTrans.StartTransaction;
  try
    qryCalendar.Close;
    qryCalendar.ParamByName('CURRENTPERIOD').AsInteger := FCurrentPeriod;
    qryCalendar.Open;
    qryCalendar.Last;
    CalCnt := qryCalendar.RecordCount;
    if CalCnt > trunc(MAX_DAYS_ARRAY_SIZE / FNoDaysInPeriod) then
      CalCnt := trunc(MAX_DAYS_ARRAY_SIZE / FNoDaysInPeriod);
    MakeCalStruc(FCal, CalCnt);
    qryCalendar.First;
    for n := 0 to CalCnt-1 do begin
      FCal.Arr^[n].CalStart := Trunc(qryCalendar.FieldByName('STARTDATE').AsDateTime);
      FCal.Arr^[n].CalEnd   := Trunc(qryCalendar.FieldByName('ENDDATE').AsDateTime);
      FCal.Arr^[n].NoDaysInPeriod   := trunc(FCal.Arr^[n].CalEnd - FCal.Arr^[n].CalStart)+1;
      qryCalendar.Next;
    end;
    FCal.Cnt := CalCnt;
  finally
    if not Intrans then
      DefaultTrans.Commit;
  end;
end;

procedure TFwdPlanDLLDataModule.SetLocationNo(Value : integer);
begin
  if FLocationNo <> Value then begin
    FLocationNo := Value;
    GetConfigParams;
    SetupTradingDays;
  end
end;

procedure TFwdPlanDLLDataModule.SetupTradingDays;
var
  DayCnt, I  : integer;
  Intrans : boolean;
begin
  Intrans := DefaultTrans.InTransaction;
  if not Intrans then
    DefaultTrans.StartTransaction;
  try
    DayCnt := 0;
    qryTradingDays.Close;
    qryTradingDays.ParamByName('LOCATIONNO').AsInteger := FLocationNo;
    qryTradingDays.ParamByName('STOCKDOWNLOADDATE').AsDateTime := trunc(FStockDownloadDate);
    qryTradingDays.Open;
    qryTradingDays.First;
    if qryTradingDays.eof then begin
      For I := 0 to FFP.Cnt-1 do begin
        FFact.Arr^[I] := 1;
      end;
      DayCnt := FFP.Cnt;
    end
    else begin
      while not qryTradingDays.Eof do begin
        if DayCnt < MAX_DAYS_ARRAY_SIZE then begin  // 1000 days is the limit
          FFact.Arr^[DayCnt] := qryTradingDays.FieldByName('RATIO').AsInteger;
          Inc(DayCnt);
        end;
        qryTradingDays.Next;
      end;
    end;
    FFact.Cnt := DayCnt;
  finally
    if not Intrans then
      DefaultTrans.Commit;
  end;
end;

procedure TFwdPlanDLLDataModule.OpenFCQuery(CalendarNo : integer);
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  sqlFC.Close;
  sqlFC.ParamByName('ITEMNO').AsInteger := ItemNo;
  sqlFC.ParamByName('CALENDARNO').AsInteger := CalendarNo;
  sqlFC.ExecQuery;
  GetIntFCIBsql (sqlFC,readconfigint(101));

  {$ifdef debug}
  QryStopTime := GetTickCount();
  FCQueryElapsedTime := FCQueryElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

procedure TFwdPlanDLLDataModule.OpenBOMQuery;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  sqlBOMDailyDemand.Close;
  sqlBOMDailyDemand.ParamByName('LOCATIONNO').AsInteger := LocationNo;
  sqlBOMDailyDemand.ParamByName('ITEMNO').AsInteger := ItemNo;
  sqlBOMDailyDemand.ParamByName('STOCKDOWNLOADDATE').AsDateTime := trunc(FStockDownloadDate);
  sqlBOMDailyDemand.ExecQuery;

  {$ifdef debug}
  QryStopTime := GetTickCount();
  BOMFCQueryElapsedTime := BOMFCQueryElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

procedure TFwdPlanDLLDataModule.OpenDRPQuery;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  sqlDRPDailyDemand.Close;
  sqlDRPDailyDemand.ParamByName('LOCATIONNO').AsInteger := LocationNo;
  sqlDRPDailyDemand.ParamByName('ITEMNO').AsInteger := ItemNo;
  sqlDRPDailyDemand.ParamByName('STOCKDOWNLOADDATE').AsDateTime := trunc(FStockDownloadDate);
  sqlDRPDailyDemand.ExecQuery;

  {$ifdef debug}
  QryStopTime := GetTickCount();
  DRPFCQueryElapsedTime := DRPFCQueryElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

procedure TFwdPlanDLLDataModule.OpenBOMDataSet;
begin
  qryBOMDailyDemand.Close;
  qryBOMDailyDemand.ParamByName('ITEMNO').AsInteger := ItemNo;
  qryBOMDailyDemand.ParamByName('STOCKDOWNLOADDATE').AsDateTime := trunc(FStockDownloadDate);
  qryBOMDailyDemand.Open;
end;

procedure TFwdPlanDLLDataModule.OpenDRPDataSet;
begin
  qryDRPDailyDemand.Close;
  qryDRPDailyDemand.ParamByName('ITEMNO').AsInteger := ItemNo;
  qryDRPDailyDemand.ParamByName('STOCKDOWNLOADDATE').AsDateTime := trunc(FStockDownloadDate);
  qryDRPDailyDemand.Open;
end;

procedure TFwdPlanDLLDataModule.OpenCOQuery;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  sqlCO.Close;
  sqlCO.ParamByName('ITEMNO').AsInteger := ItemNo;
  sqlCO.ExecQuery;

  {$ifdef debug}
  QryStopTime := GetTickCount();
  COQueryElapsedTime := COQueryElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

procedure TFwdPlanDLLDataModule.OpenPOQuery;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  sqlPO.Close;
  sqlPO.ParamByName('ITEMNO').AsInteger := ItemNo;
  sqlPO.ExecQuery;

  {$ifdef debug}
  QryStopTime := GetTickCount();
  POQueryElapsedTime := POQueryElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

function TFwdPlanDLLDataModule.MustExcludePOfromSurplus(IndicatorToExclude: String): Boolean;
begin
  // PY ToDo what about a transaction here
  if not FOpenedPOexcludeList then begin
    qryExclPO.Close;
    qryExclPO.Open;
    FOpenedPOexcludeList := True;
  end;
  // the default is false which means that if a macth was not found the PO will
  // NOT be excluded from the surplus order calculation
  result := False;
  if not qryExclPO.IsEmpty then begin
    qryExclPO.First;
    while not qryExclPO.Eof do begin
      if UPPERCASE(qryExclPO.FieldByName('PO_EXCLUDE_IND').AsString) = UPPERCASE(IndicatorToExclude) then begin
        result := True;
        Break;
      end;
      qryExclPO.Next;
    end;
  end;
end;

procedure TFwdPlanDLLDataModule.LoadConfigParams;
begin
  FParams.StockDate   := trunc(FStockDownloadDate);
  FParams.WeekStartDay := FWeekStartDay;
  FParams.SurplusOrdersOutsideLT := FSurplusOrdersOutsideLT;
  FParams.ExcludePseudoFwdPO := FExcludePseudoFwdPO;
  FParams.NoPeriodsFC := FNoPeriodsFC;
  FParams.AvrFCPeriod := FAvrFCPeriod;
  FParams.ProactiveM := ReadConfigStr(413) = 'Y';

  FParams.NoDaysInPeriod := FNoDaysInPeriod;
  case FCurrFCUsage of
    0: FParams.CurrFCUsage := fcUseProrate;
    1: FParams.CurrFCUsage := fcUseSalesToDate;
    2: FParams.CurrFCUsage := fcUseFull;
  end;
  FParams.FirstRatio := FFirstRatio;
  case FOverCOIs of
    0: FParams.OverCOIs := ociBackOrdered;
    1: FParams.OverCOIs := ociInFirst;
    2: FParams.OverCOIs := ociIgnored;
  end;
  FParams.OverFromSDD := FOverFromSDD;
  case FCOUsage of
    0: FParams.COUsage := coUseIgnore;
    1: FParams.COUsage := coUseAdd;
    2: FParams.COUsage := coUseOverride;
  end;
  case FCOOverride of
    0: FParams.COOverride := coDay;
    1: FParams.COOverride := coWeek;
    2: FParams.COOverride := coPeriod;
  end;
  FParams.UseMOQ       := FUseMOQ;
  FParams.UseMult      := FUseMult;
  FParams.UseMin       := FUseMin;
  FParams.ZeroNegStock := FZeroNegStock;
  FParams.UseFirmInSS  := FUseFirmInSS;
  FParams.FWDPOPercentage := FFWDPOPercentage;
  FParams.FWDCOPercentage := FFWDCOPercentage;
  //FParams.FWDPODays    := FFWDPODays;
//PJK  FParams.UseBOM := FUseBOM;
//PJK  FParams.UseDRP := FUseDRP;
  FParams.ExitQuick    := False;
  case FRoundMOQ of
    0: FParams.RoundMOQ := RoundUp;
    1: FParams.RoundMOQ := RoundDown;
    2: FParams.RoundMOQ := RoundNear;
  end;
  case FRoundMult of
    0: FParams.RoundMult := RoundUp;
    1: FParams.RoundMult := RoundDown;
    2: FParams.RoundMult := RoundNear;
  end;
  FParams.ExcessAboveRC  := FExcessAboveRC;
  FParams.CORatio        := 1; //FCORatio;
  FParams.FCRatio        := FFCRatio/100;
  FParams.DRPRatio       := FDRPRatio/100;
  FParams.BOMRatio       := FBOMRatio/100;
  FParams.UseFixedLevels := FUseFixedLevels;
  FParams.MinimumDays    := FMinimumDays;
  FParams.PercentageLT   := FPercentageLT;
  FParams.MinDaysLT      := FMinDaysLT;
  FParams.PercentageRecChanges := FPercentageRecChanges;
  FParams.MinDaysRecChanges := FMinDaysRecChanges;
  FParams.ExpeditePO     := FExpeditePO;
  if Fparams.ForceSimulation = ftsNone then begin
      case FTypeOfSimulation of
        0: FParams.TypeOfSimulation := tsCurrent;
        1: FParams.TypeOfSimulation := tsProjection;
        2: FParams.TypeOfSimulation := tsIdeal;
        3: FParams.TypeOfSimulation := tsFixed;
      end;
  end else begin
     case fparams.forceSimulation of
      ftscurrent: FParams.TypeOfSimulation := tsCurrent;
      ftsprojection: FParams.TypeOfSimulation := tsProjection;
      ftsideal: FParams.TypeOfSimulation := tsIdeal;
      ftsFixed: FParams.TypeOfSimulation := tsFixed;
    end;
  end;
  case FNonStockedModel of
    0: FParams.NonStockedModel := nmZero;
    1: FParams.NonStockedModel := nmLeadTime;
    2: FParams.NonStockedModel := nmHalfRP;
  end;
  
  if FParams.TypeOfSimulation = tsFixed then
    FParams.FixedHorizon := FFixedHorizon * FNoDaysInPeriod;
    
  FParams.RedistributableStockLevel := FRedistributableStockLevel;
  FParams.SplitStockBuildReceipts := FSplitStockBuildReceipts;

  case FOrderMethod of
    0: FParams.OrderMethod := omReOrderPoint;
    1: FParams.OrderMethod := omTopup;
    2: FParams.OrderMethod := omAuto;
  end;
end;

function TFwdPlanDLLDataModule.CalculateDayPolicy(PolicyValue : double) : integer;
begin
  if FSystemInWeeks then begin
    Result := trunc(PolicyValue * FParams.NoDaysInPeriod);
  end
  else begin
    if PolicyValue = 0.00 then
      Result := 0
      else if PolicyValue = 0.04 then
        Result := 1
      else if PolicyValue = 0.23 then
             Result := 7
        else if PolicyValue = 0.46 then
           Result := 14
          else if PolicyValue = 0.93 then
             Result := 28
            else if (not (PolicyValue = 1)) and (not (trunc(PolicyValue / 1) = (PolicyValue / 1))) then
               Result := trunc(ELRound(PolicyValue * FParams.NoDaysInPeriod))
              else
                Result := -1;
  end;
end;

procedure TFwdPlanDLLDataModule.LoadItemParams;
begin
  if Pareto = 'X' then  // X items are treated as non-stocked
    Stocked  := False;

  FParams.ItemNo        := ItemNo;
  FParams.SalesToDate   := SalesToDate;
  FParams.Stocked       := Stocked;
  FParams.Pareto        := Pareto;

  if FParams.SS < 0 then
    FParams.SS := 0;
  // Some rules apply if the following fields are zero
  if not FSystemInWeeks then begin
    if FParams.RC < 0.0 then
      FParams.RC := 0.04;
    if FParams.RP < 0.04 then
      FParams.RP := 0.04;
    if FParams.LT < 0.04 then
      FParams.LT := 0.04;
  end
  else begin
    if FParams.RC < 0.15 then
      FParams.RC := 0.15;
    if FParams.RP < 0.15 then
      FParams.RP := 0.15;
    if FParams.LT < 0.15 then
      FParams.LT := 0.15;
  end;

  FParams.SSDays := CalculateDayPolicy(FParams.SS);
  FParams.RCDays := CalculateDayPolicy(FParams.RC);
  FParams.RPDays := CalculateDayPolicy(FParams.RP);
  FParams.LTDays := CalculateDayPolicy(FParams.LT);

  if TransitLTDays > LTDays then begin
    TransitLTDays := LTDays;
  end;

{  FParams.SSDays        := SSDays;
  FParams.RCDays        := RCDays;
  FParams.RPDays        := RPDays;
  FParams.LTDays        := LTDays;}
  if EffRCDays <> -1 then // If This has not been set by the application calling this, then set eff rc = rc
    FParams.EffRCDays     := EffRCDays;

  if (FParams.OrderMethod = omAuto) and (FParams.RCDays = FParams.RPDays) then
    FParams.OrderMethod := omTopup;

  FParams.SSLTDays      := SSLTDays;
  FParams.SSRCDays      := SSRCDays;
  FParams.SSHalfRCDays  := SSHalfRCDays;
  FParams.SSRPDays      := SSRPDays;
  FParams.SSLTRPDays    := SSLTRPDays;
  FParams.SSLTRCDays    := SSLTRCDays;

  FParams.TransitLTDays := TransitLTDays;
  FParams.SOH           := SOH;
  FParams.BO            := BO;
  FParams.CBO           := CBO;
  FParams.Bin           := Bin;

  if not FUseMOQ then
    FParams.MOQ           := 1
  else
    FParams.MOQ           := MOQ;

  if not FUseMult then
    FParams.Mult          := 1
  else
    FParams.Mult          := Mult;

  FParams.Min           := Min;

  FParams.UseFixedLevels := UseFixedLevels;
  if FParams.UseFixedLevels then begin
    FParams.FixedSS := FixedSS;
    FParams.FixedSSRC := FixedSSRC;
  end;

  FParams.CalcIdealArrival := CalcIdealArrival;
  FParams.UseStockBuild    := UseStockBuild;
  FParams.BuildStartDate   := BuildStartDate;
  FParams.ShutdownStart    := ShutdownStart;
  FParams.ShutdownEnd      := ShutdownEnd;
  FParams.EffShutdownStart := ShutdownStart + TransitLTDays;
  FParams.EffShutdownEnd   := ShutdownEnd + TransitLTDays;
  FParams.AllowCatchup := AllowCatchup;
  FParams.OrdersInShutdown := OrdersDuringShutdown;
  FParams.ProvideShortfall := Provide_For_Shortfall;



  // Initialize  output values
  FParams.IdealArrivalDate := 0;
  FParams.NowTopup := 0;
  FParams.NowIdeal := 0;
  FParams.NowOrder := 0;
  FParams.AverageFC := 0.00;
  FParams.BuildQty := 0;
  FParams.MOQDays := 0;
//  FParams.EffRCDays := FParams.RCDays;

  // Initialize Internal Use Variables
  FParams.BuildStartDay := 0;
  FParams.ShutdownStartDay := 0;
  FParams.ShutdownEndDay := 0;
  FParams.EffShutdownStartDay := 0;
  FParams.EffShutdownEndDay := 0;
  FParams.Level := 0;
  FParams.OrdersInBuild := 0;
  FParams.TempBuildQty  := 0;
  FParams.OutRes        := 0;
  FParams.BuildTotal    := 0;

  FParams.EffectiveLTDay    := 0;
  FParams.OverduePOIncluded := 0;
  FParams.OverduePOExcluded := 0;
  FParams.CalcSurplusOrders := True;
  FParams.SurplusOrders     := 0;

  FParams.ForwardSS := 0;
  FParams.ForwardLT := 0;
  FParams.ForwardSSLT := 0;
  FParams.ForwardLTSSRC := 0;
  FParams.ForwardSSRC := 0;
  FParams.ForwardSSRP := 0;
  FParams.ForwardSSHalfRC := 0;
  FParams.ForwardLTSSRP := 0;
  FParams.ForwardSONHBackOrder := 0;
  FParams.ForwardSONHBackorderSONO := 0;
  FParams.ForwardSONHBackorderSONOInLT := 0;
  FParams.PeriodsOnOrder := 0;
  FParams.FirmLTSSRC := 0;
  FParams.RemainingFC := 0;
  FParams.ForwardSSLT_SSPortion := 0;
  FParams.ForwardLTSSRC_SSPortion := 0;
  FParams.ForwardSSRC_SSPortion := 0;
  FParams.ForwardSSHALFRC_SSPortion := 0;
  FParams.ForwardSSHALFRC_PLAIN_SSPortion := 0;

  FParams.PeriodsOnHand  := 0;

  FParams.RedistributableExcess := 0;
  FParams.StockOnOrder          := StockOnOrder;
  FParams.StockOnOrderOther     := StockOnOrderOther;
  FParams.StockOnOrderInLT      :=  StockOnOrderInLT;
  FParams.StockOnOrderInLTOther :=  StockOnOrderInLTOther;
  FParams.LostSales := 0;
end;

function TFwdPlanDLLDataModule.CalculateCarryVal(var IntVal: double; const DoubleVal : currency): double;
Var
  DifVal : Currency;
begin
  // BFP11343 New CalculateCarryVal function, RM, 07/07/2009
  result := 0.0;
  difval := 0;
  if (IntVal <> DoubleVal) then
  begin
    DifVal := DoubleVal - IntVal;
    if (DifVal >= 0.5) then
    begin
      IntVal := IntVal + 1;
      result := (-1 + DifVal)
    end
    else
      result := DifVal;
  end;
end;

function TFwdPlanDLLDataModule.CalculateAvgForecast(const TotalForeCast : double): double;
begin
  // BFP11343 New CalculateAvgForecast function, RM, 07/07/2009
  result := 0;
  If FAvrFCPeriod > 0 then
    result := TotalForeCast / FAvrFCPeriod;
end;

procedure TFwdPlanDLLDataModule.SetupFC;
var
  n : integer;
  CarryVal : Currency;
  IntVal : double;
  DoubleVal : Currency;
  //DifVal : Currency;
  TotalForeCast,
  AvgForecast : double;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}
  // Load all the Local forecasts
  FFC.Cnt := 0;
  if (sqlFC.RecordCount > 0) then
  begin
    CarryVal := 0;
  //  DifVal := 0;
    TotalForeCast := 0;
    AvgForecast := 0;
    for n := 0 to FOriginalHorizon -1 do
    begin
      IF N >= (FOriginalHorizon ) - FAvrFCPeriod then
        TotalForeCast := TotalForeCast + sqlFC.FieldByName('FORECAST_' + IntToStr(n)).AsDouble;
      sqlFC.FieldByName('FORECAST_' + IntToStr(n)).AsCurrency :=
              sqlFC.FieldByName('FORECAST_' + IntToStr(n)).AsCurrency + CarryVal;
      IntVal := Int(sqlFC.FieldByName('FORECAST_' + IntToStr(n)).AsCurrency);
      DoubleVal := sqlFC.FieldByName('FORECAST_' + IntToStr(n)).AsCurrency;

      // BFP11343 uses new CalculateCarryVal function, RM, 07/07/2009
      CarryVal := CalculateCarryVal(IntVal, DoubleVal);
      FFC.Arr[n] := IntVal;
    end;

    If FNoperiodsFC <> FOriginalHorizon then
    begin
      // BFP11343 uses new CalculateAvgForecast function, RM, 07/07/2009
      AvgForecast := CalculateAvgForecast(TotalForeCast);
      for n := FOriginalHorizon to FNoPeriodsFC -1 do
      begin
        AvgForecast := AvgForecast + CarryVal;
        IntVal := Int(AvgForecast);
        DoubleVal := avgforecast;

        // BFP11343 uses new CalculateCarryVal function, RM, 07/07/2009
        CarryVal := CalculateCarryVal(IntVal, DoubleVal);
        FFC.Arr[n] := IntVal;
      end;
    end;
  end;

  FFC.Cnt := FNoPeriodsFC;

  {$ifdef debug}
  QryStopTime := GetTickCount();
  FCLoadElapsedTime := FCLoadElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

procedure TFwdPlanDLLDataModule.SetupBOMFC;
var
  n : integer;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  OpenBOMQuery;

  // Load all the Local forecasts
  n := 0;
  while not sqlBOMDailyDemand.Eof do begin
    FBOM.Arr[n].DemDate := trunc(sqlBOMDailyDemand.FieldByName('FORECASTDATE').AsDateTime);
    FBOM.Arr[n].DemQty := trunc(sqlBOMDailyDemand.FieldByName('FCVALUE').AsFloat);
    inc(n);
    sqlBOMDailyDemand.Next;
  end;
  FBOM.Cnt := n;

  {$ifdef debug}
  QryStopTime := GetTickCount();
  FCBOMLoadElapsedTime := FCBOMLoadElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

procedure TFwdPlanDLLDataModule.SetupDRPFC;
var
  n : integer;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  OpenDRPQuery;
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

  {$ifdef debug}
  QryStopTime := GetTickCount();
  FCDRPLoadElapsedTime := FCDRPLoadElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

procedure TFwdPlanDLLDataModule.SetupCO;
var
  LDate : TDateTime;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  // Load All the CO's
  OverCO  := 0;
  FCO.Cnt := 0;

  if FOverFromSDD then
    LDate := trunc(FStockDownloadDate)  // Ignore all
  else begin
    qryCalendar.First;
    LDate := Trunc(qryCalendarSTARTDATE.AsDateTime);  // Start Of Period so ignore all before that
  end;

  while not sqlCO.Eof do begin
    if trunc(sqlCO.FieldByName('EXPECTEDDELIVERYDATE').AsDateTime) >= LDate then begin  // Ignore Some Co's
      FCO.Arr[FCO.Cnt].DemDate := trunc(sqlCO.FieldByName('EXPECTEDDELIVERYDATE').AsDateTime);
      FCO.Arr[FCO.Cnt].DemQty  := sqlCO.FieldByName('Quantity').AsInteger;
      Inc(FCO.Cnt);
    end else begin
      // The Date Smaller than to Ignore Customer Orders
      case FOverCOIs of
        0 : begin  // Backordered
              OverCO := OverCO + sqlCO.FieldByname('Quantity').AsInteger;
            end;
        1 : begin  // First Period so add all orders to first period
              FCO.Arr[FCO.Cnt].DemDate := trunc(FStockDownloadDate);
              FCO.Arr[FCO.Cnt].DemQty  := sqlCO.FieldByName('Quantity').AsInteger;
              Inc(FCO.Cnt);
            end; 
        //2 : Do.Nothing; // Ignore so ignore all overdue Orders
      end;
    end;
    if FCO.Cnt > MAX_CO_ARRAY_SIZE - 1 then
      break;
    sqlCO.Next;
  end;

  {$ifdef debug}
  QryStopTime := GetTickCount();
  COLoadElapsedTime := COLoadElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

procedure TFwdPlanDLLDataModule.SetupPO;
begin
  {$ifdef debug}
  QryStartTime := GetTickCount();
  {$endif}

  // Load PO's and Calculate Overdue Po's
  OverPO := 0;
  FPO.Cnt := 0;

  while not sqlPO.Eof do begin
    if trunc(sqlPO.FieldByname('EXPECTEDARRIVALDATE').AsDateTime) >= trunc(FStockDownloadDate) then begin
      FPO.Arr[FPO.Cnt].PODate := trunc(sqlPO.FieldByname('EXPECTEDARRIVALDATE').AsDateTime);
      FPO.Arr[FPO.Cnt].POQty := sqlPO.FieldByname('Quantity').AsInteger;
      FPO.Arr[FPO.Cnt].POMovedQty := 0;
      FPO.Arr[FPO.Cnt].PONo := sqlPO.FieldByname('PURCHASEORDERNO').AsInteger;
      FPO.Arr[FPO.Cnt].POIdealDate := trunc(sqlPO.FieldByname('EXPECTEDARRIVALDATE').AsDateTime);
      FPO.Arr[FPO.Cnt].POExpedited := 'N';
      FPO.Arr[FPO.Cnt].ExcludeFromSurplus := MustExcludePOfromSurplus(sqlPO.FieldByname('EXTERNALINDICATOR').AsString);
      FPO.Arr[FPO.Cnt].POIndicator := sqlPO.FieldByname('EXTERNALINDICATOR').AsString[1];
      Inc(FPO.Cnt);
    end else begin
      OverPO := OverPO + sqlPO.FieldByname('Quantity').AsInteger;
      if MustExcludePOfromSurplus(sqlPO.FieldByname('EXTERNALINDICATOR').AsString) then
        FParams.OverduePOExcluded := FParams.OverduePOExcluded + sqlPO.FieldByname('Quantity').AsInteger
      else
        FParams.OverduePOIncluded := FParams.OverduePOIncluded + sqlPO.FieldByname('Quantity').AsInteger;
    end;
    if FPO.Cnt >= MAX_PO_ARRAY_SIZE - 1 then
      break;
    sqlPO.Next;
  end;
  if FParams.TypeOfSimulation = tsIdeal then begin
    OverPO := 0;
    FParams.OverduePOExcluded := 0;
    FParams.OverduePOIncluded := 0;
  end;
  {$ifdef debug}
  QryStopTime := GetTickCount();
  POLoadElapsedTime := POLoadElapsedTime + (QryStopTime - QryStartTime);
  {$endif}
end;

procedure TFwdPlanDLLDataModule.LoadFCWI;
var
  InTrans : Boolean;
begin
  FromFC := False;

  Intrans := DefaultTrans.InTransaction;
  if not Intrans then
    DefaultTrans.StartTransaction;
  try
    OpenPOQuery;
    if UseDailyBOMDRP then begin
      if FUseBOM then
        SetupBOMFC;
      if FUseDRP then
        SetupDRPFC;
    end;
    SetupPO;
  finally
    if not Intrans then
      DefaultTrans.Commit;
  end;
end;

// l_iNoDays is used in the DemandPlanningConsolidation where we need to set NoDays differently
// All other applications that call DoCalc can ignore this parameter
function TFwdPlanDLLDataModule.DoCalc(l_iNoDays : Integer = -1) : integer;
var
  NoDays : integer;
  CalCreateResult : integer;
  Intrans : boolean;
begin
  FAdjustedDownloadDateStart := False;
  FAdjustedDownloadDateEnd   := False;
//  ResetBOMStruc;
//  ResetDRPStruc;

  qryCalendar.First;
  if trunc(FStockDownloadDate) < trunc(qryCalendar.FieldByName('STARTDATE').AsDateTime) then begin
    FStockDownloadDate := trunc(qryCalendar.FieldByName('STARTDATE').AsDateTime);
    FAdjustedDownloadDateStart := True;
  end;
  if trunc(FStockDownloadDate) > trunc(qryCalendar.FieldByName('ENDDATE').AsDateTime) then begin
    FStockDownloadDate := trunc(qryCalendar.FieldByName('ENDDATE').AsDateTime);
    FAdjustedDownloadDateEnd := True;
  end;

  LoadConfigParams;
  LoadItemParams;

  if (l_iNoDays = -1) then begin
    NoDays := (FNoPeriodsFC * FNoDaysInPeriod) + (trunc(FParams.LT + FParams.SS + FParams.RC)*FNoDaysInPeriod);
  end
  else begin
    NoDays := (FNoPeriodsFC * FNoDaysInPeriod) + (l_iNoDays*FNoDaysInPeriod);
  end;

  if NoDays > MAX_CAL_ARRAY_SIZE then
    NoDays := MAX_CAL_ARRAY_SIZE;

  Intrans := DefaultTrans.InTransaction;
  if not Intrans then
    DefaultTrans.StartTransaction;
  try
    try
      OpenFCQuery(FCurrentPeriod);
      try
        FFP.Cnt := NoDays; //PK Check this out.
        CalCreateResult := MakeCal(FFP, FCal, FFact, FParams);

        if CalCreateResult = 0 then begin
          OpenCOQuery;
          OpenPOQuery;

          if FUseBOM then
            SetupBOMFC;
          if FUseDRP then
            SetupDRPFC;

          SetupFC;
          SetupCO;
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
          FParams.FWDCODays := Trunc(FParams.FWDCOPercentage * (FParams.LT*FParams.NoDaysInPeriod));
          FFWDCODays := FParams.FWDCODays;
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



function TFwdPlanDLLDataModule.DoWICalc : integer;
var
  NoDays : integer;
  CalCreateResult : integer;
  InTrans : Boolean;
begin
  try
    LoadConfigParams;
    LoadItemParams;
    NoDays := (FNoPeriodsFC * FNoDaysInPeriod) + (trunc(FParams.LT + FParams.SS + FParams.RC)*FNoDaysInPeriod);

    if NoDays > MAX_CAL_ARRAY_SIZE then
      NoDays := MAX_CAL_ARRAY_SIZE;

    FFP.Cnt := NoDays;
    FAdjustedDownloadDateStart := False;
    FAdjustedDownloadDateEnd := False;

    try
      CalCreateResult := MakeCal(FFP, FCal, FFact, FParams);
      if CalCreateResult = 0 then begin
        Intrans := DefaultTrans.InTransaction;
        if not Intrans then
          DefaultTrans.StartTransaction;
        try
          OpenCOQuery;
          SetupCO;
          if FromFC then begin
             LoadFCWI;
          end;
          if FParams.TypeOfSimulation = tsIdeal then
            OverPO := 0;
        finally
          if not Intrans then
            DefaultTrans.Commit;
        end;

        if NoDays < FFP.Cnt then
            FFP.Cnt := NoDays;

        FParams.FWDPODays := Trunc(FParams.FWDPOPercentage * (FParams.LT*FParams.NoDaysInPeriod));
        FFWDPODays := FParams.FWDPODays;

        FParams.FWDCODays := Trunc(FParams.FWDCOPercentage * (FParams.LT*FParams.NoDaysInPeriod));
        FFWDCODays := FParams.FWDCODays;
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
end;

function TFwdPlanDLLDataModule.GetDataPath(var DatabasePath, Password : string) : boolean;
var
  Reg : TRegistry;
  MustReadMachine : boolean;

begin
  Result := False;
  Reg := TRegistry.Create;
  try
    with Reg do begin
      Access := KEY_READ;
      RootKey := HKEY_CURRENT_USER;
      if KeyExists('Software\Execulink\optimiza\database') then begin
        if OpenKey('Software\Execulink\optimiza\database', False) then begin
          DatabasePath := Reg.ReadString('Path');
          if DatabasePath <> '' then begin
            DatabaseDescription := Reg.ReadString('Name');
            Result := True;
            MustReadMachine := False;
          end
          else begin
            MustReadMachine := True;
            CloseKey;
          end;
        end
        else begin
          MessageDlg('Cannot find the database path in the local registry. Please run the Database Manager to configure at least one database', mtError, [mbOk], 0);
          DatabaseDescription := 'Undefined database';
          Result := False;
          MustReadMachine := False;
        end;
      end
      else
        MustReadMachine := True;
 {============================================
   if cPth = '' then
  begin
    SvpReg1 := TRegistry.Create;
    SvpReg1.Access := KEY_READ;
    SvpReg1.RootKey := HKEY_LOCAL_MACHINE;
    cVar := 'SOFTWARE\Execulink\Svp\Database';
    cPth := '';

    If SvpReg1.OpenKey(cVar, False) = True then
    Begin
      cPth := SvpReg1.ReadString(svpPath);
      FDbDescription := SvpReg1.ReadString('Name');
    End;
    SvpReg1.CloseKey;
    SvpReg1.Free;
============================================ }
      if MustReadMachine then begin
        RootKey := HKEY_LOCAL_MACHINE;
        if OpenKey('Software\Execulink\SVP\Database', False) then begin
          DatabasePath := Reg.ReadString('Path');
          DatabaseDescription := Reg.ReadString('Name');
          Result := True;
        end
        else begin
          MessageDlg('Cannot find the database path in the local registry. Please run the Database Manager to configure at least one database', mtError, [mbOk], 0);
          DatabaseDescription := 'Undefined database';
          Result := False;
        end;
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TFwdPlanDLLDataModule.GetStockBuild(l_iStockBuildNo: Integer);
var
InTrans : boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    qryStockBuild.Close;
    qryStockBuild.ParamByName('STOCK_BUILDNO').AsInteger :=l_iStockBuildNo;
    qryStockBuild.Open;
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;


procedure TFwdPlanDLLDataModule.SetItemInfo(DataSet : TIBDataSet; SetCalcIdealArrival : boolean);
var
  ParetoCat : string;
begin
  //set fwdplan item params
  ItemNo := DataSet.FieldByName('ITEMNO').AsInteger;;
  Stocked := (DataSet.FieldByName('STOCKINGINDICATOR').AsString = 'Y');
  SalesToDate := DataSet.FieldByName('SALESAMOUNT_0').AsInteger;
  ParetoCat := DataSet.FieldByName('PARETOCATEGORY').AsString;
  if length(ParetoCat) = 1 then
    Pareto := ParetoCat[1]
  else begin
    if Stocked then
      Pareto := 'B'
    else
      Pareto := 'F';
  end;
  FParams.SS := DataSet.FieldByName('SAFETYSTOCK').AsFloat;
  FParams.RC := DataSet.FieldByName('REPLENISHMENTCYCLE').AsFloat;
  if (Stocked and (Pareto = 'M') and (ReadConfigStr(411) = 'Y')) or ((not stocked) and (ReadConfigStr(412) = 'Y')) then
  begin
    if FSystemInWeeks then FParams.RP := 0.15 else FParams.RP := 0.04;
  end
  else
    FParams.RP := DataSet.FieldByName('REVIEWPERIOD').AsFloat;
  FParams.LT := DataSet.FieldByName('LEADTIME').AsFloat;
  FParams.EffectiveRC := DataSet.FieldByName('EFFECTIVERC').AsFloat;

  SSDays := Trunc(ELRound(DataSet.FieldByName('SAFETYSTOCK').AsFloat * FNoDaysInPeriod));
  RCDays := Trunc(ELRound(DataSet.FieldByName('REPLENISHMENTCYCLE').AsFloat * FNoDaysInPeriod));
  EffRCDays := Trunc(ELRound(DataSet.FieldByName('EFFECTIVERC').AsFloat * FNoDaysInPeriod));
  RPDays := Trunc(ELRound(DataSet.FieldByName('REVIEWPERIOD').AsFloat * FNoDaysInPeriod));
  LTDays := Trunc(ELRound(DataSet.FieldByName('LEADTIME').AsFloat * FNoDaysInPeriod));

  SSLTDays      := SSDays + LTDays;
  SSRCDays      := SSDays + RCDays;
  SSHalfRCDays  := SSDays +  ((RCDays)div 2);
  SSRPDays      := SSDays +  RPDays;
  SSLTRPDays    := SSDays +  LTDays + RPDays;
  SSLTRCDays    := SSDays +  LTDays + RCDays;

  TransitLTDays := Trunc(ELRound(DataSet.FieldByName('TRANSITLT').AsFloat * FNoDaysInPeriod));

  SOH := Trunc(DataSet.FieldByName('STOCKONHAND').AsFloat);
  BO := Trunc(DataSet.FieldByName('BACKORDER').AsFloat);
  CBO := Trunc(DataSet.FieldByName('CONSOLIDATEDBRANCHORDERS').AsFloat);
  Bin := Trunc(DataSet.FieldByName('BINLEVEL').AsFloat);
  MOQ := Trunc(DataSet.FieldByName('MINIMUMORDERQUANTITY').AsFloat);
  Mult := Trunc(DataSet.FieldByName('ORDERMULTIPLES').AsFloat);
  Min := Trunc(DataSet.FieldByName('Min_SS_Units').AsFloat);
  StockOnOrder := DataSet.FieldByName('STOCKONORDER').AsInteger;
  StockOnOrderInLT := DataSet.FieldByName('STOCKONORDERINLT').AsInteger;
  StockOnOrderOther := DataSet.FieldByName('STOCKONORDER_OTHER').AsInteger;
  StockOnOrderInLTOther := DataSet.FieldByName('STOCKONORDERINLT_OTHER').AsInteger;

  UseFixedLevels :=  False;
  if UseFixedLevels then begin
    FixedSS := 0;
    FixedSSRC := 0;
  end;

  if not DataSet.FieldbyName('BACKORDERRATIO').IsNull then begin
    FFCRatio := DataSet.FieldbyName('BACKORDERRATIO').AsFloat;
  end
  else begin
    FFCRatio := FConfigFCRatio;
  end;

  if not DataSet.FieldbyName('BOMBACKORDERRATIO').IsNull then begin
    FBOMRatio := DataSet.FieldbyName('BOMBACKORDERRATIO').AsFloat;
  end
  else begin
    FBOMRatio := FConfigBOMRatio;
  end;

  if not DataSet.FieldbyName('DRPBACKORDERRATIO').IsNull then begin
    FDRPRatio := DataSet.FieldbyName('DRPBACKORDERRATIO').AsFloat;
  end
  else begin
    FDRPRatio := FConfigDRPRatio;
  end;

  CalcIdealArrival := SetCalcIdealArrival;
  UseStockBuild := False;  //change to TRUE , if a stock build exists
  if ((DataSet.FieldByName('STOCK_BUILDNO').AsInteger > 0) and not ModelWithoutStockBuild) then begin
    UseStockBuild := True;
    GetStockBuild(DataSet.FieldByName('STOCK_BUILDNO').AsInteger);
    BuildStartDate := qryStockBuild.FieldByName('START_BUILD').AsDateTime;
    ShutdownStart := qryStockBuild.FieldByName('START_SHUTDOWN').AsDateTime;
    ShutdownEnd := qryStockBuild.FieldByName('END_SHUTDOWN').AsDateTime;
    OrdersDuringShutdown := (qryStockBuildORDERS_DURING_SHUTDOWN.asstring = 'Y');
  end
  else begin
    BuildStartDate := 0;
    ShutdownStart := 0;
    ShutdownEnd := 0;
    FParams.EffShutdownStart := 0;
    FParams.EffShutdownEnd := 0;
  end;
  FParams.ForceSimulation := ftsNone;
end;

function TFwdPlanDLLDataModule.GetNumDaysOrder(ANumDays: Integer): Double;
var
  i : Integer;
  vRecOrder : Double;
begin
  vRecOrder := 0.0;
  for i := 0 to ANumDays - 1 do
    vRecOrder := vRecOrder + FFP.Dat[i].Order;
  Result := vRecOrder;
end;

end.
