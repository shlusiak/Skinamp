unit cureditor;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,sascha, ExtCtrls, ToolWin, ComCtrls, ImgList,math, Buttons,skinampc,shellapi,
  funktionen,language, ColorField, ShapeDblClick;

type
  Tcursoreditor = class(TForm)
    PaintBox: TPaintBox;
    Button1: TButton;
    Panel: TPanel;
    farben: TPanel;
    Panel2: TPanel;
    Shape1: TShapeDblClick;
    Shape2: TShapeDblClick;
    Shape3: TShapeDblClick;
    Shape4: TShapeDblClick;
    Shape5: TShapeDblClick;
    Shape6: TShapeDblClick;
    Shape7: TShapeDblClick;
    Shape8: TShapeDblClick;
    Shape9: TShapeDblClick;
    Shape10: TShapeDblClick;
    Shape11: TShapeDblClick;
    Shape12: TShapeDblClick;
    Shape13: TShapeDblClick;
    Shape14: TShapeDblClick;
    Shape15: TShapeDblClick;
    Shape16: TShapeDblClick;
    Shape17: TShape;
    Shape18: TShape;
    shapel: TShape;
    Shaper: TShape;
    tools: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    Button2: TButton;
    Panel1: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    SpeedButton1: TSpeedButton;
    StaticText3: TStaticText;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    ToolButton8: TToolButton;
    Button3: TButton;
    Button4: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    List: TListView;
    StaticText4: TStaticText;
    ToolButtonList: TImageList;
    ToolButton9: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolBar1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Panel2DblClick(Sender: TObject);
    procedure Shape1DblClick(Sender: TObject);
    procedure ListContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
    zoom:integer;
    aktcol1,aktcol2:byte;
    band:record
      t:byte;
      mode:byte;
      x1,y1,x2,y2:integer;
      moving:boolean;
      inhalt:array[0..31,0..31]of byte;
      hasinhalt:boolean;
      mx,my:byte;
    end;
    enterhotspot:boolean;
    mousedown:boolean;
    faktcur:byte;

    procedure setzoom(z:integer);
    function shape(color:integer):tshape;
    procedure setpixel(x,y,f:integer);
    procedure line(x1,y1,x2,y2,farbe:integer);
    procedure klecks(mx,my,f:integer);
    procedure aktualisiere;
    procedure updatecursor;
    procedure edited;
    function aktcur:pcursorfile;
    procedure unselect;
    procedure wmdropfiles(var msg:tmessage); message wm_dropfiles;
    procedure setcolors;
  public
    { Public-Deklarationen }
    cursors:array[1..27]of pcursorfile;
  end;

pcursors=^tcursors;
tcursors=object
private
  loaded:boolean;
  list:tstringlist;
  procedure load(multithread:boolean);
public
  cursors:array[1..27]of pcursorfile;
  ce:tcursoreditor;
  constructor init;
  destructor done;
  procedure showmodal;
  procedure save(path:pchar);
end;

implementation

uses ctest, saveform, main, syncobjs;

{$R *.DFM}


const
cursornames:array[1..27]of string=
('Close','EqClose','EqNormal','EqSlid','EqTitle','Mainmenu',
'Min','Normal','PClose','PNormal','Posbar','PSize','PTBar',
'Pvscroll','PWinbut','Pwsnorm','Pwssize','Songname','Titlebar',
'Volbal','Volbar','Winbut','WsClose','WsMin','WsNormal',
'WsPosbar','WsWinbut');
cur_first='Skinamp_FirstCursor';
cur_last='Skinamp_LastCursor';


type
tloadcursor=class(tthread)
  handles:array[1..8]of thandle;
  aktcur:tcursorfile;
  firstcursorloaded,lastcursorloaded:tevent;
  cursors:pcursors;
  constructor mycreate;
  destructor destroy; override;
  procedure execute; override;
  procedure addcur;
end;



procedure import(h:hcursor;c:pcursorfile;dc:hdc); forward;


constructor tcursors.init;
begin
  loaded:=false;
  list:=tstringlist.create;
  ce:=nil;
end;

destructor tcursors.done;
var
i:integer;
begin
  if loaded then for i:=1 to 27 do cursors[i].done;
  list.free;
end;

procedure tcursors.showmodal;
var
i:integer;
li:tlistitem;
begin
  ce:=tcursoreditor.Create(pagesdlg);
  ce.list.items.clear;
  for i:=0 to list.count-1 do
  begin
    li:=ce.list.items.add;
    li.caption:=list.Strings[i];
    ce.cursors[i+1]:=cursors[i+1];
  end;
  if (list.count>0)then ce.list.selected:=ce.list.items.item[0];
  if not loaded then load(true);
  ce.showmodal;
  ce.free;
  ce:=nil;
