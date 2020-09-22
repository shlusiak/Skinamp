unit wavs;
{$I cs.inc}

interface

uses windows,graphics,skinampc;

procedure getavsbitmap(r:tbitmap;created:boolean);
procedure saveavsbitmaps(verz:pchar);

implementation

uses konstanten,bmps,main,classes;



procedure createavs(avs:tbitmap;display:boolean;created:boolean);
var
temp:tbitmap;
src,dest:trect;
dc:hdc;
procedure obenunten;
var
s:string;
begin
  originalmask(dc,0,0,9,9,27,9,275-12,3,pagesdlg.checkbox10.checked);

  getpicturepart(dc,15,0,0,0,50,15);

  if created then begin
    s:=pagesdlg.edit5.text;

//    avs.canvas.TextOut(18,0,s);
    titeltext(avs,15,0,64,13,s,true);
  end;

  getpicturepart(dc,15,16,0,maxheight-6,50,5);
  begin
    clearbitmap(temp,rgb(255,255,255));
    getpicturepart(temp.canvas.handle,0,0,50,0,avswidth-50-16,15);
    getpicturepart(temp.canvas.handle,0,16,50,maxheight-6,avswidth-50-16,5);

    src.left:=0;
    src.top:=0;
    src.right:=avswidth-51;
    src.bottom:=21;

    dest.left:=66;
    dest.top:=0;
    dest.right:=66+14;
    dest.bottom:=21;

    avs.canvas.copyrect(dest,temp.canvas,src);
  end;
  getpicturepart(dc,81,0,avswidth-16,0,16,15);
  if (pagesdlg.checkbox10.checked)and(created) then paintmask(dc,86,2,9,9,27,0);
  getpicturepart(dc,81,16,avswidth-16,pictureheight-5,16,5);
end;
procedure seiten;
begin
  clearbitmap(temp,rgb(255,255,255));
  getpicturepart(temp.canvas.handle,0,0,0,0,7,maxheight);
  getpicturepart(temp.canvas.handle,8,0,avswidth-7,0,6,maxheight);

  src.left:=0;
  src.top:=0;
  src.right:=15;
  src.bottom:=maxheight;

  dest.left:=0;
  dest.top:=16;
  dest.right:=15;
  dest.bottom:=188;

  SetStretchBltMode(avs.canvas.handle,coloroncolor);
  avs.canvas.copyrect(dest,temp.canvas,src);
end;
procedure rand;
begin
  dc:=avs.canvas.handle;
  lineh(dc,15,0,64,0,pagesdlg.radiogroup6.itemindex=0);
  lineh(dc,66,0,79,0,pagesdlg.radiogroup6.itemindex=0);
  lineh(dc,81,0,96,0,pagesdlg.radiogroup6.itemindex=0);

  lineh(dc,15,20,64,20,pagesdlg.radiogroup6.itemindex=1);
  lineh(dc,66,20,79,20,pagesdlg.radiogroup6.itemindex=1);
  lineh(dc,81,20,96,20,pagesdlg.radiogroup6.itemindex=1);

  if pagesdlg.CheckBox9.checked then
  begin
    lineh(dc,15,12,64,12,pagesdlg.radiogroup6.itemindex=1);
    lineh(dc,66,12,79,12,pagesdlg.radiogroup6.itemindex=1);
    lineh(dc,81,12,96,12,pagesdlg.radiogroup6.itemindex=1);

    lineh(dc,15,13,64,13,pagesdlg.radiogroup6.itemindex=0);
    lineh(dc,66,13,79,13,pagesdlg.radiogroup6.itemindex=0);
    lineh(dc,81,13,96,13,pagesdlg.radiogroup6.itemindex=0);
  end;

  linev(dc,15,0,15,14,pagesdlg.radiogroup6.itemindex=0);
  linev(dc,15,15,15,20,pagesdlg.radiogroup6.itemindex=0);
  linev(dc,96,0,96,14,pagesdlg.radiogroup6.itemindex=1);
  linev(dc,96,16,96,20,pagesdlg.radiogroup6.itemindex=1);

  linev(dc,0,16,0,187,pagesdlg.radiogroup6.itemindex=0);
  linev(dc,13,16,13,187,pagesdlg.radiogroup6.itemindex=1);

  begin                // Innerer Rand
    lineh(dc,21,14,64,14,false);
    lineh(dc,66,14,79,14,false);
    lineh(dc,81,14,90,14,false);

    lineh(dc,21,16,64,16,true);
    lineh(dc,66,16,79,16,true);
    lineh(dc,81,16,90,16,true);

    linev(dc,6,16,6,187,false);
    linev(dc,8,16,8,187,true);
  end;                         
