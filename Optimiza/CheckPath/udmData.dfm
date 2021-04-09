inherited dmData: TdmData
  object qrySched: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      
        'Select ss.SchedulerSetNo,ss.Description as SchedName,s.Descripti' +
        'on as SchedDesc,s.ExecutablePath,s.Executable from SchedulerSets' +
        ' ss'
      '  Left Join Schedule s on ss.SchedulerSetNo=s.SchedulerSetNo')
    Transaction = trnOptimiza
    Left = 136
    Top = 32
  end
end
