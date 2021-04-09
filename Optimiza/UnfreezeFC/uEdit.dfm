object frmEdit: TfrmEdit
  Left = 333
  Top = 180
  Width = 442
  Height = 173
  Caption = 'Edit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 43
    Width = 46
    Height = 13
    Caption = 'Update %'
  end
  object Label2: TLabel
    Left = 22
    Top = 68
    Width = 401
    Height = 13
    Caption = 
      'Increase example. Update % of 120 , where Forecast = 100, will y' +
      'ield Forecast of 120'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 22
    Top = 89
    Width = 394
    Height = 13
    Caption = 
      'Decrease example. Update % of 90 , where Forecast = 100, will yi' +
      'eld Forecast of 90'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object ExtEdit1: TExtEdit
    Left = 93
    Top = 39
    Width = 52
    Height = 21
    TabOrder = 0
    Text = '0'
    Format = '000.00'
    Kind = eekFloat
    Valid = valNone
    MinValue = 1
    MaxValue = 500
    FormatOnExit = False
    PlaneOnEnter = False
    ValidOnExit = False
  end
  object Edit1: TEdit
    Left = 32
    Top = 7
    Width = 385
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 248
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 344
    Top = 112
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
