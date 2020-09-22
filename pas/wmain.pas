unit wmain;
{$I cs.inc}

interface

uses windows,graphics,skinampc;

procedure initmainbitmaps;
procedure getmainbitmap(r:tbitmap;created:boolean);
procedure drawmainbar(z:tbitmap;x,y:integer;typ:byte);
procedure savemainbitmaps(verz:pchar);

var
volume,balance:array[0..27]of tcolorref;

implementation

uses konstanten,bmps,main,forms,classes,cheatdlg,viscolor,pltext,math,stdctrls;



procedure initmainbitmaps;
procedure vol(i:integer;c:tcolorref); cdecl;
begin
  volume[i]:=c;
  balance[i]:=c;
end;
begin
  multiflow(0,27,rgb(0,128,0),rgb(255,255,0),rgb(255,0,0),0,0,3,@vol);
end;

procedure drawmainbar(z:tbitmap;x,y:integer;typ:byte);
var
dc:hdc;
var
s:string;
procedure line(x1,y1,x2,y2:integer);
begin
  movetoex(dc,x1,y1,nil);
  lineto(dc,x2,y2);
end;
var
pen,oldpen:hpen;
begin
  z.canvas.lock;
  dc:=z.canvas.handle;
  getpicturepart(dc,x,y,0,0,mainwidth,14);
  if pagesdlg.CheckBox3.checked then
  begin
    lineh(dc,x,y+13,x+mainwidth-1,y+13,pagesdlg.radiogroup6.itemindex=1);
    lineh(dc,x,y+14,x+mainwidth-1,y+14,pagesdlg.radiogroup6.itemindex=0);
  end;
  if pagesdlg.radiogroup2.itemindex<>0 then
  begin
    lineh(dc,x,y,x+mainwidth-1,y,pagesdlg.radiogroup6.itemindex=0);
    linev(dc,x,y,x,y+13,pagesdlg.radiogroup6.itemindex=0);
    linev(dc,x+mainwidth-1,y,x+mainwidth-1,y+13,pagesdlg.radiogroup6.itemindex=1);
  end;

  if typ in [1..4]then s:=pagesdlg.Edit1.Text else 
  begin
    s:=pagesdlg.cheattext;
  end;

  if typ in [3,4]then
  begin
    titeltext(z,x+20,y,x+20+z.canvas.textwidth(s),y+14,s,typ=3);
  end else titeltext(z,x+35,y,x+mainwidth-35,y+14,s,typ in [1,3,5]);

  if pagesdlg.checkbox4.checked then
  begin
    paintmask(dc,x+244,y+3,9,9,9,0);                // Minimize
    if typ in [1,2,5,6]then paintmask(dc,x+254,y+3,9,9,18,0)               // Maximize
    else paintmask(dc,x+254,y+3,9,9,36,0);            // Restore
    paintmask(dc,x+264,y+3,9,9,27,0);               // Close
    paintbmp(dc,x+6,y+3,9,9,0,0);                   // WinAmp
  end;
  if typ in [3,4]then
  begin     { Klein... }
    rahmen(dc,x+78,y+3,40,8,true,0);
    rahmen(dc,x+125,y+3,33,8,true,0);
    originalmask(dc,x+226,y+4,17,7,0,155,226,3,true);
    pen:=createpen(ps_solid,1,pagesdlg.colorfield2.color);
    oldpen:=selectobject(dc,pen);
    MoveToex(dc,x+144,y+6,nil);
    lineto(dc,x+146,y+6);
    MoveToex(dc,x+144,y+8,nil);
    lineto(dc,x+146,y+8);
    selectobject(dc,oldpen);
    deleteobject(pen);
    paintbmp(dc,x+169,y+3,54,7,0,180);
  end;
  z.canvas.unlock;
end;

procedure drawrepeat(dc:hdc;x,y:integer;typ:integer);
begin
  getpicturepart(dc,x,y,164+46,89,28,15);
  case pagesdlg.buttons.ItemIndex of
    1:paintbmp(dc,x,y,28,15,0,66+typ*15);
    2:paintmask(dc,x,y,28,15,0,66+typ*15);
  end;
