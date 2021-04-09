object frmCopySalesHist: TfrmCopySalesHist
  Left = 270
  Top = 203
  Width = 573
  Height = 370
  Caption = 'Copy Sales History to Multiple Locations'
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 324
    Width = 565
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 565
    Height = 324
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 13
      Top = 3
      Width = 78
      Height = 13
      Caption = 'Source Location'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 293
      Top = 5
      Width = 102
      Height = 13
      Caption = 'Source Product Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 13
      Top = 78
      Width = 210
      Height = 13
      Caption = 'Copy Sales History to the following locations:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 293
      Top = 78
      Width = 99
      Height = 13
      Caption = 'Target Product Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 13
      Top = 21
      Width = 257
      Height = 21
      Hint = 'LocationCode;Description'
      KeyField = 'Description'
      ListField = 'LocationCode;Description'
      ListSource = dmCopySalesHist.srcAllLocations
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 293
      Top = 21
      Width = 204
      Height = 21
      TabOrder = 1
    end
    object Button1: TButton
      Left = 507
      Top = 21
      Width = 48
      Height = 21
      Caption = 'Find ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button1Click
    end
    object CheckListBox1: TCheckListBox
      Left = 13
      Top = 94
      Width = 257
      Height = 217
      ItemHeight = 13
      TabOrder = 3
    end
    object BitBtn1: TBitBtn
      Left = 390
      Top = 288
      Width = 75
      Height = 25
      Caption = 'Copy'
      TabOrder = 4
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 480
      Top = 288
      Width = 75
      Height = 25
      TabOrder = 5
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object Edit2: TEdit
      Left = 293
      Top = 94
      Width = 204
      Height = 21
      TabOrder = 6
    end
    object Button2: TButton
      Left = 507
      Top = 94
      Width = 48
      Height = 21
      Caption = 'Find ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = Button2Click
    end
  end
end
