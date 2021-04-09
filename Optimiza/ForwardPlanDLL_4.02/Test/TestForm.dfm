object Form1: TForm1
  Left = 343
  Top = 272
  Width = 862
  Height = 640
  Caption = 'New forward plan test engine'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label12: TLabel
    Left = 488
    Top = 560
    Width = 72
    Height = 13
    Caption = 'Backorder ratio'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 97
    Width = 854
    Height = 509
    ActivePage = tabConfig
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    object tabCalendar: TTabSheet
      Caption = 'Calendar'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 846
        Height = 488
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 846
          Height = 56
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
        end
        object DBGrid1: TDBGrid
          Left = 0
          Top = 56
          Width = 846
          Height = 432
          Align = alClient
          DataSource = dmTest.dscTest
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'DAYNO'
              Title.Caption = 'Day'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 27
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STARTDATE'
              Title.Caption = 'Date'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 56
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CALENDARNO'
              Title.Caption = 'Cal'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 34
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'WEEKNO'
              Title.Caption = 'Week'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DVAL'
              Title.Caption = 'Factor'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 41
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FC'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DRPFC'
              Title.Caption = 'DRP FC'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 51
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BOMFC'
              Title.Caption = 'BOM FC'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CO'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 30
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PO'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 39
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'OPENING'
              Title.Caption = 'Open'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLOSING'
              Title.Caption = 'Close'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ORDERS'
              Title.Caption = 'Orders'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'RECEIPTS'
              Title.Caption = 'Receipts'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'BO'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOSTSALES'
              Title.Caption = 'Lost sales'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MINIMUM'
              Title.Caption = 'SS'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MAXIMUM'
              Title.Caption = 'SS+RC'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EXCESS'
              Title.Caption = 'Excess'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Visible = True
            end>
        end
      end
    end
    object tabConfig: TTabSheet
      Caption = 'Config data'
      ImageIndex = 1
      object Label3: TLabel
        Left = 8
        Top = 8
        Width = 103
        Height = 13
        Caption = 'Config parameters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 56
        Top = 40
        Width = 72
        Height = 13
        Alignment = taRightJustify
        Caption = 'Download date'
      end
      object Label6: TLabel
        Left = 62
        Top = 64
        Width = 66
        Height = 13
        Alignment = taRightJustify
        Caption = 'Current period'
      end
      object Label7: TLabel
        Left = 40
        Top = 88
        Width = 88
        Height = 13
        Alignment = taRightJustify
        Caption = 'Periods to forecast'
      end
      object Label8: TLabel
        Left = 61
        Top = 112
        Width = 67
        Height = 13
        Alignment = taRightJustify
        Caption = 'Days in period'
      end
      object Label9: TLabel
        Left = 57
        Top = 136
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'Avg Fc periods'
      end
      object Label11: TLabel
        Left = 54
        Top = 160
        Width = 74
        Height = 13
        Alignment = taRightJustify
        Caption = 'First period ratio'
      end
      object Label20: TLabel
        Left = 680
        Top = 88
        Width = 63
        Height = 13
        Caption = 'Fwd PO days'
      end
      object Label4: TLabel
        Left = 473
        Top = 368
        Width = 72
        Height = 13
        Alignment = taRightJustify
        Caption = 'Backorder ratio'
      end
      object Label10: TLabel
        Left = 446
        Top = 400
        Width = 99
        Height = 13
        Alignment = taRightJustify
        Caption = 'BOM Backorder ratio'
      end
      object Label13: TLabel
        Left = 647
        Top = 368
        Width = 98
        Height = 13
        Alignment = taRightJustify
        Caption = 'DRP Backorder ratio'
      end
      object Label14: TLabel
        Left = 655
        Top = 400
        Width = 90
        Height = 13
        Alignment = taRightJustify
        Caption = 'CO Backorder ratio'
      end
      object Label32: TLabel
        Left = 4
        Top = 184
        Width = 124
        Height = 13
        Alignment = taRightJustify
        Caption = 'Min no days for ideal order'
      end
      object Label39: TLabel
        Left = 440
        Top = 192
        Width = 99
        Height = 13
        Caption = 'Fixed horizon periods'
      end
      object Label43: TLabel
        Left = 448
        Top = 440
        Width = 124
        Height = 13
        Caption = 'Redistributable stock level'
      end
      object edtCurrPeriod: TEdit
        Left = 136
        Top = 64
        Width = 73
        Height = 21
        TabOrder = 0
        Text = 'edtCurrPeriod'
      end
      object edtNoPeriodsFc: TEdit
        Left = 136
        Top = 88
        Width = 73
        Height = 21
        TabOrder = 1
        Text = 'edtNoPeriodsFc'
      end
      object edtDaysInPeriod: TEdit
        Left = 136
        Top = 112
        Width = 73
        Height = 21
        TabOrder = 2
        Text = 'edtDaysInPeriod'
      end
      object edtAvgFCPeriods: TEdit
        Left = 136
        Top = 136
        Width = 73
        Height = 21
        TabOrder = 3
        Text = 'edtAvgFCPeriods'
      end
      object edtFirstPeriodRatio: TEdit
        Left = 136
        Top = 160
        Width = 73
        Height = 21
        TabOrder = 4
        Text = 'edtFirstPeriodRatio'
      end
      object cbUseMOQ: TCheckBox
        Left = 440
        Top = 64
        Width = 97
        Height = 17
        Caption = 'Use MOQs'
        TabOrder = 13
      end
      object cbUseMult: TCheckBox
        Left = 440
        Top = 88
        Width = 97
        Height = 17
        Caption = 'Use multiples'
        TabOrder = 14
      end
      object cbZeroNeg: TCheckBox
        Left = 440
        Top = 112
        Width = 121
        Height = 17
        Caption = 'Zero negative stock'
        TabOrder = 15
      end
      object cbUseDependant: TCheckBox
        Left = 680
        Top = 16
        Width = 145
        Height = 17
        Caption = 'Use dependant FC in SS'
        TabOrder = 16
      end
      object edtPODays: TEdit
        Left = 752
        Top = 88
        Width = 73
        Height = 21
        TabOrder = 19
        Text = 'edtPODays'
      end
      object cbUseBOM: TCheckBox
        Left = 680
        Top = 40
        Width = 97
        Height = 17
        Caption = 'Use BOM'
        TabOrder = 17
      end
      object cbUseDRP: TCheckBox
        Left = 680
        Top = 64
        Width = 97
        Height = 17
        Caption = 'Use DRP'
        TabOrder = 18
      end
      object rgProrateFC: TRadioGroup
        Left = 8
        Top = 208
        Width = 385
        Height = 33
        Caption = 'Prorate forecast'
        Columns = 3
        Items.Strings = (
          'Prorate'
          'Sales to date'
          'Full')
        TabOrder = 6
      end
      object rgOverrideCO: TRadioGroup
        Left = 8
        Top = 248
        Width = 385
        Height = 33
        Caption = 'Overdue COs'
        Columns = 3
        Items.Strings = (
          'Backordered'
          'In first'
          'Ignored')
        TabOrder = 7
      end
      object rgDateCO: TRadioGroup
        Left = 8
        Top = 288
        Width = 385
        Height = 33
        Caption = 'Date used for overdue COs'
        Columns = 2
        Items.Strings = (
          'Stock download date'
          'Current period start date')
        TabOrder = 8
      end
      object rgCO: TRadioGroup
        Left = 8
        Top = 328
        Width = 385
        Height = 33
        Caption = 'Customer orders'
        Columns = 3
        Items.Strings = (
          'Ignore'
          'Add to forecast'
          'Included in forecast')
        TabOrder = 9
      end
      object rgCOOverride: TRadioGroup
        Left = 8
        Top = 368
        Width = 385
        Height = 33
        Caption = 'CO override'
        Columns = 3
        Items.Strings = (
          'Day'
          'Week'
          'Period')
        TabOrder = 10
      end
      object rbMOQRound: TRadioGroup
        Left = 440
        Top = 232
        Width = 385
        Height = 33
        Caption = 'MOQ rounding'
        Columns = 3
        Items.Strings = (
          'Up'
          'Nearest'
          'Down')
        TabOrder = 20
      end
      object rgMultRound: TRadioGroup
        Left = 440
        Top = 272
        Width = 385
        Height = 33
        Caption = 'Multiples rounding'
        Columns = 3
        Items.Strings = (
          'Up'
          'Nearest'
          'Down')
        TabOrder = 21
      end
      object rgTypeOrder: TRadioGroup
        Left = 440
        Top = 312
        Width = 385
        Height = 33
        Caption = 'Type of ordering'
        Columns = 3
        Items.Strings = (
          'Reorder'
          'Top up'
          'Automatic')
        TabOrder = 22
      end
      object cbExcessUses: TCheckBox
        Left = 680
        Top = 112
        Width = 97
        Height = 17
        Caption = 'Excess uses RC'
        TabOrder = 23
      end
      object edtBackorderRatio: TEdit
        Left = 552
        Top = 368
        Width = 57
        Height = 21
        TabOrder = 24
        Text = 'edtBackorderRatio'
      end
      object edtBOMBackorderRatio: TEdit
        Left = 552
        Top = 400
        Width = 57
        Height = 21
        TabOrder = 25
        Text = 'edtBackorderRatio'
      end
      object edtCOBackorderRatio: TEdit
        Left = 752
        Top = 400
        Width = 57
        Height = 21
        TabOrder = 27
        Text = 'edtBackorderRatio'
      end
      object edtDRPBackorderRatio: TEdit
        Left = 752
        Top = 368
        Width = 57
        Height = 21
        TabOrder = 26
        Text = 'edtBackorderRatio'
      end
      object cbUseMin: TCheckBox
        Left = 440
        Top = 40
        Width = 241
        Height = 17
        Caption = 'Use minimum stock (Stocked A - F items only)'
        TabOrder = 12
      end
      object cbFixedLevels: TCheckBox
        Left = 440
        Top = 16
        Width = 225
        Height = 17
        Caption = 'Use fixed levels (Stocked A - F items only)'
        TabOrder = 11
      end
      object edtMinimumDays: TEdit
        Left = 136
        Top = 184
        Width = 73
        Height = 21
        TabOrder = 5
        Text = 'edtMinimumDays'
      end
      object rgTypeSim: TRadioGroup
        Left = 440
        Top = 144
        Width = 385
        Height = 33
        Caption = 'Type of simulation'
        Columns = 4
        Items.Strings = (
          'Current'
          'Projected'
          'Ideal'
          'Fixed')
        TabOrder = 28
        OnClick = rgTypeSimClick
      end
      object edtFixedHorizon: TEdit
        Left = 544
        Top = 192
        Width = 41
        Height = 21
        Enabled = False
        TabOrder = 29
        Text = '0'
      end
      object grpNonStockModel: TRadioGroup
        Left = 8
        Top = 408
        Width = 385
        Height = 73
        Caption = 'Model calculation for non - stocked items'
        Items.Strings = (
          'Set to zero'
          'Use lead time'
          'Use half a review period')
        TabOrder = 30
      end
      object edtRedistLevel: TEdit
        Left = 584
        Top = 440
        Width = 49
        Height = 21
        TabOrder = 31
        Text = '0'
      end
      object edtDD: TDateTimePicker
        Left = 136
        Top = 40
        Width = 113
        Height = 22
        CalAlignment = dtaLeft
        Date = 37594.3550727546
        Time = 37594.3550727546
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 32
      end
    end
    object tabItem: TTabSheet
      Caption = 'Item data'
      ImageIndex = 2
      object Label15: TLabel
        Left = 24
        Top = 40
        Width = 31
        Height = 13
        Caption = 'Pareto'
      end
      object Label17: TLabel
        Left = 24
        Top = 72
        Width = 62
        Height = 13
        Caption = 'Sales to date'
      end
      object Label18: TLabel
        Left = 24
        Top = 104
        Width = 39
        Height = 13
        Caption = 'SS days'
      end
      object Label19: TLabel
        Left = 24
        Top = 136
        Width = 40
        Height = 13
        Caption = 'RC days'
      end
      object Label21: TLabel
        Left = 24
        Top = 168
        Width = 40
        Height = 13
        Caption = 'RP days'
      end
      object Label22: TLabel
        Left = 24
        Top = 200
        Width = 38
        Height = 13
        Caption = 'LT days'
      end
      object Label24: TLabel
        Left = 416
        Top = 72
        Width = 70
        Height = 13
        Caption = 'Stock on hand'
      end
      object Label25: TLabel
        Left = 416
        Top = 104
        Width = 54
        Height = 13
        Caption = 'Backorders'
      end
      object Label26: TLabel
        Left = 416
        Top = 136
        Width = 129
        Height = 13
        Caption = 'Consolidated branch orders'
      end
      object Label16: TLabel
        Left = 416
        Top = 168
        Width = 40
        Height = 13
        Caption = 'Bin level'
      end
      object Label27: TLabel
        Left = 416
        Top = 200
        Width = 25
        Height = 13
        Caption = 'MOQ'
      end
      object Label28: TLabel
        Left = 416
        Top = 232
        Width = 69
        Height = 13
        Caption = 'Order multiples'
      end
      object Label29: TLabel
        Left = 416
        Top = 272
        Width = 81
        Height = 13
        Caption = 'Minimum quantity'
      end
      object Label30: TLabel
        Left = 24
        Top = 264
        Width = 42
        Height = 13
        Caption = 'Fixed SS'
      end
      object Label31: TLabel
        Left = 24
        Top = 296
        Width = 57
        Height = 13
        Caption = 'Fixed SSRC'
      end
      object Label33: TLabel
        Left = 24
        Top = 376
        Width = 78
        Height = 13
        Caption = 'Ideal arrival date'
      end
      object Label38: TLabel
        Left = 24
        Top = 232
        Width = 73
        Height = 13
        Caption = 'Transit LT days'
      end
      object Label44: TLabel
        Left = 416
        Top = 296
        Width = 72
        Height = 13
        Caption = 'Backorder ratio'
      end
      object Label45: TLabel
        Left = 416
        Top = 328
        Width = 99
        Height = 13
        Caption = 'BOM Backorder ratio'
      end
      object Label46: TLabel
        Left = 416
        Top = 360
        Width = 98
        Height = 13
        Caption = 'DRP Backorder ratio'
      end
      object cbStocked: TCheckBox
        Left = 24
        Top = 8
        Width = 97
        Height = 17
        Caption = 'Stocked'
        TabOrder = 0
      end
      object edtSTD: TEdit
        Left = 120
        Top = 72
        Width = 121
        Height = 21
        TabOrder = 9
      end
      object edtSOH: TEdit
        Left = 576
        Top = 72
        Width = 89
        Height = 21
        TabOrder = 17
      end
      object edtBO: TEdit
        Left = 576
        Top = 104
        Width = 89
        Height = 21
        TabOrder = 18
      end
      object edtCBO: TEdit
        Left = 576
        Top = 136
        Width = 89
        Height = 21
        TabOrder = 19
      end
      object edtBinLevel: TEdit
        Left = 576
        Top = 168
        Width = 89
        Height = 21
        TabOrder = 20
      end
      object edtMOQ: TEdit
        Left = 576
        Top = 200
        Width = 89
        Height = 21
        TabOrder = 21
      end
      object edtOrderMult: TEdit
        Left = 576
        Top = 232
        Width = 89
        Height = 21
        TabOrder = 22
      end
      object edtSSDays: TEdit
        Left = 120
        Top = 104
        Width = 80
        Height = 21
        TabOrder = 10
      end
      object edtRCDays: TEdit
        Left = 120
        Top = 136
        Width = 80
        Height = 21
        TabOrder = 11
      end
      object edtRPDays: TEdit
        Left = 120
        Top = 168
        Width = 80
        Height = 21
        TabOrder = 12
      end
      object edtLTDays: TEdit
        Left = 120
        Top = 200
        Width = 80
        Height = 21
        TabOrder = 13
      end
      object rbAPareto: TRadioButton
        Left = 96
        Top = 40
        Width = 33
        Height = 17
        Caption = 'A'
        TabOrder = 1
      end
      object rbBPareto: TRadioButton
        Left = 128
        Top = 40
        Width = 33
        Height = 17
        Caption = 'B'
        TabOrder = 2
      end
      object rbCPAreto: TRadioButton
        Left = 168
        Top = 40
        Width = 33
        Height = 17
        Caption = 'C'
        TabOrder = 3
      end
      object rbDPareto: TRadioButton
        Left = 208
        Top = 40
        Width = 33
        Height = 17
        Caption = 'D'
        TabOrder = 4
      end
      object rbEPareto: TRadioButton
        Left = 248
        Top = 40
        Width = 33
        Height = 17
        Caption = 'E'
        TabOrder = 5
      end
      object rbFPareto: TRadioButton
        Left = 288
        Top = 40
        Width = 33
        Height = 17
        Caption = 'F'
        TabOrder = 6
      end
      object rbMPareto: TRadioButton
        Left = 328
        Top = 40
        Width = 33
        Height = 17
        Caption = 'M'
        TabOrder = 7
      end
      object rbXPareto: TRadioButton
        Left = 368
        Top = 40
        Width = 33
        Height = 17
        Caption = 'X'
        TabOrder = 8
      end
      object edtMinQty: TEdit
        Left = 576
        Top = 264
        Width = 89
        Height = 21
        TabOrder = 23
      end
      object edtFixedSS: TEdit
        Left = 120
        Top = 264
        Width = 81
        Height = 21
        TabOrder = 15
      end
      object edtFixedSSRC: TEdit
        Left = 120
        Top = 296
        Width = 81
        Height = 21
        TabOrder = 16
      end
      object cbCalcIdealArrival: TCheckBox
        Left = 24
        Top = 344
        Width = 233
        Height = 17
        Caption = 'Calculate ideal arrival date'
        TabOrder = 24
      end
      object edtIdealArrival: TEdit
        Left = 112
        Top = 376
        Width = 121
        Height = 21
        TabOrder = 25
      end
      object edtTransitLT: TEdit
        Left = 120
        Top = 232
        Width = 81
        Height = 21
        TabOrder = 14
      end
      object edtItemBackorderRatio: TEdit
        Left = 576
        Top = 296
        Width = 57
        Height = 21
        TabOrder = 26
      end
      object edtItemBOMBackorderRatio: TEdit
        Left = 576
        Top = 328
        Width = 57
        Height = 21
        TabOrder = 27
      end
      object edtItemDRPBackorderRatio: TEdit
        Left = 576
        Top = 360
        Width = 57
        Height = 21
        TabOrder = 28
      end
    end
    object tabGraph: TTabSheet
      Caption = 'Graph'
      ImageIndex = 3
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 846
        Height = 481
        ActivePage = tabDailyGraph
        Align = alClient
        Style = tsButtons
        TabIndex = 0
        TabOrder = 0
        object tabDailyGraph: TTabSheet
          Caption = 'Daily'
          object chrtDaily: TChart
            Left = 0
            Top = 0
            Width = 838
            Height = 457
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            BackWall.Pen.Visible = False
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            BottomAxis.DateTimeFormat = 'dd-MMM'
            BottomAxis.LabelsAngle = 90
            Frame.Visible = False
            Legend.Alignment = laBottom
            MaxPointsPerPage = 365
            RightAxis.Automatic = False
            RightAxis.AutomaticMaximum = False
            RightAxis.AutomaticMinimum = False
            RightAxis.Maximum = 1
            RightAxis.Visible = False
            View3D = False
            View3DWalls = False
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object DBuildSeries: TBarSeries
              ColorEachPoint = True
              HorizAxis = aTopAxis
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = 16744576
              ShowInLegend = False
              Title = 'Build period'
              VertAxis = aRightAxis
              AutoMarkPosition = False
              BarPen.Visible = False
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              Dark3D = False
              MultiBar = mbNone
              SideMargins = False
              UseYOrigin = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object DExcessSeries: TAreaSeries
              Marks.ArrowLength = 8
              Marks.Style = smsPercent
              Marks.Visible = False
              SeriesColor = clRed
              Title = 'Excess'
              AreaLinesPen.Visible = False
              DrawArea = True
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object DLeadTimeSeries: TAreaSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = 16744448
              Title = 'Lead time'
              DrawArea = True
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object DModelSeries: TLineSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 16711808
              Title = 'Model'
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object DOrderSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 16777088
              Title = 'Orders'
              BarStyle = bsRectGradient
              MultiBar = mbNone
              SideMargins = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
              CustomBarWidth = 10
            end
            object DReceiptSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 16744448
              Title = 'Receipts'
              BarStyle = bsRectGradient
              MultiBar = mbNone
              SideMargins = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
              CustomBarWidth = 10
            end
            object DSOHSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = 8453888
              Title = 'Stock on hand'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object DPOSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = clYellow
              Title = 'Purchase orders'
              BarStyle = bsRectGradient
              MultiBar = mbNone
              SideMargins = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
              CustomBarWidth = 10
            end
            object DMinSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clAqua
              Title = 'Minimum stock'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object DSSSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clYellow
              Title = 'Safety stock'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object DSSRCSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clFuchsia
              Title = 'SS RC'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = False
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object DIdealArrivalSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 12615935
              Title = 'Ideal arrival date'
              VertAxis = aRightAxis
              AutoMarkPosition = False
              BarBrush.Color = clWhite
              BarPen.Visible = False
              BarWidthPercent = 60
              MultiBar = mbNone
              OffsetPercent = -5
              SideMargins = False
              UseYOrigin = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
              CustomBarWidth = 2
            end
            object DPOExpeditedSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 33023
              Title = 'Expedited POs'
              MultiBar = mbNone
              SideMargins = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
              CustomBarWidth = 10
            end
            object DPODeExpeditedSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 65408
              Title = 'De-expedited POs'
              MultiBar = mbNone
              SideMargins = False
              XValues.DateTime = False
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
              CustomBarWidth = 10
            end
            object DShutdownSeries: TAreaSeries
              Active = False
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = 13288885
              Title = 'Shutdown period'
              AreaLinesPen.Visible = False
              DrawArea = True
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
          end
        end
        object tabWeeklyGraph: TTabSheet
          Caption = 'Weekly'
          ImageIndex = 1
          object chrtWeekly: TChart
            Left = 0
            Top = 0
            Width = 838
            Height = 450
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            BottomAxis.DateTimeFormat = 'dd-MMM'
            BottomAxis.LabelsAngle = 90
            Legend.Alignment = laBottom
            View3D = False
            Align = alClient
            TabOrder = 0
            object WStockBuildSeries: TAreaSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clGreen
              Title = 'Stock build'
              DrawArea = True
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WDemandSeries: TAreaSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = 16744576
              Title = 'Demand'
              DrawArea = True
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WForecastSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clFuchsia
              Title = 'Forecast'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WDRPSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clBlue
              Title = 'DRP demand'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WBOMSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clAqua
              Title = 'BOM demand'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WCOSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 16711808
              Title = 'Customer orders'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WBOSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = clPurple
              Title = 'Backorders'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WExcessSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = clRed
              Title = 'Excess'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WProjectedOrderSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = clYellow
              Title = 'Projected orders'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WShipmentSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 16744448
              Title = 'Shipments'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WReceiptsSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = clAqua
              Title = 'Receipts'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object WOnHandSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = 4259584
              Title = 'On hand'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
          end
        end
        object tabMonthlyGraph: TTabSheet
          Caption = 'Monthly'
          ImageIndex = 2
          object chrtMonthly: TChart
            Left = 0
            Top = 0
            Width = 838
            Height = 450
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Title.Text.Strings = (
              'TChart')
            Title.Visible = False
            BottomAxis.DateTimeFormat = 'MMM-YY'
            BottomAxis.LabelsAngle = 90
            Legend.Alignment = laBottom
            View3D = False
            Align = alClient
            TabOrder = 0
            object MStockBuildSeries: TAreaSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clGreen
              Title = 'Stock build'
              DrawArea = True
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MDemandSeries: TAreaSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = 16744576
              Title = 'Demand'
              DrawArea = True
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MForecastSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clFuchsia
              Title = 'Forecast'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MDRPSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clBlue
              Title = 'DRP demand'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MBOMSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clAqua
              Title = 'BOM demand'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MCOSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 16711808
              Title = 'Customer orders'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MBOSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = clPurple
              Title = 'Backorders'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MExcessSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = clRed
              Title = 'Excess'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MProjectedOrderSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = clYellow
              Title = 'Projected orders'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MShipmentSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = 16744448
              Title = 'Shipments'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MReceiptsSeries: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = False
              SeriesColor = clAqua
              Title = 'Receipts'
              BarStyle = bsRectGradient
              BarWidthPercent = 100
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
            object MOnHandSeries: TLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = 4259584
              Title = 'On hand'
              LinePen.Width = 3
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              Pointer.Visible = False
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Multiplier = 1
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1
              YValues.Order = loNone
            end
          end
        end
      end
    end
    object tabExpedite: TTabSheet
      Caption = 'Expediting params'
      ImageIndex = 4
      object Label35: TLabel
        Left = 32
        Top = 64
        Width = 205
        Height = 13
        Caption = '% of LT above transit LT to use as minimum'
      end
      object Label36: TLabel
        Left = 32
        Top = 96
        Width = 203
        Height = 13
        Caption = 'Minimum no of days to add to the transit LT'
      end
      object Label37: TLabel
        Left = 32
        Top = 128
        Width = 224
        Height = 13
        Caption = 'Only recommend changes to dates greater than'
      end
      object Label34: TLabel
        Left = 32
        Top = 160
        Width = 207
        Height = 13
        Caption = 'Minimum no of days to recommend changes'
      end
      object cbExpedite: TCheckBox
        Left = 32
        Top = 24
        Width = 233
        Height = 17
        Caption = 'Expedite purchase orders'
        TabOrder = 0
      end
      object edtPercentagelt: TEdit
        Left = 304
        Top = 64
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object edtMinDaysLT: TEdit
        Left = 304
        Top = 96
        Width = 121
        Height = 21
        TabOrder = 2
      end
      object edtRecChanges: TEdit
        Left = 304
        Top = 128
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object edtMinDaysRec: TEdit
        Left = 304
        Top = 160
        Width = 121
        Height = 21
        TabOrder = 4
      end
    end
    object tabPO: TTabSheet
      Caption = 'Purchase orders'
      ImageIndex = 5
    end
    object tabStockBuild: TTabSheet
      Caption = 'Stock build'
      ImageIndex = 6
      object Label40: TLabel
        Left = 24
        Top = 56
        Width = 70
        Height = 13
        Caption = 'Build start date'
      end
      object Label41: TLabel
        Left = 24
        Top = 88
        Width = 95
        Height = 13
        Caption = 'Shutdown start date'
      end
      object Label42: TLabel
        Left = 24
        Top = 120
        Width = 93
        Height = 13
        Caption = 'Shutdown end date'
      end
      object cbStockBuild: TCheckBox
        Left = 24
        Top = 16
        Width = 201
        Height = 17
        Caption = 'Use stock build'
        TabOrder = 0
        OnClick = cbStockBuildClick
      end
      object edtBuildStart: TDateTimePicker
        Left = 136
        Top = 56
        Width = 186
        Height = 21
        CalAlignment = dtaLeft
        Date = 37549.540689456
        Time = 37549.540689456
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
      end
      object edtShutdownStart: TDateTimePicker
        Left = 136
        Top = 88
        Width = 186
        Height = 21
        CalAlignment = dtaLeft
        Date = 37580.5407338426
        Time = 37580.5407338426
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 2
      end
      object edtShutdownEnd: TDateTimePicker
        Left = 136
        Top = 120
        Width = 186
        Height = 21
        CalAlignment = dtaLeft
        Date = 37607.5407672222
        Time = 37607.5407672222
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 3
      end
      object cbSBOrders: TCheckBox
        Left = 24
        Top = 160
        Width = 297
        Height = 17
        Caption = 'Orders can be placed during shutdown'
        TabOrder = 4
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 854
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    OnClick = Panel3Click
    object btnData: TSpeedButton
      Left = 544
      Top = 40
      Width = 81
      Height = 21
      Caption = 'Model'
      OnClick = btnDataClick
    end
    object Label1: TLabel
      Left = 24
      Top = 40
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Product code'
    end
    object Label2: TLabel
      Left = 47
      Top = 8
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Location'
    end
    object Label23: TLabel
      Left = 35
      Top = 72
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description'
    end
    object btnLoadItem: TSpeedButton
      Left = 424
      Top = 40
      Width = 113
      Height = 21
      Caption = 'Load item data'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDD707DDDDDDDDDDDDDD0000DD73
        307DDDDDDDDDDDDD0000DD783307DDDDDDDDDDDD0000DDD383307DDDDDDDDDDD
        0000DDDD38330777777DDDDD0000DDDDD38330000077DDDD0000DDDDDD383378
        88707DDD0000DDDDDDD037F8F88707DD0000DDDDDDD07FCCCCC8777D0000DDDD
        DCD0F8C8F8C880CD0000DDDDDCC08FCCCCCF80DD0000DDDDDCD0F8CFFCF880DD
        0000DDDDDDC77FCCCC8F77CD0000DDDDDDDD07F8F8F70DDD0000DDDDDDDDD07F
        8F70DDDD0000DDDDDDDDDD70007DDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDD
        DDDDDDDDDDDDDDDD0000}
      OnClick = btnLoadItemClick
    end
    object btnLoadFromFile: TSpeedButton
      Left = 720
      Top = 16
      Width = 121
      Height = 22
      Caption = 'Load from file'
      OnClick = btnLoadFromFileClick
    end
    object btnSaveParamsToFile: TSpeedButton
      Left = 720
      Top = 40
      Width = 121
      Height = 22
      Caption = 'Save params to file'
      Enabled = False
      OnClick = btnSaveParamsToFileClick
    end
    object btnSaveResultsToFile: TSpeedButton
      Left = 720
      Top = 64
      Width = 121
      Height = 22
      Caption = 'Save results to file'
      Enabled = False
      OnClick = btnSaveResultsToFileClick
    end
    object DBEdit1: TDBEdit
      Left = 96
      Top = 8
      Width = 193
      Height = 21
      DataField = 'DESCRIPTION'
      DataSource = dmTest.dscLocation
      Enabled = False
      TabOrder = 0
    end
    object DBNavigator1: TDBNavigator
      Left = 296
      Top = 40
      Width = 120
      Height = 21
      DataSource = dmTest.dscItem
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 1
      OnClick = DBNavigator1Click
    end
    object DBNavigator2: TDBNavigator
      Left = 296
      Top = 8
      Width = 120
      Height = 21
      DataSource = dmTest.dscLocation
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 2
      OnClick = DBNavigator2Click
    end
    object DBEdit3: TDBEdit
      Left = 96
      Top = 72
      Width = 321
      Height = 21
      DataField = 'PDESCRIPTION'
      DataSource = dmTest.dscItem
      TabOrder = 3
    end
    object edtProductCode: TEdit
      Left = 96
      Top = 40
      Width = 193
      Height = 21
      TabOrder = 4
      Text = 'edtProductCode'
    end
    object ItemForecast: TCheckBox
      Left = 456
      Top = 8
      Width = 145
      Height = 17
      Caption = 'ItemForecast'
      TabOrder = 5
      OnClick = ItemForecastClick
    end
    object CheckBox1: TCheckBox
      Left = 456
      Top = 80
      Width = 97
      Height = 17
      Caption = 'Use stock build'
      TabOrder = 6
      OnClick = CheckBox1Click
    end
  end
  object dlgLoad: TOpenDialog
    DefaultExt = 'fwd'
    Left = 632
    Top = 8
  end
  object dlgSaveParams: TSaveDialog
    DefaultExt = 'fwd'
    Left = 632
    Top = 40
  end
  object dlgSaveResults: TSaveDialog
    DefaultExt = 'fwr'
    Left = 632
    Top = 72
  end
end
