object saveskin: Tsaveskin
  Left = 394
  Top = 142
  HelpContext = 802
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Speichern'
  ClientHeight = 289
  ClientWidth = 269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 247
    Width = 97
    Height = 29
    HelpContext = 10
    Anchors = [akLeft, akBottom]
    Caption = '&Save'
    Default = True
    TabOrder = 3
    OnClick = Button1Click
    OnContextPopup = StaticText1ContextPopup
  end
  object Button2: TButton
    Left = 156
    Top = 247
    Width = 97
    Height = 29
    HelpContext = 11
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Abbruch'
    ModalResult = 2
    TabOrder = 4
    OnContextPopup = StaticText1ContextPopup
  end
  object dir: TEdit
    Left = 16
    Top = 213
    Width = 237
    Height = 21
    HelpContext = 800
    Anchors = [akLeft, akRight, akBottom]
    AutoSelect = False
    TabOrder = 2
    OnEnter = dirEnter
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 8
    Width = 241
    Height = 33
    HelpContext = 802
    Alignment = taCenter
    AutoSize = False
    Caption = 'Geben Sie Namen oder Verzeichnis ein:'
    TabOrder = 5
    OnContextPopup = StaticText1ContextPopup
  end
  object what: TCheckListBox
    Left = 16
    Top = 48
    Width = 241
    Height = 137
    HelpContext = 802
    ItemHeight = 13
    Items.Strings = (
      'Main'
      'Equalizer'
      'Playlist'
      'Minibrowser'
      'AVS'
      'Readme.txt'
      'Viscolor.txt'
      'Pledit.txt'
      'Region.txt'
      'Cursors')
    TabOrder = 0
  end
  object Zipped: TCheckBox
    Left = 16
    Top = 189
    Width = 237
    Height = 17
    HelpContext = 801
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&WSZ'
    TabOrder = 1
    OnClick = ZippedClick
    OnContextPopup = StaticText1ContextPopup
  end
end
