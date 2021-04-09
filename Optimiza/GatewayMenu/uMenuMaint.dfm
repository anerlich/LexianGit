object frmMenuMaint: TfrmMenuMaint
  Left = 527
  Top = 247
  Width = 575
  Height = 387
  Caption = 'Menu Maintenance'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMenu = PopupMenu2
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 7
    Width = 81
    Height = 13
    Caption = 'Main Menu Items'
  end
  object Label2: TLabel
    Left = 181
    Top = 8
    Width = 77
    Height = 13
    Caption = 'Sub Menu Items'
  end
  object Label3: TLabel
    Left = 349
    Top = 8
    Width = 77
    Height = 13
    Caption = 'Sub Menu Items'
  end
  object Label4: TLabel
    Left = 226
    Top = 192
    Width = 77
    Height = 13
    Caption = 'Menu Command'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 158
    Height = 149
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnClick = ListBox1Click
    OnMouseDown = ListBox1MouseDown
  end
  object BitBtn6: TBitBtn
    Left = 480
    Top = 304
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn7: TBitBtn
    Left = 392
    Top = 304
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object ListBox2: TListBox
    Left = 176
    Top = 24
    Width = 158
    Height = 149
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 3
    OnClick = ListBox2Click
    OnMouseDown = ListBox2MouseDown
  end
  object ListBox3: TListBox
    Left = 347
    Top = 24
    Width = 158
    Height = 149
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 4
    OnClick = ListBox3Click
    OnMouseDown = ListBox3MouseDown
  end
  object ListBox4: TListBox
    Left = 8
    Top = 194
    Width = 201
    Height = 107
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
    TabOrder = 5
    Visible = False
  end
  object Edit1: TEdit
    Left = 224
    Top = 214
    Width = 289
    Height = 21
    TabOrder = 6
  end
  object Edit2: TEdit
    Left = 224
    Top = 242
    Width = 289
    Height = 21
    TabOrder = 7
  end
  object Edit3: TEdit
    Left = 224
    Top = 274
    Width = 289
    Height = 21
    TabOrder = 8
  end
  object MainMenu1: TMainMenu
    Left = 520
    Top = 32
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object ools1: TMenuItem
      Caption = 'Tools'
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 520
    object Add1: TMenuItem
      Caption = 'Add Menu Item'
      OnClick = Add1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete Menu Item'
      OnClick = Delete1Click
    end
    object EditMenuNameandTag1: TMenuItem
      Caption = 'Edit Menu Name and Tag'
      OnClick = EditMenuNameandTag1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MoveDown1: TMenuItem
      Caption = 'Move Down'
      OnClick = MoveDown1Click
    end
    object MoveUp1: TMenuItem
      Caption = 'Move Up'
      OnClick = MoveUp1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object NewSeperator1: TMenuItem
      Caption = 'Insert Seperator Above'
      OnClick = NewSeperator1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object AssignCommand1: TMenuItem
      Caption = 'Add/Edit Command'
      OnClick = AssignCommand1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 520
    Top = 120
    object ShowTagWindow1: TMenuItem
      Caption = 'Show Tag Window'
      OnClick = ShowTagWindow1Click
    end
  end
end