end;

procedure tcursors.load;
var
i:integer;
t:tloadcursor;
cursorloaded:tevent;
handles:array[1..8]of hcursor;
begin
  if loaded then exit;
  // Liste füttern
  list.clear;

  cursorloaded:=tevent.create(nil,false,false,cur_first);
  t:=tloadcursor.mycreate;
  for i:=1 to 8 do handles[i]:=loadcursor(dllinstance,pchar(100+i));
  for i:=1 to 8 do t.handles[i]:=handles[i];
  t.cursors:=@self;
  t.resume;
  while cursorloaded.waitfor(10)=wrtimeout do warte;
  cursorloaded.free;
  
  if multithread=false then
  begin
    cursorloaded:=tevent.create(nil,false,false,cur_last);
    while cursorloaded.waitfor(10)=wrtimeout do warte;
    cursorloaded.free;
  end;
  loaded:=true;
end;

procedure tcursors.save;
var
i:integer;
begin
  if not loaded then load(false);
  pagesdlg.StepIt;
  for i:=1 to 27 do
  begin
    cursors[i].savetofile(path+cursornames[i]+'.cur');
    warte;
  end;
end;




var
ce:tcursoreditor;

procedure setp(x,y,f,p1,p2:integer); cdecl;
begin
  ce.setpixel(x,y,f);
end;



constructor tloadcursor.mycreate;
var
i:integer;
begin
  inherited create(true);
  freeonterminate:=true;
  for i:=1 to 8 do handles[i]:=0;
  firstcursorloaded:=tevent.create(nil,false,false,cur_first);
  lastcursorloaded:=tevent.create(nil,false,false,cur_last);
end;

destructor tloadcursor.destroy;
begin
  firstcursorloaded.free;
  lastcursorloaded.free;
  inherited destroy;
end;

procedure tloadcursor.execute;
var
i,j,k:integer;
myc:array[1..8]of tcursorfile;
b:tbitmap;
dc:hdc;
begin
  aktcur.init;
  b:=tbitmap.create;
  b.width:=32;
  b.height:=32;
  dc:=createcompatibledc(0);
  selectobject(dc,b.handle);
  for i:=1 to 8 do if terminated=false then
  begin
    myc[i].init;
    import(handles[i],@myc[i],dc);
    if i=1 then
    begin
      aktcur.data:=myc[i].data;
      synchronize(addcur);
    end;
  end;
  b.free;
  deletedc(dc);

  for j:=2 to 27 do if terminated=false then
  begin         // 27 Cursor auf die 8 geladenen setzen
    case j of
      1,2,9,23:k:=1;                 // Schliessen
      3,6,8,10,15,16,22,25,27:k:=2;  // Normal
      4,14:k:=3;                     // Up/Down
      5,13,19:k:=4;                  // Size
      7,24:k:=5;                     // Min
      11,17,18,20,21,26:k:=6;        // Left/Right
      12:k:=7;                       // Expand (PL)

      else k:=1;
    end;
    aktcur.data:=myc[k].data;
    synchronize(addcur);
  end;
  aktcur.done;
  for i:=1 to 8 do myc[i].done;
  lastcursorloaded.setevent;
end;

procedure tloadcursor.addcur;
var
i:integer;
li:tlistitem;
begin
  i:=cursors.list.count+1;
  cursors.cursors[i]:=new(pcursorfile,init);
  cursors.cursors[i].data:=aktcur.data;
  cursors.list.add(cursornames[i]);

  if cursors.ce<>nil then
  begin
    li:=cursors.ce.list.items.add;
    li.caption:=cursornames[i];
    ce.cursors[i]:=cursors.cursors[i];
    if i=1 then ce.List.selected:=li;
  end;

  if i=1 then firstcursorloaded.setevent;
end;


function tcursoreditor.aktcur;
begin
  result:=cursors[faktcur+1];
end;

