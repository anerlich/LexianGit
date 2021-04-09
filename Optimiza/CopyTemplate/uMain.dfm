object frmMain: TfrmMain
  Left = 370
  Top = 245
  Width = 658
  Height = 491
  Caption = 'Copy User Templates'
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
  object Splitter1: TSplitter
    Left = 0
    Top = 41
    Width = 3
    Height = 397
    Cursor = crHSplit
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 438
    Width = 650
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object Panel10: TPanel
    Left = 0
    Top = 0
    Width = 650
    Height = 41
    Align = alTop
    PopupMenu = PopupMenu1
    TabOrder = 1
    object BitBtn8: TBitBtn
      Left = 4
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkClose
    end
    object BitBtn9: TBitBtn
      Left = 102
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Export User Templates'
      TabOrder = 1
      OnClick = BitBtn9Click
    end
    object BitBtn11: TBitBtn
      Left = 554
      Top = 8
      Width = 91
      Height = 25
      Caption = 'Admin Options'
      TabOrder = 2
      OnClick = BitBtn11Click
    end
    object Button3: TButton
      Left = 236
      Top = 8
      Width = 145
      Height = 25
      Caption = 'Export Report Templates'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 385
      Top = 8
      Width = 89
      Height = 25
      Caption = 'Export Users'
      TabOrder = 4
      OnClick = Button4Click
    end
  end
  object PageControl1: TPageControl
    Left = 3
    Top = 41
    Width = 647
    Height = 397
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Copy'
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 321
        Height = 337
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel4'
        TabOrder = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 321
          Height = 67
          Align = alTop
          TabOrder = 0
          object Label1: TLabel
            Left = 68
            Top = 16
            Width = 119
            Height = 13
            Caption = 'Copy Template from User'
          end
          object edtUserFrom: TEdit
            Left = 13
            Top = 38
            Width = 201
            Height = 21
            ReadOnly = True
            TabOrder = 0
          end
          object Button1: TButton
            Left = 215
            Top = 36
            Width = 32
            Height = 25
            Caption = '...'
            TabOrder = 1
            OnClick = Button1Click
          end
          object edtUserFromNo: TEdit
            Left = 214
            Top = 8
            Width = 35
            Height = 21
            TabOrder = 2
            Visible = False
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 67
          Width = 321
          Height = 270
          Align = alClient
          Caption = 'Panel1'
          TabOrder = 1
          object Panel2: TPanel
            Left = 1
            Top = 1
            Width = 319
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Template(s) to Copy'
            TabOrder = 0
          end
          object Panel3: TPanel
            Left = 1
            Top = 228
            Width = 319
            Height = 41
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object BitBtn4: TBitBtn
              Left = 5
              Top = 8
              Width = 98
              Height = 25
              Caption = 'Add to List'
              TabOrder = 0
              OnClick = BitBtn4Click
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
                0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
                0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000008000008000008000008000
                0080000080000080000080000080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                0000800000800000800000800000800000800000800000800000800000800000
                80C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000008000008000008000008000
                0080000080000080000080000080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
                0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
                0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
                C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
            end
            object BitBtn5: TBitBtn
              Left = 112
              Top = 8
              Width = 98
              Height = 25
              Caption = 'Remove from List'
              TabOrder = 1
              OnClick = BitBtn5Click
            end
            object BitBtn6: TBitBtn
              Left = 216
              Top = 8
              Width = 98
              Height = 25
              Caption = 'Remove All'
              TabOrder = 2
              OnClick = BitBtn6Click
            end
          end
          object vleTemplate: TValueListEditor
            Left = 1
            Top = 42
            Width = 319
            Height = 186
            Align = alClient
            KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
            TabOrder = 2
            TitleCaptions.Strings = (
              'Template No'
              'Template Name')
            ColWidths = (
              78
              235)
          end
        end
      end
      object Panel6: TPanel
        Left = 321
        Top = 0
        Width = 318
        Height = 337
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel6'
        TabOrder = 1
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 318
          Height = 41
          Align = alTop
          Caption = 'Copy Template to User(s)'
          TabOrder = 0
        end
        object Panel8: TPanel
          Left = 0
          Top = 296
          Width = 318
          Height = 41
          Align = alBottom
          TabOrder = 1
          object BitBtn1: TBitBtn
            Left = 9
            Top = 8
            Width = 98
            Height = 25
            Caption = 'Add to List'
            TabOrder = 0
            OnClick = BitBtn1Click
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
              0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
              0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000008000008000008000008000
              0080000080000080000080000080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              0000800000800000800000800000800000800000800000800000800000800000
              80C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000008000008000008000008000
              0080000080000080000080000080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
              0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0000080000080000080C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000008000
              0080000080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
              C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
          end
          object BitBtn2: TBitBtn
            Left = 113
            Top = 8
            Width = 98
            Height = 25
            Caption = 'Remove from List'
            TabOrder = 1
            OnClick = BitBtn2Click
          end
          object BitBtn3: TBitBtn
            Left = 214
            Top = 8
            Width = 98
            Height = 25
            Caption = 'Remove All'
            TabOrder = 2
            OnClick = BitBtn3Click
          end
        end
        object vleUserTo: TValueListEditor
          Left = 0
          Top = 41
          Width = 318
          Height = 255
          Align = alClient
          KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
          TabOrder = 2
          TitleCaptions.Strings = (
            'User No'
            'User Name')
          ColWidths = (
            84
            228)
        end
      end
      object Panel9: TPanel
        Left = 0
        Top = 337
        Width = 639
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object BitBtn7: TBitBtn
          Left = 435
          Top = 4
          Width = 75
          Height = 25
          Caption = 'Copy'
          TabOrder = 0
          OnClick = BitBtn7Click
          Kind = bkOK
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Copy As'
      ImageIndex = 2
      object Label4: TLabel
        Left = 12
        Top = 16
        Width = 22
        Height = 13
        Caption = 'User'
      end
      object Label5: TLabel
        Left = 12
        Top = 53
        Width = 44
        Height = 13
        Caption = 'Template'
      end
      object Label6: TLabel
        Left = 12
        Top = 90
        Width = 39
        Height = 13
        Caption = 'Copy As'
      end
      object edtUserSaveAs: TEdit
        Left = 80
        Top = 14
        Width = 201
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
      object Button5: TButton
        Left = 284
        Top = 12
        Width = 32
        Height = 25
        Caption = '...'
        TabOrder = 1
        OnClick = Button5Click
      end
      object BitBtn12: TBitBtn
        Left = 364
        Top = 49
        Width = 33
        Height = 25
        Caption = '...'
        TabOrder = 2
        OnClick = BitBtn12Click
      end
      object edtUserSaveAsno: TEdit
        Left = 438
        Top = 16
        Width = 65
        Height = 21
        TabOrder = 3
        Visible = False
      end
      object edtTemplate: TEdit
        Left = 80
        Top = 51
        Width = 281
        Height = 21
        ReadOnly = True
        TabOrder = 4
      end
      object edtSaveTemplateNo: TEdit
        Left = 472
        Top = 56
        Width = 73
        Height = 21
        TabOrder = 5
        Visible = False
      end
      object edtNewName: TEdit
        Left = 80
        Top = 88
        Width = 281
        Height = 21
        TabOrder = 6
      end
      object BitBtn13: TBitBtn
        Left = 80
        Top = 128
        Width = 75
        Height = 25
        Caption = 'Copy'
        TabOrder = 7
        OnClick = BitBtn13Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Delete'
      ImageIndex = 1
      object Label2: TLabel
        Left = 68
        Top = 16
        Width = 126
        Height = 13
        Caption = 'Delete Template from User'
      end
      object Label3: TLabel
        Left = 16
        Top = 136
        Width = 72
        Height = 13
        Caption = 'Deletion Status'
      end
      object edtDeleteFromNo: TEdit
        Left = 214
        Top = 8
        Width = 35
        Height = 21
        TabOrder = 0
        Visible = False
      end
      object edtDeleteFrom: TEdit
        Left = 13
        Top = 38
        Width = 201
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object Button2: TButton
        Left = 215
        Top = 36
        Width = 32
        Height = 25
        Caption = '...'
        TabOrder = 2
        OnClick = Button2Click
      end
      object BitBtn10: TBitBtn
        Left = 16
        Top = 88
        Width = 225
        Height = 25
        Caption = 'Select Templates to Delete'
        TabOrder = 3
        OnClick = BitBtn10Click
      end
      object Memo1: TMemo
        Left = 16
        Top = 152
        Width = 417
        Height = 209
        Color = clInfoBk
        ReadOnly = True
        TabOrder = 4
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 608
    Top = 40
    object Upgrade1: TMenuItem
      Caption = 'Upgrade...'
      OnClick = Upgrade1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object RemoveSpecificRepCat1: TMenuItem
      Caption = 'Remove Specific Rep Cat from all templates'
      OnClick = RemoveSpecificRepCat1Click
    end
    object ReassignReportCategory1: TMenuItem
      Caption = 'Reassign Report Category'
      OnClick = ReassignReportCategory1Click
    end
  end
end
