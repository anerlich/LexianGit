unit FwdPlan;

interface

const
  MAX_DAYS_ARRAY_SIZE = 3500;
  MAX_PO_ARRAY_SIZE = 20000;
  MAX_CO_ARRAY_SIZE = 20000;
  MAX_WEEKS_ARRAY_SIZE = 500;
  MAX_MONTHS_ARRAY_SIZE = 117;
  MAX_CAL_ARRAY_SIZE = 10000;
  MAX_BUILDRECEIPT_ARRAY_SIZE = 1000;


type
  // Input calender period dated.
  // Used as input of periods to create the calendar.
  TCalRec = record
    CalStart : TDateTime;  // Start of period
    CalEnd   : TDateTime;  // End of period
    NoDaysInPeriod : integer;
    StartDayNo : Integer;
    EndDayNo : integer;
  end;
  TCalArr = array[0..MAX_DAYS_ARRAY_SIZE] of TCalRec;
  PCalArr = ^TCalArr;


  // Array of integer values.
  // Used as input of running sequence of trading days to create the calendar.
  TIntArr = array[0..MAX_DAYS_ARRAY_SIZE] of Integer;
  PIntArr = ^TIntArr;


  // array of float falues.
  // This is used for input of period bases data like the local forecast.
  TFltArr = array[0..MAX_DAYS_ARRAY_SIZE] of Double;
  PFltArr = ^TFltArr;


  // Demand array with demand on a specific date.
  // This can be used for input of firm demand on specific dates or to read out
  // a stream of projected orders for example.
  TDemRec = record
    DemDate      : TDateTime;    // The date the Order will arrive or collected
    DemQty       : Integer;      // The Quantity that will arrive or be collected
  end;
  TDemArr = array[0..MAX_DAYS_ARRAY_SIZE] of TDemRec;
  PDemArr = ^TDemArr;

  // PO array with POs on a specific date.
  // This can be used for input of firm demand on specific dates or to read out
  // a stream of projected orders for example.
  TPORec = record
    PODate       : TDateTime;    // The date the Order will arrive or be collected
    POQty        : Integer;      // The Quantity that will arrive or be collected
    POMovedQty   : Integer;      // The Quantity that will arrive or be collected
    POIdealDate  : TDateTime;    // The ideal arrival date
    PONo         : Integer;      // The PO record number on the database
    POExpedited  : Char;         // An indicator of whether the PO has been moved FU
    POIndicator  : Char;         // An indicator of the type of PO
    ExcludeFromSurplus : Boolean;// true if the PO must not be used for surplus calculation and false if it must be used for surplus order calculation
  end;
  TPOArr = array[0..MAX_PO_ARRAY_SIZE] of TPORec;
  PPOArr = ^TPOArr;

  // Forward plan calendar
  // This is the calendar that is created.
  // (The data is splitted out into a seperat array to allow easy clearing of all data fields)
  TFPCalRec = record
    Date   : TDateTime;    // The calendar date                                  //PJK not required
    CalNo  : Integer;      // The period number
    WeekNo : Integer;      // The week number
    DVal   : Integer;      // Relative trade for the day
    Fact   : Double;       // trade factor for the day ( DVal / TotDVal )
  end;
  TFPCalArr = array[0..MAX_CAL_ARRAY_SIZE] of TFPCalRec;
  PFPCalArr = ^TFPCalArr;

  TBuildReceiptRec = record
    ReceiptDay      : Integer;    // The date the Order will arrive or collected
    ReceiptAmt        : Integer;      // The Quantity that will arrive or be collected
  end;
  TBuildReceiptArr = array[0..MAX_BUILDRECEIPT_ARRAY_SIZE] of TBuildReceiptRec;
  PBuildReceiptArr = ^TDemArr;

  
  // Forward plan data array.
  // This array go hand in hand with TFPCalArr. It hold the respective data for
  // every day in the daily calendar.
  TFPDatRec = record
    FCIn       : Double;       //     The Input Forecast on a daily bases
    BOMIn      : Double;
    DRPIn      : Double;
    CO         : integer;      //    The Input Customer orders
    DRP        : integer;      //    The Input DRP demand
    BOM        : integer;      //    The Input BOM demand
    FC         : integer;      //   The forecast as an integer stream

    //PK
    // This Two fields contain the values for FC and CO
    // After FCOverride is applied.
    // They are needed because the original values must be
    // displayde while this is used for calculation. This
    // will cause confusion with the clients.
    FCOverride : Integer;      // FC overrided with CO
    COOverride : Integer;      // CO Overrided with FC

    Tot        : integer;      // The total forecast for the day
    BuildTot   : Integer;      // the total build forecast for the day
    SS         : Integer;      // The Safety stock level on this day
    SSRC       : Integer;      // The Safety stock and Replenishment cycle on the day
    RC         : Integer;      // the Replenichment cycle on the day
    Open       : Integer;      // Opening stock on the day
    Close      : Integer;      // Closing stock on the day
    Order      : Integer;      // The quantity we recoment you order on this day
    Receive    : Integer;      // The quantity that should be received on this day for a prefiously recomended order
    Excess     : Integer;      // quantity of excess stock for the day
    BO         : Integer;      // Back orders for the day
    Lost       : Integer;      // Lost sales for the day
    FWDPO      : Integer;      // Quantity of orders expected to come in soon
    PO         : Integer;      // Purshase orders expected to be reseived today.
    Model      : Integer;      // The model stock for the day

    Firm       : Integer;      // Total Firm demand for the day.
    FirmRP     : Integer;      // the firm demand in the review period for the day
    UseFC      : Boolean;      // ???
    Min        : Integer;      // Represent the Min level for the day (SS or Bin)
    Max        : Integer;      // Represent the max level for the day
    MaxNextDay : Integer;       //Work out SS+RC from next day - Current max is from today
                               //MaxNextDay is needed for Excess calculation
    Bin        : Integer;      // THe Bin Level for the day for this item
    EffBin     : Integer;      //
    FirmLT     : Integer;      // Firm demand in the lead time
    NextSSPoint    : integer;
    NextRCPoint    : integer;
    OrigRCPoint    : integer;
    NextRPPoint    : integer;
    PrevLTPoint    : integer;
    FirmDemandExists : boolean;
  end;
  TFPDatArr = array[0..MAX_CAL_ARRAY_SIZE] of TFPDatRec;
  PFPDatArr = ^TFPDatArr;


  // The following structures is declared to make the use of the pointer arrays easyer when passing them
  // to the functions in the DLL
  TCalStruc = record
    Max : Integer;
    Cnt : Integer;
    Arr : PCalArr;
  end;

  TIntStruc = record
    Max : Integer;
    Cnt : Integer;
    Arr : PIntArr;
  end;

  TFltStruc = record
    Max : Integer;
    Cnt : Integer;
    Arr : PFltArr;
  end;

  TDemStruc = record
    Max : Integer;
    Cnt : Integer;
    Arr : PDemArr;
  end;

  TPOStruc = record
    Max : Integer;
    Cnt : Integer;
    Arr : PPOArr;
  end;

  TFPStruc = record
    Max : Integer;
    Cnt : Integer;
    Cal : PFPCalArr;
    Dat : PFPDatArr;
  end;

