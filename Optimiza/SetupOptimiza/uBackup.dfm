object frmBackup: TfrmBackup
  Left = 396
  Top = 326
  Width = 746
  Height = 627
  Caption = 'Create backup script'
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
  object Panel1: TPanel
    Left = 0
    Top = 552
    Width = 738
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 392
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 738
    Height = 257
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 234
      Width = 110
      Height = 13
      Caption = 'Standard backup script'
    end
    object Label2: TLabel
      Left = 376
      Top = 234
      Width = 89
      Height = 13
      Caption = 'New backup script'
    end
    object Label3: TLabel
      Left = 24
      Top = 28
      Width = 61
      Height = 13
      Caption = 'Backup path'
    end
    object Label4: TLabel
      Left = 24
      Top = 54
      Width = 70
      Height = 13
      Caption = 'Database path'
    end
    object Label5: TLabel
      Left = 24
      Top = 80
      Width = 62
      Height = 13
      Caption = 'Database file'
    end
    object Label6: TLabel
      Left = 24
      Top = 106
      Width = 53
      Height = 13
      Caption = 'Backup file'
    end
    object Label7: TLabel
      Left = 26
      Top = 132
      Width = 47
      Height = 13
      Caption = 'GBak.exe'
    end
    object Label8: TLabel
      Left = 24
      Top = 157
      Width = 64
      Height = 13
      Caption = 'Optimiza path'
    end
    object edtBackupPath: TEdit
      Left = 105
      Top = 24
      Width = 405
      Height = 21
      TabOrder = 0
    end
    object edtGdb: TEdit
      Left = 105
      Top = 76
      Width = 453
      Height = 21
      TabOrder = 1
      OnChange = edtGdbChange
    end
    object Button1: TButton
      Left = 561
      Top = 76
      Width = 33
      Height = 25
      Caption = '...'
      TabOrder = 2
      OnClick = Button1Click
    end
    object edtGBK: TEdit
      Left = 105
      Top = 102
      Width = 453
      Height = 21
      TabOrder = 3
    end
    object edtDBPath: TEdit
      Left = 105
      Top = 50
      Width = 405
      Height = 21
      TabOrder = 4
    end
    object edtGBak: TEdit
      Left = 105
      Top = 128
      Width = 453
      Height = 21
      TabOrder = 5
    end
    object Button2: TButton
      Left = 561
      Top = 126
      Width = 33
      Height = 25
      Caption = '...'
      TabOrder = 6
      OnClick = Button2Click
    end
    object edtSoftware: TEdit
      Left = 105
      Top = 153
      Width = 405
      Height = 21
      TabOrder = 7
    end
    object RadioGroup1: TRadioGroup
      Left = 104
      Top = 179
      Width = 265
      Height = 49
      Caption = 'Which version of FireEvent'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'FireEvent.exe'
        'FireEventMP.exe')
      TabOrder = 8
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 257
    Width = 369
    Height = 295
    Align = alLeft
    TabOrder = 2
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 367
      Height = 293
      Align = alClient
      Lines.Strings = (
        ':START'
        'delete %BACKUP_TARGET%'
        ''
        '%GBAK_DRIVE%'
        'cd\%GBAK_PATH%'
        ''
        
          'gbak.exe -B -G -user "SYSDBA" -password "masterkey"  %BACKUP_SOU' +
          'RCE% %BACKUP_TARGET%  '
        ''
        '%OPTIMIZA_DRIVE%'
        'cd%OPTIMIZA_PATH%'
        ''
        'IF ERRORLEVEL 0 GOTO SUCCESS'
        ''
        ':ERROR'
        '%FIRE_EVENT% F'
        ''
        ':SUCCESS'
        '%FIRE_EVENT% S'
        ''
        ':END')
      TabOrder = 0
      WordWrap = False
    end
  end
  object Panel4: TPanel
    Left = 369
    Top = 257
    Width = 369
    Height = 295
    Align = alClient
    TabOrder = 3
    object Memo2: TMemo
      Left = 1
      Top = 1
      Width = 367
      Height = 293
      Align = alClient
      TabOrder = 0
      WordWrap = False
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.gdb'
    Filter = 'Optimiza Database (*.gdb)|*.gdb'
    Options = [ofHideReadOnly, ofNoNetworkButton, ofEnableSizing]
    Left = 336
    Top = 72
  end
end
