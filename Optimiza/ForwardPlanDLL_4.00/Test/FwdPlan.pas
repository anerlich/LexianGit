unit FwdPlan;

interface

const
  MAX_DAYS_ARRAY_SIZE = 3500;
  MAX_PO_ARRAY_SIZE = 1000;
  MAX_CO_ARRAY_SIZE = 2500;
  MAX_WEEKS_ARRAY_SIZE = 250;
  MAX_MONTHS_ARRAY_SIZE = 52;

type
  // Input calender period dated.
  // Used as input of periods to create the calendar.
  TCalRec = record
    CalStart : TDateTime;  // Start of period
    CalEnd   : TDateTime;  // End of period
    Total    : Integer;    // This do not need to be populated. the function will use this variable internally to calculare the daily factors. (It gets populated by the function).
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
    PODate       : TDateTime;    // The date the Order will arrive or collected
    POQty        : Integer;      // The Quantity that will arrive or be collected
    POMovedQty   : Integer;      // The Quantity that will arrive or be collected
    POIdealDate  : TDateTime;    // The ideal arrival date
    PONo         : Integer;      // The PO record number on the database - can be used for updates
    POExpedited  : PChar;        // An indicator of whether the PO has been moved
  end;
  TPOArr = array[0..MAX_DAYS_ARRAY_SIZE] of TPORec;
  PPOArr = ^TPOArr;

  // Forward plan calendar
  // This is the calendar that is created.
  // (The data is splitted out into a seperat array to allow easy clearing of all data fields)
  TFPCalRec = record
    Date   : TDateTime;    // The calendar date
    CalNo  : Integer;      // The period number
    WeekNo : Integer;      // The week number
    DVal   : Integer;      // Relative trade for the day
    Fact   : Double;       // Daily trade factor (calculated using Total DVal for the period)
  end;
  TFPCalArr = array[0..10000] of TFPCalRec;
  PFPCalArr = ^TFPCalArr;


  // Forward plan data array.
  // This array go hand in hand with TFPCalArr. It hold the respective data for every day
  // in the daily calendar.
  TFPDatRec = record
    FCIn      : Double;       // The Input Forecast on a daily bases
    FCNew     : Double;       // Forecast left after CO override


    COOverride     : Integer;       // If CO does not override FC this variable is zero else = CO
    CO        : Integer;      // The Input Customer orders
    DRP       : Integer;      // The Input DRP demand
    BOM       : Integer;      // The Input BOM demand
    FC        : Integer;      // The new forecast converted into a integer stream (Display this as forecast).
    FCOverride     : Integer;       // If CO overrides FC this variable is zero else = FC
    Tot       : Integer;      // the total forecast for the day
    BuildTot  : Integer;      // the total build forecast for the day

    SS        : Integer;      // The Safety stock level on this day
    SSRC      : Integer;      // The Safety stock and Replenishment cycle on the day
    RC        : Integer;      // the Replenichment cycle on the day
    Open      : Integer;      // Opening stock on the day
    Close     : Integer;      // Closing stock on the day
    Order     : Integer;      // The quantity we recoment you order on this day
    Receive   : Integer;     // THe quantity that should be received on this day for a prefiously recomended order
    Excess    : Integer;      // quantity of excess stock for the day
    BO        : Integer;      // Back orders for the day
    Lost      : Integer;      // Lost sales for the day
    FWDPO     : Integer;      // Quantity of orders expected to come in soon
    PO        : Integer;      // Purshase orders expected to be reseived today.
    Model     : Integer;      // The model stock for the day

    Firm      : Integer;      // Total Firm demand for the day.
    FirmRP    : Integer;      // the firm demand in the review period for the day
    UseFC     : Boolean;      // ???

    Min       : Integer;      // Represent the Min level for the day (SS or Bin)
    Max       : Integer;      // Represent the max level for the day

    Bin       : Integer;      // THe Bin Level for the day for this item
    EffBin    : Integer;      //
    FirmLT    : Integer;      // Firm demand in the lead time

    NewSS     : integer;      // ???

    // Shutdown period levels before changes
    ShutdownSS   : Integer;      // The Safety stock level on this day in the shutdown period
    ShutdownSSRC   : Integer;    // The SSRC level on this day in the shutdown period
    ShutdownMax  : Integer;      // Represent the max level for the day
  end;
  TFPDatArr = array[0..10000] of TFPDatRec;
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

