object frmCopySaleAndFC: TfrmCopySaleAndFC
  Left = 237
  Top = 107
  Width = 504
  Height = 315
  Caption = 'Copy Sales & Frozen Forecast'
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
  object Label1: TLabel
    Left = 75
    Top = 14
    Width = 333
    Height = 20
    Caption = 'Add Sales and Frozen Forecast Numbers from:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 235
    Top = 98
    Width = 14
    Height = 20
    Caption = 'to'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 269
    Width = 496
    Height = 19
    Panels = <
      item
        Text = 'Database'
        Width = 52
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object BitBtn1: TBitBtn
    Left = 120
    Top = 224
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 288
    Top = 224
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 73
    Top = 56
    Width = 337
    Height = 21
    KeyField = 'locationcode'
    ListField = 'description;LocationCode'
    ListSource = dmCopySaleAndFC.srcFromLoc
    TabOrder = 2
  end
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 74
    Top = 140
    Width = 337
    Height = 21
    Hint = 'description;LocationCode'
    KeyField = 'locationcode'
    ListField = 'description;LocationCode'
    ListSource = dmCopySaleAndFC.srcToLoc
    TabOrder = 3
  end
  object BitBtn3: TBitBtn
    Left = 400
    Top = 224
    Width = 75
    Height = 25
    Caption = 'BitBtn3'
    TabOrder = 5
    OnClick = BitBtn3Click
  end
end
