object mbtextdlg: Tmbtextdlg
  Left = 732
  Top = 354
  HelpContext = 600
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Minibrowser Text'
  ClientHeight = 134
  ClientWidth = 171
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
    Left = 50
    Top = 104
    Width = 75
    Height = 25
    HelpContext = 10
    Cancel = True
    Caption = '&Schliessen'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnContextPopup = Button1ContextPopup
  end
  object GroupBox1: TGroupBox
    Left = 11
    Top = 8
    Width = 153
    Height = 81
    HelpContext = 600
    Caption = 'Minibrowser Text'
    TabOrder = 1
    OnContextPopup = Button1ContextPopup
    object Label1: TLabel
      Left = 48
      Top = 26
      Width = 10
      Height = 13
      Caption = 'Hi'
    end
    object Label2: TLabel
      Left = 48
      Top = 50
      Width = 13
      Height = 13
      Caption = 'Vo'
    end
    object mt1: TColorField
      Left = 16
      Top = 24
      Width = 25
      Height = 17
      OnLeftClick = mt1LeftClick
      OnRightClick = mt1RightClick
    end
    object mt2: TColorField
      Left = 16
      Top = 48
      Width = 25
      Height = 17
      OnLeftClick = mt1LeftClick
      OnRightClick = mt1RightClick
    end
  end
end
