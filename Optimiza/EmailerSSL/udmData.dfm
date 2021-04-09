inherited dmData: TdmData
  OldCreateOrder = True
  inherited dbOptimiza: TIBDatabase
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
  end
  object qryUser: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select UserName,Emailadd_1 as eaddr from Users'
      '  where Emailadd_1 <> ""'
      '  union'
      'Select UserName,Emailadd_2 as eaddr from Users'
      '  where Emailadd_2 <> ""'
      '  union'
      'Select UserName,Emailadd_3 as eaddr from Users'
      '  where Emailadd_3 <> ""')
    Left = 96
    Top = 88
  end
  object srcUser: TDataSource
    DataSet = qryUser
    Left = 168
    Top = 80
  end
  object qryHost: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select * from configuration where ConfigurationNo = 154')
    Left = 120
    Top = 184
  end
  object qryAccount: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select * from configuration where ConfigurationNo = 155')
    Left = 152
    Top = 248
  end
end