// This constants is to assist when you want to pass an enpty  list to for example
// the Load data procedure. Most of them might not be required at all
const
  EmptyCalStruc : TCalStruc = (
    Max : 0;
    Cnt : 0;
    Arr : nil;
  );
  EmptyIntStruc : TIntStruc = (
    Max : 0;
    Cnt : 0;
    Arr : nil;
  );
  EmptyFltStruc : TFltStruc = (
    Max : 0;
    Cnt : 0;
    Arr : nil;
  );
  EmptyDemStruc : TDemStruc = (
    Max : 0;
    Cnt : 0;
    Arr : nil;
  );
  EmptyPOStruc : TPOStruc = (
    Max : 0;
    Cnt : 0;
    Arr : nil;
  );

  EmptyFPStruc : TFPStruc = (
    Max : 0;
    Cnt : 0;
    Cal : nil;
    Dat : nil;
  );

// NOTE: Set types is not complicated structured types. and may be used with
// DLL's, they are basically treated as normal integer values with predefined constants.
type
  TRound       = (RoundUp, RoundDown, RoundNear);
  TOrderMethod = (omReOrderPoint, omTopup, omAuto);
  TCurrFCUsage = (fcUseProrate, fcUseSalesToDate, fcUseFull);
  TCOUsage     = (coUseIgnore, coUseAdd, coUseOverride);
  TCOOverride  = (coNone, coDay, coWeek, coPeriod);
  TOverCOIs    = (ociBackOrdered, ociInFirst, ociIgnored);
  TTypeOfSimulation = (tsCurrent, tsProjection, tsIdeal, tsFixed);
  TForcepeofSimulation = (ftsNone, ftsCurrent, ftsProjection, ftsIdeal, ftsFixed);
  TNonStockedModel = (nmZero, nmLeadTime, nmHalfRP);
  TPolicyType = (ptSS, ptRC, ptRP, ptLT);

  // This structure hold all the input parameters used by the forward plan
  // functions. Not all parameters is used by all the functions. so to help
  // show what need to be set before a call is made I added a grid in comments
  // next to each field. The Grid headings is as follow.
  // A = MakeCal
  // B = LoadDemand
  // C = COOverride
  // D = FPProject
  // Currently load demand do not require many parameters. but it may be that
  // we want to allow it to calculate overdue PO's and CO's while loading the
  // data later on.
  TFPParams = record                  // A B C D -=- CNo -=- Description
    // System Based
    // Only needed to set once
    StockDate            : TDateTime;       // A       -=- 104 -=- The Stock download date.
    AvrFCPeriod          : Integer;         //   B     -=- 193 -=- Periods to use to determin average forecast
    NoPeriodsFC          : Integer;         //   B     -=- 101 -=- How many periods to forecast - Can be extended by config(388)
    OriginalPeriodsFC    : integer;         //         -=- 101 -=- How many periods to forecast - Original FC
    CurrFCUsage          : TCurrFCUsage;    //   B     -=- 191 -=- What to do with the forecast of the first period
    FirstRatio           : Double;          //   B     -=-     -=- First Period Ratio (Use GetMonthFactor)
    OverCOIs             : TOverCOIs;       //     C   -=- 152 -=- How is CO's imported
    OverFromSDD          : Boolean;         //     C   -=- 153 -=- What date must be used for ignoring of CO's
    COUsage              : TCOUsage;        //   B C   -=- 198 -=- How must the CO's be Used
    COOverride           : TCOOverride;     //     C   -=- 199 -=- How to Override CO's
    UseMOQ               : Boolean;         //       D -=- 184 -=- Must MOQ be Used.
    UseMult              : Boolean;         //       D -=- 186 -=- Must Order multiples be used.
    UseMin               : Boolean;         //       D -=- 186 -=- Must minimum stock be used.

    // Used Only in DM
    ZeroNegStock         : Boolean;         //       D -=- 190 -=- Must Negative Stock be Zero on First Day.

    UseFirmInSS          : Boolean;         //       D -=- 196 -=- Is BOM and DRP included in SS.
    FWDPOPercentage      : Double;          //       Percentage set to use in Orders outside leadtime (ReadConfigFloat(188)
    FWDPODays            : Integer;         //       D -=- 188 -=- How many days to look forward for PO's.
    FWDCOPercentage      : double;          //             385     Customer order outside LT % for M Item ordering
    FWDCODays            : integer;         //                     Days to look forward after LT for Customer orders
    ExitQuick            : Boolean;         //       D -=-     -=- Must we exit the Procedure Quickly (Only to Calculate RecOrder, Topup amd Ideal used when we run in RecomenderOrderMP.exe)
    RoundMOQ             : TRound;          //       D -=- 185 -=- How to Round MOQ if used
    RoundMult            : TRound;          //       D -=- 187 -=- how to Round Order multiples if used
    ExcessAboveRC        : Boolean;         //       D -=- 195 -=- Is Excess above RC (Y)or MOQ (N)
    CORatio              : Double;          //       D -=-     -=- BO Ratio for CO's
    FCRatio              : Double;          //       D -=- 194 -=- BO Ratio fo FC (May have a line item override)
    DRPRatio             : Double;          //       D -=-     -=- BO Ratio for DRP
    BOMRatio             : Double;          //       D -=-     -=- BO Ratio fo BOM
    UseFixedLevels       : boolean;         //       D Use fixed SS & SSRC levels instead of calculating them from FC
    MinimumDays          : Integer;         //       D -=- 318 -=- The minimum number of days after stock download where ideal orders may arrive
    PercentageLT         : Double;   //       D 319 - % of LT above transit LT to use as minimum
    MinDaysLT            : integer;  //       D 320 - Minimum number of days to add to the transit lead time
    PercentageRecChanges : Double;   //       D 321 - Only recommend changes to dates greater than X percent
    MinDaysRecChanges    : integer;  //       D 322 - Minimum number of days for items with short lead times and to prevent daily changes being  recommended
    ExpeditePO           : boolean;         //       D Calculate the expedite & de-expedite dates on purchase orders
    TypeOfSimulation     : TTypeOfSimulation;
    ForceSimulation      : TForcepeofSimulation;//     D 188 - Type of simulation
    NonStockedModel      : TNonStockedModel; //      D -=- 271 -=- Non stocked model calc method
    FixedHorizon         : integer;        //        D 328 - Fixed horizon - used for a Fixed type of simulation
    ExcludePseudoFwdPO   : boolean;        //        D 335 - Exclude pseudo POs from FwdPO calc

    //PJK This is overritten it Auto in the DM
    OrderMethod          : TOrderMethod;    //       D -=- 189 -=- How to calculate orders

    // Item Bases Paramaters
    ItemNo           : Integer;
    SalesToDate      : Double;         //   B     -=-     -=- Self explanatory (Use SalesAmount_0)
    Stocked          : Boolean;         //       D -=-     -=- Is this a stocked item
    Pareto           : Char;            //       D -=-     -=- The Pareto Category
    SS               : Double;         //       D -=-     -=- Periods of Safety stock
    RC               : Double;         //       D -=-     -=- Periods of RC
    RP               : Double;         //       D -=-     -=- Periods of RP
    LT               : Double;         //       D -=-     -=- Periods of LT
    SSDays           : Integer;         //       D -=-     -=- Days for Safety stock
    RCDays           : Integer;         //       D -=-     -=- Days to order for
    RPDays           : Integer;         //       D -=-     -=- Days before Look to order again
    LTDays           : Integer;         //       D -=-     -=- Leadtime in days
    TransitLTDays    : Integer;         //       D -=-     -=- Transit lead time in days
    SOH              : Integer;         //       D -=-     -=- Current Stock on hand
    BO               : Integer;         //       D -=-     -=- Current Back orders
    CBO              : Integer;         //       D -=-     -=- Consolidated Branch orders
    Bin              : Integer;         //       D -=-     -=- The Bin level of the Item
    MOQ              : Integer;         //       D -=-     -=- Minimum order quantity
    Mult             : Integer;         //       D -=-     -=- Order multipls
    FixedSS          : Integer;         //       The fixed level safety stock
    FixedSSRC        : Integer;         //       The fixed level safety stock and replenishment cycle
    CalcIdealArrival : boolean;         //       D -=-     -=- Calculate idela arrival date
    UseStockBuild    : boolean;         //       Take the stock n=builds into account
    BuildStartDate   : TDateTime;       //       D -=-     -=- The stock build start date.
    ShutdownStart    : TDateTime;       //       D -=-     -=- The stock build shutdown period start date.
    ShutdownEnd      : TDateTime;       //       D -=-     -=- The stock build shutdown period end date.
    EffShutdownStart : TDateTime;       //       D -=-     -=- The stock build shutdown period start date.
    EffShutdownEnd   : TDateTime;       //       D -=-     -=- The stock build shutdown period end date.
    AllowCatchup          : Boolean;
    ProvideShortfall : Boolean;
    OrdersInShutdown : boolean;
    ForwardSSLT_SSPortion : integer;    // Keep a running count of the SS portion for fwdSSLT - MinStock
    ForwardLTSSRC_SSPortion : integer;  // Keep a running count of the SS portion for fwdLTSSRC - MinStock
    ForwardSSRC_SSPortion : integer;
    ForwardSSHALFRC_SSPortion : integer;
    ForwardSSHALFRC_PLAIN_SSPortion : integer;


    // Output Paramaters
    IdealArrivalDate: TDateTime;      // -=-     -=- The ideal order date
    NowTopup      : Integer;          // -=-     -=- The Order it want to topup even if we do not need to order now
    NowIdeal      : Integer;          // -=-     -=- The recommended order without MOQ and multiples.
    NowOrder      : Integer;          // -=-     -=- The Recommended Order
    AverageFC,                        // -=-     -=- Avergae forecasts based on the no of average periods in system parameters
    AverageBOM,
    AverageDRP    : Double;
    BuildQty      : integer;
    MOQDays       : Integer;          // D -=-     -=- Minimum order quantity in days
    EffRCDays     : Integer;          //       D -=-     -=- Effective replenishment cycle  in days
    EffectiveRC   : Double;           //       D -=-     -=- Effective replenishment cycle in periods
    COInLT        : integer;

    //Internal Usage
    BuildStartDay: Integer;
    EffShutdownStartDay: Integer;
    EffShutdownEndDay: Integer;
    ShutdownStartDay: Integer;
    ShutdownEndDay: Integer;
    Level     : Integer;
    OrdersInBuild : Integer;
    TempBuildQty  : Integer;
    OutRes : Integer;
    BuildTotal   : Integer;
    LastFirmDay : Integer;
    AvgLocalFC  : Double;

    SSLTDays                  : Integer;       // Days for Safety stock + Lead time
    SSRCDays                  : Integer;       // Days for Safety stock + Replenishment cycle
    SSRPDays                  : Integer;       // Days for Safety stock + Review period
    SSHalfRCDays              : Integer;       // Days for Safety stock + half replenishment cycle
    SSLTRCDays                : Integer;       // Days for Safety stock + Lead time + Replenishment cycle
    SSLTRPDays                : Integer;       // Days for Safety stock + Lead time + Review period
    StockOnOrder              : Integer;       // Stock on order
    StockOnOrderOther         : Integer;       // Stock on order (other)
    StockOnOrderInLT          : Integer;       // Stock on order in LT
    StockOnOrderInLTOther     : Integer;       // Stock on order in LT (other)
    NoDaysInPeriod            : Integer;       // D -=- 102 -=- How many days in a period
    RedistributableStockLevel : Integer;       // 281
    Min                       : Integer;       // D -=-     -=- Minimum stock
    // PY ToDo where must the initialization happen?
    EffectiveLTDay            : Integer;
    OverduePOIncluded         : Integer;
    OverduePOExcluded         : Integer;
    CalcSurplusOrders         : Boolean;
    SurplusOrders             : Double;
    SurplusOrdersOutsideLT    : boolean;       // 304 - determines wheter to include all PO or just PO in the LT as surplus
    WeekStartDay              : Integer;       // 334 The start day of the week 1 = Sunday - 7 = Saturday

    PeriodsOnHand                : Double;
    ForwardSONHBackOrder         : double;
    ForwardSONHBackorderSONO     : double;
    ForwardSONHBackorderSONOInLT : double;
    PeriodsOnOrder               : double;
    LostSales                    : double;

    RemainingFC                  : Integer;
    ForwardSS                    : Integer;
    ForwardLT                    : Integer;
    ForwardSSLT                  : Integer;
    ForwardSSRC                  : integer;
    ForwardSSRP                  : integer;
    ForwardSSHalfRC              : integer;
    ForwardSSHalfRCPlain         : integer;
    ForwardLTSSRP                : integer;
    ForwardLTSSRC                : integer;
    ForwardLTSSRCPlain           : integer;
    FirmLTSSRC                   : integer;
    RedistributableExcess        : integer;

  end;

  //This record is to hold the values used in FPLoopDays
  //FPLoopDays is called more than once and needs to keep track
  //of these accumulated values to start at the correct value
  TFPSaveLoopVals = record
    // System Based
    // Only needed to set once
    StockOnOrder            : Integer;
    OnHandbackorders        : Integer;
    SONHBackOSONO           : Integer;
    SONHBackOSONOInLT       : Integer;
    PeriodsOnHand           : Integer;
    BaseLevel               : Integer;
    BO_Rest                 : double;
    LS_Rest                 : double;
  end;

