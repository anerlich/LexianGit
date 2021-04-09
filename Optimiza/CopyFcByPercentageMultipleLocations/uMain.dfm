object frmMain: TfrmMain
  Left = 438
  Top = 152
  Width = 815
  Height = 607
  Caption = 'Forecast Copy Utility'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 807
    Height = 554
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Criteria'
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
      object Panel4: TPanel
        Left = 0
        Top = 262
        Width = 799
        Height = 264
        Align = alBottom
        TabOrder = 0
        object CheckBox1: TCheckBox
          Left = 8
          Top = 6
          Width = 97
          Height = 17
          Caption = 'Copy Forecasts'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 0
          OnClick = CheckBox1Click
        end
        object GroupBox2: TGroupBox
          Left = 8
          Top = 24
          Width = 489
          Height = 233
          Caption = 'Forecasts'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 1
          object grpMonth: TRadioGroup
            Left = 32
            Top = 24
            Width = 185
            Height = 115
            Caption = 'Number of Months to copy'
            ItemIndex = 1
            Items.Strings = (
              '6 Months '
              '12 Months '
              '18 Months '
              '24 Months ')
            TabOrder = 0
          end
          object GroupBox1: TGroupBox
            Left = 32
            Top = 142
            Width = 185
            Height = 73
            Caption = 'Starting Month'
            TabOrder = 1
            object ComboBox1: TComboBox
              Left = 13
              Top = 29
              Width = 145
              Height = 21
              ItemHeight = 13
              TabOrder = 0
            end
          end
          object grpAdd: TRadioGroup
            Left = 234
            Top = 63
            Width = 241
            Height = 72
            Caption = 'Replace or Add to Target Product'
            ItemIndex = 0
            Items.Strings = (
              'Replace Target Forecast with Source'
              'Add Source Forecast to Target')
            TabOrder = 2
          end
          object chkFreeze: TCheckBox
            Left = 242
            Top = 27
            Width = 225
            Height = 17
            Caption = 'Freeze Forecasts for Target Product'
            TabOrder = 3
          end
        end
        object Panel6: TPanel
          Left = 504
          Top = 8
          Width = 289
          Height = 209
          TabOrder = 2
          Visible = False
          object Label1: TLabel
            Left = 6
            Top = 7
            Width = 268
            Height = 13
            Caption = 'NON Visible Panel - leave, maybe enhancement required'
          end
          object CheckBox2: TCheckBox
            Left = 32
            Top = 25
            Width = 97
            Height = 17
            Caption = 'Copy Sales'
            TabOrder = 0
            OnClick = CheckBox2Click
          end
          object GroupBox3: TGroupBox
            Left = 16
            Top = 52
            Width = 257
            Height = 133
            Caption = 'Sales'
            TabOrder = 1
            object RadioGroup1: TRadioGroup
              Left = 8
              Top = 20
              Width = 241
              Height = 89
              Caption = 'Replace or Add to Target Product'
              ItemIndex = 1
              Items.Strings = (
                'Replace Target Sales with Source'
                'Add Source Sales to Target')
              TabOrder = 0
            end
          end
        end
      end
      object CheckListBox1: TCheckListBox
        Left = 21
        Top = 32
        Width = 257
        Height = 227
        ItemHeight = 13
        TabOrder = 1
      end
      object BitBtn5: TBitBtn
        Left = 288
        Top = 208
        Width = 75
        Height = 25
        Caption = 'Select All'
        TabOrder = 2
        OnClick = BitBtn5Click
      end
      object BitBtn6: TBitBtn
        Left = 288
        Top = 240
        Width = 75
        Height = 25
        Caption = 'Unselect All'
        TabOrder = 3
        OnClick = BitBtn6Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Products'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 430
        Top = 0
        Width = 3
        Height = 526
        Cursor = crHSplit
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 430
        Height = 526
        Align = alLeft
        TabOrder = 0
        object Label6: TLabel
          Left = 13
          Top = 242
          Width = 24
          Height = 13
          Caption = 'Copy'
        end
        object Label7: TLabel
          Left = 115
          Top = 242
          Width = 234
          Height = 13
          Caption = '% of Source Product'#39's Forecast to Target Product'
        end
        object Label8: TLabel
          Left = 13
          Top = 268
          Width = 390
          Height = 13
          Caption = 
            'Increase example. Copy % of 120 , where Forecast = 100, will yie' +
            'ld Forecast of 120'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 13
          Top = 289
          Width = 383
          Height = 13
          Caption = 
            'Decrease example. Copy % of 90 , where Forecast = 100, will yiel' +
            'd Forecast of 90'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object GroupBox4: TGroupBox
          Left = 8
          Top = 16
          Width = 298
          Height = 208
          Caption = 'Source Product'
          TabOrder = 0
          object Edit2: TEdit
            Left = 8
            Top = 21
            Width = 179
            Height = 21
            Hint = 'Enter the partial code and click on the Find button'
            TabOrder = 0
            OnChange = Edit2Change
          end
          object BitBtn8: TBitBtn
            Left = 192
            Top = 19
            Width = 75
            Height = 25
            Hint = 'Find the SKU'
            Caption = 'Find'
            TabOrder = 1
            OnClick = BitBtn8Click
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
          object DBGrid1: TDBGrid
            Left = 8
            Top = 51
            Width = 281
            Height = 120
            Color = clInfoBk
            DataSource = dmData.srcSrcProd
            Options = [dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
            ReadOnly = True
            TabOrder = 2
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid1CellClick
            Columns = <
              item
                Expanded = False
                FieldName = 'PRODUCTCODE'
                Width = 120
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRODUCTDESCRIPTION'
                Width = 165
                Visible = True
              end>
          end
          object DBNavigator1: TDBNavigator
            Left = 8
            Top = 176
            Width = 132
            Height = 25
            DataSource = dmData.srcSrcProd
            VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
            TabOrder = 3
          end
        end
        object GroupBox7: TGroupBox
          Left = 8
          Top = 313
          Width = 298
          Height = 208
          Caption = 'Target Product'
          TabOrder = 1
          object Edit1: TEdit
            Left = 8
            Top = 21
            Width = 179
            Height = 21
            Hint = 'Enter the partial code and click on the Find button'
            TabOrder = 0
          end
          object BitBtn1: TBitBtn
            Left = 192
            Top = 19
            Width = 75
            Height = 25
            Hint = 'Find the SKU'
            Caption = 'Find'
            TabOrder = 1
            OnClick = BitBtn1Click
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
          object DBGrid2: TDBGrid
            Left = 8
            Top = 51
            Width = 281
            Height = 120
            Color = clInfoBk
            DataSource = dmData.srcTgtProd
            Options = [dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
            ReadOnly = True
            TabOrder = 2
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnCellClick = DBGrid2CellClick
            Columns = <
              item
                Expanded = False
                FieldName = 'PRODUCTCODE'
                Width = 120
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PRODUCTDESCRIPTION'
                Width = 165
                Visible = True
              end>
          end
          object DBNavigator2: TDBNavigator
            Left = 8
            Top = 176
            Width = 132
            Height = 25
            DataSource = dmData.srcTgtProd
            VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
            TabOrder = 3
          end
        end
        object BitBtn2: TBitBtn
          Left = 313
          Top = 491
          Width = 113
          Height = 25
          Caption = 'Add to Copy List'
          TabOrder = 2
          OnClick = BitBtn2Click
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
        object edtPercentage: TExtEdit
          Left = 51
          Top = 239
          Width = 52
          Height = 21
          TabOrder = 3
          Text = '100'
          Format = '000.00'
          Kind = eekFloat
          Valid = valNone
          MinValue = 1
          MaxValue = 500
          Value = 100
          FormatOnExit = False
          PlaneOnEnter = False
          ValidOnExit = False
        end
      end
      object Panel2: TPanel
        Left = 433
        Top = 0
        Width = 366
        Height = 526
        Align = alClient
        Caption = 'Panel2'
        TabOrder = 1
        object Panel3: TPanel
          Left = 1
          Top = 484
          Width = 364
          Height = 41
          Align = alBottom
          TabOrder = 0
          object BitBtn3: TBitBtn
            Left = 32
            Top = 8
            Width = 129
            Height = 25
            Caption = 'Delete From List'
            TabOrder = 0
            OnClick = BitBtn3Click
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
          object BitBtn4: TBitBtn
            Left = 208
            Top = 8
            Width = 131
            Height = 25
            Caption = 'Run Forecast Copy'
            TabOrder = 1
            OnClick = BitBtn4Click
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
        end
        object StringGrid1: TStringGrid
          Left = 1
          Top = 29
          Width = 364
          Height = 455
          Align = alClient
          ColCount = 3
          DefaultColWidth = 112
          DefaultRowHeight = 20
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          TabOrder = 1
        end
        object Panel5: TPanel
          Left = 1
          Top = 1
          Width = 364
          Height = 28
          Align = alTop
          BevelOuter = bvLowered
          Caption = 'Copy List'
          TabOrder = 2
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 554
    Width = 807
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
end
