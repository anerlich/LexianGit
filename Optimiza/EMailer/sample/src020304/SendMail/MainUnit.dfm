object MailerForm: TMailerForm
  Left = 257
  Top = 118
  Width = 405
  Height = 329
  Caption = 'Mail sender demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 295
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 0
    object ledHost: TLabeledEdit
      Left = 8
      Top = 24
      Width = 177
      Height = 21
      EditLabel.Width = 93
      EditLabel.Height = 13
      EditLabel.Caption = 'Host (SMTP server)'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 0
      Text = 'mail.htnet.hr'
    end
    object ledFrom: TLabeledEdit
      Left = 8
      Top = 76
      Width = 177
      Height = 21
      EditLabel.Width = 23
      EditLabel.Height = 13
      EditLabel.Caption = 'From'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 1
      Text = 'zarko@mono.hr'
    end
    object ledTo: TLabeledEdit
      Left = 8
      Top = 120
      Width = 177
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'To'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 2
      Text = 'delphi.guide@about.com'
    end
    object ledCC: TLabeledEdit
      Left = 8
      Top = 164
      Width = 177
      Height = 21
      EditLabel.Width = 14
      EditLabel.Height = 13
      EditLabel.Caption = 'CC'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 3
      Text = 'ozana@sf.hr'
    end
    object btnSendMail: TBitBtn
      Left = 40
      Top = 193
      Width = 113
      Height = 37
      Caption = 'Send Mail'
      TabOrder = 4
      OnClick = btnSendMailClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        000037777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
        FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF7777BBF
        FFF07F333777777F3FF70FFFFFFFB9BF1CC07F3FFF337F7377770F777FFFB99B
        C1C07F7773337F377F370FFFFFFFB9BBC1C07FFFFFFF7F337FF700000077B999
        B000777777777F33777733337377B9999B33333F733373F337FF3377377B99BB
        9BB33377F337F377377F3737377B9B79B9B737F73337F7F7F37F33733777BB7B
        BBB73373333377F37F3737333777BB777B9B3733333377F337F7333333777B77
        77BB3333333337333377333333333777337B3333333333333337}
      NumGlyphs = 2
    end
    object StatusMemo: TMemo
      Left = 1
      Top = 233
      Width = 191
      Height = 61
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        'Status...'
        '')
      ScrollBars = ssVertical
      TabOrder = 5
    end
  end
  object pnlBottom: TPanel
    Left = 193
    Top = 0
    Width = 204
    Height = 295
    Align = alClient
    BevelOuter = bvLowered
    BorderWidth = 5
    TabOrder = 1
    DesignSize = (
      204
      295)
    object Body: TMemo
      Left = 6
      Top = 92
      Width = 192
      Height = 197
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        'Mail body goes here...')
      TabOrder = 3
    end
    object ledAttachment: TLabeledEdit
      Left = 6
      Top = 72
      Width = 149
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 105
      EditLabel.Height = 13
      EditLabel.Caption = 'Send this file attached'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 1
    end
    object btnAttachment: TBitBtn
      Left = 159
      Top = 72
      Width = 37
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 2
      OnClick = btnAttachmentClick
    end
    object ledSubject: TLabeledEdit
      Left = 6
      Top = 24
      Width = 193
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'Subject'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 0
      Text = 'This is the subject of this mail'
    end
  end
  object MailMessage: TIdMessage
    BccList = <>
    CCList = <>
    Recipients = <>
    ReplyTo = <>
    Left = 232
    Top = 128
  end
  object SMTP: TIdSMTP
    OnStatus = SMTPStatus
    Host = '10.57.0.17'
    AuthenticationType = atLogin
    Password = '123456'
    UserId = 'colin'
    Left = 232
    Top = 180
  end
  object AttachmentDialog: TOpenDialog
    Options = [ofReadOnly, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 233
    Top = 236
  end
end
