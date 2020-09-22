unit wpl;
{$I cs.inc}

interface

uses windows,graphics,skinampc;

procedure getplbitmap(r:tbitmap;created,withcurrentsong:boolean);
procedure saveplbitmaps(verz:pchar);
function plursprung:integer;
function plbodenursprung:integer;

implementation

uses konstanten,bmps,main,pltext,funktionen,messages,forms,
  sascha,sysutils;


function plursprung:integer;
begin
  plursprung:=mainheight+eqheight;
end;

function plbodenursprung:integer;
begin
  plbodenursprung:=plursprung+20+(ploffset*(1-pagesdlg.radiogroup7.itemindex));
end;


procedure createpl(pl:tbitmap;display:boolean;created:boolean);
var
dc:hdc;
procedure drawmainbar(x,y:integer;active:boolean);
var
s:string;
procedure drawrippe(y,h:integer);
begin
  linev(dc,x+24,y+1,x+24,y+h-1,false);

  linev(dc,x+26,y+1,x+26,y+h-1,true);
  linev(dc,x+125,y+1,x+125,y+h-1,false);
  lineh(dc,x+127,y,x+151,y,false);
  lineh(dc,x+127,y+h,x+151,y+h,true);

  linev(dc,x+153,y+1,x+153,y+h-1,true);

  with pl.canvas do
  begin
    pen.style:=psclear;
    brush.style:=bssolid;
    brush.color:=rgb(0,0,0);
    rectangle(x+127,y+1,x+153,y+h+1);
  end;
end;
const
k1y=2;
k2y=10;
kh=7;
begin
  getpicturepart(dc,x+0,y,0,plursprung,25,20);
  if (pagesdlg.radiogroup2.itemindex<>0)and(created) then linev(dc,x,y,x,y+19,pagesdlg.radiogroup6.itemindex=0);
  getpicturepart(dc,x+26,y,87,plursprung,100,20);
  if created then begin
    s:=pagesdlg.edit3.text;

    titeltext(pl,x+25,y,x+125,y+14,s,active);
  end;
  getpicturepart(dc,x+127,y,50,plursprung,25,20);

  getpicturepart(dc,x+153,y,plwidth-25,plursprung,25,20);
  if created then
  begin
    if (pagesdlg.checkbox12.checked)then
    begin
      drawrippe(y+k1y,kh);
      drawrippe(y+k2y,kh);
    end;
    if pagesdlg.checkbox6.checked then
    begin
      paintmask(dc,x+158,y+3,9,9,18,0);
      paintmask(dc,x+167,y+3,9,9,27,0);
    end;
    if pagesdlg.radiogroup2.itemindex<>0 then linev(dc,x+177,y,x,y+19,pagesdlg.radiogroup6.itemindex=1);
    if pagesdlg.radiogroup2.itemindex=1 then
    begin
      lineh(dc,x,y,x+24,y,pagesdlg.radiogroup6.itemindex=0);
      lineh(dc,x+26,y,x+126,y,pagesdlg.radiogroup6.itemindex=0);
      lineh(dc,x+127,y,x+152,y,pagesdlg.radiogroup6.itemindex=0);
      lineh(dc,x+153,y,x+177,y,pagesdlg.radiogroup6.itemindex=0);
    end;
    if pagesdlg.ploptions.checked[1] then lineh(dc,x+162,y+19,x+171,y+19,false); // Scrollleiste
    if (pagesdlg.checkbox5.checked)and(pagesdlg.checkbox12.checked=false) then
    begin
      lineh(dc,x,y+13,x+24,y+13,pagesdlg.radiogroup6.itemindex=1);
      lineh(dc,x,y+14,x+24,y+14,pagesdlg.radiogroup6.itemindex=0);

      lineh(dc,x+26,y+13,x+125,y+13,pagesdlg.radiogroup6.itemindex=1);
      lineh(dc,x+26,y+14,x+125,y+14,pagesdlg.radiogroup6.itemindex=0);

      lineh(dc,x+127,y+13,x+151,y+13,pagesdlg.radiogroup6.itemindex=1);
      lineh(dc,x+127,y+14,x+151,y+14,pagesdlg.radiogroup6.itemindex=0);

      lineh(dc,x+153,y+13,x+177,y+13,pagesdlg.radiogroup6.itemindex=1);
      lineh(dc,x+153,y+14,x+177,y+14,pagesdlg.radiogroup6.itemindex=0);
    end;
    if (pagesdlg.checkbox5.checked)and(pagesdlg.checkbox12.checked)then
    begin { Lappen bei Titel }
      linev(dc,x+30,y,x+30,y+14,false);
      linev(dc,x+31,y,x+31,y+13,true);

      lineh(dc,x+31,y+13,x+120,y+13,false);
      lineh(dc,x+30,y+14,x+121,y+14,true);

      linev(dc,x+120,y,x+120,y+13,false);
      linev(dc,x+121,y,x+121,y+14,true);
    end;
    begin                                 { Innenrahmen }
      lineh(dc,x+9,y+19,x+24,y+19,false);
      lineh(dc,x+26,y+19,x+125,y+19,false);
      lineh(dc,x+127,y+19,x+151,y+19,false);
      lineh(dc,x+153,y+19,x+162,y+19,false);
    end;
  end;
