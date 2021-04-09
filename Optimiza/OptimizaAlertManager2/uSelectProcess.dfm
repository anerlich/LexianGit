object frmSelectProcess: TfrmSelectProcess
  Left = 525
  Top = 271
  Width = 326
  Height = 211
  Caption = 'Select Process'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 120
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 208
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 40
    Top = 48
    Width = 209
    Height = 21
    Hint = 'Description'
    KeyField = 'Description'
    ListField = 'Description'
    ListFieldIndex = 1
    ListSource = dmData.srcSchedule
    TabOrder = 2
  end
end
