inherited dmCopyForecast: TdmCopyForecast
  OldCreateOrder = True
  Left = 285
  Top = 207
  Height = 479
  Width = 741
  object qryAllLocations: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location Order by LocationCode')
    Left = 160
    Top = 48
  end
  object srcAllLocations: TDataSource
    DataSet = qryAllLocations
    Left = 160
    Top = 96
  end
  object qrySearchProduct: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 120
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
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location'
      '  where LocationCode <> :LocationCode')
    Left = 160
    Top = 152
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
    Top = 192
  end
  object prcCopyFC: TIBStoredProc
    Database = dbOptimiza
    Transaction = trnOptimiza
    StoredProcName = 'UP_COPYFC'
    Params = <
      item
        DataType = ftString
        Name = 'SOURCELOCATIONCODE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SOURCEPRODUCTCODE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TARGETPRODUCTCODE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'MONTHCOUNT'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'FREEZEIND'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADDIND'
        ParamType = ptInput
      end>
    Left = 160
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'SOURCELOCATIONCODE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SOURCEPRODUCTCODE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TARGETPRODUCTCODE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'MONTHCOUNT'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'FREEZEIND'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADDIND'
        ParamType = ptInput
      end>
  end
  object qryCheckTarget: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
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
end
