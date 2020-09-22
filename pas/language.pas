unit language;
{$I cs.inc}
interface

uses classes,funktionen;

procedure setlanguage;

const
maxlang=50;

function loadstringfromfile(nr:integer;filename:string):string;
function loadstring(nr:integer):string;
function stringexists(nr:integer;filename:string):boolean;
procedure setstrings(t:tstrings;startnr:integer;count:integer);
procedure searchlanguages;
procedure initlanguages;
procedure donelanguages;

function l_title:string;

var
currentlanguage:integer;
langfiles:array[1..maxlang+1]of string;

implementation

uses main,windows,flowform,info,pltext,regions,saveform,viscolor,artwork,
     cheatdlg,sysutils,menus,forms,sascha,searchcolor,mbtext,
     cureditor,ctest;

type
planguagefile=pointer;

var
warning:boolean;
sprachdatei:planguagefile;

const
dll='skinampc.dll';
max_char=512;

// Import external funcions
function extractprefix(s:pchar):integer; cdecl; external dll index 30; 
function extractsuffix(s,r:pchar):boolean; cdecl; external dll index 31; overload;
function createlanguagefile(filename:pchar;cacheing:boolean):planguagefile; cdecl; external dll index 32;
procedure destroylanguagefile(lf:planguagefile); cdecl; external dll index 33;
function getlanguagefilestring(lf:planguagefile;nr:integer;r:pchar):boolean; cdecl; external dll index 34;
function getlanguagefilename(lf:planguagefile):pchar; cdecl; external dll index 35;

// Overload external functions



function extractsuffix(s:string):string; overload;
var
a:array[0..max_char]of char;
begin
  if extractsuffix(pchar(s),@a[0])=true then result:=string(a) else result:='';
end;



function fileexists(fn:string):boolean;
var
f:file;
begin
  result:=true;
  filemode:=0;
  assignfile(f,fn);
  {$I-}
  reset(f);
  {$I+}
  if ioresult<>0 then result:=false else closefile(f);
end;


