unit DataStructures;

interface

Const
  _MaxDailyPO = 500;

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
    UseMOQplusBinLevelForExcess,
    ErrorMessage : PChar;
    NoPeriodsForecast,
    MaxForwardCover,
    NumberofPeriodsInYear,
    PeriodsForAverageForecast,
    DaysInPer,
    ErrorCode   : Integer;
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
    ProductCode,
    Pareto : PChar;
    Redistro_Excess_MAX_plus,
    ConfirmationHorizon,
    StockBuildNo,
    BackorderRatio : integer;
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
    OrderNo : integer;
    OrderDate,
    OriginalExpectedArrivalDate,
    ExpectedArrivalDate,
    IdealArrivalDate : TDateTime;
    OrderQty, MovedQty : double;
    OrderExpedited : PChar;
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

  TOutputForecast = record
    OutputForecast : array [-1..342] of double;
  end;
  POutputForecast = ^TOutputForecast;

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

  TMaxStock = record
    MAX :  array [-1..342] of double;
  end;
  PMaxStock = ^TMaxStock;

  TCustomerOrderDetail = record
    OrderDate,
    ExpectedDeliveryDate : TDateTime;
    OrderQty : double;
    OrderNumber:String;
  end;
  PCustomerOrderDetail = ^TCustomerOrderDetail;
  TDetailCustomerOrder = record
    NoEntries : integer;
    FirstEntry : PCustomerOrderDetail;
  end;
  PDetailCustomerOrder = ^TDetailCustomerOrder;

  //Store more than a year
  TDailyPurchaseOrders = record
    PO : array [-1.._MaxDailyPO] of double;
  end;
  PDailyPurchaseOrders = ^TDailyPurchaseOrders;



implementation

end.