end;
procedure werbung;
var
b:array[0..100]of char;
begin
  with avs.canvas do
  begin
    font.height:=12;
    font.style:=[];
    font.color:=rgb(64,180,214);
    brush.color:=rgb(255,255,255);
    font.name:='Arial';

    getdateformat(0,0,nil,'dd MMM, yyyy',b,100);

    textout(18,30,'This skin was');
    textout(18,42,'made with');
    textout(18,85,'('+b+')');

    font.height:=14;
    font.style:=[fsbold];
    textout(18,60,'SkinAmp.');
  end;
end;
begin
  avs.canvas.lock;
  dc:=avs.canvas.handle;
  temp:=tbitmap.create;
//  temp.pixelformat:=pixelformat;
  temp.width:=avswidth;
  temp.height:=maxheight;
  temp.canvas.lock;
  clearbitmap(avs,rgb(255,255,255));

  obenunten;
  seiten;
  if created then rand;
  if (created)and(display=false)and(konstanten.werbung)then werbung;
  temp.canvas.unlock;
  temp.free;
  avs.canvas.unlock;
end;

procedure getavsbitmap;
var
temp,avs:tbitmap;
procedure sortfordisplay;
procedure copypart(x,y,w,h:integer;tx,ty,tw,th:integer);
var
src,dest:trect;
begin
  src.left:=x;
  src.top:=y;
  src.right:=x+w;
  src.bottom:=y+h;
  dest.left:=tx;
  dest.top:=ty;
  dest.right:=tx+tw;
  dest.bottom:=ty+th;
  temp.canvas.copyrect(dest,avs.canvas,src);
end;
begin
  with temp.canvas do
  begin
    brush.color:=rgb(0,0,0);
    brush.style:=bssolid;
    pen.style:=psclear;
    rectangle(0,0,avswidth+1,avsheight+1);
  end;

  copypart(15,0,50,15,0,0,50,15);
  copypart(66,0,14,15,50,0,avswidth-50-16,15);
  copypart(81,0,16,15,avswidth-16,0,16,15);

  copypart(0,16,7,172,0,15,7,avsheight-5-15);
  copypart(8,16,6,172,avswidth-6,15,6,avsheight-5-15);

  copypart(15,16,50,5,0,avsheight-5,50,5);
  copypart(66,16,14,5,50,avsheight-5,avswidth-50-6,5);
  copypart(81,16,16,5,avswidth-16,avsheight-5,16,5);
end;
begin
  r.width:=avswidth;
  r.height:=avsheight;

  temp:=tbitmap.create;
  temp.width:=avswidth;
  temp.height:=avsheight;
  avs:=tbitmap.create;
  avs.width:=avswidth;
  avs.height:=avsheight;

  createavs(avs,false,created);

  sortfordisplay;

  r.canvas.draw(0,0,temp);
  avs.free;
  temp.free;
end;

procedure saveavsbitmaps;
var
temp:tbitmap;
begin
  temp:=tbitmap.create;
  temp.width:=avspicturewidth;
  temp.height:=avspictureheight;
  temp.pixelformat:=pixelformat;
  temp.canvas.lock;
  createavs(temp,false,true);
  temp.savetofile(verz+'avs.bmp');
  pagesdlg.stepit;
  temp.canvas.unlock;
  temp.free;
end;


end.
