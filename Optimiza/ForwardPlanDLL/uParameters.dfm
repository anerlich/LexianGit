object frmParameters: TfrmParameters
  Left = 516
  Top = 260
  Width = 593
  Height = 294
  Caption = 'Parameters'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 136
    Width = 72
    Height = 13
    Caption = 'Location Code:'
  end
  object Label2: TLabel
    Left = 40
    Top = 184
    Width = 85
    Height = 13
    Caption = 'Output File Name:'
  end
  object RadioGroup1: TRadioGroup
    Left = 32
    Top = 16
    Width = 185
    Height = 97
    Caption = 'Recommended Order Type'
    Items.Strings = (
      'Customer Order'
      'Other Demand'
      'Standard')
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 128
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 252
    Top = 135
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 128
    Top = 180
    Width = 329
    Height = 21
    TabOrder = 3
  end
  object Button2: TButton
    Left = 456
    Top = 178
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 384
    Top = 224
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 480
    Top = 224
    Width = 75
    Height = 25
    TabOrder = 6
    OnClick = BitBtn2Click
    Kind = bkOK
  end
  object chkIgnore: TCheckBox
    Left = 264
    Top = 21
    Width = 177
    Height = 17
    Caption = 'Ignore MOQ and Order Multiples'
    TabOrder = 7
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.csv'
    Filter = 'CSV Files|*.csv|Text Files|*.txt|All Files|*.*'
    Left = 320
    Top = 216
  end
end