procedure import;
var
ii:iconinfo;
j,k,l:integer;
m:tcolorref;
b:hbrush;
begin
  b:=createsolidbrush(rgb($40,0,$40));
  selectobject(dc,getstockobject(null_pen));
  selectobject(dc,b);
  rectangle(dc,0,0,33,33);
  selectobject(dc,getstockobject(null_brush));
  deleteobject(b);

  drawiconex(dc,0,0,h,32,32,0,0,di_normal);
  for j:=0 to 31 do for k:=0 to 31 do
  begin
    m:=getpixel(dc,j,k);
    if curispalettecolor(m,$400040) then
    begin
      c.setcolor(j,k,0);
      c.setmask(j,k,true);
    end else
    if curispalettecolor(m,$bfffbf) then
    begin
      c.setcolor(j,k,15);
      c.setmask(j,k,true);
    end else 
    for l:=0 to 15 do if curispalettecolor(m,c.getrgbpalette(l))then
    begin
      c.setcolor(j,k,l);
      c.setmask(j,k,false);
      break;
    end;
  end;
  geticoninfo(h,ii);
  c.data.hx:=ii.xHotspot;
  c.data.hy:=ii.yHotspot;
end;

procedure Tcursoreditor.FormCreate(Sender: TObject);
var
i:integer;
b:tbitmap;
begin
  caption:=loadstring(1500);
  statictext1.caption:=loadstring(1501);
  button1.caption:=loadstring(901);
  button2.caption:=loadstring(551);
  button3.caption:=loadstring(905);
  button4.caption:=loadstring(550);

  faktcur:=0;
  aktcol1:=15;
  aktcol2:=16;

  ce:=self;
  mousedown:=false;
  setzoom(9);
  doublebuffered:=true;
  band.t:=0;
  band.moving:=false;
  band.hasinhalt:=false;

  // Benutzerdefinierte Cursor laden
  begin
    screen.cursors[6]:=loadcursor(dllinstance,makeintresource(201));
    screen.cursors[7]:=loadcursor(dllinstance,makeintresource(202));
    screen.cursors[8]:=loadcursor(dllinstance,makeintresource(203));
    screen.cursors[9]:=loadcursor(dllinstance,makeintresource(204));
    screen.cursors[10]:=loadcursor(dllinstance,makeintresource(205));
  end;
  dragacceptfiles(handle,true);

  speedbutton1.Glyph.LoadFromResourceID(dllinstance,120);
  toolbuttonlist.Clear;
  b:=tbitmap.create;

  for i:=101 to 109 do
  begin
    b.LoadFromResourceID(dllinstance,i);
    toolbuttonlist.addmasked(b,cldefault);
  end;

  setids(self);

  b.free;
end;

procedure tcursoreditor.setzoom;
begin
  zoom:=z;
  paintbox.width:=z*32;
  paintbox.height:=z*32;
  width:=paintbox.left+paintbox.width+15+panel.width;
  if zoom>12 then
  begin
    clientheight:=paintbox.top+paintbox.height+paintbox.top;
  end else clientheight:=396;
  paintbox.invalidate;
end;

procedure Tcursoreditor.PaintBoxPaint(Sender: TObject);
var
i,j,k,l,m,n:integer;
procedure drawpunkt(x,y,farbe,p1,p2:integer); cdecl;
begin
  rectangle(p1,x*p2,y*p2,x*p2+p2,y*p2+p2);
end;
var
x1,y1,x2,y2:integer;
br,obr,pn,opn,dc:thandle;
begin
  with paintbox.canvas do
  begin
    pen.mode:=pmcopy;
    pen.style:=psclear;
    brush.style:=bssolid;
    pn:=0;
    opn:=0;
    dc:=paintbox.canvas.handle;
    with aktcur^ do
    for i:=0 to 31 do for j:=0 to 31 do
    begin
      if getmask(i,j)=false then k:=getrgbcolor(i,j) else
      begin
        if getcolor(i,j)=0 then k:=shape(16).brush.color else
          k:=shape(17).brush.color;
      end;
      if zoom>1 then
      begin
//        brush.color:=k;
//        pen.color:=k;
        br:=createsolidbrush(k);
        if zoom<=4 then
        begin
          pn:=createpen(ps_solid,1,k);
          opn:=selectobject(dc,pn);
        end else selectobject(dc,getstockobject(NULL_PEN));
        obr:=selectobject(dc,br);
        windows.rectangle(dc,i*zoom,j*zoom,i*zoom+zoom,j*zoom+zoom);
        selectobject(dc,obr);
        if zoom<=4 then
        begin
          selectobject(dc,opn);
          deleteobject(pn);
        end;
        deleteobject(br);
      end
      else windows.setpixel(dc,i,j,k);
    end;
    if (band.hasinhalt) then
    begin
      for i:=0 to (band.x2-band.x1) do for j:=0 to (band.y2-band.y1) do
      begin
        k:=shape(band.inhalt[i,j]).brush.color;
        if zoom>1 then
        begin
