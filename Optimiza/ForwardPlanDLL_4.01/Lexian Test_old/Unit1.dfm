object Form1: TForm1
  Left = 319
  Top = 217
  Width = 952
  Height = 656
  Caption = 'Lexian Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 97
    Width = 51
    Height = 13
    Caption = 'Output File'
  end
  object Label2: TLabel
    Left = 43
    Top = 17
    Width = 41
    Height = 13
    Caption = 'Location'
  end
  object Edit1: TEdit
    Left = 40
    Top = 121
    Width = 393
    Height = 21
    TabOrder = 0
    Text = 'test.csv'
  end
  object Button1: TButton
    Left = 440
    Top = 121
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 424
    Top = 152
    Width = 161
    Height = 25
    Caption = 'Generate Output'
    TabOrder = 2
    OnClick = Button2Click
  end
  object DBEdit1: TDBEdit
    Left = 40
    Top = 36
    Width = 377
    Height = 21
    DataField = 'DESCRIPTION'
    DataSource = dmMainDLL.srcSelectLocation
    TabOrder = 3
  end
  object DBNavigator1: TDBNavigator
    Left = 424
    Top = 36
    Width = 112
    Height = 21
    DataSource = dmMainDLL.srcSelectLocation
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
    TabOrder = 4
  end
  object SaveDialog1: TSaveDialog
    Filter = '*.txt|*.txt|*.csv|*.csv|*.*|*.*'
    Left = 504
    Top = 80
  end
end
