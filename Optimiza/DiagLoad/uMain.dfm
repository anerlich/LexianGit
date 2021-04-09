object Form1: TForm1
  Left = 249
  Top = 114
  Width = 952
  Height = 632
  Caption = 'Load Diagnostic dump'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 113
    Width = 68
    Height = 13
    Caption = 'Setup SQL file'
  end
  object Label2: TLabel
    Left = 10
    Top = 59
    Width = 77
    Height = 13
    Caption = 'Product SQL file'
  end
  object Label3: TLabel
    Left = 16
    Top = 237
    Width = 107
    Height = 13
    Caption = 'Current SQL command'
  end
  object Label4: TLabel
    Left = 360
    Top = 5
    Width = 60
    Height = 16
    Caption = 'Database'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 10
    Top = 10
    Width = 110
    Height = 13
    Caption = 'Script for user fields etc'
  end
  object edtSetup: TEdit
    Left = 10
    Top = 129
    Width = 425
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 442
    Top = 129
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 441
    Top = 202
    Width = 75
    Height = 25
    Caption = 'Execute SQL'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 10
    Top = 257
    Width = 673
    Height = 313
    TabOrder = 3
    WordWrap = False
  end
  object edtProduct: TEdit
    Left = 10
    Top = 75
    Width = 425
    Height = 21
    TabOrder = 4
  end
  object Button5: TButton
    Left = 442
    Top = 75
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 5
    OnClick = Button5Click
  end
  object RadioGroup1: TRadioGroup
    Left = 10
    Top = 159
    Width = 337
    Height = 65
    Caption = 'Is this a Blank Database'
    ItemIndex = 0
    Items.Strings = (
      'Yes'
      'No')
    TabOrder = 6
  end
  object GroupBox1: TGroupBox
    Left = 696
    Top = 294
    Width = 208
    Height = 179
    Caption = 'Debugging Only'
    TabOrder = 7
    object Button3: TButton
      Left = 16
      Top = 141
      Width = 75
      Height = 25
      Caption = 'Read Line'
      Enabled = False
      TabOrder = 0
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 117
      Top = 141
      Width = 75
      Height = 25
      Caption = 'Execute Line'
      Enabled = False
      TabOrder = 1
      OnClick = Button4Click
    end
    object RadioGroup2: TRadioGroup
      Left = 16
      Top = 24
      Width = 176
      Height = 73
      Caption = 'Debug'
      ItemIndex = 0
      Items.Strings = (
        'Setup SQL'
        'Product SQL')
      TabOrder = 2
    end
    object Button6: TButton
      Left = 18
      Top = 109
      Width = 75
      Height = 25
      Caption = 'Open File'
      TabOrder = 3
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 117
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Close File'
      Enabled = False
      TabOrder = 4
      OnClick = Button7Click
    end
  end
  object edtUserScript: TEdit
    Left = 10
    Top = 26
    Width = 425
    Height = 21
    TabOrder = 8
    Text = 'O:\Optimiza\DiagLoad\Data\pre_Script.sql'
  end
  object Button8: TButton
    Left = 442
    Top = 26
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 9
    OnClick = Button8Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.sql'
    Filter = '*.sql|*.sql|*.txt|*.txt|All Files|*.*'
    Left = 616
    Top = 120
  end
end
