object frmNewHost: TfrmNewHost
  Left = 399
  Top = 318
  Width = 326
  Height = 130
  Caption = 'New Host'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 24
    Width = 57
    Height = 13
    Caption = 'I.P. Address'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 53
    Height = 13
    Caption = 'Host Name'
  end
  object Edit1: TEdit
    Left = 74
    Top = 19
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 74
    Top = 56
    Width = 137
    Height = 21
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 227
    Top = 17
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 227
    Top = 56
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
end
