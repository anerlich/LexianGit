object frmEmail: TfrmEmail
  Left = 455
  Top = 271
  Width = 494
  Height = 187
  Caption = 'Email Settings'
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
    Left = 11
    Top = 48
    Width = 94
    Height = 13
    Caption = 'Path for Emailer.exe'
  end
  object Label2: TLabel
    Left = 11
    Top = 84
    Width = 139
    Height = 13
    Caption = 'Parameter File for Emailer.exe'
  end
  object CheckBox1: TCheckBox
    Left = 11
    Top = 13
    Width = 177
    Height = 17
    Caption = 'Send email when error occurs'
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 298
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 391
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object Edit1: TEdit
    Left = 168
    Top = 45
    Width = 267
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 168
    Top = 81
    Width = 267
    Height = 21
    TabOrder = 4
  end
  object Button1: TButton
    Left = 440
    Top = 45
    Width = 26
    Height = 22
    Caption = '...'
    TabOrder = 5
    OnClick = Button1Click
  end
  object vleIniFile: TValueListEditor
    Left = 304
    Top = 8
    Width = 121
    Height = 81
    TabOrder = 6
    Visible = False
    ColWidths = (
      150
      -35)
  end
  object Button3: TButton
    Left = 440
    Top = 82
    Width = 26
    Height = 22
    Caption = '...'
    TabOrder = 7
    OnClick = Button3Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Applications (*.exe)|*.exe'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 424
    Top = 8
  end
end
