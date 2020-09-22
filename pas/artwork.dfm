object ArtDlg: TArtDlg
  Left = 511
  Top = 182
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Hintergrund erzeugen'
  ClientHeight = 265
  ClientWidth = 267
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 112
    Width = 249
    Height = 113
    Caption = 'Farben'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 8
    Top = 232
    Width = 75
    Height = 25
    HelpContext = 10
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 4
    OnContextPopup = DirectionContextPopup
  end
  object Button2: TButton
    Left = 96
    Top = 232
    Width = 75
    Height = 25
    HelpContext = 11
    Cancel = True
    Caption = 'Abbruch'
    ModalResult = 2
    TabOrder = 5
    OnContextPopup = DirectionContextPopup
  end
  inline Frame: TFlowFrm
    Left = 16
    Top = 128
    Width = 233
    HorzScrollBar.Range = 0
    VertScrollBar.Range = 0
    AutoScroll = False
    TabOrder = 3
    inherited numbers: TComboBox
      OnChange = FramenumbersChange
    end
    inherited text2: TStaticText
      Top = 72
    end
  end
  object Direction: TRadioGroup
    Tag = 2
    Left = 8
    Top = 8
    Width = 137
    Height = 97
    HelpContext = 200
    Caption = 'Richtung'
    ItemIndex = 0
    Items.Strings = (
      'Vertikal'
      'Horizontal'
      'Diagonal \'
      'Diagonal /')
    TabOrder = 0
    OnClick = DirectionClick
    OnContextPopup = DirectionContextPopup
  end
  object bisfenster: TRadioGroup
    Left = 152
    Top = 8
    Width = 105
    Height = 57
    HelpContext = 201
    Caption = 'Farbverteilung'
    ItemIndex = 1
    Items.Strings = (
      'bis Minibrowser'
      'bis Playlist')
    TabOrder = 1
    OnContextPopup = DirectionContextPopup
  end
  object Button3: TButton
    Left = 184
    Top = 232
    Width = 75
    Height = 25
    HelpContext = 301
    Caption = 'Zufall'
    TabOrder = 6
    OnClick = Button3Click
    OnContextPopup = DirectionContextPopup
    OnDragDrop = Button3DragDrop
    OnDragOver = Button3DragOver
  end
  object CheckBox1: TCheckBox
    Left = 152
    Top = 72
    Width = 105
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 7
  end
end
