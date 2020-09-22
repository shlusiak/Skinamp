unit weq;
{$I cs.inc}

interface

uses windows,graphics,skinampc;

procedure initeqbitmaps;
procedure geteqbitmap(r:tbitmap;created:boolean);
procedure saveeqbitmaps(verz:pchar);
procedure drawmainbar(z:tbitmap;x,y:integer;typ:byte);

var
eqbezier:array[1..19]of tcolorref;
eqbar:array[0..27]of tcolorref;

implementation

uses konstanten,bmps,main,classes;

{var
eq:tbitmap;}

procedure initeqbitmaps;
procedure createeqflow;
procedure cb1(i:integer;c:tcolorref); cdecl;
begin
  eqbezier[i]:=c;
end;
procedure cb2(i:integer;c:tcolorref); cdecl;
begin
  eqbar[i]:=c;
end;
begin
  multiflow(1,19,rgb(255,0,0),rgb(255,255,0),rgb(0,255,0),0,0,3,@cb1);
  multiflow(0,27,rgb(255,0,0),rgb(255,255,0),rgb(0,255,0),0,0,3,@cb2);
end;
begin
  createeqflow;
end;


procedure drawmainbar(z:tbitmap;x,y:integer;typ:byte);
var
dc:hdc;
procedure rahmen(x1,y1,w,h:integer);
begin
  lineh(dc,x1,y1,x1+w,y1,false);
  lineh(dc,x1,y1+h,x1+w,y1+h,true);
  linev(dc,x1,y1,x1,y1+h,false);
  linev(dc,x1+w,y1,x1+w,y1+h,true);
end;
var
s:string;
tx:integer;
begin
  z.canvas.lock;
  dc:=z.canvas.handle;
  getpicturepart(dc,x,y,0,mainheight,eqwidth,14);
  if pagesdlg.CheckBox1.checked then
  begin
    lineh(dc,x,y+13,x+eqwidth-1,y+13,pagesdlg.radiogroup6.itemindex=1);
    lineh(dc,x,y+14,x+eqwidth-1,y+14,pagesdlg.radiogroup6.itemindex=0);
  end;
  if pagesdlg.radiogroup2.itemindex=1 then lineh(dc,x,y,x+mainwidth-1,y,pagesdlg.radiogroup6.itemindex=0);
  if pagesdlg.radiogroup2.itemindex<>0 then
  begin
    linev(dc,x,y,x,y+13,pagesdlg.radiogroup6.itemindex=0);
    linev(dc,x+mainwidth-1,y,x+mainwidth-1,y+13,pagesdlg.radiogroup6.itemindex=1);
  end;

  s:=pagesdlg.edit2.text;
  if typ in [3,4]then
  begin
    tx:=20;
    s:='Eq';
    titeltext(z,x+tx,y,x+tx+z.canvas.textwidth(s),y+14,s,typ=3);
  end else titeltext(z,x,y,x+eqwidth,y+14,s,typ in [1,3]);


  if pagesdlg.checkbox2.checked then
  begin
    if typ in [1,2,5,6]then paintmask(dc,x+254,y+3,9,9,18,0)               // Maximize
    else paintmask(dc,x+254,y+3,9,9,36,0);            // Restore
    paintmask(dc,x+264,y+3,9,9,27,0);               // Close
  end;
  if typ in [3,4]then
  begin     { Klein... }
    rahmen(x+61,y+3,97,7);
    rahmen(x+164,y+3,43,7);
  end;
  z.canvas.unlock;
end;

procedure drawonauto(dc:hdc;x,y:integer;b1,b2:byte);
begin
  getpicturepart(dc,x,y,14,134,58,12);
  case pagesdlg.radiogroup1.itemindex of
    1:begin
      paintbmp(dc,x,y,25,12,0,200+(b1*12));
      paintbmp(dc,x+25,y,58-25,12,25,200+(b2*12));
    end;
    2:begin
      paintmask(dc,x,y,25,12,0,200+(b1*12));
      paintmask(dc,x+25,y,58-25,12,25,200+(b2*12));
    end;
  end;
end;

procedure drawpreset(dc:hdc;x,y:integer;pressed:boolean);
begin
  getpicturepart(dc,x,y,217,134,44,12);
  case pagesdlg.radiogroup1.itemindex of
    1:paintbmp(dc,x,y,44,12,58,200+(byte(pressed)*12));
    2:paintmask(dc,x,y,44,12,58,200+(byte(pressed)*12));
  end;
end;

