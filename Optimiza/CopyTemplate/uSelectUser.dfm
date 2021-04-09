object frmSelectUser: TfrmSelectUser
  Left = 430
  Top = 220
  Width = 339
  Height = 287
  Caption = 'Select User'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 331
    Height = 212
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 329
      Height = 210
      Align = alClient
      DataSource = dmData.srcUser
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'USERNAME'
          Title.Caption = 'User Name'
          Title.Color = clInfoBk
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UserNo'
          Title.Caption = 'User No'
          Title.Color = clInfoBk
          Width = 100
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 212
    Width = 331
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 14
      Width = 153
      Height = 13
      Caption = 'Use [Ctrl]+Click to select multiple'
    end
    object BitBtn1: TBitBtn
      Left = 166
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 254
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
