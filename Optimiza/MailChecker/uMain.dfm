object frmMain: TfrmMain
  Left = 279
  Top = 28
  Width = 1051
  Height = 800
  Caption = 'Mail Checker'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 747
    Width = 1043
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 105
    Width = 1043
    Height = 642
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 1041
      Height = 640
      ActivePage = TabSheet5
      Align = alClient
      TabIndex = 4
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Message Headers'
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 1033
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object BitBtn3: TBitBtn
            Left = 8
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Refresh List'
            TabOrder = 0
            OnClick = BitBtn3Click
          end
        end
        object grdHeader: TStringGrid
          Left = 0
          Top = 41
          Width = 1033
          Height = 768
          Align = alClient
          ColCount = 4
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 200
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
          TabOrder = 1
          OnDblClick = grdHeaderDblClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Mail Types'
        ImageIndex = 1
        object vleMailType: TValueListEditor
          Left = 0
          Top = 0
          Width = 505
          Height = 809
          Align = alLeft
          TabOrder = 0
          TitleCaptions.Strings = (
            'Mail Type'
            'Description/Comment')
          OnSetEditText = vleMailTypeSetEditText
          ColWidths = (
            150
            349)
        end
        object Panel6: TPanel
          Left = 505
          Top = 0
          Width = 528
          Height = 809
          Align = alClient
          Color = clWhite
          TabOrder = 1
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Businesses'
        ImageIndex = 2
        object vleBusinesses: TValueListEditor
          Left = 0
          Top = 0
          Width = 569
          Height = 809
          Align = alLeft
          DisplayOptions = [doColumnTitles, doAutoColResize]
          KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
          TabOrder = 0
          TitleCaptions.Strings = (
            'Name'
            'Description/Comment')
          OnSetEditText = vleBusinessesSetEditText
          ColWidths = (
            150
            413)
        end
        object Panel5: TPanel
          Left = 569
          Top = 0
          Width = 464
          Height = 809
          Align = alClient
          Color = clWhite
          TabOrder = 1
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Bus/Mail Allocation'
        ImageIndex = 3
        object StringGrid1: TStringGrid
          Left = 0
          Top = 0
          Width = 1033
          Height = 768
          Align = alClient
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 200
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          TabOrder = 0
          OnDblClick = StringGrid1DblClick
        end
        object Panel3: TPanel
          Left = 0
          Top = 768
          Width = 1033
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object BitBtn4: TBitBtn
            Left = 32
            Top = 8
            Width = 97
            Height = 25
            Caption = 'Edit or Remove'
            TabOrder = 0
            OnClick = BitBtn4Click
          end
        end
      end
      object TabSheet5: TTabSheet
        Caption = 'Report'
        ImageIndex = 4
        OnShow = TabSheet5Show
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 1033
          Height = 29
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object BitBtn1: TBitBtn
            Left = 8
            Top = 2
            Width = 75
            Height = 25
            Caption = 'List'
            TabOrder = 0
            OnClick = BitBtn1Click
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000000000C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0000000848400000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000FFFF848400000000C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C084000000FFFF848400000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000000000000000000000FFFF84
              8400000000C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0000000C0C0C0C0C0C0
              00000000FFFF00FFFF00FFFF00FFFF00FFFF848400000000C0C0C0C0C0C00000
              00C0C0C0000000C0C0C0C0C0C0C0C0C000000000FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF000000C0C0C0C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C000000000FFFF848400000000840000000000000000C0C0C0C0C0C00000
              00C0C0C0000000C0C0C0C0C0C0C0C0C0C0C0C000000000FFFF00FFFF84840000
              0000C0C0C0C0C0C0C0C0C0000000C0C0C0C0C0C0C0C0C0000000C0C0C0000000
              00000000000000000000FFFF00FFFF848400000000C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C000000000FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF848400000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              00000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF848400000000C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000000000FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF848400000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              0000000000000000000000000000000000000000000000000000000000000000
              00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
          end
          object cmbLocalMailType: TComboBox
            Left = 464
            Top = 3
            Width = 145
            Height = 21
            ItemHeight = 13
            TabOrder = 1
            Text = 'cmbLocalMailType'
            Visible = False
          end
          object BitBtn2: TBitBtn
            Left = 288
            Top = 3
            Width = 153
            Height = 25
            Caption = 'Delete these messages'
            TabOrder = 2
            OnClick = BitBtn2Click
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
        object Panel9: TPanel
          Left = 0
          Top = 485
          Width = 1033
          Height = 127
          Align = alBottom
          Caption = 'Panel9'
          TabOrder = 1
          object StringGrid3: TStringGrid
            Left = 1
            Top = 29
            Width = 1031
            Height = 97
            Align = alClient
            ColCount = 3
            DefaultColWidth = 150
            DefaultRowHeight = 18
            FixedCols = 0
            RowCount = 150
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goHorzLine]
            TabOrder = 0
            OnDrawCell = StringGrid3DrawCell
          end
          object Panel12: TPanel
            Left = 1
            Top = 1
            Width = 1031
            Height = 28
            Align = alTop
            TabOrder = 1
            object Label6: TLabel
              Left = 23
              Top = 7
              Width = 77
              Height = 13
              Caption = 'Other Messages'
            end
          end
        end
        object Panel10: TPanel
          Left = 0
          Top = 29
          Width = 1033
          Height = 456
          Align = alClient
          Caption = 'Panel10'
          TabOrder = 2
          object StringGrid2: TStringGrid
            Left = 1
            Top = 29
            Width = 1031
            Height = 426
            Align = alClient
            ColCount = 3
            DefaultColWidth = 150
            DefaultRowHeight = 18
            FixedCols = 0
            RowCount = 150
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goHorzLine]
            TabOrder = 0
            OnDrawCell = StringGrid2DrawCell
          end
          object Panel11: TPanel
            Left = 1
            Top = 1
            Width = 1031
            Height = 28
            Align = alTop
            TabOrder = 1
            object Label5: TLabel
              Left = 23
              Top = 7
              Width = 82
              Height = 13
              Caption = 'Critical Messages'
            end
          end
        end
      end
      object TabSheet6: TTabSheet
        Caption = 'Message Header'
        ImageIndex = 5
        object Memo2: TMemo
          Left = 0
          Top = -149
          Width = 1033
          Height = 761
          Align = alBottom
          Lines.Strings = (
            'Memo2')
          TabOrder = 0
        end
        object Button2: TButton
          Left = 8
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Show Current'
          TabOrder = 1
          OnClick = Button2Click
        end
      end
      object TabSheet7: TTabSheet
        Caption = 'Database Log'
        ImageIndex = 6
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 1033
          Height = 41
          Align = alTop
          TabOrder = 0
          object vleParameters: TValueListEditor
            Left = 728
            Top = 0
            Width = 306
            Height = 300
            TabOrder = 0
          end
        end
        object Panel13: TPanel
          Left = 0
          Top = 768
          Width = 1033
          Height = 41
          Align = alBottom
          TabOrder = 1
        end
        object Panel14: TPanel
          Left = 0
          Top = 41
          Width = 1033
          Height = 727
          Align = alClient
          TabOrder = 2
        end
      end
      object TabSheet8: TTabSheet
        Caption = 'Mail Types DB'
        ImageIndex = 7
        object Panel15: TPanel
          Left = 0
          Top = 0
          Width = 1033
          Height = 41
          Align = alTop
          TabOrder = 0
          object DBNavigator1: TDBNavigator
            Left = 16
            Top = 8
            Width = 240
            Height = 25
            DataSource = dmData.srcMailTypes
            TabOrder = 0
          end
        end
        object Panel16: TPanel
          Left = 0
          Top = 41
          Width = 1033
          Height = 768
          Align = alClient
          TabOrder = 1
          object DBGrid1: TDBGrid
            Left = 1
            Top = 1
            Width = 1031
            Height = 766
            Align = alClient
            DataSource = dmData.srcMailTypes
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
          end
        end
      end
      object TabSheet9: TTabSheet
        Caption = 'Businesses DB'
        ImageIndex = 8
        object Panel17: TPanel
          Left = 0
          Top = 0
          Width = 1033
          Height = 41
          Align = alTop
          TabOrder = 0
          object DBNavigator2: TDBNavigator
            Left = 24
            Top = 8
            Width = 240
            Height = 25
            DataSource = dmData.srcCustomer
            TabOrder = 0
          end
        end
        object Panel18: TPanel
          Left = 0
          Top = 41
          Width = 1033
          Height = 768
          Align = alClient
          Caption = 'Panel18'
          TabOrder = 1
          object DBGrid2: TDBGrid
            Left = 1
            Top = 1
            Width = 1031
            Height = 766
            Align = alClient
            DataSource = dmData.srcCustomer
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
          end
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1043
    Height = 105
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 28
      Top = 11
      Width = 22
      Height = 13
      Caption = 'Host'
    end
    object Label2: TLabel
      Left = 31
      Top = 35
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label3: TLabel
      Left = 14
      Top = 59
      Width = 36
      Height = 13
      Caption = 'User ID'
    end
    object Label4: TLabel
      Left = 5
      Top = 83
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Button1: TButton
      Left = 230
      Top = 76
      Width = 75
      Height = 25
      Caption = 'Re Connect'
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 66
      Top = 7
      Width = 191
      Height = 21
      TabOrder = 1
      Text = 'mail.lexian.com.au'
    end
    object Edit2: TEdit
      Left = 66
      Top = 31
      Width = 36
      Height = 21
      TabOrder = 2
      Text = '110'
    end
    object Edit3: TEdit
      Left = 66
      Top = 55
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'kevin_gray@lexian.com.au'
    end
    object Edit4: TEdit
      Left = 66
      Top = 79
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 4
      Text = '8lexian9'
    end
  end
  object NMPOP31: TNMPOP3
    Port = 110
    ReportLevel = 0
    OnConnectionFailed = NMPOP31ConnectionFailed
    Parse = False
    DeleteOnRead = False
    Left = 276
    Top = 8
  end
end
