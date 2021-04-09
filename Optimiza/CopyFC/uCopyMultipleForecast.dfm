object frmCopyForecast: TfrmCopyForecast
  Left = 270
  Top = 203
  Width = 573
  Height = 421
  Caption = 'Copy Forecast to Multiple Locations'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 368
    Width = 565
    Height = 19
    Panels = <
      item
        Text = 'Database'
        Width = 100
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 565
    Height = 368
    Align = alClient
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 563
      Height = 328
      ActivePage = TabSheet3
      Align = alClient
      TabIndex = 0
      TabOrder = 0
      object TabSheet3: TTabSheet
        Caption = 'Parameters'
        ImageIndex = 2
        object grpMonth: TRadioGroup
          Left = 32
          Top = 24
          Width = 185
          Height = 169
          Caption = 'Number of Months to copy'
          ItemIndex = 0
          Items.Strings = (
            '6 Months '
            '12 Months '
            '18 Months '
            '24 Months ')
          TabOrder = 0
        end
        object chkFreeze: TCheckBox
          Left = 280
          Top = 64
          Width = 225
          Height = 17
          Caption = 'Freeze Forecasts for Target Product'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object grpAdd: TRadioGroup
          Left = 272
          Top = 96
          Width = 241
          Height = 89
          Caption = 'Replace or Add Target Product'
          ItemIndex = 0
          Items.Strings = (
            'Replace Target Forecast with Source'
            'Add Source Forecast to Target')
          TabOrder = 2
        end
        object GroupBox1: TGroupBox
          Left = 32
          Top = 200
          Width = 185
          Height = 73
          Caption = 'Starting Month'
          TabOrder = 3
          object ComboBox1: TComboBox
            Left = 13
            Top = 29
            Width = 145
            Height = 21
            ItemHeight = 13
            TabOrder = 0
          end
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Locations'
        object Label3: TLabel
          Left = 13
          Top = 5
          Width = 195
          Height = 13
          Caption = 'Copy Forecasts to the following locations:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object CheckListBox1: TCheckListBox
          Left = 21
          Top = 32
          Width = 257
          Height = 217
          ItemHeight = 13
          TabOrder = 0
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Products'
        ImageIndex = 1
        object BitBtn4: TBitBtn
          Left = 89
          Top = 274
          Width = 75
          Height = 25
          Hint = 'Delete Current Row'
          Caption = 'Delete'
          TabOrder = 0
          OnClick = BitBtn4Click
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
        object StringGrid1: TStringGrid
          Left = 9
          Top = 8
          Width = 224
          Height = 261
          Hint = 'Drag and drop the product code from the search results'
          ColCount = 2
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          TabOrder = 1
          OnDragDrop = StringGrid1DragDrop
          OnDragOver = StringGrid1DragOver
          ColWidths = (
            102
            92)
        end
        object BitBtn5: TBitBtn
          Left = 9
          Top = 274
          Width = 75
          Height = 25
          Hint = 'Add Empty Row'
          Caption = 'Add'
          TabOrder = 2
          OnClick = BitBtn5Click
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
        object MyDBGrid1: TMyDBGrid
          Left = 256
          Top = 80
          Width = 289
          Height = 189
          Hint = 'Drag and drop the product code on the product list'
          DataSource = dmCopyForecast.srcSearchProduct
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnMouseDown = MyDBGrid1MouseDown
          Row = 1
        end
        object DBNavigator1: TDBNavigator
          Left = 256
          Top = 42
          Width = 224
          Height = 25
          DataSource = dmCopyForecast.srcSearchProduct
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          TabOrder = 4
        end
        object Edit1: TEdit
          Left = 256
          Top = 10
          Width = 161
          Height = 21
          Hint = 'Enter the full or partial product code'
          TabOrder = 5
          Text = 'A'
          OnExit = Edit1Exit
        end
        object BitBtn3: TBitBtn
          Left = 423
          Top = 8
          Width = 75
          Height = 25
          Hint = 'Find a Product Code'
          Caption = 'Find'
          TabOrder = 6
          OnClick = BitBtn3Click
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
            0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C0000000000000000000000000000000000000000000C0C0C00000000000FFFF
            FF00000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C00000000000FFFFFF00000000000000000000000000C0C0C00000000000FFFF
            FF00000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C00000000000FFFFFF00000000000000000000000000C0C0C000000000000000
            00000000000000000000000000000000000000000000C0C0C000000000000000
            00000000000000000000000000000000000000000000C0C0C000000000000000
            0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
            FF000000000000000000000000000000000000000000C0C0C000000000000000
            0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
            FF000000000000000000000000000000000000000000C0C0C000000000000000
            0000FFFFFF00000000000000000000000000C0C0C0000000000000000000FFFF
            FF000000000000000000000000000000000000000000C0C0C000C0C0C0000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
            C00000000000FFFFFF00000000000000000000000000C0C0C00000000000FFFF
            FF00000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C0000000000000000000000000000000000000000000C0C0C000000000000000
            0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000000000000000000000000000C0C0C000C0C0C000C0C0C0000000
            00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C00000000000FFFFFF0000000000C0C0C000C0C0C000C0C0C0000000
            0000FFFFFF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000000000000000000000000000C0C0C000C0C0C000C0C0C0000000
            00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
        end
        object BitBtn6: TBitBtn
          Left = 470
          Top = 274
          Width = 75
          Height = 25
          Caption = 'Help'
          TabOrder = 7
          OnClick = BitBtn6Click
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000808080008080800080808000808080008080
            80000000000000FFFF000000000080808000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C0000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00000000000000000080808000C0C0C000C0C0C000C0C0
            C00000000000FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
            FF0000FFFF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00800000008000
            0000FFFFFF00FFFFFF0000FFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
            FF0000FFFF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00800000008080
            8000FFFFFF00FFFFFF0000FFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFFFF00808080008000
            0000C0C0C000FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF008080
            8000800000008080800000FFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF00FFFFFF00FFFFFF008000000080808000FFFFFF00FFFF
            FF008000000080000000FFFFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF0000FFFF00FFFFFF00800000008000000000FFFF00C0C0
            C000800000008000000000FFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF00FFFFFF00FFFFFF00C0C0C00080000000800000008000
            000080000000C0C0C000FFFFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFF
            FF00FFFFFF00FFFFFF0000FFFF00FFFFFF000000000080808000C0C0C000C0C0
            C00000000000FFFFFF00FFFFFF00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFF
            FF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0
            C000C0C0C0000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000C0C0C000C0C0C000}
        end
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 329
      Width = 563
      Height = 38
      Align = alBottom
      TabOrder = 1
      object BitBtn1: TBitBtn
        Left = 396
        Top = 5
        Width = 75
        Height = 25
        Hint = 'Run the Sales History Copy for the given criteria'
        Caption = 'Copy'
        TabOrder = 0
        OnClick = BitBtn1Click
        Kind = bkOK
      end
      object BitBtn2: TBitBtn
        Left = 480
        Top = 5
        Width = 75
        Height = 25
        TabOrder = 1
        OnClick = BitBtn2Click
        Kind = bkCancel
      end
    end
  end
end
