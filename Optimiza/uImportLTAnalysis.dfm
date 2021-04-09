object Form1: TForm1
  Left = 290
  Top = 130
  Width = 440
  Height = 244
  Caption = 'Import Lead Time Analysis'
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 198
    Width = 432
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 48
    Width = 320
    Height = 120
    DataSource = dmLTAnal.srcLTAnal
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 16
    Top = 16
    Width = 240
    Height = 25
    DataSource = dmLTAnal.srcLTAnal
    TabOrder = 2
  end
  object Button1: TButton
    Left = 344
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Import'
    TabOrder = 3
    OnClick = Button1Click
  end
end
