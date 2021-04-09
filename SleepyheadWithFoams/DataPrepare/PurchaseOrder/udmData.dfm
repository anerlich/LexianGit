inherited dmData: TdmData
  OldCreateOrder = True
  Left = 464
  Top = 274
  inherited dbOptimiza: TIBDatabase
    DatabaseName = 'C:\Optimiza\Holeproof\Database\HJ.GDB'
  end
  object qryProd: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select Itemno from'
      
        '  Item Where LocationNo = (Select LocationNo from Location Where' +
        ' LocationCode = :LocCode)'
      
        '             and ProductNo = (Select ProductNo from Product Wher' +
        'e ProductCode = :ProdCode)')
    Left = 152
    Top = 24
    ParamData = <
      item
        DataType = ftString
        Name = 'LocCode'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'ProdCode'
        ParamType = ptUnknown
      end>
  end
  object qrySupplier: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT s.SupplierNo,s.SupplierCode from '
      'item i'
      'left join Supplier s on  i.SupplierNo1 = s.SupplierNo'
      
        'where i.LocationNo = :LocNo and i.ProductNo = (Select ProductNo ' +
        'From Product where ProductCode = :ProdCode)')
    Left = 152
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LocNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'ProdCode'
        ParamType = ptUnknown
      end>
  end
end
