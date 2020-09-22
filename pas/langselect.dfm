object languagedlg: Tlanguagedlg
  Left = 388
  Top = 100
  Width = 350
  Height = 410
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Select your language'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 7
    Top = 344
    Width = 32
    Height = 32
    Anchors = [akLeft, akBottom]
    AutoSize = True
  end
  object okbutton: TButton
    Left = 243
    Top = 347
    Width = 91
    Height = 25
    HelpContext = 10
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnContextPopup = LanguagesContextPopup
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 8
    Width = 326
    Height = 17
    HelpContext = 500
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Select your language:'
    TabOrder = 2
    OnContextPopup = LanguagesContextPopup
  end
  object Languages: TListView
    Left = 7
    Top = 33
    Width = 327
    Height = 304
    HelpContext = 500
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        AutoSize = True
        Caption = 'Title'
      end
      item
        AutoSize = True
        Caption = 'Version'
      end
      item
        AutoSize = True
        Caption = 'File'
      end>
    RowSelect = True
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
    OnContextPopup = LanguagesContextPopup
    OnDblClick = LanguagesDblClick
    OnSelectItem = LanguagesSelectItem
  end
end
