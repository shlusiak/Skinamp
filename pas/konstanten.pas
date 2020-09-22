unit konstanten;
{$I cs.inc}

interface

uses messages;

const
mainwidth=275;
mainheight=116;
eqwidth=275;
eqheight=116;
eqpicturewidth=275;
eqpictureheight=315;
eqsmallpictureheight=163;
plwidth=275;
plheight=116;
plpicturewidth=280;
plpictureheight=186;
mbwidth=275;
mbheight=145;
mbpicturewidth=242;
mbpictureheight=119;
avswidth=275;
avsheight=200;
avspicturewidth=97;
avspictureheight=188;
picturewidth=mainwidth;
pictureheight=mainheight+eqheight+plheight;
maxpictureheight=mainheight+eqheight+plheight+138;     { 116+116+116+138=348+138=486 }
mboffset=87;
ploffset=50;

wclass='Winamp v1.x';
wm_redraw=wm_user+5;
myskin='MySkin';

var
werbung:boolean;

implementation

begin
  werbung:=true;
end.






