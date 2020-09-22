unit funktionen;
{$I cs.inc}

interface

uses windows,classes,stdctrls,konstanten,messages,skinampc,forms,controls,
  extctrls,checklst,commdlg;

type
tcb=procedure(f:string); far;
trunthread=class(tthread)
  cmd,path:string;
  next:trunthread;
  constructor create(vpath,vcmd:string);
  procedure execute; override;
  procedure add(n:trunthread);
end;


procedure saveskinfile(f:string);
procedure loadskinfile(f:string);
procedure popupfontmenu(p:tpoint;cb:tcb);
function loadstringid(id:integer):string;
procedure setids(window:tform);
procedure runcontexthelp(wer:twincontrol);

function getsavefile(owner:hwnd;filter:string;maxfilter:integer):string;
function getopenfile(owner:hwnd;filter:string;maxfilter:integer):string;

implementation

uses
inifiles,main,sascha,cheatdlg,sysutils,wmain,viscolor,
weq,pltext,mbtext,wavs,wmb,artwork,regions,bmps,graphics,
menus,language,saveform,cureditor;


const
s_options='Options';
s_picture='Picture';
s_main='Main';
s_eq='EQ';
s_pl='PL';
s_mb='MB';
s_btempl='BitmapsTemplate';
s_mtempl='MasksTemplate';

return=#$d#$a;


var
rt:trunthread;


constructor trunthread.create;
begin
  next:=nil;
  inherited create(rt<>nil);
  if rt=nil then rt:=self else rt.add(self);
  freeonterminate:=true;
  cmd:=vcmd;
  path:=vpath;
end;

procedure trunthread.execute;
var
startinfo:tstartupinfo;
pi:tprocessinformation;
begin
  zeromemory(@startinfo,sizeof(startinfo));
  StartInfo.cb:=sizeof(TSTARTUPINFO);
  StartInfo.dwFlags:=STARTF_USESHOWWINDOW or STARTF_USEPOSITION or STARTF_USESIZE;
  StartInfo.wShowWindow:=sw_show;

  createprocess(pchar(path),
                pchar(path+' '+cmd),
                nil,
                nil,
                false,
                create_new_process_group,
                nil,
                nil,
                startinfo,
                pi);
  waitforinputidle(pi.hProcess,infinite);
  if next<>nil then next.resume else rt:=nil;
end;

procedure trunthread.add;
begin
  if next=nil then next:=n else next.add(n);
end;



function makehex(i:byte):string;
var
s2:string;
begin
  s2:=format('%x',[i]);
  while length(s2)<2 do s2:='0'+s2;
  result:=s2;
end;

function hexcolor(c:tcolorref):string;
begin
  result:=makehex(getrvalue(c))+makehex(getgvalue(c))+makehex(getbvalue(c));
end;

procedure saveskinfile;
var
i:tinifile;
s:string;
procedure savepicture;
procedure kunst;
var
j:integer;
begin
  i.writestring(s_picture,'Art',str(pagesdlg.artr.direction)+str(pagesdlg.artr.bis)+str(pagesdlg.artr.numcolors));
  s:='';
  for j:=1 to 5 do s:=s+hexcolor(pagesdlg.artr.colors[j]);
  i.writestring(s_picture,'Artcolors',s);
end;
procedure regionen;
var
j,k:integer;
begin
  for j:=0 to 3 do with regionsdlg do
  begin
    what.itemindex:=j;
    for k:=1 to getrrec.polynum do
    begin
      polnum.position:=k;
      fuetter;
      s:=pointlist.lines.text;
      if s<>'' then i.WriteString('Regions',str(j)+str(k),s);
    end;
  end;
  regionsdlg.what.itemindex:=0;
  regionsdlg.polnum.position:=1;
