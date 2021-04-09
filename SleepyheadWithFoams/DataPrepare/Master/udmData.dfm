inherited dmData: TdmData
  OldCreateOrder = True
  Left = 669
  Top = 64831
  Height = 480
  Width = 770
  inherited dbOptimiza: TIBDatabase
    Connected = True
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
  object qryItem: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select gm.GroupCode,'
      '           p.productCode,'
      '           (s.SalesAmount_1+'
      '           s.SalesAmount_2+'
      '           s.SalesAmount_3+'
      '           s.SalesAmount_4+'
      '           s.SalesAmount_5+'
      '           s.SalesAmount_6) as Last6Sales,'
      '           i.Age,'
      
        '           (f.Forecast_0+f.Forecast_1+f.forecast_2+f.forecast_3+' +
        'f.forecast_4+f.forecast_5)'
      '           as FC6'
      ''
      'from Item i'
      'left join Product p on i.productno=p.productno'
      'left join groupmajor gm on i.groupmajor=gm.groupno'
      'left join itemsales s on i.itemno=s.itemno'
      
        'left join itemforecast f on i.itemno=f.itemno and f.forecasttype' +
        'No=1 and f.Calendarno=:Calno'
      'where i.LocationNo=:LocNo'
      'Order by 1')
    Left = 112
    Top = 144
    ParamData = <
      item
        DataType = ftInteger
        Name = 'Calno'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'LocNo'
        ParamType = ptUnknown
      end>
  end
  object qryItemProdLocAll: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select r.slhwarehousecode || '#39'|'#39' || p.productcode as ProductKey,' +
        'l.locationcode,r.slhwarehousecode,p.productcode'
      'from '
      'item i join product p on i.productno = p.productno join '
      'location l on i.locationno = l.locationno join'
      
        'ut_loc_reverse_lookup r on r.locationcode = l.locationcode  and ' +
        'r.slhwarehousecode <> '#39#39
      'order by r.slhwarehousecode || '#39'|'#39' || p.productcode;')
    UniDirectional = True
    Left = 88
    Top = 224
  end
  object qryMappedList: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      '  AUS_PRODUCTCODE,'
      '  NZ_PRODUCTCODE'
      'FROM '
      '  UT_ITEM_MAPPING '
      'Order By AUS_PRODUCTCODE')
    Transaction = trnOptimiza
    Left = 32
    Top = 24
  end
end
