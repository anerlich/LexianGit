inherited dmData: TdmData
  OldCreateOrder = True
  Left = 464
  Top = 274
  inherited dbOptimiza: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Optimiza\Holeproof\Database\HJ.GDB'
  end
  object tblSCHEDULERSETS: TIBTable
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'SCHEDULERSETS'
    Left = 104
    Top = 56
  end
  object qryDelete: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Delete from SCHEDULERSETS')
    Left = 104
    Top = 144
  end
  object tblSCHEDULE: TIBTable
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'SCHEDULE'
    Left = 112
    Top = 232
  end
  object qrySeqNo: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'Select Gen_id(SchedulerSets_SeqNo,:SeqNo) as SeqNo from Configur' +
        'ation'
      '  where ConfigurationNo = 100')
    Left = 208
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SeqNo'
        ParamType = ptUnknown
      end>
  end
  object qryMaxSeqNo: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select Max() from')
    Left = 192
    Top = 296
  end
end
