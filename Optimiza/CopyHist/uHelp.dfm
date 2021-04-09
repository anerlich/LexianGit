object frmHelp: TfrmHelp
  Left = 290
  Top = 210
  Width = 514
  Height = 405
  Caption = 'Help'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 506
    Height = 341
    Align = alClient
    TabOrder = 0
    object RichEdit1: TRichEdit
      Left = 1
      Top = 1
      Width = 504
      Height = 339
      Align = alClient
      Lines.Strings = (
        'Adding Product Codes:'
        '-----------------------------------'
        
          'Product Codes can be entered manually or dragged and dropped fro' +
          'm the search results.'
        ''
        'Manual Method:'
        '  1. Click on the '#39'Add'#39' button to add a blank row. '
        
          '  2. Click on the empty Source or Target cell and enter the prod' +
          'uct code. '
        '      Note: The product code is case sensitive.'
        ''
        'Drag and Drop Method:'
        
          '  1. Enter the product code in the search box and click on the '#39 +
          'Find'#39' button.'
        
          '      Note: A partial or full product code may be entered as sea' +
          'rch criteria.'
        
          '  2. Once the search result(s) display, click on the required pr' +
          'oduct code and drag to the product list.'
        
          '  3. Drop the product code onto either the Source or Target colu' +
          'mn.'
        
          '      Note: To add a new product to the list, drop the product b' +
          'elow the last product in the list. '
        
          '                To replace an existing product, drop over the ex' +
          'isting product.'
        
          '                When a product is dropped on the column titles, ' +
          'this too will add a new product.'
        ''
        'Deleting Product Codes:'
        '--------------------------------------'
        '1. Click on the product to be deleted.'
        '2. Click on the '#39'Delete'#39' button.')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 341
    Width = 506
    Height = 37
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 416
      Top = 5
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
  end
end
