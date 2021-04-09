object frmExportUsers: TfrmExportUsers
  Left = 558
  Top = 249
  Width = 476
  Height = 162
  Caption = 'Export Users'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 23
    Top = 10
    Width = 82
    Height = 13
    Caption = 'Export ALL Users'
  end
  object Label2: TLabel
    Left = 14
    Top = 30
    Width = 40
    Height = 13
    Caption = 'CSV File'
  end
  object BitBtn1: TBitBtn
    Left = 296
    Top = 87
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 384
    Top = 87
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkClose
  end
  object edtUserFrom: TEdit
    Left = 156
    Top = 8
    Width = 69
    Height = 21
    ReadOnly = True
    TabOrder = 2
    Visible = False
  end
  object Button1: TButton
    Left = 246
    Top = 6
    Width = 32
    Height = 25
    Caption = '...'
    TabOrder = 3
    Visible = False
    OnClick = Button1Click
  end
  object edtUserFromNo: TEdit
    Left = 109
    Top = 10
    Width = 35
    Height = 21
    TabOrder = 4
    Visible = False
  end
  object CheckBox1: TCheckBox
    Left = 292
    Top = 13
    Width = 97
    Height = 17
    Caption = 'All Users'
    Checked = True
    State = cbChecked
    TabOrder = 5
    Visible = False
  end
  object Edit1: TEdit
    Left = 14
    Top = 46
    Width = 361
    Height = 21
    TabOrder = 6
  end
  object BitBtn3: TBitBtn
    Left = 382
    Top = 46
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 7
    OnClick = BitBtn3Click
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.csv'
    Filter = 'CSV Files|*.CSV'
    Left = 336
    Top = 40
  end
end