end;
var
j:integer;
begin
  with pagesdlg do
  begin
    s:=str(cliptyp.itemindex)+str(radiogroup2.itemindex)+str(radiogroup6.itemindex);
    i.writestring(s_picture,s_options,s);
    i.writeinteger(s_picture,'FromX',fromx);
    i.writeinteger(s_picture,'FromY',fromy);
    i.writestring(s_picture,'ScaleX',edit6.text);
    i.writestring(s_picture,'ScaleY',edit7.text);
    i.writestring(s_picture,'Filename',loadedfilename);

    i.writestring('Font','Name',fontdialog.font.name);
    i.writeinteger('Font','Size',fontdialog.font.size);
    i.writeinteger('Font','Color',fontdialog.font.color);
    with fontdialog.font do j:=
      byte(fsbold in style)*1000+
      byte(fsitalic in style)*100+
      byte(fsunderline in style)*10+
      byte(fsstrikeout in style)*1;
    i.writeinteger('Font','Style',j);
  end;
  i.writeinteger(s_picture,'SavedZipped',byte(pagesdlg.saveskinr.zipped));
  i.writestring(s_picture,'SaveName',pagesdlg.saveskinr.dir);
  i.writestring(s_picture,s_btempl,bitmapsfile);
  i.writestring(s_picture,s_mtempl,masksfile);
  kunst;
  regionen;
end;
procedure savemain;
var
j:integer;
procedure volume;
var
j:integer;
begin
  s:='';
  for j:=0 to 27 do begin
    s:=s+hexcolor(wmain.volume[j]);
  end;
  i.writestring(s_main,'Volume',s);
end;
procedure visc;
var
j:integer;
begin
  s:='';
  for j:=1 to 16 do begin
    s:=s+hexcolor(viscolordlg.spec(j).color);
  end;
  for j:=1 to 5 do begin
    s:=s+hexcolor(viscolordlg.osc(j).color);
  end;
  s:=s+hexcolor(viscolordlg.s1.color);
  s:=s+hexcolor(viscolordlg.s2.color);
  s:=s+hexcolor(viscolordlg.s3.color);

  i.writestring(s_main,'Visualization',s);
end;
procedure balance;
var
j:integer;
begin
  s:='';
  for j:=0 to 27 do begin
    s:=s+hexcolor(wmain.balance[j]);
  end;
  i.writestring(s_main,'Balance',s);
end;
begin
  with pagesdlg do
  begin
    i.writestring(s_main,'Title',edit1.text);
    s:=str(buttons.itemindex)+str(byte(checkbox3.checked))+str(byte(checkbox4.checked));
    for j:=0 to 9 do case options.state[j] of
      cbunchecked:s:=s+'0';
      cbchecked:s:=s+'1';
      cbgrayed:s:=s+'2';
    end;
    i.writestring(s_main,s_options,s);
    i.writestring(s_main,'Time',hexcolor(colorfield1.color));
    i.writestring(s_main,'Song',hexcolor(colorfield2.color));
    i.writestring(s_main,'Background',hexcolor(colorfield3.color));
  end;
  volume;
  visc;
  balance;
  i.writestring(s_main,'Skincheat',pagesdlg.cheattext);
end;
procedure saveeq;
var
j:integer;
procedure kurve;
var
j:integer;
begin
  s:='';
  for j:=1 to 19 do s:=s+hexcolor(eqbezier[j]);
  i.writestring(s_eq,'Bezier',s);
end;
procedure regler;
var
j:integer;
begin
  s:='';
  for j:=0 to 27 do s:=s+hexcolor(eqbar[j]);
  i.writestring(s_eq,'Bars',s);
end;
begin
  i.writeinteger(s_eq,'On',integer(pagesdlg.checkbox14.checked));
  i.writestring(s_eq,'Title',pagesdlg.edit2.text);
  s:=str(pagesdlg.radiogroup1.itemindex)+str(byte(pagesdlg.checkbox1.checked))+str(byte(pagesdlg.checkbox2.checked));
  for j:=0 to 4 do s:=s+str(byte(pagesdlg.eqoptions.checked[j]));
  i.writestring(s_eq,s_options,s);
  kurve;
  regler;
end;
procedure savepl;
var
j:integer;
procedure text;
var
j:integer;
begin
  s:='';
  for j:=1 to 4 do s:=s+hexcolor(pagesdlg.textr.pl[j]);
  i.writestring(s_pl,'Text',s);
  i.writestring(s_pl,'Font',pagesdlg.textr.font);
