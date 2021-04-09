object frmStatus: TfrmStatus
  Left = 407
  Top = 206
  Width = 396
  Height = 354
  Caption = 'Backup Status'
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
    Top = 0
    Width = 388
    Height = 281
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 386
      Height = 279
      Align = alClient
      Lines.Strings = (
        '')
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 281
    Width = 388
    Height = 46
    Align = alClient
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 422
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
  end
end
