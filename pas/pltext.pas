unit pltext;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,inifiles, Menus,funktionen, ColorField;

type
  Tpltextdlg = class(TForm)
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    FontMenu: TPopupMenu;
    font: TEdit;
    pt1: TColorField;
    pt2: TColorField;
    pt3: TColorField;
    pt4: TColorField;
    procedure FormCreate(Sender: TObject);
    procedure fontContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure pt1LeftClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pt1RightClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure fontChange(Sender: TObject);
    procedure Button1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    inchange:boolean;
    oldtext:string;
    { Private-Deklarationen }
    procedure drawmenuitem(Sender:TObject;ACanvas:TCanvas;ARect:TRect;Selected:Boolean);
    procedure selectmenuitem(sender:tobject);
    procedure measureitem(Sender:TObject;ACanvas:TCanvas;var Width,Height:Integer);
  public
    { Public-Deklarationen }
  end;


procedure savepltext(verz:pchar);

implementation

uses searchcolor,mbtext,sascha, main,language;

{$R *.DFM}

const
schrift=-16;
menuheight=17;

var
mypltextdlg:tpltextdlg;

procedure savepltext;
var
i:tinifile;
procedure writecolor(ident:string;def:tcolorref);
var
s:String;
function makehex(i:byte):string;
var
s2:string;
begin
  s2:=format('%x',[i]);
  while length(s2)<2 do s2:='0'+s2;
  result:=s2;
end;
begin
  s:=makehex(getrvalue(def))+makehex(getgvalue(def))+makehex(getbvalue(def));
  while length(s)<6 do s:='0'+s;
  s:='#'+s; 
  i.writestring('Text',ident,s);
end;
begin
  i:=tinifile.create(verz+'pledit.txt');

  writecolor('Normal',pagesdlg.textr.pl[1]);
  writecolor('Current',pagesdlg.textr.pl[2]);
  writecolor('NormalBG',pagesdlg.textr.pl[3]);
  writecolor('SelectedBG',pagesdlg.textr.pl[4]);
  writecolor('MbBG',pagesdlg.textr.mb[1]);
  writecolor('MbFG',pagesdlg.textr.mb[2]);

  i.writestring('Text','Font',pagesdlg.textr.font);

  i.updatefile;
  i.free;
end;

procedure Tpltextdlg.FormCreate(Sender: TObject);
procedure createfonts;
var
i:integer;
mi:tmenuitem;
begin
  fontmenu.items.clear;
  for i:=0 to screen.fonts.count-1 do
  begin
    mi:=tmenuitem.create(self);
    mi.caption:=screen.fonts[i];
    mi.ondrawitem:=drawmenuitem;
    mi.onmeasureitem:=measureitem;
    mi.onclick:=selectmenuitem;

    fontmenu.items.add(mi);
  end;
end;
begin
  mypltextdlg:=self;
  createfonts;
  inchange:=false;
  oldtext:='';
  label1.caption:=loadstring(1050);
  label2.caption:=loadstring(1051);
  label3.caption:=loadstring(1052);
  label4.caption:=loadstring(1053);
  button1.caption:=loadstring(901);
  caption:=loadstring(1054);
  setids(self);
end;

procedure tpltextdlg.drawmenuitem;
var
n:string;
begin
  with acanvas do
  begin
    with font do
    begin
      n:=tmenuitem(sender).caption;
      name:=n;
      height:=schrift;
    end;
    pen.style:=pssolid;
    pen.color:=brush.color;
    brush.style:=bssolid;
    rectangle(arect);
    brush.style:=bsclear;
    textout(aRect.left+2,arect.top+(arect.bottom-arect.top-textheight(n))div 2,n);
  end;
end;

procedure tpltextdlg.selectmenuitem;
begin
  font.text:=tmenuitem(sender).caption;
end;

procedure tpltextdlg.measureitem;
begin
  acanvas.font.name:=tmenuitem(sender).caption;
  acanvas.font.height:=schrift;
  width:=acanvas.textwidth(tmenuitem(sender).caption);
  height:=menuheight;
end;

procedure pldlgcb(s:string);
begin
  mypltextdlg.Font.text:=s;
end;

procedure Tpltextdlg.fontContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  popupfontmenu((sender as tedit).clienttoscreen(mousepos),@pldlgcb);
  handled:=true;
end;

procedure Tpltextdlg.pt1LeftClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pagesdlg.colordialog.color:=(sender as tcolorfield).color;
  if pagesdlg.colordialog.execute then (sender as tcolorfield).color:=pagesdlg.colordialog.color;
end;

procedure Tpltextdlg.pt1RightClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (sender as tcolorfield).color:=getcolor((sender as tcolorfield).color);
end;


procedure Tpltextdlg.fontChange(Sender: TObject);
var
i,j:integer;
s:string;
begin
  if inchange then exit;
  if length(font.text)<=length(oldtext) then
  begin
    oldtext:=font.text;
    exit;
  end;
  oldtext:=font.text;
  inchange:=true;
  s:=font.text;
  for i:=0 to screen.fonts.count-1 do if grosswort(copy(screen.fonts[i],1,length(s)))=grosswort(s)then
  begin
    j:=length(s);
    font.text:=screen.fonts[i];
    font.selstart:=j;
    font.sellength:=length(font.text)-j;
    break;
  end;
  inchange:=false;
end;

procedure Tpltextdlg.Button1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
