unit DataStructures;

interface

type
  TLocationParams = record
    ExcessUses,
    UseMOQ,
    TypeOfOrdering,
    RoundMOQ,
    RoundMult,
    TypeOfSimulation,
    UseOfCustomerOrders,
    OverdueCustomerOrderDate,
    LocalMonthFactorMode,
    BOMMonthFactorMode,
    DRPMonthFactorMode,
    BOMFillMode,
    CustomerOrdersOverride,
    OverdueCustomerOrdersImport,
    UseBOM,
    UseDRP,
    UseDRPBackOrders,
    UseMult,
    TreatNegativeStockAsZero,
    ApplyBackOrderPercentToDependantForecasts,
    BackOrderAllCustomerOrders,
    IgnoreCustomerOrdersForSafetyStock,
    UseDependantForecastsForSafetyStock,
    ForceDailyReviewPeriod,
    SystemWeeks,
    ExportParams,
    ExportResults,
    ShowErrorMessage,
    UseMOQplusBinLevelForExcess : PChar;
    NoPeriodsForecast,
    MaxForwardCover,
    NumberofPeriodsInYear,
    PeriodsForAverageForecast,
    PercentUnsatisfiedOrdersBackOrdered,
    DaysInPer  : Integer;
    StockDownloadDate : TDateTime;
    AddPercToLTFence, OrderThreshold : Double
  end;
  PLocationParams = ^TLocationParams;

  TCalendarEntry = record
    CalNo : integer;
    StartDate,
    EndDate : TDateTime
  end;
  PCalendarEntry = ^TCalendarEntry;
  TCalendar = record
    NoEntries : integer;
    FirstEntry : PCalendarEntry;
  end;
  PCalendar = ^TCalendar;

  TItemParams = record
    Pareto : PChar;
    Redistro_Excess_MAX_plus,
    ConfirmationHorizon,
    StockBuildNo : integer;
    StockOnHand,
    DRPBackOrders,
    OpenBackOrders,
    SlowMovingLevel,
    SafetyStock,
    LeadTime,
    ReviewPeriod,
    ReplenishmentCycle,
    OrderMinimum,
    OrderMultiple,
    TransitLT,
    SalesToDate : Double;
    StartBuild,
    StartShutdown,
    EndShutdown : TDateTime;
    OrdersDuringShutdown : PChar;
  end;
  PItemParams = ^TItemParams;

  TPurchaseOrderEntry = record
    OrderDate,
    ExpectedArrivalDate : TDateTime;
    OrderQty : double
  end;
  PPurchaseOrderEntry = ^TPurchaseOrderEntry;
  TPurchaseOrder = record
    NoEntries : integer;
    FirstEntry : PPurchaseOrderEntry;
  end;
  PPurchaseOrder = ^TPurchaseOrder;

  TCustomerOrderEntry = record
    OrderDate,
    ExpectedDeliveryDate : TDateTime;
    OrderQty : double
  end;
  PCustomerOrderEntry = ^TCustomerOrderEntry;
  TCustomerOrder = record
    NoEntries : integer;
    FirstEntry : PCustomerOrderEntry;
  end;
  PCustomerOrder = ^TCustomerOrder;

  TForecast = record
    PeriodForecast : array [0..51] of double;
  end;
  PForecast = ^TForecast;

  TRecommendedOrders = record
    RO : array [-1..342] of double;
  end;
  PRecommendedOrders = ^TRecommendedOrders;

  TOpeningStock = record
    OS :  array [-1..342] of double;
  end;
  POpeningStock = ^TOpeningStock;

  TCalculatedReceipts = record
    CR :  array [-1..342] of double;
  end;
  PCalculatedReceipts = ^TCalculatedReceipts;

  TBackOrders = record
    BO :  array [-1..342] of double;
  end;
  PBackOrders = ^TBackOrders;

  TCumLostSales = record
    CLS :  array [-1..342] of double;
  end;
  PCumLostSales = ^TCumLostSales;

  TExcess = record
    EX :  array [-1..342] of double;
  end;
  PExcess = ^TExcess;

implementation

end.
