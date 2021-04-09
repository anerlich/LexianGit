object Form1: TForm1
  Left = 266
  Top = 118
  Width = 784
  Height = 717
  Caption = 'Kill Process'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 285
    Top = 9
    Width = 49
    Height = 13
    Caption = 'Processes'
  end
  object Label1: TLabel
    Left = 284
    Top = 570
    Width = 86
    Height = 13
    Caption = 'Currently Selected'
  end
  object Label2: TLabel
    Left = 571
    Top = 572
    Width = 36
    Height = 13
    Caption = 'Proc ID'
  end
  object Label7: TLabel
    Left = 284
    Top = 622
    Width = 88
    Height = 13
    Caption = 'Enter Image Name'
  end
  object Label3: TLabel
    Left = 15
    Top = 9
    Width = 29
    Height = 13
    Caption = 'Tasks'
  end
  object Label4: TLabel
    Left = 24
    Top = 296
    Width = 48
    Height = 13
    Caption = 'Messages'
  end
  object Label5: TLabel
    Left = 16
    Top = 528
    Width = 27
    Height = 13
    Caption = 'Errors'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 664
    Width = 776
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object Button1: TButton
    Left = 644
    Top = 24
    Width = 120
    Height = 25
    Caption = 'Refresh List'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 284
    Top = 590
    Width = 269
    Height = 21
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 571
    Top = 589
    Width = 57
    Height = 21
    TabOrder = 3
  end
  object Edit3: TEdit
    Left = 379
    Top = 618
    Width = 254
    Height = 21
    TabOrder = 4
  end
  object BitBtn1: TBitBtn
    Left = 643
    Top = 588
    Width = 120
    Height = 25
    Caption = 'Kill Current Selection'
    TabOrder = 5
    OnClick = BitBtn1Click
  end
  object BitBtn3: TBitBtn
    Left = 643
    Top = 616
    Width = 120
    Height = 25
    Caption = 'Kill All with Given Name'
    TabOrder = 6
    OnClick = BitBtn3Click
  end
  object chkTasks: TCheckListBox
    Left = 15
    Top = 24
    Width = 186
    Height = 105
    ItemHeight = 13
    Items.Strings = (
      'Kill Scheduler'
      'Kill Optimiza'
      'Stop Firebird Engine'
      'Kill ALL fb_inet_server sessions'
      'Start Firebird Engine'
      'Kill Mismatch Report'
      'Kill Late Customer Order Report')
    TabOrder = 7
  end
  object BitBtn2: TBitBtn
    Left = 15
    Top = 133
    Width = 89
    Height = 25
    Caption = 'Execute Tasks'
    TabOrder = 8
    OnClick = BitBtn2Click
  end
  object BitBtn4: TBitBtn
    Left = 15
    Top = 183
    Width = 89
    Height = 25
    Caption = 'Kill Scheduler'
    TabOrder = 9
    OnClick = BitBtn4Click
  end
  object BitBtn5: TBitBtn
    Left = 112
    Top = 183
    Width = 89
    Height = 25
    Caption = 'Kill Optimiza'
    TabOrder = 10
    OnClick = BitBtn5Click
  end
  object BitBtn6: TBitBtn
    Left = 15
    Top = 224
    Width = 89
    Height = 25
    Caption = 'Stop Firebird'
    TabOrder = 11
    OnClick = BitBtn6Click
  end
  object BitBtn7: TBitBtn
    Left = 112
    Top = 224
    Width = 89
    Height = 25
    Caption = 'Start Firebird'
    TabOrder = 12
    OnClick = BitBtn7Click
  end
  object BitBtn8: TBitBtn
    Left = 43
    Top = 256
    Width = 130
    Height = 25
    Caption = 'Kill ALL fb_inet_server'
    TabOrder = 13
    OnClick = BitBtn8Click
  end
  object ListBox1: TListBox
    Left = 280
    Top = 24
    Width = 360
    Height = 537
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    TabOrder = 14
    OnClick = ListBox1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 312
    Width = 257
    Height = 209
    TabOrder = 15
  end
  object Memo2: TMemo
    Left = 16
    Top = 544
    Width = 257
    Height = 89
    TabOrder = 16
  end
  object Hidden: TButton
    Left = 664
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Hidden'
    TabOrder = 17
    Visible = False
    OnClick = HiddenClick
  end
end
