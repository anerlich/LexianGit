inherited frmFileName: TfrmFileName
  Caption = 'System 3 Conversion Utility'
  ClientHeight = 188
  ClientWidth = 414
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Left = 6
    Width = 401
    Height = 145
  end
  inherited Label1: TLabel
    Left = 18
    Top = 88
    Width = 172
    Caption = 'Path and File Name for Mlsysdir.dbf :'
  end
  object Label2: TLabel [2]
    Left = 18
    Top = 24
    Width = 89
    Height = 13
    Caption = 'Current Database :'
  end
  inherited OKBtn: TButton
    Left = 252
    Top = 159
  end
  inherited CancelBtn: TButton
    Left = 332
    Top = 159
  end
  inherited Edit1: TEdit
    Top = 111
    Width = 295
  end
  inherited Button1: TButton
    Left = 327
    Top = 107
    Width = 68
  end
  object Edit2: TEdit [7]
    Left = 16
    Top = 48
    Width = 380
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  inherited OpenDialog1: TOpenDialog
    Left = 288
    Top = 0
  end
end