const
  ErrCalOK                   = 0;  // Not Realy an error (Everything is OK ) }
  ErrCalStartBeforeEnd       = -1; // The Start date is larger that the end date for a period
  ErrCalGapBetweenPeriods    = -2; // There is a gap between the end of one period and the start of the next
  ErrCalStockDateOutofbounds = -3; // The Stock date is not in the first period
  ErrCalNoCalendarSpecified  = -4; // No Calendar specified to create a day calendar from
  ErrStockBuildDatesInvalid  = -5; // No Calendar specified to create a day calendar from
  ErrUnknownError            = -10;

{$ifndef FwdPlanDll}

// Return the DLL version as a short string. ShortString types is allowed in
// DLL interface functions without the need to use borland memory dll's
function GetDLLVersion : ShortString;  stdcall; external 'FwdPlanDLL.DLL'; 


// This function create the daily calendar for the forward plan. this only need
// to happen once. because it is build based on system parameters.
// The calendar must be created before you call LoadDemand or Project.
// The memory space for the array must be pre allocated even though it is
// passed as var.
function MakeCal(
  var FP      : TFPStruc;    // FP data
  var Cal         : TCalStruc;   // Input dates for periods
  Fact        : TIntStruc;   // Input DVal values
  var Params  : TFPParams    // See the input param structure for detail
) : Integer; stdCall; external 'FwdPlanDLL.DLL';


