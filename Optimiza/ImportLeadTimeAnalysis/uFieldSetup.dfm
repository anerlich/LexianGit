object frmFieldSetup: TfrmFieldSetup
  Left = 584
  Top = 227
  Width = 454
  Height = 209
  Caption = 'Field Setup'
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
    Left = 34
    Top = 49
    Width = 56
    Height = 13
    Caption = 'Field Name:'
  end
  object lblField: TLabel
    Left = 32
    Top = 16
    Width = 22
    Height = 13
    Caption = 'Field'
  end
  object Label2: TLabel
    Left = 36
    Top = 83
    Width = 57
    Height = 13
    Caption = 'Field length:'
  end
  object lblCalculation: TLabel
    Left = 40
    Top = 112
    Width = 52
    Height = 13
    Caption = 'Calculation'
    Visible = False
  end
  object edtFieldName: TEdit
    Left = 104
    Top = 46
    Width = 249
    Height = 21
    TabOrder = 0
  end
  object edtFieldLen: TEdit
    Left = 106
    Top = 79
    Width = 249
    Height = 21
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 280
    Top = 136
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 362
    Top = 136
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkOK
  end
  object edtCalculation: TEdit
    Left = 106
    Top = 111
    Width = 249
    Height = 21
    TabOrder = 4
    Visible = False
  end
  object chkCalculated: TCheckBox
    Left = 254
    Top = 16
    Width = 97
    Height = 17
    Caption = 'Calculated'
    TabOrder = 5
    OnClick = chkCalculatedClick
  end
end