// THis constants is to assist when you want to pass an enpty  list to for example
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
  TNonStockedModel = (nmZero, nmLeadTime, nmHalfRP);

  // This structure hold all the input parameters used by the forward plan functions
  // Not all parameters is used by all the functions. so to help show what need to be
  // set before a call is made I added a grid in comments next to each field.
  // The Grid headings is as follow.
  // A = MakeCal
  // B = LoadDemand
  // C = COOverride
  // D = FPProject
  // Currently load demand do not require many parameters. but it may be that
  // we want to allow it to calculate overdue PO's and CO's while loading the data lateron
  TFPParams = record                 // A B C D -=- CNo -=- Description
    // System Based
    // Only needed to set once
    StockDate     : TDateTime;       //   A     -=- 104 -=- The Stock download date.
    FactIdx       : Integer;         //   A     -=-     -=- Where in the tradeing days array to start the calendar from (Use StockDownloadDate Day of week but may differ if the array do not represent a week)
    AvrFCPeriod   : Integer;         //   B     -=- 193 -=- Periods to use to determin average forecast
    NoPeriodsFC   : Integer;         //   B     -=- 101 -=- How many periods to forecast
    NoDaysInPeriod : Integer;        //   D     -=- 102 -=- How many days in a period
    CurrFCUsage   : TCurrFCUsage;    //   B     -=- 191 -=- What to do with the forecast of the first period
    FirstRatio    : Double;          //   B     -=-     -=- First Period Ratio (Use GetMonthFactor)
    MinimumDays   : Integer;         //   D     -=- 318 -=- The minimum number of days after stock download where ideal orders may arrive

    // This two may or may not be used see concerns
    OverCOIs      : TOverCOIs;       //     C   -=- 152 -=- How is CO's imported
    OverFromSDD   : Boolean;         //     C   -=- 153 -=- What date must be used for ignoring of CO's

    COUsage              : TCOUsage;        //     C   -=- 198 -=- How must the CO's be Used
    COOverride           : TCOOverride;     //     C   -=- 199 -=- How to Override CO's
    COMethod             : TCOOverride;     //     C   -=-     -=- What override to do (Use the above two parameters to determine what override to do) See Consirns
    UseMOQ               : Boolean;         //       D -=- 184 -=- Must MOQ be Used.
    UseMult              : Boolean;         //       D -=- 186 -=- Must Order multiples be used.
    UseMin               : Boolean;         //       D -=- 186 -=- Must minimum stock be used.
    ZeroNegStock         : Boolean;         //       D -=- 190 -=- Must Negative Stock be Zero on First Day.
    UseFirmInSS          : Boolean;         //       D -=- 196 -=- Is CO, BOM and DRP included in SS.
    FWDPODays            : Integer;         //       D -=- 188 -=- How many days to look forward for PO's.
    UseBOM               : Boolean;         //       D -=- 203 -=- Must Boms be Used
    UseDRP               : Boolean;         //       D -=- 206 -=- Must DRP be Used
    ExitQuick            : Boolean;         //       D -=-     -=- Must we exit the Procedure Quickly (Only to Calculate RecOrder, Topup amd Ideal used when we run in RecomenderOrderMP.exe)
    RoundMOQ             : TRound;          //       D -=- 185 -=- How to Round MOQ if used
    RoundMult            : TRound;          //       D -=- 187 -=- how to Round Order multiples if used
    ExcessAboveRC        : Boolean;         //       D -=- 195 -=- Is Excess above RC (Y)or MOQ (N)
    OrderMethod          : TOrderMethod;    //       D -=- 189 -=- How to calculate orders
    NewSSCalc            : boolean;         //       New SS calc?
    UseFixedLevels       : boolean;         //       D Use fixed SS & SSRC levels instead of calculating them from FC
    ExpeditePO           : boolean;         //       D Calculate the expedite & de-expedite dates on purchase orders
    TypeOfSimulation     : TTypeOfSimulation; //     D 188 - Type of simulation
    FixedHorizon         : integer;        //        D 328 - Fixed horizon - used for a Fixed type of simulation
    UseStockBuild        : boolean;         //       Take the stock n=builds into account
    NonStockedModel      : TNonStockedModel; //      D -=- 271 -=- Non stocked model calc method
    RedistributableStockLevel : Integer;      // 281

    // Location-specific parameters for expediting & de-expediting
    PercentageLT         : Double;   //       D 319 - % of LT above transit LT to use as minimum
    MinDaysLT            : integer;  //       D 320 - Minimum number of days to add to the transit lead time
    PercentageRecChanges : Double;   //       D 321 - Only recommend changes to dates greater than X percent
    MinDaysRecChanges    : integer;  //       D 322 - Minimum number of days for items with short lead times and to prevent daily changes being  recommended

    // these are actually item based
    // because they may have overrides
    FCRAtio          : Double;          //       D -=- 194 -=- BO Ratio fo FC (May have a line item override)
    DRPRatio         : Double;          //       D -=-     -=- BO Ratio for DRP
    BOMRatio         : Double;          //       D -=-     -=- BO Ratio fo BOM
    CORatio          : Double;          //       D -=-     -=- BO Ratio for CO's

    // Item Based
    ItemNo           : Integer;
    SalesToDate      : Double;         //   B     -=-     -=- Self explanatory (Use SalesAmount_0)
    OverPO           : Integer;         //       D -=-     -=- Overdue Purchase Orders (Calculated while loading Purchase Order Info) (This may potentially be an output of B and then an input to D)
    Stocked          : Boolean;         //       D -=-     -=- Is this a stocked item
    Pareto           : Char;            //       D -=-     -=- The Pareto Category
    SSDays           : Integer;         //       D -=-     -=- Days for Safety stock
    RCDays           : Integer;         //       D -=-     -=- Days to order for
    FixedSS          : Integer;         //       The fixed level safety stock
    FixedSSRC        : Integer;         //       The fixed level safety stock and replenishment cycle
    RPDays           : Integer;         //       D -=-     -=- Days before Look to order again
    LTDays           : Integer;         //       D -=-     -=- Leadtime in days
    TransitLTDays    : Integer;         //       D -=-     -=- Transit lead time in days
    SOH              : Integer;         //       D -=-     -=- Current Stock on hand
    BO               : Integer;         //       D -=-     -=- Current Back orders
    CBO              : Integer;         //       D -=-     -=- Consolidated Branch orders
    Bin              : Integer;         //       D -=-     -=- The Bin level of the Item
    MOQ              : Integer;         //       D -=-     -=- Minimum order quantity
    MOQDays          : Integer;         //       D -=-     -=- Minimum order quantity in days
    Mult             : Integer;         //       D -=-     -=- Order multipls
    Min              : Integer;         //       D -=-     -=- Minimum stock
    CalcIdealArrival : boolean;         //       D -=-     -=- Calculate idela arrival date
    BuildStartDate   : TDateTime;       //       D -=-     -=- The stock build start date.
    ShutdownStart    : TDateTime;       //       D -=-     -=- The stock build shutdown period start date.
    ShutdownEnd      : TDateTime;       //       D -=-     -=- The stock build shutdown period end date.
    EffShutdownStart : TDateTime;       //       D -=-     -=- The stock build shutdown period start date.
    EffShutdownEnd   : TDateTime;       //       D -=-     -=- The stock build shutdown period end date.
    OrdersDuringShutdown  : boolean;
    StockOnOrder          : Integer;         //        Stock on order
    StockOnOrderOther     : Integer;         //        Stock on order (other)
    StockOnOrderInLT      : Integer;         //        Stock on order in LT
    StockOnOrderInLTOther : Integer;         //        Stock on order in LT (other)
    SSLTDays              : Integer;         //        Days for Safety stock + Lead time
    SSRCDays              : Integer;         //        Days for Safety stock + Replenishment cycle
    SSHalfRCDays          : Integer;         //        Days for Safety stock + half replenishment cycle
    SSRPDays              : Integer;         //        Days for Safety stock + Review period
    SSLTRPDays            : Integer;         //        Days for Safety stock + Lead time + Review period
    SSLTRCDays            : Integer;         //        Days for Safety stock + Lead time + Replenishment cycle

    //Stock build calculated parameters
    BuildStartDay,
    EffShutdownStartDay,
    EffShutdownEndDay,
    ShutdownStartDay,
    ShutdownEndDay,
    BuildTotal   : Integer;

    // Item Based Output parameters
    NowOrder      : Integer;         //         -=-     -=- The Recommended Order
    NowTopup      : Integer;         //         -=-     -=- The Order it want to topup even if we do not need to order now
    NowIdeal      : Integer;         //         -=-     -=- The recommended order without MOQ and multiples.
    IdealArrivalDate: TDateTime;       //         -=-     -=- The ideal order date
    ForwardSS,
    ForwardLT,
    ForwardSSLT,
    ForwardLTSSRC,
    ForwardSSRC,
    ForwardSSRP,
    ForwardSSHalfRC,
    ForwardLTSSRP,
    ForwardSONHBackOrder,
    ForwardSONHBackorderSONO,
    ForwardSONHBackorderSONOInLT,
    PeriodsOnOrder,
    FirmLTSSRC,
    RemainingFC,
    AverageFC,
    PeriodsOnHand,
    LostSales   : double;
    BuildQty,
    RedistributableExcess : integer;

    // This is not realy needed
    // as parameters they can be
    // local veriables in the functions
    // I just do not want to loos
    // sight of them for now 
    Level     : Integer;
    CurCalNo  : Integer;
    PStart    : TDateTime;
    PEnd      : TDateTime;
  end;

