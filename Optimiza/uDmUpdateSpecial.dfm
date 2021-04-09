inherited dmUpdateSpecial: TdmUpdateSpecial
  OldCreateOrder = True
  Left = 1045
  Top = 170
  Height = 479
  Width = 741
  object qryAllLocations: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location'
      'Order by Description')
    Left = 24
    Top = 8
  end
  object srcAllLocations: TDataSource
    DataSet = qryAllLocations
    Left = 24
    Top = 72
  end
  object qrySearchProd: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 96
    Top = 8
  end
  object srcSearchProd: TDataSource
    DataSet = qrySearchProd
    Left = 96
    Top = 56
  end
  object qryUpdateItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    UniDirectional = True
    Left = 96
    Top = 112
  end
  object qryProducts: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select ProductNo from Product'
      '  where ProductCode = :PRODCODE')
    Left = 104
    Top = 160
    ParamData = <
      item
        DataType = ftString
        Name = 'PRODCODE'
        ParamType = ptUnknown
      end>
  end
  object srcProducts: TDataSource
    DataSet = qryProducts
    Left = 104
    Top = 216
  end
  object qrySuppliers: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select SupplierNo, SupplierCode, SupplierName From Supplier')
    Left = 176
    Top = 8
  end
  object srcSuppliers: TDataSource
    DataSet = qrySuppliers
    Left = 176
    Top = 64
  end
  object qryGroupMajor: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select GroupNo, GroupCode, Description From GroupMajor')
    Left = 168
    Top = 120
  end
  object qryGroupMinor1: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select GroupNo, GroupCode, Description From GroupMinor1')
    Left = 168
    Top = 216
  end
  object qryGroupMinor2: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select GroupNo, GroupCode, Description From GroupMinor2')
    Left = 168
    Top = 312
  end
  object srcGroupMajor: TDataSource
    DataSet = qryGroupMajor
    Left = 168
    Top = 168
  end
  object srcGroupMinor1: TDataSource
    DataSet = qryGroupMinor1
    Left = 168
    Top = 264
  end
  object srcGroupMinor2: TDataSource
    DataSet = qryGroupMinor2
    Left = 168
    Top = 360
  end
  object qryUserFields: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Configuration'
      '  where (ConfigurationNo >= 208 and  ConfigurationNo <= 231)'
      '  or (ConfigurationNo >= 418 and  ConfigurationNo <= 457)'
      'order by Description')
    Left = 32
    Top = 288
  end
  object srcUserFields: TDataSource
    DataSet = qryUserFields
    Left = 40
    Top = 344
  end
  object qryToUpdate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select l.locationcode'
      '   ,p.ProductCode'
      '  ,i.ParetoCategory'
      '  ,i.StockingIndicator'
      '  ,i.LeadTimeCategory'
      '  ,i.ManualPolicy'
      '  ,i.ManualForecast'
      '  ,i.LeadTime'
      '  ,i.ReplenishmentCycle'
      '  ,i.ServiceLevel'
      '  ,i.ReviewPeriod'
      '  ,i.MinimumOrderQuantity'
      '  ,i.OrderMultiples')
    Left = 24
    Top = 152
  end
  object srcToUpdate: TDataSource
    DataSet = qryToUpdate
    Left = 24
    Top = 208
  end
end
