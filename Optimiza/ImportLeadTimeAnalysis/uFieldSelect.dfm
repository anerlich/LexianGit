object frmFieldSelect: TfrmFieldSelect
  Left = 519
  Top = 263
  Width = 527
  Height = 243
  Caption = 'Select Field'
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
    Left = 48
    Top = 64
    Width = 116
    Height = 13
    Caption = 'Lead Time Analysis Field'
  end
  object cmbFieldName: TComboBox
    Left = 48
    Top = 104
    Width = 409
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 296
    Top = 160
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 400
    Top = 160
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object edtFieldName: TEdit
    Left = 176
    Top = 61
    Width = 275
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
end