// This function load all the data streams at once. this basically load the
// item level data into the structure. if for instance you do not want to
// load PO values you can pass an empty structure as that parameter.
// (See Constants at top of file.)
// THe Calendar must be created before you call this function
function LoadDemand(
  FP         : TFPStruc;     // FP Data
  FC         : TFltStruc;    // Local forecast
  CO         : TDemStruc;    // customer orders
  BOM        : TDemStruc;    // Bill of material demand
  DRP        : TDemStruc;    // Central wharehouse demand
  PO         : TPOStruc;     // Existing purchase orders
  var Params : TFPParams     // See the input param structure for detail
) : Integer; stdCall; external 'FwdPlanDLL.DLL';


// this function does the actual projection for the item
function FPProject(
  FP : TFPStruc;
  PO : TPOStruc;
  var Params : TFPParams;
  Cal : TCalStruc
) : Integer; stdCall; external 'FwdPlanDLL.DLL';

{$endif}

procedure MakeCalStruc(var Struc : TCalStruc; iCnt : Integer);
procedure MakeIntStruc(var Struc : TIntStruc; iCnt : Integer);
procedure MakeFltStruc(var Struc : TFltStruc; iCnt : Integer);
procedure MakeDemStruc(var Struc : TDemStruc; iCnt : Integer);
procedure MakePOStruc(var Struc : TPOStruc; iCnt : Integer);
procedure MakeFPStruc(var Struc : TFPStruc; iCnt : Integer);

