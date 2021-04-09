object frmPassword: TfrmPassword
  Left = 572
  Top = 358
  Width = 470
  Height = 137
  ActiveControl = Edit1
  Caption = 'Logon'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 22
    Width = 53
    Height = 13
    Caption = 'User Name'
  end
  object Label2: TLabel
    Left = 58
    Top = 66
    Width = 46
    Height = 13
    Caption = 'Password'
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 352
    Top = 14
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 352
    Top = 62
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object Edit1: TEdit
    Left = 128
    Top = 18
    Width = 161
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 128
    Top = 62
    Width = 161
    Height = 21
    CharCase = ecUpperCase
    PasswordChar = '*'
    TabOrder = 3
    Visible = False
  end
end