end;
begin
  i.writestring(s_pl,'Title',pagesdlg.edit3.text);
  s:=str(pagesdlg.radiogroup3.itemindex)+str(byte(pagesdlg.checkbox5.checked))+str(byte(pagesdlg.checkbox6.checked))+str(byte(pagesdlg.checkbox12.checked))+str(byte(pagesdlg.radiogroup7.itemindex));
  for j:=0 to 3 do s:=s+str(byte(pagesdlg.ploptions.checked[j]));
  i.writestring(s_pl,s_options,s);
  text;
end;
procedure savemb;
var
j:integer;
procedure text;
begin
  s:=hexcolor(pagesdlg.textr.mb[1])+hexcolor(pagesdlg.textr.mb[2]);
  i.writestring(s_mb,'Text',s);
end;
begin
  i.writestring(s_mb,'Title',pagesdlg.edit4.text);
  s:=str(pagesdlg.radiogroup4.itemindex)+str(byte(pagesdlg.checkbox7.checked))+str(byte(pagesdlg.checkbox8.checked))+str(byte(pagesdlg.checkbox13.checked))+str(byte(pagesdlg.radiogroup8.itemindex));
  for j:=0 to 1 do s:=s+str(byte(pagesdlg.mboptions.checked[j]));
  i.writestring(s_mb,s_options,s);
  i.writestring(s_mb,'Site',pagesdlg.edit8.text);
  text;
end;
procedure saveavs;
begin
  i.writestring('AVS','Title',pagesdlg.edit5.text);
  s:=str(byte(pagesdlg.checkbox9.checked))+str(byte(pagesdlg.checkbox10.checked));
  i.writestring('AVS',s_options,s);
end;
procedure savereadme;
var
s:string;
begin
  i.writebool('Readme','Advertisment',pagesdlg.checkbox11.checked);
  s:=pagesdlg.readme.lines.text;
  while pos(return,s)>0 do
  begin
    insert('\n',s,pos(return,s));
    delete(s,pos(return,s),length(return));
  end;
  i.writestring('Readme','Readme',s);
end;

begin
  if fileexists(f) then deletefile(f);
  i:=tinifile.create(f);

  savepicture;
  savemain;
  saveeq;
  savepl;
  savemb;
  saveavs;
  savereadme;

  i.UpdateFile;
  i.free;
end;



function extractnum(s:string;i:integer):integer;
var
j,k:integer;
begin
  val(copy(s,i,1),j,k);
  if k<>0 then j:=0;
  result:=j;
end;

function extractcolor(s:string;i:integer):tcolorref;
function c(nr:integer):byte;
var
j,k:integer;
s2:string;
begin
  s2:=copy(s,nr,2);
  val('$'+s2,j,k);
  if k<>0 then j:=0;
  result:=j;
end;
begin
  s:=copy(s,((i-1)*6)+1,6);
  result:=rgb(c(1),c(3),c(5));
end;



procedure loadskinfile;
var
i:tinifile;
s:string;
procedure loadpicture;
procedure kunst;
var
j:integer;
begin
  s:=i.readstring(s_picture,'Art',str(pagesdlg.artr.direction)+str(pagesdlg.artr.bis)+str(pagesdlg.artr.numcolors));
  pagesdlg.artr.direction:=extractnum(s,1);
  pagesdlg.artr.bis:=extractnum(s,2);
  pagesdlg.artr.numcolors:=extractnum(s,3);
  with pagesdlg.artr do
  begin
    s:=i.readstring(s_picture,'Artcolors',hexcolor(colors[1])+hexcolor(colors[2])+hexcolor(colors[3])+hexcolor(colors[4])+hexcolor(colors[5]));
    for j:=1 to 5 do colors[j]:=extractcolor(s,j);
  end;
end;
procedure regionen;
var
j,k:integer;
begin
  for j:=0 to 3 do with regionsdlg do
  begin
    what.itemindex:=j;
    getrrec.polynum:=1;
    polnum.position:=1;
    polnum.max:=1;
    polnum.enabled:=false;
    for k:=1 to Regions.maxpolygon do
    begin
      s:=i.readstring('Regions',str(j)+str(k),'');
      if s<>'' then
      begin
        if k>1 then button3click(button3);
        polnum.position:=k;
        pointlist.lines.text:=s;
      end;
    end;
  end;
  regionsdlg.what.itemindex:=0;
  regionsdlg.polnum.position:=1;
