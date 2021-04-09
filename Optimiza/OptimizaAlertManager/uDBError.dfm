object frmDBError: TfrmDBError
  Left = 414
  Top = 210
  Width = 309
  Height = 146
  Caption = 'Error'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 22
    Top = 20
    Width = 258
    Height = 63
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'The Scheduler has FAILED, please refer to the log file for the a' +
      'ppropriate error message'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object BitBtn1: TBitBtn
    Left = 121
    Top = 90
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object EventLog: TafpEventLog
    ApplicationName = 'OptimizaAlert'
    RegisterApplication = True
    IncludeUserName = False
    EventType = etError
    EventID = 1004
    EventCategory = 0
    Left = 2
  end
end
