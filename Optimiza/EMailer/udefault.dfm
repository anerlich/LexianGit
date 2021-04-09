object frmDefault: TfrmDefault
  Left = 664
  Top = 380
  Width = 378
  Height = 169
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
    Left = 7
    Top = 59
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 142
    Top = 17
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object BitBtn1: TBitBtn
    Left = 191
    Top = 96
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 279
    Top = 96
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object CheckBox1: TCheckBox
    Left = 64
    Top = 16
    Width = 77
    Height = 17
    Caption = 'Use Default'
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 63
    Top = 56
    Width = 289
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
end
