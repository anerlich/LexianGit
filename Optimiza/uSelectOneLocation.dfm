object frmSelectOneLocation: TfrmSelectOneLocation
  Left = 615
  Top = 0
  Width = 435
  Height = 389
  Caption = 'Select One Location'
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 419
    Height = 41
    Align = alTop
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 419
    Height = 268
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object DBLookupListBox1: TDBLookupListBox
      Left = 1
      Top = 1
      Width = 417
      Height = 264
      Hint = 'LocationCode;Description'
      Align = alClient
      KeyField = 'LOCATIONCODE'
      ListField = 'LocationCode;Description'
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 309
    Width = 419
    Height = 41
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 240
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 328
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkOK
    end
  end
end