//        brush.color:=k;
//        pen.color:=k;
          br:=createsolidbrush(k);
          if zoom<=4 then
          begin
            pn:=createpen(ps_solid,1,k);
            opn:=selectobject(dc,pn);
          end else opn:=selectobject(dc,getstockobject(NULL_PEN));
          obr:=selectobject(dc,br);
          windows.rectangle(dc,(i+band.x1)*zoom,(j+band.y1)*zoom,(i+band.x1)*zoom+zoom,(j+band.y1)*zoom+zoom);
          selectobject(dc,obr);
          selectobject(dc,opn);
          if zoom<=4 then
          begin
            deleteobject(pn);
          end;
          deleteobject(br);
        end
        else windows.setpixel(dc,i+band.x1,j+band.y1,k);
      end;
    end;
    pen.color:=rgb(0,0,0);
    pen.style:=pssolid;
    brush.style:=bsclear;
    rectangle(0,0,paintbox.width,paintbox.height);
    pen.style:=psclear;
    pen.color:=rgb(0,0,0);
    case band.mode of
      0:begin
        brush.color:=rgb(0,0,255);
        pen.mode:=pmnot;
      end;
      1:brush.color:=shape(aktcol1).brush.color;
      2:brush.color:=shape(aktcol2).brush.color;
    end;
    case band.t of
      1:begin
        j:=band.x1;
        k:=band.x2;
        if k<j then change(k,j);
        for i:=j to k do rectangle(i*zoom,band.y1*zoom,i*zoom+zoom,band.y1*zoom+zoom);
        if (band.y1<>band.y2) then for i:=j to k do rectangle(i*zoom,band.y2*zoom,i*zoom+zoom,band.y2*zoom+zoom);

        j:=band.y1;
        k:=band.y2;
        if k<j then change(k,j);
        inc(j);
        dec(k);
        for i:=j to k do rectangle(band.x1*zoom,i*zoom,band.x1*zoom+zoom,i*zoom+zoom);
        if (band.y1<>band.y2)and(band.x1<>band.x2) then for i:=j to k do rectangle(band.x2*zoom,i*zoom,band.x2*zoom+zoom,i*zoom+zoom);
      end;
      2:begin
        j:=band.x1;
        k:=band.x2;
        if k<j then change(j,k);
        m:=band.y1;
        n:=band.y2;
        if n<m then change(m,n);
        for i:=j to k do for l:=m to n do rectangle(i*zoom,l*zoom,i*zoom+zoom,l*zoom+zoom);
      end;
      3:begin
        x1:=band.x1;
        x2:=band.x2;
        y1:=band.y1;
        y2:=band.y2;

        br:=createsolidbrush(brush.color);
        obr:=selectobject(dc,br);
        opn:=selectobject(dc,getstockobject(null_pen));
        curline(@drawpunkt,x1,y1,x2,y2,0,dc,zoom);
        selectobject(dc,opn);
        selectobject(dc,obr);
        deleteobject(br);
      end;
    end;
    canvas.brush.style:=bssolid;
  end;
end;

procedure Tcursoreditor.ListBoxClick(Sender: TObject);
begin
  aktualisiere;
end;

function tcursoreditor.shape;
begin
  case color of
    0:result:=shape1;
    1:result:=shape2;
    2:result:=shape3;
    3:result:=shape4;
    4:result:=shape5;
    5:result:=shape6;
    6:result:=shape7;
    7:result:=shape8;
    8:result:=shape9;
    9:result:=shape10;
    10:result:=shape11;
    11:result:=shape12;
    12:result:=shape13;
    13:result:=shape14;
    14:result:=shape15;
    15:result:=shape16;
    16:result:=shape17;
    17:result:=shape18;
    else result:=shape1;
  end;
end;

procedure Tcursoreditor.Shape1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  case button of
    mbleft:begin
      aktcol1:=(sender as tshape).tag;
      shapel.brush.color:=(sender as tshape).brush.color;
    end;
    mbright:begin
      aktcol2:=(sender as tshape).tag;
      shaper.brush.color:=(sender as tshape).brush.color;
    end;
  end;
end;

procedure Tcursoreditor.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

procedure cfloodfill(c:integer);
var
a:array[0..31,0..31]of byte;
i,j:integer;
begin
  for i:=0 to 31 do for j:=0 to 31 do
    if aktcur.getmask(i,j)=false then a[i,j]:=aktcur.getcolor(i,j) else
  begin
    if aktcur.getcolor(i,j)=0 then a[i,j]:=16 else a[i,j]:=17;
  end;
  curfloodfill(@a,@setp,x,y,c);
  paintbox.invalidate;
