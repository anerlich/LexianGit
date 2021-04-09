object frmMessage: TfrmMessage
  Left = 436
  Top = 345
  Width = 496
  Height = 490
  Caption = 'Message'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 488
    Height = 105
    Align = alTop
    TabOrder = 0
    object Label4: TLabel
      Left = 11
      Top = 84
      Width = 65
      Height = 13
      Caption = 'Attachments :'
    end
    object edtTo: TEdit
      Left = 49
      Top = 8
      Width = 416
      Height = 21
      TabOrder = 0
    end
    object edtCC: TEdit
      Left = 49
      Top = 32
      Width = 416
      Height = 21
      TabOrder = 1
    end
    object edtBcc: TEdit
      Left = 49
      Top = 56
      Width = 416
      Height = 21
      TabOrder = 2
    end
    object edtAttach: TEdit
      Left = 83
      Top = 80
      Width = 361
      Height = 21
      TabOrder = 3
    end
    object Button1: TButton
      Left = 9
      Top = 8
      Width = 35
      Height = 20
      Caption = 'To...'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 9
      Top = 32
      Width = 35
      Height = 20
      Caption = 'Cc...'
      TabOrder = 5
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 9
      Top = 56
      Width = 35
      Height = 20
      Caption = 'Bcc...'
      TabOrder = 6
      OnClick = Button3Click
    end
    object BitBtn3: TBitBtn
      Left = 446
      Top = 80
      Width = 21
      Height = 22
      TabOrder = 7
      OnClick = BitBtn3Click
      Glyph.Data = {
        AA030000424DAA030000000000001A0000000C0000001000130001001800DEED
        EFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF
        DEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEED
        EFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFA6A6A6
        4D4D4D4D4D4D4D4D4DA6A6A6DEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEED
        EFDEEDEFDEEDEFDEEDEFA6A6A64D4D4DDEEDEFDEEDEFDEEDEF4D4D4DA6A6A6DE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF
        DEEDEF4D4D4DDEEDEFDEEDEF4D4D4DDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEED
        EFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF
        4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEED
        EFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF
        4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEED
        EFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF
        4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEED
        EFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF
        4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEED
        EFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF4D4D4DDEEDEF4D4D4DDEEDEF4D4D4DDE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF
        4D4D4DDEEDEFDEEDEFDEEDEF4D4D4DDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEED
        EFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF4D4D4D4D4D4D4D4D4DDEEDEFDE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEF
        DEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEED
        EFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDEEDEFDE
        EDEFDEEDEFDEEDEFDEEDEFDEEDEF}
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 105
    Width = 488
    Height = 41
    Align = alTop
    TabOrder = 1
    object Label5: TLabel
      Left = 16
      Top = 14
      Width = 36
      Height = 13
      Caption = 'Subject'
    end
    object edtSubject: TEdit
      Left = 72
      Top = 10
      Width = 377
      Height = 21
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 415
    Width = 488
    Height = 41
    Align = alBottom
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 323
      Top = 12
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 406
      Top = 12
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 146
    Width = 488
    Height = 269
    Align = alClient
    TabOrder = 3
    object edtMessage: TMemo
      Left = 1
      Top = 1
      Width = 486
      Height = 267
      Align = alClient
      Color = clInfoBk
      TabOrder = 0
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.csv'
    Filter = 
      'CSV Files|*.csv|Text Files|*.txt|Excel Files (*.xls)|*.xls|All F' +
      'iles|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 536
    Top = 64
  end
end
