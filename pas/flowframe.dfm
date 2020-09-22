object FlowFrm: TFlowFrm
  Left = 0
  Top = 0
  Width = 305
  Height = 89
  HelpContext = 400
  TabOrder = 0
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 71
    Height = 13
    Caption = 'Anzahl &Farben:'
    FocusControl = numbers
  end
  object Beispiel: TPaintBox
    Left = 240
    Top = 8
    Width = 65
    Height = 81
    OnPaint = BeispielPaint
  end
  object c1: TColorField
    Left = 128
    Top = 8
    Width = 33
    Height = 17
    Brush.Color = clRed
    Pen.Style = psClear
    Color = clRed
    OnLeftClick = c1LeftClick
    OnRightClick = c1RightClick
    OnRedraw = c1Redraw
  end
  object c2: TColorField
    Left = 128
    Top = 24
    Width = 33
    Height = 17
    Brush.Color = clYellow
    Pen.Style = psClear
    Color = clYellow
    OnLeftClick = c1LeftClick
    OnRightClick = c1RightClick
    OnRedraw = c1Redraw
  end
  object c3: TColorField
    Left = 128
    Top = 40
    Width = 33
    Height = 17
    Brush.Color = clLime
    Pen.Style = psClear
    Color = clLime
    OnLeftClick = c1LeftClick
    OnRightClick = c1RightClick
    OnRedraw = c1Redraw
  end
  object c4: TColorField
    Left = 128
    Top = 56
    Width = 33
    Height = 17
    Brush.Color = clAqua
    Pen.Style = psClear
    Visible = False
    Color = clAqua
    OnLeftClick = c1LeftClick
    OnRightClick = c1RightClick
    OnRedraw = c1Redraw
  end
  object c5: TColorField
    Left = 128
    Top = 72
    Width = 33
    Height = 17
    Brush.Color = clBlue
    Pen.Style = psClear
    Visible = False
    Color = clBlue
    OnLeftClick = c1LeftClick
    OnRightClick = c1RightClick
    OnRedraw = c1Redraw
  end
  object numbers: TComboBox
    Left = 8
    Top = 24
    Width = 105
    Height = 21
    HelpContext = 400
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = numbersChange
    OnContextPopup = numbersContextPopup
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
  end
  object text1: TStaticText
    Left = 168
    Top = 8
    Width = 30
    Height = 17
    Caption = 'Oben'
    TabOrder = 1
  end
  object text2: TStaticText
    Left = 168
    Top = 40
    Width = 33
    Height = 17
    Caption = 'Unten'
    TabOrder = 2
  end
end
