object frmSelectDayList: TfrmSelectDayList
  Left = 351
  Top = 217
  Width = 328
  Height = 183
  Caption = 'Select Day(s)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 108
    Width = 320
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 239
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 161
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
    object BitBtn3: TBitBtn
      Left = 5
      Top = 8
      Width = 71
      Height = 25
      Caption = 'Select All'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 79
      Top = 8
      Width = 71
      Height = 25
      Caption = 'De-select All'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 108
    Align = alClient
    TabOrder = 1
    object CheckListBox1: TCheckListBox
      Left = 1
      Top = 1
      Width = 318
      Height = 106
      Align = alClient
      ItemHeight = 13
      Items.Strings = (
        'Monday'
        'Tuesday'
        'Wednesday'
        'Thursday'
        'Friday'
        'Saturday'
        'Sunday')
      TabOrder = 0
    end
  end
end
