inherited dmExport: TdmExport
  OldCreateOrder = True
  Left = 999
  Top = 278
  Height = 548
  object qryEndDate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select endDate from calendar where calendarno=(Select TypeOfInte' +
        'ger from Configuration where'
      '  ConfigurationNo = 100)+12')
    Left = 176
    Top = 16
  end
  object qryCapacityOrder: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'Select p.productcode,s.SupplierCode,(i.TransitLT * 30.4) as Tran' +
        'sitDays,r2.reportcategorycode as division,po.* from PurchaseOrde' +
        'r po'
      'left join item i on po.itemno=i.itemno'
      'left join product p on i.productno=p.productno '
      
        'join ITEM_REPORTCATEGORY r1 on i.ITEMNO = r1.ITEMNO and r1.REPOR' +
        'TCATEGORYTYPE = 1'
      
        'join REPORTCATEGORY r2 on r1.REPORTCATEGORYNO =  r2.REPORTCATEGO' +
        'RYNO and r2.REPORTCATEGORYTYPE = 1'
      'join Supplier s on i.SupplierNo1=s.SupplierNo'
      ''
      'where i.LocationNo = :LocNo'
      '          and po.OrderDate <= :EndDate'
      '          and po.OrderNumber not like "O-%"'
      '          and po.OrderNumber not like "I-%"')
    UniDirectional = True
    Left = 72
    Top = 16
    ParamData = <
      item
        DataType = ftInteger
        Name = 'LocNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'EndDate'
        ParamType = ptUnknown
      end>
  end
  object qryPotentialStockout: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from up_GetPotentialStockout(:LocCode)')
    Left = 72
    Top = 80
    ParamData = <
      item
        DataType = ftString
        Name = 'LocCode'
        ParamType = ptUnknown
      end>
  end
  object qrySurplusStock: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from up_GetSurplusStock(:LocCode)')
    Left = 176
    Top = 79
    ParamData = <
      item
        DataType = ftString
        Name = 'LocCode'
        ParamType = ptUnknown
      end>
  end
  object qryExpediteOrder: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from up_GetExpediteOrder(:LocCode)')
    Left = 112
    Top = 160
    ParamData = <
      item
        DataType = ftString
        Name = 'LocCode'
        ParamType = ptUnknown
      end>
  end
  object qryLocationList: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    Left = 112
    Top = 224
  end
end
