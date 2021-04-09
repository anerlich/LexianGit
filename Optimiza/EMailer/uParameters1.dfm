object frmParameters: TfrmParameters
  Left = 516
  Top = 260
  Width = 593
  Height = 548
  Caption = 'Parameters'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 12
      Width = 83
      Height = 13
      Caption = 'New item settings'
    end
    object edtIniFile: TEdit
      Left = 92
      Top = 9
      Width = 404
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object btnSave: TBitBtn
      Left = 505
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 1
      OnClick = btnSaveClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000C0C0C000C0C0C0000000
        0000008080000080800000000000000000000000000000000000000000000000
        0000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
        0000008080000080800000000000000000000000000000000000000000000000
        0000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
        0000008080000080800000000000000000000000000000000000000000000000
        0000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
        0000008080000080800000000000000000000000000000000000000000000000
        00000000000000000000000000000080800000000000C0C0C000C0C0C0000000
        0000008080000080800000808000008080000080800000808000008080000080
        80000080800000808000008080000080800000000000C0C0C000C0C0C0000000
        0000008080000080800000000000000000000000000000000000000000000000
        00000000000000000000008080000080800000000000C0C0C000C0C0C0000000
        00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
        00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
        00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
        00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
        00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0C0000000
        00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C00000000000C0C0C00000000000C0C0C000C0C0C0000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 184
    Width = 585
    Height = 330
    Align = alBottom
    TabOrder = 1
    object Panel5: TPanel
      Left = 1
      Top = 288
      Width = 583
      Height = 41
      Align = alBottom
      TabOrder = 0
      object BitBtn1: TBitBtn
        Left = 403
        Top = 10
        Width = 75
        Height = 25
        TabOrder = 0
        Kind = bkCancel
      end
      object BitBtn2: TBitBtn
        Left = 488
        Top = 10
        Width = 75
        Height = 25
        TabOrder = 1
        OnClick = BitBtn2Click
        Kind = bkOK
      end
      object BitBtn3: TBitBtn
        Left = 204
        Top = 8
        Width = 91
        Height = 25
        Caption = 'Merge'
        Default = True
        ModalResult = 6
        TabOrder = 2
        OnClick = BitBtn3Click
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0840000840000C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0840000848400840000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C084000000FFFF848400840000C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C084000000FFFF848400840000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C084000084000084000084000000FFFF84
          8400840000C0C0C0C0C0C0840000C0C0C0C0C0C0C0C0C0840000C0C0C0C0C0C0
          84000000FFFF00FFFF00FFFF00FFFF00FFFF848400840000C0C0C0C0C0C08400
          00C0C0C0840000C0C0C0C0C0C0C0C0C084000000FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF840000C0C0C0C0C0C0C0C0C0840000C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C084000000FFFF848400840000840000840000840000C0C0C0C0C0C08400
          00C0C0C0840000C0C0C0C0C0C0C0C0C0C0C0C084000000FFFF00FFFF84840084
          0000C0C0C0C0C0C0C0C0C0840000C0C0C0C0C0C0C0C0C0840000C0C0C0840000
          84000084000084000000FFFF00FFFF848400840000C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C084000000FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF848400840000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          84000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF848400840000C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C084000000FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF848400840000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          8400008400008400008400008400008400008400008400008400008400008400
          00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 583
      Height = 41
      Align = alTop
      TabOrder = 1
      object Label2: TLabel
        Left = 4
        Top = 12
        Width = 64
        Height = 13
        Caption = 'Email settings'
      end
      object BitBtn4: TBitBtn
        Left = 424
        Top = 6
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 0
        OnClick = BitBtn4Click
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          0000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          0000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          0000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          00000000000000000000000000000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000808000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          00000000000000000000008080000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C00000000000C0C0C00000000000C0C0C000C0C0C0000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
      end
      object edtEmail: TEdit
        Left = 75
        Top = 8
        Width = 260
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object btnSaveAs: TBitBtn
        Left = 504
        Top = 6
        Width = 75
        Height = 25
        Caption = 'Save As'
        TabOrder = 2
        OnClick = btnSaveAsClick
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          0000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          0000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          0000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          00000000000000000000000000000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000808000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000C0C0C000C0C0C0000000
          0000008080000080800000000000000000000000000000000000000000000000
          00000000000000000000008080000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000080800000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0C0000000
          00000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C00000000000C0C0C00000000000C0C0C000C0C0C0000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
      end
      object btnOpen: TBitBtn
        Left = 340
        Top = 6
        Width = 75
        Height = 25
        Caption = 'Open'
        TabOrder = 3
        OnClick = btnOpenClick
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
          0000008080000080800000808000008080000080800000808000008080000080
          80000080800000000000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FF
          FF00000000000080800000808000008080000080800000808000008080000080
          8000008080000080800000000000C0C0C000C0C0C000C0C0C00000000000FFFF
          FF0000FFFF000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000000000C0C0C000C0C0C0000000000000FF
          FF00FFFFFF0000FFFF0000000000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000C0C0C00000000000FFFF
          FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
          FF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
          FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
          FF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FF
          FF00FFFFFF0000FFFF0000000000000000000000000000000000000000000000
          000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
          00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0
          C000C0C0C000C0C0C00000000000C0C0C00000000000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
          00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
      end
    end
    object vleEmail: TValueListEditor
      Left = 1
      Top = 42
      Width = 583
      Height = 246
      Align = alClient
      Color = clInfoBk
      Strings.Strings = (
        'Host=[default]'
        'Port=[default]'
        'User ID=[default]'
        'Sender Name='
        'Sender Email='
        'TO='
        'CC='
        'BCC='
        'Attachments='
        'Subject='
        'Message=')
      TabOrder = 2
      OnEditButtonClick = vleEmailEditButtonClick
      ColWidths = (
        150
        427)
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 585
    Height = 143
    Align = alClient
    TabOrder = 2
    object vleParameters: TValueListEditor
      Left = 1
      Top = 1
      Width = 583
      Height = 141
      Align = alClient
      Strings.Strings = (
        '=')
      TabOrder = 0
      OnEditButtonClick = vleParametersEditButtonClick
      ColWidths = (
        150
        427)
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.csv'
    Filter = 'CSV Files|*.csv|Text Files|*.txt|All Files|*.*'
    Left = 536
    Top = 64
  end
  object OpenDialog2: TOpenDialog
    DefaultExt = '*.ini'
    Filter = 'INI Files (*.ini)|*.ini|All Files (*.*)|*.*'
    Left = 496
    Top = 64
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.ini'
    Filter = 'INI Files (*.ini)|*.ini|All Files (*.*)|*.*'
    Left = 512
    Top = 144
  end
end
