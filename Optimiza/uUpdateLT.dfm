object frmUpdateLT: TfrmUpdateLT
  Left = 238
  Top = 94
  Width = 696
  Height = 641
  Caption = 'Update Lead Time'
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
    Top = 320
    Width = 688
    Height = 294
    Align = alBottom
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 11
      Top = 7
      Width = 500
      Height = 254
      Caption = 'Suppliers'
      TabOrder = 0
      object Label4: TLabel
        Left = 73
        Top = 32
        Width = 86
        Height = 13
        Caption = 'Selected suppliers'
      end
      object Label5: TLabel
        Left = 335
        Top = 32
        Width = 92
        Height = 13
        Caption = 'Available Suppliers'
      end
      object ListBox3: TListBox
        Left = 16
        Top = 52
        Width = 201
        Height = 185
        ItemHeight = 13
        TabOrder = 0
      end
      object ListBox4: TListBox
        Left = 280
        Top = 52
        Width = 201
        Height = 185
        ItemHeight = 13
        TabOrder = 1
      end
      object Button3: TButton
        Left = 224
        Top = 52
        Width = 49
        Height = 25
        Caption = '<'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 224
        Top = 212
        Width = 49
        Height = 25
        Caption = '>'
        TabOrder = 3
        OnClick = Button4Click
      end
    end
    object BitBtn1: TBitBtn
      Left = 546
      Top = 216
      Width = 117
      Height = 25
      Caption = 'Run LT Update'
      TabOrder = 1
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 546
      Top = 168
      Width = 117
      Height = 25
      TabOrder = 2
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 274
      Width = 686
      Height = 19
      Panels = <
        item
          Width = 50
        end>
      SimplePanel = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 41
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 10
      Width = 94
      Height = 13
      Caption = 'Lead Time to Apply:'
    end
    object Edit1: TEdit
      Left = 113
      Top = 6
      Width = 121
      Height = 21
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 688
    Height = 279
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 2
    object GroupBox1: TGroupBox
      Left = 11
      Top = 7
      Width = 500
      Height = 254
      Caption = 'Locations'
      TabOrder = 0
      object Label2: TLabel
        Left = 72
        Top = 32
        Width = 91
        Height = 13
        Caption = 'Selected Locations'
      end
      object Label3: TLabel
        Left = 333
        Top = 32
        Width = 92
        Height = 13
        Caption = 'Available Locations'
      end
      object ListBox1: TListBox
        Left = 16
        Top = 52
        Width = 201
        Height = 185
        ItemHeight = 13
        TabOrder = 0
      end
      object ListBox2: TListBox
        Left = 280
        Top = 52
        Width = 201
        Height = 185
        ItemHeight = 13
        TabOrder = 1
      end
      object Button1: TButton
        Left = 224
        Top = 212
        Width = 49
        Height = 25
        Caption = '>'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 224
        Top = 52
        Width = 49
        Height = 25
        Caption = '<'
        TabOrder = 3
        OnClick = Button2Click
      end
    end
  end
end
