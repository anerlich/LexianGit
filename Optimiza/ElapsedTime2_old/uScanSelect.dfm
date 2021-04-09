object Form2: TForm2
  Left = 435
  Top = 214
  Width = 441
  Height = 485
  Caption = 'Scan Log Files'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 433
    Height = 65
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 11
      Top = 7
      Width = 190
      Height = 25
      Caption = 'Scan for Log Files with Same Name'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 11
      Top = 36
      Width = 406
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 433
    Height = 345
    Align = alClient
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 431
      Height = 41
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 0
      object Label1: TLabel
        Left = 13
        Top = 20
        Width = 96
        Height = 13
        Caption = 'Log Files Found For:'
      end
      object Edit2: TEdit
        Left = 118
        Top = 17
        Width = 299
        Height = 21
        Color = clScrollBar
        ReadOnly = True
        TabOrder = 0
      end
    end
    object ListBox1: TListBox
      Left = 1
      Top = 42
      Width = 431
      Height = 302
      Align = alClient
      ItemHeight = 13
      MultiSelect = True
      Sorted = True
      TabOrder = 1
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 410
    Width = 433
    Height = 41
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 267
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 352
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 192
    Top = 56
  end
end
