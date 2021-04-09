object frmMain: TfrmMain
  Left = 306
  Top = 122
  Width = 830
  Height = 531
  Caption = 'Restore Status'
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
    Width = 822
    Height = 41
    Align = alTop
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 24
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Open'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 248
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Go To'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object Edit1: TEdit
      Left = 144
      Top = 10
      Width = 97
      Height = 21
      TabOrder = 2
    end
    object BitBtn3: TBitBtn
      Left = 712
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Find'
      TabOrder = 3
      OnClick = BitBtn3Click
    end
    object Edit2: TEdit
      Left = 464
      Top = 8
      Width = 201
      Height = 21
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 440
    Width = 822
    Height = 57
    Align = alBottom
    TabOrder = 1
    object StatusBar1: TStatusBar
      Left = 1
      Top = 37
      Width = 820
      Height = 19
      Panels = <
        item
          Width = 50
        end
        item
          Width = 50
        end
        item
          Width = 50
        end
        item
          Width = 50
        end
        item
          Width = 50
        end>
      SimplePanel = False
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 41
    Width = 822
    Height = 399
    Style = lbOwnerDrawFixed
    Align = alClient
    ItemHeight = 16
    TabOrder = 2
    OnDrawItem = ListBox1DrawItem
    OnMouseDown = ListBox1MouseDown
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Text Files (*.txt)|*.txt|All Files|*.*'
    Left = 680
    Top = 8
  end
end
