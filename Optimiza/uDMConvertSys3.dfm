inherited dmOptimiza1: TdmOptimiza1
  OldCreateOrder = True
  Left = 257
  Top = 133
  Height = 479
  Width = 741
  object qryMlsysdir: TQuery
    Left = 24
    Top = 8
  end
  object srcMlSysdir: TDataSource
    DataSet = qryMlsysdir
    Left = 24
    Top = 56
  end
  object qryLocationList: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = srcMlSysdir
    Left = 120
    Top = 16
  end
  object srcLocationList: TDataSource
    DataSet = qryLocationList
    Left = 120
    Top = 64
  end
  object qryMasterFile: TQuery
    SQL.Strings = (
      
        'select * from "f:\im_ber\sku\master.dbf" where exclude = "E" or ' +
        'exclude = " "')
    Left = 24
    Top = 160
  end
  object srcMasterFile: TDataSource
    DataSet = qryMasterFile
    Left = 24
    Top = 216
  end
  object qryUpdateItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 120
    Top = 160
  end
  object qryUpdateConfiguration: TIBQuery
    Database = dbOptimiza
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 128
    Top = 288
  end
  object qryImSysPar: TQuery
    Left = 24
    Top = 288
  end
  object srcImSysPar: TDataSource
    DataSet = qryImSysPar
    Left = 24
    Top = 344
  end
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = dbOptimiza
    AutoStopAction = saNone
    Left = 312
    Top = 152
  end
  object qryUpdateItemFrozenForecast: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 128
    Top = 232
  end
  object qryConfiguration: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'Select TypeOfInteger from Configuration where ConfigurationNo = ' +
        '100')
    Left = 312
    Top = 224
  end
  object srcConfiguration: TDataSource
    DataSet = qryConfiguration
    Left = 312
    Top = 280
  end
end
