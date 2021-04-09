object Form1: TForm1
  Left = 237
  Top = 107
  Width = 703
  Height = 507
  Caption = 'System 3 conversion utility'
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 695
    Height = 451
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Location Links'
      object GroupBox2: TGroupBox
        Left = 4
        Top = 8
        Width = 577
        Height = 196
        Caption = 'System 3 Locations'
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 8
          Top = 48
          Width = 553
          Height = 137
          DataSource = dmOptimiza1.srcMlSysdir
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
        object DBNavigator1: TDBNavigator
          Left = 8
          Top = 14
          Width = 240
          Height = 25
          DataSource = dmOptimiza1.srcMlSysdir
          TabOrder = 1
        end
      end
      object Button2: TButton
        Left = 4
        Top = 207
        Width = 228
        Height = 25
        Caption = 'Link Sys3 to Optimiza tables on DIRCDE'
        TabOrder = 1
        OnClick = Button2Click
      end
      object GroupBox1: TGroupBox
        Left = 4
        Top = 233
        Width = 577
        Height = 189
        Caption = 'Optimiza Locations'
        TabOrder = 2
        object DBGrid2: TDBGrid
          Left = 8
          Top = 48
          Width = 554
          Height = 132
          DataSource = dmOptimiza1.srcLocationList
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
        object DBNavigator2: TDBNavigator
          Left = 8
          Top = 14
          Width = 240
          Height = 25
          DataSource = dmOptimiza1.srcLocationList
          TabOrder = 1
        end
      end
      object Button3: TButton
        Left = 353
        Top = 207
        Width = 228
        Height = 25
        Caption = 'Link Sys3 to Optimiza tables on ORG'
        TabOrder = 3
        OnClick = Button3Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Locations to update'
      ImageIndex = 1
      object CheckListBox2: TCheckListBox
        Left = 8
        Top = 8
        Width = 393
        Height = 337
        ItemHeight = 13
        TabOrder = 0
      end
      object Button4: TButton
        Left = 432
        Top = 304
        Width = 75
        Height = 25
        Caption = 'Untag all'
        TabOrder = 1
        OnClick = Button4Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Update Options'
      ImageIndex = 3
      object Button1: TButton
        Left = 376
        Top = 104
        Width = 75
        Height = 25
        Caption = 'Update Now'
        TabOrder = 0
        OnClick = Button1Click
      end
      object CheckListBox1: TCheckListBox
        Left = 4
        Top = 8
        Width = 201
        Height = 97
        ItemHeight = 13
        Items.Strings = (
          'Stock Out Count'
          'Frozen Forecast Indicators'
          'Manual Policy')
        TabOrder = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 451
    Width = 695
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 473
      Top = 0
      Width = 3
      Height = 18
      Cursor = crHSplit
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 473
      Height = 18
      Align = alLeft
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 476
      Top = 0
      Width = 219
      Height = 18
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      object Gauge1: TGauge
        Left = 1
        Top = 1
        Width = 217
        Height = 16
        Align = alClient
        Progress = 0
      end
    end
  end
end
