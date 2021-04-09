inherited dmData: TdmData
  OldCreateOrder = True
  Left = 629
  Top = 293
  object spCopyDisag: TIBStoredProc
    Database = dbOptimiza
    Transaction = trnOptimiza
    StoredProcName = 'UP_DISAG_COPY_ORG_TGT'
    Left = 24
    Top = 16
  end
  object qryLocsForModel: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select distinct l.locationcode'
      'from item i '
      'inner join location l on i.locationno = l.locationno '
      'inner join product p on i.productno = p.productno'
      'inner join ut_disaglevel0 dl0 on dl0.itemno = i.itemno'
      'where p.productcode = :prodcode')
    Left = 32
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prodcode'
        ParamType = ptUnknown
      end>
  end
  object spSetDisagRatios: TIBStoredProc
    Database = dbOptimiza
    Transaction = trnOptimiza
    StoredProcName = 'UP_DISAG_SET_RATIO_TGT'
    Left = 32
    Top = 144
  end
  object qryMiscCheck: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 32
    Top = 216
  end
  object spCheckSkuSize: TIBStoredProc
    Database = dbOptimiza
    Transaction = trnOptimiza
    StoredProcName = 'UP_DISAG_CHECK_SKU_SIZE'
    Left = 48
    Top = 288
  end
end