end;
var
i,j:integer;
begin
  j:=0;
  setcapturecontrol(paintbox);
  x:=x div zoom;
  y:=y div zoom;
  if enterhotspot then begin
    if button=mbleft then
    begin
      aktcur.data.hx:=x;
      aktcur.data.hy:=y;
      edited;
      aktualisiere;
      mousedown:=true;
    end;
    exit;
  end;
  for i:=0 to toolbar1.buttoncount-1 do if toolbar1.buttons[i].down then j:=i;
  case j of
    0:if button=mbleft then begin  { Umrahmen }
      if (band.t=1)and(x>=band.x1)and(x<=band.x2)and(y>=band.y1)and(y<=band.y2)then
      begin
        // In vorhandenen Rahmen geklickt -> Bewegen
        if (ssctrl in shift)and(band.hasinhalt) then begin
          for i:=band.x1 to band.x2 do for j:=band.y1 to band.y2 do
            setpixel(i,j,band.inhalt[i-band.x1,j-band.y1]);
        end;
        band.moving:=true;
        band.mx:=x-band.x1;
        band.my:=y-band.y1;
        mousedown:=true;
      end else begin
        unselect;
        band.t:=1;
        band.x1:=x;
        band.y1:=y;
        band.x2:=band.x1;
        band.y2:=band.y1;
        band.mode:=0;
        paintbox.invalidate;
        mousedown:=true;
      end;
    end else begin
      unselect;
      paintbox.invalidate;
    end;
    1: if button=mbleft then       { Hole Farbe aus Cursor }
    begin
      aktcol1:=aktcur.getcolor(x,y);
      if aktcur.getmask(x,y)=false then shapel.brush.color:=aktcur.getrgbpalette(aktcol1)
      else begin
        if aktcol1=0 then shapel.brush.color:=shape(16).brush.color else shapel.brush.color:=shape(17).brush.color;
      end;
      mousedown:=true;
    end else begin
      aktcol2:=aktcur.getcolor(x,y);
      if aktcur.getmask(x,y)=false then shaper.brush.color:=aktcur.getrgbpalette(aktcol2)
      else begin
        if aktcol2=0 then shaper.brush.color:=shape(16).brush.color else shaper.brush.color:=shape(17).brush.color;
      end;
      mousedown:=true;
    end;
    2:begin                        { Zoom }
      if (button=mbleft)and(zoom<20) then setzoom(zoom+1);
      if (button=mbright)and(zoom>1) then setzoom(zoom-1);
    end;
    3:begin                        { Pen }
      edited;
      band.x1:=x;
      band.y1:=y;
      if (button=mbleft)then setpixel(x,y,aktcol1);
      if (button=mbright)then setpixel(x,y,aktcol2);

      paintbox.invalidate;
      mousedown:=true;
    end;
    4:begin                        { Brush }
      if button=mbleft then klecks(x,y,aktcol1);
      if button=mbright then klecks(x,y,aktcol2);
      paintbox.invalidate;
      mousedown:=true;
    end;
    5:begin                        { Line }
      band.t:=3;
      band.x1:=x;
      band.y1:=y;
      band.x2:=band.x1;
      band.y2:=band.y1;
      if button=mbleft then band.mode:=1 else band.mode:=2;
      paintbox.invalidate;
      mousedown:=true;
    end;
    6:begin
      edited;
      if button=mbleft then cfloodfill(aktcol1) else cfloodfill(aktcol2);
    end;
    7:begin                        { Rect }
      band.t:=1;
      band.x1:=x;
      band.y1:=y;
      band.x2:=band.x1;
      band.y2:=band.y1;
      if button=mbleft then band.mode:=1 else band.mode:=2;
      paintbox.invalidate;
      edited;
      mousedown:=true;
    end;
    8:begin                        { Fillrect }
      band.t:=2;
      band.x1:=x;
      band.y1:=y;
      band.x2:=band.x1;
      band.y2:=band.y1;
      if button=mbleft then band.mode:=1 else band.mode:=2;
      paintbox.invalidate;
      edited;
      mousedown:=true;
    end;
  end;
end;