end;

procedure drawshuffle(dc:hdc;x,y:integer;typ:integer);
begin
  getpicturepart(dc,x,y,164,89,47,15);
  case pagesdlg.buttons.ItemIndex of
    1:paintbmp(dc,x,y,75-28,15,28,66+typ*15);
    2:paintmask(dc,x,y,75-28,15,28,66+typ*15);
  end;
end;

procedure drawchaosbar(dc:hdc;x,y:integer;marked:integer);
var
fx,fy:integer;
begin
  getpicturepart(dc,x,y,10,22,8,43);
  if pagesdlg.options.Checked[0]=false then exit;

  fx:=136;
  fy:=0;
  case marked of
    -1:inc(fx,8);
    1,2,3,4,5:inc(fy,44);
  end;
  if marked>=1 then inc(fx,(marked-1)*8);
  paintbmp(dc,x,y,8,43,fx,fy);
end;

procedure draweqpl(dc:hdc;x,y:integer;eq,pl:integer);
var
fx1,fy1,fx2,fy2:integer;
begin
  fx1:=0;
  fy1:=127;
  fx2:=23;
  fy2:=127;
  if eq in [1,3]then inc(fx1,46);
  if eq in [2,3]then inc(fy1,12);

  if pl in [1,3]then inc(fx2,46);
  if pl in [2,3]then inc(fy2,12);

  getpicturepart(dc,x,y,219,58,46,12);
  case pagesdlg.buttons.ItemIndex of
    1:begin
      paintbmp(dc,x,y,23,12,fx1,fy1);
      paintbmp(dc,x+23,y,46-23,12,fx2,fy2);
    end;
    2:begin
      paintmask(dc,x,y,23,12,fx1,fy1);
      paintmask(dc,x+23,y,46-23,12,fx2,fy2);
    end;
  end;
end;

procedure drawmono(dc:hdc;x,y:integer;enabled:boolean);
begin
  getpicturepart(dc,x,y,212,41,29,12);
  if pagesdlg.options.checked[1] then paintbmp(dc,x,y,29,12,29,151+(byte(enabled)*12));
end;

procedure drawstereo(dc:hdc;x,y:integer;enabled:boolean);
begin
  getpicturepart(dc,x,y,239,41,29,12);
  if pagesdlg.options.checked[1] then paintbmp(dc,x,y,29,12,0,151+(byte(enabled)*12));
end;

procedure drawbalance(dc:hdc;x,y:integer;pos:integer);
const
b=38;
h=15;
var
brush,oldbrush:hbrush;
begin
  getpicturepart(dc,x,y,177,57,b,h);
  if pagesdlg.options.state[2]<>cbchecked then exit;
  lineh(dc,x,y+1,x+b-1,y+1,false);
  lineh(dc,x,y+h-3,x+b-1,y+h-3,true);
  linev(dc,x,y+1,x,y+h-4,false);
  linev(dc,x+b-1,y+1,x+b-1,y+h-3,true);

  brush:=createsolidbrush(balance[pos]);
  oldbrush:=selectobject(dc,brush);
  selectobject(dc,getstockobject(black_pen));
  rectangle(dc,x+1,y+3,x+b-1,y+h-5);
  selectobject(dc,oldbrush);
  deleteobject(brush);
end;

procedure drawvolume(dc:hdc;x,y:integer;pos:integer);
const
b=68;
h=15;
var
brush,oldbrush:hbrush;
begin
  getpicturepart(dc,x,y,107,57,b,h);
  if pagesdlg.options.state[3]<>cbchecked then exit;
  lineh(dc,x,y+1,x+b-1,y+1,false);
  lineh(dc,x,y+h-3,x+b-1,y+h-3,true);
  linev(dc,x,y+1,x,y+h-4,false);
  linev(dc,x+b-1,y+1,x+b-1,y+h-3,true);

  brush:=createsolidbrush(volume[pos]);
  oldbrush:=selectobject(dc,brush);
  selectobject(dc,getstockobject(black_pen));
  rectangle(dc,x+1,y+3,x+b-1,y+h-5);
  selectobject(dc,oldbrush);
  deleteobject(brush);
