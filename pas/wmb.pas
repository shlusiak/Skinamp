unit wmb;
{$I cs.inc}

interface

uses windows,graphics,skinampc,funktionen;

procedure getmbbitmap(r:tbitmap;created:boolean);
procedure savembbitmaps(verz:pchar);
function mbursprung:integer;
function mbbodenursprung:integer;

implementation

uses konstanten,bmps,main,wpl,mbtext,pltext;


function mbursprung;
begin
  mbursprung:=plbodenursprung+39;
end;

function mbbodenursprung;
var
r:integer;
begin
  r:=mbursprung+20-1+(mboffset*(1-pagesdlg.radiogroup8.itemindex));
  result:=r;
end;


procedure createmb(mb:tbitmap;display:boolean;created:boolean);
var
dc:hdc;
procedure drawmainbar(ziel:tbitmap;x,y:integer;active:boolean);
procedure drawrippe(y,h:integer);
begin
  linev(dc,x+24,y+1,x+24,y+h-1,false);

  linev(dc,x+26,y+1,x+26,y+h-1,true);
  linev(dc,x+125,y+1,x+125,y+h-1,false);
  lineh(dc,x+127,y,x+151,y,false);
  lineh(dc,x+127,y+h,x+151,y+h,true);

  linev(dc,x+153,y+1,x+153,y+h-1,true);

  with mb.canvas do
  begin
    pen.style:=psclear;
    brush.style:=bssolid;
    brush.color:=rgb(0,0,0);
    rectangle(x+127,y+1,x+153,y+h+1);
  end;
end;

var
s:String;
const
ky1=2;
ky2=10;
kh=7;
begin
  getpicturepart(dc,x,y,0,mbursprung,25,20);

  getpicturepart(dc,x+26,y,87,mbursprung,100,20);

  getpicturepart(dc,x+127,y,175,mbursprung,25,20);

  getpicturepart(dc,x+153,y,250,mbursprung,25,20);

  if created then
  begin
    if pagesdlg.checkbox13.checked then
    begin
      drawrippe(y+ky1,kh);
      drawrippe(y+ky2,kh);
    end;
    s:=pagesdlg.edit4.text;

    titeltext(mb,x+27,y,x+27+100,y+14,s,active);

    if pagesdlg.checkbox8.checked then
    begin
      paintmask(dc,x+167,y+3,9,9,27,0);
    end;
    if pagesdlg.radiogroup2.itemindex<>0 then
    begin
      linev(dc,x,y,x,y+19,pagesdlg.radiogroup6.itemindex=0);
      linev(dc,x+177,y,x,y+19,pagesdlg.radiogroup6.itemindex=1);
      lineh(dc,x,y,x+24,y,pagesdlg.radiogroup6.itemindex=0);
      lineh(dc,x+26,y,x+126,y,pagesdlg.radiogroup6.itemindex=0);
      lineh(dc,x+127,y,x+152,y,pagesdlg.radiogroup6.itemindex=0);
      lineh(dc,x+153,y,x+177,y,pagesdlg.radiogroup6.itemindex=0);
    end;
    if pagesdlg.checkbox7.checked then
    begin
      if pagesdlg.checkbox13.checked=false then
      begin
        lineh(dc,x,y+13,x+24,y+13,pagesdlg.radiogroup6.itemindex=1);
        lineh(dc,x,y+14,x+24,y+14,pagesdlg.radiogroup6.itemindex=0);

        lineh(dc,x+26,y+13,x+125,y+13,pagesdlg.radiogroup6.itemindex=1);
        lineh(dc,x+26,y+14,x+125,y+14,pagesdlg.radiogroup6.itemindex=0);

        lineh(dc,x+127,y+13,x+151,y+13,pagesdlg.radiogroup6.itemindex=1);
        lineh(dc,x+127,y+14,x+151,y+14,pagesdlg.radiogroup6.itemindex=0);

        lineh(dc,x+153,y+13,x+177,y+13,pagesdlg.radiogroup6.itemindex=1);
        lineh(dc,x+153,y+14,x+177,y+14,pagesdlg.radiogroup6.itemindex=0);
      end else
      begin
        linev(dc,x+30,y,x+30,y+14,false);
        linev(dc,x+31,y,x+31,y+13,true);

        lineh(dc,x+31,y+13,x+120,y+13,false);
        lineh(dc,x+30,y+14,x+121,y+14,true);

        linev(dc,x+120,y,x+120,y+13,false);
        linev(dc,x+121,y,x+121,y+14,true);
      end;
    end;

    begin                         // Innenrahmen
      lineh(dc,x+10,y+19,x+24,y+19,false);
      lineh(dc,x+26,y+19,x+125,y+19,false);
      lineh(dc,x+127,y+19,x+151,y+19,false);
      lineh(dc,x+153,y+19,x+170,y+19,false);
    end;
  end;
