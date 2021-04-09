object frmEdit: TfrmEdit
  Left = 401
  Top = 148
  Width = 574
  Height = 315
  Caption = 'Mail Allocation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 17
    Width = 42
    Height = 13
    Caption = 'Business'
  end
  object Label2: TLabel
    Left = 12
    Top = 57
    Width = 46
    Height = 13
    Caption = 'Mail Type'
  end
  object Label3: TLabel
    Left = 12
    Top = 97
    Width = 23
    Height = 13
    Caption = 'From'
  end
  object Label4: TLabel
    Left = 12
    Top = 137
    Width = 36
    Height = 13
    Caption = 'Subject'
  end
  object BitBtn1: TBitBtn
    Left = 466
    Top = 239
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 370
    Top = 239
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object btnRemove: TBitBtn
    Left = 82
    Top = 204
    Width = 75
    Height = 25
    Caption = 'Remove'
    ModalResult = 6
    TabOrder = 2
  end
  object cmbBusiness: TComboBox
    Left = 85
    Top = 13
    Width = 241
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
  end
  object cmbMailType: TComboBox
    Left = 85
    Top = 53
    Width = 241
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 85
    Top = 93
    Width = 457
    Height = 21
    ReadOnly = True
    TabOrder = 5
  end
  object Edit2: TEdit
    Left = 85
    Top = 133
    Width = 457
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object CheckBox1: TCheckBox
    Left = 85
    Top = 168
    Width = 97
    Height = 17
    Caption = 'Critical'
    TabOrder = 7
  end
end
