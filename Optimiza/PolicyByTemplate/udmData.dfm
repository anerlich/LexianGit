inherited dmData: TdmData
  OldCreateOrder = True
  Left = 967
  Top = 71
  Height = 661
  object qryUsers: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select UserName, UserNo from Users'
      '  Order By UserName')
    Left = 146
    Top = 289
  end
  object qryTemplate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select TemplateNo,Description from Template'
      'where TemplateType = '#39'F'#39' and UserNo = :UserNo'
      'Order by Description')
    Left = 58
    Top = 289
    ParamData = <
      item
        DataType = ftInteger
        Name = 'UserNo'
        ParamType = ptUnknown
      end>
  end
  object srcTemplate: TDataSource
    DataSet = qryTemplate
    Left = 58
    Top = 337
  end
  object srcUsers: TDataSource
    DataSet = qryUsers
    Left = 146
    Top = 353
  end
  object qryTemplateName: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select TemplateNo,Description,UserNo from Template'
      'where TemplateNo = :TemplateNo')
    Left = 226
    Top = 321
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TemplateNo'
        ParamType = ptUnknown
      end>
  end
  object qryAlter: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    Transaction = trnOptimiza
    Left = 112
    Top = 96
  end
  object qryExec: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Execute procedure up_Policy_dynamic;')
    Transaction = trnOptimiza
    Left = 104
    Top = 160
  end
  object qryGetLocalAdmin: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select UserNo from Users'
      '  where UserName = '#39'LOCALADMIN'#39)
    Left = 210
    Top = 177
  end
  object qryDrop: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Drop procedure up_Policy_dynamic')
    Transaction = trnOther
    Left = 40
    Top = 128
  end
  object trnOther: TIBTransaction
    Active = False
    DefaultDatabase = dbOptimiza
    AutoStopAction = saNone
    Left = 176
    Top = 40
  end
end
