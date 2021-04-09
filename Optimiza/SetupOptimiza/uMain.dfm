object frmMain: TfrmMain
  Left = 300
  Top = 127
  Width = 952
  Height = 656
  Caption = 'Setup Optimiza Standards'
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
    Left = 368
    Top = 38
    Width = 44
    Height = 13
    Caption = 'Company'
  end
  object Label2: TLabel
    Left = 364
    Top = 75
    Width = 57
    Height = 13
    Caption = 'Folder prefix'
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 32
    Width = 129
    Height = 25
    Caption = 'Connect to database'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 603
    Width = 944
    Height = 19
    Panels = <
      item
        Text = 'Current Database'
        Width = 150
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object BitBtn2: TBitBtn
    Left = 40
    Top = 120
    Width = 129
    Height = 25
    Caption = 'Create folders'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object edtCompany: TEdit
    Left = 424
    Top = 35
    Width = 249
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object edtCompanyPrefix: TEdit
    Left = 424
    Top = 72
    Width = 257
    Height = 21
    TabOrder = 4
  end
  object BitBtn3: TBitBtn
    Left = 40
    Top = 168
    Width = 129
    Height = 25
    Caption = 'Create backup script'
    TabOrder = 5
    OnClick = BitBtn3Click
  end
end
