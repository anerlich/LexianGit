object frmAndOr: TfrmAndOr
  Left = 630
  Top = 238
  Width = 240
  Height = 167
  Caption = 'Select Operation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 55
    Top = 8
    Width = 122
    Height = 73
    Caption = 'Select Operation'
    ItemIndex = 0
    Items.Strings = (
      'AND'
      'OR')
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 35
    Top = 104
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 123
    Top = 104
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
