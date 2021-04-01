object frmFilter: TfrmFilter
  Left = 528
  Top = 177
  Width = 628
  Height = 387
  Caption = 'Filter'
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
  object Splitter1: TSplitter
    Left = 0
    Top = 88
    Width = 620
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Beveled = True
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 220
    Width = 620
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Beveled = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 312
    Width = 620
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 280
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 366
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object memWhere: TMemo
    Left = 0
    Top = 251
    Width = 620
    Height = 61
    Align = alClient
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 620
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 30
      Width = 349
      Height = 13
      Caption = 
        'Additional fields which facilitate the filtering (Separate Field' +
        's with commas).'
    end
    object CheckBox1: TCheckBox
      Left = 14
      Top = 7
      Width = 97
      Height = 17
      Caption = 'Use Filter'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 48
    Width = 620
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object memFields: TMemo
      Left = 0
      Top = 0
      Width = 620
      Height = 40
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 91
    Width = 620
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object Label3: TLabel
      Left = 12
      Top = 12
      Width = 128
      Height = 13
      Caption = 'Additional Join statement(s)'
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 120
    Width = 620
    Height = 100
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object memJoin: TMemo
      Left = 0
      Top = 0
      Width = 620
      Height = 100
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 223
    Width = 620
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
    object Label4: TLabel
      Left = 8
      Top = 11
      Width = 192
      Height = 13
      Caption = 'Where statement (Must start with "and").'
    end
  end
end
