object frmProgressForm: TfrmProgressForm
  Left = 282
  Top = 117
  Width = 330
  Height = 304
  Caption = 'Status'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 322
    Height = 240
    Align = alClient
    Color = clInfoBk
    Lines.Strings = (
      'Started....')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 240
    Width = 322
    Height = 37
    Align = alBottom
    Alignment = taLeftJustify
    Caption = '   Progress'
    TabOrder = 1
    object ProgressBar1: TProgressBar
      Left = 72
      Top = 11
      Width = 233
      Height = 16
      Min = 0
      Max = 100
      Smooth = True
      Step = 1
      TabOrder = 0
    end
  end
end
