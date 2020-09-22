unit bmps;
{$I cs.inc}
interface

uses windows,graphics,jpeg,sascha,gifimage,funktionen;

var
fromx,fromy:integer;
originalpicture,loadedfile:tbitmap;
prozentx,prozenty:integer;
bitmapsfile,masksfile,defaultbitmapsfile,defaultmasksfile:string;

const
intensiv=230;
pixelformat=pf24bit;
minstretch=10;

function maxwidth:integer;
function maxheight:integer;
procedure getoriginalpicture(r:tbitmap;y:integer;h:integer);
procedure getpicturepart(dc:hdc;dx,dy:integer;x1,y1,w,h:integer);
procedure paintmask(dc:hdc;x,y,w,h:integer;srcx,srcy:integer);
procedure paintbmp (dc:hdc;x,y,w,h:integer;srcx,srcy:integer);
procedure paintbmpcolor(dc:hdc;x,y,w,h:integer;srcx,srcy:integer;color:tcolorref);
procedure initmask;
procedure freemask;
procedure clearbitmap(b:tbitmap;c:tcolorref);
procedure createpicture(c1,c2,c3,c4,c5:tcolorref;colors,direction,bis:integer);
procedure smalltextout(c:tbitmap;x,y:integer;text:string);
procedure loadpicture(filename:string;autoconfig:boolean);
procedure cliptypchanged;
procedure copyfonts(dc:hdc);
procedure titeltext(z:tbitmap;x1,y1,x2,y2:integer;text:string;active:boolean);
procedure originalmask(dc:hdc;x,y,w,h,srcx,srcy:integer;orgx,orgy:integer;withmask:boolean);
procedure originalbmp(dc:hdc;x,y,w,h,srcx,srcy:integer;orgx,orgy:integer;withbmp:boolean);
procedure assignbitmapsfile(f:string);
procedure assignmasksfile(f:string);
procedure setdefault;
procedure lockbitmaps;
procedure unlockbitmaps;


implementation

uses konstanten,main,classes,sysutils,saveform,forms,language,pltext,
  math,skinampc;

var
mask,bitmaps:tbitmap;

type
tmyjpg=class(tJPEGImage)
  procedure drawto(c:tcanvas);
end;

procedure tmyjpg.drawto;
var
r:trect;
begin
  r.left:=0;
  r.top:=0;
  r.right:=width;
  r.bottom:=height;
  Draw(c,r);
end;


function maxwidth:integer;
begin
  maxwidth:=picturewidth;
end;

function maxheight:integer;
var
h:integer;
begin
  h:=pictureheight;
  if pagesdlg.radiogroup7.itemindex=0 then h:=h+ploffset;
  if pagesdlg.radiogroup8.itemindex=0 then h:=h+mboffset;
//  inc(h);
  maxheight:=h;
end;



procedure initmask;
begin
  mask:=tbitmap.Create;
//  mask.pixelformat:=pixelformat;

  assignmasksfile(defaultmasksfile);
  bitmaps:=tbitmap.create;
//  bitmaps.pixelformat:=pixelformat;
  assignbitmapsfile(defaultbitmapsfile);
end;

procedure freemask;
begin
  mask.free;
  bitmaps.free;
end;

procedure cliptypchanged;
var
src,dest:trect;
function rb:integer;
begin
  rb:=ceil((loadedfile.width*prozentx)/ 100);
end;
function rh:integer;
begin
  rh:=ceil((loadedfile.height*prozenty)/ 100);