procedure FreeCalStruc(var Struc : TCalStruc);
procedure FreeIntStruc(var Struc : TIntStruc);
procedure FreeFltStruc(var Struc : TFltStruc); 
procedure FreeDemStruc(var Struc : TDemStruc);
procedure FreePOStruc(var Struc : TPOStruc);
procedure FreeFPStruc(var Struc : TFPStruc);

implementation

procedure MakeCalStruc(var Struc : TCalStruc; iCnt : Integer);
begin
  if Struc.Max > 0 then FreeCalStruc(Struc);
  GetMem(Struc.Arr, iCnt * SizeOf(TCalRec));
  Struc.Max := iCnt;
  Struc.Cnt := 0;
end;

procedure MakeIntStruc(var Struc : TIntStruc; iCnt : Integer);
begin
  if Struc.Max > 0 then FreeIntStruc(Struc);
  GetMem(Struc.Arr, iCnt * SizeOf(Integer));
  Struc.Max := iCnt;
  Struc.Cnt := 0;
end;

procedure MakeFltStruc(var Struc : TFltStruc; iCnt : Integer);
begin
  if Struc.Max > 0 then FreeFltStruc(Struc);
  GetMem(Struc.Arr, iCnt * SizeOf(Double));
  Struc.Max := iCnt;
  Struc.Cnt := 0;
