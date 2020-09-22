object pltextdlg: Tpltextdlg
  Left = 666
  Top = 323
  HelpContext = 700
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Playlist Text'
  ClientHeight = 234
  ClientWidth = 183
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
  object GroupBox5: TGroupBox
    Left = 8
    Top = 8
    Width = 169
    Height = 177
    HelpContext = 700
    Caption = 'Playlist Text'
    TabOrder = 0
    OnContextPopup = Button1ContextPopup
    object Label1: TLabel
      Left = 48
      Top = 32
      Width = 33
      Height = 13
      Caption = 'Normal'
    end
    object Label2: TLabel
      Left = 48
      Top = 56
      Width = 32
      Height = 13
      Caption = 'Aktuell'
    end
    object Label3: TLabel
      Left = 48
      Top = 80
      Width = 100
      Height = 13
      Caption = 'Normaler Hintergrund'
    end
    object Label4: TLabel
      Left = 48
      Top = 104
      Width = 111
      Height = 13
      Caption = 'Selektierter Hintergrund'
    end
    object pt1: TColorField
      Left = 16
      Top = 30
      Width = 25
      Height = 17
      OnLeftClick = pt1LeftClick
      OnRightClick = pt1RightClick
    end
    object pt2: TColorField
      Left = 16
      Top = 54
      Width = 25
      Height = 17
      OnLeftClick = pt1LeftClick
      OnRightClick = pt1RightClick
    end
    object pt3: TColorField
      Left = 16
      Top = 78
      Width = 25
      Height = 17
      OnLeftClick = pt1LeftClick
      OnRightClick = pt1RightClick
    end
    object pt4: TColorField
      Left = 16
      Top = 102
      Width = 25
      Height = 17
      OnLeftClick = pt1LeftClick
      OnRightClick = pt1RightClick
    end
    object font: TEdit
      Left = 16
      Top = 136
      Width = 137
      Height = 24
      HelpContext = 701
      TabOrder = 0
      OnChange = fontChange
      OnContextPopup = fontContextPopup
    end
  end
  object Button1: TButton
    Left = 56
    Top = 200
    Width = 75
    Height = 25
    HelpContext = 10
    Cancel = True
    Caption = '&Schliessen'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnContextPopup = Button1ContextPopup
  end
  object FontMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    OwnerDraw = True
    Left = 136
    Top = 192
  end
end
