object frmTestFP: TfrmTestFP
  Left = 346
  Top = 310
  Width = 308
  Height = 163
  Caption = 'Test Forward plan'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblProductCode: TLabel
    Left = 0
    Top = 116
    Width = 300
    Height = 13
    Align = alBottom
    AutoSize = False
  end
  object lblLocation: TLabel
    Left = 24
    Top = 20
    Width = 41
    Height = 13
    Caption = 'Location'
  end
  object lblTemplate: TLabel
    Left = 21
    Top = 51
    Width = 44
    Height = 13
    Caption = 'Template'
  end
  object btnMany: TButton
    Left = 72
    Top = 80
    Width = 209
    Height = 33
    Caption = 'Get and save a whole lot'
    TabOrder = 0
    OnClick = btnManyClick
  end
  object cmbTemplates: TDBLookupComboBox
    Left = 72
    Top = 48
    Width = 209
    Height = 21
    KeyField = 'TEMPLATENO'
    ListField = 'DESCRIPTION'
    ListSource = FPTestDLLDatamodule.dscTemplate
    TabOrder = 1
  end
  object lcbLocation: TDBLookupComboBox
    Left = 72
    Top = 16
    Width = 209
    Height = 21
    KeyField = 'LOCATIONNO'
    ListField = 'DESCRIPTION'
    ListSource = FPTestDLLDatamodule.dscLocations
    TabOrder = 2
  end
  object OvcController1: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      ()
      'WordStar'
      False
      ()
      'Grid'
      False
      ())
    EntryOptions = [efoAutoSelect, efoBeepOnError, efoInsertPushes]
    Epoch = 2000
    Left = 32
    Top = 160
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'csv'
    Left = 568
    Top = 144
  end
end