end;

procedure drawposbar(dc:hdc;x,y:integer);
begin
  getpicturepart(dc,x,y,16,72,248,10);
  if pagesdlg.options.state[4]<>cbchecked then exit;
  lineh(dc,x,y,x+247,y,false);
  lineh(dc,x,y+9,x+247,y+9,true);
  linev(dc,x,y,x,y+9,false);
  linev(dc,x+247,y,x+247,y+9,true);
end;

procedure drawbutton(dc:hdc;zx,zy:integer;pressed:boolean;nr:integer);
var
x,y,w,h:integer;
begin
  w:=23;
  h:=18;
  x:=23*nr;
  y:=30+byte(pressed)*18;
  if nr=4 then dec(x);
  if nr=5 then dec(x);
  if nr=5 then h:=16;
  case pagesdlg.Buttons.itemindex of
    1:begin
      paintbmp(dc,zx,zy,w,h,x,y);
    end;
    2:begin
      paintmask(dc,zx,zy,w,h,x,y);
    end;
  end;
end;

procedure drawmainbitmap(z:tbitmap;x,y:integer;display:boolean);
var
i:integer;
dc:hdc;
procedure drawvis;
procedure drawline(x,y:integer;pos:integer;peak:integer);
var
i:integer;
pen,oldpen:hpen;
begin
  for i:=1 to pos do
  begin
    pen:=createpen(ps_solid,1,viscolordlg.spec(16+1-i).color);
    oldpen:=selectobject(dc,pen);
    movetoex(dc,24+(x-1)*4,y-i,nil);
    lineto(dc,24+(x-1)*4+3,y-i);
    selectobject(dc,oldpen);
    deleteobject(pen);
  end;
end;
const
heights:array[1..19]of byte=
(0,2,6,0,4,8,9,7,16,6,14,15,9,4,3,4,2,3,0);
var
i,j:integer;
b,ob:hbrush;
p,op:hpen;
begin { 18 x }
  b:=createsolidbrush(viscolordlg.s1.color);
  p:=createpen(ps_solid,1,viscolordlg.s1.color);
  ob:=selectobject(dc,b);
  op:=selectobject(dc,p);
  rectangle(dc,24,43,100,59);
  selectobject(dc,op);
  selectobject(dc,ob);
  deleteobject(p);
  deleteobject(b);
  for i:=0 to 76 div 2-1 do for j:=0 to 16 div 2-1 do
    setpixel(dc,24+i*2,43+j*2,viscolordlg.s2.color);
  for i:=1 to 19 do drawline(i,59,heights[i],0);
