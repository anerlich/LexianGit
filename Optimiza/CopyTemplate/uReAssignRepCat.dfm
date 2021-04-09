object frmReAssignRepCat: TfrmReAssignRepCat
  Left = 421
  Top = 228
  Width = 835
  Height = 349
  Caption = 'Reassign Report Category From One to Another in All templates'
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
    Left = 9
    Top = 41
    Width = 77
    Height = 13
    Caption = 'Report Category'
  end
  object Label2: TLabel
    Left = 7
    Top = 70
    Width = 76
    Height = 13
    Caption = 'Report Type No'
  end
  object Label3: TLabel
    Left = 7
    Top = 243
    Width = 101
    Height = 13
    Caption = 'Selected Rep Cat No'
  end
  object Label4: TLabel
    Left = 7
    Top = 98
    Width = 77
    Height = 13
    Caption = 'Report Category'
  end
  object Label5: TLabel
    Left = 7
    Top = 114
    Width = 30
    Height = 13
    Caption = 'Codes'
  end
  object Label6: TLabel
    Left = 441
    Top = 41
    Width = 77
    Height = 13
    Caption = 'Report Category'
  end
  object Label7: TLabel
    Left = 439
    Top = 70
    Width = 76
    Height = 13
    Caption = 'Report Type No'
  end
  object Label8: TLabel
    Left = 439
    Top = 98
    Width = 77
    Height = 13
    Caption = 'Report Category'
  end
  object Label9: TLabel
    Left = 439
    Top = 114
    Width = 30
    Height = 13
    Caption = 'Codes'
  end
  object Label10: TLabel
    Left = 439
    Top = 243
    Width = 101
    Height = 13
    Caption = 'Selected Rep Cat No'
  end
  object Label11: TLabel
    Left = 97
    Top = 10
    Width = 31
    Height = 13
    Caption = 'FROM'
  end
  object Label12: TLabel
    Left = 529
    Top = 7
    Width = 15
    Height = 13
    Caption = 'TO'
  end
  object BitBtn1: TBitBtn
    Left = 728
    Top = 280
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkClose
  end
  object edtRepCatTypeFM: TEdit
    Left = 95
    Top = 69
    Width = 49
    Height = 21
    TabOrder = 1
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 95
    Top = 37
    Width = 281
    Height = 21
    KeyField = 'ReportCategoryType'
    ListField = 'Description'
    ListSource = dmData.srcRepCats
    TabOrder = 2
    OnCloseUp = DBLookupComboBox1CloseUp
  end
  object BitBtn2: TBitBtn
    Left = 536
    Top = 280
    Width = 177
    Height = 25
    Caption = 'Reassign in All Templates'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object edtRepcatNoFM: TEdit
    Left = 122
    Top = 240
    Width = 49
    Height = 21
    TabOrder = 4
  end
  object DBGrid1: TDBGrid
    Left = 95
    Top = 97
    Width = 281
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
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 527
    Top = 37
    Width = 281
    Height = 21
    KeyField = 'ReportCategoryType'
    ListField = 'Description'
    ListSource = dmData.srcRepCats2
    TabOrder = 6
    OnCloseUp = DBLookupComboBox2CloseUp
  end
  object edtRepCatTypeTO: TEdit
    Left = 527
    Top = 69
    Width = 49
    Height = 21
    TabOrder = 7
  end
  object DBGrid2: TDBGrid
    Left = 527
    Top = 97
    Width = 281
    Height = 120
    DataSource = dmData.srcRepCat2
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid2CellClick
    Columns = <
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
  object edtRepcatNoTO: TEdit
    Left = 554
    Top = 240
    Width = 49
    Height = 21
    TabOrder = 9
  end
end
