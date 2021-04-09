inherited dmData: TdmData
  OldCreateOrder = True
  inherited dbOptimiza: TIBDatabase
    Connected = True
  end
  object qrySchedule: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from SchedulerSets'
      '')
    Left = 128
    Top = 112
  end
  object srcSchedule: TDataSource
    DataSet = qrySchedule
    Left = 128
    Top = 64
  end
  object qryConfig: TIBQuery
    Database = dbOptimiza
    Transaction = trnConfig
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Configuration'
      ' where ConfigurationNo = 291')
    Left = 128
    Top = 208
  end
  object srcConfig: TDataSource
    DataSet = qryConfig
    Left = 128
    Top = 256
  end
  object trnConfig: TIBTransaction
    Active = False
    DefaultDatabase = dbOptimiza
    AutoStopAction = saNone
    Left = 64
    Top = 208
  end
end