end;

procedure MakeDemStruc(var Struc : TDemStruc; iCnt : Integer);
begin
  if Struc.Max > 0 then FreeDemStruc(Struc);
  GetMem(Struc.Arr, iCnt * SizeOf(TDemRec));
  Struc.Max := iCnt;
  Struc.Cnt := 0;
end;

procedure MakePOStruc(var Struc : TPOStruc; iCnt : Integer);
begin
  if Struc.Max > 0 then FreePOStruc(Struc);
  GetMem(Struc.Arr, iCnt * SizeOf(TPORec));
  Struc.Max := iCnt;
  Struc.Cnt := 0;
end;
                     
procedure MakeFPStruc(var Struc : TFPStruc; iCnt : Integer);
begin
  if Struc.Max > 0 then FreeFPStruc(Struc);
  GetMem(Struc.Cal, iCnt * SizeOf(TFPCalRec));
  GetMem(Struc.Dat, iCnt * SizeOf(TFPDatRec));
  Struc.Max := iCnt;
  Struc.Cnt := 0;
end;

procedure FreeCalStruc(var Struc : TCalStruc);
begin
  try
    FreeMem(Struc.Arr);
  finally
    Struc.Max := 0;
    Struc.Cnt := 0;
    Struc.Arr := nil;
  end;
