object frmInterval: TfrmInterval
  Left = 364
  Top = 203
  Width = 399
  Height = 158
  Caption = 'Time Interval'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 54
    Top = 35
    Width = 103
    Height = 13
    Caption = 'Perform checks every'
  end
  object Label6: TLabel
    Left = 200
    Top = 35
    Width = 37
    Height = 13
    Caption = 'Minutes'
  end
  object edtInterval: TMaskEdit
    Left = 164
    Top = 32
    Width = 22
    Height = 21
    EditMask = '99;0; '
    MaxLength = 2
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 192
    Top = 96
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 296
    Top = 96
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
