inherited dmTest: TdmTest
  OldCreateOrder = True
  Left = 456
  Top = 267
  object qryTest: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
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
    Left = 32
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
    Left = 88
    Top = 16
  end
  object qryPOGrid: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
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
    Left = 40
    Top = 112
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
    Left = 104
    Top = 112
  end
  object qryGetLocation: TIBDataSet
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = True
    SelectSQL.Strings = (
      'select *'
      'from Location'
      'order by Description'
      '')
    Left = 96
    Top = 200
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
    DataSet = qryGetLocation
    Left = 96
    Top = 256
  end
end