end;
begin
  z.canvas.lock;
  dc:=z.canvas.handle;
  getpicturepart(dc,x,y,0,0,mainwidth,mainheight);
  drawmainbar(z,x,y,1);
  
  drawshuffle(dc,x+164,y+89,2);
  drawrepeat(dc,x+164+46,y+89,0);
  draweqpl(dc,x+219,y+58,2,2);
  if display then drawchaosbar(dc,x+10,y+22,2) else drawchaosbar(dc,x+10,y+22,0);
  drawmono(dc,x+212,y+41,false);
  drawstereo(dc,x+239,y+41,true);

  { Balance}
  drawbalance(dc,x+177,y+57,0);
  if (display)then case pagesdlg.options.state[2] of
    cbchecked:paintbmp(dc,x+189,y+58,14,11,175,0);
    cbgrayed:paintmask(dc,x+189,y+58,14,11,65,0);
  end;

  { Volume }
  drawvolume(dc,x+107,y+57,21);
  if (display)then case pagesdlg.options.state[3] of
    cbchecked:paintbmp(dc,x+145,y+58,14,11,175,0);
    cbgrayed:paintmask(dc,x+145,y+58,14,11,65,0);
  end;

  if display then
  begin      { Posbar }                                         
    drawposbar(dc,16,72);
    case pagesdlg.options.state[4] of
      cbchecked:paintbmp(dc,16,72,29,10,190,0);
      cbgrayed:paintmask(dc,16,72,29,10,80,0);                              
    end;
  end else drawposbar(dc,16,72);


  case pagesdlg.RadioGroup2.itemindex of
    1,2:begin
      if pagesdlg.radiogroup2.itemindex=1 then lineh(dc,x,y+mainheight-1,x+mainwidth-1,y+mainheight-1,pagesdlg.radiogroup6.itemindex=1);
      linev(dc,x,y+14,x,y+mainheight-1,pagesdlg.radiogroup6.itemindex=0);
      linev(dc,x+mainwidth-1,y+14,x+mainwidth-1,y+mainheight-1,pagesdlg.radiogroup6.itemindex=1);
    end;
  end;
  for i:=0 to 4 do drawbutton(dc,16+i*23,88,false,i);
  drawbutton(dc,16+7+5*23,89,false,5);

  if pagesdlg.options.checked[9] then begin
    paintbmp(dc,250,91,16,16,270,0);
  end;

  with z.canvas do begin                         // Sonstige schwarze Stellen
    pen.color:=rgb(0,0,0);
    pen.style:=pssolid;
    brush.color:=rgb(0,0,0);
    brush.style:=bssolid;

    if pagesdlg.options.checked[6] then
    begin                          { Visualisierungsfenster }
      rahmen(dc,22,24,80,36,true,pagesdlg.colorfield3.color);
      pen.color:=pagesdlg.colorfield1.color;
      pen.style:=pssolid;
      moveto(72,30);
      lineto(72+3,30);
      moveto(72,34);
      lineto(72+3,34);
      if display then drawvis;
      if display then
      begin      { Zeit ausgeben }
        paintbmpcolor(dc,48,26,9,13,200,60,pagesdlg.colorfield1.color);
        paintbmpcolor(dc,60,26,9,13,200,60,pagesdlg.colorfield1.color);
        paintbmpcolor(dc,78,26,9,13,200,60,pagesdlg.colorfield1.color);
        paintbmpcolor(dc,90,26,9,13,209,60,pagesdlg.colorfield1.color);
      end;
    end;
    if (display)and(pagesdlg.options.checked[8]) then
    begin
      paintbmp(dc,24,28,3,9,236,50);
      paintbmp(dc,30,28,6,9,203,50);
    end;

    if pagesdlg.options.checked[7] then
    begin
      rahmen(dc,110,23,156,14,true,pagesdlg.ColorField3.color);
      pen.color:=rgb(128,255,255);
      smalltextout(z,114,27,'SkinAmp - SkinAmp - SkinAmp - SkinAmp');
      brush.style:=bssolid;
      brush.color:=rgb(0,0,0);
    end;
    if pagesdlg.options.checked[5] then
    begin
      rahmen(dc,110,42,17,8,true,pagesdlg.colorfield3.color);
      rahmen(dc,155,42,12,8,true,pagesdlg.colorfield3.color);
    end;
  end;
  z.canvas.unlock;
end;

procedure getmainbitmap;
begin
  r.width:=mainwidth;
  r.height:=mainheight;
  r.canvas.lock;
  clearbitmap(r,rgb(255,255,255));
  if created then drawmainbitmap(r,0,0,true)
  else getpicturepart(r.canvas.handle,0,0,0,0,mainwidth,mainheight);
  r.canvas.unlock;
end;