end;
procedure drawsmallbar(x,y:integer);
procedure ende(x,y:integer);
begin
  getpicturepart(dc,x,y,0,plursprung,50,14);
  rahmen(dc,x,y+2,22,10,false,pagesdlg.colorfield3.color);
  paintbmp(dc,x+22,y+4,7,7,190,20);
  paintmask(dc,x+30,y+3,9,9,36,0);
  paintmask(dc,x+39,y+3,9,9,27,0);
  lineh(dc,x,y,x+49,y,pagesdlg.radiogroup6.itemindex=0);
  linev(dc,x+49,y,x+49,y+13,pagesdlg.radiogroup6.itemindex=1);
  lineh(dc,x,y+13,x+49,y+13,pagesdlg.radiogroup6.itemindex=1);
end;
begin
  getpicturepart(dc,x,y,0,plursprung,25,14);
  rahmen(dc,x+2,y+2,23,10,false,pagesdlg.colorfield3.color);
  lineh(dc,x,y,x+24,y,pagesdlg.radiogroup6.itemindex=0);
  linev(dc,x,y,x,y+13,pagesdlg.radiogroup6.itemindex=0);
  lineh(dc,x,y+13,x+24,y+13,pagesdlg.radiogroup6.itemindex=1);

  getpicturepart(dc,x,y+15,0,plursprung,25,14);
  rahmen(dc,x,y+15+2,25,10,false,pagesdlg.colorfield3.color);
  lineh(dc,x,y+15,x+24,y+15,pagesdlg.radiogroup6.itemindex=0);
  lineh(dc,x,y+28,x+24,y+28,pagesdlg.radiogroup6.itemindex=1);

  ende(x+27,y);
  ende(x+27,y+15);

  originalmask(dc,x+78,y,9,9,36,9,155,plursprung+3,true);
end;
procedure seiten;
procedure copyline(fx,fy,fx2:integer;tx,ty:integer);
var
i:integer;
begin
  for i:=fx to fx2 do setpixel(pl.canvas.handle,tx+i-fx,ty,getpixel(pl.canvas.handle,i,fy));
end;
var
i:integer;
begin
  getpicturepart(dc,0,42,0,plursprung+20,25,15);
  for i:=0 to 14 do copyline(0,42+14-i,25,0,42+14+i);
  rahmen(dc,10,42,15,29,false,pagesdlg.textr.pl[3]);
  if (pagesdlg.radiogroup2.itemindex<>0)and(created) then linev(dc,0,42,0,42+28,pagesdlg.radiogroup6.itemindex=0);

  getpicturepart(dc,26,42,mainwidth-25,plursprung+20,25,15);
  for i:=0 to 14 do copyline(26,42+14-i,50,26,42+14+i);
  rahmen(dc,26,42,9,29,false,pagesdlg.textr.pl[3]);
  originalbmp(dc,52,53,8,18,200,20,260,plursprung+21,created);  // Scrollbuttons
  originalbmp(dc,61,53,8,18,209,20,260,plursprung+21,created);  // Scrollbuttons
  if created then
  begin
    if pagesdlg.radiogroup2.itemindex<>0 then linev(dc,50,42,50,42+28,pagesdlg.radiogroup6.itemindex=1);
    if pagesdlg.ploptions.checked[1] then
    begin
      linev(dc,36,42,36,42+28,false);
      linev(dc,44,42,44,42+28,true);
    end;
    begin                                  { Innenrahmen }
      linev(dc,9,42,9,70,false);
      linev(dc,35,42,35,70,true);
    end;
  end;
