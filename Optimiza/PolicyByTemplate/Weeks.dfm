object frmMain: TfrmMain
  Left = 24
  Top = 117
  Width = 826
  Height = 684
  Caption = 'Convert to weeks'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 616
    Width = 810
    Height = 30
    Align = alBottom
    TabOrder = 0
    object btnConvert: TBitBtn
      Left = 528
      Top = 2
      Width = 147
      Height = 25
      Caption = 'Convert to weeks'
      TabOrder = 0
      OnClick = btnConvertClick
    end
    object btnClose: TBitBtn
      Left = 696
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = btnCloseClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 278
    Width = 810
    Height = 338
    Align = alClient
    TabOrder = 1
    object Label2: TLabel
      Left = 6
      Top = 42
      Width = 44
      Height = 13
      Caption = 'Template'
    end
    object Label3: TLabel
      Left = 392
      Top = 64
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 6
      Top = 12
      Width = 53
      Height = 13
      Caption = 'Description'
    end
    object edtTemplateName: TEdit
      Left = 64
      Top = 38
      Width = 561
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnTemplate: TButton
      Left = 640
      Top = 37
      Width = 33
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btnTemplateClick
    end
    object edtTemplateNo: TEdit
      Left = 16
      Top = 54
      Width = 25
      Height = 21
      TabOrder = 2
      Visible = False
    end
    object GroupBox1: TGroupBox
      Left = 65
      Top = 63
      Width = 608
      Height = 52
      Hint = 
        'The "Reset ALL to TSL" option must be ticked to use the safety s' +
        'tock setting.'
      Caption = 'Update'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = GroupBox1Click
      object chkLT: TCheckBox
        Left = 19
        Top = 20
        Width = 70
        Height = 22
        Caption = 'Lead Time'
        TabOrder = 0
        OnEnter = chkLTEnter
      end
      object chkRC: TCheckBox
        Left = 93
        Top = 20
        Width = 78
        Height = 22
        Caption = 'Repl. Cycle'
        TabOrder = 1
        OnEnter = chkRCEnter
      end
      object chkRP: TCheckBox
        Left = 171
        Top = 20
        Width = 92
        Height = 22
        Caption = 'Review Period'
        TabOrder = 2
        OnEnter = chkRPEnter
      end
      object chkTSL: TCheckBox
        Left = 269
        Top = 20
        Width = 88
        Height = 22
        Caption = 'Service Level'
        TabOrder = 3
        OnEnter = chkTSLEnter
      end
      object chkSS: TCheckBox
        Left = 361
        Top = 20
        Width = 88
        Height = 22
        Caption = 'Safety Stock'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnEnter = chkSSEnter
      end
      object chkMOQ: TCheckBox
        Left = 449
        Top = 20
        Width = 88
        Height = 22
        Caption = 'MOQ'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnEnter = chkMOQEnter
      end
      object chkORM: TCheckBox
        Left = 505
        Top = 20
        Width = 88
        Height = 22
        Caption = 'Order Multiples'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnEnter = chkORMEnter
      end
    end
    object grdLocs: TStringGrid
      Left = 64
      Top = 120
      Width = 609
      Height = 215
      Hint = 'Right Click to Copy'
      ColCount = 9
      DefaultColWidth = 40
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 50
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = True
      TabOrder = 4
      OnClick = grdLocsClick
      RowHeights = (
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18
        18)
    end
    object btnLocs: TBitBtn
      Left = 688
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Locations...'
      TabOrder = 5
      OnClick = btnLocsClick
    end
    object btnPolicy: TBitBtn
      Left = 688
      Top = 152
      Width = 75
      Height = 25
      Caption = 'Policy...'
      TabOrder = 6
      OnClick = btnPolicyClick
    end
    object btnSave: TBitBtn
      Left = 688
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      Enabled = False
      TabOrder = 7
      OnClick = btnSaveClick
    end
    object btnCancel: TBitBtn
      Left = 688
      Top = 40
      Width = 75
      Height = 25
      Enabled = False
      TabOrder = 8
      OnClick = btnCancelClick
      Kind = bkCancel
    end
    object edtDescription: TEdit
      Left = 64
      Top = 8
      Width = 561
      Height = 21
      TabOrder = 9
      OnClick = edtDescriptionClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 810
    Height = 278
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 18
      Top = 9
      Width = 71
      Height = 13
      Caption = 'List of Updates'
    end
    object vleUpdates: TValueListEditor
      Left = 65
      Top = 55
      Width = 384
      Height = 217
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goThumbTracking]
      TabOrder = 0
      TitleCaptions.Strings = (
        'ID'
        'Description')
      OnClick = vleUpdatesClick
      ColWidths = (
        3
        375)
    end
    object btnAdd: TBitBtn
      Left = 456
      Top = 54
      Width = 75
      Height = 26
      Caption = 'Add'
      TabOrder = 1
      OnClick = btnAddClick
    end
    object btnEdit: TBitBtn
      Left = 456
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Edit'
      TabOrder = 2
      OnClick = btnEditClick
    end
    object btnDelete: TBitBtn
      Left = 456
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Delete'
      TabOrder = 3
      OnClick = btnDeleteClick
    end
    object vleSettings: TValueListEditor
      Left = 480
      Top = 136
      Width = 169
      Height = 73
      Strings.Strings = (
        'User No='
        'Template No='
        'Update=LT,RC,RP,TSL'
        'Locations=')
      TabOrder = 4
      Visible = False
      ColWidths = (
        150
        -4)
    end
    object btnCopyTo: TBitBtn
      Left = 456
      Top = 151
      Width = 75
      Height = 25
      Caption = 'Copy to ...'
      TabOrder = 5
      OnClick = btnCopyToClick
    end
    object chkResetTSL: TCheckBox
      Left = 64
      Top = 32
      Width = 449
      Height = 17
      Caption = 
        'Reset ALL to Target Service Level before the update starts (Alte' +
        'red by ADMIN user only)'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object vleParameters: TValueListEditor
      Left = 8
      Top = 168
      Width = 137
      Height = 97
      Strings.Strings = (
        'Reset to TSL before start=Yes')
      TabOrder = 7
      Visible = False
      ColWidths = (
        150
        -19)
    end
    object btnMoveUp: TBitBtn
      Left = 456
      Top = 211
      Width = 75
      Height = 25
      Hint = 'Move current row Up'
      Caption = 'Move'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btnMoveUpClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFF06660F
        FFFFFFFFFF06660FFFFFFFFFFF06660FFFFFFFF00006660000FFFFFF06666666
        0FFFFFFFF0666660FFFFFFFFFF06660FFFFFFFFFFFF060FFFFFFFFFFFFFF0FFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphRight
    end
    object btnMoveDown: TBitBtn
      Left = 456
      Top = 240
      Width = 75
      Height = 25
      Hint = 'Move current row Down'
      Caption = 'Move'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = btnMoveDownClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFF060FF
        FFFFFFFFFF06660FFFFFFFFFF0666660FFFFFFFF066666660FFFFFF000066600
        00FFFFFFFF06660FFFFFFFFFFF06660FFFFFFFFFFF06660FFFFFFFFFFF00000F
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphRight
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 696
    Top = 496
    object CopyALLpolicytoAllLocations1: TMenuItem
      Caption = 'Copy ALL policy to All Locations'
      OnClick = CopyALLpolicytoAllLocations1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CopyLTtoAllLocations1: TMenuItem
      Caption = 'Copy LT to All Locations'
      OnClick = CopyLTtoAllLocations1Click
    end
    object CopyRCtoAllLocations1: TMenuItem
      Caption = 'Copy RC to All Locations'
      OnClick = CopyRCtoAllLocations1Click
    end
    object CopyRPtoAllLocations1: TMenuItem
      Caption = 'Copy RP to All Locations'
      OnClick = CopyRPtoAllLocations1Click
    end
    object CopyTSLtoAllLocations1: TMenuItem
      Caption = 'Copy TSL to All Locations'
      OnClick = CopyTSLtoAllLocations1Click
    end
    object CopySStoAllLocations1: TMenuItem
      Caption = 'Copy SS to All Locations'
      OnClick = CopySStoAllLocations1Click
    end
  end
end