function loadstringfromfile;
var
d:textfile;
s,a,e:string;
i,j:integer;
begin
  if fileexists(progdir+filename)=false then
  begin
    result:=loadstringid(12);
    exit;
  end;
  assignfile(d,progdir+filename);
  filemode:=0;
  { $I-}
  reset(d);
  { $I+}
  if ioresult<>0 then
  begin
    result:=loadstringid(11)+str(nr)+']';
    exit;
  end;
  repeat
    readln(d,s);
    a:=trim(copy(s,0,pos('=',s)-1));
    val(a,i,j);
  until (eof(d))or((j=0)and(i=nr));
  e:=copy(s,pos('=',s)+1,length(s)-pos('=',s));
  if (j=0)and(i=nr)then
  begin
    if e[1]='*' then e:=copy(e,2,length(e)-1);
    if e[length(e)]='*' then e:=copy(e,1,length(e)-1);
    result:=e;
  end
  else begin
    if grosswort(filename)<>'ENGLISH.LNG' then result:='*'+loadstringfromfile(nr,'english.lng')+'*';
    if warning then
    begin
      if pagesdlg.splash=0 then
        application.messagebox(pchar('Error loading String '+str(nr)+#13+result),'Error!',mb_ok or mb_iconinformation)
      else
        messagebox(pagesdlg.splash,pchar('Error loading String '+str(nr)+#13+result),'Error!',mb_ok or mb_iconinformation);

    end;
  end;
  close(d);
end;

function loadstring;
var
s:string;
a:array[0..max_char]of char;
p:pchar;
begin
  if currentlanguage=0 then
  begin
    case nr of
      11:result:=loadstringid(17);
      13:result:=loadstringid(18);
      30:result:='SkinAmp';
      else result:='';
    end;
  end else
  begin
    if sprachdatei=nil then
      result:=loadstringfromfile(nr,langfiles[currentlanguage])
    else begin
      getlanguagefilestring(sprachdatei,nr,@a[0]);
      s:=extractsuffix(a);
      if s='' then
      begin
        p:=getlanguagefilename(sprachdatei);
        if grosswort(string(p))<>'ENGLISH.LNG' then s:='*'+loadstringfromfile(nr,'english.lng')+'*';
        if (warning) then
          case application.messagebox(pchar('Error loading String '+str(nr)+#13+s+#13+'Continue warning?'),'Error!',mb_yesno) of
            id_no:warning:=false;
          end;
      end else
      begin
        if (length(s)>1)and(s[1]='*')then s:=copy(s,2,length(s)-1);
      end;
      result:=s;
    end;
  end;
end;

function stringexists;
var
d:textfile;
s,a:string;
i,j:integer;
begin
  if fileexists(progdir+filename)=false then
  begin
    result:=false;
    exit;
  end;
  assignfile(d,progdir+filename);
  filemode:=0;
  { $I-}
  reset(d);
  { $I+}
  if ioresult<>0 then
  begin
    result:=false;
    exit;
  end;
  repeat
    readln(d,s);
    a:=trim(copy(s,0,pos('=',s)-1));
    val(a,i,j);
  until (eof(d))or((j=0)and(i=nr));
  if (j=0)and(i=nr)then
  begin
    result:=true;
    exit;
  end
  else result:=false;
  close(d);
end;

function l_title;
begin
  result:=loadstring(30);
end;

procedure setstrings(t:tstrings;startnr:integer;count:integer);
var
i:integer;
begin
  for i:=startnr to startnr+count-1 do t[i-startnr]:=loadstring(i);
end;

procedure setlanguage;
procedure setmenu;
procedure menuitem(nr1,nr2:integer;s:string);
begin
  pagesdlg.menu.items.items[nr1].items[nr2].caption:=s;
end;
begin
  with pagesdlg do
  begin
    with menu.items do
    begin
      programm1.caption:=loadstring(100);
      programm1.items[0].caption:=loadstring(101);
      programm1.items[1].caption:=loadstring(102);
      programm1.items[2].caption:=loadstring(105);
      programm1.items[4].caption:=loadstring(106);
      programm1.items[6].caption:=loadstring(103);
      programm1.items[7].caption:=loadstring(107);
      programm1.items[9].caption:=loadstring(104);

      items[1].caption:=loadstring(110);

      template1.caption:=loadstring(150);
      template1.items[0].caption:=loadstring(151);
      template1.items[1].caption:=loadstring(152);
      template1.items[3].caption:=loadstring(127);
      template1.items[5].caption:=loadstring(153);
      template1.items[6].caption:=loadstring(154);

      voreinstellung1.caption:=loadstring(111);
      voreinstellung1.items[0].caption:=loadstring(112);
      voreinstellung1.items[1].caption:=loadstring(113);
      voreinstellung1.items[2].caption:=loadstring(114);
      
      main1.caption:=loadstring(115);
      main1.items[0].caption:=loadstring(116);
      main1.items[1].caption:=loadstring(117);
      main1.items[2].caption:=loadstring(118);
      main1.items[3].caption:=loadstring(119);
      
      equalizer1.caption:=loadstring(120);
      equalizer1.items[0].caption:=loadstring(121);
      equalizer1.items[1].caption:=loadstring(122);
      playlist1.caption:=loadstring(123);
      playlist1.items[0].caption:=loadstring(573);
      minibrowser1.caption:=loadstring(128);
      minibrowser1.items[0].caption:=loadstring(573);
      avs1.caption:=loadstring(620);
      avs1.items[0].caption:=loadstring(907);
      cursors1.caption:=loadstring(632);
      speichern2.caption:=loadstring(125);
      laden1.caption:=loadstring(126);
      standard1.caption:=loadstring(127);
      
      sprachen1.caption:=loadstring(130);
      hilfe1.caption:=loadstring(140);
      hilfe1.items[0].caption:=loadstring(140);
      hilfe1.items[2].caption:=loadstring(141);
    end;
  end;
end;
procedure setmainwindow;
begin
  with pagesdlg do
  begin
    button2.caption:=loadstring(550);
    button11.caption:=loadstring(551);
    button3.caption:=loadstring(552);

    pagecontrol.Pages[0].caption:=loadstring(553);
    button1.caption:=loadstring(554);
    button14.caption:=loadstring(573);
    button8.caption:=loadstring(555);
    button13.caption:=loadstring(556);
    cliptyp.caption:=loadstring(557);
    setstrings(cliptyp.items,558,3);
    radiogroup2.caption:=loadstring(561);
    setstrings(radiogroup2.items,562,3);
    radiogroup6.caption:=loadstring(565);
    setstrings(radiogroup6.items,566,2);
    radiogroup5.caption:=loadstring(568);
    setstrings(radiogroup5.items,569,3);
    groupbox1.caption:=loadstring(572);
    label8.caption:=loadstring(517);
    label9.caption:=loadstring(518);
    label10.caption:=loadstring(1203);
    button16.caption:=loadstring(632);

    pagecontrol.Pages[1].caption:=loadstring(580);   // Main
    label1.caption:=loadstring(500);
    buttons.caption:=loadstring(503);
    setstrings(buttons.items,504,3);
    checkbox3.caption:=loadstring(501);
    checkbox4.caption:=loadstring(502);
    button6.caption:=loadstring(581);
    button10.caption:=loadstring(582);
    button7.caption:=loadstring(583);
    button12.caption:=loadstring(584);
    setstrings(options.items,507,10);

    pagecontrol.Pages[2].caption:=loadstring(590);   // EQ
    label2.caption:=loadstring(500);
    checkbox1.caption:=loadstring(501);
    checkbox2.caption:=loadstring(502);
    checkbox14.caption:=loadstring(525);
    radiogroup1.caption:=loadstring(503);
    setstrings(radiogroup1.items,504,3);
    setstrings(eqoptions.items,520,5);
    button4.caption:=loadstring(591);
    button5.caption:=loadstring(592);

    pagecontrol.Pages[3].caption:=loadstring(600);   // PL
    label3.caption:=loadstring(500);
    setstrings(radiogroup3.items,504,3);
    radiogroup3.caption:=loadstring(503);
    checkbox5.caption:=loadstring(501);
    checkbox6.caption:=loadstring(502);
    setstrings(ploptions.items,530,4);
    button9.caption:=loadstring(601);
    radiogroup7.caption:=loadstring(534);
    setstrings(radiogroup7.items,535,2);
    checkbox12.caption:=loadstring(537);

    pagecontrol.Pages[4].caption:=loadstring(610);   //MB
    label4.caption:=loadstring(500);
    setstrings(radiogroup4.items,504,3);
    radiogroup4.caption:=loadstring(503);
    checkbox7.caption:=loadstring(501);
    checkbox8.caption:=loadstring(502);
    setstrings(mboptions.items,540,2);
    radiogroup8.caption:=loadstring(542);
    setstrings(radiogroup8.items,535,2);
    checkbox13.caption:=loadstring(537);
    button15.caption:=loadstring(601);
    label1.caption:=loadstring(543);


    pagecontrol.Pages[5].caption:=loadstring(620);   // AVS
    label5.caption:=loadstring(500);
    checkbox9.caption:=loadstring(501);
    checkbox10.caption:=loadstring(502);

    pagecontrol.Pages[6].caption:=loadstring(630);   // Readme
    checkbox11.caption:=loadstring(631);
  end;
end;
procedure setdialogs;
procedure regions;
begin
  with regionsdlg do
  begin
    checkbox1.caption:=loadstring(1100);
    label1.caption:=loadstring(1101);
    label2.caption:=loadstring(1102);
    button1.caption:=loadstring(901);
    button3.caption:=loadstring(1103);
    button4.caption:=loadstring(1104);
    speedbutton1.caption:=loadstring(551);
    button2.caption:=loadstring(905);
    caption:=loadstring(1105);
    setstrings(what.items,1106,4);
  end;
end;
procedure viscolor;
begin
  with viscolordlg do
  begin
    statictext1.caption:=loadstring(18);
    statictext2.caption:=loadstring(19);
    statictext3.caption:=loadstring(22);
    statictext4.caption:=loadstring(23);
    button1.caption:=loadstring(900);
    button4.caption:=loadstring(900);
    groupbox1.caption:=loadstring(1200);
    groupbox2.caption:=loadstring(1201);
    groupbox3.caption:=loadstring(1202);
    button2.caption:=loadstring(901);
    label1.caption:=loadstring(1203);
    label2.caption:=loadstring(1204);
    label3.caption:=loadstring(1205);
    button3.caption:=loadstring(905);
    caption:=loadstring(1206);
  end;
end;
begin
  flowdlg.caption:=loadstring(1320);
  flowdlg.frame.label1.caption:=loadstring(904);
  flowdlg.Button1.caption:=loadstring(902);
  flowdlg.Button2.caption:=loadstring(903);
  flowdlg.button3.caption:=loadstring(1300);
  flowdlg.button4.caption:=loadstring(906);
  regions;
  viscolor;
end;
var
i:integer;
begin
  if (currentlanguage=0)or(fileexists(progdir+langfiles[currentlanguage])=false) then exit;

  warning:=true;
  sprachdatei:=createlanguagefile(pchar(progdir+langfiles[currentlanguage]),true);
  setmenu;
  setmainwindow;
  setdialogs;
  destroylanguagefile(sprachdatei);
  sprachdatei:=nil;

  for i:=1 to maxlang do if langfiles[i]<>'' then pagesdlg.mainmenu.items[2].items[i-1].checked:=false;
  if currentlanguage<>0 then pagesdlg.mainmenu.items[2].items[currentlanguage-1].checked:=true;
end;


procedure searchlanguages;
var
dirinfo:tsearchrec;
s:string;
mi:tmenuitem;
i:integer;
names:array[1..maxlang]of string;

procedure sortlanguages;
var
b:boolean;
zhl:byte;
d:string;
function getn(i:integer):string;
begin
  result:=names[i];
  while (pos('&',result)>0) do delete(result,pos('&',result),1);
end;
begin
  repeat
    b:=false;
    for zhl:=1 to maxlang-1 do if (langfiles[zhl]<>'')and(langfiles[zhl+1]<>'')and(grosswort(getn(zhl))>grosswort(getn(zhl+1)))then
    begin
      d:=langfiles[zhl];
      langfiles[zhl]:=langfiles[zhl+1];
      langfiles[zhl+1]:=d;
      d:=names[zhl];
      names[zhl]:=names[zhl+1];
      names[zhl+1]:=d;

      b:=true;
    end;
  until b=false;
end;

begin
  for i:=1 to maxlang do
  begin
    langfiles[i]:='';
    names[i]:='';
  end;
  i:=1;
  if findfirst(progdir+'*.lng',faarchive,dirinfo)=0 then
  repeat
    s:=loadstringfromfile(0,dirinfo.name);
    if (copy(s,1,length(loadstringid(11)))<>loadstringid(11))and
      (copy(s,1,1)<>'*') then
    begin
      names[i]:=s;
      langfiles[i]:=dirinfo.Name;
      inc(i);
    end;
  until (findnext(dirinfo)<>0)or(i>maxlang);
  findclose(dirinfo);

  sortlanguages;

  pagesdlg.mainmenu.Items[2].Clear;
  for i:=1 to maxlang do if langfiles[i]<>'' then
  begin
    mi:=tmenuitem.create(pagesdlg.mainmenu.items[2]);
    mi.caption:=names[i];
    mi.onclick:=pagesdlg.lang_select;
    mi.tag:=i;
    mi.radioitem:=true;
    pagesdlg.mainmenu.items[2].add(mi);
  end;
end;


procedure initlanguages;
var
i:integer;
begin
  for i:=1 to maxlang do langfiles[i]:='';
  searchlanguages;
  currentlanguage:=0;
  for i:=1 to maxlang do if grosswort(langfiles[i])='ENGLISH.LNG' then currentlanguage:=i;
end;

procedure donelanguages;
begin

end;

var
i:integer;
begin
  sprachdatei:=nil;
  currentlanguage:=0;
  for i:=1 to maxlang do langfiles[i]:='';
end.
