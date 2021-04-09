object frmSetAppend: TfrmSetAppend
  Left = 653
  Top = 250
  Width = 429
  Height = 257
  Caption = 'Type of Import'
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
  object grpType: TRadioGroup
    Left = 22
    Top = 16
    Width = 385
    Height = 161
    ItemIndex = 0
    Items.Strings = (
      'Replace (Clears LT Analysis Table)'
      'Append All Data'
      'Append Only Data From Last Import Date to Stock Download Date'
      'Append Only Data From Last Import and Update Download Date')
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 240
    Top = 191
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 336
    Top = 191
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
end
