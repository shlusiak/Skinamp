object cursoreditor: Tcursoreditor
  Left = 374
  Top = 175
  HelpContext = 1107
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Cursor editor'
  ClientHeight = 413
  ClientWidth = 570
  Color = clBtnFace
  UseDockManager = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox: TPaintBox
    Left = 136
    Top = 8
    Width = 89
    Height = 81
    OnMouseDown = PaintBoxMouseDown
    OnMouseMove = PaintBoxMouseMove
    OnMouseUp = PaintBoxMouseUp
    OnPaint = PaintBoxPaint
  end
  object Button1: TButton
    Left = 492
    Top = 385
    Width = 73
    Height = 25
    HelpContext = 10
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnContextPopup = ListContextPopup
  end
  object Panel: TPanel
    Left = 415
    Top = 0
    Width = 150
    Height = 354
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 2
    object farben: TPanel
      Left = 8
      Top = 200
      Width = 89
      Height = 129
      HelpContext = 1104
      Caption = 'farben'
      TabOrder = 0
      object shapel: TShape
        Left = 8
        Top = 8
        Width = 16
        Height = 16
        Brush.Color = clBlack
      end
      object Shaper: TShape
        Left = 26
        Top = 8
        Width = 16
        Height = 16
      end
      object Panel2: TPanel
        Left = 8
        Top = 32
        Width = 70
        Height = 94
        BevelOuter = bvNone
        TabOrder = 0
        OnDblClick = Panel2DblClick
        object Shape1: TShapeDblClick
          Left = 0
          Top = 27
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape2: TShapeDblClick
          Left = 18
          Top = 27
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape3: TShapeDblClick
          Left = 36
          Top = 27
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape4: TShapeDblClick
          Left = 54
          Top = 27
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape5: TShapeDblClick
          Left = 0
          Top = 44
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape6: TShapeDblClick
          Left = 18
          Top = 44
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape7: TShapeDblClick
          Left = 36
          Top = 44
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape8: TShapeDblClick
          Left = 54
          Top = 44
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape9: TShapeDblClick
          Left = 0
          Top = 61
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape10: TShapeDblClick
          Left = 18
          Top = 61
          Width = 17
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape11: TShapeDblClick
          Left = 36
          Top = 61
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape12: TShapeDblClick
          Left = 54
          Top = 61
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape13: TShapeDblClick
          Left = 0
          Top = 78
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape14: TShapeDblClick
          Left = 18
          Top = 78
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape15: TShapeDblClick
          Left = 36
          Top = 78
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape16: TShapeDblClick
          Left = 54
          Top = 78
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
          OnDblClick = Shape1DblClick
        end
        object Shape17: TShape
          Left = 0
          Top = 10
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
        end
        object Shape18: TShape
          Left = 18
          Top = 10
          Width = 16
          Height = 16
          OnMouseDown = Shape1MouseDown
        end
      end
    end
    object tools: TPanel
      Left = 8
      Top = 29
      Width = 89
      Height = 92
      HelpContext = 1106
      TabOrder = 1
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 87
        Height = 90
        HelpContext = 1106
        Align = alClient
        ButtonHeight = 26
        ButtonWidth = 29
        Caption = 'ToolBar1'
        Color = clBtnFace
        EdgeBorders = []
        Images = ToolButtonList
        ParentColor = False
        TabOrder = 0
        TabStop = True
        Transparent = True
        OnClick = ToolBar1Click
        object ToolButton1: TToolButton
          Left = 0
          Top = 2
          Caption = 'ToolButton1'
          Grouped = True
          ImageIndex = 0
          ParentShowHint = False
          ShowHint = True
          Style = tbsCheck
          OnClick = ToolBar1Click
        end
        object ToolButton2: TToolButton
          Left = 29
          Top = 2
          Caption = 'ToolButton2'
          Grouped = True
          ImageIndex = 1
          Style = tbsCheck
          OnClick = ToolBar1Click
        end
        object ToolButton3: TToolButton
          Left = 58
          Top = 2
          Caption = 'ToolButton3'
          Grouped = True
          ImageIndex = 2
          Wrap = True
          Style = tbsCheck
          OnClick = ToolBar1Click
        end
        object ToolButton4: TToolButton
          Left = 0
          Top = 28
          Caption = 'ToolButton4'
          Down = True
          Grouped = True
          ImageIndex = 3
          Style = tbsCheck
          OnClick = ToolBar1Click
        end
        object ToolButton5: TToolButton
          Left = 29
          Top = 28
          Caption = 'ToolButton5'
          Grouped = True
          ImageIndex = 4
          Style = tbsCheck
          OnClick = ToolBar1Click
        end
        object ToolButton6: TToolButton
          Left = 58
          Top = 28
          Caption = 'ToolButton6'
          Grouped = True
          ImageIndex = 5
          Wrap = True
          Style = tbsCheck
          OnClick = ToolBar1Click
        end
        object ToolButton9: TToolButton
          Left = 0
          Top = 54
          Caption = 'ToolButton9'
          Grouped = True
          ImageIndex = 6
          Style = tbsCheck
          OnClick = ToolBar1Click
        end
        object ToolButton7: TToolButton
          Left = 29
          Top = 54
          Caption = 'ToolButton7'
          Grouped = True
          ImageIndex = 7
          Style = tbsCheck
          OnClick = ToolBar1Click
        end
        object ToolButton8: TToolButton
          Left = 58
          Top = 54
          Caption = 'ToolButton8'
          Grouped = True
          ImageIndex = 8
          Style = tbsCheck
          OnClick = ToolBar1Click
        end
      end
    end
    object Panel1: TPanel
      Left = 8
      Top = 128
      Width = 89
      Height = 65
      HelpContext = 1105
      TabOrder = 2
      OnContextPopup = ListContextPopup
      object SpeedButton1: TSpeedButton
        Left = 56
        Top = 24
        Width = 23
        Height = 25
        AllowAllUp = True
        GroupIndex = 1
        OnClick = SpeedButton1Click
      end
      object StaticText1: TStaticText
        Left = 8
        Top = 24
        Width = 44
        Height = 17
        Caption = 'Hotspot:'
        TabOrder = 0
      end
      object StaticText2: TStaticText
        Left = 8
        Top = 40
        Width = 25
        Height = 17
        Caption = '(0,0)'
        TabOrder = 1
      end
      object StaticText3: TStaticText
        Left = 8
        Top = 8
        Width = 25
        Height = 17
        Caption = '(0,0)'
        TabOrder = 2
      end
    end
    object StaticText4: TStaticText
      Left = 8
      Top = 8
      Width = 23
      Height = 21
      HelpContext = 1106
      Caption = '(-:)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnContextPopup = ListContextPopup
    end
  end
  object Button2: TButton
    Left = 492
    Top = 357
    Width = 73
    Height = 25
    HelpContext = 1103
    Anchors = [akRight, akBottom]
    Caption = 'Test'
    TabOrder = 0
    OnClick = Button2Click
    OnContextPopup = ListContextPopup
  end
  object Button3: TButton
    Left = 415
    Top = 357
    Width = 73
    Height = 25
    HelpContext = 1102
    Anchors = [akRight, akBottom]
    Caption = 'Import'
    TabOrder = 4
    OnClick = Button3Click
    OnContextPopup = ListContextPopup
  end
  object Button4: TButton
    Left = 415
    Top = 385
    Width = 73
    Height = 25
    HelpContext = 1101
    Anchors = [akRight, akBottom]
    Caption = 'Save'
    TabOrder = 5
    OnClick = Button4Click
    OnContextPopup = ListContextPopup
  end
  object List: TListView
    Left = 8
    Top = 8
    Width = 121
    Height = 401
    HelpContext = 1100
    Anchors = [akLeft, akTop, akBottom]
    Columns = <
      item
        AutoSize = True
      end>
    ColumnClick = False
    DragCursor = 8
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -7
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    ShowColumnHeaders = False
    TabOrder = 3
    ViewStyle = vsReport
    OnContextPopup = ListContextPopup
    OnDragDrop = ListDragDrop
    OnDragOver = ListDragOver
    OnSelectItem = ListSelectItem
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'cur'
    Filter = 
      'Supported files (*.cur;*.ico)|*.cur;*.ico|Cursor files (*.cur)|*' +
      '.cur|Icon files (*.ico)|*.ico|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Import cursor from file'
    Left = 192
    Top = 120
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'cur'
    Filter = 'Cursor files (*.cur)|*.cur|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Export cursor to file'
    Left = 192
    Top = 168
  end
  object ToolButtonList: TImageList
    Height = 20
    Width = 20
    Left = 280
    Top = 168
  end
end
