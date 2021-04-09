inherited dmImport: TdmImport
  OldCreateOrder = True
  Left = 453
  Top = 301
  inherited dbOptimiza: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Optimiza\Holeproof\Database\HJ.GDB'
  end
  inherited trnOptimiza: TIBTransaction
    Active = True
  end
  object qryDelete: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Delete from LeadTimeAnalysis')
    Transaction = trnOptimiza
    Left = 32
    Top = 64
  end
  object qryGarbage: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Select Count(*) from LeadTimeAnalysis')
    Transaction = trnOptimiza
    Left = 32
    Top = 16
  end
  object qryItem: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      
        'Select i.Itemno,i.LeadTime,i.CostPrice,i.CostPer,i.LeadTimeCateg' +
        'ory, s.SupplierCode,i.Supplierno1,i.LeadTimeVariance From'
      
        'Item i, Supplier s where i.LocationNo = (Select LocationNo from ' +
        'Location where LocationCode = :LocCode)'
      
        'and i.productno = (Select Productno from Product where ProductCo' +
        'de = :ProdCode)'
      'and i.Supplierno1 = s.SupplierNo')
    Transaction = trnOptimiza
    Left = 72
    Top = 144
  end
  object qryDaysInPeriod: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'select TYPEOFINTEGER'
      '  from CONFIGURATION'
      '  where CONFIGURATIONNO = 102')
    Transaction = trnOptimiza
    Left = 112
    Top = 64
  end
  object qryPeriods: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Select * from Calendar where CalendarNo <= :CurrentPeriod and'
      '  CalendarNo >= :MaxPeriod'
      '  '
      ' Order by Calendarno descending')
    Transaction = trnOptimiza
    Left = 112
    Top = 8
  end
  object prcInsert: TIBStoredProc
    Database = dbOptimiza
    Transaction = trnOptimiza
    StoredProcName = 'UP_INSERTLTANALYSIS'
    Left = 16
    Top = 144
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ITEMNO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ORDERNUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'ORIGINALEAD'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'LTCAT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'LT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'COSTPRICE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'COSTPER'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ORDSUPPLIERCODE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ORDSUPPLIERNO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ITEMSUPPLIERNO'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'ORDERDATE'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'FINALDELIVERYDATE'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'EAD'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'QTY'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'ACTUALLT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'LTVARIANCE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'CURRENTLTVARIANCE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'DELIVEREDCALENDARNO'
        ParamType = ptInput
      end>
  end
  object qryCheckTrigger: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Select * from rdb$triggers where'
      'RDB$TRIGGER_NAME = "PURCHASEORDERLTANAL"')
    Transaction = trnOptimiza
    Left = 40
    Top = 280
  end
  object qryDropTrigger: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Drop Trigger PURCHASEORDERLTANAL')
    Transaction = trnOptimiza
    Left = 40
    Top = 336
  end
  object qryCheckUpdate: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Select * from rdb$procedures where'
      'RDB$PROCEDURE_NAME = "UPDATELEADTIMEANALYSIS"')
    Transaction = trnOptimiza
    Left = 128
    Top = 200
  end
  object qryAlterProcedure: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Alter procedure UPDATELEADTIMEANALYSIS'
      'as'
      'begin'
      '  /* Special LT Analysis Import Override Ver 1.0 */'
      '  suspend;'
      'end')
    Transaction = trnOptimiza
    Left = 224
    Top = 200
  end
  object qryCheckUp: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Select * from rdb$procedures where'
      'RDB$PROCEDURE_NAME = "UP_INSERTLTANALYSIS"')
    Transaction = trnOptimiza
    Left = 152
    Top = 296
  end
  object qryCreateUP: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      
        'create procedure up_insertltanalysis (ITEMNO integer, ORDERNUMBE' +
        'R varchar(30), ORIGINALEAD date,'
      
        ' LTCAT char(1), LT double precision, COSTPRICE double precision,' +
        ' COSTPER double precision,'
      
        ' ORDSUPPLIERCODE varchar(30), ORDSUPPLIERNO integer, ITEMSUPPLIE' +
        'RNO integer, ORDERDATE date,'
      
        ' FINALDELIVERYDATE date, EAD date, QTY double precision, ACTUALL' +
        'T double precision,'
      
        ' LTVARIANCE double precision, CURRENTLTVARIANCE double precision' +
        ', DELIVEREDCALENDARNO integer)'
      'as'
      'begin'
      ''
      ' /*if order supplier differs then go get supplier No*/'
      ' if (OrdSupplierNo = -1) then'
      ' begin'
      '   OrdSupplierno = 0;'
      '   '
      '   Select SupplierNo From Supplier where'
      '     SupplierCode = :OrdSupplierCode'
      '     into :OrdSupplierNo;'
      '     '
      '   if ((:OrdSupplierNo is null) or (:OrdSupplierNo = 0)) then'
      '     OrdSupplierNo = ItemSupplierNo;'
      ''
      '   '
      ' end'
      ' '
      
        ' insert into LEADTIMEANALYSIS (LEADTIMEANALYSISNO, ITEMNO, ORDER' +
        'NUMBER,'
      
        '    ORIGINALEAD, SUPPLIERNO, LEADTIMECATEGORY, LEADTIME, COSTPRI' +
        'CE, COSTPER,'
      
        '    ORDERSUPPLIERNO, ORDERDATE, EXPECTEDARRIVALDATE, ORIGINALQUA' +
        'NTITY,'
      
        '    STATUS, FINALDELIVERYDATE, ACTUALLEADTIME, LEADTIMEVARIANCE,' +
        ' '
      '    CURRENTLEADTIMEVARIANCE, DELIVEREDCALENDARNO)'
      
        '    values(gen_id(LEADTIMEANALYSIS_SEQNO, 1), :ITEMNO, :ORDERNUM' +
        'BER,'
      '    :EAD, :ItemSUPPLIERNO, :LTCAT, :LT, :COSTPRICE,'
      
        '    :COSTPER, :OrdSUPPLIERNO, :ORDERDATE, :EAD, :QTY, '#39'D'#39',:Final' +
        'DeliveryDate,'
      
        '    :ActualLT, :LTVariance, :CurrentLTVariance, :DeliveredCalend' +
        'arNo);'
      'end')
    Transaction = trnOptimiza
    Left = 224
    Top = 296
  end
end
