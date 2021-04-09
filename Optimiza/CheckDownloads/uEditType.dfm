object frmEditType: TfrmEditType
  Left = 521
  Top = 253
  Width = 603
  Height = 406
  Caption = 'Change'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 11
    Width = 24
    Height = 13
    Caption = 'Type'
  end
  object Label3: TLabel
    Left = 12
    Top = 42
    Width = 52
    Height = 13
    Caption = 'Trigger File'
  end
  object Label4: TLabel
    Left = 12
    Top = 104
    Width = 72
    Height = 13
    Caption = 'Download Files'
  end
  object Label2: TLabel
    Left = 13
    Top = 73
    Width = 58
    Height = 13
    Caption = 'Email Ini File'
  end
  object BitBtn1: TBitBtn
    Left = 507
    Top = 295
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 506
    Top = 332
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object cmbType: TComboBox
    Left = 92
    Top = 9
    Width = 81
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'Daily'
    Items.Strings = (
      'Daily'
      'Monthly')
  end
  object edtTrigger: TEdit
    Left = 92
    Top = 38
    Width = 404
    Height = 21
    TabOrder = 3
  end
  object Button2: TButton
    Left = 503
    Top = 38
    Width = 25
    Height = 22
    Caption = '...'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 503
    Top = 102
    Width = 25
    Height = 22
    Caption = '...'
    TabOrder = 5
    OnClick = Button3Click
  end
  object grdDownload: TStringGrid
    Left = 92
    Top = 102
    Width = 404
    Height = 257
    ColCount = 1
    DefaultColWidth = 400
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 12
    FixedRows = 0
    TabOrder = 6
  end
  object edtEmailIni: TEdit
    Left = 93
    Top = 69
    Width = 404
    Height = 21
    TabOrder = 7
  end
  object Button1: TButton
    Left = 504
    Top = 69
    Width = 25
    Height = 22
    Caption = '...'
    TabOrder = 8
    OnClick = Button1Click
  end
  object BitBtn3: TBitBtn
    Left = 532
    Top = 67
    Width = 41
    Height = 25
    Caption = 'Edit'
    TabOrder = 9
    OnClick = BitBtn3Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Text Files|*.txt|CSV Files|*.csv|Ini Files|*.ini|All Files|*.*'
    Left = 448
    Top = 8
  end
end
