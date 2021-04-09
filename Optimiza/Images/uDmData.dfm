inherited dmData: TdmData
  object qryTemplate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select TemplateNo,Description from Template'
      'where TemplateType = '#39'F'#39' and UserNo = :UserNo'
      'Order by Description')
    Left = 192
    Top = 152
    ParamData = <
      item
        DataType = ftInteger
        Name = 'UserNo'
        ParamType = ptUnknown
      end>
  end
  object srcTemplate: TDataSource
    DataSet = qryTemplate
    Left = 184
    Top = 200
  end
end
