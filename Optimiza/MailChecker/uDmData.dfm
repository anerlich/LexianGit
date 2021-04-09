object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 427
  Top = 254
  Height = 440
  Width = 677
  object dbMain: TIBDatabase
    DatabaseName = 
      '127.0.0.1:C:\Clients\Programs\Optimiza\MailChecker\MailChecker.g' +
      'db'
    Params.Strings = (
      'USER "SYSDBA"'
      'PASSWORD "masterkey"'
      'PAGE_SIZE 4096'
      'user_name=SYSDBA')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 336
    Top = 64
  end
  object trnMain: TIBTransaction
    Active = False
    DefaultDatabase = dbMain
    AutoStopAction = saNone
    Left = 184
    Top = 48
  end
  object srcMailTypes: TDataSource
    DataSet = qryMailTypes
    Left = 192
    Top = 168
  end
  object srcCustomer: TDataSource
    DataSet = qryCustomer
    Left = 128
    Top = 168
  end
  object qryCustomer: TIBQuery
    Database = dbMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from CUSTOMER')
    Left = 120
    Top = 120
  end
  object qryMailTypes: TIBQuery
    Database = dbMain
    Transaction = trnMain
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from MAILTYPES')
    Left = 216
    Top = 120
  end
end
