inherited dmUpdateLT: TdmUpdateLT
  OldCreateOrder = True
  object qryAllLocations: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'select LocationCode, Description From Location'
      'Order by Description')
    Left = 24
    Top = 112
  end
  object srcAllLocations: TDataSource
    DataSet = qryAllLocations
    Left = 24
    Top = 56
  end
  object qrySuppliers: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select SupplierCode, SupplierName from Supplier'
      'Order By SupplierCode')
    Left = 112
    Top = 112
  end
  object srcsuppliers: TDataSource
    DataSet = qrySuppliers
    Left = 112
    Top = 56
  end
  object qryUpdateLT: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 88
    Top = 184
  end
end