procedure Tcursoreditor.PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
i,j:integer;
begin
  j:=0;
  x:=x div zoom;
  y:=y div zoom;
  statictext3.caption:='('+str(x)+','+str(y)+')';
  if mousedown=false then exit;
  if enterhotspot then begin
    if ssleft in shift then
    begin
      aktcur.data.hx:=x;
      aktcur.data.hy:=y;
      aktualisiere;
    end;
    exit;
  end;
  for i:=0 to toolbar1.buttoncount-1 do if toolbar1.buttons[i].down then j:=i;
  case j of
    0:begin
      if (ssleft in shift) then
      begin
        if band.moving then
        begin                         { Auswahl verschieben }
          band.x2:=(x-band.mx)+(band.x2-band.x1);
          band.y2:=(y-band.my)+(band.y2-band.y1);
          band.x1:=x-band.mx;
          band.y1:=y-band.my;

          paintbox.invalidate;
        end else
        begin                         { Umrahmen }
          band.x2:=x;
          band.y2:=y;
          if band.x2<0 then band.x2:=0;
          if band.x2>31 then band.x2:=31;
          if band.y2<0 then band.y2:=0;
          if band.y2>31 then band.y2:=31;
          paintbox.invalidate;
        end;
      end;
    end;
    1:if (ssleft in shift)or(ssright in shift)then
    begin
      if ssleft in shift then
      begin
        aktcol1:=aktcur.getcolor(x,y);
        if aktcur.getmask(x,y)=false then shapel.brush.color:=aktcur.getrgbpalette(aktcol1)
        else begin
          if aktcol1=0 then shapel.brush.color:=shape(16).brush.color else shapel.brush.color:=shape(17).brush.color;
        end;
      end else begin
        aktcol2:=aktcur.getcolor(x,y);
        if aktcur.getmask(x,y)=false then shaper.brush.color:=aktcur.getrgbpalette(aktcol2)
        else begin
          if aktcol2=0 then shaper.brush.color:=shape(16).brush.color else shaper.brush.color:=shape(17).brush.color;
        end;
      end;
    end;
    3:if (ssleft in shift)or(ssright in shift) then begin  { Pen }
      if (ssleft in shift)then line(band.x1,band.y1,x,y,aktcol1);
      if (ssright in shift)then line(band.x1,band.y1,x,y,aktcol2);
      band.x1:=x;
      band.y1:=y;

      paintbox.invalidate;
    end;
    4:if (ssleft in shift)or(ssright in shift)then begin
      if ssleft in shift then klecks(x,y,aktcol1);
      if ssright in shift then klecks(x,y,aktcol2);
      paintbox.invalidate;
    end;
    5,7,8:if band.t<>0 then begin            { Rechteck }
      band.x2:=x;
      band.y2:=y;
      paintbox.invalidate;
    end;
  end;
end;

procedure Tcursoreditor.PaintBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
i,j,k,l,m,n,o:integer;
begin
  releasecapture;
  if enterhotspot then begin
    enterhotspot:=false;
    speedbutton1.down:=false;
    aktualisiere;
    exit;
  end;
  j:=0;
  mousedown:=false;
  for i:=0 to toolbar1.buttoncount-1 do if toolbar1.buttons[i].down then j:=i;
  case j of
    0:if band.hasinhalt=false then begin
      if band.x1>band.x2 then change(band.x1,band.x2);
      if band.y1>band.y2 then change(band.y1,band.y2);
      if (band.x1=band.x2)and(band.y1=band.y2)then
      begin
        unselect;
        paintbox.invalidate;
        exit;
      end;
      for i:=0 to band.x2-band.x1 do for k:=0 to band.y2-band.y1 do
      begin
        l:=aktcur.getcolor(band.x1+i,band.y1+k);
        if aktcur.getmask(band.x1+i,band.y1+k)=false then band.inhalt[i,k]:=l else
        begin
          if l=0 then band.inhalt[i,k]:=16 else band.inhalt[i,k]:=17;
        end;
        setpixel(band.x1+i,band.y1+k,aktcol2);
      end;
      band.hasinhalt:=true;
      band.moving:=false;
    end;
    5:if band.t<>0 then begin
      band.t:=0;
      case band.mode of
        1:k:=aktcol1;
        2:k:=aktcol2;
        else k:=aktcol1;
      end;
      with band do line(x1,y1,x2,y2,k);
      paintbox.invalidate;
    end;
    7:if band.t<>0 then begin
      if button=mbleft then l:=aktcol1 else l:=aktcol2;
      band.t:=0;
      j:=band.x1;
      k:=band.x2;
      if k<j then change(k,j);
      for i:=j to k do setpixel(i,band.y1,l);
      for i:=j to k do setpixel(i,band.y2,l);
      j:=band.y1;
      k:=band.y2;
      if k<j then
      begin
        i:=j;
        j:=k;
        k:=i;
      end;
      for i:=j to k do setpixel(band.x1,i,l);
      for i:=j to k do setpixel(band.x2,i,l);
      paintbox.invalidate;
    end;
    8:if band.t<>0 then
    begin
      if button=mbleft then o:=aktcol1 else o:=aktcol2;
      band.t:=0;
      j:=band.x1;
      k:=band.x2;
      if k<j then change(k,j);
      m:=band.y1;
      n:=band.y2;
      if n<m then change(m,n);
      for i:=j to k do for l:=m to n do setpixel(i,l,o);
      paintbox.invalidate;
    end;
  end;
