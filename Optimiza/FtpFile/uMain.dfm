object frmMain: TfrmMain
  Left = 430
  Top = 180
  Width = 690
  Height = 326
  Caption = 'FTP Utility'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edtFtpSite: TEdit
    Left = 120
    Top = 48
    Width = 249
    Height = 21
    TabOrder = 0
    Text = 'ftp.barloworldoptimus.com'
  end
  object edtUser: TEdit
    Left = 120
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'bwoaus'
  end
  object edtPassword: TEdit
    Left = 121
    Top = 115
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'kgrey005!'
  end
  object edtPath: TEdit
    Left = 120
    Top = 152
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'priv/bwoaus/Sleepmaker'
  end
  object edtFile: TEdit
    Left = 120
    Top = 184
    Width = 345
    Height = 21
    TabOrder = 4
  end
  object Button1: TButton
    Left = 468
    Top = 182
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 5
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 448
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Transfer'
    TabOrder = 6
    OnClick = BitBtn1Click
  end
  object OpenDialog1: TOpenDialog
    Left = 544
    Top = 176
  end
end
