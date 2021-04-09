inherited dmDataImport: TdmDataImport
  OldCreateOrder = True
  Left = 1156
  Top = 264
  Height = 462
  Width = 710
  object qryGetItemNo: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select i.itemno '
      'from item i'
      'inner join product p on i.productno = p.productno'
      'inner join location l on i.locationno = l.locationno'
      'where p.productcode = :prodcode and l.locationcode = :loccode')
    Left = 168
    Top = 244
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prodcode'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'loccode'
        ParamType = ptUnknown
      end>
  end
  object qryGetRepCatNos: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select reportcategorytype, reportcategoryno'
      'from ITEM_REPORTCATEGORY'
      'where itemno = :itemno'
      'and reportcategorytype in (42,43)')
    Left = 236
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'itemno'
        ParamType = ptUnknown
      end>
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'Microsoft.ACE.OLEDB.12.0'
    Left = 164
    Top = 148
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 96
    Top = 144
  end
  object qryInsertExcelData: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'insert into ut_disagMethod '
      '(ID,Description,TrackHistory,MethodType)'
      'Values (0,"6 Month Sales Average","Y","Y")')
    Transaction = trnOptimiza
    Left = 16
    Top = 144
  end
end
