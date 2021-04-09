object frmExist: TfrmExist
  Left = 408
  Top = 306
  Width = 393
  Height = 185
  Caption = 'Record Exists'
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
    Left = 4
    Top = 79
    Width = 47
    Height = 13
    Caption = 'Old Name'
  end
  object Label2: TLabel
    Left = 4
    Top = 122
    Width = 53
    Height = 13
    Caption = 'New Name'
  end
  object BitBtn1: TBitBtn
    Left = 308
    Top = 77
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn3: TBitBtn
    Left = 308
    Top = 117
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object edtOld: TEdit
    Left = 60
    Top = 79
    Width = 235
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object edtNew: TEdit
    Left = 60
    Top = 119
    Width = 235
    Height = 21
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 57
    Align = alTop
    Caption = 'This Backup Set already exists. Please use a different name.'
    TabOrder = 4
  end
end
