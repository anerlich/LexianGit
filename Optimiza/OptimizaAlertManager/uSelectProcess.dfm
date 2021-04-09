object frmSelectProcess: TfrmSelectProcess
  Left = 1307
  Top = 278
  Width = 326
  Height = 251
  Caption = 'Select Process'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 120
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 208
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 16
    Top = 12
    Width = 269
    Height = 21
    Hint = 'Description'
    DropDownRows = 10
    DropDownWidth = 200
    KeyField = 'Description'
    ListField = 'Description'
    ListFieldIndex = 1
    ListSource = dmData.srcSchedule
    TabOrder = 2
  end
  object DBNavigator1: TDBNavigator
    Left = 20
    Top = 144
    Width = 222
    Height = 25
    DataSource = dmData.srcSchedule
    VisibleButtons = [nbLast]
    TabOrder = 3
    Visible = False
  end
end
