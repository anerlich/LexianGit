object frmSelectTemplate: TfrmSelectTemplate
  Left = 530
  Top = 299
  Width = 464
  Height = 393
  Caption = 'Select Template'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 318
    Width = 456
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 186
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 98
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkOK
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 51
    Width = 456
    Height = 267
    Align = alClient
    DataSource = dmData.srcTemplate
    Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DESCRIPTION'
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TEMPLATENO'
        Width = 30
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 456
    Height = 51
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 5
      Top = 9
      Width = 101
      Height = 13
      Caption = 'Display Templates for'
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 115
      Top = 5
      Width = 145
      Height = 21
      Hint = 'UserNo'
      KeyField = 'UserNo'
      ListField = 'UserName'
      ListFieldIndex = 1
      ListSource = dmData.srcUsers
      TabOrder = 0
      OnCloseUp = DBLookupComboBox1CloseUp
    end
    object CheckBox1: TCheckBox
      Left = 6
      Top = 29
      Width = 257
      Height = 17
      Caption = 'Do not use a Template (All items will be selected)'
      TabOrder = 1
      OnClick = CheckBox1Click
    end
  end
end
