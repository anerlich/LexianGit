object frmExecuteFile: TfrmExecuteFile
  Left = 656
  Top = 370
  Width = 380
  Height = 161
  Caption = 'Execute File'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 55
    Width = 118
    Height = 13
    Caption = 'Timer Set To (Seconds) :'
  end
  object Button1: TButton
    Left = 256
    Top = 49
    Width = 89
    Height = 25
    Caption = 'Execute File...'
    TabOrder = 0
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.exe'
    Filter = 
      'Application Files (*.exe, *.bat)|*.exe;*.bat|Executables (*.exe)' +
      '|*.exe|Batch Files (*.bat)|*.bat|All Files (*.*)|*.*'
    Left = 106
    Top = 2
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = Timer1Timer
    Left = 176
  end
end
