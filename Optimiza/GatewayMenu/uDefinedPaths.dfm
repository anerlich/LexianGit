object frmDefinedPaths: TfrmDefinedPaths
  Left = 365
  Top = 243
  Width = 477
  Height = 362
  Caption = 'Defined Paths and Variables'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 469
    Height = 287
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Maintain'
      object vleVariables: TValueListEditor
        Left = 0
        Top = 0
        Width = 461
        Height = 259
        Align = alClient
        KeyOptions = [keyEdit, keyAdd, keyUnique]
        Strings.Strings = (
          'Network Folder=\\Lexian02\Optimiza\'
          'Company Folder=Sleepmaker\'
          'Sub Folder 1=Specials\'
          'Sub Folder 2=SalesForecastValuation\Application\'
          'Sub Folder 3='
          'Sub Folder 4='
          'Sub Folder 5='
          'Sub Folder 6='
          'Sub Folder 7='
          'Sub Folder 8='
          'Database=')
        TabOrder = 0
        TitleCaptions.Strings = (
          'Variable Name'
          'Value')
        OnEditButtonClick = vleVariablesEditButtonClick
        ColWidths = (
          150
          305)
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Select'
      ImageIndex = 1
      object Label9: TLabel
        Left = 163
        Top = 11
        Width = 43
        Height = 13
        Caption = 'Available'
      end
      object Label10: TLabel
        Left = 328
        Top = 11
        Width = 81
        Height = 13
        Caption = 'Current Selection'
      end
      object Label8: TLabel
        Left = 19
        Top = 206
        Width = 35
        Height = 13
        Caption = 'Sample'
      end
      object ListBox1: TListBox
        Left = 160
        Top = 28
        Width = 86
        Height = 133
        ItemHeight = 13
        Items.Strings = (
          'Network'
          'Company'
          'Sub Folder 1'
          'Sub Folder 2'
          'Sub Folder 3'
          'Sub Folder 4'
          'Sub Folder 5')
        MultiSelect = True
        TabOrder = 0
      end
      object Button2: TButton
        Left = 256
        Top = 29
        Width = 60
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 256
        Top = 61
        Width = 60
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 256
        Top = 93
        Width = 60
        Height = 25
        Caption = 'Delete All'
        TabOrder = 3
        OnClick = Button4Click
      end
      object ListBox2: TListBox
        Left = 326
        Top = 28
        Width = 129
        Height = 133
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 4
      end
      object Edit1: TEdit
        Left = 8
        Top = 206
        Width = 481
        Height = 21
        Color = clInfoBk
        ReadOnly = True
        TabOrder = 5
      end
      object Edit2: TEdit
        Left = 8
        Top = 172
        Width = 481
        Height = 21
        Color = clInfoBk
        ReadOnly = True
        TabOrder = 6
      end
      object ListBox3: TListBox
        Left = 8
        Top = 28
        Width = 145
        Height = 133
        Enabled = False
        ItemHeight = 13
        TabOrder = 7
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 287
    Width = 469
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 291
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 374
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
