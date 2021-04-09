object Form1: TForm1
  Left = 296
  Top = 137
  Width = 696
  Height = 480
  Caption = 'Report Criteria to Run in Batch Mode'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 434
    Width = 688
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 5
    Width = 273
    Height = 65
    Caption = 'Printer'
    TabOrder = 1
    object ComboBox1: TComboBox
      Left = 16
      Top = 28
      Width = 241
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'ComboBox1'
    end
  end
  object BitBtn1: TBitBtn
    Left = 611
    Top = 347
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 608
    Top = 379
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object Edit1: TEdit
    Left = 8
    Top = 409
    Width = 673
    Height = 21
    TabOrder = 4
  end
  object GroupBox2: TGroupBox
    Left = 342
    Top = 5
    Width = 273
    Height = 65
    Caption = 'User'
    TabOrder = 5
    object ComboBox2: TComboBox
      Left = 16
      Top = 28
      Width = 241
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'ComboBox2'
    end
  end
  object GroupBox3: TGroupBox
    Left = 24
    Top = 315
    Width = 529
    Height = 89
    Caption = 'Report'
    TabOrder = 6
    object Label3: TLabel
      Left = 16
      Top = 21
      Width = 63
      Height = 13
      Caption = 'Report Name'
    end
    object Label4: TLabel
      Left = 272
      Top = 21
      Width = 75
      Height = 13
      Caption = 'Template Name'
    end
    object ComboBox3: TComboBox
      Left = 16
      Top = 43
      Width = 241
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'ComboBox3'
      OnChange = ComboBox3Change
    end
    object ComboBox4: TComboBox
      Left = 272
      Top = 43
      Width = 241
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'ComboBox4'
    end
  end
  object GroupBox4: TGroupBox
    Left = 24
    Top = 79
    Width = 593
    Height = 225
    Caption = 'Locations'
    TabOrder = 7
    object Label1: TLabel
      Left = 71
      Top = 17
      Width = 92
      Height = 13
      Caption = 'Available Locations'
    end
    object Label2: TLabel
      Left = 351
      Top = 17
      Width = 91
      Height = 13
      Caption = 'Selected Locations'
    end
    object ListBox3: TListBox
      Left = 16
      Top = 134
      Width = 73
      Height = 96
      ItemHeight = 13
      TabOrder = 0
      Visible = False
    end
    object ListBox1: TListBox
      Left = 15
      Top = 39
      Width = 242
      Height = 169
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 1
    end
    object Button1: TButton
      Left = 262
      Top = 39
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 262
      Top = 87
      Width = 25
      Height = 25
      Caption = '>>'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 262
      Top = 135
      Width = 25
      Height = 25
      Caption = '<<'
      TabOrder = 4
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 262
      Top = 183
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 5
      OnClick = Button4Click
    end
    object ListBox2: TListBox
      Left = 291
      Top = 39
      Width = 242
      Height = 169
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 6
    end
    object ListBox4: TListBox
      Left = 443
      Top = 129
      Width = 89
      Height = 97
      ItemHeight = 13
      TabOrder = 7
      Visible = False
    end
    object Button5: TButton
      Left = 540
      Top = 65
      Width = 42
      Height = 25
      Caption = 'Up'
      TabOrder = 8
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 540
      Top = 151
      Width = 42
      Height = 25
      Caption = 'Down'
      TabOrder = 9
      OnClick = Button6Click
    end
  end
end
