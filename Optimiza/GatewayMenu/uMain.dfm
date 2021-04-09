object frmMain: TfrmMain
  Left = 734
  Top = 175
  Width = 633
  Height = 457
  Caption = 'Gateway Application'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox4: TListBox
    Left = 88
    Top = 272
    Width = 193
    Height = 65
    ItemHeight = 13
    Items.Strings = (
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    TabOrder = 0
    Visible = False
  end
  object vleUserList: TValueListEditor
    Left = 296
    Top = 32
    Width = 306
    Height = 249
    TabOrder = 1
    Visible = False
  end
  object vleMenuGroup: TValueListEditor
    Left = 24
    Top = 8
    Width = 265
    Height = 209
    TabOrder = 2
    Visible = False
    ColWidths = (
      150
      109)
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 380
    Width = 617
    Height = 19
    Panels = <
      item
        Text = 'User'
        Width = 50
      end
      item
        Width = 200
      end
      item
        Text = 'Menu Group'
        Width = 70
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Left = 152
    Top = 64
    object File1: TMenuItem
      Tag = 999
      Caption = 'File'
      object Setup1: TMenuItem
        Tag = 999
        Caption = 'Menu Setup'
        OnClick = Setup1Click
      end
      object UserSetup1: TMenuItem
        Tag = 999
        Caption = 'User Setup'
        OnClick = UserSetup1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Tag = 999
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Reports1: TMenuItem
      Tag = 999
      Caption = 'Reports'
    end
    object Run1: TMenuItem
      Tag = 999
      Caption = 'Run'
    end
    object ools1: TMenuItem
      Tag = 999
      Caption = 'Tools'
    end
  end
end