end;
procedure seiten;
procedure copyline(fx,fy,fx2:integer;tx,ty:integer);
var
i:integer;
begin
  for i:=fx to fx2 do setpixel(mb.canvas.handle,tx+i-fx,ty,getpixel(mb.canvas.handle,i,fy));
end;
var
i:integer;
begin
  getpicturepart(dc,127,42,0,mbursprung+20,11,15);
  for i:=0 to 14 do copyline(127,42+14-i,127+11,127,42+14+i);
  if (pagesdlg.radiogroup2.itemindex<>0)and(created) then linev(dc,127,42,127,42+28,pagesdlg.radiogroup6.itemindex=0);

  getpicturepart(dc,139,42,mainwidth-8,mbursprung+20,8,29);
  for i:=0 to 14 do copyline(139,42+14-i,139+7,139,42+14+i);
  if (pagesdlg.radiogroup2.itemindex<>0)and(created) then linev(dc,146,42,146,42+28,pagesdlg.radiogroup6.itemindex=1);

  if created then                         { Innenrand }      
  begin
    linev(dc,137,42,137,70,false);
    linev(dc,139,42,139,70,true);
  end;
end;
procedure unten;
begin
  { Links }
  getpicturepart(dc,0,42,0,mbbodenursprung,125,38);
  if (pagesdlg.radiogroup2.itemindex<>0)and(created) then
  begin
    linev(dc,0,42,0,42+37,pagesdlg.radiogroup6.itemindex=0);
    lineh(dc,0,42+37,124,42+37,pagesdlg.radiogroup6.itemindex=1);
  end;

  if created then
  begin
    case pagesdlg.radiogroup4.itemindex of
      0:getpicturepart(dc,158,42,8,mbbodenursprung+9,75,18);
      1:begin
        paintbmp(dc,8,50,75,18,60,155);
        if display=false then originalbmp(dc,158,42,75,18,60+1,155+19,8,mbbodenursprung+9,pagesdlg.radiogroup6.itemindex=0);
      end;
      2:begin
        paintmask(dc,8,50,75,18,150,0);
        if display=false then originalmask(dc,158,42,75,18,151,19,8,mbbodenursprung+9,pagesdlg.radiogroup6.itemindex=0);
      end;
    end;
    if pagesdlg.mboptions.checked[1] then
    begin
      rahmen(dc,92,53,33,13,false,rgb(0,0,0));
      linev(dc,91,52,92,66,false);
      lineh(dc,91,52,91+33,52,false);
      lineh(dc,91,66,91+33,66,true);
    end;
  end;

  { Mitte }
  getpicturepart(dc,127,81,125,mbbodenursprung,25,38);
  if (pagesdlg.radiogroup2.itemindex<>0)and(created) then
    lineh(dc,127,118,151,118,pagesdlg.radiogroup6.itemindex=1);
  if created then
  begin
    if pagesdlg.mboptions.checked[1] then
    begin
      rahmen(dc,127,92,25,13,false,rgb(0,0,0));
      lineh(dc,127,91,127+24,91,false);
      lineh(dc,127,105,127+24,105,true);
    end;
  end;

  { Rechts }
  getpicturepart(dc,0,81,150,mbbodenursprung,125,38);
  if (pagesdlg.radiogroup2.itemindex<>0)and(created) then
  begin
    linev(dc,124,42+39,124,42+39+37,pagesdlg.radiogroup6.itemindex=1);
    lineh(dc,0,42+39+37,124,42+39+37,pagesdlg.radiogroup6.itemindex=1);

    if pagesdlg.mboptions.checked[1] then
    begin
      rahmen(dc,0,92,100,13,false,rgb(0,0,0));
      linev(dc,100,91,100,105,true);
      lineh(dc,0,91,100,91,false);
      lineh(dc,0,105,100,105,true);
    end;
  end;
  if (created)and(pagesdlg.mboptions.checked[0]) then paintmask(dc,109,103,14,14,25,160);

  if created then
  begin                             { Innenrahmen }             
    lineh(dc,11,42,124,42,true);
    lineh(dc,0,81,117,81,true);
    lineh(dc,127,81,151,81,true);
  end;
