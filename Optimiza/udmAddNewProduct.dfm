inherited dmaddNewProduct: TdmaddNewProduct
  OldCreateOrder = True
  Left = 264
  Top = 194
  Height = 518
  Width = 741
  inherited dbOptimiza: TIBDatabase
    Left = 344
  end
  inherited qryLocation: TIBQuery
    Left = 480
  end
  inherited prcFireEvent: TIBStoredProc
    Left = 408
  end
  inherited trnOptimiza: TIBTransaction
    Left = 376
  end
  inherited qryDownloadDate: TIBQuery
    Left = 488
  end
  inherited qryCalendarPeriod: TIBQuery
    Left = 464
    Top = 200
  end
  inherited srcCalendarPeriod: TDataSource
    Left = 464
    Top = 248
  end
  inherited qryCalendarDate: TIBQuery
    Left = 472
  end
  inherited qryForecastAndPolicy: TIBQuery
    Left = 464
    Top = 296
  end
  inherited srcForecastAndPolicy: TDataSource
    Left = 464
    Top = 344
  end
  inherited qryGetCurrentPeriod: TIBQuery
    Left = 384
  end
  object srcSearchProduct: TDataSource
    DataSet = qrySearchProduct
    Left = 32
    Top = 8
  end
  object qrySearchProduct: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 120
    Top = 8
  end
  object qrySearchItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      
        'Select l.locationcode ,p.ProductCode ,i.supplierno1, s.supplierc' +
        'ode'
      
        ',i.GroupMajor, mj.Groupcode as MajorGroup ,i.GroupMinor1, m1.Gro' +
        'upCode as MinorGroup1'
      ',i.GroupMinor2, m2.GroupCode as MinorGroup2 ,i.ParetoCategory'
      ',i.StockingIndicator ,i.LeadTimeCategory ,i.ManualPolicy'
      ',i.ManualForecast, i.LeadTime, i.ReplenishmentCycle'
      ',i.ServiceLevel ,i.ReviewPeriod ,i.MinimumOrderQuantity'
      
        ',i.OrderMultiples, i.CostPrice, i.CostPer, i.RetailPrice,i.Produ' +
        'ctNo'
      
        'from item i left outer join Product P on i.ProductNo = P.Product' +
        'No'
      '  left outer join Location L on i.LocationNo = L.LocationNo'
      '  left outer join Supplier S on i.Supplierno1 = S.SupplierNo'
      '  left outer join GroupMajor mj on i.GroupMajor = mj.GroupNo'
      '  left outer join GroupMinor1 m1 on i.GroupMinor1 = m1.GroupNo'
      '  left outer join GroupMinor2 m2 on i.GroupMinor2 = m2.GroupNo'
      'where i.ProductNo = :ProductNo')
    Left = 120
    Top = 64
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ProductNo'
        ParamType = ptUnknown
      end>
  end
  object srcSearchItem: TDataSource
    DataSet = qrySearchItem
    Left = 32
    Top = 64
  end
  object qrySearchsupplier: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 120
    Top = 112
  end
  object srcSearchsupplier: TDataSource
    DataSet = qrySearchsupplier
    Left = 32
    Top = 112
  end
  object qryMajor: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 120
    Top = 168
  end
  object qryMinor1: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 120
    Top = 216
  end
  object qryMinor2: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 120
    Top = 264
  end
  object srcMajor: TDataSource
    DataSet = qryMajor
    Left = 32
    Top = 168
  end
  object srcMinor1: TDataSource
    DataSet = qryMinor1
    Left = 32
    Top = 216
  end
  object srcMinor2: TDataSource
    DataSet = qryMinor2
    Left = 32
    Top = 264
  end
  object qryUser: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 120
    Top = 320
  end
  object srcUser: TDataSource
    DataSet = qryUser
    Left = 32
    Top = 320
  end
  object qryAllLocations: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location')
    Left = 272
    Top = 8
  end
  object srcAllLocations: TDataSource
    DataSet = qryAllLocations
    Left = 200
    Top = 8
  end
  object qryInsertProduct: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Insert into Product (ProductNo, ProductCode, ProductDescription)'
      
        'Values (GEN_ID(Product_Seqno,1),:ProductCode, :ProductDescriptio' +
        'n)')
    Left = 288
    Top = 80
    ParamData = <
      item
        DataType = ftString
        Name = 'ProductCode'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'ProductDescription'
        ParamType = ptUnknown
      end>
  end
  object qryInsertItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Insert Into Item (ItemNo,'
      ' ProductNo, '
      ' LocationNo,'
      ' PARETOCATEGORY,'
      '  STOCKINGINDICATOR,'
      '  MINIMUMORDERQUANTITY,'
      '  ORDERMULTIPLES,'
      '  COSTPRICE,'
      '  COSTPER,'
      '  RETAILPRICE,'
      '  GROUPMAJOR,'
      '  GROUPMINOR1,'
      '  GROUPMINOR2,'
      '  SUPPLIERNO1,'
      '  LEADTIMECATEGORY,'
      '  INVENTORYMANAGER,'
      '  NEWITEM,'
      '  IMPORTED,'
      '  MANUALPOLICY,'
      '  AGE)'
      'Values'
      '(GEN_ID(Item_Seqno,1),'
      ' :ProductNo, '
      ' :LocationNo,'
      ' :PARETOCATEGORY,'
      ' :STOCKINGINDICATOR,'
      '  :MINIMUMORDERQUANTITY,'
      '  :ORDERMULTIPLES,'
      '  :COSTPRICE,'
      '  :COSTPER,'
      '  :RETAILPRICE,'
      '  :GROUPMAJOR,'
      '  :GROUPMINOR1,'
      '  :GROUPMINOR2,'
      '  :SUPPLIERNO1,'
      '  :LEADTIMECATEGORY,'
      '  1,'
      '  "Y",'
      '  "N",'
      '  "N",'
      '  0)')
    Left = 288
    Top = 136
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ProductNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'LocationNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'PARETOCATEGORY'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'STOCKINGINDICATOR'
        ParamType = ptUnknown
      end
      item
        DataType = ftFloat
        Name = 'MINIMUMORDERQUANTITY'
        ParamType = ptUnknown
      end
      item
        DataType = ftFloat
        Name = 'ORDERMULTIPLES'
        ParamType = ptUnknown
      end
      item
        DataType = ftFloat
        Name = 'COSTPRICE'
        ParamType = ptUnknown
      end
      item
        DataType = ftFloat
        Name = 'COSTPER'
        ParamType = ptUnknown
      end
      item
        DataType = ftFloat
        Name = 'RETAILPRICE'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'GROUPMAJOR'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'GROUPMINOR1'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'GROUPMINOR2'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SUPPLIERNO1'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'LEADTIMECATEGORY'
        ParamType = ptUnknown
      end>
  end
  object qryValidateLocs: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 288
    Top = 192
  end
  object srcValidateLocs: TDataSource
    DataSet = qryValidateLocs
    Left = 208
    Top = 192
  end
  object srcUpdate: TDataSource
    DataSet = qryShowProduct
    Left = 280
    Top = 304
  end
  object qryGetMaxItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'select max(ItemNo)'
      ' From Item')
    Left = 352
    Top = 320
  end
  object qryShowProduct: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      
        'Select l.locationcode ,p.ProductCode ,i.supplierno1, s.supplierc' +
        'ode'
      
        ',i.GroupMajor, mj.Groupcode as MajorGroup ,i.GroupMinor1, m1.Gro' +
        'upCode as MinorGroup1'
      ',i.GroupMinor2, m2.GroupCode as MinorGroup2 ,i.ParetoCategory'
      ',i.StockingIndicator ,i.LeadTimeCategory ,i.ManualPolicy'
      ',i.ManualForecast, i.LeadTime, i.ReplenishmentCycle'
      ',i.ServiceLevel ,i.ReviewPeriod ,i.MinimumOrderQuantity'
      
        ',i.OrderMultiples, i.CostPrice, i.CostPer, i.RetailPrice,i.Produ' +
        'ctNo,i.ItemNo'
      
        'from item i left outer join Product P on i.ProductNo = P.Product' +
        'No'
      '  left outer join Location L on i.LocationNo = L.LocationNo'
      '  left outer join Supplier S on i.Supplierno1 = S.SupplierNo'
      '  left outer join GroupMajor mj on i.GroupMajor = mj.GroupNo'
      '  left outer join GroupMinor1 m1 on i.GroupMinor1 = m1.GroupNo'
      '  left outer join GroupMinor2 m2 on i.GroupMinor2 = m2.GroupNo'
      'where i.itemno > :ItemNo')
    Left = 232
    Top = 264
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ItemNo'
        ParamType = ptUnknown
      end>
  end
  object qryUpdateSupplier: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Update item'
      ' set Supplierno1 = :SupplierNo'
      'where ItemNo = :ItemNo')
    Left = 304
    Top = 248
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SupplierNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'ItemNo'
        ParamType = ptUnknown
      end>
  end
end
