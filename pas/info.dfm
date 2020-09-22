object infodialog: Tinfodialog
  Left = 393
  Top = 151
  HelpContext = 2
  ActiveControl = NowButton
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Info über SkinAmp...'
  ClientHeight = 245
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 32
    Height = 32
    AutoSize = True
    DragMode = dmAutomatic
    OnMouseMove = FormMouseMove
  end
  object Image2: TImage
    Left = 232
    Top = 8
    Width = 32
    Height = 32
    Hint = 'Sascha (32x32)'
    ParentShowHint = False
    ShowHint = True
    OnDragDrop = Image2DragDrop
    OnDragOver = Image2DragOver
    OnMouseMove = FormMouseMove
  end
  object StaticText3: TStaticText
    Left = 11
    Top = 80
    Width = 250
    Height = 33
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSunken
    Caption = 'Darf kopiert werden!'
    Color = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clAqua
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ShowAccelChar = False
    TabOrder = 0
    OnMouseMove = FormMouseMove
  end
  object StaticText2: TStaticText
    Left = 12
    Top = 56
    Width = 249
    Height = 17
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Sascha Hlusiak'
    TabOrder = 1
    OnMouseMove = FormMouseMove
  end
  object EMail: TStaticText
    Tag = 1
    Left = 44
    Top = 120
    Width = 185
    Height = 17
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 6
    OnMouseDown = homepageMouseDown
    OnMouseMove = winampMouseMove
    OnMouseUp = homepageMouseUp
  end
  object homepage: TStaticText
    Tag = 2
    Left = 24
    Top = 136
    Width = 225
    Height = 17
    Cursor = crHandPoint
    Alignment = taCenter
    AutoSize = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 7
    OnMouseDown = homepageMouseDown
    OnMouseMove = winampMouseMove
    OnMouseUp = homepageMouseUp
  end
  object NowButton: TButton
    Left = 8
    Top = 195
    Width = 81
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Urheber l&oben'
    Default = True
    ModalResult = 1
    TabOrder = 5
    OnClick = NowButtonClick
    OnMouseMove = FormMouseMove
  end
  object StaticText1: TStaticText
    Left = 98
    Top = 16
    Width = 76
    Height = 17
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    Caption = 'SkinAmp v1.14'
    TabOrder = 2
    OnMouseMove = StaticText1MouseMove
    OnMouseUp = StaticText1MouseUp
  end
  object laterButton: TButton
    Left = 96
    Top = 195
    Width = 81
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Später'
    TabOrder = 4
    TabStop = False
    OnEnter = laterButtonEnter
    OnMouseDown = laterButtonMouseDown
    OnMouseMove = schlechtmoved
  end
  object NeverButton: TButton
    Left = 184
    Top = 195
    Width = 81
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Nie'
    TabOrder = 3
    TabStop = False
    OnEnter = laterButtonEnter
    OnMouseDown = laterButtonMouseDown
    OnMouseMove = schlechtmoved
  end
  object winamp: TStaticText
    Tag = 3
    Left = 91
    Top = 152
    Width = 4
    Height = 4
    Cursor = crHandPoint
    TabOrder = 8
    OnMouseDown = homepageMouseDown
    OnMouseMove = winampMouseMove
    OnMouseUp = homepageMouseUp
  end
end