procedure savemainbitmaps;
var
b:tbitmap;
i:integer;
t:boolean;
dc:hdc;
begin
  b:=tbitmap.create;
  b.pixelformat:=pixelformat;
  b.canvas.lock;

  begin                  // Main.bmp
    b.width:=mainwidth;
    b.height:=mainheight;
    clearbitmap(b,rgb(255,255,255));
    drawmainbitmap(b,0,0,false);

    b.savetofile(verz+'main.bmp');
    pagesdlg.stepit;
  end;
  begin                  // titlebar.bmp         
    b.width:=344;
    b.height:=87;
    dc:=b.canvas.handle;
    clearbitmap(b,rgb(255,255,255));

    begin                { Knöpfe }
      t:=pagesdlg.checkbox4.checked;
      originalbmp(dc,0,0,9,9,0,0,6,3,t);                // WinAmp
      originalbmp(dc,0,9,9,9,0,9,6,3,t);                // WinAmp
      originalmask(dc,9,0,9,9,9,0,244,4,t);             // Minimize
      originalmask(dc,9,9,9,9,9,9,244,4,t);             // Minimize
      originalmask(dc,18,0,9,9,27,0,264,4,t);           // Close
      originalmask(dc,18,9,9,9,27,9,264,4,t);           // Close
      originalmask(dc,0,18,9,9,18,0,254,4,t);            // Maximize
      originalmask(dc,9,18,9,9,18,9,254,4,t);            // Maximize
      originalmask(dc,0,27,9,9,36,0,254,4,t);            // Restore
      originalmask(dc,9,27,9,9,36,9,254,4,t);            // Restore
    end;
    begin              { Kleine Sachen }
      originalmask(dc,0,36,17,7,0,155,226,3,true);
      originalbmp(dc,17,36,9,7,250,0,226,3,true);

    end;

    drawmainbar(b,27,0,1);
    drawmainbar(b,27,15,2);
    drawmainbar(b,27,29,3);
    drawmainbar(b,27,42,4);
    drawmainbar(b,27,57,5);
    drawmainbar(b,27,72,6);

    drawchaosbar(dc,304,0,0);
    drawchaosbar(dc,304+8,0,-1);
    for i:=1 to 5 do drawchaosbar(dc,304+(i-1)*8,44,i);

    b.savetofile(verz+'titlebar.bmp');
    pagesdlg.stepit;
  end;
  begin                  // cbuttons.bmp
    b.width:=136;
    b.height:=36;
    dc:=b.canvas.handle;
    clearbitmap(b,rgb(255,255,255));
    getpicturepart(dc,0,0   ,16,88,114,18);
    getpicturepart(dc,0,18  ,16,88,114,18);

    getpicturepart(dc,114,0   ,114+16+6,89,22,16);
    getpicturepart(dc,114,16  ,114+16+7,89,22,16);

    for i:=0 to 5 do drawbutton(dc,0+i*23,0,false,i);
    for i:=0 to 4 do drawbutton(dc,0+i*23,18,true,i);
    drawbutton(dc,5*23,16,true,5);

    b.savetofile(verz+'cbuttons.bmp');
  end;                   // shufrep.bmp
  begin
    b.width:=92;
    b.height:=85;
    dc:=b.canvas.handle;
    clearbitmap(b,rgb(255,255,255));

    for i:=0 to 3 do
    begin
      drawrepeat(dc,0,i*15,i);
      drawshuffle(dc,28,i*15,i);
    end;

    draweqpl(dc,0,61,0,0);
    draweqpl(dc,46,61,1,1);
    draweqpl(dc,0,73,2,2);
    draweqpl(dc,46,73,3,3);

    b.savetofile(verz+'shufrep.bmp');
    pagesdlg.stepit;
  end;
  begin                       // monoster.bmp
    b.width:=58;
    b.height:=24;
    dc:=b.canvas.handle;
    clearbitmap(b,rgb(255,255,255));

    drawstereo(dc,0,0,true);
    drawstereo(dc,0,12,false);
    drawmono(dc,29,0,true);
    drawmono(dc,29,12,false);

    b.savetofile(verz+'monoster.bmp');
  end;
  begin                               // Balance.bmp
    b.width:=68;
    if pagesdlg.options.state[2]<>cbunchecked then b.height:=433 else b.height:=421;
    dc:=b.canvas.handle;
    clearbitmap(b,rgb(255,255,255));

    for i:=0 to 27 do drawbalance(dc,9,i*15,i);

    if pagesdlg.options.state[2]<>cbunchecked then
    begin
      getpicturepart(dc,0,422,189,58,14,11);
      getpicturepart(dc,15,422,189,58,14,11);
      case pagesdlg.options.state[2] of
        cbchecked:begin
          paintbmp(dc,0,422,14,11,160,0);
          paintbmp(dc,15,422,14,11,175,0);
        end;
        cbgrayed:begin
          paintmask(dc,0,422,14,11,50,0);
          paintmask(dc,15,422,14,11,65,0);
        end;
      end;
    end;

    b.savetofile(verz+'balance.bmp');
  end;
  begin                               // volume.bmp
    b.width:=68;
    if pagesdlg.options.state[3]<>cbunchecked then b.height:=433 else b.height:=421;
    dc:=b.canvas.handle;
    clearbitmap(b,rgb(255,255,255));

    for i:=0 to 27 do drawvolume(dc,0,i*15,i);

    if pagesdlg.options.state[3]<>cbunchecked then
    begin
      getpicturepart(dc,0,422,145,58,14,11);
      getpicturepart(dc,15,422,145,58,14,11);
      case pagesdlg.options.state[3] of
        cbchecked:begin
          paintbmp(dc,0,422,14,11,160,0);
          paintbmp(dc,15,422,14,11,175,0);
        end;
        cbgrayed:begin
          paintmask(dc,0,422,14,11,50,0);
          paintmask(dc,15,422,14,11,65,0);
        end;
      end;
    end;

    b.savetofile(verz+'volume.bmp');
    pagesdlg.stepit;
  end;
  begin                             // posbar.bmp
    if pagesdlg.options.state[4]=cbunchecked then b.width:=248 else b.width:=307;
    b.height:=10;
    dc:=b.canvas.handle;
    clearbitmap(b,rgb(255,255,255));
    drawposbar(dc,0,0);
    getpicturepart(dc,248,0,17,72,59,10);
    case pagesdlg.options.state[4] of
      cbchecked:paintbmp(dc,248,0,59,10,190,0);
      cbgrayed:paintmask(dc,248,0,59,10,80,0);
    end;

    b.savetofile(verz+'posbar.bmp');
  end;
  begin                             // Playpaus.bmp
    b.width:=42;
    b.height:=9;
    dc:=b.canvas.handle;

    if pagesdlg.options.checked[8] then
    begin
      clearbitmap(b,pagesdlg.colorfield3.color);
      paintbmp(b.canvas.handle,0,0,42,9,200,50);
    end else
    begin
      if pagesdlg.options.checked[6] then
      patblt(b.canvas.handle,0,0,42,9,blackness) else
      begin               { Hintergrund in playpaus.bmp übernehmen }
        getpicturepart(dc,0,0,26,28,9,9);
        getpicturepart(dc,9,0,26,28,9,9);
        getpicturepart(dc,18,0,26,28,9,9);
        getpicturepart(dc,27,0,24,28,9,9);
        getpicturepart(dc,36,0,24,28,3,9);
        getpicturepart(dc,39,0,24,28,3,9);
      end;
    end;

    b.savetofile(verz+'playpaus.bmp');
  end;
  begin                               // numbers.bmp
    b.width:=99;
    b.height:=13;
    clearbitmap(b,pagesdlg.colorfield3.color);

    paintbmpcolor(b.canvas.handle,0,0,99,13,200,60,pagesdlg.colorfield1.color);

    b.savetofile(verz+'numbers.bmp');
  end;
  begin                              // text.bmp
    b.width:=155;
    b.height:=18;
    clearbitmap(b,pagesdlg.colorfield3.color);
    copyfonts(b.canvas.handle);
    b.savetofile(verz+'text.bmp');
    pagesdlg.stepit;
  end;

  b.canvas.unlock;
  b.free;
end;

begin
  randomize;
end.