end;
begin
  if pagesdlg.disableupdate then exit;
  dest.left:=0;
  dest.top:=0;
  dest.right:=originalpicture.width;
  dest.bottom:=originalpicture.height;
  originalpicture.canvas.brush.style:=bssolid;
  originalpicture.canvas.brush.color:=rgb(192,192,192);
  originalpicture.canvas.pen.style:=pssolid;
  originalpicture.canvas.pen.color:=originalpicture.canvas.brush.color;
  originalpicture.Canvas.rectangle(dest);
  case main.PagesDlg.cliptyp.itemindex of
    0:begin
      src.left:=fromx;
      src.top:=fromy;
      src.right:=fromx+(originalpicture.width)*100 div prozentx;
      src.bottom:=fromy+(originalpicture.height)*100 div prozenty;
      setstretchbltmode(originalpicture.canvas.handle,halftone);
      stretchblt(originalpicture.canvas.handle,dest.left,dest.top,dest.right-dest.left,dest.bottom-dest.top,
        loadedfile.canvas.handle,src.left,src.top,src.right-src.left,src.bottom-src.top,srccopy);
    end;
    1:begin
      originalpicture.canvas.StretchDraw(dest,loadedfile);
    end;
    2:begin
       src.left:=0;
       src.top:=0;
       src.right:=loadedfile.width;
       src.bottom:=loadedfile.height;
       dest.left:=-fromx;
       dest.top:=-fromy;
       dest.right:=dest.left+rb;
       dest.bottom:=dest.top+rh;
       setstretchbltmode(originalpicture.canvas.handle,halftone);

       repeat
         stretchblt(originalpicture.canvas.handle,dest.left,dest.top,dest.right-dest.left,dest.bottom-dest.top,
           loadedfile.canvas.handle,src.left,src.top,src.right-src.left,src.bottom-src.top,srccopy);

         dest.left:=dest.left+rb;
         dest.right:=dest.right+rb;
         if (dest.left>maxwidth)then
         begin
           dest.left:=-fromx;
           dest.right:=dest.left+rb;
           dest.top:=dest.top+rh;
           dest.bottom:=dest.bottom+rh;
         end;
       until dest.top>maxheight+rh;
    end;
  end;
//  originalpicture.pixelformat:=pfdevice;
end;

procedure getoriginalpicture;
begin
  getpicturepart(r.canvas.handle,0,0,0,y,r.width,h);
end;

procedure getpicturepart;
begin
  bitblt(dc,dx,dy,w,h,originalpicture.canvas.handle,x1,y1,srccopy);
end;

procedure paintmask;
begin
  cpaintmask(mask.canvas.handle,dc,x,y,w,h,srcx,srcy);
end;

procedure paintbmp;
begin
  cpaintbmp(bitmaps.canvas.handle,dc,x,y,w,h,srcx,srcy);
end;

procedure paintbmpcolor;
begin
  cpaintbmpcolor(bitmaps.canvas.handle,dc,x,y,w,h,srcx,srcy,color);
end;

procedure clearbitmap;
begin
  with b.canvas do
  begin
    brush.color:=c;
    brush.style:=bssolid;
    pen.style:=psclear;
    rectangle(0,0,b.width+1,b.height+1);
  end;
end;

procedure createpicture;
procedure flow(fromc,toc:tcolorref;f,t:double);
var
zhl:integer;
r,g,b:integer;
aktr,aktg,aktb:double;
points:array[0..3]of tpoint;
dx,dy:integer;
begin
  r:=getrvalue(toc)-getrvalue(fromc);
  g:=getgvalue(toc)-getgvalue(fromc);
  b:=getbvalue(toc)-getbvalue(fromc);
  aktr:=getrvalue(fromc);
  aktg:=getgvalue(fromc);
  aktb:=getbvalue(fromc);
  for zhl:=round(f) to round(t) do
  begin
    loadedfile.canvas.Brush.color:=rgb(round(aktr),round(aktg),round(aktb));
    case direction of
      0:loadedfile.canvas.rectangle(0,zhl,picturewidth+1,zhl+2);
      1:loadedfile.canvas.rectangle(zhl,0,zhl+2,maxpictureheight+1);
      2,3:begin
        if direction=2 then dx:=picturewidth else dx:=0;
        dy:=zhl-2-(picturewidth div 2);
        points[0]:=point(picturewidth-dx,zhl);
        points[2]:=point(dx,dy);

        points[1]:=point(points[0].x,points[0].y-2);
        points[3]:=point(points[2].x,points[2].y+2);
        loadedfile.canvas.Polygon(points);
      end;
    end;

    aktr:=aktr+(r/(t-f));
    aktg:=aktg+(g/(t-f));
    aktb:=aktb+(b/(t-f));
  end;
