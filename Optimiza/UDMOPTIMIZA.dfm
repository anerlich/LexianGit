object dmOptimiza: TdmOptimiza
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 556
  Width = 1453
  object dbOptimiza: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    SQLDialect = 1
    AllowStreamedConnected = False
    Left = 288
    Top = 8
  end
  object qryLocation: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select * from Location '
      'where LocationCode = :iLocation')
    Left = 440
    Top = 16
    ParamData = <
      item
        DataType = ftString
        Name = 'iLocation'
        ParamType = ptUnknown
      end>
  end
  object prcFireEvent: TIBStoredProc
    Database = dbOptimiza
    Transaction = trnOptimiza
    StoredProcName = 'FIRE_EVENT'
    Left = 352
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'SUCCESSFAIL'
        ParamType = ptInput
      end>
  end
  object trnOptimiza: TIBTransaction
    DefaultDatabase = dbOptimiza
    Left = 288
    Top = 64
  end
  object qryDownloadDate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      '  select TYPEOFDATE'
      '  from CONFIGURATION'
      '  where CONFIGURATIONNO = 104'
      ''
      '')
    Left = 432
    Top = 64
  end
  object qryCalendarPeriod: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      ''
      '')
    Left = 352
    Top = 168
  end
  object srcCalendarPeriod: TDataSource
    DataSet = qryCalendarPeriod
    Left = 352
    Top = 216
  end
  object qryCalendarDate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 432
    Top = 112
  end
  object qryForecastAndPolicy: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select l.locationCode'
      ',p.productcode,p.generic, p.ProductDescription'
      ',g.primarychild, i.UserChar1'
      
        ',i.StockingIndicator,i.ParetoCategory,i.Safetystock, i.LeadTime,' +
        ' '
      'i.StockOnHand, i.BackOrder,'
      'i.CostPrice, i.RetailPrice,'
      'i.ReviewPeriod, i.ReplenishmentCycle,  i.BinLevel, i.EffectiveRc'
      ', f.calendarno'
      
        ', f.forecast_0 AS f0  , f.forecast_1 AS f1  , f.forecast_2 AS f2' +
        '  , f.forecast_3 AS f3  , f.forecast_4 AS f4  , f.forecast_5 AS ' +
        'f5  , f.forecast_6 AS f6  , f.forecast_7 AS f7  , f.forecast_8 A' +
        'S f8  , f.forecast_9 AS f9  , f.forecast_10 AS f10  , f.forecast' +
        '_11 AS f11'
      
        ', bf.forecast_0 AS bf0, bf.forecast_1 AS bf1, bf.forecast_2 AS b' +
        'f2, bf.forecast_3 AS bf3, bf.forecast_4 AS bf4, bf.forecast_5 AS' +
        ' bf5, bf.forecast_6 AS bf6, bf.forecast_7 AS bf7, bf.forecast_8 ' +
        'AS bf8, bf.forecast_9 AS bf9, bf.forecast_10 AS bf10, bf.forecas' +
        't_11 AS bf11'
      
        ', gf.forecast_0 AS gf0, gf.forecast_1 AS gf1, gf.forecast_2 AS g' +
        'f2, gf.forecast_3 AS gf3, gf.forecast_4 AS gf4, gf.forecast_5 AS' +
        ' gf5, gf.forecast_6 AS gf6, gf.forecast_7 AS gf7, gf.forecast_8 ' +
        'AS gf8, gf.forecast_9 AS gf9, gf.forecast_10 AS gf10, gf.forecas' +
        't_11 AS gf11'
      
        ', co.customerorder_0 AS co0  , co.customerorder_1 AS co1  , co.c' +
        'ustomerorder_2 AS co2  , co.customerorder_3 AS co3  , co.custome' +
        'rorder_4 AS co4  , co.customerorder_5 AS co5  , co.customerorder' +
        '_6 AS co6  , co.customerorder_7 AS co7  , co.customerorder_8 AS ' +
        'co8  , co.customerorder_9 AS co9  , co.customerorder_10 AS co10 ' +
        ' , co.customerorder_11 AS co11'
      ',s.salesamount_0,'
      'gm1.GroupCode, gm1.Description as GroupMinor1Desc'
      
        'from item i left outer join itemforecast f on i.itemno = f.itemn' +
        'o and f.forecasttypeno = 1 and f.calendarno = :CALENDARNO'
      
        '            left outer join itemforecast bf on i.itemno = bf.ite' +
        'mno and bf.forecasttypeno = 2 and bf.calendarno = :CALENDARNO'
      
        '            left outer join itemforecast gf on i.itemno = gf.ite' +
        'mno and gf.forecasttypeno = 3 and gf.calendarno = :CALENDARNO'
      
        '            left outer join Product P on i.ProductNo = P.Product' +
        'No'
      
        '            left outer join Location L on i.LocationNo = L.Locat' +
        'ionNo'
      
        '            left outer join generic g on i.productno = g.childpr' +
        'oductno'
      '            left outer join itemorder co on i.itemno = co.itemno'
      '            left outer join itemsales s on i.itemno = s.itemno'
      
        '            left join groupminor1 gm1 on i.groupminor1 = gm1.Gro' +
        'upNo')
    Left = 368
    Top = 280
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CALENDARNO'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CALENDARNO'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CALENDARNO'
        ParamType = ptUnknown
      end>
    object qryForecastAndPolicyLOCATIONCODE: TIBStringField
      FieldName = 'LOCATIONCODE'
      Size = 10
    end
    object qryForecastAndPolicyPRODUCTCODE: TIBStringField
      FieldName = 'PRODUCTCODE'
      Size = 30
    end
    object qryForecastAndPolicyGENERIC: TIBStringField
      FieldName = 'GENERIC'
      Size = 1
    end
    object qryForecastAndPolicyPRIMARYCHILD: TIBStringField
      FieldName = 'PRIMARYCHILD'
      Size = 1
    end
    object qryForecastAndPolicySTOCKINGINDICATOR: TIBStringField
      FieldName = 'STOCKINGINDICATOR'
      Size = 1
    end
    object qryForecastAndPolicyPARETOCATEGORY: TIBStringField
      FieldName = 'PARETOCATEGORY'
      Size = 1
    end
    object qryForecastAndPolicySAFETYSTOCK: TFloatField
      FieldName = 'SAFETYSTOCK'
    end
    object qryForecastAndPolicyLEADTIME: TFloatField
      FieldName = 'LEADTIME'
    end
    object qryForecastAndPolicyREVIEWPERIOD: TFloatField
      FieldName = 'REVIEWPERIOD'
    end
    object qryForecastAndPolicyREPLENISHMENTCYCLE: TFloatField
      FieldName = 'REPLENISHMENTCYCLE'
    end
    object qryForecastAndPolicyBINLEVEL: TFloatField
      FieldName = 'BINLEVEL'
    end
    object qryForecastAndPolicyCALENDARNO: TIntegerField
      FieldName = 'CALENDARNO'
    end
    object qryForecastAndPolicyF0: TFloatField
      FieldName = 'F0'
    end
    object qryForecastAndPolicyF1: TFloatField
      FieldName = 'F1'
    end
    object qryForecastAndPolicyF2: TFloatField
      FieldName = 'F2'
    end
    object qryForecastAndPolicyF3: TFloatField
      FieldName = 'F3'
    end
    object qryForecastAndPolicyF4: TFloatField
      FieldName = 'F4'
    end
    object qryForecastAndPolicyF5: TFloatField
      FieldName = 'F5'
    end
    object qryForecastAndPolicyF6: TFloatField
      FieldName = 'F6'
    end
    object qryForecastAndPolicyF7: TFloatField
      FieldName = 'F7'
    end
    object qryForecastAndPolicyF8: TFloatField
      FieldName = 'F8'
    end
    object qryForecastAndPolicyF9: TFloatField
      FieldName = 'F9'
    end
    object qryForecastAndPolicyF10: TFloatField
      FieldName = 'F10'
    end
    object qryForecastAndPolicyF11: TFloatField
      FieldName = 'F11'
    end
    object qryForecastAndPolicyBF0: TFloatField
      FieldName = 'BF0'
    end
    object qryForecastAndPolicyBF1: TFloatField
      FieldName = 'BF1'
    end
    object qryForecastAndPolicyBF2: TFloatField
      FieldName = 'BF2'
    end
    object qryForecastAndPolicyBF3: TFloatField
      FieldName = 'BF3'
    end
    object qryForecastAndPolicyBF4: TFloatField
      FieldName = 'BF4'
    end
    object qryForecastAndPolicyBF5: TFloatField
      FieldName = 'BF5'
    end
    object qryForecastAndPolicyBF6: TFloatField
      FieldName = 'BF6'
    end
    object qryForecastAndPolicyBF7: TFloatField
      FieldName = 'BF7'
    end
    object qryForecastAndPolicyBF8: TFloatField
      FieldName = 'BF8'
    end
    object qryForecastAndPolicyBF9: TFloatField
      FieldName = 'BF9'
    end
    object qryForecastAndPolicyBF10: TFloatField
      FieldName = 'BF10'
    end
    object qryForecastAndPolicyBF11: TFloatField
      FieldName = 'BF11'
    end
    object qryForecastAndPolicyGF0: TFloatField
      FieldName = 'GF0'
    end
    object qryForecastAndPolicyGF1: TFloatField
      FieldName = 'GF1'
    end
    object qryForecastAndPolicyGF2: TFloatField
      FieldName = 'GF2'
    end
    object qryForecastAndPolicyGF3: TFloatField
      FieldName = 'GF3'
    end
    object qryForecastAndPolicyGF4: TFloatField
      FieldName = 'GF4'
    end
    object qryForecastAndPolicyGF5: TFloatField
      FieldName = 'GF5'
    end
    object qryForecastAndPolicyGF6: TFloatField
      FieldName = 'GF6'
    end
    object qryForecastAndPolicyGF7: TFloatField
      FieldName = 'GF7'
    end
    object qryForecastAndPolicyGF8: TFloatField
      FieldName = 'GF8'
    end
    object qryForecastAndPolicyGF9: TFloatField
      FieldName = 'GF9'
    end
    object qryForecastAndPolicyGF10: TFloatField
      FieldName = 'GF10'
    end
    object qryForecastAndPolicyGF11: TFloatField
      FieldName = 'GF11'
    end
    object qryForecastAndPolicyCO0: TFloatField
      FieldName = 'CO0'
    end
    object qryForecastAndPolicyCO1: TFloatField
      FieldName = 'CO1'
    end
    object qryForecastAndPolicyCO2: TFloatField
      FieldName = 'CO2'
    end
    object qryForecastAndPolicyCO3: TFloatField
      FieldName = 'CO3'
    end
    object qryForecastAndPolicyCO4: TFloatField
      FieldName = 'CO4'
    end
    object qryForecastAndPolicyCO5: TFloatField
      FieldName = 'CO5'
    end
    object qryForecastAndPolicyCO6: TFloatField
      FieldName = 'CO6'
    end
    object qryForecastAndPolicyCO7: TFloatField
      FieldName = 'CO7'
    end
    object qryForecastAndPolicyCO8: TFloatField
      FieldName = 'CO8'
    end
    object qryForecastAndPolicyCO9: TFloatField
      FieldName = 'CO9'
    end
    object qryForecastAndPolicyCO10: TFloatField
      FieldName = 'CO10'
    end
    object qryForecastAndPolicyCO11: TFloatField
      FieldName = 'CO11'
    end
    object qryForecastAndPolicySALESAMOUNT_0: TFloatField
      FieldName = 'SALESAMOUNT_0'
    end
    object qryForecastAndPolicySTOCKONHAND: TFloatField
      FieldName = 'STOCKONHAND'
      Origin = 'ITEM.STOCKONHAND'
    end
    object qryForecastAndPolicyBACKORDER: TFloatField
      FieldName = 'BACKORDER'
      Origin = 'ITEM.BACKORDER'
    end
    object qryForecastAndPolicyCOSTPRICE: TFloatField
      FieldName = 'COSTPRICE'
      Origin = 'ITEM.COSTPRICE'
    end
    object qryForecastAndPolicyRETAILPRICE: TFloatField
      FieldName = 'RETAILPRICE'
      Origin = 'ITEM.RETAILPRICE'
    end
    object qryForecastAndPolicyGROUPCODE: TIBStringField
      FieldName = 'GROUPCODE'
      Origin = 'GROUPMINOR1.GROUPCODE'
      Size = 4
    end
    object qryForecastAndPolicyPRODUCTDESCRIPTION: TIBStringField
      FieldName = 'PRODUCTDESCRIPTION'
      Origin = 'PRODUCT.PRODUCTDESCRIPTION'
      Size = 60
    end
    object qryForecastAndPolicyGROUPMINOR1DESC: TIBStringField
      FieldName = 'GROUPMINOR1DESC'
      Origin = 'GROUPMINOR1.DESCRIPTION'
      Size = 60
    end
    object qryForecastAndPolicyUSERCHAR1: TIBStringField
      FieldName = 'USERCHAR1'
      Origin = 'ITEM.USERCHAR1'
      FixedChar = True
      Size = 256
    end
    object qryForecastAndPolicyEFFECTIVERC: TFloatField
      FieldName = 'EFFECTIVERC'
      Origin = 'ITEM.EFFECTIVERC'
    end
  end
  object srcForecastAndPolicy: TDataSource
    DataSet = qryForecastAndPolicy
    Left = 368
    Top = 336
  end
  object qryGetCurrentPeriod: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      '  select TYPEOFINTEGER'
      '  from CONFIGURATION'
      '  where CONFIGURATIONNO = 100'
      ''
      ''
      '')
    Left = 344
    Top = 120
  end
  object qryCheckProcedure: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select * from rdb$procedures where'
      'RDB$PROCEDURE_NAME = :ProcName')
    Left = 576
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'ProcName'
        ParamType = ptUnknown
      end>
  end
  object qryInstallProcedure: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    Transaction = trnOptimiza
    Left = 576
    Top = 184
  end
  object qrySelectLocation: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select * from Location'
      'where 1=1'
      'Order by LocationCode')
    Left = 576
    Top = 40
  end
  object srcSelectLocation: TDataSource
    DataSet = qrySelectLocation
    Left = 576
    Top = 96
  end
  object qryLocationListCodes: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select * from Location'
      'where LocationCode in ("")')
    Left = 464
    Top = 192
  end
  object qryGetConfiguration: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'Select * from Configuration'
      '  where ConfigurationNo = :ConfigurationNo')
    Left = 472
    Top = 272
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ConfigurationNo'
        ParamType = ptUnknown
      end>
  end
  object ReadConfig: TIBSQL
    Database = dbOptimiza
    SQL.Strings = (
      
        'select DESCRIPTION, TYPEOFSTRING, TYPEOFINTEGER, TYPEOFFLOAT, TY' +
        'PEOFDATE,TYPEOFLongSTRING'
      'from CONFIGURATION                  '
      'where CONFIGURATIONNO = ?CONFIGURATIONNO')
    Transaction = trnOptimiza
    Left = 480
    Top = 336
  end
  object ReadConfigLoc: TIBSQL
    Database = dbOptimiza
    SQL.Strings = (
      
        'select  TYPEOFSTRING, TYPEOFINTEGER, TYPEOFFLOAT, TYPEOFDATE,TYP' +
        'EOFLongSTRING'
      'from Location_CONFIGURATION                  '
      'where LocationNo = ?LocationNo and'
      'CONFIGURATIONNO = ?CONFIGURATIONNO')
    Transaction = trnOptimiza
    Left = 576
    Top = 336
  end
  object qryCode: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      ''
      'SELECT SUPPLIERCODE CODE FROM SUPPLIER WHERE SUPPLIERNO = :NO'
      '')
    Left = 132
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NO'
        ParamType = ptUnknown
      end>
  end
end
