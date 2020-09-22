unit info;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, OleServer,mapi, ExtCtrls, ImgList,funktionen,skinampc;

type
  Tinfodialog = class(TForm)
    NowButton: TButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    laterButton: TButton;
    NeverButton: TButton;
    EMail: TStaticText;
    Image1: TImage;
    homepage: TStaticText;
    Image2: TImage;
    winamp: TStaticText;
    procedure schlechtmoved(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure laterButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NowButtonClick(Sender: TObject);
    procedure homepageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure homepageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure laterButtonEnter(Sender: TObject);
    procedure winampMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Image2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure StaticText1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StaticText1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private-Deklarationen }
    inmove:boolean;
    b1,b2,b3:integer;

    procedure clearall;
  public
    { Public-Deklarationen }
  end;

implementation

uses language,wininet,shellapi,sascha;

{$R *.DFM}

function highlight:tcolorref;
begin
  result:=rgb(255,0,0);
end;

procedure Tinfodialog.schlechtmoved(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
x1,y1,x2,y2:integer;
i:integer;
faktor:integer;
cpos:tpoint;

const
vertikal=5;
horizontal=8;
label nochmal;
begin
  clearall;
  if inmove then exit;
  nochmal:
  inmove:=true;
  { Vertauscht Gut, und Schlecht }
  x1:=nowbutton.left;
  y1:=nowbutton.top;
  x2:=tbutton(sender).left;
  y2:=tbutton(sender).top;
  if x1<x2 then faktor:=1 else faktor:=-1;
  for i:=1 to ((x2-x1)*faktor)div 16 do    { Hoch }
  begin
    nowbutton.left:=nowbutton.left+(faktor*horizontal);
    nowbutton.top:=nowbutton.top+(faktor*vertikal);
    tbutton(sender).left:=tbutton(sender).left-(faktor*horizontal);
    tbutton(sender).top:=tbutton(sender).top-(faktor*vertikal);
    delay(17);
  end;
  for i:=1 to ((x2-x1)*faktor)div 16 do      { Runter }
  begin
    nowbutton.left:=nowbutton.left+(faktor*horizontal);
    nowbutton.top:=nowbutton.top-(faktor*vertikal);
    tbutton(sender).left:=tbutton(sender).left-(faktor*horizontal);
    tbutton(sender).top:=tbutton(sender).top+(faktor*vertikal);
    delay(17);
  end;
  nowbutton.left:=x2;
  nowbutton.top:=y2;
  tbutton(sender).left:=x1;
  tbutton(sender).top:=y1;
  inmove:=False;
  cpos:=screentoclient(mouse.cursorpos);
  if ((cpos.x>laterbutton.left)and(cpos.y>laterbutton.top)and
     (cpos.x<laterbutton.left+laterbutton.width)and(cpos.y<laterbutton.top+laterbutton.height)) or
     ((cpos.x>neverbutton.left)and(cpos.y>neverbutton.top)and
     (cpos.x<neverbutton.left+neverbutton.width)and(cpos.y<neverbutton.top+neverbutton.height))then
  begin
    postmessage(handle,wm_mousemove,cpos.x,cpos.y);
  end;
end;

procedure Tinfodialog.FormCreate(Sender: TObject);
begin
  inmove:=False;
  b1:=nowbutton.left;
  b2:=laterbutton.left;
  b3:=neverbutton.left;

  statictext2.caption:=loadstring(1001);
  if (length(statictext2.caption)>0)and(statictext2.caption[length(statictext2.caption)]<>' ') then statictext2.caption:=statictext2.caption+' ';
  statictext2.caption:=statictext2.caption+loadstringid(7);
  statictext3.caption:=loadstring(1002);
  email.caption:=loadstring(1003)+loadstringid(8);
  homepage.caption:=loadstring(11);
  winamp.caption:=loadstringid(10);
  nowbutton.caption:=loadstring(1004);
  laterbutton.caption:=loadstring(1005);
  neverbutton.caption:=loadstring(1006);
  caption:=loadstring(1000);
  image1.Picture.Icon.Handle:=loadicon(hinstance,'mainicon');
  image2.picture.bitmap.loadfromresourceid(dllinstance,130);
end;

procedure Tinfodialog.laterButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  nowbutton.setfocus;
end;

procedure Tinfodialog.NowButtonClick(Sender: TObject);
begin
  close;
end;

procedure Tinfodialog.homepageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if button=mbleft then 
  begin
    (sender as tstatictext).left:=(sender as tstatictext).left+1;
    (sender as tstatictext).top:=(sender as tstatictext).top+1;
    (sender as tstatictext).tag:=(sender as tstatictext).tag+10;
  end;
end;

procedure Tinfodialog.homepageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if button=mbleft then
  begin
    if (sender as tstatictext).tag div 10=1 then
    begin
      (sender as tstatictext).left:=(sender as tstatictext).left-1;
      (sender as tstatictext).top:=(sender as tstatictext).top-1;
      clearall;
      case (sender as tstatictext).tag mod 10 of
        1:shellexecute(handle,'open',pchar(loadstringid(9)),nil,nil,sw_show);
        2:shellexecute(handle,'open',pchar(loadstring(11)),nil,nil,sw_show);
        3:shellexecute(handle,'open',pchar(loadstringid(10)),nil,nil,sw_show);
      end;
    end;
    (sender as tstatictext).tag:=(sender as tstatictext).tag mod 10;
  end;
end;

procedure Tinfodialog.laterButtonEnter(Sender: TObject);
begin
  nowbutton.setfocus;
end;

procedure tinfodialog.clearall;
begin
  email.font.color:=clwindowtext;
  homepage.font.color:=clwindowtext;
  winamp.font.color:=clwindowtext;
end;

procedure Tinfodialog.winampMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
t:tstatictext;
begin
  t:=sender as tstatictext;
  if not (ssleft in shift) then
  begin
    if t<>email then email.font.color:=clwindowtext;
    if t<>homepage then homepage.font.color:=clwindowtext;
    if t<>winamp then winamp.font.color:=clwindowtext;
    if sender is tstatictext then t.Font.color:=highlight;
  end else if sender is tstatictext then 
  begin
    if (x>0)and(x<t.width)and(y>0)and(y<t.height)then
    begin
      if t.tag div 10=2 then begin
        t.font.color:=highlight;
        t.left:=t.left+1;
        t.top:=t.top+1;
        t.tag:=t.tag mod 10+10;
      end;
    end else
    begin
      if t.tag div 10=1 then begin
        t.left:=t.left-1;
        t.top:=t.top-1;
        t.font.color:=clwindowtext;
        t.tag:=t.tag mod 10+20;
      end;
    end;
  end;
end;

procedure Tinfodialog.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  clearall;
end;

procedure Tinfodialog.Image2DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if sender=image1 then accept:=true;
end;

procedure Tinfodialog.Image2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
symbol1,symbol2:pcheatobject;

procedure initialisiere;
function getxspeed:integer;
begin
  result:=random(6)+5;
end;
function getyspeed:integer;
begin
  result:=random(8)-2;
end;
var
bmp:tbitmap;
begin
  bmp:=tbitmap.create;
  bmp.width:=image1.width;
  bmp.height:=image1.height;
  bmp.canvas.draw(0,0,image1.picture.graphic);
  symbol1:=createcheatobject(clienttoscreen(point(Image1.Left,image1.top)),point(image1.width,image1.height),point(-getxspeed,getyspeed),
    bmp.canvas.handle);
  bmp.canvas.draw(0,0,image2.picture.graphic);
  symbol2:=createcheatobject(clienttoscreen(point(Image2.Left,image2.top)),point(image2.width,image2.height),point(getxspeed,getyspeed),
    bmp.canvas.handle);
  bmp.free;
  addothercheatobject(symbol1,symbol2);
  addothercheatobject(symbol2,symbol1);
end;
var
halb:tcolorref;
begin
  initialisiere;
  halb:=rgb(
    round(getrvalue(colortorgb(color)) / 1.5),
    round(getgvalue(colortorgb(color)) / 1.5),
    round(getbvalue(colortorgb(color)) / 1.5));
  runinfocheat(symbol1,symbol2,halb);
end;

procedure Tinfodialog.FormShow(Sender: TObject);
begin
  nowbutton.left:=b1;
  laterbutton.left:=b2;
  neverbutton.left:=b3;
end;

procedure Tinfodialog.StaticText1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
p:tpoint;
begin          
  screen.cursor:=crdefault;
  p:=(sender as tstatictext).clienttoscreen(point(x,y));
  if iswinamp(p) then infomoveit(p);
end;

procedure Tinfodialog.StaticText1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssleft in shift then
  begin
    if iswinamp((sender as tstatictext).clienttoscreen(point(x,y)))then
      screen.cursor:=crhandpoint
    else screen.cursor:=crdefault;
  end else clearall;
end;

end.
