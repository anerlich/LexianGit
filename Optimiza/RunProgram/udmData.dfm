inherited dmData: TdmData
  OldCreateOrder = True
  object qrySelectProduct: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT DISTINCT PRODUCTCODE FROM PRODUCT p INNER JOIN ITEM i ON ' +
        'i.PRODUCTNO = p.PRODUCTNO;')
    Left = 40
    Top = 32
  end
end
