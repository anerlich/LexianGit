object frmValidateLocs: TfrmValidateLocs
  Left = 273
  Top = 167
  Width = 555
  Height = 296
  Caption = 'Product List'
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
    Left = 43
    Top = 8
    Width = 460
    Height = 20
    Caption = 'The following products already exist in the location shown'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 43
    Top = 32
    Width = 419
    Height = 20
    Caption = 'Please correct this on the Location Selection screen'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 236
    Top = 232
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object DBGrid1: TDBGrid
    Left = 45
    Top = 96
    Width = 457
    Height = 120
    DataSource = dmaddNewProduct.srcValidateLocs
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 155
    Top = 56
    Width = 240
    Height = 25
    DataSource = dmaddNewProduct.srcValidateLocs
    TabOrder = 2
  end
end
