inherited dmUpdateForecast: TdmUpdateForecast
  OldCreateOrder = True
  Left = 285
  Top = 207
  Height = 479
  Width = 741
  inherited dbOptimiza: TIBDatabase
    DatabaseName = ''
  end
  object qryAllLocations: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location Order by LocationCode')
    Left = 160
    Top = 56
  end
  object srcAllLocations: TDataSource
    DataSet = qryAllLocations
    Left = 160
    Top = 104
  end
  object qrySearchProduct: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 128
    Top = 8
  end
  object srcSearchProduct: TDataSource
    DataSet = qrySearchProduct
    Left = 32
    Top = 8
  end
  object qryTargetLocations: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location'
      '  where LocationCode <> :LocationCode')
    Left = 160
    Top = 160
    ParamData = <
      item
        DataType = ftString
        Name = 'LocationCode'
        ParamType = ptUnknown
      end>
  end
  object srcTargetLocations: TDataSource
    DataSet = qryTargetLocations
    Left = 160
    Top = 216
  end
  object qryCheckTarget: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select itemno from'
      'item where productno = (Select productno from product'
      '  where productCode = :ProdCode)'
      '  and locationno = (Select LocationNo from Location'
      '  where LocationCode = :LocCode)')
    Left = 40
    Top = 120
    ParamData = <
      item
        DataType = ftString
        Name = 'ProdCode'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'LocCode'
        ParamType = ptUnknown
      end>
  end
  object srcCheckTarget: TDataSource
    DataSet = qryCheckTarget
    Left = 40
    Top = 176
  end
  object qryPeriod: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select Description from Calendar'
      '  where Calendarno >= :StartPeriod'
      '  and CalendarNo <= :EndPeriod')
    Left = 48
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'StartPeriod'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EndPeriod'
        ParamType = ptUnknown
      end>
  end
  object srcPeriod: TDataSource
    DataSet = qryPeriod
    Left = 48
    Top = 312
  end
  object prcUpdateFC: TIBStoredProc
    Database = dbOptimiza
    Transaction = trnOptimiza
    StoredProcName = 'UP_UnfreezeFC'
    Left = 160
    Top = 280
  end
end