procedure draweqbar(dc:hdc;x,y:integer;pos:integer);
var
brush,oldbrush:hpen;
begin
  getpicturepart(dc,x,y,96,154,14,63);
  if pagesdlg.eqoptions.checked[1] then
  begin
    linev(dc,x,y,x,y+62,false);
    linev(dc,x+12,y,x+12,y+62,true);
    lineh(dc,x,y,x+12,y,false);
    lineh(dc,x,y+62,x+12,y+62,true);
  end;

  if pagesdlg.eqoptions.checked[2] then
  begin
    brush:=createsolidbrush(eqbar[pos]);
    oldbrush:=selectobject(dc,brush);
    selectobject(dc,getstockobject(black_pen));

    rectangle(dc,x+1+2,y+1,x+12-3,y+62);
    selectobject(dc,oldbrush);
    deleteobject(brush);
  end;
end;

procedure draweqfeld(dc:hdc;x,y:integer);
var
i:integer;
pen,oldpen:hpen;
begin
  getpicturepart(dc,x,y,86,133,113,19);

  if pagesdlg.eqoptions.checked[3]=false then exit;

  pen:=createpen(ps_solid,1,rgb(64,64,92));
  oldpen:=selectobject(dc,pen);
  for i:=1 to 10 do
  begin
    movetoex(dc,x+2+(i-1)*12,y,nil);
    lineto(dc,x+2+(i-1)*12,y+19);
  end;
  selectobject(dc,oldpen);
  deleteobject(pen);
end;

procedure draweq(ziel:tbitmap;x,y:integer;display:boolean);
var
zdc:hdc;
procedure line(x1,y1,x2,y2:integer);
begin
  movetoex(zdc,x1,y1,nil);
  lineto(zdc,x2,y2);
end;
begin
  ziel.canvas.lock;
  zdc:=ziel.canvas.handle;
  drawmainbar(ziel,x,y,2);

  case pagesdlg.RadioGroup2.itemindex of
    1,2:begin
      if pagesdlg.radiogroup2.itemindex=1 then lineh(zdc,x,y+eqheight-1,x+eqwidth-1,y+eqheight-1,pagesdlg.radiogroup6.itemindex=1);
      linev(zdc,x,y+14,x,y+eqheight-1,pagesdlg.radiogroup6.itemindex=0);
      linev(zdc,x+eqwidth-1,y+14,x+eqwidth-1,y+eqheight-1,pagesdlg.radiogroup6.itemindex=1);
    end;
  end;

  if pagesdlg.eqoptions.checked[0] then with ziel.canvas do begin                         // Texte
    pen.color:=rgb(0,64,64);
    smalltextout(ziel,16,103,'Preamp');
    smalltextout(ziel,81,103,'60');
    smalltextout(ziel,97,103,'170');
    smalltextout(ziel,114,103,'310');
    smalltextout(ziel,133,103,'600');
    smalltextout(ziel,152,103,'1k');
    smalltextout(ziel,170,103,'3k');
    smalltextout(ziel,189,103,'6k');
    smalltextout(ziel,205,103,'12k');
    smalltextout(ziel,223,103,'14k');
    smalltextout(ziel,240,103,'16k');
  end;
  if pagesdlg.eqoptions.checked[4] then with ziel.canvas do begin
    pen.color:=rgb(0,64,64);
    pen.style:=pssolid;
    smalltextout(ziel,45,36,'+20db');
    smalltextout(ziel,45,36+31,' 0 db');
    smalltextout(ziel,45,36+62,'-20db');
  end;
  ziel.canvas.unlock;
end;

procedure geteqbitmap;
var
dc:hdc;
procedure drawbezier(x,y:integer);
var
p:array[1..4]of tpoint;
c:tbitmap;
i,j:integer;
begin
  c:=tbitmap.create;
//  c.pixelformat:=pixelformat;
  c.width:=200;
  c.height:=19;
  c.canvas.pen.color:=rgb(255,255,255);
  c.canvas.Rectangle(0,0,200,19);

  c.canvas.pen.color:=rgb(0,0,0);
  p[1]:=point(0,1);
  p[2]:=point(40,19);
  p[3]:=point(40+15,15);
  p[4]:=point(110,5);
  polybezier(c.canvas.handle,p,4);

  for i:=0 to 108 do for j:=0 to 18 do
  begin
    if getpixel(c.canvas.handle,i,j)<>rgb(255,255,255)then
    begin
      setpixel(r.canvas.handle,x+i,y+j,eqbezier[j+1]);

    end;
  end;

  c.free;
