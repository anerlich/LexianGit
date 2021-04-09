object frmGroup: TfrmGroup
  Left = 470
  Top = 189
  Width = 690
  Height = 300
  Caption = 'Select Group'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 0
    Width = 41
    Height = 16
    Caption = 'Step 1.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 20
    Top = 17
    Width = 124
    Height = 13
    Caption = 'Select Group or User Field'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 176
    Top = 0
    Width = 41
    Height = 16
    Caption = 'Step 2.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 316
    Top = 17
    Width = 65
    Height = 13
    Caption = 'Specify Value'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 316
    Top = 0
    Width = 41
    Height = 16
    Caption = 'Step 3.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 176
    Top = 17
    Width = 79
    Height = 13
    Caption = 'Specify Operator'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 592
    Top = 0
    Width = 41
    Height = 16
    Caption = 'Step 4.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 592
    Top = 17
    Width = 64
    Height = 13
    Caption = 'Select Button'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 285
    Top = 32
    Width = 301
    Height = 137
    BevelInner = bvLowered
    TabOrder = 0
    object DBLookupComboBox2: TDBLookupComboBox
      Left = 10
      Top = 36
      Width = 280
      Height = 21
      KeyField = 'GroupNo'
      ListField = 'GroupCode;Description'
      ListSource = dmUpdateSpecial.srcGroupMajor
      TabOrder = 3
      Visible = False
      OnCloseUp = DBLookupComboBox2CloseUp
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 10
      Top = 36
      Width = 273
      Height = 21
      DropDownRows = 12
      KeyField = 'SupplierNo'
      ListField = 'SupplierCode;SupplierName'
      ListSource = dmUpdateSpecial.srcSuppliers
      TabOrder = 2
      OnCloseUp = DBLookupComboBox1CloseUp
    end
    object chkFromData: TCheckBox
      Left = 10
      Top = 8
      Width = 97
      Height = 17
      Caption = 'Value From Data'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkFromDataClick
    end
    object chkSpecificValue: TCheckBox
      Left = 10
      Top = 80
      Width = 98
      Height = 17
      Caption = 'Custom Value'
      TabOrder = 4
      OnClick = chkSpecificValueClick
    end
    object Edit1: TEdit
      Left = 10
      Top = 100
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 5
      OnChange = Edit1Change
    end
    object ComboBox3: TComboBox
      Left = 10
      Top = 36
      Width = 53
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'A'
      Visible = False
      OnChange = ComboBox3Change
      Items.Strings = (
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'M'
        'X')
    end
    object Edit2: TEdit
      Left = 10
      Top = 58
      Width = 121
      Height = 21
      TabOrder = 6
      Visible = False
    end
    object ComboBox5: TComboBox
      Left = 10
      Top = 44
      Width = 53
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 7
      Text = '1'
      Visible = False
      OnChange = ComboBox5Change
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5')
    end
  end
  object Panel2: TPanel
    Left = 5
    Top = 32
    Width = 161
    Height = 137
    BevelInner = bvLowered
    TabOrder = 1
    object ComboBox1: TComboBox
      Left = 8
      Top = 36
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'Supplier'
      OnChange = ComboBox1Change
      Items.Strings = (
        'Supplier'
        'Group Major'
        'Group Minor 1'
        'Group Minor 2'
        'Pareto Category'
        'Criticality')
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 8
      Width = 97
      Height = 17
      Caption = 'Group'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object ComboBox4: TComboBox
      Left = 8
      Top = 100
      Width = 145
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      Text = '(None)'
      OnChange = ComboBox4Change
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 80
      Width = 97
      Height = 17
      Caption = 'User Field'
      TabOrder = 3
      OnClick = CheckBox2Click
    end
  end
  object Panel3: TPanel
    Left = 169
    Top = 32
    Width = 113
    Height = 137
    BevelInner = bvLowered
    TabOrder = 2
    object ComboBox2: TComboBox
      Left = 3
      Top = 58
      Width = 109
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = '='
      OnChange = ComboBox2Change
      Items.Strings = (
        '='
        '<>'
        '>'
        '<'
        '>='
        '<='
        'LIKE'
        'STARTING WITH'
        'CONTAINING'
        'BETWEEN')
    end
  end
  object Panel4: TPanel
    Left = 589
    Top = 32
    Width = 90
    Height = 183
    BevelInner = bvLowered
    TabOrder = 3
    object BitBtn3: TBitBtn
      Left = 7
      Top = 6
      Width = 75
      Height = 49
      Caption = 'Specify'
      Default = True
      ModalResult = 6
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0C000000000000000
        0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000000000008080000000000000000000008080
        000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
        0000000000000000000000000000000000008080000080800000000000008080
        00008080000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
        0000808000008080000080800000808000008080000080800000808000000000
        0000808000008080000000000000C0C0C000C0C0C000C0C0C000C0C0C0000000
        0000808000008080000080800000808000008080000080800000808000008080
        000000000000808000008080000000000000C0C0C000C0C0C000C0C0C0000000
        0000808000008080000080800000808000008080000080800000808000000000
        0000808000008080000000000000C0C0C000C0C0C000C0C0C000C0C0C0000000
        0000000000000000000000000000000000008080000080800000000000008080
        00008080000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000000000008080000000000000000000008080
        000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0C000000000000000
        0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C00000000000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
    end
    object BitBtn1: TBitBtn
      Left = 7
      Top = 87
      Width = 75
      Height = 25
      Caption = 'Finish'
      TabOrder = 1
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 7
      Top = 147
      Width = 75
      Height = 25
      TabOrder = 2
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
  end
  object Panel5: TPanel
    Left = 6
    Top = 174
    Width = 580
    Height = 41
    BevelInner = bvLowered
    TabOrder = 4
    object Label7: TLabel
      Left = 6
      Top = 14
      Width = 100
      Height = 13
      Caption = 'Resulting Condition : '
    end
    object lblGroup: TLabel
      Left = 110
      Top = 14
      Width = 38
      Height = 13
      Caption = 'Supplier'
    end
    object Label12: TLabel
      Left = 222
      Top = 14
      Width = 9
      Height = 13
      Caption = '= '
    end
    object Label11: TLabel
      Left = 312
      Top = 14
      Width = 3
      Height = 13
    end
  end
end
