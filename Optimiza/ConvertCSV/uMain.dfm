object Form1: TForm1
  Left = 355
  Top = 197
  Width = 909
  Height = 656
  Caption = 'Convert Report File'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 901
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 8
      Width = 50
      Height = 13
      Caption = 'File Name:'
    end
    object Edit1: TEdit
      Left = 88
      Top = 6
      Width = 385
      Height = 21
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 483
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Browse'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 632
      Top = 8
      Width = 75
      Height = 25
      Caption = 'BitBtn2'
      TabOrder = 2
      OnClick = BitBtn2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 901
    Height = 573
    Align = alClient
    TabOrder = 1
    object StringGrid2: TStringGrid
      Left = 776
      Top = 1
      Width = 124
      Height = 571
      ColCount = 1
      DefaultColWidth = 2048
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      TabOrder = 1
    end
    object StringGrid1: TStringGrid
      Left = 1
      Top = 1
      Width = 899
      Height = 571
      Align = alClient
      ColCount = 255
      DefaultColWidth = 10
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Fixedsys'
      Font.Style = []
      GridLineWidth = 0
      Options = [goFixedVertLine, goFixedHorzLine, goHorzLine, goRangeSelect]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnDblClick = StringGrid1DblClick
      OnDrawCell = StringGrid1DrawCell
      OnMouseDown = StringGrid1MouseDown
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Text File|*.txt'
    Left = 592
    Top = 32
  end
  object PopupMenu1: TPopupMenu
    Left = 752
    Top = 16
    object ColumnHeader1: TMenuItem
      Caption = 'Column Header'
      OnClick = ColumnHeader1Click
    end
    object Footer1: TMenuItem
      Caption = 'Footer'
      OnClick = Footer1Click
    end
    object PageBreak1: TMenuItem
      Caption = 'PageBreak'
      OnClick = PageBreak1Click
    end
    object ColumnSeparator1: TMenuItem
      Caption = 'Add Column Separator'
      OnClick = StringGrid1DblClick
    end
    object DeleteColumnSeparator1: TMenuItem
      Caption = 'Delete Column Separator'
      OnClick = DeleteColumnSeparator1Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.csv'
    Filter = 'CSV File|*.csv'
    Left = 792
    Top = 16
  end
end