end;
procedure eqbar(x,y,pos:integer);
begin
  draweqbar(dc,x,y,pos);
  paintbmp(r.canvas.handle,x+1,y+round((61/28)*(pos)),11,11,160,12);
end;
begin
  r.width:=eqwidth;
  r.height:=eqheight;
  r.canvas.lock;
  dc:=r.canvas.handle;
  getoriginalpicture(r,mainheight,eqheight);
  if created then
  begin
    draweq(r,0,0,true);
    drawonauto(dc,14,18,1,0);
    if pagesdlg.checkbox14.checked then
    begin
      drawpreset(dc,217,18,false);

      draweqfeld(dc,86,17);
      r.canvas.pen.style:=pssolid;
      r.canvas.pen.color:=rgb(64,64,92);
      r.canvas.moveto(86,26);
      r.canvas.lineto(200,26);
      drawbezier(88,17);

      eqbar(21,38,13);

      eqbar(78+(0*18),38,2);
      eqbar(78+(1*18),38,7);
      eqbar(78+(2*18),38,14);
      eqbar(78+(3*18),38,17);
      eqbar(78+(4*18),38,18);
      eqbar(78+(5*18),38,17);
      eqbar(78+(6*18),38,15);
      eqbar(78+(7*18),38,13);
      eqbar(78+(8*18),38,10);
      eqbar(78+(9*18),38,7);
    end;
  end;
  r.canvas.unlock;
end;

procedure saveeqbitmaps;
var
b:tbitmap;
i:integer;
dc:hdc;
begin
  b:=tbitmap.create;
  b.pixelformat:=pixelformat;
  b.canvas.lock;

  begin                               // eqmain.bmp
    b.width:=eqpicturewidth;
    if pagesdlg.checkbox14.checked then b.height:=eqpictureheight else b.height:=eqsmallpictureheight;
    dc:=b.canvas.handle;
    getoriginalpicture(b,mainheight,eqheight);
    draweq(b,0,0,false);

    begin               // Mainbar
      drawmainbar(b,0,134,1);
      drawmainbar(b,0,149,2);
      originalmask(dc,0,116,9,9,27,0,264,3+mainheight,pagesdlg.CheckBox2.checked);
      originalmask(dc,0,116+9,9,9,27,9,264,3+mainheight,pagesdlg.CheckBox2.checked);
    end;
    begin                               // On/Auto/Preset
      for i:=0 to 3 do drawonauto(dc,10+(i*59),119,i,i);
      drawpreset(dc,224,164,false);
      drawpreset(dc,224,164+12,true);
    end;
    draweqfeld(dc,0,294);
    b.canvas.pen.style:=pssolid;
    b.canvas.pen.color:=rgb(64,64,92);
    b.canvas.MoveTo(0,314);
    b.canvas.lineto(113,314);
    for i:=1 to 19 do setpixel(dc,115,294+(i-1),eqbezier[i]);

    for i:=0 to 27 do draweqbar(dc,13+(i mod 14)*15,164+(i div 14)*65,27-i);
    getpicturepart(dc,0,164,69,174,11,11);
    paintbmp(b.canvas.handle,0,164,11,11,160,12);
    getpicturepart(dc,0,176,69,174,11,11);
    paintbmp(dc,0,176,11,11,172,12);

    b.savetofile(verz+'eqmain.bmp');
    pagesdlg.stepit;
  end;
  begin                             // Eq_ex.bmp
    b.width:=275;
    b.height:=82;
    dc:=b.canvas.handle;
    clearbitmap(b,rgb(255,255,255));

    drawmainbar(b,0,0,3);
    drawmainbar(b,0,15,4);

    originalmask(dc,1,38,9,9,18,9,254,mainheight+3,pagesdlg.CheckBox2.checked);
    originalmask(dc,1,47,9,9,36,9,254,mainheight+3,pagesdlg.CheckBox2.checked);

    originalmask(dc,11,38,9,9,27,0,254,mainheight+3,pagesdlg.CheckBox2.checked);
    originalmask(dc,11,47,9,9,27,9,254,mainheight+3,pagesdlg.CheckBox2.checked);

    originalbmp(dc,1,30,9,7,250,0,226,mainheight+3,true);
    originalbmp(dc,11,30,9,7,250,0,226,mainheight+3,true);

    b.savetofile(verz+'eq_ex.bmp');
    pagesdlg.stepit;
  end;

  b.canvas.unlock;
  b.free;
end;

end.

