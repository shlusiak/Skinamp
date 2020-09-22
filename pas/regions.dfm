object Regionsdlg: TRegionsdlg
  Left = 486
  Top = 193
  Width = 410
  Height = 283
  HelpContext = 3
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Regionen:'
  Color = clBtnFace
  Constraints.MinHeight = 283
  Constraints.MinWidth = 410
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 140
    Width = 41
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Poly&gon:'
    FocusControl = polnum
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 10
    Top = 159
    Width = 37
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '&Punkte:'
    FocusControl = pointlist
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 320
    Top = 192
    Width = 76
    Height = 25
    AllowAllUp = True
    Anchors = [akRight, akBottom]
    GroupIndex = 1
    Caption = 'Test'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object PaintBox: TPaintBox
    Left = 8
    Top = 8
    Width = 275
    Height = 116
    Cursor = crCross
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnDblClick = PaintBoxDblClick
    OnMouseDown = PaintBoxMouseDown
    OnMouseMove = PaintBoxMouseMove
    OnPaint = PaintBoxPaint
  end
  object SpeedButton2: TSpeedButton
    Left = 368
    Top = 128
    Width = 25
    Height = 25
    AllowAllUp = True
    Anchors = [akTop, akRight]
    GroupIndex = 2
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 336
    Top = 128
    Width = 25
    Height = 25
    AllowAllUp = True
    Anchors = [akTop, akRight]
    GroupIndex = -1
    OnClick = SpeedButton3Click
  end
  object modus: TSpeedButton
    Left = 304
    Top = 128
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    OnClick = BitBtn1Click
  end
  object What: TListBox
    Left = 296
    Top = 8
    Width = 97
    Height = 57
    HelpContext = 1200
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    Items.Strings = (
      'Main'
      'Equalizer'
      'Windowshade'
      'Equalizer WS')
    ParentFont = False
    TabOrder = 3
    OnClick = WhatClick
    OnContextPopup = WhatContextPopup
  end
  object Button1: TButton
    Left = 320
    Top = 224
    Width = 76
    Height = 25
    HelpContext = 10
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 10
    OnContextPopup = WhatContextPopup
  end
  object polynum: TEdit
    Left = 69
    Top = 136
    Width = 50
    Height = 21
    HelpContext = 1201
    Anchors = [akLeft, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = '1'
  end
  object polnum: TUpDown
    Left = 119
    Top = 136
    Width = 19
    Height = 21
    HelpContext = 1201
    Anchors = [akLeft, akBottom]
    Associate = polynum
    Enabled = False
    Min = 1
    Max = 1
    Position = 1
    TabOrder = 2
    Wrap = False
    OnContextPopup = WhatContextPopup
    OnClick = polnumClick
  end
  object Button3: TButton
    Left = 152
    Top = 136
    Width = 64
    Height = 17
    HelpContext = 1201
    Anchors = [akRight, akBottom]
    Caption = '&Neu'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Button3Click
    OnContextPopup = WhatContextPopup
  end
  object Button4: TButton
    Left = 224
    Top = 136
    Width = 63
    Height = 17
    HelpContext = 1201
    Anchors = [akRight, akBottom]
    Caption = '&Löschen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = Button4Click
    OnContextPopup = WhatContextPopup
  end
  object mousex: TStaticText
    Left = 296
    Top = 72
    Width = 23
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'X: ?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object mousey: TStaticText
    Left = 296
    Top = 88
    Width = 23
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Y: ?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object pointlist: TMemo
    Left = 8
    Top = 176
    Width = 281
    Height = 73
    Anchors = [akLeft, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = pointlistChange
    OnKeyDown = FormKeyDown
  end
  object CheckBox1: TCheckBox
    Left = 296
    Top = 104
    Width = 105
    Height = 17
    HelpContext = 1201
    Anchors = [akTop, akRight]
    Caption = '&Alle Polygons'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 8
    OnClick = CheckBox1Click
    OnContextPopup = WhatContextPopup
  end
  object Button2: TButton
    Left = 320
    Top = 160
    Width = 76
    Height = 25
    HelpContext = 1202
    Anchors = [akRight, akBottom]
    Caption = 'Import...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = Button2Click
    OnContextPopup = WhatContextPopup
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'txt'
    FileName = 'region.txt'
    Filter = 'Region files (region.txt)|region.txt|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 280
    Top = 168
  end
end
