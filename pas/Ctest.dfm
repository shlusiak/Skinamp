object cursortest: Tcursortest
  Left = 586
  Top = 563
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Click to close'
  ClientHeight = 188
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnShow = FormShow
  PixelsPerInch = 115
  TextHeight = 16
  object PaintBox: TPaintBox
    Left = 10
    Top = 10
    Width = 338
    Height = 143
    OnMouseDown = FormMouseDown
    OnPaint = PaintBoxPaint
  end
  object Button1: TButton
    Left = 256
    Top = 158
    Width = 92
    Height = 30
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
    OnKeyDown = Button1KeyDown
  end
end
