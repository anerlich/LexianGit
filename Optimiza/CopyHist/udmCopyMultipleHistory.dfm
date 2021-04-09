inherited dmCopyMultipleHistory: TdmCopyMultipleHistory
  OldCreateOrder = True
  object qryAllLocations: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select LocationCode, Description from Location '
      '  Order by LocationCode')
    Left = 96
    Top = 72
  end
  object qryProduct: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 88
    Top = 176
  end
end
