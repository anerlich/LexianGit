object OptimizaServiceAlert: TOptimizaServiceAlert
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'OptimizaServiceAlert'
  Interactive = True
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  OnStop = ServiceStop
  Left = 1450
  Top = 200
  Height = 271
  Width = 390
  object EventLog: TafpEventLog
    ApplicationName = 'OptimizaAlert'
    RegisterApplication = True
    IncludeUserName = True
    EventID = 0
    EventCategory = 0
    Left = 116
    Top = 28
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 200
    Top = 32
  end
end
