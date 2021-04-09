inherited dmRunScript: TdmRunScript
  OldCreateOrder = True
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object qryLastScript: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select TypeOfInteger as LastScript from Configuration where'
      'ConfigurationNo = 180')
    Left = 112
    Top = 96
  end
  object srcLastScript: TDataSource
    DataSet = qryLastScript
    Left = 176
    Top = 96
  end
  object qryUpdate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    ParamCheck = False
    Left = 104
    Top = 184
  end
  object qryScriptNo: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Update Configuration Set TypeOfInteger = :NewNumber'
      'where ConfigurationNo = 180')
    Left = 192
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NewNumber'
        ParamType = ptUnknown
      end>
  end
  object qryUpdateScriptNo: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Update Configuration Set TypeOfInteger = :NewNum'
      ' where Configurationno = 180')
    Left = 104
    Top = 256
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NewNum'
        ParamType = ptUnknown
      end>
  end
end
