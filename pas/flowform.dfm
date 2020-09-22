object FlowDlg: TFlowDlg
  Left = 494
  Top = 219
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Farbverlauf:'
  ClientHeight = 131
  ClientWidth = 311
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
    Left = 8
    Top = 96
    Width = 73
    Height = 25
    HelpContext = 10
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnContextPopup = Button1ContextPopup
  end
  object Button2: TButton
    Left = 84
    Top = 96
    Width = 73
    Height = 25
    HelpContext = 11
    Cancel = True
    Caption = 'Abbruch'
    ModalResult = 2
    TabOrder = 2
    OnContextPopup = Button1ContextPopup
  end
  inline Frame: TFlowFrm
    Left = 2
    Top = 3
  end
  object Button3: TButton
    Left = 235
    Top = 96
    Width = 73
    Height = 25
    HelpContext = 301
    Caption = 'Zufall'
    TabOrder = 4
    OnClick = Button3Click
    OnContextPopup = Button1ContextPopup
    OnDragDrop = Button3DragDrop
    OnDragOver = Button3DragOver
  end
  object Button4: TButton
    Left = 159
    Top = 96
    Width = 73
    Height = 25
    HelpContext = 300
    Caption = 'Tauschen'
    TabOrder = 3
    OnClick = Button4Click
    OnContextPopup = Button1ContextPopup
  end
end
