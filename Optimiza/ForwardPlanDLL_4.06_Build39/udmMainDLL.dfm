inherited dmMainDLL: TdmMainDLL
  OldCreateOrder = True
  Left = 472
  Top = 182
  Height = 634
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
    Left = 295
    Top = 267
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
    object qryTestDAYNO: TIntegerField
      FieldName = 'DAYNO'
      Required = True
    end
  end
  object dscTest: TDataSource
    DataSet = qryTest
    Left = 351
    Top = 267
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
    Left = 423
    Top = 267
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
    Left = 423
    Top = 323
  end
  object qryItem1: TIBDataSet
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
      '  '#39'Dummy'#39' as Division,'
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
      '  i.StockOnOrderInLT,'
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
    Left = 303
    Top = 395
    object qryItem1ITEMNO: TIntegerField
      FieldName = 'ITEMNO'
      Origin = 'ITEM.ITEMNO'
      Required = True
    end
    object qryItem1LOCATIONCODE: TIBStringField
      FieldName = 'LOCATIONCODE'
      Origin = 'LOCATION.LOCATIONCODE'
      Required = True
      Size = 10
    end
    object qryItem1LDESCRIPTION: TIBStringField
      FieldName = 'LDESCRIPTION'
      Origin = 'LOCATION.DESCRIPTION'
      Size = 60
    end
    object qryItem1PRODUCTCODE: TIBStringField
      FieldName = 'PRODUCTCODE'
      Origin = 'PRODUCT.PRODUCTCODE'
      Required = True
      Size = 30
    end
    object qryItem1PDESCRIPTION: TIBStringField
      FieldName = 'PDESCRIPTION'
      Origin = 'PRODUCT.PRODUCTDESCRIPTION'
      Size = 255
    end
    object qryItem1STOCKINGINDICATOR: TIBStringField
      FieldName = 'STOCKINGINDICATOR'
      Origin = 'ITEM.STOCKINGINDICATOR'
      FixedChar = True
      Size = 1
    end
    object qryItem1PARETOCATEGORY: TIBStringField
      FieldName = 'PARETOCATEGORY'
      Origin = 'ITEM.PARETOCATEGORY'
      FixedChar = True
      Size = 1
    end
    object qryItem1SAFETYSTOCK: TFloatField
      FieldName = 'SAFETYSTOCK'
      Origin = 'ITEM.SAFETYSTOCK'
    end
    object qryItem1LEADTIME: TFloatField
      FieldName = 'LEADTIME'
      Origin = 'ITEM.LEADTIME'
    end
    object qryItem1REPLENISHMENTCYCLE: TFloatField
      FieldName = 'REPLENISHMENTCYCLE'
      Origin = 'ITEM.REPLENISHMENTCYCLE'
    end
    object qryItem1REVIEWPERIOD: TFloatField
      FieldName = 'REVIEWPERIOD'
      Origin = 'ITEM.REVIEWPERIOD'
    end
    object qryItem1STOCKONHAND: TFloatField
      FieldName = 'STOCKONHAND'
      Origin = 'ITEM.STOCKONHAND'
    end
    object qryItem1BACKORDER: TFloatField
      FieldName = 'BACKORDER'
      Origin = 'ITEM.BACKORDER'
    end
    object qryItem1MINIMUMORDERQUANTITY: TFloatField
      FieldName = 'MINIMUMORDERQUANTITY'
      Origin = 'ITEM.MINIMUMORDERQUANTITY'
    end
    object qryItem1ORDERMULTIPLES: TFloatField
      FieldName = 'ORDERMULTIPLES'
      Origin = 'ITEM.ORDERMULTIPLES'
    end
    object qryItem1CONSOLIDATEDBRANCHORDERS: TFloatField
      FieldName = 'CONSOLIDATEDBRANCHORDERS'
      Origin = 'ITEM.CONSOLIDATEDBRANCHORDERS'
      Required = True
    end
    object qryItem1BINLEVEL: TFloatField
      FieldName = 'BINLEVEL'
      Origin = 'ITEM.BINLEVEL'
    end
    object qryItem1SALESAMOUNT_0: TFloatField
      FieldName = 'SALESAMOUNT_0'
      Origin = 'ITEMSALES.SALESAMOUNT_0'
    end
    object qryItem1FORWARD_SS: TFloatField
      FieldName = 'FORWARD_SS'
      Origin = 'ITEM.FORWARD_SS'
    end
    object qryItem1FORWARD_SSRC: TFloatField
      FieldName = 'FORWARD_SSRC'
      Origin = 'ITEM.FORWARD_SSRC'
    end
    object qryItem1RECOMMENDEDORDER: TFloatField
      FieldName = 'RECOMMENDEDORDER'
      Origin = 'ITEM.RECOMMENDEDORDER'
    end
    object qryItem1TOPUPORDER: TFloatField
      FieldName = 'TOPUPORDER'
      Origin = 'ITEM.TOPUPORDER'
    end
    object qryItem1IDEALORDER: TFloatField
      FieldName = 'IDEALORDER'
      Origin = 'ITEM.IDEALORDER'
    end
    object qryItem1LOCATIONNO: TIntegerField
      FieldName = 'LOCATIONNO'
      Origin = 'ITEM.LOCATIONNO'
      Required = True
    end
    object qryItem1ABSOLUTEMINIMUMQUANTITY: TFloatField
      FieldName = 'ABSOLUTEMINIMUMQUANTITY'
      Origin = 'ITEM.ABSOLUTEMINIMUMQUANTITY'
    end
    object qryItem1CALC_IDEAL_ARRIVAL_DATE: TIBStringField
      FieldName = 'CALC_IDEAL_ARRIVAL_DATE'
      Origin = 'ITEM.CALC_IDEAL_ARRIVAL_DATE'
      FixedChar = True
      Size = 1
    end
    object qryItem1TRANSITLT: TFloatField
      FieldName = 'TRANSITLT'
      Origin = 'ITEM.TRANSITLT'
    end
    object qryItem1STOCKONORDER: TFloatField
      FieldName = 'STOCKONORDER'
      Origin = 'ITEM.STOCKONORDER'
    end
    object qryItem1STOCKONORDERINLT: TFloatField
      FieldName = 'STOCKONORDERINLT'
      Origin = 'ITEM.STOCKONORDERINLT'
    end
    object qryItem1BACKORDERRATIO: TIntegerField
      FieldName = 'BACKORDERRATIO'
      Origin = 'ITEM.BACKORDERRATIO'
    end
    object qryItem1BOMBACKORDERRATIO: TIntegerField
      FieldName = 'BOMBACKORDERRATIO'
      Origin = 'ITEM.BOMBACKORDERRATIO'
    end
    object qryItem1DRPBACKORDERRATIO: TIntegerField
      FieldName = 'DRPBACKORDERRATIO'
      Origin = 'ITEM.DRPBACKORDERRATIO'
    end
    object qryItem1STOCK_BUILDNO: TIntegerField
      FieldName = 'STOCK_BUILDNO'
      Origin = 'ITEM.STOCK_BUILDNO'
    end
    object qryItem1DIVISION: TIBStringField
      FieldName = 'DIVISION'
      Required = True
      FixedChar = True
      Size = 5
    end
  end
  object dscItem: TDataSource
    DataSet = qryItem1
    Left = 343
    Top = 395
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
    Left = 287
    Top = 523
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
    Left = 343
    Top = 523
  end
  object trnOptimiza: TIBTransaction
    Active = False
    DefaultDatabase = SVPDatabase
    AutoStopAction = saNone
    Left = 552
    Top = 264
  end
  object qrySelectLocation: TIBQuery
    Database = SVPDatabase
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location'
      'where 1=1'
      'Order by LocationCode')
    Left = 552
    Top = 344
  end
  object srcSelectLocation: TDataSource
    DataSet = qrySelectLocation
    Left = 552
    Top = 400
  end
  object prcFireEvent: TIBStoredProc
    Database = SVPDatabase
    Transaction = trnOptimiza
    StoredProcName = 'FIRE_EVENT'
    Left = 552
    Top = 472
    ParamData = <
      item
        DataType = ftString
        Name = 'SUCCESSFAIL'
        ParamType = ptInput
      end>
  end
  object CalendarEnd: TIBSQL
    Database = SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select STARTDATE, ENDDATE, DESCRIPTION'
      'from CALENDAR'
      'where CALENDARNO >= :CALENDARNO1 '
      '  and CALENDARNO <= :CALENDARNO2 + :NOPERIODS'
      'order by CALENDARNO')
    Transaction = trnOptimiza
    Left = 432
    Top = 528
  end
  object qryItem: TIBSQL
    Database = SVPDatabase
    ParamCheck = True
    Transaction = DefaultTrans
    Left = 256
    Top = 400
  end
  object qryGetLocation: TIBQuery
    Database = SVPDatabase
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location '
      'where LocationCode = :iLocation')
    Left = 648
    Top = 272
    ParamData = <
      item
        DataType = ftString
        Name = 'iLocation'
        ParamType = ptUnknown
      end>
  end
  object sqlDRPLexDailyDemand: TIBSQL
    Database = SVPDatabase
    ParamCheck = True
    SQL.Strings = (
      'select ForecastDate, sum(FCValue) as FCValue'
      'from ut_DailyDrp_d'
      'where LOCATIONNO = ?LOCATIONNO'
      'and ITEMNO = ?ItemNo'
      'and FORECASTDATE >= :StockDownloadDate'
      'group by ForecastDate')
    Transaction = DefaultTrans
    Left = 552
    Top = 160
  end
end
