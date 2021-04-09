object Form1: TForm1
  Left = 237
  Top = 102
  Width = 492
  Height = 367
  Caption = 'Run SQL in Script File'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 31
    Width = 52
    Height = 13
    Caption = 'Script File :'
  end
  object BitBtn1: TBitBtn
    Left = 296
    Top = 251
    Width = 113
    Height = 25
    Caption = 'Execute'
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object Edit1: TEdit
    Left = 104
    Top = 27
    Width = 209
    Height = 21
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 314
    Width = 484
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Memo1: TMemo
    Left = 24
    Top = 71
    Width = 369
    Height = 169
    Lines.Strings = (
      '')
    TabOrder = 3
  end
  object Button1: TButton
    Left = 192
    Top = 256
    Width = 75
    Height = 25
    Caption = 'SQL Monitor'
    TabOrder = 4
    OnClick = Button1Click
  end
end
