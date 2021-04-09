object frmMain: TfrmMain
  Left = 1151
  Top = 111
  Width = 696
  Height = 530
  Caption = 'Edit Sales History'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 680
    Height = 473
    Align = alClient
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 473
    Width = 680
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
    Width = 680
    Height = 473
    Align = alClient
    TabOrder = 2
    object Label1: TLabel
      Left = 41
      Top = 328
      Width = 5
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 305
      Top = 328
      Width = 5
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object GroupBox5: TGroupBox
      Left = 24
      Top = 16
      Width = 297
      Height = 59
      Caption = 'Location'
      TabOrder = 0
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 9
        Top = 24
        Width = 145
        Height = 21
        KeyField = 'LOCATIONNO'
        ListField = 'DESCRIPTION'
        ListSource = dmData.srcSrcLocation
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 24
      Top = 80
      Width = 337
      Height = 208
      Caption = 'Product'
      TabOrder = 1
      object Edit2: TEdit
        Left = 8
        Top = 21
        Width = 179
        Height = 21
        Hint = 'Enter the partial code and click on the Find button'
        TabOrder = 0
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
        Options = [dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
    object DBGrid2: TDBGrid
      Left = 24
      Top = 349
      Width = 617
      Height = 73
      DataSource = dmData.srcSales
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALESAMOUNT_0'
          Visible = True
        end>
    end
    object BitBtn2: TBitBtn
      Left = 48
      Top = 432
      Width = 75
      Height = 25
      Caption = 'Post'
      TabOrder = 3
      OnClick = BitBtn2Click
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C00080000000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000800000008000000080000000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C0008000000080000000800000008000000080000000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000800000008000000080000000C0C0C00080000000800000008000
        0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000800000008000000080000000C0C0C000C0C0C000C0C0C000800000008000
        000080000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C00080000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008000
        00008000000080000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000800000008000000080000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000800000008000000080000000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000800000008000000080000000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C00080000000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
    end
    object BitBtn3: TBitBtn
      Left = 176
      Top = 432
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 4
      OnClick = BitBtn3Click
    end
  end
end
