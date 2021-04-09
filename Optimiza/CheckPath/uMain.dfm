object frmMain: TfrmMain
  Left = 345
  Top = 147
  Width = 706
  Height = 513
  Caption = 'Validate Paths for ver 3.6'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 698
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 32
      Top = 8
      Width = 121
      Height = 25
      Caption = 'Validate Scheduler'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 600
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkClose
    end
    object BitBtn3: TBitBtn
      Left = 184
      Top = 8
      Width = 153
      Height = 25
      Caption = 'Check Scripts for FireEvent'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 698
    Height = 419
    Align = alClient
    Color = clInfoBk
    PopupMenu = PopupMenu1
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 460
    Width = 698
    Height = 19
    Panels = <
      item
        Text = 'Database'
        Width = 100
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.txt'
    Filter = '(*.txt)|*.txt|All Files (*.*)|*.*'
    Title = 'Export to pipe delimited file'
    Left = 384
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 80
    object SavetoCSV1: TMenuItem
      Caption = 'Save to CSV ..'
      OnClick = SavetoCSV1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 352
    Top = 16
  end
end