end;
var
j:integer;
begin
  assignbitmapsfile(i.readstring(s_picture,s_btempl,defaultbitmapsfile));
  assignmasksfile(i.readstring(s_picture,s_mtempl,defaultmasksfile));
  with pagesdlg do
  begin
    s:=i.readstring(s_picture,s_options,str(cliptyp.itemindex)+str(radiogroup2.itemindex)+str(radiogroup5.itemindex)+str(radiogroup6.itemindex));

    cliptyp.itemindex:=extractnum(s,1);
    radiogroup2.itemindex:=extractnum(s,2);
    radiogroup6.itemindex:=extractnum(s,3);
    edit6.text:=i.readstring(s_picture,'ScaleX','100');
    edit7.text:=i.readstring(s_picture,'ScaleY','100');
    prozentx:=i.readinteger(s_picture,'ScaleX',100);
    prozenty:=i.readinteger(s_picture,'Scaley',100);
    fromx:=i.readinteger(s_picture,'FromX',0);
    fromy:=i.readinteger(s_picture,'FromY',0);
    loadedfilename:=i.readstring(s_picture,'Filename','');

    fontdialog.font.name:=i.readstring('Font','Name',fontdialog.font.name);
    fontdialog.font.size:=i.readinteger('Font','Size',fontdialog.font.size);
    fontdialog.font.color:=i.readinteger('Font','Color',fontdialog.font.color);
    with fontdialog.font do
    begin
      j:=byte(fsbold in style)*1000+
         byte(fsitalic in style)*100+
         byte(fsunderline in style)*10+
         byte(fsstrikeout in style)*1;
      j:=i.readinteger('Font','Style',j);
      style:=[];
      if ((j div 1000)mod 10=1) then style:=style+[fsbold];
      if ((j div 100)mod 10=1) then style:=style+[fsitalic];
      if ((j div 10)mod 10=1) then style:=style+[fsunderline];
      if ((j div 1)mod 10=1) then style:=style+[fsstrikeout];
    end;
    pagesdlg.saveskinr.zipped:=boolean(i.readinteger(s_picture,'SavedZipped',1));
    if i.readstring(s_picture,'SaveName','-')<>'-' then pagesdlg.saveskinr.dir:=i.readstring(s_picture,'SaveName','MySkin');
  end;
  kunst;
  regionen;
end;
procedure loadmain;
var
j:integer;
procedure volume;
var
j:integer;
begin
  s:='';
  for j:=0 to 27 do begin
    s:=s+makehex(getrvalue(wmain.volume[j]))+makehex(getgvalue(wmain.volume[j]))+makehex(getbvalue(wmain.volume[j]))
  end;
  s:=i.readstring(s_main,'Volume',s);
  for j:=0 to 27 do begin
    wmain.volume[j]:=extractcolor(s,j+1);
  end;
end;
procedure visc;
var
j:integer;
begin
  s:='';
  for j:=1 to 16 do begin
    s:=s+hexcolor(viscolordlg.spec(j).color);
  end;
  for j:=1 to 5 do begin
    s:=s+hexcolor(viscolordlg.osc(j).color);
  end;
  s:=s+hexcolor(viscolordlg.s1.color);
  s:=s+hexcolor(viscolordlg.s2.color);
  s:=s+hexcolor(viscolordlg.s3.color);

  s:=i.readstring(s_main,'Visualization',s);

  for j:=1 to 16 do viscolordlg.spec(j).color:=extractcolor(s,j);
  for j:=1 to 5 do viscolordlg.osc(j).color:=extractcolor(s,j+16);
  viscolordlg.s1.color:=extractcolor(s,16+5+1);
  viscolordlg.s2.color:=extractcolor(s,16+5+2);
  viscolordlg.s3.color:=extractcolor(s,16+5+3);
