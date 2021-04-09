object Form1: TForm1
  Left = 249
  Top = 114
  Width = 710
  Height = 370
  Caption = 'Search and Replace String'
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
    Left = 409
    Top = 289
    Width = 40
    Height = 13
    Caption = 'Records'
  end
  object Label2: TLabel
    Left = 69
    Top = 22
    Width = 28
    Height = 13
    Caption = 'In File'
  end
  object Label3: TLabel
    Left = 69
    Top = 68
    Width = 36
    Height = 13
    Caption = 'Out File'
  end
  object Label4: TLabel
    Left = 69
    Top = 176
    Width = 64
    Height = 13
    Caption = 'Search String'
  end
  object Label5: TLabel
    Left = 69
    Top = 232
    Width = 70
    Height = 13
    Caption = 'Replace String'
  end
  object Edit1: TEdit
    Left = 69
    Top = 36
    Width = 417
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 69
    Top = 84
    Width = 417
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 499
    Top = 35
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 2
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 305
    Top = 281
    Width = 75
    Height = 25
    Caption = 'Convert'
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 600
    Top = 280
    Width = 75
    Height = 25
    TabOrder = 4
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object Edit3: TEdit
    Left = 69
    Top = 192
    Width = 380
    Height = 21
    TabOrder = 5
    Text = 'values (7'
  end
  object Edit4: TEdit
    Left = 69
    Top = 248
    Width = 380
    Height = 21
    TabOrder = 6
    Text = 'values (31'
  end
  object OpenDialog1: TOpenDialog
    Left = 632
    Top = 96
  end
end
