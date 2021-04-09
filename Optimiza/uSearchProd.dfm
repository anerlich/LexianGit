object frmSearch: TfrmSearch
  Left = 440
  Top = 203
  Width = 368
  Height = 365
  Caption = 'Search'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 48
    Width = 37
    Height = 13
    Caption = 'Search:'
  end
  object Edit1: TEdit
    Left = 120
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 248
    Top = 40
    Width = 49
    Height = 25
    Caption = 'Find'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 56
    Top = 104
    Width = 241
    Height = 153
    DataSource = dmUpdateSpecial.srcSearchProd
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 56
    Top = 72
    Width = 224
    Height = 25
    DataSource = dmUpdateSpecial.srcSearchProd
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
    TabOrder = 3
  end
  object BitBtn1: TBitBtn
    Left = 224
    Top = 296
    Width = 75
    Height = 25
    TabOrder = 4
    OnClick = BitBtn1Click
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 144
    Top = 296
    Width = 75
    Height = 25
    Caption = '&Add'
    TabOrder = 5
    Kind = bkYes
  end
end
