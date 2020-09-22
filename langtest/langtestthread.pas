unit langtestthread;

interface

uses
  Classes,comctrls,stdctrls;

type
  TTestThread = class(TThread)
  private
    { Private-Deklarationen }
  protected
    listitem:tlistitem;
    details:tmemo;
    filename:string;
    detail:string;
    numhints,numcomments,numduplex,badcomments:integer;
    procedure Execute; override;
    procedure setnumbers;
    procedure setdetail;
  public
    notfound,nottrans,tested:integer;
    exitproc:procedure of object;
    testthread:boolean;
    constructor mycreate(fn:string;li:tlistitem;det:tmemo);
  end;
  tlangaddthread=class(tthread)
    filename,stringtoadd:string;
    constructor create(f,s:string); overload;
    procedure execute; override;
  end;
  tmatchthread=class(tthread)
    filename:string;
    memo:tmemo;
    detail:string;
    constructor create(f:string;m:tmemo); overload;
    procedure execute; override;
    procedure adddetail;
  end;

var
threads:integer;
terminatetestthread:boolean;


implementation

uses windows,sysutils,sascha,langfile;





{ TTestThread }

constructor ttestthread.mycreate;
begin
  create(true);
  freeonterminate:=true;
  filename:=fn;
  listitem:=li;
  details:=det;
  tested:=0;
  notfound:=0;
  nottrans:=0;
  numhints:=0;
  numcomments:=0;
  badcomments:=0;
  inc(threads);
  testthread:=false;
  priority:=tplower;
  terminatetestthread:=false;
end;

procedure ttestthread.setnumbers;
var
s:string;
begin
  if listitem=nil then exit;
  if terminatetestthread then exit;
  listitem.subitems.strings[1]:=str(notfound);
  listitem.subitems.strings[2]:=str(nottrans);
  if numhints>0 then listitem.subitems.strings[3]:=str(numhints);
  if (numcomments>0) then
  begin
    s:=inttostr(numcomments);
    if (badcomments>0)then s:=s+' (bad: '+inttostr(badcomments)+')';
    listitem.subitems.strings[4]:=s;
  end;
  if numduplex>0 then listitem.subitems.strings[5]:=str(numduplex);
end;

procedure ttestthread.setdetail;
begin
  if terminatetestthread then exit;
  details.Lines.Add(detail);
end;

procedure TTestThread.Execute;
procedure adddetail(s:string);
begin
  if (details=nil)or(terminated) then exit;
  detail:=s;
  synchronize(setdetail);
end;
var
f3:file of byte;
i,j,zhl:integer;
s1,s2:string;
important:tstringlist;
hints:tstringlist;
efile:plangfile;
tfile:plangfile;
const
isimportant:array[1..8]of integer=(0,11,12,30,1000,1001,1002,1004);
line='---------------';

procedure testdouble;
var
first:boolean;
a:tlist;
begin
  a:=tlist.create;
  a.clear;
  first:=true;

  tfile.open;
  tfile.gofirst;
  while not tfile.eof do
  begin
    s1:=tfile.getnextstring;
    i:=extractprefix(pchar(s1));
    if a.indexof(pointer(i))<>-1 then
    begin
      if first then
      begin
        adddetail('');
        adddetail(line);
        adddetail('[Double]');
        first:=false;
      end;
      adddetail('--> '+s1);
      inc(numduplex);
    end else a.Add(pointer(i));
    if terminatetestthread then break;
  end;
  a.free;
  if listitem<>nil then synchronize(setnumbers);
end;

