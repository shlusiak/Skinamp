object getcolor: Tgetcolor
  Left = 359
  Top = 182
  HelpContext = 901
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Farbe suchen'
  ClientHeight = 139
  ClientWidth = 229
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Shape: TShape
    Left = 8
    Top = 49
    Width = 217
    Height = 57
    Brush.Color = clBlack
    OnMouseDown = ShapeMouseDown
    OnMouseMove = ShapeMouseMove
    OnMouseUp = ShapeMouseUp
  end
  object StaticText1: TStaticText
    Left = 0
    Top = 8
    Width = 225
    Height = 41
    HelpContext = 901
    Alignment = taCenter
    AutoSize = False
    Caption = 'Klicken Sie auf das Feld...'
    TabOrder = 0
    OnContextPopup = StaticText1ContextPopup
  end
  object Button1: TButton
    Left = 8
    Top = 112
    Width = 65
    Height = 25
    HelpContext = 10
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnContextPopup = StaticText1ContextPopup
  end
  object Button2: TButton
    Left = 152
    Top = 112
    Width = 73
    Height = 25
    HelpContext = 11
    Cancel = True
    Caption = 'Abbruch'
    ModalResult = 2
    TabOrder = 2
    OnContextPopup = StaticText1ContextPopup
  end
  object Button3: TButton
    Left = 80
    Top = 112
    Width = 67
    Height = 25
    HelpContext = 900
    Caption = 'Zufall'
    TabOrder = 3
    OnClick = Button3Click
    OnContextPopup = StaticText1ContextPopup
  end
end