const
  ErrCalOK                   = 0;  // Not Realy an error (Everything is OK ) }
  ErrCalStartBeforeEnd       = -1; // The Start date is larger that the end date for a period
  ErrCalGapBetweenPeriods    = -2; // There is a gap between the end of one period and the start of the next
  ErrCalStockDateOutofbounds = -3; // The Stock date is not in the first period
  ErrCalNoCalendarSpecified  = -4; // No Calendar specified to create a day calendar from
  ErrStockBuildDatesInvalid  = -5; // No Calendar specified to create a day calendar from

{$ifndef FwdPlanDll}

// This function create the daily calendar for the forward plan. this only need
// to happen once. because it is build based on system parameters.
// This must be the first function called before you start projecting item data.
function MakeCal(
  var FP      : TFPStruc;    // The memory space for the array must be pre allocated even though it is passed as var.
  Cal         : TCalStruc;   // The input dates
  Fact        : TIntStruc;   // The input tradeing days
  var Params  : TFPParams    // See the input param structure for detail
) : Integer; stdCall;


// This function load all the data streams at once. this basically load the item
// level data into the structure. if for instance you do not want to load PO values
// You can pass an empty structure as that parameter. (See Constants at top of file.)
function LoadDemand(
  FP         : TFPStruc;     // The Forward plan (This do not need to be var since we have the arrays as pointers)
  FC         : TFltStruc;    // Local forecast
  CO         : TDemStruc;    // customer orders
  BOM        : TDemStruc;    // Bill of material demand
  DRP        : TDemStruc;    // Central wharehouse demand
  PO         : TPOStruc;    // Existing purchase orders
  var Params : TFPParams     // See the input param structure for detail
) : Integer; stdCall;

// this function does the actual projection for the item
function FPProject(
  FP : TFPStruc;
  PO : TPOStruc;
  var Params : TFPParams
) : Integer; stdCall;

function GetDLLVersion : PChar;  stdcall; 

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

function MakeCal(var FP : TFPStruc; Cal : TCalStruc; Fact : TIntStruc; var Params  : TFPParams) : Integer; stdCall; external 'FwdPlanDLL.DLL';

function LoadDemand(
  FP         : TFPStruc;
  FC         : TFltStruc;
  CO         : TDemStruc;
  BOM        : TDemStruc;
  DRP        : TDemStruc;
  PO         : TPOStruc;
  var Params : TFPParams
) : Integer; stdCall; external 'FwdPlanDll.dll';

function FPProject(
  FP : TFPStruc;
  PO : TPOStruc;
  var Params : TFPParams
) : Integer; stdCall; external 'FwdPlanDll.dll';

function GetDLLVersion : PChar;  stdcall; external 'FwdPlanDll.dll';

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