end;
procedure balance;
var
j:integer;
begin
  s:='';
  for j:=0 to 27 do begin
    s:=s+makehex(getrvalue(wmain.balance[j]))+makehex(getgvalue(wmain.balance[j]))+makehex(getbvalue(wmain.balance[j]));
  end;
  s:=i.readstring(s_main,'Balance',s);

  for j:=0 to 27 do wmain.balance[j]:=extractcolor(s,j+1);
end;
begin
  with pagesdlg do
  begin
    edit1.text:=i.readstring(s_main,'Title',edit1.text);
    s:=str(buttons.itemindex)+str(byte(checkbox3.checked))+str(byte(checkbox4.checked));
    for j:=0 to 9 do case options.state[j] of
      cbunchecked:s:=s+'0';
      cbchecked:s:=s+'1';
      cbgrayed:s:=s+'2';
    end;
    s:=i.readstring(s_main,s_options,s);

    buttons.itemindex:=extractnum(s,1);
    checkbox3.checked:=boolean(extractnum(s,2));
    checkbox4.checked:=boolean(extractnum(s,3));
    for j:=0 to 9 do case extractnum(s,3+j+1) of
      0:options.state[j]:=cbunchecked;
      1:options.state[j]:=cbchecked;
      2:options.state[j]:=cbgrayed;
    end;
    options.repaint;
    colorfield1.color:=extractcolor(i.readstring(s_main,'Time',hexcolor(colorfield1.color)),1);
    colorfield2.color:=extractcolor(i.readstring(s_main,'Song',hexcolor(colorfield2.color)),1);
    colorfield3.color:=extractcolor(i.readstring(s_main,'Background',hexcolor(colorfield3.color)),1);
  end;
  volume;
  visc;
  balance;
  pagesdlg.cheattext:=i.readstring(s_main,'Skincheat',pagesdlg.cheattext);
end;
procedure loadeq;
var
j:integer;
procedure kurve;
var
j:integer;
begin
  s:='';
  for j:=1 to 19 do s:=s+hexcolor(eqbezier[j]);
  s:=i.readstring(s_eq,'Bezier',s);
  for j:=1 to 19 do eqbezier[j]:=extractcolor(s,j);
end;
procedure regler;
var
j:integer;
begin
  s:='';
  for j:=0 to 27 do s:=s+hexcolor(eqbar[j]);
  s:=i.readstring(s_eq,'Bars',s);
  for j:=0 to 27 do eqbar[j]:=extractcolor(s,j+1);
end;
begin
  pagesdlg.checkbox14.checked:=boolean(i.readinteger(s_eq,'On',integer(pagesdlg.checkbox14.checked)));
  pagesdlg.edit2.text:=i.readstring(s_eq,'Title',pagesdlg.edit2.text);
  s:=str(pagesdlg.radiogroup1.itemindex)+str(byte(pagesdlg.checkbox1.checked))+str(byte(pagesdlg.checkbox2.checked));
  for j:=0 to 4 do s:=s+str(byte(pagesdlg.eqoptions.checked[j]));
  s:=i.readstring(s_eq,s_options,s);
  pagesdlg.radiogroup1.itemindex:=extractnum(s,1);
  pagesdlg.checkbox1.checked:=boolean(extractnum(s,2));
  pagesdlg.checkbox2.checked:=boolean(extractnum(s,3));
  for j:=0 to 4 do pagesdlg.eqoptions.checked[j]:=boolean(extractnum(s,4+j));

  kurve;
  regler;
end;
procedure loadpl;
var
j:integer;
procedure text;
var
j:integer;
begin
  s:='';
  for j:=1 to 4 do s:=s+makehex(pagesdlg.textr.pl[j]);
  s:=i.readstring(s_pl,'Text',s);
  for j:=1 to 4 do pagesdlg.textr.pl[j]:=extractcolor(s,j);
  pagesdlg.textr.font:=i.readstring(s_pl,'Font',pagesdlg.textr.font);
