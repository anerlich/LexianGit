object Form1: TForm1
  Left = 270
  Top = 123
  Width = 952
  Height = 627
  Caption = 'DB Util'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 131
    Top = 84
    Width = 73
    Height = 13
    Caption = 'DB'
  end
  object Edit1: TEdit
    Left = 216
    Top = 80
    Width = 313
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 536
    Top = 80
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 2
    OnClick = Button2Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 200
    Width = 401
    Height = 257
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button3: TButton
    Left = 104
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Close'
    Enabled = False
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 488
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Field Structure'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 632
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Update'
    Enabled = False
    TabOrder = 6
    OnClick = Button5Click
  end
  object ListBox1: TListBox
    Left = 480
    Top = 200
    Width = 169
    Height = 105
    ItemHeight = 13
    TabOrder = 7
    OnClick = ListBox1Click
  end
  object Edit2: TEdit
    Left = 488
    Top = 336
    Width = 121
    Height = 21
    TabOrder = 8
  end
  object Edit3: TEdit
    Left = 488
    Top = 368
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.dbf'
    Filter = 'DBF Files|*.dbf'
    Left = 624
    Top = 80
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'DefaultDD'
    FieldDefs = <
      item
        Name = 'COMPANY'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'MAILTYPE'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'TIMESTR'
        DataType = ftString
        Size = 150
      end>
    IndexDefs = <
      item
        Name = 'Table1Index1'
        Fields = 'Company;MailType;TimeStr'
      end>
    StoreDefs = True
    TableName = 'O:\Optimiza\MailChecker\Company.dbf'
    TableType = ttDBase
    Left = 392
    Top = 128
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 448
    Top = 128
  end
  object XMLDocument1: TXMLDocument
    Left = 736
    Top = 128
    DOMVendorDesc = 'MSXML'
  end
end