end;
procedure unten;
begin
  getpicturepart(dc,0,72,0,plbodenursprung,125,38);
  if (pagesdlg.radiogroup2.itemindex<>0)and(created) then
  begin
    linev(dc,0,72,0,72+37,pagesdlg.radiogroup6.itemindex=0);
    lineh(dc,0,72+37,124,72+37,pagesdlg.radiogroup6.itemindex=1);
  end;

  if display=false then
  begin
    getpicturepart(dc,179,0,125,plbodenursprung,25,38);
    if pagesdlg.radiogroup2.itemindex<>0 then lineh(dc,179,37,179+24,37,pagesdlg.radiogroup6.itemindex=1);
  end;

  if display=false then
  begin
    getpicturepart(dc,205,0,150,plbodenursprung,75,38);
    if pagesdlg.radiogroup2.itemindex<>0 then lineh(dc,205,37,205+74,37,pagesdlg.radiogroup6.itemindex=1);
    rahmen(dc,205,6,75,27,true,0);         // Black Box
  end;

  getpicturepart(dc,126,72,125,plbodenursprung,150,38);
  if created then
  begin
    if pagesdlg.ploptions.checked[1] then lineh(dc,260,72,269,72,true);   // Scrollleiste
    if pagesdlg.radiogroup2.itemindex<>0 then
    begin
      linev(dc,126+149,72,126+149,72+37,pagesdlg.radiogroup6.itemindex=1);
      lineh(dc,126,72+37,126+149,72+37,pagesdlg.radiogroup6.itemindex=1);
    end;
    begin                          { Innenrahmen }
      lineh(dc,9,72,124,72,true);
      lineh(dc,126,72,259,72,true);
      lineh(dc,179,0,203,0,true);
      lineh(dc,205,0,279,0,true);
    end;


    if pagesdlg.ploptions.checked[3] then paintmask(dc,259,93,14,14,25,160);    // Ecke
    if pagesdlg.ploptions.checked[0] then paintbmp(dc,132,95,54,7,0,180);       // Spiel-Knöppe
    if pagesdlg.ploptions.checked[2] then paintbmp(dc,261,74,8,10,0,189);       // Hoch / runter
    case pagesdlg.radiogroup3.itemindex of
      1:begin
        paintbmp(dc,11,80,112,18,150,200);    // Buttonsl
        paintbmp(dc,229,80,25,18,266,200);    // Buttonsr
      end;
      2:begin
        paintmask(dc,11,80,112,18,100,150);    // Buttonsl
        paintmask(dc,229,80,25,18,216,150);    // Buttonsr
      end;
    end;
    if display=false then paintbmp(dc,0,111,255,75,150,100);    // Alle Knöppe
    begin                                 // Weitere Black Boxes
      rahmen(dc,130,79,94,12,true,pagesdlg.colorfield3.color);          // Gesamte Zeit
      rahmen(dc,188,93,36,10,true,pagesdlg.colorfield3.color);          // Liedzeit
      setpixel(pl.canvas.handle,209,96,pagesdlg.colorfield2.color);
      setpixel(pl.canvas.handle,210,96,pagesdlg.colorfield2.color);
      setpixel(pl.canvas.handle,209,98,pagesdlg.colorfield2.color);
      setpixel(pl.canvas.handle,210,98,pagesdlg.colorfield2.color);
    end;
  end;
end;
begin
  { Bild erzeugen }
  pl.canvas.lock;
  dc:=pl.canvas.handle;
  clearbitmap(pl,rgb(255,255,255));
  begin           // Titelleiste
    if display=false then drawmainbar(0,0,true);
    drawmainbar(0,21,false);
    if created then
    begin
      originalmask(dc,52,42,9,9,27,9,130,plursprung+3,true);
      originalmask(dc,62,42,9,9,18,9,130,plursprung+3,true);
      if display=false then drawsmallbar(72,42);
    end;
  end;
  seiten;
  unten;
  pl.canvas.unlock;
end;

procedure getplbitmap;
var
temp,pl:tbitmap;

procedure sortfordisplay;
procedure copypart(x,y,w,h:integer;tx,ty:integer);
begin
  bitblt(temp.canvas.handle,tx,ty,w,h,pl.canvas.handle,x,y,srccopy);
end;
procedure textinpl;
procedure text(y:integer;typ:byte;title,nr,length:string);
begin
  with temp.canvas do
  begin
    case typ of
      1:font.color:=pagesdlg.textr.pl[1];
      2:font.color:=pagesdlg.textr.pl[2];
      3:begin
        font.color:=pagesdlg.textr.pl[1];
        brush.color:=pagesdlg.textr.pl[4];
        rectangle(12,y,257,y+14);
      end;
    end;
    brush.style:=bsclear;
    textout(13,y,nr);
    textout(16+textwidth(nr),y,title);
    textout(255-textwidth(length),y,length);
  end;
