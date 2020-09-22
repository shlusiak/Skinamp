unit searchcolor;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,skinampc,language;

type
  Tgetcolor = class(TForm)
    StaticText1: TStaticText;
    Shape: TShape;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ShapeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure StaticText1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
    pressed:boolean;
    b:tbitmap;
  public
    { Public-Deklarationen }
  end;

function getcolor(default:tcolorref):colorref;

implementation

uses sascha,bmps, main,funktionen;

{$R *.DFM}

function getcolor;
var
dlg:tgetcolor;
begin
  dlg:=tgetcolor.create(pagesdlg);
  if dlg.showmodal=mrok then result:=dlg.shape.brush.color else result:=default;
  dlg.free;
end;


procedure Tgetcolor.FormCreate(Sender: TObject);
begin
  pressed:=false;
  caption:=loadstring(1350);
  statictext1.caption:=loadstring(1351);
  button1.caption:=loadstring(902);
  button2.caption:=loadstring(903);
  button3.caption:=loadstring(1300);
  setids(self);
end;

procedure Tgetcolor.ShapeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
c:tcanvas;
dc:hdc;
r:trect;
begin
  if button=mbright then
  begin
    pagesdlg.colordialog.color:=shape.Brush.color;
    if pagesdlg.colordialog.execute then 
    shape.brush.color:=pagesdlg.colordialog.color;
    exit;
  end;
  if button<>mbleft then exit;
  if pressed then exit;
  setcapture(handle);
  pressed:=true;
  c:=tcanvas.Create;
  b:=tbitmap.create;
  b.width:=getsystemmetrics(sm_cxscreen);
  b.height:=Getsystemmetrics(sm_cyscreen);
  dc:=getdc(getdesktopwindow);
  c.handle:=dc;
  r.left:=0;
  r.top:=0;
  r.right:=getsystemmetrics(sm_cxscreen);
  r.bottom:=getsystemmetrics(sm_cyscreen);
  b.canvas.CopyRect(r,c,r);

  releasedc(getdesktopwindow,dc);
  c.free;
  screen.cursor:=crhandpoint;
end;

procedure Tgetcolor.ShapeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if pressed=False then exit;
  pressed:=false;
  releasecapture();
  b.free;
  screen.cursor:=crdefault;
end;

procedure Tgetcolor.ShapeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
p:tpoint;
begin
  if pressed then
  begin
    p:=shape.clienttoscreen(point(x,y));
    shape.brush.color:=getpixel(b.canvas.handle,p.x,p.y);
  end;
end;

procedure Tgetcolor.Button3Click(Sender: TObject);
begin
  shape.brush.color:=getrandomcolor;
end;

procedure Tgetcolor.StaticText1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
