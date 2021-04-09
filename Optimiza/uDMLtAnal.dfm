inherited dmLTAnal: TdmLTAnal
  OldCreateOrder = True
  Left = 253
  Top = 147
  Height = 479
  Width = 741
  object tblLTAnal: TTable
    Left = 104
    Top = 128
  end
  object srcLTAnal: TDataSource
    DataSet = qryLTAnal
    Left = 104
    Top = 192
  end
  object qryItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select ITEMNO, LEADTIMECATEGORY, LEADTIME, COSTPRICE, COSTPER, S' +
        'UPPLIERNO1  from ITEM'
      
        '      where ProductNo = (Select ProductNo from Product where    ' +
        '                                    ProductCode = :ProductCode)'
      
        '      and LocationNo = (Select LocationNo from Location where   ' +
        '                                   LocationCode = :LocationCode)')
    Left = 160
    Top = 128
    ParamData = <
      item
        DataType = ftString
        Name = 'ProductCode'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'LocationCode'
        ParamType = ptUnknown
      end>
  end
  object srcItem: TDataSource
    DataSet = qryItem
    Left = 160
    Top = 192
  end
  object qryUpdateLT: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 232
    Top = 128
  end
  object qryLTAnal: TQuery
    Left = 40
    Top = 128
  end
  object qryGetSeqNo: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'Select * from Leadtimeanalysis order by leadtimeanalysisno desce' +
        'nding')
    Left = 240
    Top = 256
  end
  object srcGetSeqNo: TDataSource
    DataSet = qryGetSeqNo
    Left = 240
    Top = 304
  end
  object qrySetSeqNo: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 248
    Top = 200
  end
end
