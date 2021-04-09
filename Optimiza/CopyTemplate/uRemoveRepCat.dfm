object frmRemoveRepCat: TfrmRemoveRepCat
  Left = 421
  Top = 235
  Width = 579
  Height = 323
  Caption = 'Remove Report Category From All Templates'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 26
    Top = 15
    Width = 77
    Height = 13
    Caption = 'Report Category'
  end
  object Label2: TLabel
    Left = 24
    Top = 44
    Width = 76
    Height = 13
    Caption = 'Report Type No'
  end
  object Label3: TLabel
    Left = 24
    Top = 217
    Width = 101
    Height = 13
    Caption = 'Selected Rep Cat No'
  end
  object Label4: TLabel
    Left = 24
    Top = 72
    Width = 77
    Height = 13
    Caption = 'Report Category'
  end
  object Label5: TLabel
    Left = 24
    Top = 88
    Width = 30
    Height = 13
    Caption = 'Codes'
  end
  object Label6: TLabel
    Left = 208
    Top = 216
    Width = 58
    Height = 13
    Caption = 'Blank = ALL'
  end
  object BitBtn1: TBitBtn
    Left = 464
    Top = 248
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkClose
  end
  object edtRepCatType: TEdit
    Left = 112
    Top = 43
    Width = 49
    Height = 21
    TabOrder = 1
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 112
    Top = 11
    Width = 281
    Height = 21
    KeyField = 'ReportCategoryType'
    ListField = 'Description'
    ListSource = dmData.srcRepCats
    TabOrder = 2
    OnCloseUp = DBLookupComboBox1CloseUp
  end
  object BitBtn2: TBitBtn
    Left = 104
    Top = 240
    Width = 177
    Height = 25
    Caption = 'Remove from All Templates'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object edtRepcatNo: TEdit
    Left = 139
    Top = 214
    Width = 49
    Height = 21
    TabOrder = 4
  end
  object DBGrid1: TDBGrid
    Left = 112
    Top = 71
    Width = 441
    Height = 120
    DataSource = dmData.srcRepCat
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'REPORTCATEGORYNO'
        Title.Caption = 'No'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REPORTCATEGORYCODE'
        Title.Caption = 'Code'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIPTION'
        Title.Caption = 'Description'
        Visible = True
      end>
  end
end