end;

procedure tcursoreditor.setpixel;
begin
  if f<=15 then
  begin
    aktcur.setcolor(x,y,f);
    aktcur.setmask(x,y,false);
  end else
  begin
    if f=16 then aktcur.setcolor(x,y,0) else
      aktcur.setcolor(x,y,15);
    aktcur.setmask(x,y,true);
  end;
end;

procedure tcursoreditor.line;
begin
  edited;
  curline(@setp,x1,y1,x2,y2,farbe,0,0);
end;

procedure tcursoreditor.klecks;
var
i:integer;
j:integer;
const
r=3.5;
begin
  edited;
  for i:=mx-ceil(r) to mx+ceil(r) do for j:=my-ceil(r) to my+ceil(r) do
    if ((sqrt(sqr(i-mx)+sqr(j-my)))<r)then setpixel(i,j,f);
end;

procedure Tcursoreditor.ToolBar1Click(Sender: TObject);
begin
  unselect;
  enterhotspot:=false;
  if speedbutton1.down then speedbutton1.down:=false;
  updatecursor;
  paintbox.invalidate;
end;            

procedure Tcursoreditor.Button2Click(Sender: TObject);
var
a:array[0..200]of char;
path:string;
begin
  unselect;
  gettemppath(200,a);
  if strlen(a)>0 then
  begin
    path:=a;
    if path[length(path)]<>'\' then path:=path+'\';
  end else path:='';
  path:=path+loadstringid(6);

  aktcur.savetofile(path);
  paintbox.invalidate;
  screen.cursors[5]:=loadcursorfromfile(pchar(path));
  deletefile(path);
  cursortest:=tcursortest.create(self);
  cursortest.paintbox.cursor:=5;
  cursortest.showmodal;
  cursortest.free;
  destroycursor(screen.cursors[5]);
  screen.cursors[5]:=screen.cursors[crdefault];
end;

procedure Tcursoreditor.FormShow(Sender: TObject);
begin
  aktualisiere;
end;

procedure tcursoreditor.aktualisiere;
begin                      
  statictext4.caption:='"'+list.items[faktcur].caption+'.cur":';
  statictext2.caption:='('+str(aktcur.data.hx)+','+str(aktcur.data.hy)+')';
  updatecursor;
  paintbox.invalidate;
end;

procedure Tcursoreditor.SpeedButton1Click(Sender: TObject);
begin
  enterhotspot:=enterhotspot=false;
  updatecursor;
end;

procedure tcursoreditor.updatecursor;
var
i,j:integer;
begin
  if enterhotspot then paintbox.cursor:=crhandpoint else
  begin
    j:=0;
    for i:=0 to toolbar1.buttoncount-1 do if toolbar1.buttons[i].down then j:=i;
    case j of
      0,4,5,7,8:paintbox.cursor:=crcross;
      2:paintbox.cursor:=7;
      3:paintbox.cursor:=6;
      1:paintbox.cursor:=10;
      6:paintbox.cursor:=9;
      else paintbox.cursor:=crdefault;
    end;
  end;
end;

procedure tcursoreditor.edited;
begin
  pagesdlg.saveskinr.what[9]:=true;
end;

procedure Tcursoreditor.Button3Click(Sender: TObject);
var
h:hcursor;
b:tbitmap;
i,j:integer;
begin
  if opendialog.execute then
  begin
    screen.cursor:=crhourglass;
    b:=tbitmap.create;
    b.width:=32;
    b.height:=32;
    if opendialog.Files.count>1 then
    begin
      for i:=0 to opendialog.files.count-1 do
      begin
        h:=loadcursorfromfile(pchar(opendialog.files[i]));
        for j:=1 to 27 do
          if grosswort(copy(extractfilename(opendialog.files[i]),1,pos('.',extractfilename(opendialog.files[i]))-1))=grosswort(cursornames[j])then
        begin
          import(h,@cursors[j],b.canvas.handle);
          break;
        end;
      end;
    end else
    begin
      h:=loadcursorfromfile(pchar(opendialog.filename));
      import(h,aktcur,b.canvas.handle);
    end;
    b.free;
    unselect;
    aktualisiere;
    setcolors;
    screen.cursor:=crdefault;
  end;
