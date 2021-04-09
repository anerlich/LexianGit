inherited dmData: TdmData
  OldCreateOrder = True
  Left = 438
  Top = 263
  inherited dbOptimiza: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Optimiza\Berlei\Database\BERLEI.GDB'
  end
  inherited trnOptimiza: TIBTransaction
    Active = True
  end
  object qryAllLocations: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Select * from Location'
      'where LocationNo > 0'
      ' Order by Description')
    Transaction = trnOptimiza
    Left = 96
    Top = 48
  end
  object qryLoc: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location'
      '  where LocationNo = :LocNo')
    UniDirectional = True
    Left = 96
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LocNo'
        ParamType = ptUnknown
      end>
  end
  object qryInstallProc: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'create procedure up_ModelFCError(LocNo Integer,'
      '                                 Increase Char(1),'
      '                                 Cap Char(1),'
      '                                 Perc Double Precision,'
      '                                 CapPerc Double Precision)'
      'as'
      'declare variable ItemNo Integer;'
      'declare variable FCError double precision;'
      'begin'
      '  for Select ItemNo,ForecastAccuracy from'
      '    Item where LocationNo = :LocNo'
      '    into :ItemNo,:FCError'
      '  do begin'
      '   '
      '   if (Increase = '#39'Y'#39') then'
      '   begin'
      '     FCError = FCError + (FcError * Perc / 100);'
      '   end'
      '   else'
      '   begin'
      '     FCError = FCError - (FcError * Perc / 100);'
      '   end'
      '   '
      '   if (Cap = '#39'Y'#39') then'
      '   begin'
      ''
      '     if (FCError > CapPerc) then'
      '     begin'
      '       FCError = CapPerc;'
      '     end'
      '   '
      '   end'
      ''
      '   if (FCError < 0) then FCError = 0;'
      '   '
      '   if (FCError > 100) then FCError = 100;'
      '   '
      '   Update Item Set ForecastAccuracy = :FCError'
      '     where ItemNo = :ItemNo;'
      '     '
      '  end'
      '  '
      'end')
    Transaction = trnOptimiza
    Left = 152
    Top = 232
  end
  object qryGetProc: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from rdb$procedures where'
      'RDB$PROCEDURE_NAME = "UP_MODELFCERROR"')
    UniDirectional = True
    Left = 104
    Top = 120
  end
  object qryCreateProc: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'create procedure up_ModelFCError(LocNo Integer,'
      '                                 Increase Char(1),'
      '                                 Cap Char(1),'
      '                                 Perc Double Precision,'
      '                                 CapPerc Double Precision)'
      'as'
      'declare variable ItemNo Integer;'
      'declare variable FCError double precision;'
      'begin'
      '  for Select ItemNo,ForecastAccuracy from'
      '    Item where LocationNo = :LocNo'
      '    into :ItemNo,:FCError'
      '  do begin'
      '   '
      '   if (Increase = '#39'Y'#39') then'
      '   begin'
      '     FCError = FCError + (FcError * Perc / 100);'
      '   end'
      '   else'
      '   begin'
      '     FCError = FCError - (FcError * Perc / 100);'
      '   end'
      '   '
      '   if (Cap = '#39'Y'#39') then'
      '   begin'
      ''
      '     if (FCError > CapPerc) then'
      '     begin'
      '       FCError = CapPerc;'
      '     end'
      '   '
      '   end'
      ''
      '   if (FCError < 0) then FCError = 0;'
      '   '
      ''
      '   Update Item Set ForecastAccuracy = :FCError'
      '     where ItemNo = :ItemNo;'
      '     '
      '  end'
      '  '
      'end')
    Transaction = trnOptimiza
    Left = 208
    Top = 128
  end
  object prcUpdate: TIBStoredProc
    Database = dbOptimiza
    Transaction = trnOptimiza
    StoredProcName = 'UP_MODELFCERROR'
    Left = 80
    Top = 280
    ParamData = <
      item
        DataType = ftInteger
        Name = 'LOCNO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'INCREASE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CAP'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PERC'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'CAPPERC'
        ParamType = ptInput
      end>
  end
end
