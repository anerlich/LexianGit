object frmRecipient: TfrmRecipient
  Left = 511
  Top = 267
  Caption = 'Recipients'
  ClientHeight = 480
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 610
    Height = 439
    Align = alClient
    Caption = 'Panel6'
    TabOrder = 0
    object Splitter3: TSplitter
      Left = 289
      Top = 1
      Height = 437
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 288
      Height = 437
      Align = alLeft
      Caption = 'Panel4'
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 286
        Height = 344
        Align = alTop
        DataSource = dmData.srcUser
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'USERNAME'
            Title.Caption = 'Name'
            Title.Color = clInfoBk
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EADDR'
            Title.Caption = 'Email Addr'
            Title.Color = clInfoBk
            Width = 150
            Visible = True
          end>
      end
      object Panel8: TPanel
        Left = 1
        Top = 345
        Width = 286
        Height = 91
        Align = alClient
        Caption = 'Panel8'
        TabOrder = 1
        Visible = False
        object Panel9: TPanel
          Left = 1
          Top = 1
          Width = 284
          Height = 22
          Align = alTop
          Color = clInfoBk
          TabOrder = 0
          object Label1: TLabel
            Left = 4
            Top = 4
            Width = 76
            Height = 13
            Caption = 'Distribution Lists'
          end
          object BitBtn6: TBitBtn
            Left = 182
            Top = 2
            Width = 97
            Height = 17
            Caption = 'Maintain'
            TabOrder = 0
          end
        end
        object ListBox4: TListBox
          Left = 1
          Top = 23
          Width = 284
          Height = 67
          Align = alClient
          ItemHeight = 13
          Items.Strings = (
            'Line test'
            'Iem 3'
            'Item4')
          MultiSelect = True
          TabOrder = 1
        end
      end
    end
    object Panel5: TPanel
      Left = 292
      Top = 1
      Width = 317
      Height = 437
      Align = alClient
      Caption = 'Panel5'
      TabOrder = 1
      object Splitter1: TSplitter
        Left = 1
        Top = 193
        Width = 315
        Height = 3
        Cursor = crVSplit
        Align = alTop
      end
      object Splitter2: TSplitter
        Left = 1
        Top = 321
        Width = 315
        Height = 3
        Cursor = crVSplit
        Align = alBottom
      end
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 315
        Height = 192
        Align = alTop
        TabOrder = 0
        object BitBtn1: TBitBtn
          Left = 6
          Top = 8
          Width = 75
          Height = 25
          Caption = 'To'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
            0000000000000000000000000000000000000000000000000000C0C0C0C0C0C0
            0000FFC0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000C0C0C0C0C0C00000FF0000FFC0C0C0C0C0C0C0C0C000
            0000FFFFFF000000000000FFFFFF000000000000FFFFFF0000000000FF0000FF
            0000FF0000FF0000FFC0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000000000FF0000FF0000FF0000FF0000FF0000FFC0C0C000
            0000FFFFFF000000000000FFFFFF000000000000FFFFFF0000000000FF0000FF
            0000FF0000FF0000FFC0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000C0C0C0C0C0C00000FF0000FFC0C0C0C0C0C0C0C0C080
            0000800000800000800000800000800000800000800000800000C0C0C0C0C0C0
            0000FFC0C0C0C0C0C0C0C0C0C0C0C0800000FFFFFF800000800000FFFFFF8000
            00800000FFFFFF800000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C080
            0000800000800000800000800000800000800000800000800000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
          Layout = blGlyphRight
          TabOrder = 0
          OnClick = BitBtn1Click
        end
        object ListBox1: TListBox
          Left = 97
          Top = 1
          Width = 217
          Height = 190
          Align = alRight
          ItemHeight = 13
          MultiSelect = True
          TabOrder = 1
          OnKeyDown = ListBox1KeyDown
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 196
        Width = 315
        Height = 125
        Align = alClient
        TabOrder = 1
        object BitBtn2: TBitBtn
          Left = 6
          Top = 8
          Width = 75
          Height = 25
          Caption = 'CC'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
            0000000000000000000000000000000000000000000000000000C0C0C0C0C0C0
            0000FFC0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000C0C0C0C0C0C00000FF0000FFC0C0C0C0C0C0C0C0C000
            0000FFFFFF000000000000FFFFFF000000000000FFFFFF0000000000FF0000FF
            0000FF0000FF0000FFC0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000000000FF0000FF0000FF0000FF0000FF0000FFC0C0C000
            0000FFFFFF000000000000FFFFFF000000000000FFFFFF0000000000FF0000FF
            0000FF0000FF0000FFC0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000C0C0C0C0C0C00000FF0000FFC0C0C0C0C0C0C0C0C080
            0000800000800000800000800000800000800000800000800000C0C0C0C0C0C0
            0000FFC0C0C0C0C0C0C0C0C0C0C0C0800000FFFFFF800000800000FFFFFF8000
            00800000FFFFFF800000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C080
            0000800000800000800000800000800000800000800000800000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
          Layout = blGlyphRight
          TabOrder = 0
          OnClick = BitBtn2Click
        end
        object ListBox2: TListBox
          Left = 97
          Top = 1
          Width = 217
          Height = 123
          Align = alRight
          ItemHeight = 13
          MultiSelect = True
          TabOrder = 1
          OnKeyDown = ListBox2KeyDown
        end
      end
      object Panel3: TPanel
        Left = 1
        Top = 324
        Width = 315
        Height = 112
        Align = alBottom
        TabOrder = 2
        object BitBtn3: TBitBtn
          Left = 6
          Top = 8
          Width = 75
          Height = 25
          Caption = 'BCC'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
            0000000000000000000000000000000000000000000000000000C0C0C0C0C0C0
            0000FFC0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000C0C0C0C0C0C00000FF0000FFC0C0C0C0C0C0C0C0C000
            0000FFFFFF000000000000FFFFFF000000000000FFFFFF0000000000FF0000FF
            0000FF0000FF0000FFC0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF0000000000FF0000FF0000FF0000FF0000FF0000FFC0C0C000
            0000FFFFFF000000000000FFFFFF000000000000FFFFFF0000000000FF0000FF
            0000FF0000FF0000FFC0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000C0C0C0C0C0C00000FF0000FFC0C0C0C0C0C0C0C0C080
            0000800000800000800000800000800000800000800000800000C0C0C0C0C0C0
            0000FFC0C0C0C0C0C0C0C0C0C0C0C0800000FFFFFF800000800000FFFFFF8000
            00800000FFFFFF800000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C080
            0000800000800000800000800000800000800000800000800000C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
          Layout = blGlyphRight
          TabOrder = 0
          OnClick = BitBtn3Click
        end
        object ListBox3: TListBox
          Left = 97
          Top = 1
          Width = 217
          Height = 110
          Align = alRight
          ItemHeight = 13
          MultiSelect = True
          TabOrder = 1
          OnKeyDown = ListBox3KeyDown
        end
      end
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 439
    Width = 610
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn4: TBitBtn
      Left = 432
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn5: TBitBtn
      Left = 528
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
