object frmSelectTemplate: TfrmSelectTemplate
  Left = 655
  Top = 231
  Width = 318
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 318
    Width = 310
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 226
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 136
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkOK
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 310
    Height = 277
    Align = alClient
    DataSource = dmData.srcTemplate
    Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgMultiSelect]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DESCRIPTION'
        Width = 250
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
    Width = 310
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
  end
end
