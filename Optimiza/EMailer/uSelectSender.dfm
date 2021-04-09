object frmSelectSender: TfrmSelectSender
  Left = 430
  Top = 173
  Width = 378
  Height = 163
  Caption = 'Sender Information'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 16
    Width = 34
    Height = 13
    Caption = 'Name :'
  end
  object Label2: TLabel
    Left = 14
    Top = 64
    Width = 69
    Height = 13
    Caption = 'Email Address:'
  end
  object Edit1: TEdit
    Left = 102
    Top = 16
    Width = 201
    Height = 21
    Hint = 'Enter User Name or Select an Optimiza User'
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 102
    Top = 56
    Width = 201
    Height = 21
    Hint = 'Enter Email Address'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 310
    Top = 16
    Width = 25
    Height = 25
    Hint = 'Select Optimiza User'
    Caption = '...'
    TabOrder = 2
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 184
    Top = 88
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 272
    Top = 88
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkCancel
  end
end
