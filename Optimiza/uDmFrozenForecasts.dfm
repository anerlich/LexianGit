inherited dmFrozenForecast: TdmFrozenForecast
  OldCreateOrder = True
  Left = 282
  Top = 209
  Height = 479
  Width = 741
  object qryFrzFile: TQuery
    SQL.Strings = (
      'Select * from "Exp_frz.dbf"')
    Left = 64
    Top = 64
  end
  object srcFrzFile: TDataSource
    DataSet = qryFrzFile
    Left = 64
    Top = 112
  end
  object qryItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select ProductNo,ProductCode From Product '
      'where ProductCode = :ITEM')
    Left = 64
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ITEM'
        ParamType = ptUnknown
      end>
  end
  object srcItem: TDataSource
    DataSet = qryItem
    Left = 72
    Top = 240
  end
  object qryUpdateFrz: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    Left = 136
    Top = 192
  end
end
