inherited FwdPlanDLLDataModule: TFwdPlanDLLDataModule
  inherited DefaultTrans: TIBTransaction
    Left = 120
  end
  object Get_MonthFactor: TIBSQL
    Database = SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select MONTHFACTOR'
      'from GETMONTHFACTOR')
    Transaction = DefaultTrans
    Left = 40
    Top = 107
  end
  object qryCalendar: TIBDataSet
    Database = SVPDatabase
    Transaction = DefaultTrans
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
    object qryCalendarPERIOD: TIntegerField
      FieldName = 'PERIOD'
      Origin = 'CALENDAR.PERIOD'
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
  end
  object sqlFC: TIBSQL
    Database = SVPDatabase
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
    Transaction = DefaultTrans
    Left = 280
    Top = 8
  end
  object sqlCO: TIBSQL
    Database = SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select'
      '  ExpectedDeliveryDate,'
      '  Quantity'
      'from CustomerOrder'
      'where   ItemNo = :ItemNo'
      'order by ExpectedDeliveryDate, OrderDate, OrderNo'
      '')
    Transaction = DefaultTrans
    Left = 280
    Top = 55
  end
  object sqlPO: TIBSQL
    Database = SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select PurchaseOrderNo,'
      '          OrderNumber,'
      '          OrderDate,'
      '          ExpectedArrivalDate,'
      '          Quantity,'
      '          EXTERNALINDICATOR'
      'from PurchaseOrder'
      'where   ItemNo = :ItemNo'
      'order by ExpectedArrivalDate, OrderDate, PurchaseOrderNo')
    Transaction = DefaultTrans
    Left = 360
    Top = 55
  end
  object qryTradingDays: TIBDataSet
    Database = SVPDatabase
    Transaction = DefaultTrans
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
    Database = SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select ForecastDate, sum(FCValue) as FCValue'
      'from ItemDailyForecast'
      'where  LOCATIONNO = ?LOCATIONNO'
      'and ITEMNO = ?ItemNo'
      'and FORECASTDATE >= :StockDownloadDate'
      'and ForecastTypeNo = 2'
      'group by ForecastDate')
    Transaction = DefaultTrans
    Left = 312
    Top = 112
  end
  object sqlDRPDailyDemand: TIBSQL
    Database = SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select ForecastDate, sum(FCValue) as FCValue'
      'from ItemDailyForecast'
      'where LOCATIONNO = ?LOCATIONNO'
      'and ITEMNO = ?ItemNo'
      'and FORECASTDATE >= :StockDownloadDate'
      'and ForecastTypeNo = 3'
      'group by ForecastDate')
    Transaction = DefaultTrans
    Left = 312
    Top = 176
  end
  object qryBOMDailyDemand: TIBDataSet
    Database = SVPDatabase
    Transaction = DefaultTrans
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
    Left = 432
    Top = 112
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
    Database = SVPDatabase
    Transaction = DefaultTrans
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
    Left = 432
    Top = 168
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
  object qryExclPO: TIBDataSet
    Database = SVPDatabase
    Transaction = DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select PO_EXCLUDE_IND'
      'from PURCHASE_ORDER_TYPE_EXCLUDE'
      'order by PO_EXCLUDE_IND')
    Left = 360
    Top = 8
    object qryExclPOPO_EXCLUDE_IND: TIBStringField
      FieldName = 'PO_EXCLUDE_IND'
      Origin = 'PURCHASE_ORDER_TYPE_EXCLUDE.PO_EXCLUDE_IND'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
end
