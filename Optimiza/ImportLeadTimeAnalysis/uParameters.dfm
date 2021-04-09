object frmParameters: TfrmParameters
  Left = 401
  Top = 249
  Width = 518
  Height = 424
  Caption = 'Parameters'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 65
    Width = 510
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 348
    Width = 510
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 510
    Height = 65
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Label3: TLabel
      Left = 16
      Top = 14
      Width = 70
      Height = 13
      Caption = 'Parameter File:'
    end
    object edtParamFile: TEdit
      Left = 96
      Top = 10
      Width = 329
      Height = 21
      TabOrder = 0
    end
    object Button1: TButton
      Left = 427
      Top = 8
      Width = 33
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
    object ValueListEditor2: TValueListEditor
      Left = 96
      Top = 36
      Width = 330
      Height = 21
      DisplayOptions = [doAutoColResize, doKeyColFixed]
      Strings.Strings = (
        'Last Import Date=')
      TabOrder = 2
      ColWidths = (
        150
        174)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 351
    Width = 510
    Height = 39
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 347
      Top = 9
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 431
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkOK
    end
    object cmbDummy: TComboBox
      Left = 7
      Top = 8
      Width = 225
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'cmbDummy'
      Visible = False
    end
    object BitBtn3: TBitBtn
      Left = 264
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Import'
      ModalResult = 1
      TabOrder = 3
      OnClick = BitBtn3Click
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0840000840000C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0840000848400840000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C084000000FFFF848400840000C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C084000000FFFF848400840000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C084000084000084000084000000FFFF84
        8400840000C0C0C0C0C0C0840000C0C0C0C0C0C0C0C0C0840000C0C0C0C0C0C0
        84000000FFFF00FFFF00FFFF00FFFF00FFFF848400840000C0C0C0C0C0C08400
        00C0C0C0840000C0C0C0C0C0C0C0C0C084000000FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF840000C0C0C0C0C0C0C0C0C0840000C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C084000000FFFF848400840000840000840000840000C0C0C0C0C0C08400
        00C0C0C0840000C0C0C0C0C0C0C0C0C0C0C0C084000000FFFF00FFFF84840084
        0000C0C0C0C0C0C0C0C0C0840000C0C0C0C0C0C0C0C0C0840000C0C0C0840000
        84000084000084000000FFFF00FFFF848400840000C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C084000000FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF848400840000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        84000000FFFF00FFFF00FFFF00FFFF00FFFF00FFFF848400840000C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C084000000FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF848400840000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        8400008400008400008400008400008400008400008400008400008400008400
        00C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 68
    Width = 510
    Height = 280
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel3'
    TabOrder = 2
    object ValueListEditor1: TValueListEditor
      Left = 1
      Top = 1
      Width = 508
      Height = 278
      Align = alClient
      Strings.Strings = (
        'Input Filename=ClosedPO.csv'
        'File Format=CSV'
        'Date Format=YYYYMMDD'
        'Append or Replace Data=Replace'
        'Field1='
        'Field2='
        'Field3='
        'Field4='
        'Field5='
        'Field6='
        'Field7='
        'Field8='
        'Field9='
        'Field10='
        'Field11='
        'Field12='
        'Field13='
        'Field14='
        'Field15='
        'Location Code='
        'Product Code='
        'Supplier Code='
        'Order Number='
        'Order Date='
        'Expected Arrival Date='
        'Final Delivery Date='
        'Quantity=')
      TabOrder = 0
      OnEditButtonClick = ValueListEditor1EditButtonClick
      OnValidate = ValueListEditor1Validate
      ColWidths = (
        150
        335)
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.csv'
    Filter = 'CSV Files|*.csv|Text Files|*.txt|All Files|*.*'
    Left = 480
    Top = 104
  end
  object OpenDialog2: TOpenDialog
    DefaultExt = '*.ini'
    Filter = 'INI Files|*.ini|Text Files|*.txt|All Files|*.*'
    Left = 528
    Top = 8
  end
end
