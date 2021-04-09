object frmEditDrive: TfrmEditDrive
  Left = 326
  Top = 220
  Width = 538
  Height = 200
  Caption = 'Drive Settings'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 63
    Top = 40
    Width = 70
    Height = 13
    Caption = 'Selected Drive'
  end
  object Label2: TLabel
    Left = 63
    Top = 84
    Width = 115
    Height = 13
    Caption = 'Disk Space no less than'
  end
  object Label3: TLabel
    Left = 245
    Top = 85
    Width = 22
    Height = 13
    Caption = '(MB)'
  end
  object Edit1: TEdit
    Left = 184
    Top = 32
    Width = 249
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object edtMB: TMaskEdit
    Left = 184
    Top = 80
    Width = 55
    Height = 21
    EditMask = '!99999;0; '
    MaxLength = 5
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 352
    Top = 136
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 448
    Top = 136
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object BitBtn3: TBitBtn
    Left = 251
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Delete'
    ModalResult = 6
    TabOrder = 4
    OnClick = BitBtn3Click
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000080000000
      8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000008000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000080000000
      800000008000C0C0C000C0C0C000C0C0C00000008000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      800000008000C0C0C000C0C0C0000000800000008000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000080000000800080008000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000800080000000800000008000C0C0C000C0C0C000C0C0C00000000000C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C00000000000C0C0
      C00000008000800080000000800000008000C0C0C000C0C0C00000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      800000008000C0C0C000C0C0C000000080000000800080008000000000008000
      0000800000008000000080000000800000008000000080008000000080008000
      0000800000008000000080000000C0C0C0008000800000008000C0C0C0008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000800080008000FFFF
      FF00FFFFFF00FFFFFF0080000000C0C0C000C0C0C000C0C0C000C0C0C0008000
      0000FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF000000
      000000000000FFFFFF0080000000C0C0C000C0C0C000C0C0C000C0C0C0008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080000000C0C0C000C0C0C000C0C0C000C0C0C0008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000C0C0C000C0C0C000C0C0C000C0C0C0008000
      0000C0C0C0008000000080000000C0C0C0008000000080000000C0C0C0008000
      000080000000C0C0C00080000000C0C0C000C0C0C000C0C0C000C0C0C0008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000C0C0C000C0C0C000C0C0C000}
  end
end
