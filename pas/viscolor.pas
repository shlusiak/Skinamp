unit viscolor;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ColorField,skinampc,konstanten,funktionen;

type
  Tviscolordlg = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Button4: TButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button3: TButton;
    OpenDialog: TOpenDialog;
    spec1: TColorField;
    spec2: TColorField;
    spec3: TColorField;
    spec4: TColorField;
    spec5: TColorField;
    spec6: TColorField;
    spec7: TColorField;
    spec8: TColorField;
    spec9: TColorField;
    spec10: TColorField;
    spec11: TColorField;
    spec12: TColorField;
    spec13: TColorField;
    spec14: TColorField;
    spec15: TColorField;
    spec16: TColorField;
    osc1: TColorField;
    osc2: TColorField;
    osc3: TColorField;
    osc4: TColorField;
    osc5: TColorField;
    s1: TColorField;
    s2: TColorField;
    s3: TColorField;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure spec1LeftClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure spec1RightClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function spec(nr:integer):tcolorfield;
    function osc(nr:integer):tcolorfield;
  end;

var
  viscolordlg: Tviscolordlg;

procedure saveviscolor(verz:pchar);

implementation

uses main,bmps, flowform,sascha,language,searchcolor;

{$R *.DFM}

var
vac:array[1..16]of tcolorref;
voc:array[1..5]of tcolorref;


procedure saveviscolor;
var
f:textfile;
i:integer;
procedure writergb(c:tcolorref;text:string;last:boolean);
var
s:string;
begin
  s:=str(getrvalue(c))+','+str(getgvalue(c))+','+str(getbvalue(c));
  if not last then s:=s+',';
  write(f,s);
  if text<>'' then writeln(f,stringofchar(' ',3-(length(s)-12))+'// '+text)else writeln(f);
end;
begin
  assignfile(f,verz+'viscolor.txt');
  rewrite(f);
  writergb(viscolordlg.s1.color,'Background',false);
  writergb(viscolordlg.s2.color,'Dots',false);
  for i:=1 to 16 do writergb(viscolordlg.spec(i).color,'Analyzer',false);
  for i:=1 to 5 do writergb(viscolordlg.osc(i).color,'Osc',false);
  writergb(viscolordlg.s3.color,'Peaks',true);
  writeln(f);
  writeln(f,'// '+loadstringid(16));

  closefile(f);
end;

function tviscolordlg.spec;
begin
  case nr of
    1:result:=spec1;
    2:result:=spec2;
    3:result:=spec3;
    4:result:=spec4;
    5:result:=spec5;
    6:result:=spec6;
    7:result:=spec7;
    8:result:=spec8;
    9:result:=spec9;
    10:result:=spec10;
    11:result:=spec11;
    12:result:=spec12;
    13:result:=spec13;
    14:result:=spec14;
    15:result:=spec15;
    16:result:=spec16;
    else result:=nil;
  end;
end;

function tviscolordlg.osc;
begin
  case nr of
    1:result:=osc1;
    2:result:=osc2;
    3:result:=osc3;
    4:result:=osc4;
    5:result:=osc5;
    else result:=nil;
  end;
end;

procedure Tviscolordlg.Button1Click(Sender: TObject);
procedure cb(i:integer;c:tcolorref); cdecl;
begin
  vac[i]:=c;
end;
var
i:integer;
begin
  flowdlg.frame.text1.caption:=loadstring(18);
  flowdlg.frame.text2.caption:=loadstring(19);
  if flowdlg.showmodal=mrok then
  begin
    multiflow(1,16,
    flowdlg.Frame.getcolor(1),
    flowdlg.Frame.getcolor(2),
    flowdlg.Frame.getcolor(3),
    flowdlg.Frame.getcolor(4),
    flowdlg.Frame.getcolor(5),flowdlg.frame.getnum,@cb);
    for i:=1 to 16 do spec(i).color:=vac[i];
  end;
end;

procedure Tviscolordlg.Button4Click(Sender: TObject);
procedure cb(i:integer;c:tcolorref); cdecl;
begin
  voc[i]:=c;
end;
var
i:integer;
begin
  flowdlg.frame.text1.caption:=loadstring(22);
  flowdlg.frame.text2.caption:=loadstring(23);
  if flowdlg.showmodal=mrok then
  begin
    multiflow(1,5,
    flowdlg.Frame.getcolor(1),
    flowdlg.Frame.getcolor(2),
    flowdlg.Frame.getcolor(3),
    flowdlg.Frame.getcolor(4),
    flowdlg.Frame.getcolor(5),flowdlg.frame.getnum,@cb);
    for i:=1 to 5 do osc(i).color:=voc[i];
  end;
end;

procedure Tviscolordlg.FormCreate(Sender: TObject);
procedure cb1(nr:integer;c:colorref); cdecl;
begin
  vac[nr]:=c;
end;
var
i:integer;
begin
  multiflow(1,16,rgb(255,0,0),rgb(255,255,0),rgb(0,255,0),rgb(0,255,255),rgb(0,0,255),5,@cb1);
  voc[1]:=rgb(196,196,196);
  voc[2]:=rgb(160,160,160);
  voc[3]:=rgb(128,128,128);
  voc[4]:=rgb(92,92,92);
  voc[5]:=rgb(48,48,48);

  for i:=1 to 16 do spec(i).color:=vac[i];
  for i:=1 to 5 do osc(i).color:=voc[i];
  s1.color:=rgb(0,0,0);
  s2.color:=rgb(32,32,32);
  s3.color:=rgb(224,224,224);
  setids(self);
end;

procedure Tviscolordlg.Button3Click(Sender: TObject);
var
f:textfile;
function readrgb(t:tcolorfield):boolean;
function readvalue:byte;
var
s:String;
c,oc:char;
i,e:integer;
begin
  c:='-';
  repeat
    oc:=c;
    read(f,c);
    if (eof(f)) then
    begin
      result:=0;
      exit;
    end;
    if (oc='/')and(c='/')then
    begin
      readln(f,s);
      c:='-';
    end;
  until c in ['0'..'9'];
  s:='';
  repeat
    s:=s+c;
    {$I-}
    read(f,c);
    {$I+}
    if eof(f) then
    begin
      result:=0;
      exit;
    end;
  until (c in ['0'..'9'])=false;
  if s<>'' then val(s,i,e) else
  begin
    i:=0;
    e:=0;
  end;
//  if e<>0 then runerror;
  result:=i;
end;
var
r,g,b:tcolorref;
begin
  readrgb:=true;
  r:=readvalue;
  g:=readvalue;
  b:=readvalue;
  t.color:=rgb(r,g,b);
end;
var
i:integer;
begin
  { Laden... }
  if opendialog.execute then
  begin
    assignfile(f,opendialog.filename);
    {$I-}
    reset(f);
    {$I+}
    if ioresult<>0 then runerror;

    readrgb(s1);
    readrgb(s2);
    for i:=1 to 16 do readrgb(spec(i));
    for i:=1 to 5 do readrgb(osc(i));
    readrgb(s3);

    closefile(f);
  end;
end;

procedure Tviscolordlg.spec1LeftClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  pagesdlg.colordialog.color:=(sender as tcolorfield).color;
  if pagesdlg.colordialog.execute then (sender as tcolorfield).color:=pagesdlg.colordialog.color;
end;

procedure Tviscolordlg.spec1RightClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  (sender as tcolorfield).color:=getcolor((sender as tcolorfield).color);
end;

procedure Tviscolordlg.GroupBox1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
