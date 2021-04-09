inherited dmData: TdmData
  inherited dbOptimiza: TIBDatabase
    Connected = True
  end
  object qryAllLocations: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Select * from Location'
      'where LocationNo > 0'
      ' Order by Description')
    Transaction = trnOptimiza
    Left = 96
    Top = 88
  end
end
