unit ctest;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,wmain, StdCtrls,language;

type
  Tcursortest = class(TForm)
    PaintBox: TPaintBox;
    Button1: TButton;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  cursortest: Tcursortest;

implementation

uses main;

{$R *.DFM}

procedure Tcursortest.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  close;
end;

procedure Tcursortest.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  close;
end;

procedure Tcursortest.FormShow(Sender: TObject);
begin
  left:=(screen.width-width)div 2;
  top:=(screen.height-height)div 2;
  mouse.cursorpos:=point(left+width div 2,top+height div 2);
end;

procedure Tcursortest.PaintBoxPaint(Sender: TObject);
var
b:tbitmap;
begin
  b:=tbitmap.create;
  wmain.getmainbitmap(b,true);
  paintbox.canvas.draw(0,0,b);
  b.free;
end;

procedure Tcursortest.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tcursortest.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  close;
end;

procedure Tcursortest.FormCreate(Sender: TObject);
begin
  button1.caption:=loadstring(901);
end;

end.
