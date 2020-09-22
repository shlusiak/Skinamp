unit skinampc;
{$I cs.inc}

interface

uses windows,forms,controls;

type
tcurcbproc=procedure(x,y,farbe,p1,p2:integer); cdecl;
pcurcbproc=^tcurcbproc;
pflowrec=pointer;
tflowproc=procedure(p:integer;c:tcolorref); cdecl;
pflowproc=^tflowproc;
pcheatobject=pointer;

//procedure heller(dc:hdc;x,y:integer); cdecl;
//procedure dunkler(dc:hdc;x,y:integer); cdecl;
// werden nicht gebraucht
function dllinstance:thandle; cdecl;
procedure lineh(dc:hdc;x1,y1,x2,y2:integer;heller:boolean); cdecl;
procedure linev(dc:hdc;x1,y1,x2,y2:integer;heller:boolean); cdecl;
function getrandomcolor:tcolorref; cdecl;
procedure cpaintbmp(sdc:hdc;dc:hdc;x,y,w,h:integer;sx,sy:integer); cdecl;
procedure cpaintbmpcolor(sdc:hdc;dc:hdc;x,y,w,h:integer;sx,sy:integer;color:tcolorref); cdecl;
procedure cpaintmask(sdc:hdc;dc:hdc;x,y,w,h:integer;sx,sy:integer); cdecl;
procedure csmalltextout(sdc:hdc;dc:hdc;x,y:integer;text:pchar;color:tcolorref); cdecl;
procedure rahmen(dc:hdc;x1,y1,w,h:integer;dd:boolean;color:tcolorref); cdecl;
function iswinamp(p:tpoint):boolean; cdecl;
procedure infomoveit(p:tpoint); cdecl;
procedure multiflow(min,max:integer;c1,c2,c3,c4,c5:tcolorref;colors:integer;cb:pflowproc); cdecl;
procedure ccopyfonts(bdc,tdc:hdc;color:tcolorref); cdecl;
procedure curline(cb:pcurcbproc;x1,y1,x2,y2:integer;farbe:integer;p1,p2:integer); cdecl;
function curfloodfill(a:pointer;cb:pcurcbproc;x,y:integer;farbe:integer):integer; cdecl;
function curispalettecolor(c,p:tcolorref):boolean; cdecl;
procedure runinfocheat(o1,o2:pcheatobject;halb:tcolorref); cdecl;
function createcheatobject(pos,size,speed:tpoint;graphic:hdc):pcheatobject; cdecl;
procedure addothercheatobject(ob,other:pcheatobject); cdecl;
function CreateSplashScreen(owner:hwnd):hwnd; cdecl;
procedure destroysplashscreen(wnd:hwnd); cdecl;
function getshelllinktarget(shfile:pchar;target:pchar;max:integer):hresult; cdecl;
function zipfiles(files,dest:pchar):boolean; cdecl;
function setwinampskin(skindir:pchar):boolean; cdecl;
procedure contexthelp(wnd:thandle;parm:pointer); cdecl;

const
dll='skinampc.dll';

implementation


//procedure Heller; external dll index 1;
//procedure Dunkler; external dll index 2;
function dllinstance; external dll index 1;
function setwinampskin; external dll index 2;
procedure lineh; external dll index 3;
procedure linev; external dll index 4;
procedure cpaintbmp; external dll index 5;
procedure cpaintbmpcolor; external dll index 6;
procedure cpaintmask; external dll index 7;
procedure csmalltextout; external dll index 8;
procedure rahmen; external dll index 9;
function getrandomcolor; external dll index 10;
procedure curline; external dll index 11;
function curfloodfill; external dll index 12;
function curispalettecolor; external dll index 13;
function iswinamp; external dll index 14;
procedure infomoveit; external dll index 15;
procedure multiflow; external dll index 16;
procedure ccopyfonts; external dll index 17;
function createcheatobject; external dll index 18;
procedure runinfocheat; external dll index 19;
procedure contexthelp; external dll index 20;
procedure addothercheatobject; external dll index 21;
function createsplashscreen; external dll index 24;
procedure destroysplashscreen; external dll index 25;
function getshelllinktarget; external dll index 26;
function zipfiles; external dll index 27;


end.