end;

begin
  mb.canvas.lock;
  dc:=mb.canvas.handle;
  clearbitmap(mb,rgb(255,255,255));
  if display=false then drawmainbar(mb,0,0,true);
  drawmainbar(mb,0,21,false);
  if (created)and(display=false)then originalmask(dc,148,42,9,9,27,9,265,mbursprung+3,pagesdlg.checkbox8.checked);
  seiten;
  unten;
  mb.canvas.unlock;
end;

procedure getmbbitmap;
var
temp:tbitmap;
mb:tbitmap;
procedure sortfordisplay;
procedure copypart(x,y,w,h:integer;tx,ty:integer);
begin
  bitblt(temp.canvas.handle,tx,ty,w,h,mb.canvas.handle,x,y,srccopy);
end;
var
s:string;
begin
  with temp.canvas do
  begin
    brush.color:=rgb(0,0,0);
    brush.style:=bssolid;
    pen.style:=psclear;
    rectangle(0,0,mbwidth+1,mbheight+1);
  end;
  
  copypart(0,21,25,20,0,0);
  copypart(127,21,25,20,25,0);
  copypart(127,21,25,20,50,0);
  copypart(127,21,25,20,75,0);
  copypart(127,21,25,20,175,0);
  copypart(127,21,25,20,200,0);
  copypart(127,21,25,20,225,0);
  copypart(153,21,25,20,250,0);
  copypart(26,21,100,20,87,0);

  copypart(127,42,11,29,0,20);
  copypart(127,42,11,29,0,49);
  copypart(127,42,11,29,0,78);

  copypart(139,42,8,29,267,20);
  copypart(139,42,8,29,267,49);
  copypart(139,42,8,29,267,78);

  copypart(0,42,125,38,0,107);
  copypart(127,81,25,38,125,107);
  copypart(0,81,125,38,150,107);

  if created then with temp.canvas do 
  begin      { Adresse }
    pen.style:=psclear;
    brush.color:=pagesdlg.textr.mb[1];
    brush.style:=bssolid;
    rectangle(92,118,251,132);
    brush.style:=bsclear;
    font.color:=pagesdlg.textr.mb[2];
    font.name:=pagesdlg.textr.font;
    font.size:=7;
    s:=pagesdlg.edit8.text;
    if s='' then s:=loadstringid(17);
    while textwidth(s)>250-93 do s:=copy(s,1,length(s)-1);

    textout(93,119,s);
  end;
end;
begin
  r.width:=mbwidth;
  r.height:=mbheight;

  temp:=tbitmap.create;
  temp.width:=mbwidth;
  temp.height:=mbheight;
  mb:=tbitmap.create;
  mb.width:=mbwidth;
  mb.height:=mbheight;

  createmb(mb,false,created);

  sortfordisplay;

  r.canvas.draw(0,0,temp);
  mb.free;
  temp.free;
end;

procedure savembbitmaps;
var
mb:tbitmap;
begin
  mb:=tbitmap.create;
  mb.pixelformat:=pixelformat;
  mb.width:=mbpicturewidth;
  mb.height:=mbpictureheight;
  createmb(mb,false,true);
  pagesdlg.stepit;
  mb.savetofile(verz+'mb.bmp');
  mb.free;
  if pagesdlg.edit8.text<>'' then
  begin
    writeprivateprofilestring('Winamp','MBOpen',pchar(pagesdlg.edit8.text),pchar(verz+'mb.ini'));
  end;
end;


end.