end;

procedure FreeIntStruc(var Struc : TIntStruc);
begin
  try
    FreeMem(Struc.Arr);
  finally
    Struc.Max := 0;
    Struc.Cnt := 0;
    Struc.Arr := nil;
  end;
end;

procedure FreeFltStruc(var Struc : TFltStruc);
begin
  try
    FreeMem(Struc.Arr);
  finally
    Struc.Max := 0;
    Struc.Cnt := 0;
    Struc.Arr := nil;
  end;
end;

procedure FreeDemStruc(var Struc : TDemStruc);
begin
  try
    FreeMem(Struc.Arr);
  finally
    Struc.Max := 0;
    Struc.Cnt := 0;
    Struc.Arr := nil;
  end;
end;

procedure FreePOStruc(var Struc : TPOStruc);
begin
  try
    FreeMem(Struc.Arr);
  finally
    Struc.Max := 0;
    Struc.Cnt := 0;
    Struc.Arr := nil;
  end;
end;

procedure FreeFPStruc(var Struc : TFPStruc);
begin
  try
    FreeMem(Struc.Cal);
  finally
    Struc.Cal := nil;
  end;
  try
    FreeMem(Struc.Dat);
  finally
    Struc.Max := 0;
    Struc.Cnt := 0;
    Struc.Dat := nil;
  end;
end;

end.

