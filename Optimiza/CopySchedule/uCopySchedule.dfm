object frmCopySchedule: TfrmCopySchedule
  Left = 282
  Top = 186
  Width = 1391
  Height = 438
  Caption = 'Copy Schedule lines'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  DesignSize = (
    1375
    400)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 624
    Top = 200
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 624
    Top = 224
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label3: TLabel
    Left = 624
    Top = 256
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1375
    Height = 41
    Align = alTop
    TabOrder = 0
  end
  object cbFromSchedule: TComboBox
    Left = 8
    Top = 48
    Width = 241
    Height = 21
    Style = csDropDownList
    DropDownCount = 20
    ItemHeight = 13
    TabOrder = 1
    OnChange = cbFromScheduleChange
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 381
    Width = 1375
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object lbFromTasks: TListBox
    Left = 256
    Top = 48
    Width = 297
    Height = 326
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 3
  end
  object cbToSchedule: TComboBox
    Left = 728
    Top = 48
    Width = 241
    Height = 21
    Style = csDropDownList
    DropDownCount = 20
    ItemHeight = 13
    TabOrder = 4
    OnChange = cbToScheduleChange
  end
  object lbToTasks: TListBox
    Left = 976
    Top = 48
    Width = 297
    Height = 326
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 5
  end
  object btnCopy: TButton
    Left = 600
    Top = 96
    Width = 105
    Height = 25
    Caption = 'Copy Selected ->'
    TabOrder = 6
    OnClick = btnCopyClick
  end
  object GroupBox1: TGroupBox
    Left = 744
    Top = 96
    Width = 129
    Height = 27
    TabOrder = 7
    object rbBefore: TRadioButton
      Left = 8
      Top = 8
      Width = 57
      Height = 17
      Caption = 'Before'
      TabOrder = 0
    end
    object rbAfter: TRadioButton
      Left = 72
      Top = 8
      Width = 49
      Height = 17
      Caption = 'After'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object Button1: TButton
    Left = 628
    Top = 156
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 8
    OnClick = Button1Click
  end
end
