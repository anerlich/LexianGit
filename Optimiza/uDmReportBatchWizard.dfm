inherited dmOptimiza2: TdmOptimiza2
  OldCreateOrder = True
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object qryAllLocations: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'select * from Location')
    Left = 16
    Top = 24
  end
  object srcAllLocations: TDataSource
    DataSet = qryAllLocations
    Left = 16
    Top = 72
  end
  object qryUsers: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select USERNAME from Users')
    Left = 104
    Top = 32
  end
  object srcUsers: TDataSource
    DataSet = qryUsers
    Left = 104
    Top = 80
  end
  object qryReports: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Reports'
      'order by ReportNo')
    Left = 32
    Top = 168
  end
  object qryTemplate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    CachedUpdates = False
    SQL.Strings = (
      'Select * from ReportTemplate'
      '  where ReportNo = :ReportNo')
    Left = 104
    Top = 168
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ReportNo'
        ParamType = ptUnknown
      end>
  end
  object srcReports: TDataSource
    DataSet = qryReports
    Left = 32
    Top = 224
  end
  object srcTemplate: TDataSource
    DataSet = qryTemplate
    Left = 104
    Top = 232
  end
end
