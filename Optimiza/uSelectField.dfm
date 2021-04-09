object frmSelectField: TfrmSelectField
  Left = 61
  Top = 59
  Width = 384
  Height = 846
  Caption = 'Select Field'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 368
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblDescription: TLabel
      Left = 11
      Top = 12
      Width = 63
      Height = 13
      Caption = 'lblDescription'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 767
    Width = 368
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 212
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 297
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 209
    Width = 368
    Height = 558
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 2
    object grdFields: TStringGrid
      Left = 1
      Top = 1
      Width = 366
      Height = 556
      Align = alClient
      ColCount = 3
      DefaultColWidth = 175
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 7
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 0
      OnSelectCell = grdFieldsSelectCell
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 41
    Width = 368
    Height = 168
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object GroupBox1: TGroupBox
      Left = 8
      Top = 6
      Width = 361
      Height = 145
      Caption = 'Current Setting'
      TabOrder = 0
      object Label2: TLabel
        Left = 8
        Top = 43
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object Label3: TLabel
        Left = 11
        Top = 81
        Width = 22
        Height = 13
        Caption = 'Field'
      end
      object edtDescription: TEdit
        Left = 75
        Top = 41
        Width = 217
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
      object edtField: TEdit
        Left = 75
        Top = 81
        Width = 217
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 17
        Width = 340
        Height = 17
        Caption = 
          'Create a single Workbook (i.e. do not split into several workboo' +
          'ks)'
        TabOrder = 2
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 72
        Top = 113
        Width = 273
        Height = 17
        Caption = 'Use Description rather than Code'
        TabOrder = 3
        OnClick = CheckBox2Click
      end
    end
  end
end
