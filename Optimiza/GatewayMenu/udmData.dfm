inherited dmData: TdmData
  OldCreateOrder = True
  Left = 63
  Top = 297
  object qryUser: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from users'
      '  where userName <> '#39'ADMIN'#39
      'order by UserName')
    Left = 120
    Top = 112
  end
  object srcUser: TDataSource
    DataSet = qryUser
    Left = 120
    Top = 176
  end
end
