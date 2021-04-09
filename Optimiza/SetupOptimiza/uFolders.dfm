object frmFolders: TfrmFolders
  Left = 511
  Top = 189
  Width = 665
  Height = 531
  Caption = 'Folders'
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
    Left = 80
    Top = 37
    Width = 63
    Height = 13
    Caption = 'Primary folder'
  end
  object Label2: TLabel
    Left = 81
    Top = 12
    Width = 73
    Height = 13
    Caption = 'Company folder'
  end
  object Label3: TLabel
    Left = 74
    Top = 100
    Width = 70
    Height = 13
    Caption = 'Database path'
  end
  object Label4: TLabel
    Left = 74
    Top = 141
    Width = 54
    Height = 13
    Caption = 'Export path'
  end
  object Label5: TLabel
    Left = 74
    Top = 183
    Width = 81
    Height = 13
    Caption = 'Custom programs'
  end
  object Label6: TLabel
    Left = 74
    Top = 224
    Width = 47
    Height = 13
    Caption = 'Data path'
  end
  object Label7: TLabel
    Left = 74
    Top = 266
    Width = 37
    Height = 13
    Caption = 'Reports'
  end
  object Label8: TLabel
    Left = 74
    Top = 307
    Width = 37
    Height = 13
    Caption = 'Backup'
  end
  object Label9: TLabel
    Left = 74
    Top = 349
    Width = 39
    Height = 13
    Caption = 'Log files'
  end
  object Label10: TLabel
    Left = 74
    Top = 69
    Width = 66
    Height = 13
    Caption = 'Software path'
  end
  object BitBtn1: TBitBtn
    Left = 448
    Top = 440
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 544
    Top = 440
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object edtPrimary: TEdit
    Left = 172
    Top = 35
    Width = 341
    Height = 21
    ReadOnly = True
    TabOrder = 2
    OnChange = edtPrimaryChange
  end
  object Button1: TButton
    Left = 517
    Top = 33
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 3
    OnClick = Button1Click
  end
  object edtCompany: TEdit
    Left = 173
    Top = 8
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 4
    OnChange = edtCompanyChange
  end
  object edtDb: TEdit
    Left = 160
    Top = 96
    Width = 361
    Height = 21
    TabOrder = 5
  end
  object edtExport: TEdit
    Left = 160
    Top = 137
    Width = 361
    Height = 21
    TabOrder = 6
  end
  object edtProg: TEdit
    Left = 160
    Top = 178
    Width = 361
    Height = 21
    TabOrder = 7
  end
  object edtData: TEdit
    Left = 160
    Top = 220
    Width = 361
    Height = 21
    TabOrder = 8
  end
  object edtReport: TEdit
    Left = 160
    Top = 261
    Width = 361
    Height = 21
    TabOrder = 9
  end
  object edtBackup: TEdit
    Left = 160
    Top = 302
    Width = 361
    Height = 21
    TabOrder = 10
  end
  object edtLog: TEdit
    Left = 160
    Top = 344
    Width = 361
    Height = 21
    TabOrder = 11
  end
  object edtSoftware: TEdit
    Left = 160
    Top = 65
    Width = 361
    Height = 21
    TabOrder = 12
  end
end
