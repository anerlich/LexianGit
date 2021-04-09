object frmProperties: TfrmProperties
  Left = 335
  Top = 104
  Width = 634
  Height = 473
  Caption = 'Properties'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 90
    Height = 13
    Caption = 'Backup Set Name:'
  end
  object Label3: TLabel
    Left = 8
    Top = 66
    Width = 105
    Height = 13
    Caption = 'Backup File and Path:'
  end
  object Label4: TLabel
    Left = 8
    Top = 37
    Width = 49
    Height = 13
    Caption = 'Database:'
  end
  object Label5: TLabel
    Left = 8
    Top = 95
    Width = 100
    Height = 13
    Caption = 'Location of gbak.exe'
  end
  object BitBtn1: TBitBtn
    Left = 447
    Top = 416
    Width = 75
    Height = 25
    Hint = 'Save Settings and Close'
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 542
    Top = 416
    Width = 75
    Height = 25
    Hint = 'Close without Save'
    TabOrder = 1
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object edtName: TEdit
    Left = 120
    Top = 6
    Width = 217
    Height = 21
    TabOrder = 2
  end
  object edtBackupPath: TEdit
    Left = 120
    Top = 64
    Width = 471
    Height = 21
    TabOrder = 3
  end
  object edtDatabase: TEdit
    Left = 120
    Top = 35
    Width = 472
    Height = 21
    TabOrder = 4
    OnExit = edtDatabaseExit
  end
  object edtGbak: TEdit
    Left = 120
    Top = 93
    Width = 471
    Height = 21
    TabOrder = 5
  end
  object Button1: TButton
    Left = 592
    Top = 35
    Width = 22
    Height = 21
    Hint = 'Browse'
    Caption = '...'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 592
    Top = 64
    Width = 22
    Height = 21
    Hint = 'Browse'
    Caption = '...'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 592
    Top = 93
    Width = 22
    Height = 21
    Hint = 'Browse'
    Caption = '...'
    TabOrder = 8
    OnClick = Button3Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 120
    Width = 609
    Height = 289
    Caption = 'Zip Options'
    TabOrder = 9
    object Label6: TLabel
      Left = 12
      Top = 45
      Width = 44
      Height = 13
      Caption = 'Zip utility:'
    end
    object Label2: TLabel
      Left = 368
      Top = 219
      Width = 129
      Height = 13
      Caption = 'Number of Rolling Zip Files:'
    end
    object Label8: TLabel
      Left = 12
      Top = 73
      Width = 68
      Height = 13
      Caption = 'Zip File Name:'
    end
    object lblSample: TLabel
      Left = 89
      Top = 95
      Width = 3
      Height = 13
    end
    object Label9: TLabel
      Left = 12
      Top = 95
      Width = 38
      Height = 13
      Caption = 'Sample:'
    end
    object grpAddtional: TGroupBox
      Left = 12
      Top = 114
      Width = 341
      Height = 168
      Caption = 'Additional Files to Include in Zip'
      TabOrder = 0
      object ListBox1: TListBox
        Left = 10
        Top = 24
        Width = 320
        Height = 97
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 0
      end
      object btnAdd: TBitBtn
        Left = 11
        Top = 129
        Width = 75
        Height = 25
        Hint = 'Add new file'
        Caption = '&Add'
        TabOrder = 1
        OnClick = btnAddClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
          0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
          0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000008000008000008000008000
          0080000080000080000080000080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          0000800000800000800000800000800000800000800000800000800000800000
          80C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000008000008000008000008000
          0080000080000080000080000080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
          0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
          0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
      end
      object btnRemove: TBitBtn
        Left = 97
        Top = 129
        Width = 75
        Height = 25
        Hint = 'Delete File from list'
        Caption = '&Remove'
        TabOrder = 2
        OnClick = btnRemoveClick
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C00000008000FFFFFF00C0C0C000C0C0C000C0C0
          C000C0C0C00000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000000080000000800000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C00000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000000080000000800000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C00000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000000080000000800000008000FFFFFF00C0C0C000C0C0C000C0C0
          C0000000800000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000080000000800000008000FFFFFF00C0C0C0000000
          800000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000080000000800000008000000080000000
          8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000000080000000800000008000FFFF
          FF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000080000000800000008000000080000000
          8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000080000000800000008000FFFFFF00C0C0C0000000
          8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C00000008000000080000000800000008000FFFFFF00C0C0C000C0C0C000C0C0
          C0000000800000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C0000000
          8000000080000000800000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C0000000800000008000FFFFFF00C0C0C000C0C0C000C0C0C0000000
          800000008000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C0000000800000008000FFFFFF00C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
      end
    end
    object edtZip: TEdit
      Left = 89
      Top = 41
      Width = 280
      Height = 21
      TabOrder = 1
      OnExit = edtZipExit
    end
    object Button4: TButton
      Left = 370
      Top = 41
      Width = 22
      Height = 21
      Hint = 'Browse'
      Caption = '...'
      TabOrder = 2
      OnClick = Button4Click
    end
    object CheckBox1: TCheckBox
      Left = 369
      Top = 254
      Width = 145
      Height = 17
      Hint = 'Store the Folder Information in the ZIP'
      Caption = 'Save Folder Names'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object edtRoll: TMaskEdit
      Left = 513
      Top = 217
      Width = 40
      Height = 21
      TabOrder = 4
      Text = '1'
    end
    object UpDown1: TUpDown
      Left = 553
      Top = 217
      Width = 15
      Height = 21
      Associate = edtRoll
      Min = 1
      Position = 1
      TabOrder = 5
      Wrap = False
    end
    object edtFileName: TEdit
      Left = 89
      Top = 70
      Width = 280
      Height = 21
      TabOrder = 6
      OnChange = edtFileNameChange
    end
    object Button5: TButton
      Left = 370
      Top = 70
      Width = 22
      Height = 21
      Hint = 'Browse'
      Caption = '...'
      TabOrder = 7
      OnClick = Button5Click
    end
    object chkZIP: TCheckBox
      Left = 12
      Top = 18
      Width = 213
      Height = 17
      Caption = 'Use ZIP Utility as well as gbak.exe'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = chkZIPClick
    end
  end
  object btnVerify: TBitBtn
    Left = 184
    Top = 416
    Width = 113
    Height = 25
    Hint = 'Verify Paths and Settings'
    Caption = 'Verify Settings'
    TabOrder = 10
    OnClick = btnVerifyClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000FF000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000FF00
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000008080800000000000FF000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FFFF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000FFFFFF0080808000FFFFFF00808080008080800000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000C0C0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000C0C0
      C000FFFFFF008080800080808000FFFFFF008080800000000000FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C0000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0
      C0000000000000000000000000000000000080808000FFFFFF00808080008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0
      C00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0
      C00000000000FFFFFF0080808000808080008080800080808000FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0
      C00000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
  end
  object opnBrowse: TOpenDialog
    Left = 368
  end
end
