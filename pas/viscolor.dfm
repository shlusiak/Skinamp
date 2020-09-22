object viscolordlg: Tviscolordlg
  Left = 443
  Top = 158
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Visualisierung'
  ClientHeight = 295
  ClientWidth = 278
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
    Top = 8
    Width = 121
    Height = 281
    HelpContext = 1000
    BiDiMode = bdRightToLeft
    Caption = 'Analysator'
    ParentBiDiMode = False
    TabOrder = 0
    OnContextPopup = GroupBox1ContextPopup
    object spec1: TColorField
      Left = 8
      Top = 16
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec2: TColorField
      Left = 8
      Top = 32
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec3: TColorField
      Left = 8
      Top = 48
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec4: TColorField
      Left = 8
      Top = 64
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec5: TColorField
      Left = 8
      Top = 80
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec6: TColorField
      Left = 8
      Top = 96
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec7: TColorField
      Left = 8
      Top = 112
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec8: TColorField
      Left = 8
      Top = 128
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec9: TColorField
      Left = 8
      Top = 144
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec10: TColorField
      Left = 8
      Top = 160
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec11: TColorField
      Left = 8
      Top = 176
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec12: TColorField
      Left = 8
      Top = 192
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec13: TColorField
      Left = 8
      Top = 208
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec14: TColorField
      Left = 8
      Top = 224
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec15: TColorField
      Left = 8
      Top = 240
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object spec16: TColorField
      Left = 8
      Top = 256
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object Button1: TButton
      Left = 38
      Top = 40
      Width = 75
      Height = 25
      HelpContext = 1000
      Caption = 'Verlauf...'
      TabOrder = 0
      OnClick = Button1Click
      OnContextPopup = GroupBox1ContextPopup
    end
    object StaticText1: TStaticText
      Left = 40
      Top = 16
      Width = 30
      Height = 17
      Caption = 'Oben'
      TabOrder = 1
    end
    object StaticText2: TStaticText
      Left = 40
      Top = 256
      Width = 33
      Height = 17
      Caption = 'Unten'
      TabOrder = 2
    end
  end
  object Button2: TButton
    Left = 184
    Top = 264
    Width = 81
    Height = 25
    HelpContext = 10
    Cancel = True
    Caption = 'Close'
    Default = True
    ModalResult = 1
    TabOrder = 4
    OnContextPopup = GroupBox1ContextPopup
  end
  object GroupBox2: TGroupBox
    Left = 144
    Top = 8
    Width = 121
    Height = 105
    HelpContext = 1000
    Caption = 'Oscilloscop'
    TabOrder = 1
    OnContextPopup = GroupBox1ContextPopup
    object osc1: TColorField
      Left = 8
      Top = 16
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object osc2: TColorField
      Left = 8
      Top = 32
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object osc3: TColorField
      Left = 8
      Top = 48
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object osc4: TColorField
      Left = 8
      Top = 64
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object osc5: TColorField
      Left = 8
      Top = 80
      Width = 25
      Height = 17
      Pen.Style = psClear
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object Button4: TButton
      Left = 40
      Top = 40
      Width = 75
      Height = 25
      HelpContext = 1000
      Caption = 'Verlauf...'
      TabOrder = 0
      OnClick = Button4Click
      OnContextPopup = GroupBox1ContextPopup
    end
    object StaticText3: TStaticText
      Left = 40
      Top = 16
      Width = 31
      Height = 17
      Caption = 'Innen'
      TabOrder = 1
    end
    object StaticText4: TStaticText
      Left = 40
      Top = 80
      Width = 39
      Height = 17
      Caption = 'Aussen'
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 144
    Top = 120
    Width = 121
    Height = 89
    HelpContext = 1000
    Caption = '&Sonstiges'
    TabOrder = 2
    OnContextPopup = GroupBox1ContextPopup
    object Label1: TLabel
      Left = 40
      Top = 16
      Width = 55
      Height = 13
      Caption = 'Hintergrund'
    end
    object Label2: TLabel
      Left = 40
      Top = 40
      Width = 34
      Height = 13
      Caption = 'Punkte'
    end
    object Label3: TLabel
      Left = 40
      Top = 64
      Width = 35
      Height = 13
      Caption = 'Spitzen'
    end
    object s1: TColorField
      Left = 8
      Top = 16
      Width = 25
      Height = 17
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object s2: TColorField
      Left = 8
      Top = 40
      Width = 25
      Height = 17
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
    object s3: TColorField
      Left = 8
      Top = 64
      Width = 25
      Height = 17
      OnLeftClick = spec1LeftClick
      OnRightClick = spec1RightClick
    end
  end
  object Button3: TButton
    Left = 184
    Top = 232
    Width = 81
    Height = 25
    HelpContext = 1001
    Caption = 'Import'
    TabOrder = 3
    OnClick = Button3Click
    OnContextPopup = GroupBox1ContextPopup
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'txt'
    FileName = 'viscolor.txt'
    Filter = 'Viscolor Files (viscolor.txt)|viscolor.txt|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 128
    Top = 208
  end
end
