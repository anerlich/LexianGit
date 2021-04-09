object frmCopySalesHist: TfrmCopySalesHist
  Left = 32
  Top = 37
  Width = 918
  Height = 653
  Caption = 'Copy Product Details to Multiple Locations'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 600
    Width = 910
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
    Width = 910
    Height = 600
    Align = alClient
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 908
      Height = 560
      ActivePage = TabSheet1
      Align = alClient
      TabIndex = 0
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Locations'
        DesignSize = (
          900
          532)
        object Label5: TLabel
          Left = 24
          Top = 23
          Width = 198
          Height = 13
          Caption = 'Copy Details from the following location(s):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object GroupBox3: TGroupBox
          Left = 299
          Top = 26
          Width = 281
          Height = 369
          Caption = 'Sales History:'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 0
          object Shape1: TShape
            Left = 0
            Top = 34
            Width = 281
            Height = 2
            Brush.Color = clBlack
          end
          object cbCopySales: TCheckBox
            Left = 8
            Top = 16
            Width = 137
            Height = 17
            Caption = 'Copy Sales History'
            TabOrder = 0
            OnClick = cbCopySalesClick
          end
          object rgSalesAdd: TRadioGroup
            Left = 8
            Top = 48
            Width = 241
            Height = 64
            Caption = 'Replace or Add Target Product'
            Enabled = False
            ItemIndex = 0
            Items.Strings = (
              'Replace Target Sales with Source'
              'Add Source Sales to Target')
            TabOrder = 1
          end
          object rgSalesReplaceAdd: TRadioGroup
            Left = 8
            Top = 120
            Width = 241
            Height = 63
            Caption = 'Replace or Add'
            Enabled = False
            ItemIndex = 0
            Items.Strings = (
              'All History'
              'Specific Months')
            TabOrder = 2
            OnClick = rgSalesReplaceAddClick
          end
          object gbSalesMthFromTo: TGroupBox
            Left = 8
            Top = 264
            Width = 241
            Height = 88
            Caption = 'Starting Month'
            Enabled = False
            TabOrder = 3
            object Label2: TLabel
              Left = 12
              Top = 40
              Width = 37
              Height = 13
              Caption = 'Back to'
            end
            object cbSalesStartMth: TComboBox
              Left = 10
              Top = 16
              Width = 145
              Height = 21
              Enabled = False
              ItemHeight = 13
              TabOrder = 0
              OnChange = cbSalesStartMthChange
            end
            object cbSalesBacktoMth: TComboBox
              Left = 10
              Top = 56
              Width = 145
              Height = 21
              Enabled = False
              ItemHeight = 13
              TabOrder = 1
              OnChange = cbSalesStartMthChange
            end
          end
          object gbSalesMonths: TGroupBox
            Left = 8
            Top = 192
            Width = 241
            Height = 66
            Caption = 'Number of Months to Copy'
            Enabled = False
            TabOrder = 4
            object seSalesMths: TSpinEdit
              Left = 10
              Top = 20
              Width = 63
              Height = 22
              Enabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = seSalesMthsChange
            end
          end
        end
        object GroupBox4: TGroupBox
          Left = 595
          Top = 26
          Width = 281
          Height = 369
          Caption = 'Forecast:'
          Color = clSilver
          ParentColor = False
          TabOrder = 1
          object Shape2: TShape
            Left = 0
            Top = 34
            Width = 281
            Height = 2
            Brush.Color = clBlack
          end
          object cbCopyForecast: TCheckBox
            Left = 8
            Top = 16
            Width = 137
            Height = 17
            Caption = 'Copy Forecast'
            TabOrder = 0
            OnClick = cbCopyForecastClick
          end
          object rgFC_Add: TRadioGroup
            Left = 8
            Top = 42
            Width = 241
            Height = 64
            Caption = 'Replace or Add Target Product'
            Enabled = False
            ItemIndex = 0
            Items.Strings = (
              'Replace Target Forecast with Source'
              'Add Source Forecast to Target')
            TabOrder = 1
          end
          object rgFC_ReplaceAdd: TRadioGroup
            Left = 8
            Top = 115
            Width = 185
            Height = 63
            Caption = 'Replace or Add'
            Enabled = False
            ItemIndex = 0
            Items.Strings = (
              'All Forecasts'
              'Specific Months')
            TabOrder = 2
            OnClick = rgFC_ReplaceAddClick
          end
          object gbFC_MthFromTo: TGroupBox
            Left = 8
            Top = 262
            Width = 193
            Height = 88
            Caption = 'Starting Month'
            Enabled = False
            TabOrder = 3
            object Label4: TLabel
              Left = 12
              Top = 40
              Width = 50
              Height = 13
              Caption = 'Forward to'
            end
            object cbFC_StartMth: TComboBox
              Left = 10
              Top = 16
              Width = 145
              Height = 21
              Enabled = False
              ItemHeight = 13
              TabOrder = 0
              OnChange = cbFC_StartMthChange
            end
            object cbFC_ForwardToMth: TComboBox
              Left = 10
              Top = 56
              Width = 145
              Height = 21
              Enabled = False
              ItemHeight = 13
              TabOrder = 1
              OnChange = cbFC_StartMthChange
            end
          end
          object gbFC_Months: TGroupBox
            Left = 8
            Top = 188
            Width = 185
            Height = 66
            Caption = 'Number of Months to Copy'
            Enabled = False
            TabOrder = 4
            object seFC_Mths: TSpinEdit
              Left = 10
              Top = 20
              Width = 63
              Height = 22
              Enabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = seFC_MthsChange
            end
          end
        end
        object GroupBox7: TGroupBox
          Left = 299
          Top = 402
          Width = 577
          Height = 119
          Caption = 'Item Details:'
          Color = clSkyBlue
          ParentColor = False
          TabOrder = 2
          object cbPareto: TCheckBox
            Left = 8
            Top = 16
            Width = 137
            Height = 17
            Caption = 'Pareto'
            TabOrder = 0
          end
          object cbStockingIndicator: TCheckBox
            Left = 8
            Top = 40
            Width = 137
            Height = 17
            Caption = 'Stocking Indicator'
            TabOrder = 1
          end
          object cbCriticality: TCheckBox
            Left = 8
            Top = 64
            Width = 137
            Height = 17
            Caption = 'Criticality'
            TabOrder = 2
          end
          object cbBinLevel: TCheckBox
            Left = 296
            Top = 16
            Width = 137
            Height = 17
            Caption = 'Bin Level'
            TabOrder = 3
          end
          object cbMOQ: TCheckBox
            Left = 296
            Top = 40
            Width = 137
            Height = 17
            Caption = 'MOQ/Multiples'
            TabOrder = 4
          end
          object cbSupplier: TCheckBox
            Left = 296
            Top = 64
            Width = 137
            Height = 17
            Caption = 'Supplier Code'
            TabOrder = 5
          end
        end
        object clbLocations: TCheckListBox
          Left = 24
          Top = 42
          Width = 257
          Height = 447
          OnClickCheck = clbLocationsClickCheck
          Anchors = [akLeft, akTop, akBottom]
          ItemHeight = 13
          TabOrder = 3
        end
        object btnAllFrom: TButton
          Left = 24
          Top = 504
          Width = 75
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = 'Select All'
          TabOrder = 4
          OnClick = btnAllFromClick
        end
        object btnClearFrom: TButton
          Left = 208
          Top = 504
          Width = 75
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = 'Clear all'
          TabOrder = 5
          OnClick = btnClearFromClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Products'
        ImageIndex = 1
        DesignSize = (
          900
          532)
        object Label1: TLabel
          Left = 384
          Top = 490
          Width = 179
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Click and drag item to source or target'
        end
        object btnDeleteProductCodeLine: TBitBtn
          Left = 149
          Top = 499
          Width = 75
          Height = 25
          Hint = 'Delete Current Row'
          Anchors = [akLeft, akBottom]
          Caption = 'Delete'
          TabOrder = 0
          OnClick = btnDeleteProductCodeLineClick
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
        object grdFromToProductCodes: TStringGrid
          Left = 9
          Top = 8
          Width = 328
          Height = 475
          Hint = 'Drag and drop the product code from the search results'
          Anchors = [akLeft, akTop, akBottom]
          ColCount = 2
          DefaultColWidth = 160
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          TabOrder = 1
          OnDragDrop = grdFromToProductCodesDragDrop
          OnDragOver = grdFromToProductCodesDragOver
        end
        object btnAddProductCodeLine: TBitBtn
          Left = 1
          Top = 499
          Width = 75
          Height = 25
          Hint = 'Add Empty Row'
          Anchors = [akLeft, akBottom]
          Caption = 'Add'
          TabOrder = 2
          OnClick = btnAddProductCodeLineClick
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
        object grdProductCodes: TMyDBGrid
          Left = 384
          Top = 80
          Width = 489
          Height = 403
          Hint = 'Drag and drop the product code on the product list'
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dmCopySalesHist.srcSearchProduct
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnMouseDown = grdProductCodesMouseDown
          Row = 1
        end
        object dbnProductCodes: TDBNavigator
          Left = 384
          Top = 42
          Width = 224
          Height = 25
          DataSource = dmCopySalesHist.srcSearchProduct
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          TabOrder = 4
        end
        object edtProductCode: TEdit
          Left = 384
          Top = 10
          Width = 161
          Height = 21
          Hint = 'Enter the full or partial product code'
          TabOrder = 5
          OnExit = edtProductCodeExit
          OnKeyPress = edtProductCodeKeyPress
        end
        object btnFind: TBitBtn
          Left = 551
          Top = 8
          Width = 75
          Height = 25
          Hint = 'Find a Product Code'
          Caption = 'Find'
          Default = True
          TabOrder = 6
          OnClick = btnFindClick
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
        object btnHelp: TBitBtn
          Left = 566
          Top = 499
          Width = 75
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Help'
          TabOrder = 7
          OnClick = btnHelpClick
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
      Top = 561
      Width = 908
      Height = 38
      Align = alBottom
      TabOrder = 1
      object btnCopy: TBitBtn
        Left = 396
        Top = 5
        Width = 75
        Height = 25
        Hint = 'Run the Sales History Copy for the given criteria'
        Caption = 'Copy'
        ModalResult = 1
        TabOrder = 0
        OnClick = btnCopyClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
      object btnCancel: TBitBtn
        Left = 480
        Top = 5
        Width = 75
        Height = 25
        TabOrder = 1
        OnClick = btnCancelClick
        Kind = bkCancel
      end
    end
  end
end
