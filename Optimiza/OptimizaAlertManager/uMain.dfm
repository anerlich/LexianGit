object frmMain: TfrmMain
  Left = 836
  Top = 136
  Width = 696
  Height = 525
  Caption = 'Optimiza Alert Manager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 472
    Width = 688
    Height = 19
    Panels = <
      item
        Text = 'Database'
        Width = 50
      end>
    SimplePanel = False
  end
  object BitBtn1: TBitBtn
    Left = 589
    Top = 440
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 12
    Width = 277
    Height = 329
    Caption = 'Drive Settings'
    TabOrder = 2
    object Label1: TLabel
      Left = 32
      Top = 22
      Width = 176
      Height = 13
      Caption = 'Select Drive to check for Disk Space'
    end
    object Label3: TLabel
      Left = 32
      Top = 207
      Width = 75
      Height = 13
      Caption = 'Current Settings'
    end
    object ListBox1: TListBox
      Left = 32
      Top = 41
      Width = 65
      Height = 151
      ItemHeight = 13
      Items.Strings = (
        'Drive C:'
        'Drive D:'
        'Drive E:'
        'Drive F:'
        'Drive G:'
        'Drive H:'
        'Drive I:'
        'Drive J:'
        'Drive K:'
        'Drive L:'
        'Drive M:')
      TabOrder = 0
    end
    object Button2: TButton
      Left = 112
      Top = 41
      Width = 97
      Height = 25
      Caption = 'Edit Disk Settings'
      TabOrder = 1
      OnClick = Button2Click
    end
    object memDrive: TMemo
      Left = 32
      Top = 223
      Width = 169
      Height = 89
      ReadOnly = True
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 312
    Top = 12
    Width = 353
    Height = 209
    Caption = 'Schedule Settings'
    TabOrder = 3
    object lblSchedule: TLabel
      Left = 94
      Top = 207
      Width = 3
      Height = 13
    end
    object Label4: TLabel
      Left = 4
      Top = 27
      Width = 105
      Height = 13
      Caption = 'Daily Process Settings'
    end
    object Label2: TLabel
      Left = 16
      Top = 115
      Width = 93
      Height = 13
      Caption = 'Month End Settings'
    end
    object Button1: TButton
      Left = 214
      Top = 20
      Width = 113
      Height = 25
      Caption = 'Edit Schedule Settings'
      TabOrder = 0
      OnClick = Button1Click
    end
    object memDaily: TMemo
      Left = 16
      Top = 47
      Width = 313
      Height = 58
      Color = clInactiveBorder
      ReadOnly = True
      TabOrder = 1
    end
    object memMonthly: TMemo
      Left = 16
      Top = 131
      Width = 313
      Height = 58
      Color = clInactiveBorder
      ReadOnly = True
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 17
    Top = 349
    Width = 280
    Height = 75
    Caption = 'Time Interval'
    TabOrder = 4
    object Label5: TLabel
      Left = 10
      Top = 19
      Width = 103
      Height = 13
      Caption = 'Perform checks every'
    end
    object Label6: TLabel
      Left = 156
      Top = 19
      Width = 37
      Height = 13
      Caption = 'Minutes'
    end
    object Label7: TLabel
      Left = 9
      Top = 49
      Width = 166
      Height = 13
      Caption = 'Write Errors to Windows Event Log'
    end
    object edtInterval: TEdit
      Left = 122
      Top = 16
      Width = 25
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object Button3: TButton
      Left = 210
      Top = 15
      Width = 57
      Height = 25
      Caption = 'Change'
      TabOrder = 1
      OnClick = Button3Click
    end
    object edtEventLog: TEdit
      Left = 181
      Top = 46
      Width = 25
      Height = 21
      Color = clInactiveBorder
      ReadOnly = True
      TabOrder = 2
    end
  end
  object GroupBox4: TGroupBox
    Left = 312
    Top = 232
    Width = 353
    Height = 79
    Caption = 'Path for Optimiza Log Files'
    TabOrder = 5
    object edtPath: TEdit
      Left = 8
      Top = 21
      Width = 335
      Height = 21
      Color = clInactiveBorder
      ReadOnly = True
      TabOrder = 0
    end
    object Button5: TButton
      Left = 266
      Top = 46
      Width = 75
      Height = 25
      Caption = 'Change'
      TabOrder = 1
      OnClick = Button8Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 314
    Top = 323
    Width = 353
    Height = 106
    Caption = 'Email notification'
    TabOrder = 6
    object Button8: TButton
      Left = 267
      Top = 78
      Width = 75
      Height = 25
      Caption = 'Change'
      TabOrder = 0
      OnClick = Button9Click
    end
    object memEmail: TMemo
      Left = 9
      Top = 17
      Width = 334
      Height = 59
      Color = clSilver
      ReadOnly = True
      TabOrder = 1
    end
  end
end
