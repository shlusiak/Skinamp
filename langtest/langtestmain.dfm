object Langtestform: TLangtestform
  Left = 74
  Top = 158
  Width = 882
  Height = 565
  Caption = 'Language-Test application'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 620
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 104
    Top = 507
    Width = 25
    Height = 25
    Anchors = [akLeft, akBottom]
    Visible = False
    OnPaint = PaintBox1Paint
  end
  object Panel: TPanel
    Left = 8
    Top = 8
    Width = 858
    Height = 493
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 441
      Top = 0
      Width = 3
      Height = 493
      Cursor = crHSplit
    end
    object ergebnis: TMemo
      Left = 444
      Top = 0
      Width = 414
      Height = 493
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        'Select the language for testing...')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object langlist: TListView
      Left = 0
      Top = 0
      Width = 441
      Height = 493
      Align = alLeft
      Columns = <
        item
          AutoSize = True
          Caption = 'File'
        end
        item
          AutoSize = True
          Caption = 'Version'
        end
        item
          Caption = 'Not found'
          Width = 59
        end
        item
          Caption = 'Not translated'
          Width = 78
        end
        item
          Caption = 'Hints'
          Width = 36
        end
        item
          Caption = 'Comments'
          Width = 70
        end
        item
          Caption = 'Double'
          Width = 46
        end>
      GridLines = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = langlistChange
      OnContextPopup = langlistContextPopup
      OnDblClick = langlistDblClick
    end
  end
  object Button1: TButton
    Left = 792
    Top = 508
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Close'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 712
    Top = 508
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Refresh'
    TabOrder = 1
    OnClick = Button2Click
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 510
    Width = 75
    Height = 24
    Anchors = [akLeft, akBottom]
    Caption = 'SkinAmp'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object StaticText2: TStaticText
    Left = 136
    Top = 509
    Width = 113
    Height = 17
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Workerthreads: 0'
    TabOrder = 4
  end
  object Button3: TButton
    Left = 632
    Top = 508
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Edit'
    Enabled = False
    TabOrder = 5
    OnClick = Button3Click
  end
  object StaticText3: TStaticText
    Left = 272
    Top = 510
    Width = 85
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Language files: 1'
    TabOrder = 6
  end
  object Button4: TButton
    Left = 552
    Top = 508
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Add String...'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 472
    Top = 508
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Match all'
    TabOrder = 8
    OnClick = Button5Click
  end
  object Timer: TTimer
    Interval = 180
    OnTimer = TimerTimer
    Left = 464
    Top = 448
  end
  object PopupMenu: TPopupMenu
    Left = 408
    Top = 448
    object Edit1: TMenuItem
      Caption = '&Edit File'
      Default = True
      OnClick = Edit1Click
    end
    object Refresh1: TMenuItem
      Caption = '&Refresh'
      OnClick = Refresh1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Quit1: TMenuItem
      Caption = '&Quit'
      OnClick = Quit1Click
    end
  end
  object ActionList1: TActionList
    Left = 328
    Top = 448
    object Action1: TAction
      Category = 'Shortcuts'
      Caption = 'Refresh'
      ShortCut = 116
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Category = 'Shortcuts'
      Caption = 'Action2'
      ShortCut = 115
      OnExecute = Button3Click
    end
  end
end