end;

procedure Tcursoreditor.Button4Click(Sender: TObject);
begin
  savedialog.filename:=list.items[faktcur].caption+'.cur';
  if savedialog.execute then
  begin
    aktcur.savetofile(savedialog.filename);
  end;
end;

procedure Tcursoreditor.ListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (source is tlistview)and((source as tlistview).selected<>(sender as tlistview).droptarget) then
  begin
    // Aktuellen Cursor auf DropTarget setzen und Anzeige aktualisieren
    if (state=dsdragmove)and((sender as tlistview).droptarget<>nil) then faktcur:=(sender as tlistview).droptarget.index;
    if state=dsdragleave then faktcur:=(sender as tlistview).selected.index;
    aktualisiere;
    accept:=true;
  end else begin
    if faktcur<>(sender as tlistview).selected.index then
    begin
      faktcur:=(sender as tlistview).selected.index;
      aktualisiere;
    end;
    accept:=false;
  end;
end;

procedure Tcursoreditor.ListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
c1,c2:pcursorfile;
begin
  { }
  c1:=aktcur;
  c2:=cursors[(sender as tlistview).droptarget.index+1];

  c2.data:=c1.data;
  (sender as tlistview).selected:=(source as tlistview).droptarget;
  aktualisiere;
end;

procedure tcursoreditor.setcolors;
var
i:integer;
begin
  for i:=0 to 17 do
  begin
    if i<=15 then shape(i).brush.color:=aktcur.getrgbpalette(i)
    else begin
      if i=16 then shape(i).brush.color:=rgb(0,128,128) else shape(i).brush.color:=rgb(255,128,128);
    end;
    shape(i).tag:=i;
  end;
  shapel.brush.color:=shape(aktcol1).brush.color;
  shaper.brush.color:=shape(aktcol2).brush.color;
end;

procedure Tcursoreditor.ListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if selected=true then
  begin
    faktcur:=item.index;
    unselect;
    aktualisiere;
    setcolors;
  end;
end;

procedure tcursoreditor.unselect;
var
i,j:integer;
begin
  if band.hasinhalt then
  begin
    for i:=band.x1 to band.x2 do for j:=band.y1 to band.y2 do
      setpixel(i,j,band.inhalt[i-band.x1,j-band.y1]);
  end;
  band.t:=0;
  band.hasinhalt:=false;
  band.moving:=false;
end;

procedure Tcursoreditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
i,j:integer;
begin
  if (band.t=1)and(band.hasinhalt)and(key=vk_delete) then
  begin
    unselect;
    for i:=band.x1 to band.x2 do for j:=band.y1 to band.y2 do
    begin
      setpixel(i,j,aktcol2);
    end;
    paintbox.invalidate;
  end;
end;

procedure tcursoreditor.wmdropfiles;
var
num,i,j:integer;
a:array[0..200]of char;
b:tbitmap;
h:hcursor;
begin
  setforegroundwindow(handle);
  num:=dragqueryfile(msg.wparam,uint(-1),pchar(@a[0]),200);
  b:=tbitmap.create;
  b.width:=32;
  b.height:=32;
  for i:=0 to num-1 do
  begin
    dragqueryfile(msg.wparam,i,pchar(@a[0]),200);
    h:=loadcursorfromfile(pchar(@a[0]));
    for j:=1 to 27 do
      if grosswort(copy(extractfilename(a),1,pos('.',extractfilename(a))-1))=grosswort(cursornames[j])then
    begin
      import(h,@cursors[j],b.canvas.handle);
      break;
    end;
  end;
  b.free;
  unselect;
  aktualisiere;
end;

procedure Tcursoreditor.Panel2DblClick(Sender: TObject);
begin
  application.messagebox('Hallo','Hallo',0);
end;

procedure Tcursoreditor.Shape1DblClick(Sender: TObject);
var
r,g,b:byte;
begin
  pagesdlg.ColorDialog.color:=(sender as tshape).brush.color;
  if pagesdlg.colordialog.execute then
  begin
    r:=getrvalue(pagesdlg.colordialog.color);
    g:=getgvalue(pagesdlg.colordialog.color);
    b:=getbvalue(pagesdlg.colordialog.color);
    aktcur.data.palette[(sender as tshape).tag,1]:=b;
    aktcur.data.palette[(sender as tshape).tag,2]:=g;
    aktcur.data.palette[(sender as tshape).tag,3]:=r;
    setcolors;
    paintbox.Invalidate;
  end;
end;

procedure Tcursoreditor.ListContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
