unit regions;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, Buttons,math,regiotest,skinampc,
  funktionen;

const
maxpolygon=50;
maxpoints=250;

type
  ppolygon=^tpolygon;
  tpolygon=record
    numpoints:byte;
    pointlist:array[1..maxpoints]of tpoint;
  end;
  pregionpoints=^tregionpoints;
  tregionpoints=record
    polynum:byte;
    polygons:array[1..maxpolygon]of tpolygon
  end;
  TRegionsdlg = class(TForm)
    What: TListBox;
    Button1: TButton;
    polynum: TEdit;
    polnum: TUpDown;
    Label1: TLabel;
    Button3: TButton;
    Button4: TButton;
    mousex: TStaticText;
    mousey: TStaticText;
    pointlist: TMemo;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    SpeedButton1: TSpeedButton;
    Button2: TButton;
    OpenDialog: TOpenDialog;
    PaintBox: TPaintBox;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    modus: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure WhatClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure polnumClick(Sender: TObject; Button: TUDBtnType);
    procedure pointlistChange(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure PaintBoxDblClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormHide(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure WhatContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
    infuetter:boolean;
    r_main,r_eq,r_wshade,r_eqws:tregionpoints;
    orgwidth,orgheight:integer;
    preview:hwnd;

    procedure updatergn;
    procedure regiotestclosed(var msg:tmessage); message wm_regiotestclose;
    procedure addpoint(x,y:integer);    
  public
    { Public-Deklarationen }
    bmp:tbitmap;
    procedure fuetter;
    procedure saveregions(verz:pchar);
    function getrrec:pregionpoints;
    procedure updatepreview;
  end;

var
  Regionsdlg: TRegionsdlg;

implementation

{$R *.DFM}

uses bmps,wmain,weq,konstanten,sascha,inifiles,language;

procedure TRegionsdlg.FormCreate(Sender: TObject);
begin
  preview:=0;
  doublebuffered:=true;
  what.itemindex:=0;
  bmp:=tbitmap.create;
  bmp.width:=mainwidth;
  bmp.height:=mainheight;
  r_main.polynum:=1;
  r_eq.polynum:=1;
  r_wshade.polynum:=1;
  r_eqws.polynum:=1;
  infuetter:=false;
  fuetter;
  screen.Cursors[7]:=loadcursor(dllinstance,makeintresource(202));
  orgwidth:=clientwidth;
  orgheight:=clientheight;
  speedbutton2.Glyph.loadfromresourceid(dllinstance,103);
  speedbutton3.glyph.loadfromresourceid(dllinstance,125);
  modus.Glyph.loadfromresourceid(dllinstance,106);
  setids(self);
end;

function tregionsdlg.getrrec;
begin
  case what.itemindex of
    0:result:=@r_main;
    1:result:=@r_eq;
    2:result:=@r_wshade;
    3:result:=@r_eqws;
    else result:=@r_main;
  end;
end;

procedure TRegionsdlg.PaintBoxPaint(Sender: TObject);
var
i:integer;
b:tbitmap;

procedure drawp(c:tcanvas;r:ppolygon);
var i:integer;
begin
  with c,r^ do
  begin
    pen.color:=rgb(255,255,255);
    pen.Width:=1;
    pen.style:=pssolid;
    pen.mode:=pmxor;
    moveto(pointlist[1].x,pointlist[1].y);
    for i:=2 to numpoints do
    begin
      lineto(pointlist[i].x,pointlist[i].y);
    end;
//    lineto(pointlist[1].x,pointlist[1].y);
  end;
end;
procedure paintraster;
var
i,j:integer;
begin
  with b.canvas do
  begin
    pen.style:=pssolid;
    pen.mode:=pmcopy;
    setrop2(b.canvas.handle,r2_mergenotpen);
    for i:=0 to (bmp.width-1) div 2 do for j:=0 to (bmp.height-1) div 2 do
    begin
      setpixel(b.canvas.handle,i*2,j*2,rgb(128,128,128));
    end;
  end;
end;
begin
  { Inhalt malen }
  b:=tbitmap.create;
  b.width:=mainwidth;
  b.height:=mainheight;
  clearbitmap(b,color);
  b.Canvas.draw(0,0,bmp);
  if checkbox1.checked=false then drawp(b.canvas,@getrrec.polygons[polnum.position])
  else for i:=1 to getrrec.polynum do drawp(b.canvas,@getrrec.polygons[i]);

  if speedbutton3.down then
  begin // Raster malen
{    b2:=tbitmap.create;
    b2.width:=paintbox.width;
    b2.height:=paintbox.height;
    b2.canvas.stretchdraw(rect(0,0,b2.width,b2.height),b);

    paintraster;

    with paintbox do canvas.draw(0,0,b2);
    b2.free;}
    paintraster;
  end;
  with paintbox do canvas.stretchdraw(rect(0,0,width,height),b);
  b.free;
end;

procedure TRegionsdlg.WhatClick(Sender: TObject);
begin
  bmp.width:=mainwidth;
  bmp.height:=mainheight;
//  paintbox.height:=mainheight;
  clearbitmap(bmp,color);
  case what.itemindex of
    0:getmainbitmap(bmp,true);
    1:geteqbitmap(bmp,true);
    2:begin
      bmp.width:=mainwidth;
      bmp.height:=14;
//      paintbox.height:=14;
      wmain.drawmainbar(bmp,0,0,3);
    end;
    3:begin
      bmp.width:=eqwidth;
      bmp.height:=14;
//      paintbox.height:=14;
      weq.drawmainbar(bmp,0,0,3);
    end;
  end;
  setwindowpos(preview,0,0,0,bmp.width,bmp.height,swp_nomove or swp_noactivate);
  updatepreview;
  updatergn;
  polnum.max:=getrrec.polynum;
  if polnum.max=0 then polnum.max:=1;
  polnum.position:=polnum.max;
  if polnum.max>1 then polnum.enabled:=true else polnum.enabled:=false;

  fuetter;
end;

procedure TRegionsdlg.FormDestroy(Sender: TObject);
begin
  bmp.Free;
end;

procedure TRegionsdlg.Button3Click(Sender: TObject);
begin
  if polnum.max=maxpolygon then exit;
  inc(getrrec.polynum);
  polnum.enabled:=true;
  polnum.max:=polnum.max+1;
  polnum.position:=polnum.max;

  getrrec.polygons[getrrec.polynum].numpoints:=0;

  fuetter;
end;

procedure TRegionsdlg.Button4Click(Sender: TObject);
var
i:integer;
begin
  if polnum.max=1 then
  begin
    PaintBoxMouseDown(sender,mbright,[],0,0);
    exit;
  end;
  if application.messagebox(pchar(loadstring(16)+' ('+str(polnum.position)+')'),pchar(l_title),mb_yesno or mb_iconquestion)=mryes then
  begin
    dec(getrrec.polynum);
    for i:=polnum.position to getrrec.polynum do
    begin
      getrrec.polygons[i]:=getrrec.polygons[i+1];
    end;
    polnum.max:=polnum.max-1;
    polynum.text:=str(polnum.position);

    if polnum.max=1 then polnum.enabled:=false;

    fuetter;
    paintbox.Invalidate;
  end;
  updatergn;
end;

procedure tregionsdlg.fuetter;
var
s:string;
i:integer;
begin
  infuetter:=true;
  s:='';
  for i:=1 to getrrec.polygons[polnum.position].numpoints do with getrrec.polygons[polnum.position] do
  begin
    s:=s+str(pointlist[i].x)+','+str(pointlist[i].y)+',  ';
  end;

  pointlist.text:=s;
  paintbox.invalidate;
  infuetter:=false;
end;

procedure TRegionsdlg.PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  mousex.caption:='X: '+str(round((x)*(mainwidth/paintbox.width)));
  mousey.caption:='Y: '+str(round((y)*(mainheight/paintbox.height)));
end;

procedure TRegionsdlg.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
procedure zoom(positiv:boolean);
var
aktzoomh:real;
const
summand=75;
begin
  if positiv then clientwidth:=clientwidth+summand else clientwidth:=clientwidth-summand;
  aktzoomh:=clientwidth-orgwidth;

  clientheight:=orgheight+round(aktzoomh*(mainheight/mainwidth));
end;
function addroundedge(x,y:integer;right:boolean):boolean;
var
ox,oy:integer;
dir:byte;
rx,ry:integer;
g:real;
nx,ny:integer;
m:tpoint;
const
gra=90/5;
start:array[0..3]of integer=(180,270,90,0);
ende:array[0..3]of integer=(270,360,180,90);
begin
  result:=false;
  with getrrec.polygons[polnum.position] do
  begin
    if numpoints<1 then exit;
    ox:=pointlist[numpoints].x;
    oy:=pointlist[numpoints].y;
  end;
  if (abs(ox-x)<=2)or(abs(oy-y)<=2)then exit;
  if not right then
  begin
    change(x,ox);
    change(y,oy);
  end;
  dir:=0;
  if (ox<x)then dir:=dir+1;
  if (oy<y)then dir:=dir+2;


  rx:=abs(x-ox);
  ry:=abs(y-oy);
  if (dir=3)or(dir=0)then m:=point(ox,y) else m:=point(x,oy);

  if not right then
  begin
    change(x,ox);
    change(y,oy);
  end;

  begin
    g:=start[dir]+gra;
    repeat
      if right then
      begin
        nx:=round(m.x+sin(degtorad(g))*rx);
        ny:=round(m.y-cos(degtorad(g))*ry);
      end else begin
        nx:=round(m.x+sin(degtorad(ende[dir]+start[dir]-g))*rx);
        ny:=round(m.y-cos(degtorad(ende[dir]+start[dir]-g))*ry);
      end;
      addpoint(nx,ny);
      g:=g+gra;
    until (g>=ende[dir]);
  end;
  addpoint(x,y);
  
  result:=true;
end;
var
i,j:integer;
begin
  { Punkt addieren }
  if (button=mbleft)and(speedbutton2.down)then
  begin
    zoom(true);
    exit;
  end;
  if (button=mbleft)and not (ssdouble in shift)and not (speedbutton2.down) then
  begin
    i:=round(((x)/paintbox.width)*mainwidth);
    j:=round(((y)/paintbox.height)*mainheight);
    if modus.tag=0 then
      addpoint(i,j)
    else begin
      if addroundedge(i,j,modus.tag=1)=false then addpoint(i,j);
    end;
    updatergn;
    fuetter;
    exit;
  end;
  if button=mbright then
  begin
    if speedbutton2.down then
    begin
      if width>constraints.minwidth then zoom(false);
    end
    else if (getrrec.polygons[polnum.position].numpoints>0)and(application.messagebox(pchar(loadstring(17)),pchar(l_title),mb_yesno or mb_iconquestion)=mryes) then
    begin
      getrrec.polygons[polnum.position].numpoints:=0;
      updatergn;
      fuetter;
    end;
  end;
end;

procedure TRegionsdlg.polnumClick(Sender: TObject; Button: TUDBtnType);
begin
  fuetter;
end;

procedure TRegionsdlg.pointlistChange(Sender: TObject);
var
i:integer;
p:integer;
c:byte;
cord:integer;
err:integer;
ts:string;
s:string;
begin
  { Analysieren und aktualisieren }
  if infuetter then exit;
  ts:='';
  p:=1;
  c:=1;
  s:=trim(pointlist.text);
  if trim(s)='' then
  begin
    getrrec.polygons[polnum.position].numpoints:=0;
    exit;
  end;
  if s[length(s)]<>',' then s:=s+',';
  for i:=1 to length(s) do
  begin
    if s[i]<>',' then ts:=ts+s[i]else
    begin
      ts:=trim(ts);
      if ts='' then exit;
      val(ts,cord,err);
      if err<>0 then exit;
      ts:='';
      with getrrec.polygons[polnum.position] do
      begin
        if c=1 then pointlist[p].x:=cord else pointlist[p].y:=cord;
        c:=c+1;
        if c>2 then
        begin
          c:=1;
          inc(p);
        end;
      end;
    end;
  end;
  if c=1 then
  begin
    getrrec.polygons[polnum.position].numpoints:=p-1;
    paintbox.invalidate;
    updatergn;
  end;
end;

procedure tregionsdlg.saveregions;
var
i:tinifile;

procedure writesect(r:pregionpoints;name:string);
var
s:string;
zhl1,zhl2:integer;
begin
  if (r.polynum=1)and(r.polygons[1].numpoints=0)then
  begin
    i.erasesection(name);
    exit;
  end;

  s:='';
  for zhl1:=1 to r.polynum do s:=s+str(r.polygons[zhl1].numpoints)+', ';
  s:=copy(s,1,length(s)-2);
  i.WriteString(name,'numpoints',s); 

  s:='';
  for zhl1:=1 to r.polynum do for zhl2:=1 to r.polygons[zhl1].numpoints do with r.polygons[zhl1] do
  begin
    s:=s+str(pointlist[zhl2].x)+','+str(pointlist[zhl2].y)+',  ';
  end;
  s:=copy(s,1,length(s)-3);
  i.writestring(name,'pointlist',s);
end;
var
f:textfile;
begin
  i:=tinifile.create(verz+'region.txt');

  writesect(@r_main,'Normal');
  writesect(@r_eq,'Equalizer');
  writesect(@r_wshade,'WindowShade');
  writesect(@r_eqws,'EqualizerWS');

  i.updatefile;
  i.free;
  assignfile(f,verz+'region.txt');
  append(f);
  writeln(f);
  writeln(f,'// '+loadstringid(16));
  writeln(f,'// You can download Skinamp at my homepage:');
  writeln(f,'// '+loadstringid(17));
  closefile(f);
end;

procedure TRegionsdlg.CheckBox1Click(Sender: TObject);
begin
  paintbox.invalidate;
end;

procedure TRegionsdlg.FormShow(Sender: TObject);
begin
  whatclick(self);
  if speedbutton1.Down then
  begin
    preview:=createpreview(handle);
    updatergn;
    showwindow(preview,sw_show);
  end;
end;

procedure TRegionsdlg.SpeedButton1Click(Sender: TObject);
begin
  if (sender as tspeedbutton).down then
  begin
    preview:=createpreview(handle);
    updatergn;
    showwindow(preview,sw_show);
  end else
    if preview<>0 then destroywindow(preview);
end;

procedure tregionsdlg.updatepreview;
begin
  if preview<>0 then invalidaterect(preview,nil,false);
end;

procedure TRegionsdlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if preview<>0 then destroywindow(preview);
end;

procedure tregionsdlg.updatergn;
type
tpointarray=array[1..maxpoints] of tpoint;
ppointarray=^tpointarray;
tintarray=array[1..maxpolygon] of integer;
pintarray=^tintarray;

var
ppoints:ppointarray;
pnumpoints:pintarray;
polynum:integer;
rgn:hrgn;

function createbuffer:boolean;
var
pts,poly:integer;
i,j:integer;
begin
  result:=false;
  pnumpoints:=nil;
  ppoints:=nil;
  pts:=0;
  polynum:=0;
  for i:=1 to getrrec.polynum do
    if getrrec.polygons[i].numpoints>=3 then
  begin
    pts:=pts+getrrec.polygons[i].numpoints;
    inc(polynum);
  end;

  getmem(pnumpoints,polynum*sizeof(integer));
  if pnumpoints=nil then exit;
  getmem(ppoints,pts*sizeof(tpoint));
  if ppoints=nil then
  begin
    freemem(pnumpoints);
    pnumpoints:=nil;
    exit;
  end;

// Daten füllen
  pts:=1;
  poly:=1;
  for i:=1 to getrrec.polynum do if getrrec.polygons[i].numpoints>=3 then
  begin
    pnumpoints^[poly]:=integer(getrrec.polygons[i].numpoints);
    inc(poly);
    for j:=1 to getrrec.polygons[i].numpoints do
    begin
      ppoints^[pts]:=getrrec.polygons[i].pointlist[j];
      inc(pts);
    end;
  end;

  result:=true;
end;

begin
  if createbuffer then
  begin
    rgn:=createpolypolygonrgn(ppoints^,pnumpoints^,polynum,winding);
    freemem(ppoints);
    freemem(pnumpoints);
  end else rgn:=0;

  if preview<>0 then setwindowrgn(preview,rgn,true);
end;


procedure TRegionsdlg.Button2Click(Sender: TObject);
var
i:tinifile;
procedure readsect(r:pregionpoints;section:string);
var
j,k,l,m,n,error:integer;
s,s2:string;
buffer:array[0..10000]of char;
begin
  r.polynum:=1;
  r.polygons[1].numpoints:=0;
  s:=i.readstring(section,'Numpoints','');
  if trim(s)='' then exit;
  k:=1;
  j:=1;
  s2:='';
  repeat
    r.polygons[k].numpoints:=0;
    if s[j]<>',' then s2:=s2+s[j] else
    begin
      s2:=trim(s2);
      val(s2,l,error);
      if error=0 then
      begin
        r.polygons[k].numpoints:=l;
        inc(k);
      end;
      s2:='';
    end;
    inc(j);
    if j>length(s) then
    begin
      s2:=trim(s2);
      if s2<>'' then
      begin
        val(s2,l,error);
        if error=0 then
        begin
          r.polygons[k].numpoints:=l;
        end;
      end;
    end;
  until j>length(s);
  r.polynum:=k;
  SetString(s, Buffer, GetPrivateProfileString(PChar(Section),
    PChar('Pointlist'), PChar(''), Buffer, SizeOf(Buffer), PChar(i.FileName)));
  j:=1;        // Position in String
  k:=1;        // Aktuelles Polygon
  l:=1;        // Aktueller Punkt
  n:=0;        // Punkt Information x(0)/y(1)
  s2:='';      // Teil Koordinate
  repeat
    if s[j]<>',' then s2:=s2+s[j] else
    begin
      s2:=trim(s2);
      val(s2,m,error);
      if error=0 then
      begin
        if n=0 then r.polygons[k].pointlist[l].x:=m else
          r.polygons[k].pointlist[l].y:=m;
        inc(n);
        if n=2 then
        begin
          n:=0;
          inc(l);
          if l>r.polygons[k].numpoints then
          begin
            l:=1;
            inc(k);
          end;
        end;
      end;
      s2:='';
    end;
    inc(j);
  until j>length(s);
  begin           // Letzten Punkt zuende machen
    s2:=trim(s2);
    if s2<>'' then
    begin
      val(s2,m,error);
      if error=0 then
      begin
        if n=0 then r.polygons[k].pointlist[l].x:=m else
          r.polygons[k].pointlist[l].y:=m;
      end;
    end;
  end;
  if r.polynum=0 then r.polynum:=1;
end;

begin
  if opendialog.execute then
  begin
    i:=tinifile.create(opendialog.filename);

    readsect(@r_main,'Normal');
    readsect(@r_eq,'Equalizer');
    readsect(@r_wshade,'WindowShade');
    readsect(@r_eqws,'EqualizerWS');

    i.free;
    what.itemindex:=0;
    polnum.max:=getrrec.polynum;
    if polnum.max<1 then polnum.max:=1;
    if polnum.max=1 then polnum.enabled:=false else polnum.enabled:=true;
    polnum.position:=1;
    fuetter;
    updatergn;
    whatclick(what);
  end;
end;

procedure TRegionsdlg.PaintBoxDblClick(Sender: TObject);
begin
  if speedbutton2.down then exit;
  button3click(button3);
end;

procedure TRegionsdlg.SpeedButton2Click(Sender: TObject);
begin
  { Cursor ändern }
  if speedbutton2.down=false then paintbox.cursor:=crcross else
  begin
    paintbox.cursor:=7;
  end;
end;

procedure TRegionsdlg.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (button=mbright)and(speedbutton2.down)then speedbutton2.click;
end;

procedure TRegionsdlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=vk_escape)then
  begin
    if(speedbutton2.Down)then
    begin
      speedbutton2.click;
      key:=0;
    end else close;
  end;
end;

procedure TRegionsdlg.FormHide(Sender: TObject);
procedure cleanrec(r:pregionpoints);
var
i,j,k:integer;
begin
  for i:=1 to r.polynum do with r.polygons[i] do
  begin
    j:=1;
    while j<numpoints do
    begin
      if (pointlist[j].x=pointlist[j+1].x)and(pointlist[j].y=pointlist[j+1].y) then
      begin
        for k:=j+1 to numpoints-1 do pointlist[k]:=pointlist[k+1];
        pointlist[numpoints]:=point(0,0);
        dec(numpoints);
        dec(j);
      end;
      inc(j);
    end;
  end;
  
  if r.polynum<=1 then
  begin
    if r.polygons[1].numpoints<=2 then r.polygons[1].numpoints:=0;
    exit;
  end;
  i:=2;
  repeat
    if r.polygons[i].numpoints<=2 then
    begin
      r.polygons[i].numpoints:=0;
      for j:=i to r.polynum-1 do r.polygons[j]:=r.polygons[j+1];
      r.polygons[r.polynum].numpoints:=0;
      dec(r.polynum);
    end else inc(i);
  until i>r.polynum;
end;
begin
  if preview<>0 then destroywindow(preview);
  if speedbutton2.down then speedbutton2.down:=false;
  paintbox.cursor:=crcross;
  
  cleanrec(@r_main);
  cleanrec(@r_eq);
  cleanrec(@r_wshade);
  cleanrec(@r_eqws);
end;

procedure tregionsdlg.regiotestclosed;
begin
  speedbutton1.down:=false;
end;

procedure TRegionsdlg.SpeedButton3Click(Sender: TObject);
begin
  paintbox.invalidate;
end;

procedure tregionsdlg.addpoint;
begin
  with getrrec.polygons[polnum.position]do
  begin
    inc(numpoints);
    pointlist[numpoints].x:=x;
    pointlist[numpoints].y:=y;
    if (pointlist[numpoints].x=pointlist[numpoints-1].x)and
       (pointlist[numpoints].y=pointlist[numpoints-1].y)then
    begin
      dec(numpoints);
    end;
  end;
end;

procedure TRegionsdlg.BitBtn1Click(Sender: TObject);
begin
  modus.tag:=modus.tag+1;
  if modus.tag>=3 then modus.tag:=0;
  case modus.tag of
    0:modus.glyph.LoadFromResourceID(dllinstance,106);
    1:modus.glyph.LoadFromResourceID(dllinstance,126);
    2:modus.glyph.LoadFromResourceID(dllinstance,127);
  end;
end;

procedure TRegionsdlg.WhatContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
