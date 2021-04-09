object frmMain: TfrmMain
  Left = 871
  Top = 327
  Width = 411
  Height = 203
  Caption = 'EXCEL Import'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  DesignSize = (
    395
    165)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 403
    Height = 144
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Idle...')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 144
    Width = 403
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 64
      Top = 7
      Width = 3
      Height = 13
    end
    object Label2: TLabel
      Left = 3
      Top = 7
      Width = 41
      Height = 13
      Caption = 'Progress'
    end
    object ProgressBar1: TProgressBar
      Left = 155
      Top = 7
      Width = 232
      Height = 13
      Min = 0
      Max = 100
      Step = 5
      TabOrder = 0
    end
  end
end