end;
var
abschnitt:double;
lastc:tcolorref;
olddis:boolean;
begin
  olddis:=pagesdlg.disableupdate;
  loadedfile.free;
  loadedfile:=tbitmap.create;
  loadedfile.width:=picturewidth;
  loadedfile.height:=maxpictureheight;
  loadedfile.pixelformat:=pixelformat;
  clearbitmap(loadedfile,rgb(255,255,255));

  loadedfile.canvas.pen.style:=psclear;

  abschnitt:=0;
  if direction=0 then abschnitt:=(pictureheight-(60*bis))/(colors-1);
  if direction=1 then abschnitt:=(picturewidth)/(colors-1);
  if (direction=2)or(direction=3) then abschnitt:=((picturewidth div 2)+maxpictureheight)/(colors-1);
  assert(abschnitt<>0);  

  if colors=1 then flow(c1,c1,0,pictureheight);
  if colors>=2 then flow(c1,c2,abschnitt*0,abschnitt*1);
  if colors>=3 then flow(c2,c3,abschnitt*1,abschnitt*2);
  if colors>=4 then flow(c3,c4,abschnitt*2,abschnitt*3);
  if colors>=5 then flow(c4,c5,abschnitt*3,abschnitt*4);
  lastc:=c2;
  case colors of
    2: lastc:=c2;
    3: lastc:=c3;
    4: lastc:=c4;
    5: lastc:=c5;
  end;
  if (bis=1)and(direction=0)and(colors>1) then flow(lastc,lastc,pictureheight-60,pictureheight);
  if (direction in [0])then flow(lastc,lastc,pictureheight,maxpictureheight);

  pagesdlg.correctpos;
  pagesdlg.radiogroup7.itemindex:=1;
  pagesdlg.radiogroup8.itemindex:=1;
  pagesdlg.disableupdate:=false;
  cliptypchanged;
  pagesdlg.disableupdate:=olddis;
  pagesdlg.loadedfilename:='';
end;

procedure smalltextout;
begin
  csmalltextout(mask.canvas.handle,c.canvas.handle,x,y,pchar(text),c.canvas.pen.color);
end;

procedure loadpicture;
var
temp:tbitmap;
function loadbitmap:boolean;
begin
  result:=false;
  try
    temp.loadfromfile(filename);
  except
    on e:einvalidgraphic do exit;
  end;
  result:=true;
end;
function loadjpg:boolean;
var
jpg:tmyjpg;
begin
  result:=false;
  jpg:=tmyjpg.Create;
  try
    jpg.LoadFromFile(filename);
  except
    on e:einvalidgraphic do begin
      jpg.free;
      exit;
    end;
  end;
  temp.width:=jpg.width;
  temp.height:=jpg.height;
  jpg.drawto(temp.canvas);
  jpg.free;
  result:=true;
end;
function loadgif:boolean;
var
gif:tgifimage;
w,h:integer;
begin
  result:=false;
  gif:=tgifimage.Create(nil);

  if gif.LoadFromFile(filename)=false then
  begin
    gif.free;
    exit;
  end;
  w:=gif.bitmap.width;
  h:=gif.bitmap.height;
  temp.width:=w;
  temp.height:=h;
  temp.canvas.draw(0,0,gif.bitmap);

  gif.free;
  result:=true;
end;
var
a:array[0..128]of char;
begin
  if fileexists(filename)=false then exit;
  if (grosswort(extractfileext(filename))='.LNK')then
  begin
    getshelllinktarget(pchar(filename),a,sizeof(a));
    filename:=a;
  end;
  temp:=tbitmap.Create;
  if loadbitmap then
  begin
    loadedfile.free;
    loadedfile:=tbitmap.create;
    loadedfile.width:=temp.width;
    loadedfile.height:=temp.height;
    loadedfile.canvas.copyrect(rect(0,0,temp.width,temp.height),temp.canvas,rect(0,0,temp.width,temp.height));
    loadedfile.pixelformat:=pixelformat;
  end else
  begin
    if loadjpg=false then
      if loadgif=false then
    begin
      application.messagebox(pchar(loadstring(10)),pchar(l_title),mb_iconhand);
      exit;
    end;
    loadedfile.free;
    loadedfile:=temp;
  end;


  if autoconfig then
  begin
    fromx:=0;
    fromy:=0;
    if (loadedfile.width>picturewidth)and(loadedfile.height>pictureheight)then pagesdlg.cliptyp.itemindex:=0;
    if (loadedfile.width<picturewidth)or(loadedfile.height<pictureheight)then
    begin
      if (loadedfile.width<picturewidth div 4)and(loadedfile.height<pictureheight div 4)then pagesdlg.cliptyp.itemindex:=2 else
      pagesdlg.cliptyp.itemindex:=1;
    end;
    begin                           // Neuen Titel festlegen
{      s:=extractfilename(filename);
      if pos('.',s)>0 then s:=copy(s,1,pos('.',s)-1);
      s[1]:=upcase(s[1]);}
