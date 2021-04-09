inherited dmMainDLL: TdmMainDLL
  OldCreateOrder = True
  Left = 495
  Top = 283
  inherited dbOptimiza: TIBDatabase
    DatabaseName = ''
  end
  inherited qryGetCurrentPeriod: TIBQuery
    Left = 336
  end
  object GetItemData: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select p.ProductCode, p.ProductDescription,'
      '           l.LocationCode,'
      '           i.ItemNo,'
      '           i.ParetoCategory,'
      '           i.StockingIndicator,'
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
      '          sale.SalesAmount_0 as S0'
      'from Item i join product p on p.productno = i.productno'
      '                 join location l on l.locationno=i.locationno'
      '                 join ItemSales sale on i.Itemno=sale.ItemNo'
      '     '
      'order by p.ProductCode')
    Transaction = trnOptimiza
    Left = 40
    Top = 24
  end
  object Calendar: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select STARTDATE, ENDDATE, DESCRIPTION'
      'from CALENDAR'
      'where CALENDARNO >= :CALENDARNO1 '
      '  and CALENDARNO <= :CALENDARNO2 + :NOPERIODS'
      'order by CALENDARNO')
    Left = 128
    Top = 32
  end
  object GetFC: TIBSQL
    Database = dbOptimiza
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
      'where ItemNo = :ItemNo'
      'and CalendarNo = :CalendarNo'
      'and ForecastTypeNo = :ForecastTypeNo'
      ''
      ''
      ' ')
    Transaction = trnOptimiza
    Left = 40
    Top = 128
  end
  object GetPOData: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select *'
      'from PurchaseOrder'
      'where ItemNo = :ItemNo')
    Left = 104
    Top = 128
  end
  object GetCOData: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select *'
      'from CustomerOrder'
      'where ItemNo = :ItemNo')
    Left = 176
    Top = 128
  end
  object qryGetDownloadDate: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Select TypeOfDate From Configuration'
      '  where ConfigurationNo = 104')
    Transaction = trnOptimiza
    Left = 64
    Top = 208
  end
  object GetConfig: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Select * from Configuration'
      '  where ConfigurationNo = :ConfigNo')
    Transaction = trnOptimiza
    Left = 184
    Top = 208
  end
  object qryCO: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      ' select CustomerOrder_0,'
      '          CustomerOrder_1,'
      '          CustomerOrder_2,'
      '          CustomerOrder_3,'
      '          CustomerOrder_4,'
      '          CustomerOrder_5,'
      '          CustomerOrder_6,'
      '          CustomerOrder_7,'
      '          CustomerOrder_8,'
      '          CustomerOrder_9,'
      '          CustomerOrder_10,'
      '          CustomerOrder_11,'
      '          CustomerOrder_12,'
      '          CustomerOrder_13,'
      '          CustomerOrder_14,'
      '          CustomerOrder_15,'
      '          CustomerOrder_16,'
      '          CustomerOrder_17,'
      '          CustomerOrder_18,'
      '          CustomerOrder_19,'
      '          CustomerOrder_20,'
      '          CustomerOrder_21,'
      '          CustomerOrder_22,'
      '          CustomerOrder_23,'
      '          CustomerOrder_24,'
      '          CustomerOrder_25'
      'from ItemOrder'
      'where ItemNo = :ItemNo'
      ''
      ' ')
    Transaction = trnOptimiza
    Left = 112
    Top = 288
  end
  object qryUpdate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 200
    Top = 280
  end
  object qryUpdate2: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 200
    Top = 336
  end
end
