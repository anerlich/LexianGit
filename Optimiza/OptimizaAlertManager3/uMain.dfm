object frmMain: TfrmMain
  Left = 246
  Top = 117
  Width = 696
  Height = 480
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
    Top = 434
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
    Left = 597
    Top = 400
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 12
    Width = 265
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
    Height = 329
    Caption = 'Schedule Settings'
    TabOrder = 3
    object Label2: TLabel
      Left = 19
      Top = 23
      Width = 78
      Height = 13
      Caption = 'Select Schedule'
    end
    object Label4: TLabel
      Left = 32
      Top = 207
      Width = 48
      Height = 13
      Caption = 'Setting for'
    end
    object lblSchedule: TLabel
      Left = 94
      Top = 207
      Width = 3
      Height = 13
    end
    object DBGrid1: TDBGrid
      Left = 14
      Top = 42
      Width = 217
      Height = 120
      DataSource = dmData.srcSchedule
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'Description'
          Title.Caption = 'Schedule Description'
          Width = 250
          Visible = True
        end>
    end
    object Button1: TButton
      Left = 236
      Top = 42
      Width = 113
      Height = 25
      Caption = 'Edit Schedule Settings'
      TabOrder = 1
      OnClick = Button1Click
    end
    object memShedule: TMemo
      Left = 32
      Top = 223
      Width = 169
      Height = 89
      ReadOnly = True
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 17
    Top = 349
    Width = 321
    Height = 75
    Caption = 'Time Interval'
    TabOrder = 4
    object Label5: TLabel
      Left = 14
      Top = 35
      Width = 103
      Height = 13
      Caption = 'Perform checks every'
    end
    object Label6: TLabel
      Left = 160
      Top = 35
      Width = 37
      Height = 13
      Caption = 'Minutes'
    end
    object edtInterval: TEdit
      Left = 126
      Top = 32
      Width = 25
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object Button3: TButton
      Left = 214
      Top = 31
      Width = 57
      Height = 25
      Caption = 'Change'
      TabOrder = 1
      OnClick = Button3Click
    end
  end
end
