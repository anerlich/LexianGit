inherited dmTest: TdmTest
  Left = 440
  Top = 234
  Height = 447
  Width = 782
  inherited DefaultTrans: TIBTransaction
    Left = 96
  end
  inherited ReadConfig: TIBSQL
    Left = 168
  end
  object qryTest: TIBDataSet
    Database = SVPDatabase
    Transaction = DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    InsertSQL.Strings = (
      'insert into calendar'
      '(calendarno)'
      'values'
      '(?calendarno)')
    SelectSQL.Strings = (
      'select CalendarNo, '
      '          StartDate, '
      '          0 as DayNo, '
      '          0 as WeekNo, '
      '          0 as DVal, '
      '          0 as factor,'
      '          0 as Opening,'
      '          0 as closing,'
      '          0 as orders,'
      '          0 as receipts,'
      '          0 as  excess,'
      '          0 as BO,'
      '          0 as lostsales,'
      '          0 as FwdPO,'
      '          0 as PO,'
      '          0 as CO,'
      '          0 as FC,'
      '          0 as FCIn,'
      '          0 as FCNew,'
      '          0 as DRPFC,'
      '          0 as BOMFC,'
      '          0 as Minimum,'
      '          0 as Maximum,'
      '          0 as Tot,'
      '          0 as BuildTot,'
      '          0 as SS'
      ''
      'from Calendar'
      'where CalendarNo = 0')
    Left = 256
    Top = 16
    object qryTestCALENDARNO: TIntegerField
      FieldName = 'CALENDARNO'
      Origin = 'CALENDAR.CALENDARNO'
    end
    object qryTestSTARTDATE: TDateTimeField
      FieldName = 'STARTDATE'
      Origin = 'CALENDAR.STARTDATE'
    end
    object qryTestWEEKNO: TIntegerField
      FieldName = 'WEEKNO'
    end
    object qryTestDVAL: TIntegerField
      FieldName = 'DVAL'
    end
    object qryTestFACTOR: TIntegerField
      FieldName = 'FACTOR'
    end
    object qryTestOPENING: TIntegerField
      FieldName = 'OPENING'
    end
    object qryTestCLOSING: TIntegerField
      FieldName = 'CLOSING'
    end
    object qryTestORDERS: TIntegerField
      FieldName = 'ORDERS'
    end
    object qryTestRECEIPTS: TIntegerField
      FieldName = 'RECEIPTS'
    end
    object qryTestEXCESS: TIntegerField
      FieldName = 'EXCESS'
    end
    object qryTestBO: TIntegerField
      FieldName = 'BO'
    end
    object qryTestLOSTSALES: TIntegerField
      FieldName = 'LOSTSALES'
    end
    object qryTestFWDPO: TIntegerField
      FieldName = 'FWDPO'
    end
    object qryTestPO: TIntegerField
      FieldName = 'PO'
    end
    object qryTestCO: TIntegerField
      FieldName = 'CO'
    end
    object qryTestFC: TIntegerField
      FieldName = 'FC'
    end
    object qryTestDRPFC: TIntegerField
      FieldName = 'DRPFC'
    end
    object qryTestBOMFC: TIntegerField
      FieldName = 'BOMFC'
    end
    object qryTestMINIMUM: TIntegerField
      FieldName = 'MINIMUM'
      Required = True
    end
    object qryTestMAXIMUM: TIntegerField
      FieldName = 'MAXIMUM'
      Required = True
    end
    object qryTestBUILDTOT: TIntegerField
      FieldName = 'BUILDTOT'
    end
    object qryTestSS: TIntegerField
      FieldName = 'SS'
    end
    object qryTestTOT: TIntegerField
      FieldName = 'TOT'
      Required = True
    end
    object qryTestFCIN: TIntegerField
      FieldName = 'FCIN'
      Required = True
    end
    object qryTestFCNEW: TIntegerField
      FieldName = 'FCNEW'
      Required = True
    end
    object qryTestDAYNO: TIntegerField
      FieldName = 'DAYNO'
      Required = True
    end
  end
  object dscTest: TDataSource
    DataSet = qryTest
    Left = 312
    Top = 16
  end
  object qryLocation: TIBDataSet
    Database = SVPDatabase
    Transaction = DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select *'
      'from Location'
      'order by Description'
      '')
    Left = 384
    Top = 16
    object qryLocationLOCATIONNO: TIntegerField
      FieldName = 'LOCATIONNO'
      Origin = 'LOCATION.LOCATIONNO'
      Required = True
    end
    object qryLocationDESCRIPTION: TIBStringField
      FieldName = 'DESCRIPTION'
      Origin = 'LOCATION.DESCRIPTION'
      Size = 60
    end
    object qryLocationLOCATIONCODE: TIBStringField
      FieldName = 'LOCATIONCODE'
      Origin = 'LOCATION.LOCATIONCODE'
      Required = True
      Size = 10
    end
    object qryLocationCURRENCYNO: TIntegerField
      FieldName = 'CURRENCYNO'
      Origin = 'LOCATION.CURRENCYNO'
    end
  end
  object dscLocation: TDataSource
    DataSet = qryLocation
    Left = 384
    Top = 72
  end
  object qryItem: TIBDataSet
    Database = SVPDatabase
    Transaction = DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'Select'
      '  i.ItemNo,'
      '  i.LocationNo,'
      '  l.LocationCode,'
      '  l.Description as LDescription,'
      '  p.ProductCode,'
      '  p.ProductDescription as PDescription,'
      '/*  i.ItemNo,'
      '  i.LocationNo,'
      '  i.ProductNo, */'
      '  i.StockingIndicator,'
      '  i.ParetoCategory,'
      '  i.SafetyStock,'
      '  i.LeadTime,'
      '  i.TransitLT,'
      '  i.ReplenishmentCycle,'
      '  i.ReviewPeriod,'
      '  i.StockOnHand,'
      '  i.BackOrder,'
      '  i.MinimumOrderQuantity,'
      '  i.OrderMultiples,'
      '  i.ConsolidatedBranchOrders,'
      '  i.BinLevel,'
      '  s.SalesAmount_0,'
      '  i.Forward_SS,'
      '  i.FOrward_SSRC,'
      '  i.RecommendedOrder,'
      '  i.TopupOrder,'
      '  i.IdealOrder,'
      '  i.AbsoluteMinimumQuantity,'
      '  i.CALC_IDEAL_ARRIVAL_DATE,'
      '  i.StockOnOrder,'
      '  i.StockOnOrder_Other,'
      '  i.StockOnOrderInLT,'
      '  i.StockOnOrderInLT_Other,'
      '  i.BackOrderRatio,'
      '  i.BOMBackOrderRatio,'
      '  i.DRPBackOrderRatio,'
      'Stock_BuildNo'
      'from Item i'
      'join ItemSales s on i.ItemNo = s.ItemNo'
      'join Location l on i.LocationNo = l.LocationNo'
      'join Product p on p.ProductNo = i.ProductNo'
      'where LocationNo = :LocationNo'
      ' order by p.ProductCode '
      '/*order by i.ItemNo*/')
    Left = 264
    Top = 144
    object qryItemITEMNO: TIntegerField
      FieldName = 'ITEMNO'
      Origin = 'ITEM.ITEMNO'
      Required = True
    end
    object qryItemLOCATIONCODE: TIBStringField
      FieldName = 'LOCATIONCODE'
      Origin = 'LOCATION.LOCATIONCODE'
      Required = True
      Size = 10
    end
    object qryItemLDESCRIPTION: TIBStringField
      FieldName = 'LDESCRIPTION'
      Origin = 'LOCATION.DESCRIPTION'
      Size = 60
    end
    object qryItemPRODUCTCODE: TIBStringField
      FieldName = 'PRODUCTCODE'
      Origin = 'PRODUCT.PRODUCTCODE'
      Required = True
      Size = 30
    end
    object qryItemPDESCRIPTION: TIBStringField
      FieldName = 'PDESCRIPTION'
      Origin = 'PRODUCT.PRODUCTDESCRIPTION'
      Size = 255
    end
    object qryItemSTOCKINGINDICATOR: TIBStringField
      FieldName = 'STOCKINGINDICATOR'
      Origin = 'ITEM.STOCKINGINDICATOR'
      FixedChar = True
      Size = 1
    end
    object qryItemPARETOCATEGORY: TIBStringField
      FieldName = 'PARETOCATEGORY'
      Origin = 'ITEM.PARETOCATEGORY'
      FixedChar = True
      Size = 1
    end
    object qryItemSAFETYSTOCK: TFloatField
      FieldName = 'SAFETYSTOCK'
      Origin = 'ITEM.SAFETYSTOCK'
    end
    object qryItemLEADTIME: TFloatField
      FieldName = 'LEADTIME'
      Origin = 'ITEM.LEADTIME'
    end
    object qryItemREPLENISHMENTCYCLE: TFloatField
      FieldName = 'REPLENISHMENTCYCLE'
      Origin = 'ITEM.REPLENISHMENTCYCLE'
    end
    object qryItemREVIEWPERIOD: TFloatField
      FieldName = 'REVIEWPERIOD'
      Origin = 'ITEM.REVIEWPERIOD'
    end
    object qryItemSTOCKONHAND: TFloatField
      FieldName = 'STOCKONHAND'
      Origin = 'ITEM.STOCKONHAND'
    end
    object qryItemBACKORDER: TFloatField
      FieldName = 'BACKORDER'
      Origin = 'ITEM.BACKORDER'
    end
    object qryItemMINIMUMORDERQUANTITY: TFloatField
      FieldName = 'MINIMUMORDERQUANTITY'
      Origin = 'ITEM.MINIMUMORDERQUANTITY'
    end
    object qryItemORDERMULTIPLES: TFloatField
      FieldName = 'ORDERMULTIPLES'
      Origin = 'ITEM.ORDERMULTIPLES'
    end
    object qryItemCONSOLIDATEDBRANCHORDERS: TFloatField
      FieldName = 'CONSOLIDATEDBRANCHORDERS'
      Origin = 'ITEM.CONSOLIDATEDBRANCHORDERS'
      Required = True
    end
    object qryItemBINLEVEL: TFloatField
      FieldName = 'BINLEVEL'
      Origin = 'ITEM.BINLEVEL'
    end
    object qryItemSALESAMOUNT_0: TFloatField
      FieldName = 'SALESAMOUNT_0'
      Origin = 'ITEMSALES.SALESAMOUNT_0'
    end
    object qryItemFORWARD_SS: TFloatField
      FieldName = 'FORWARD_SS'
      Origin = 'ITEM.FORWARD_SS'
    end
    object qryItemFORWARD_SSRC: TFloatField
      FieldName = 'FORWARD_SSRC'
      Origin = 'ITEM.FORWARD_SSRC'
    end
    object qryItemRECOMMENDEDORDER: TFloatField
      FieldName = 'RECOMMENDEDORDER'
      Origin = 'ITEM.RECOMMENDEDORDER'
    end
    object qryItemTOPUPORDER: TFloatField
      FieldName = 'TOPUPORDER'
      Origin = 'ITEM.TOPUPORDER'
    end
    object qryItemIDEALORDER: TFloatField
      FieldName = 'IDEALORDER'
      Origin = 'ITEM.IDEALORDER'
    end
    object qryItemLOCATIONNO: TIntegerField
      FieldName = 'LOCATIONNO'
      Origin = 'ITEM.LOCATIONNO'
      Required = True
    end
    object qryItemABSOLUTEMINIMUMQUANTITY: TFloatField
      FieldName = 'ABSOLUTEMINIMUMQUANTITY'
      Origin = 'ITEM.ABSOLUTEMINIMUMQUANTITY'
    end
    object qryItemCALC_IDEAL_ARRIVAL_DATE: TIBStringField
      FieldName = 'CALC_IDEAL_ARRIVAL_DATE'
      Origin = 'ITEM.CALC_IDEAL_ARRIVAL_DATE'
      FixedChar = True
      Size = 1
    end
    object qryItemTRANSITLT: TFloatField
      FieldName = 'TRANSITLT'
      Origin = 'ITEM.TRANSITLT'
    end
    object qryItemSTOCKONORDER: TFloatField
      FieldName = 'STOCKONORDER'
      Origin = 'ITEM.STOCKONORDER'
    end
    object qryItemSTOCKONORDERINLT: TFloatField
      FieldName = 'STOCKONORDERINLT'
      Origin = 'ITEM.STOCKONORDERINLT'
    end
    object qryItemBACKORDERRATIO: TIntegerField
      FieldName = 'BACKORDERRATIO'
      Origin = 'ITEM.BACKORDERRATIO'
    end
    object qryItemBOMBACKORDERRATIO: TIntegerField
      FieldName = 'BOMBACKORDERRATIO'
      Origin = 'ITEM.BOMBACKORDERRATIO'
    end
    object qryItemDRPBACKORDERRATIO: TIntegerField
      FieldName = 'DRPBACKORDERRATIO'
      Origin = 'ITEM.DRPBACKORDERRATIO'
    end
    object qryItemSTOCK_BUILDNO: TIntegerField
      FieldName = 'STOCK_BUILDNO'
      Origin = 'ITEM.STOCK_BUILDNO'
    end
    object qryItemSTOCKONORDER_OTHER: TFloatField
      FieldName = 'STOCKONORDER_OTHER'
      Origin = 'ITEM.STOCKONORDER_OTHER'
    end
    object qryItemSTOCKONORDERINLT_OTHER: TFloatField
      FieldName = 'STOCKONORDERINLT_OTHER'
      Origin = 'ITEM.STOCKONORDERINLT_OTHER'
    end
  end
  object dscItem: TDataSource
    DataSet = qryItem
    Left = 304
    Top = 144
  end
  object qryPOGrid: TIBDataSet
    Database = SVPDatabase
    Transaction = DefaultTrans
    BufferChunks = 1000
    CachedUpdates = True
    InsertSQL.Strings = (
      'Insert into PurchaseOrder'
      '(PurchaseOrderNo)'
      'Values'
      '(?PurchaseOrderNo)')
    SelectSQL.Strings = (
      'select PurchaseOrderNo,'
      '          OrderNumber,'
      '          OrderDate,'
      '          ExpectedArrivalDate,'
      '          Ideal_Arrival_Date,'
      '          Quantity,'
      '          '#39'N'#39' as Expedited'
      'from PurchaseOrder'
      'where   ItemNo = 0')
    Left = 248
    Top = 272
    object qryPOGridPURCHASEORDERNO: TIntegerField
      FieldName = 'PURCHASEORDERNO'
      Origin = 'PURCHASEORDER.PURCHASEORDERNO'
    end
    object qryPOGridORDERNUMBER: TIBStringField
      FieldName = 'ORDERNUMBER'
      Origin = 'PURCHASEORDER.ORDERNUMBER'
      Size = 30
    end
    object qryPOGridORDERDATE: TDateTimeField
      FieldName = 'ORDERDATE'
      Origin = 'PURCHASEORDER.ORDERDATE'
    end
    object qryPOGridEXPECTEDARRIVALDATE: TDateTimeField
      FieldName = 'EXPECTEDARRIVALDATE'
      Origin = 'PURCHASEORDER.EXPECTEDARRIVALDATE'
    end
    object qryPOGridIDEAL_ARRIVAL_DATE: TDateTimeField
      FieldName = 'IDEAL_ARRIVAL_DATE'
      Origin = 'PURCHASEORDER.IDEAL_ARRIVAL_DATE'
    end
    object qryPOGridQUANTITY: TFloatField
      FieldName = 'QUANTITY'
      Origin = 'PURCHASEORDER.QUANTITY'
    end
    object qryPOGridEXPEDITED: TIBStringField
      FieldName = 'EXPEDITED'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object dscPOGrid: TDataSource
    DataSet = qryPOGrid
    Left = 304
    Top = 272
  end
  object qryStockBuild: TIBSQL
    Database = SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      
        'select DESCRIPTION, START_BUILD, START_SHUTDOWN, END_SHUTDOWN, O' +
        'RDERS_DURING_SHUTDOWN'
      'from STOCK_BUILD'
      'where STOCK_BUILDNO = ?STOCK_BUILDNO')
    Transaction = DefaultTrans
    Left = 392
    Top = 204
  end
end
