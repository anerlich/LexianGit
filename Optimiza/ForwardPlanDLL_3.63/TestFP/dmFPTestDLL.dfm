inherited FPTestDLLDatamodule: TFPTestDLLDatamodule
  Left = 85
  Top = 150
  Height = 360
  Width = 577
  object GetItemData: TIBSQL
    Database = SVPMainDataModule.SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select p.ProductCode, p.ProductDescription,'
      '           i.ItemNo,'
      '           i.ParetoCategory,'
      '           i.StockOnHand,'
      '           i.CONSOLIDATEDBRANCHORDERS,'
      '           i.BackOrder,'
      '           i.BinLevel,'
      '           i.SafetyStock,'
      '           i.LeadTime,'
      '           i.ReviewPeriod,'
      '           i.ReplenishmentCycle,'
      '           i.MINIMUMORDERQUANTITY,'
      '           i.OrderMultiples,'
      '           i.TransitLT,'
      '           i.Stock_BuildNo,'
      '          s.SalesAmount_0'
      ''
      '')
    Transaction = SVPMainDataModule.DefaultTrans
    Left = 32
    Top = 80
  end
  object GetFC: TIBSQL
    Database = SVPMainDataModule.SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select forecast_0,'
      '          forecast_1,'
      '          forecast_2,'
      '          forecast_3,'
      '          forecast_4,'
      '          forecast_5,'
      '          forecast_6,'
      '          forecast_7,'
      '          forecast_8,'
      '          forecast_9,'
      '          forecast_10,'
      '          forecast_11,'
      '          forecast_12,'
      '          forecast_13,'
      '          forecast_14,'
      '          forecast_15,'
      '          forecast_16,'
      '          forecast_17,'
      '          forecast_18,'
      '          forecast_19,'
      '          forecast_20,'
      '          forecast_21,'
      '          forecast_22,'
      '          forecast_23,'
      '          forecast_24,'
      '          forecast_25,'
      '          forecast_26,'
      '          forecast_27,'
      '          forecast_28,'
      '          forecast_29,'
      '          forecast_30,'
      '          forecast_31,'
      '          forecast_32,'
      '          forecast_33,'
      '          forecast_34,'
      '          forecast_35,'
      '          forecast_36,'
      '          forecast_37,'
      '          forecast_38,'
      '          forecast_39,'
      '          forecast_40,'
      '          forecast_41,'
      '          forecast_42,'
      '          forecast_43,'
      '          forecast_44,'
      '          forecast_45,'
      '          forecast_46,'
      '          forecast_47,'
      '          forecast_48,'
      '          forecast_49,'
      '          forecast_50,'
      '          forecast_51'
      'from ItemForecast'
      'where ItemNo = ?ItemNo'
      'and CalendarNo = ?CalendarNo'
      'and ForecastTypeNo = ?ForecastTypeNo'
      ''
      ''
      ' ')
    Transaction = SVPMainDataModule.DefaultTrans
    Left = 32
    Top = 152
  end
  object GetPOData: TIBDataSet
    Database = SVPMainDataModule.SVPDatabase
    Transaction = SVPMainDataModule.DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select *'
      'from PurchaseOrder'
      'where ItemNo = ?ItemNo')
    Left = 112
    Top = 152
  end
  object GetCOData: TIBDataSet
    Database = SVPMainDataModule.SVPDatabase
    Transaction = SVPMainDataModule.DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select *'
      'from CustomerOrder'
      'where ItemNo = ?ItemNo')
    Left = 192
    Top = 152
  end
  object Calendar: TIBDataSet
    Database = SVPMainDataModule.SVPDatabase
    Transaction = SVPMainDataModule.DefaultTrans
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select STARTDATE, ENDDATE, DESCRIPTION'
      'from CALENDAR'
      'where CALENDARNO >= ?CALENDARNO '
      '  and CALENDARNO <= ?CALENDARNO + ?NOPERIODS'
      'order by CALENDARNO')
    Left = 32
    Top = 16
  end
  object dscTemplate: TDataSource
    DataSet = GetTemplates
    Left = 112
    Top = 80
  end
  object GetTemplates: TIBDataSet
    Database = SVPMainDataModule.SVPDatabase
    Transaction = SVPMainDataModule.DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select *'
      'from Template'
      'where templatetype = '#39'F'#39
      'order by description')
    Left = 112
    Top = 16
  end
  object DummyTemplates: TIBDataSet
    Database = SVPMainDataModule.SVPDatabase
    Transaction = SVPMainDataModule.DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select *'
      'from Template'
      'where templatetype = '#39'F'#39)
    ModifySQL.Strings = (
      'update Item'
      'set 1 = 1'
      'where itemno = 0')
    Left = 192
    Top = 16
  end
  object dscDummy: TDataSource
    DataSet = DummyTemplates
    Left = 192
    Top = 80
  end
  object GetLocations: TIBDataSet
    Database = SVPMainDataModule.SVPDatabase
    Transaction = SVPMainDataModule.DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select LOCATIONNO, LOCATIONCODE, DESCRIPTION '
      'from LOCATION')
    Left = 32
    Top = 216
    object GetLocationsLOCATIONNO: TIntegerField
      FieldName = 'LOCATIONNO'
      Origin = 'LOCATION.LOCATIONNO'
      Required = True
    end
    object GetLocationsLOCATIONCODE: TIBStringField
      FieldName = 'LOCATIONCODE'
      Origin = 'LOCATION.LOCATIONCODE'
      Required = True
      Size = 10
    end
    object GetLocationsDESCRIPTION: TIBStringField
      FieldName = 'DESCRIPTION'
      Origin = 'LOCATION.DESCRIPTION'
      Size = 60
    end
  end
  object dscLocations: TDataSource
    DataSet = GetLocations
    Left = 32
    Top = 272
  end
  object GetStockBuild: TIBSQL
    Database = SVPMainDataModule.SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select *'
      'from stock_build'
      'where stock_buildno = ?StockBuildNo')
    Transaction = SVPMainDataModule.DefaultTrans
    Left = 272
    Top = 16
  end
end
