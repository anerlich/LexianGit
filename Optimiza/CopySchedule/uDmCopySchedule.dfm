inherited dmCopySchedule: TdmCopySchedule
  OldCreateOrder = True
  object qryAllLocations: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select LocationCode, Description From Location'
      'Order by Description')
    Left = 24
    Top = 112
  end
  object srcAllLocations: TDataSource
    DataSet = qryAllLocations
    Left = 24
    Top = 56
  end
  object qrySuppliers: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select SupplierCode, SupplierName from Supplier'
      'Order By SupplierCode')
    Left = 112
    Top = 112
  end
  object srcsuppliers: TDataSource
    DataSet = qrySuppliers
    Left = 112
    Top = 56
  end
  object qryScheduleList: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from SchedulerSets order by description')
    Left = 88
    Top = 184
  end
  object qryTaskList: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Schedule'
      'where schedulerSetNo = :SchedulerSetNo'
      'order by ScheduleSequenceNo')
    Left = 40
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SchedulerSetNo'
        ParamType = ptUnknown
      end>
  end
  object qryTask: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT '
      '  SCHEDULENO,'
      '  SCHEDULERSETNO,'
      '  SCHEDULESEQUENCENO,'
      '  DESCRIPTION,'
      '  EXECUTABLEPATH,'
      '  EXECUTABLE,'
      '  TASKACTIVE,'
      '  WAITTOFINISH,'
      '  EXECUTABLEPARAMS'
      'FROM '
      '  SCHEDULE '
      'where schedulerSetNo = :SchedulerSetNo'
      'and   SCHEDULESEQUENCENO =  :SCHEDULESEQUENCENO '
      '')
    Left = 104
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SchedulerSetNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SCHEDULESEQUENCENO'
        ParamType = ptUnknown
      end>
  end
  object qryTaskMove: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'EXECUTE PROCEDURE UP_TASK_MOVE( :SCHEDULERSETNO, :SCHEDULESEQUEN' +
        'CENO, :TOCOPY);'
      '')
    Left = 40
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SchedulerSetNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SCHEDULESEQUENCENO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TOCOPY'
        ParamType = ptUnknown
      end>
  end
  object qryTaskInsert: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '     Insert Into Schedule (SCHEDULENO,'
      '                           SCHEDULERSETNO,'
      '                           SCHEDULESEQUENCENO,'
      '                           DESCRIPTION,'
      '                           EXECUTABLEPATH,'
      '                           EXECUTABLE,'
      '                           TASKACTIVE,'
      '                           WAITTOFINISH,'
      '                           EXECUTABLEPARAMS)'
      '                 Values (Gen_Id(SCHEDULER_Seqno,1),'
      '                         :SCHEDULERSETNO,'
      '                         :SCHEDULESEQUENCENO,'
      '                         :DESCRIPTION,'
      '                         :EXECUTABLEPATH,'
      '                         :EXECUTABLE,'
      '                         :TASKACTIVE,'
      '                         :WAITTOFINISH,'
      '                         :EXECUTABLEPARAMS);'
      '')
    Left = 120
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SCHEDULERSETNO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SCHEDULESEQUENCENO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DESCRIPTION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EXECUTABLEPATH'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EXECUTABLE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TASKACTIVE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WAITTOFINISH'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EXECUTABLEPARAMS'
        ParamType = ptUnknown
      end>
  end
end
