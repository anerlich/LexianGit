object frmPolicy: TfrmPolicy
  Left = 279
  Top = 295
  Caption = 'Policy'
  ClientHeight = 272
  ClientWidth = 347
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
    Left = 48
    Top = 16
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 48
    Top = 40
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 51
    Top = 77
    Width = 50
    Height = 13
    Caption = 'Lead Time'
  end
  object Label4: TLabel
    Left = 48
    Top = 103
    Width = 99
    Height = 13
    Caption = 'Replenishment Cycle'
  end
  object Label5: TLabel
    Left = 48
    Top = 129
    Width = 69
    Height = 13
    Caption = 'Review Period'
  end
  object Label6: TLabel
    Left = 48
    Top = 156
    Width = 65
    Height = 13
    Caption = 'Service Level'
  end
  object Label7: TLabel
    Left = 47
    Top = 182
    Width = 61
    Height = 13
    Caption = 'Safety Stock'
  end
  object Label8: TLabel
    Left = 48
    Top = 210
    Width = 25
    Height = 13
    Caption = 'MOQ'
  end
  object Label9: TLabel
    Left = 47
    Top = 238
    Width = 70
    Height = 13
    Caption = 'Order Multiples'
  end
  object BitBtn1: TBitBtn
    Left = 245
    Top = 202
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtn2: TBitBtn
    Left = 245
    Top = 234
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object ExtEdit1: TExtEdit
    Left = 160
    Top = 71
    Width = 41
    Height = 21
    TabOrder = 2
    Text = '0'
    Kind = eekFloat
    Valid = valNone
    MaxValue = 12.000000000000000000
    FormatOnExit = False
    PlaneOnEnter = False
    ValidOnExit = False
  end
  object ExtEdit2: TExtEdit
    Left = 160
    Top = 98
    Width = 41
    Height = 21
    TabOrder = 3
    Text = '0'
    Kind = eekFloat
    Valid = valNone
    MaxValue = 12.000000000000000000
    FormatOnExit = False
    PlaneOnEnter = False
    ValidOnExit = False
  end
  object ExtEdit3: TExtEdit
    Left = 160
    Top = 125
    Width = 41
    Height = 21
    TabOrder = 4
    Text = '0'
    Kind = eekFloat
    Valid = valNone
    MaxValue = 12.000000000000000000
    FormatOnExit = False
    PlaneOnEnter = False
    ValidOnExit = False
  end
  object ExtEdit4: TExtEdit
    Left = 160
    Top = 152
    Width = 41
    Height = 21
    TabOrder = 5
    Text = '0'
    Kind = eekFloat
    Valid = valNone
    MaxValue = 12.000000000000000000
    FormatOnExit = False
    PlaneOnEnter = False
    ValidOnExit = False
  end
  object ExtEdit5: TExtEdit
    Left = 159
    Top = 178
    Width = 41
    Height = 21
    TabOrder = 6
    Text = '0'
    Kind = eekFloat
    Valid = valNone
    MaxValue = 12.000000000000000000
    FormatOnExit = False
    PlaneOnEnter = False
    ValidOnExit = False
  end
  object ExtEditMOQ: TExtEdit
    Left = 160
    Top = 206
    Width = 41
    Height = 21
    TabOrder = 7
    Text = '0'
    Kind = eekFloat
    Valid = valNone
    MaxValue = 12.000000000000000000
    FormatOnExit = False
    PlaneOnEnter = False
    ValidOnExit = False
  end
  object ExtEditORM: TExtEdit
    Left = 159
    Top = 234
    Width = 41
    Height = 21
    TabOrder = 8
    Text = '0'
    Kind = eekFloat
    Valid = valNone
    MaxValue = 12.000000000000000000
    FormatOnExit = False
    PlaneOnEnter = False
    ValidOnExit = False
  end
end
