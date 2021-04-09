object frmFolder: TfrmFolder
  Left = 644
  Top = 190
  Width = 225
  Height = 243
  Caption = 'Select Folder'
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
  object Label1: TLabel
    Left = 8
    Top = 136
    Width = 50
    Height = 13
    Caption = 'File Name:'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 185
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 134
    Top = 185
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 9
    Width = 201
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 2
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 32
    Width = 201
    Height = 97
    ItemHeight = 16
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 8
    Top = 155
    Width = 201
    Height = 21
    TabOrder = 4
  end
end
