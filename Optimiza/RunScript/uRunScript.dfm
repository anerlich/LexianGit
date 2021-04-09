object frmRunScript: TfrmRunScript
  Left = 280
  Top = 180
  Width = 696
  Height = 480
  Caption = 'Run Scripts'
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
    Left = 34
    Top = 36
    Width = 59
    Height = 13
    Caption = 'Script Folder'
  end
  object Label2: TLabel
    Left = 29
    Top = 66
    Width = 93
    Height = 13
    Caption = 'Last Script Number:'
  end
  object Label3: TLabel
    Left = 45
    Top = 126
    Width = 34
    Height = 13
    Caption = 'Current'
  end
  object CustomFileOpen1: TCustomFileOpen
    Left = 128
    Top = 31
    Width = 425
    Height = 24
    DefaultExt = '*.sql'
    Filter = 'SQL Files(*.sql)|*.sql'
    FilterIndex = 1
    Options = [ofHideReadOnly, ofEnableSizing]
  end
  object DBEdit1: TDBEdit
    Left = 128
    Top = 63
    Width = 121
    Height = 21
    Hint = 'LastScript'
    DataField = 'LastScript'
    DataSource = dmRunScript.srcLastScript
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 434
    Width = 688
    Height = 19
    Panels = <
      item
        Text = 'Database'
        Width = 55
      end
      item
        Width = 50
      end>
    SimplePanel = False
    OnClick = StatusBar1Click
  end
  object Memo1: TMemo
    Left = 32
    Top = 152
    Width = 417
    Height = 209
    Lines.Strings = (
      '')
    TabOrder = 3
  end
  object Button1: TButton
    Left = 256
    Top = 384
    Width = 129
    Height = 25
    Caption = 'Run All Scripts'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 97
    Top = 120
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 5
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 240
    Top = 120
    Width = 425
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object Button2: TButton
    Left = 480
    Top = 304
    Width = 153
    Height = 25
    Caption = 'Load Next script'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 480
    Top = 336
    Width = 153
    Height = 25
    Caption = 'Run current Script'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Edit3: TEdit
    Left = 464
    Top = 82
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '1000'
  end
  object Button4: TButton
    Left = 336
    Top = 80
    Width = 123
    Height = 25
    Caption = 'Update Script No With:'
    TabOrder = 10
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 480
    Top = 272
    Width = 153
    Height = 25
    Caption = 'Load Current script'
    TabOrder = 11
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 480
    Top = 240
    Width = 153
    Height = 25
    Caption = 'Load Previous script'
    TabOrder = 12
    OnClick = Button6Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.gdb'
    Filter = 'Interbase (*.gdb)|*.gdb'
    Left = 584
    Top = 144
  end
end
