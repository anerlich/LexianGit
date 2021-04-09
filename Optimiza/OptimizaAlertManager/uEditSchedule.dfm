object frmEditSchedule: TfrmEditSchedule
  Left = 363
  Top = 214
  Width = 490
  Height = 255
  Caption = 'Edit Schedule Settings'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 1
    Top = 16
    Width = 110
    Height = 13
    Caption = 'DAILY Schedule Name'
  end
  object lblStart: TLabel
    Left = 16
    Top = 91
    Width = 248
    Height = 13
    Caption = 'Daily  and Monthly Schedule to START no later than'
  end
  object Label2: TLabel
    Left = 16
    Top = 131
    Width = 179
    Height = 13
    Caption = 'DAILY Schedule to END no later than'
  end
  object Label3: TLabel
    Left = 301
    Top = 92
    Width = 91
    Height = 13
    Caption = '(hh:mm  e.g. 13:30)'
  end
  object Label4: TLabel
    Left = 265
    Top = 131
    Width = 188
    Height = 13
    Caption = '(hh:mm  e.g. 13:30) on the following day'
  end
  object Label5: TLabel
    Left = 1
    Top = 47
    Width = 132
    Height = 13
    Caption = 'MONTHLY Schedule Name'
  end
  object Label6: TLabel
    Left = 17
    Top = 155
    Width = 201
    Height = 13
    Caption = 'MONTHLY Schedule to END no later than'
  end
  object Label7: TLabel
    Left = 266
    Top = 155
    Width = 188
    Height = 13
    Caption = '(hh:mm  e.g. 13:30) on the following day'
  end
  object BitBtn1: TBitBtn
    Left = 272
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 368
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object Edit1: TEdit
    Left = 135
    Top = 11
    Width = 306
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object edtStart: TMaskEdit
    Left = 261
    Top = 88
    Width = 33
    Height = 21
    EditMask = '!90:00;1; '
    MaxLength = 5
    TabOrder = 3
    Text = '  :  '
  end
  object edtDayEnd: TMaskEdit
    Left = 225
    Top = 128
    Width = 33
    Height = 21
    EditMask = '!90:00;1; '
    MaxLength = 5
    TabOrder = 4
    Text = '  :  '
  end
  object Button1: TButton
    Left = 443
    Top = 11
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 135
    Top = 42
    Width = 306
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object Button2: TButton
    Left = 443
    Top = 42
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 7
    OnClick = Button2Click
  end
  object edtMthEnd: TMaskEdit
    Left = 226
    Top = 152
    Width = 33
    Height = 21
    EditMask = '!90:00;1; '
    MaxLength = 5
    TabOrder = 8
    Text = '  :  '
  end
end
