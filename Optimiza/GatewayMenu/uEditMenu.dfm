object frmEditMenu: TfrmEditMenu
  Left = 479
  Top = 232
  Width = 397
  Height = 175
  Caption = 'Edit Menu'
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
    Left = 10
    Top = 10
    Width = 66
    Height = 13
    Caption = 'Menu Caption'
  end
  object Label2: TLabel
    Left = 10
    Top = 41
    Width = 44
    Height = 13
    Caption = 'Comment'
  end
  object Label3: TLabel
    Left = 10
    Top = 73
    Width = 19
    Height = 13
    Caption = 'Tag'
  end
  object Label4: TLabel
    Left = 160
    Top = 72
    Width = 76
    Height = 13
    Caption = '999 = Reserved'
  end
  object Edit1: TEdit
    Left = 82
    Top = 7
    Width = 289
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 82
    Top = 38
    Width = 289
    Height = 21
    TabOrder = 1
  end
  object SpinEdit1: TSpinEdit
    Left = 82
    Top = 69
    Width = 65
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object BitBtn1: TBitBtn
    Left = 186
    Top = 103
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 274
    Top = 103
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkCancel
  end
end
