inherited dmData: TdmData
  OldCreateOrder = True
  Left = 464
  Top = 274
  inherited dbOptimiza: TIBDatabase
    DatabaseName = 'C:\Optimiza\Holeproof\Database\HJ.GDB'
  end
  object qryProd1: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Select l.LocationCode, p.productCode '
      ' from Product p'
      ' Left Join Item i on p.productno=i.Productno '
      ' Left Join Location l on i.LocationNo=l.LocationNo'
      '  Where p.productCode = :ProdCode ')
    Transaction = trnOptimiza
    Left = 112
    Top = 56
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
    Left = 120
    Top = 144
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
  object qryProduct: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select p.productCode from'
      '  Item i'
      '  Left Join Product p on i.productno=p.productno'
      'where i.Locationno=:LocNo')
    UniDirectional = True
    Left = 120
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LocNo'
        ParamType = ptUnknown
      end>
  end
end
