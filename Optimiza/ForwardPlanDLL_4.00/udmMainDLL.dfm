inherited dmMainDLL: TdmMainDLL
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Left = 436
  Top = 266
  Width = 714
  inherited dbOptimiza: TIBDatabase
    Connected = True
    DatabaseName = 'optimizakg:c:\optimiza\holeproof\database\hj.gdb'
  end
  inherited trnOptimiza: TIBTransaction
    Active = True
  end
  inherited ReadConfig: TIBSQL
    Database = dbOptimiza
    Transaction = trnOptimiza
  end
  inherited ReadConfigLoc: TIBSQL
    Database = dbOptimiza
    Transaction = trnOptimiza
  end
  object Get_MonthFactor: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select MONTHFACTOR'
      'from GETMONTHFACTOR')
    Transaction = trnOptimiza
    Left = 40
    Top = 107
  end
  object qryCalendar: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select *'
      'from Calendar'
      'where CalendarNo >= ?CurrentPeriod'
      'order by CalendarNo')
    Left = 120
    Top = 107
    object qryCalendarCALENDARNO: TIntegerField
      FieldName = 'CALENDARNO'
      Origin = 'CALENDAR.CALENDARNO'
      Required = True
    end
    object qryCalendarSTARTDATE: TDateTimeField
      FieldName = 'STARTDATE'
      Origin = 'CALENDAR.STARTDATE'
    end
    object qryCalendarENDDATE: TDateTimeField
      FieldName = 'ENDDATE'
      Origin = 'CALENDAR.ENDDATE'
    end
    object qryCalendarDESCRIPTION: TIBStringField
      FieldName = 'DESCRIPTION'
      Origin = 'CALENDAR.DESCRIPTION'
      Size = 60
    end
    object qryCalendarCALENDARYEAR: TIntegerField
      FieldName = 'CALENDARYEAR'
      Origin = 'CALENDAR.CALENDARYEAR'
      Required = True
    end
    object qryCalendarPERIOD2: TIntegerField
      FieldName = 'PERIOD'
      Origin = 'CALENDAR.PERIOD'
      Required = True
    end
  end
  object sqlFC: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select '
      '  FORECASTTYPENO,'
      '  FORECAST_0, '
      '  FORECAST_1, '
      '  FORECAST_2, '
      '  FORECAST_3, '
      '  FORECAST_4, '
      '  FORECAST_5, '
      '  FORECAST_6, '
      '  FORECAST_7, '
      '  FORECAST_8, '
      '  FORECAST_9, '
      '  FORECAST_10, '
      '  FORECAST_11, '
      '  FORECAST_12, '
      '  FORECAST_13, '
      '  FORECAST_14, '
      '  FORECAST_15, '
      '  FORECAST_16, '
      '  FORECAST_17, '
      '  FORECAST_18, '
      '  FORECAST_19, '
      '  FORECAST_20, '
      '  FORECAST_21, '
      '  FORECAST_22, '
      '  FORECAST_23, '
      '  FORECAST_24, '
      '  FORECAST_25'
      'from ItemForecast'
      'where ITEMNO = ?ItemNo'
      '  and CALENDARNO = ?CalendarNo'
      '  and FORECASTTYPENO < 4')
    Transaction = trnOptimiza
    Left = 80
    Top = 24
  end
  object sqlCO: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select'
      '  ExpectedDeliveryDate,'
      '  Quantity'
      'from CustomerOrder'
      'where   ItemNo = :ItemNo'
      'order by ExpectedDeliveryDate, OrderDate, OrderNo'
      '')
    Transaction = trnOptimiza
    Left = 168
    Top = 63
  end
  object sqlPO: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select PurchaseOrderNo,'
      '          OrderNumber,'
      '          OrderDate,'
      '          ExpectedArrivalDate,'
      '          Quantity'
      'from PurchaseOrder'
      'where   ItemNo = :ItemNo'
      'order by ExpectedArrivalDate, OrderDate, PurchaseOrderNo')
    Transaction = trnOptimiza
    Left = 144
    Top = 311
  end
  object qryTradingDays: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select *'
      
        'from TradeCalendarDetail tc join Location l on l.TradeCalendarNo' +
        ' = tc.TradeCalendarNo'
      'where l.LocationNo = ?LocationNo'
      'and CalendarDate >= ?StockDownloadDate'
      'order by CalendarNo, CalendarDate')
    Left = 120
    Top = 168
    object qryTradingDaysTRADECALENDARDETAILNO: TIntegerField
      FieldName = 'TRADECALENDARDETAILNO'
      Origin = 'TRADECALENDARDETAIL.TRADECALENDARDETAILNO'
      Required = True
    end
    object qryTradingDaysCALENDARDATE: TDateTimeField
      FieldName = 'CALENDARDATE'
      Origin = 'TRADECALENDARDETAIL.CALENDARDATE'
      Required = True
    end
    object qryTradingDaysCALENDARNO: TIntegerField
      FieldName = 'CALENDARNO'
      Origin = 'TRADECALENDARDETAIL.CALENDARNO'
    end
    object qryTradingDaysRATIO: TIntegerField
      FieldName = 'RATIO'
      Origin = 'TRADECALENDARDETAIL.RATIO'
    end
    object qryTradingDaysDAYNO: TIntegerField
      FieldName = 'DAYNO'
      Origin = 'TRADECALENDARDETAIL.DAYNO'
    end
    object qryTradingDaysWEEKNO: TIntegerField
      FieldName = 'WEEKNO'
      Origin = 'TRADECALENDARDETAIL.WEEKNO'
    end
    object qryTradingDaysTRADECALENDARNO: TIntegerField
      FieldName = 'TRADECALENDARNO'
      Origin = 'TRADECALENDARDETAIL.TRADECALENDARNO'
      Required = True
    end
    object qryTradingDaysDESCRIPTION: TIBStringField
      FieldName = 'DESCRIPTION'
      Origin = 'TRADECALENDARDETAIL.DESCRIPTION'
      Size = 60
    end
  end
  object sqlBOMDailyDemand: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select ForecastDate, sum(FCValue) as FCValue'
      'from ItemDailyForecast'
      'where  LOCATIONNO = ?LOCATIONNO'
      'and ITEMNO = ?ItemNo'
      'and FORECASTDATE >= :StockDownloadDate'
      'and ForecastTypeNo = 2'
      'group by ForecastDate')
    Transaction = trnOptimiza
    Left = 216
    Top = 120
  end
  object sqlDRPDailyDemand: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select ForecastDate, sum(FCValue) as FCValue'
      'from ItemDailyForecast'
      'where LOCATIONNO = ?LOCATIONNO'
      'and ITEMNO = ?ItemNo'
      'and FORECASTDATE >= :StockDownloadDate'
      'and ForecastTypeNo = 3'
      'group by ForecastDate')
    Transaction = trnOptimiza
    Left = 200
    Top = 192
  end
  object qryBOMDailyDemand: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = True
    DeleteSQL.Strings = (
      'update RDB$DATABASE'
      'set RDB$DESCRIPTION = '#39#39
      'where 1=2')
    InsertSQL.Strings = (
      'update RDB$DATABASE'
      'set RDB$DESCRIPTION = '#39#39
      'where 1=2')
    SelectSQL.Strings = (
      'select ForecastDate, sum(FCValue) as FCValue, ITEMNO'
      'from ItemDailyForecast'
      'where ITEMNO = ?ItemNo'
      'and FORECASTDATE >= :StockDownloadDate'
      'and ForecastTypeNo = 2'
      'group by ForecastDate, ITEMNO')
    ModifySQL.Strings = (
      'update RDB$DATABASE'
      'set RDB$DESCRIPTION = '#39#39
      'where 1=2')
    Left = 64
    Top = 312
    object qryBOMDailyDemandFORECASTDATE: TDateTimeField
      FieldName = 'FORECASTDATE'
      Required = True
    end
    object qryBOMDailyDemandFCVALUE: TFloatField
      FieldName = 'FCVALUE'
    end
    object qryBOMDailyDemandITEMNO: TIntegerField
      FieldName = 'ITEMNO'
      Required = True
    end
  end
  object qryDRPDailyDemand: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = True
    DeleteSQL.Strings = (
      'update RDB$DATABASE'
      'set RDB$DESCRIPTION = '#39#39
      'where 1=2')
    InsertSQL.Strings = (
      'update RDB$DATABASE'
      'set RDB$DESCRIPTION = '#39#39
      'where 1=2')
    SelectSQL.Strings = (
      'select ForecastDate, sum(FCValue) as FCValue, ITEMNO'
      'from ItemDailyForecast'
      'where ITEMNO = ?ItemNo'
      'and FORECASTDATE >= :StockDownloadDate'
      'and ForecastTypeNo = 3'
      'group by ForecastDate, ITEMNO')
    ModifySQL.Strings = (
      'update RDB$DATABASE'
      'set RDB$DESCRIPTION = '#39#39
      'where 1=2')
    Left = 80
    Top = 248
    object qryDRPDailyDemandFORECASTDATE: TDateTimeField
      FieldName = 'FORECASTDATE'
      Required = True
    end
    object qryDRPDailyDemandFCVALUE: TFloatField
      FieldName = 'FCVALUE'
    end
    object qryDRPDailyDemandITEMNO: TIntegerField
      FieldName = 'ITEMNO'
      Required = True
    end
  end
  object GetItemData1: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'Select'
      '  i.ItemNo,'
      '  i.LocationNo,'
      '  l.LocationCode,'
      '  l.Description as LDescription,'
      '  p.ProductCode,'
      '  p.ProductDescription as PDescription,'
      '/*  i.ItemNo,'
      '  i.LocationNo,'
      '  i.ProductNo, */'
      '  i.StockingIndicator,'
      '  i.ParetoCategory,'
      '  i.SafetyStock,'
      '  i.LeadTime,'
      '  i.TransitLT,'
      '  i.ReplenishmentCycle,'
      '  i.ReviewPeriod,'
      '  i.StockOnHand,'
      '  i.BackOrder,'
      '  i.MinimumOrderQuantity,'
      '  i.OrderMultiples,'
      '  i.ConsolidatedBranchOrders,'
      '  i.BinLevel,'
      '  s.SalesAmount_0,'
      '  i.Forward_SS,'
      '  i.FOrward_SSRC,'
      '  i.RecommendedOrder,'
      '  i.TopupOrder,'
      '  i.IdealOrder,'
      '  i.AbsoluteMinimumQuantity,'
      '  i.CALC_IDEAL_ARRIVAL_DATE,'
      '  i.StockOnOrder,'
      '  i.StockOnOrder_Other,'
      '  i.StockOnOrderInLT,'
      '  i.StockOnOrderInLT_Other,'
      '  i.BackOrderRatio,'
      '  i.BOMBackOrderRatio,'
      '  i.DRPBackOrderRatio,'
      'Stock_BuildNo'
      'from Item i'
      'join ItemSales s on i.ItemNo = s.ItemNo'
      'join Location l on i.LocationNo = l.LocationNo'
      'join Product p on p.ProductNo = i.ProductNo'
      'where LocationNo = :LocationNo'
      ' order by p.ProductCode '
      '/*order by i.ItemNo*/')
    Left = 176
    Top = 8
    object GetItemData1ITEMNO: TIntegerField
      FieldName = 'ITEMNO'
      Origin = 'ITEM.ITEMNO'
      Required = True
    end
    object GetItemData1LOCATIONCODE: TIBStringField
      FieldName = 'LOCATIONCODE'
      Origin = 'LOCATION.LOCATIONCODE'
      Required = True
      Size = 10
    end
    object GetItemData1LDESCRIPTION: TIBStringField
      FieldName = 'LDESCRIPTION'
      Origin = 'LOCATION.DESCRIPTION'
      Size = 60
    end
    object GetItemData1PRODUCTCODE: TIBStringField
      FieldName = 'PRODUCTCODE'
      Origin = 'PRODUCT.PRODUCTCODE'
      Required = True
      Size = 30
    end
    object GetItemData1PDESCRIPTION: TIBStringField
      FieldName = 'PDESCRIPTION'
      Origin = 'PRODUCT.PRODUCTDESCRIPTION'
      Size = 255
    end
    object GetItemData1STOCKINGINDICATOR: TIBStringField
      FieldName = 'STOCKINGINDICATOR'
      Origin = 'ITEM.STOCKINGINDICATOR'
      FixedChar = True
      Size = 1
    end
    object GetItemData1PARETOCATEGORY: TIBStringField
      FieldName = 'PARETOCATEGORY'
      Origin = 'ITEM.PARETOCATEGORY'
      FixedChar = True
      Size = 1
    end
    object GetItemData1SAFETYSTOCK: TFloatField
      FieldName = 'SAFETYSTOCK'
      Origin = 'ITEM.SAFETYSTOCK'
    end
    object GetItemData1LEADTIME: TFloatField
      FieldName = 'LEADTIME'
      Origin = 'ITEM.LEADTIME'
    end
    object GetItemData1REPLENISHMENTCYCLE: TFloatField
      FieldName = 'REPLENISHMENTCYCLE'
      Origin = 'ITEM.REPLENISHMENTCYCLE'
    end
    object GetItemData1REVIEWPERIOD: TFloatField
      FieldName = 'REVIEWPERIOD'
      Origin = 'ITEM.REVIEWPERIOD'
    end
    object GetItemData1STOCKONHAND: TFloatField
      FieldName = 'STOCKONHAND'
      Origin = 'ITEM.STOCKONHAND'
    end
    object GetItemData1BACKORDER: TFloatField
      FieldName = 'BACKORDER'
      Origin = 'ITEM.BACKORDER'
    end
    object GetItemData1MINIMUMORDERQUANTITY: TFloatField
      FieldName = 'MINIMUMORDERQUANTITY'
      Origin = 'ITEM.MINIMUMORDERQUANTITY'
    end
    object GetItemData1ORDERMULTIPLES: TFloatField
      FieldName = 'ORDERMULTIPLES'
      Origin = 'ITEM.ORDERMULTIPLES'
    end
    object GetItemData1CONSOLIDATEDBRANCHORDERS: TFloatField
      FieldName = 'CONSOLIDATEDBRANCHORDERS'
      Origin = 'ITEM.CONSOLIDATEDBRANCHORDERS'
      Required = True
    end
    object GetItemData1BINLEVEL: TFloatField
      FieldName = 'BINLEVEL'
      Origin = 'ITEM.BINLEVEL'
    end
    object GetItemData1SALESAMOUNT_0: TFloatField
      FieldName = 'SALESAMOUNT_0'
      Origin = 'ITEMSALES.SALESAMOUNT_0'
    end
    object GetItemData1FORWARD_SS: TFloatField
      FieldName = 'FORWARD_SS'
      Origin = 'ITEM.FORWARD_SS'
    end
    object GetItemData1FORWARD_SSRC: TFloatField
      FieldName = 'FORWARD_SSRC'
      Origin = 'ITEM.FORWARD_SSRC'
    end
    object GetItemData1RECOMMENDEDORDER: TFloatField
      FieldName = 'RECOMMENDEDORDER'
      Origin = 'ITEM.RECOMMENDEDORDER'
    end
    object GetItemData1TOPUPORDER: TFloatField
      FieldName = 'TOPUPORDER'
      Origin = 'ITEM.TOPUPORDER'
    end
    object GetItemData1IDEALORDER: TFloatField
      FieldName = 'IDEALORDER'
      Origin = 'ITEM.IDEALORDER'
    end
    object GetItemData1LOCATIONNO: TIntegerField
      FieldName = 'LOCATIONNO'
      Origin = 'ITEM.LOCATIONNO'
      Required = True
    end
    object GetItemData1ABSOLUTEMINIMUMQUANTITY: TFloatField
      FieldName = 'ABSOLUTEMINIMUMQUANTITY'
      Origin = 'ITEM.ABSOLUTEMINIMUMQUANTITY'
    end
    object GetItemData1CALC_IDEAL_ARRIVAL_DATE: TIBStringField
      FieldName = 'CALC_IDEAL_ARRIVAL_DATE'
      Origin = 'ITEM.CALC_IDEAL_ARRIVAL_DATE'
      FixedChar = True
      Size = 1
    end
    object GetItemData1TRANSITLT: TFloatField
      FieldName = 'TRANSITLT'
      Origin = 'ITEM.TRANSITLT'
    end
    object GetItemData1STOCKONORDER: TFloatField
      FieldName = 'STOCKONORDER'
      Origin = 'ITEM.STOCKONORDER'
    end
    object GetItemData1STOCKONORDERINLT: TFloatField
      FieldName = 'STOCKONORDERINLT'
      Origin = 'ITEM.STOCKONORDERINLT'
    end
    object GetItemData1BACKORDERRATIO: TIntegerField
      FieldName = 'BACKORDERRATIO'
      Origin = 'ITEM.BACKORDERRATIO'
    end
    object GetItemData1BOMBACKORDERRATIO: TIntegerField
      FieldName = 'BOMBACKORDERRATIO'
      Origin = 'ITEM.BOMBACKORDERRATIO'
    end
    object GetItemData1DRPBACKORDERRATIO: TIntegerField
      FieldName = 'DRPBACKORDERRATIO'
      Origin = 'ITEM.DRPBACKORDERRATIO'
    end
    object GetItemData1STOCK_BUILDNO: TIntegerField
      FieldName = 'STOCK_BUILDNO'
      Origin = 'ITEM.STOCK_BUILDNO'
    end
    object GetItemData1STOCKONORDER_OTHER: TFloatField
      FieldName = 'STOCKONORDER_OTHER'
      Origin = 'ITEM.STOCKONORDER_OTHER'
    end
    object GetItemData1STOCKONORDERINLT_OTHER: TFloatField
      FieldName = 'STOCKONORDERINLT_OTHER'
      Origin = 'ITEM.STOCKONORDERINLT_OTHER'
    end
  end
  object GetItemData: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    Transaction = trnOptimiza
    Left = 216
    Top = 64
  end
  object Calendar: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select STARTDATE, ENDDATE, DESCRIPTION'
      'from CALENDAR'
      'where CALENDARNO >= :CALENDARNO1 '
      '  and CALENDARNO <= :CALENDARNO2 + :NOPERIODS'
      'order by CALENDARNO')
    Transaction = trnOptimiza
    Left = 232
    Top = 256
  end
end
