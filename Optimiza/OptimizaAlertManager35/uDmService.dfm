inherited dmOptimiza2: TdmOptimiza2
  object evtOptimiza: TIBEvents
    AutoRegister = True
    Database = dbOptimiza
    Events.Strings = (
      'SCHEDULER_FAILED')
    Registered = False
    OnEventAlert = evtOptimizaEventAlert
    Left = 136
    Top = 72
  end
end