begin
  if details<>nil then details.clear;
  adddetail('Testing file: '+filename);
  adddetail('');

  efile:=new(plangfile,init(findfile('english.lng')));
  tfile:=new(plangfile,init(findfile(filename)));
  
  notfound:=0;
  nottrans:=0;
  numduplex:=0;
  tested:=0;
  hints:=tstringlist.create;
  important:=tstringlist.create;
                    
  efile.open;
  tfile.open;
  while (efile.eof=false)and(terminated=false) do
  begin
    s1:=efile.getnextstring;
    zhl:=extractprefix(pchar(s1));
    if zhl<>-1 then
    begin      { String gefunden }
      tfile.gofirst;
      while (not tfile.eof)and(not terminated)and(not terminatetestthread) do
      begin
        s2:=tfile.getnextstring;
        i:=extractprefix(pchar(s2));
        if (i<>-1)and(i=zhl)then
        begin   // Gleiche Strings gefunden
          if (s1=s2)or(s2[pos('=',s2)+1]='*') then
          begin
            inc(nottrans);
            if listitem<>nil then synchronize(setnumbers);
            adddetail('String not translated: '+s1);
          end;
          if details<>nil then for j:=1 to 8 do if i=isimportant[j]then
          begin
            important.add(s2);
          end;
          if ((zhl=11)or(zhl=30))and(trim(s1)<>trim(s2))then
          begin
            inc(numhints);
            hints.Add(s2);
            if listitem<>nil then synchronize(setnumbers);
          end;
          break;
        end;
        warte;
      end;
      if (tfile.eof)and(i<>zhl)and(not terminatetestthread) then
      begin
        inc(notfound);
        if listitem<>nil then synchronize(setnumbers);
        adddetail('--> String not found: '+s1);
      end;
    end;

    inc(tested);
    if terminatetestthread then break;
  end;
  tfile.close;
  efile.close;
  if listitem<>nil then synchronize(setnumbers);

  testdouble;

  if details<>nil then
  begin
    adddetail('');
    adddetail(line);
    adddetail('[Important strings]');
    for i:=0 to important.count-1 do adddetail(important[i]);

    if hints.count>0 then
    begin
      adddetail('');
      adddetail(line);
      adddetail('[Hints]');
      for i:=0 to hints.count-1 do adddetail(hints[i]);
    end;

    tfile.open;
    adddetail('');
    adddetail(line);
    adddetail('[Comments]');
    while not tfile.eof do
    begin
      s1:=tfile.getnextcomment;
      if tfile.eof then break;
      inc(numcomments);
      if (copy(s1,1,2)<>'//')then
      begin
        inc(badcomments);
        adddetail('--> Bad Comment: '+s1);
      end else adddetail(s1);

    end;
    tfile.close;

    assignfile(f3,findfile(filename));
    reset(f3);
    adddetail('');
    adddetail('');
    adddetail(line+line+line+line);
    adddetail('[Summary]');
    adddetail(str(tested)+' strings tested!');
    if notfound<>0 then adddetail('--> '+str(notfound)+' strings not found!');
    if nottrans<>0 then adddetail(str(nottrans)+' strings not translated!');
    adddetail(str(hints.count)+' hints, '+str(numcomments)+' comments.');
    if numduplex>0 then adddetail(str(numduplex)+' duplex.');
    adddetail('');
    adddetail('Filename: '+findfile(filename));
    adddetail('Filesize: '+str(filesize(f3))+' Byte');
    adddetail('Filedate: '+datetostr(filedatetodatetime(fileage(filename))));
    closefile(f3);
  end else begin
    tfile.gofirst;
    while tfile.eof=false do
    begin
      s1:=tfile.getnextcomment;
      if tfile.eof then break;
      inc(numcomments);
      if (copy(s1,1,2)<>'//')then
      begin
        inc(badcomments);
      end;
    end;
    tfile.close;
    synchronize(setnumbers);
  end;

  hints.free;
  important.free;
  dec(threads);
  dispose(efile,done);
  dispose(tfile,done);
  if threads=0 then terminatetestthread:=false;
  if @exitproc<>nil then exitproc;
end;


constructor tlangaddthread.create(f,s:string);
begin
  if pos('=',s)=0 then exit;
  filename:=f;
  stringtoadd:=s;
  inherited create(false);
  freeonterminate:=true;
  inc(threads);
end;

procedure tlangaddthread.execute;
var
number:integer;
f:textfile;
tempfile:plangfile;
tempfilename,string1:string;
i,j:integer;
written:boolean;
begin
  val(copy(stringtoadd,1,pos('=',stringtoadd)-1),number,j);
  tempfilename:=changefileext(filename,'.tmp');
  renamefile(filename,tempfilename);
  written:=false;
  tempfile:=new(plangfile,init(tempfilename));
  assignfile(f,filename);
  rewrite(f);

  tempfile.open;
  while not tempfile.eof do
  begin
    string1:=tempfile.getnext;
    if (written=false)and(pos('=',string1)<>0) then
    begin
      val(copy(string1,1,pos('=',string1)-1),i,j);
      if (j=0)and(number<=i)then
      begin
        writeln(f,stringtoadd);
        if number=i then string1:='___';
        written:=true;
      end;
    end;
    if string1<>'___' then writeln(f,string1);
  end;

  dispose(tempfile,done);
  closefile(f);
  deletefile(tempfilename);
  dec(threads);
end;


constructor tmatchthread.create(f:string;m:tmemo);
begin
  memo:=m;
  filename:=f;
  if grosswort(filename)='ENGLISH.LNG' then exit;
  inherited create(false);
  freeonterminate:=true;
  inc(threads);
end;

procedure tmatchthread.adddetail;
begin
  memo.Lines.Add(detail);
end;

procedure tmatchthread.execute;
var
i,zhl:integer;
s1:string;
t:tlangaddthread;
efile,tfile:plangfile;
procedure adddetail(s:string);
begin
  detail:=s;
  synchronize(self.adddetail);
end;
begin
  new(efile,init(findfile('english.lng')));
  new(tfile,init(filename));
  efile.open;

  tfile.open;
  while efile.eof=false do
  begin
    s1:=efile.getnextstring;
    i:=extractprefix(pchar(s1));
    if (i<>-1) then
    begin      // String gefunden, jetzt in f2 suchen
      zhl:=i;
      if tfile.stringexists(zhl)=false then
      begin
        t:=tlangaddthread.create(filename,s1);
        adddetail(filename+': + "'+s1+'"');
        t.waitfor;
        tfile.cache;
      end;
    end;
    if terminated then break;
  end;

  dispose(efile,done);
  dispose(tfile,done);

  dec(threads);
end;


begin
  threads:=0;
end.
