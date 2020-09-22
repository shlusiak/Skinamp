object skincheat: Tskincheat
  Left = 432
  Top = 144
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Cheat-Text'
  ClientHeight = 113
  ClientWidth = 261
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
  object Button1: TButton
    Left = 168
    Top = 80
    Width = 89
    Height = 25
    HelpContext = 10
    Cancel = True
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnContextPopup = Button3ContextPopup
  end
  object cheattext: TEdit
    Left = 8
    Top = 48
    Width = 249
    Height = 23
    HelpContext = 101
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button3: TButton
    Left = 8
    Top = 80
    Width = 89
    Height = 25
    HelpContext = 100
    Caption = '&Zufällig'
    TabOrder = 2
    OnClick = Button3Click
    OnContextPopup = Button3ContextPopup
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 8
    Width = 249
    Height = 33
    HelpContext = 101
    Alignment = taCenter
    AutoSize = False
    Caption = 'StaticText1'
    TabOrder = 3
    OnContextPopup = Button3ContextPopup
  end
end
