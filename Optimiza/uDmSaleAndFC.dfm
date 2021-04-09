inherited dmCopySaleAndFC: TdmCopySaleAndFC
  OldCreateOrder = True
  Left = 217
  Top = 181
  Height = 479
  Width = 741
  object qryFromLoc: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select LocationNo, LocationCode, Description From Location '
      'Order by LocationCode')
    UniDirectional = True
    Left = 16
    Top = 8
  end
  object qryToLoc: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select LocationNo, LocationCode, Description From Location '
      'Order by LocationCode')
    Left = 144
    Top = 8
  end
  object srcFromLoc: TDataSource
    DataSet = qryFromLoc
    Left = 80
    Top = 8
  end
  object srcToLoc: TDataSource
    DataSet = qryToLoc
    Left = 192
    Top = 8
  end
  object qryFromItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    AfterScroll = qryFromItemAfterScroll
    CachedUpdates = False
    DataSource = srcFromLoc
    SQL.Strings = (
      'Select * from Item'
      '  where LocationNo = :LocationNo')
    UniDirectional = True
    Left = 24
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LocationNo'
        ParamType = ptUnknown
      end>
  end
  object srcFromItem: TDataSource
    DataSet = qryFromItem
    Left = 80
    Top = 72
  end
  object qryToItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 152
    Top = 64
  end
  object srcToItem: TDataSource
    DataSet = qryToItem
    Left = 200
    Top = 72
  end
  object qryInsertItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 224
    Top = 360
  end
  object qrysetSeqNo: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 232
    Top = 184
  end
  object srcsetSeqNo: TDataSource
    DataSet = qrysetSeqNo
    Left = 232
    Top = 240
  end
  object qryFromSales: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    DataSource = srcFromItem
    SQL.Strings = (
      'Select * from ItemSales where'
      '  ItemNo = :ItemNo')
    UniDirectional = True
    Left = 16
    Top = 128
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ItemNo'
        ParamType = ptUnknown
      end>
  end
  object srcFromSales: TDataSource
    DataSet = qryFromSales
    Left = 88
    Top = 128
  end
  object qryUpdateSales: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 224
    Top = 312
  end
  object qryFromFC: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select * from itemforecast '
      '  where ItemNo = :ItemNo'
      '  and ForecastType = 1'
      '  and CalendarNo = :CalendarNo')
    UniDirectional = True
    Left = 16
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ItemNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CalendarNo'
        ParamType = ptUnknown
      end>
  end
  object srcFromFC: TDataSource
    DataSet = qryFromFC
    Left = 88
    Top = 184
  end
  object qryFromFrozen: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    UniDirectional = True
    Left = 16
    Top = 240
  end
  object srcFromFrozen: TDataSource
    DataSet = qryFromFrozen
    Left = 96
    Top = 240
  end
  object qryUpdateFC: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    UniDirectional = True
    Left = 112
    Top = 296
  end
  object qryUpdateFrozen: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    UniDirectional = True
    Left = 112
    Top = 344
  end
end
