object frmStatus: TfrmStatus
  Left = 499
  Top = 225
  Width = 376
  Height = 338
  Caption = 'Status'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 368
    Height = 292
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 292
    Width = 368
    Height = 19
    Panels = <
      item
        Text = 'Records'
        Width = 100
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
end