end;
begin
  pagesdlg.edit3.text:=i.readstring(s_pl,'Title',pagesdlg.edit3.text);
  s:=str(pagesdlg.radiogroup3.itemindex)+str(byte(pagesdlg.checkbox5.checked))+str(byte(pagesdlg.checkbox6.checked))+str(byte(pagesdlg.checkbox12.checked))+str(byte(pagesdlg.radiogroup7.itemindex));
  for j:=0 to 3 do s:=s+str(byte(pagesdlg.ploptions.checked[j]));
  s:=i.readstring(s_pl,s_options,s);
  pagesdlg.radiogroup3.itemindex:=extractnum(s,1);
  pagesdlg.checkbox5.checked:=boolean(extractnum(s,2));
  pagesdlg.checkbox6.checked:=boolean(extractnum(s,3));
  pagesdlg.checkbox12.checked:=boolean(extractnum(s,4));
  pagesdlg.radiogroup7.itemindex:=extractnum(s,5);
  for j:=0 to 3 do pagesdlg.ploptions.checked[j]:=boolean(extractnum(s,5+1+j));

  text;
end;
procedure loadmb;
var
j:integer;
procedure text;
begin
  s:=makehex(pagesdlg.textr.mb[1])+makehex(pagesdlg.textr.mb[2]);
  s:=i.readstring(s_mb,'Text',s);
  pagesdlg.textr.mb[1]:=extractcolor(s,1);
  pagesdlg.textr.mb[2]:=extractcolor(s,2);
end;
begin
  pagesdlg.edit4.text:=i.readstring(s_mb,'Title',pagesdlg.edit4.text);
  s:=str(pagesdlg.radiogroup4.itemindex)+str(byte(pagesdlg.checkbox7.checked))+str(byte(pagesdlg.checkbox8.checked))+str(byte(pagesdlg.checkbox13.checked))+str(byte(pagesdlg.radiogroup8.itemindex));
  for j:=0 to 1 do s:=s+str(byte(pagesdlg.mboptions.checked[j]));
  s:=i.readstring(s_mb,s_options,s);
  pagesdlg.edit8.text:=i.readstring(s_mb,'Site','');
  pagesdlg.radiogroup4.itemindex:=extractnum(s,1);
  pagesdlg.checkbox7.checked:=boolean(extractnum(s,2));
  pagesdlg.checkbox8.checked:=boolean(extractnum(s,3));
  pagesdlg.checkbox13.checked:=boolean(extractnum(s,4));
  pagesdlg.radiogroup8.itemindex:=extractnum(s,5);
  for j:=0 to 1 do pagesdlg.mboptions.checked[j]:=boolean(extractnum(s,j+6));
  text;
end;
procedure loadavs;
begin
  pagesdlg.edit5.text:=i.readstring('AVS','Title',pagesdlg.edit5.text);
  s:=str(byte(pagesdlg.checkbox9.checked))+str(byte(pagesdlg.checkbox10.checked));
  s:=i.readstring('AVS',s_options,s);
  pagesdlg.checkbox9.checked:=boolean(extractnum(s,1));
  pagesdlg.checkbox10.checked:=boolean(extractnum(s,2));
end;
procedure loadreadme;
var
s:string;
begin
  pagesdlg.checkbox11.checked:=i.readbool('Readme','Advertisment',pagesdlg.checkbox11.checked);
  s:=i.readstring('Readme','Readme','');

  while pos('\n',s)>0 do
  begin
    insert(return,s,pos('\n',s));
    delete(s,pos('\n',s),2);
  end;

  pagesdlg.readme.lines.text:=s;
end;
var
olddis:boolean;
begin
  if (fileexists(f)=false)then raise exception.createfmt('Can''t load configuration-file: %s!',[f]);
  if extractfilepath(f)='' then f:='.\'+f;
  screen.cursor:=crhourglass;
  olddis:=pagesdlg.disableupdate;
  pagesdlg.disableupdate:=true;
  i:=tinifile.create(f);

  loadpicture;
  loadmain;
  loadeq;
  loadpl;
  loadmb;
  loadavs;
  loadreadme;

  i.free;
  if pagesdlg.loadedfilename<>'' then
  begin
    if not fileexists(pagesdlg.loadedfilename) then
    begin
      application.messagebox(pchar(loadstring(33)),pchar(l_title),mb_ok or mb_iconhand);  
      createpicture(
        pagesdlg.artr.colors[1],
        pagesdlg.artr.colors[2],
        pagesdlg.artr.colors[3],
        pagesdlg.artr.colors[4],
        pagesdlg.artr.colors[5],
        pagesdlg.artr.numcolors+1,
        pagesdlg.artr.direction,
        pagesdlg.artr.bis);
    end else
      bmps.loadpicture(pagesdlg.loadedfilename,false);
  end
  else begin
    createpicture(
      pagesdlg.artr.colors[1],
      pagesdlg.artr.colors[2],
      pagesdlg.artr.colors[3],
      pagesdlg.artr.colors[4],
      pagesdlg.artr.colors[5],
      pagesdlg.artr.numcolors+1,
      pagesdlg.artr.direction,
      pagesdlg.artr.bis);
  end;

  pagesdlg.disableupdate:=false;
  pagesdlg.correctpos;
  cliptypchanged;
  pagesdlg.disableupdate:=olddis;
  pagesdlg.redraw(0,true);
  screen.cursor:=crdefault;
