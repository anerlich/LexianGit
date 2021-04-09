object frmFrzForecast: TfrmFrzForecast
  Left = 333
  Top = 183
  Width = 522
  Height = 483
  Caption = 'Update Forecast Frozen Indicators'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 64
    Top = 104
    Width = 281
    Height = 313
    DataSource = dmFrozenForecast.srcFrzFile
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 72
    Top = 64
    Width = 240
    Height = 25
    DataSource = dmFrozenForecast.srcFrzFile
    TabOrder = 1
  end
  object Button1: TButton
    Left = 392
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Run Update'
    TabOrder = 2
    OnClick = Button1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 437
    Width = 514
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
end