end;
var
winamp:thandle;
function getcurrenttitle:string;
var
a:array[0..200]of char;
s:string;
begin
  result:='Current';
  if (winamp=0)or(withcurrentsong=false) then exit;

  getwindowtext(winamp,a,200);
  if grosswort(copy(a,1,length('Winamp')))='WINAMP' then exit;
  s:=copy(a,pos(' ',a),pos('- Winamp',a)-pos(' ',a));
  s:=trim(s);

  with temp.canvas do if textwidth(s)>190 then 
  begin
    while textwidth(s)>183 do s:=copy(s,1,length(s)-1);
    s:=s+'...';
  end;

  result:=s;
end;
function timestring(t:integer):string;
var
s:string;
begin
  s:=str(t mod 60);
  while length(s)<2 do s:='0'+s;  
  result:=str(t div 60)+':'+s;
end;
var
anfang:byte;
time:integer;
begin
  with temp.canvas do
  begin
    pen.style:=psclear;
    brush.color:=pagesdlg.textr.pl[3];
    brush.style:=bssolid;
    rectangle(12,20,plwidth-19,79);

    font.style:=[];
    font.height:=-10;
    font.color:=pagesdlg.textr.pl[1];
    font.name:=pagesdlg.textr.font;

    anfang:=1;
    winamp:=0;
    winamp:=findwindow(wclass,nil);
    if winamp<>0 then
    begin
      anfang:=sendmessage(winamp,wm_user,0,125);
      time:=sendmessage(winamp,wm_user,1,105);
    end else time:=119;
    if anfang<>0 then
    begin
      text(22,1,'Normal',str(anfang)+'.','3:14');
      text(35,2,getcurrenttitle,str(anfang+1)+'.',timestring(time));
      text(48,3,'Selected',str(anfang+2)+'.','2:65');
      text(61,1,'Normal',str(anfang+3)+'.','3:58');
    end else
    begin
      text(22,2,getcurrenttitle,str(anfang+1)+'.',timestring(time));
      text(35,1,'Normal',str(anfang+2)+'.','3:38');
      text(48,3,'Selected',str(anfang+3)+'.','3:07');
      text(61,1,'Normal',str(anfang+4)+'.','2:56');
    end;
{    pen.color:=pagesdlg.colorfield2.color;
    smalltextout(temp,133,88,'3:07/'+timestring(time+581));
    smalltextout(temp,200,101,'00:01');}
  end;
end;
begin
  temp.canvas.pen.color:=rgb(0,0,0);
  temp.canvas.brush.color:=pagesdlg.textr.pl[3];
  temp.canvas.rectangle(0,0,plwidth,plheight);
  begin                                    // Titelleiste
    copypart(0,21,25,20,0,0);
    copypart(127,21,25,20,25,0);
    copypart(127,21,25,20,50,0);
    copypart(127,21,25,20,75,0);
    copypart(127,21,25,20,100,0);
    copypart(127,21,25,20,125,0);
    copypart(127,21,25,20,150,0);
    copypart(127,21,25,20,175,0);
    copypart(127,21,25,20,200,0);
    copypart(127,21,25,20,225,0);
    copypart(153,21,25,20,250,0);
    copypart(26,21,100,20,87,0);
  end;
  begin                                    // Seite
    copypart(0,42,25,29,0,20);
    copypart(0,42,25,29,0,49);
    copypart(26,42,25,29,250,20);
    copypart(26,42,25,29,250,49);
    copypart(52,53,8,18,260,21);           // Thumb
  end;
  begin                                    // Unten
    copypart(0,72,125,38,0,78);
    copypart(126,72,150,38,125,78);
  end;
  if created then textinpl;
end;

begin
  r.width:=plwidth;
  r.height:=plheight;
  pl:=tbitmap.create;
  pl.width:=plpicturewidth+1;
  pl.height:=plpictureheight;
  pl.canvas.lock;
  getoriginalpicture(pl,mainheight+eqheight,plheight);

  createpl(pl,true,created);

  temp:=tbitmap.create;
  temp.width:=plwidth;
  temp.height:=plheight;
  temp.canvas.lock;

  sortfordisplay;

  r.canvas.draw(0,0,temp);
  temp.canvas.unlock;
  temp.free;
  pl.canvas.unlock;
  pl.free;
end;

procedure saveplbitmaps;
var
pl:tbitmap;
begin
  pl:=tbitmap.create;
  pl.width:=plpicturewidth;
  pl.height:=plpictureheight;
  pl.pixelformat:=pixelformat;
  createpl(pl,false,true);
  pagesdlg.stepit;
  pl.savetofile(verz+'pledit.bmp');
  pl.free;
end;

end.