end;

procedure popupfontmenu;
begin
  pagesdlg.fontmenucallbackproc:=cb;
  pagesdlg.FontMenu.Popup(p.x,p.y);
end;

function loadstringid;
var
a:array[0..256]of char;
begin
  windows.loadstring(dllinstance,id,@a,256);
  result:=a;
end;

procedure setids;
var
id:integer;
procedure addrekursive(c:twincontrol);
var
newc:twincontrol;
i:integer;
begin
  for i:=0 to c.controlcount-1 do if c.controls[i] is twincontrol then
  begin
    newc:=c.controls[i] as twincontrol;
    if (newc.helpcontext<>0)and not
      ((newc is tchecklistbox))then
    begin
      setwindowlong(newc.handle,gwl_id,id);
      inc(id);
    end;
    if newc.controlcount>0 then addrekursive(newc);
  end;
end;
begin
  id:=256;
  addrekursive(window);
end;

procedure runcontexthelp;
var
data:array[1..500]of dword;
pos:integer;
procedure add(v,w:dword);
begin
  data[pos]:=v;
  data[pos+1]:=w;
  pos:=pos+2;
end;
procedure addrekursive(c:twincontrol);
var
newc:twincontrol;
i:integer;
begin
  for i:=0 to c.controlcount-1 do if c.controls[i] is twincontrol then
  begin
    newc:=c.controls[i] as twincontrol;
    if newc.helpcontext<>0 then
    begin
      add(getdlgctrlid(newc.handle),newc.helpcontext);
    end;
    if (newc.controlcount>0)and not (
      (newc is tradiogroup)or(newc is tchecklistbox)
      )then addrekursive(newc);
  end;
end;
begin
  pos:=1;
  addrekursive(wer.parent);
  add(0,0);
  winhelp(wer.handle,pchar(application.helpfile),help_contextmenu,dword(@data));
end;


function getopenfile;
var
op:openfilename;
f:array[0..max_path]of char;
begin
  zeromemory(@op,sizeof(op));
  op.lStructSize:=sizeof(op);
  op.hWndOwner:=owner;
  op.hinstance:=hinstance;
  op.lpstrfilter:=pchar(filter);
  op.nmaxcustfilter:=maxfilter;
  op.lpstrFile:=f;
  op.nMaxFile:=max_path;
  op.lpstrTitle:='Open file';
  op.Flags:=OFN_HIDEREADONLY or OFN_PATHMUSTEXIST or OFN_FILEMUSTEXIST;
  
  if (getopenfilename(op))then result:=op.lpstrFile
  else result:='';
end;

function getsavefile;
var
op:openfilename;
f:array[0..max_path]of char;
begin
  zeromemory(@op,sizeof(op));
  op.lStructSize:=sizeof(op);
  op.hWndOwner:=owner;
  op.hinstance:=hinstance;
  op.lpstrfilter:=pchar(filter);
  op.nmaxcustfilter:=maxfilter;
  op.lpstrFile:=f;
  op.nMaxFile:=max_path;
  op.lpstrTitle:='Save file';
  op.Flags:=OFN_HIDEREADONLY or OFN_PATHMUSTEXIST;

  if (getsavefilename(op))then result:=op.lpstrFile
  else result:='';
end;


begin
  rt:=nil;
end.
