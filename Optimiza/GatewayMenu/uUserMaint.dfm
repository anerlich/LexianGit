object frmUserMaint: TfrmUserMaint
  Left = 363
  Top = 223
  Width = 697
  Height = 546
  Caption = 'User Maintenance'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 302
    Height = 512
    Align = alLeft
    TabOrder = 0
    object GroupBox3: TGroupBox
      Left = 10
      Top = 16
      Width = 281
      Height = 251
      Caption = 'Menu Groups'
      TabOrder = 0
      object vleMenuGroup: TValueListEditor
        Left = 10
        Top = 19
        Width = 255
        Height = 191
        KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
        Strings.Strings = (
          'Basic='
          'Forecasters='
          'Planners='
          'Managers='
          'Administrators=')
        TabOrder = 0
        TitleCaptions.Strings = (
          'Menu Group'
          'Disabled Menu Items')
        OnSelectCell = vleMenuGroupSelectCell
        ColWidths = (
          249
          0)
      end
      object BitBtn4: TBitBtn
        Left = 16
        Top = 217
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = BitBtn4Click
      end
      object BitBtn5: TBitBtn
        Left = 98
        Top = 217
        Width = 75
        Height = 25
        Caption = 'Rename'
        TabOrder = 2
        OnClick = BitBtn5Click
      end
      object BitBtn6: TBitBtn
        Left = 182
        Top = 217
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 3
        OnClick = BitBtn6Click
      end
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 272
      Width = 281
      Height = 229
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 11
        Width = 259
        Height = 13
        Caption = 
          'Users that belong to the                                       G' +
          'roup'
      end
      object Edit2: TEdit
        Left = 126
        Top = 9
        Width = 108
        Height = 21
        Color = clInfoBk
        ReadOnly = True
        TabOrder = 0
        Text = 'Basic'
      end
      object lstUser: TListBox
        Left = 16
        Top = 34
        Width = 177
        Height = 184
        ItemHeight = 13
        TabOrder = 1
      end
      object BitBtn3: TBitBtn
        Left = 198
        Top = 111
        Width = 75
        Height = 25
        Caption = 'Add/Remove'
        TabOrder = 2
        OnClick = BitBtn3Click
      end
    end
  end
  object Panel2: TPanel
    Left = 302
    Top = 0
    Width = 387
    Height = 512
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 470
      Width = 385
      Height = 41
      Align = alBottom
      TabOrder = 0
      object BitBtn1: TBitBtn
        Left = 196
        Top = 8
        Width = 75
        Height = 25
        TabOrder = 0
        Kind = bkOK
      end
      object BitBtn2: TBitBtn
        Left = 276
        Top = 8
        Width = 75
        Height = 25
        TabOrder = 1
        Kind = bkCancel
      end
      object vleUserList: TValueListEditor
        Left = 22
        Top = -24
        Width = 129
        Height = 65
        KeyOptions = [keyUnique]
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
        TabOrder = 2
        TitleCaptions.Strings = (
          'User'
          'Menu Group')
        Visible = False
        ColWidths = (
          150
          -27)
      end
    end
    object CheckListBox1: TCheckListBox
      Left = 1
      Top = 52
      Width = 385
      Height = 418
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Fixedsys'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 1
      OnClick = CheckListBox1Click
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 385
      Height = 51
      Align = alTop
      TabOrder = 2
      object Label2: TLabel
        Left = 14
        Top = 21
        Width = 70
        Height = 13
        Caption = 'Menu Items for'
      end
      object Edit1: TEdit
        Left = 94
        Top = 17
        Width = 213
        Height = 21
        Color = clInfoBk
        ReadOnly = True
        TabOrder = 0
        Text = 'Basic'
      end
    end
  end
end
