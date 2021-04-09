inherited dmData: TdmData
  OldCreateOrder = True
  Left = 464
  Top = 274
  inherited dbOptimiza: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Optimiza\Holeproof\Database\HJ.GDB'
  end
  object qryUpdate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Update Supplier'
      '  Set LT_Short = :LT_Short,'
      '         LT_Medium = :LT_Medium,'
      '         LT_Long = :LT_Long,'
      '         SupplierName = :SupplierName'
      'where SupplierCode = :SupplierCode')
    Left = 104
    Top = 56
    ParamData = <
      item
        DataType = ftFloat
        Name = 'LT_Short'
        ParamType = ptUnknown
      end
      item
        DataType = ftFloat
        Name = 'LT_Medium'
        ParamType = ptUnknown
      end
      item
        DataType = ftFloat
        Name = 'LT_Long'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'SupplierName'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'SupplierCode'
        ParamType = ptUnknown
      end>
  end
end
