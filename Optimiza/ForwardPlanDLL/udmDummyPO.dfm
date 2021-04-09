inherited dmDummyPO: TdmDummyPO
  OldCreateOrder = True
  Left = 361
  Top = 231
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
      '           r4.REportCategoryCode as Division,'
      '           s.SupplierCode as Vendor,'
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
      '           i.LeadTime * 30.4 as LTDays,'
      '          sale.SalesAmount_0 as S0'
      'from Item i join product p on p.productno = i.productno'
      '                 join location l on l.locationno=i.locationno'
      '                 join ItemSales sale on i.Itemno=sale.ItemNo'
      '                 join Supplier S on s.SupplierNo=i.SupplierNo1'
      
        '                 join ut_Capacity uc on i.GroupMajor = uc.GroupN' +
        'o'
      
        '                 left join ITEM_REPORTCATEGORY r3 on i.ITEMNO = ' +
        '                          r3.ITEMNO and r3.REPORTCATEGORYTYPE = ' +
        '1'
      
        '                 left join ReportCategory r4 on r3.reportCategor' +
        'yNo =                        r4.reportCategoryNo and r4.REPORTCA' +
        'TEGORYTYPE = 1  '
      'where locationno = :LocNo'
      '    and i.StockingUnitFactor > 0.0000'
      
        '    and (uc.Capacity_0+uc.Capacity_1+uc.Capacity_2+uc.Capacity_3' +
        '+uc.Capacity_4+uc.Capacity_5+'
      
        '  uc.Capacity_6+uc.Capacity_7+uc.Capacity_8+uc.Capacity_9+uc.Cap' +
        'acity_10+uc.Capacity_11) > 0'
      '     '
      'order by p.ProductCode')
    Transaction = trnOptimiza
    Left = 48
    Top = 40
  end
  object Calendar: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select STARTDATE, ENDDATE, DESCRIPTION'
      'from CALENDAR'
      'where CALENDARNO >= :CALENDARNO '
      '  and CALENDARNO <= :CALENDARNO + :NOPERIODS'
      'order by CALENDARNO')
    Left = 128
    Top = 40
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
    Left = 160
    Top = 216
  end
  object GetItemData2: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select p.ProductCode, p.ProductDescription,'
      '           l.LocationCode,'
      '           r4.REportCategoryCode as Division,'
      '           s.SupplierCode as Vendor,'
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
      '           i.LeadTime * 30.4 as LTDays'
      'from Item i join product p on p.productno = i.productno'
      '                 join location l on l.locationno=i.locationno'
      '                 join Supplier S on s.SupplierNo=i.SupplierNo1'
      
        '                 left join ut_Capacity uc on i.GroupMajor = uc.G' +
        'roupNo'
      
        '                 left join ITEM_REPORTCATEGORY r3 on i.ITEMNO = ' +
        '                          r3.ITEMNO and r3.REPORTCATEGORYTYPE = ' +
        '1'
      
        '                 left join ReportCategory r4 on r3.reportCategor' +
        'yNo =                        r4.reportCategoryNo and r4.REPORTCA' +
        'TEGORYTYPE = 1  '
      'where locationno = :LocNo'
      '    and (i.StockingUnitFactor <= 0.0000'
      
        ' or uc.GroupNo is null or (uc.Capacity_0+uc.Capacity_1+uc.Capaci' +
        'ty_2+uc.Capacity_3+uc.Capacity_4+uc.Capacity_5+'
      
        '  uc.Capacity_6+uc.Capacity_7+uc.Capacity_8+uc.Capacity_9+uc.Cap' +
        'acity_10+uc.Capacity_11) <= 0)'
      '     '
      'order by p.ProductCode')
    Transaction = trnOptimiza
    Left = 176
    Top = 280
  end
end
