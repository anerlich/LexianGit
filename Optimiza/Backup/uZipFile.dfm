object frmZipFile: TfrmZipFile
  Left = 369
  Top = 201
  Width = 399
  Height = 239
  Caption = 'Select File(s) for ZIP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 16
    Width = 145
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 40
    Width = 145
    Height = 137
    FileList = FileListBox1
    ItemHeight = 16
    TabOrder = 1
  end
  object FileListBox1: TFileListBox
    Left = 160
    Top = 40
    Width = 225
    Height = 137
    FileEdit = Edit1
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 8
    Top = 184
    Width = 145
    Height = 21
    TabOrder = 3
    Text = '*.*'
  end
  object BitBtn1: TBitBtn
    Left = 224
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 310
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkCancel
  end
end
