object frmDBconnection: TfrmDBconnection
  Left = 401
  Top = 229
  Width = 566
  Height = 198
  Caption = 'Optimiza Database Connection Setup'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 3
    Top = 8
    Width = 72
    Height = 13
    Caption = 'Network Folder'
  end
  object Label2: TLabel
    Left = 6
    Top = 37
    Width = 46
    Height = 13
    Caption = 'Database'
  end
  object Label3: TLabel
    Left = 84
    Top = 147
    Width = 3
    Height = 13
  end
  object Label4: TLabel
    Left = 7
    Top = 65
    Width = 51
    Height = 13
    Caption = 'IP Address'
  end
  object Edit1: TEdit
    Left = 84
    Top = 5
    Width = 185
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 460
    Top = 123
    Width = 75
    Height = 25
    Caption = 'Run Setup'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 84
    Top = 35
    Width = 449
    Height = 21
    TabOrder = 2
  end
  object Animate1: TAnimate
    Left = 84
    Top = 91
    Width = 80
    Height = 50
    Active = False
    CommonAVI = aviFindFolder
    StopFrame = 29
    Visible = False
  end
  object Edit3: TEdit
    Left = 84
    Top = 59
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object Button2: TButton
    Left = 208
    Top = 59
    Width = 193
    Height = 25
    Caption = 'Get IP Address from Network Folder'
    TabOrder = 5
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.gdb'
    Filter = 'Optimiza Database|*.gdb'
    Left = 456
    Top = 16
  end
end
