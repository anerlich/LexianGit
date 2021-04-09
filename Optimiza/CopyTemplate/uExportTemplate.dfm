object frmExportTemplate: TfrmExportTemplate
  Left = 554
  Top = 275
  Width = 490
  Height = 255
  Caption = 'Export Template Settings'
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
    Width = 133
    Height = 13
    Caption = 'Export Template Settings for'
  end
  object Label2: TLabel
    Left = 14
    Top = 113
    Width = 40
    Height = 13
    Caption = 'CSV File'
  end
  object BitBtn1: TBitBtn
    Left = 296
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 384
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkClose
  end
  object edtUserFrom: TEdit
    Left = 20
    Top = 40
    Width = 201
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 222
    Top = 38
    Width = 32
    Height = 25
    Caption = '...'
    TabOrder = 3
    OnClick = Button1Click
  end
  object edtUserFromNo: TEdit
    Left = 221
    Top = 10
    Width = 35
    Height = 21
    TabOrder = 4
    Visible = False
  end
  object CheckBox1: TCheckBox
    Left = 20
    Top = 69
    Width = 97
    Height = 17
    Caption = 'All Users'
    TabOrder = 5
  end
  object Edit1: TEdit
    Left = 14
    Top = 129
    Width = 361
    Height = 21
    TabOrder = 6
  end
  object BitBtn3: TBitBtn
    Left = 382
    Top = 129
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
