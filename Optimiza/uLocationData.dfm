object frmLocationData: TfrmLocationData
  Left = 273
  Top = 210
  Width = 610
  Height = 328
  Caption = 'Location Data'
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
    Left = 93
    Top = 8
    Width = 416
    Height = 20
    Caption = 'Select the most appropriate data to use from the following :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 409
    Top = 265
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 504
    Top = 265
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 64
    Width = 569
    Height = 185
    DataSource = dmaddNewProduct.srcSearchItem
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 189
    Top = 38
    Width = 224
    Height = 25
    DataSource = dmaddNewProduct.srcSearchItem
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
    TabOrder = 3
  end
end
