inherited dmOptimiza2: TdmOptimiza2
  OldCreateOrder = True
  Left = 291
  Top = 182
  Height = 479
  Width = 741
  inherited dbOptimiza: TIBDatabase
    Connected = False
    DatabaseName = 'D:\Program Files\Execulink\Optimiza\Lexian\Database\Lexian.gdb'
    TraceFlags = [tfQPrepare, tfQExecute, tfQFetch, tfError, tfStmt, tfConnect, tfTransact, tfBlob, tfService, tfMisc]
  end
  inherited trnOptimiza: TIBTransaction
    Active = False
  end
  object qryUpdate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'alter PROCEDURE MyProc returns (a integer)'
      'AS '
      'declare variable b integer;'
      'begin '
      'Select TypeOfInteger from Configuration where '
      'Configurationno = 100 into :b; '
      ''
      ' b=1;'
      ' a=5;'
      'end')
    Left = 120
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'b'
        ParamType = ptUnknown
      end>
  end
  object IBSQLMonitor1: TIBSQLMonitor
    TraceFlags = [tfQPrepare, tfQExecute, tfQFetch, tfError, tfStmt, tfConnect, tfTransact, tfBlob, tfService, tfMisc]
    Left = 96
    Top = 200
  end
  object IBSQL1: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'alter PROCEDURE MyProc returns (a integer)'
      'AS '
      'declare variable b integer;'
      'begin '
      'Select TypeOfInteger from Configuration where '
      'Configurationno = 100 into :b; '
      ''
      ' b=1;'
      ' a=5;'
      'end')
    Transaction = IBTransaction1
    Left = 40
    Top = 48
  end
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = dbOptimiza
    AutoStopAction = saNone
    Left = 144
    Top = 40
  end
end
