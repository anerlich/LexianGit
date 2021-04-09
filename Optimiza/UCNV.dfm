object frmConvertDBF: TfrmConvertDBF
  Left = 237
  Top = 107
  Width = 483
  Height = 369
  Caption = 'Conversion to DBF File'
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 323
    Width = 475
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 80
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 170
    Width = 475
    Height = 153
    Align = alBottom
    DataSource = srcDBF
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 475
    Height = 137
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 5
      Top = 17
      Width = 134
      Height = 13
      Caption = 'Format File Name and Path :'
    end
    object Label2: TLabel
      Left = 90
      Top = 44
      Width = 49
      Height = 13
      Caption = 'ASCII File:'
    end
    object Label3: TLabel
      Left = 93
      Top = 71
      Width = 46
      Height = 13
      Caption = 'DBF File :'
    end
    object Label4: TLabel
      Left = 71
      Top = 100
      Width = 68
      Height = 13
      Caption = 'New Csv File :'
    end
    object Edit1: TEdit
      Left = 149
      Top = 13
      Width = 238
      Height = 21
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 149
      Top = 40
      Width = 238
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 149
      Top = 68
      Width = 238
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object Edit4: TEdit
      Left = 149
      Top = 97
      Width = 238
      Height = 21
      TabOrder = 3
    end
    object Button1: TButton
      Left = 396
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Browse ...'
      TabOrder = 4
      OnClick = Button1Click
    end
    object BitBtn2: TBitBtn
      Left = 396
      Top = 54
      Width = 75
      Height = 25
      TabOrder = 5
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object BitBtn1: TBitBtn
      Left = 396
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Convert'
      TabOrder = 6
      OnClick = BitBtn1Click
      Kind = bkOK
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 137
    Width = 475
    Height = 33
    Align = alClient
    TabOrder = 3
    object DBNavigator1: TDBNavigator
      Left = 5
      Top = 4
      Width = 240
      Height = 25
      DataSource = srcDBF
      TabOrder = 0
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 368
    Top = 114
  end
  object tblDBF: TTable
    Left = 288
    Top = 106
  end
  object srcDBF: TDataSource
    DataSet = tblDBF
    Left = 336
    Top = 114
  end
end