//      pagesdlg.edit1.text:=s+'-Amp';
    end;
    pagesdlg.radiogroup7.itemindex:=0;
    pagesdlg.radiogroup8.itemindex:=0;
    pagesdlg.edit6.text:='100';
    pagesdlg.edit7.text:='100';
    prozentx:=100;
    prozenty:=100;
    pagesdlg.correctpos;
  end;
{  saveskin.dir.text:=saveskin.skindir+pagesdlg.edit1.text;
  if saveskin.zipped.checked then saveskin.dir.text:=saveskin.dir.text+'.wsz';
}
//  loadedfile.pixelformat:=pixelformat;
//  originalpicture.pixelformat:=pixelformat;
  cliptypchanged;
  pagesdlg.loadedfilename:=filename;
end;


procedure titeltext;
var
tx,ty:integer;
label neu;
begin
  z.canvas.brush.style:=bsclear;
  z.canvas.font:=pagesdlg.fontdialog.font;

  neu:
  tx:=x1+((x2-x1-z.canvas.textwidth(text))div 2);
  ty:=y1+((y2-y1-z.canvas.textheight(text))div 2);


  if active then begin        { mit Schatten }
    if 1=1 then               { Falls Schatten sein soll }
    begin
      z.canvas.font.color:=rgb(64,64,64);
      z.canvas.textout(tx,ty,text);
      dec(tx,1);
      dec(ty);
    end;

    z.canvas.font.Color:=pagesdlg.fontdialog.font.color;
    z.canvas.TextOut(tx,ty,text);
  end else begin
    z.canvas.font.color:=rgb(128,128,128);
    z.canvas.TextOut(tx,ty,text);
  end;
end;

procedure copyfonts;
begin
  ccopyfonts(bitmaps.canvas.handle,dc,pagesdlg.colorfield2.color);
end;

procedure originalmask(dc:hdc;x,y,w,h,srcx,srcy:integer;orgx,orgy:integer;withmask:boolean);
begin
  getpicturepart(dc,x,y,orgx,orgy,w,h);
  if withmask then paintmask(dc,x,y,w,h,srcx,srcy);
end;

procedure originalbmp(dc:hdc;x,y,w,h,srcx,srcy:integer;orgx,orgy:integer;withbmp:boolean);
begin
  getpicturepart(dc,x,y,orgx,orgy,w,h);
  if withbmp then paintbmp(dc,x,y,w,h,srcx,srcy);
end;

procedure assignbitmapsfile;
begin
  bitmapsfile:=ExpandFileName(f);
  try
    bitmaps.LoadFromFile(f);
  except
    if fileexists(defaultbitmapsfile)then assignbitmapsfile(defaultbitmapsfile) else
    begin
      messagebox(0,pchar(defaultbitmapsfile),'Default Bitmaps file not found!',mb_ok);
      defaultbitmapsfile:=loadstringid(5);
    end;
  end;
end;

procedure assignmasksfile;
begin
  masksfile:=expandfilename(f);
  try
    mask.loadfromfile(f);
  except
    if fileexists(defaultmasksfile)then assignmasksfile(defaultmasksfile)
    else begin
      messagebox(0,pchar(defaultmasksfile),'Default Masks file not found!',mb_ok);
      defaultmasksfile:=loadstringid(4);
    end;
  end;
end;

procedure setdefault;
begin
end;

procedure lockbitmaps;
begin
  bitmaps.Canvas.lock;
  mask.canvas.lock;
  originalpicture.canvas.lock;
  loadedfile.canvas.lock;
end;

procedure unlockbitmaps;
begin
  loadedfile.canvas.unlock;
  originalpicture.canvas.unlock;
  mask.canvas.unlock;
  bitmaps.canvas.unlock;
end;

begin
  defaultmasksfile:=loadstringid(4);
  defaultbitmapsfile:=loadstringid(5);
  prozentx:=100;
  prozenty:=100;
end.
