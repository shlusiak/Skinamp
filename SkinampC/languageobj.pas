unit languageobj;

interface

uses windows,sysutils,classes;

type
planguagefile=^tlanguagefile;
tlanguagefile=object
  filename:string;
  f:textfile;
  cached:boolean;
  opened:boolean;
  filemap:tstringlist;
  index:integer;
  
  constructor init(fs:string);
  destructor done;
  procedure open;
  procedure close;
  procedure gofirst;
  function getnextstring:string;
  function getnextcomment:string;
  function getstring(nr:integer):string;
  function stringexists(nr:integer):boolean;
  function eof:boolean;
  function getnext:string;
  procedure cache;
end;

function extractprefix(s:string):integer;
function extractsuffix(s:string):string;
function findfile(f:string):string;

implementation


function findfile;
begin
  if fileexists(f) then result:=f else result:='..\'+f;
end;

function extractprefix;
var
i,j:integer;
begin
  if pos('=',s)=0 then
  begin
    result:=-1;
    exit;
  end;
  val(trim(copy(s,1,pos('=',s)-1)),i,j);
  if j=0 then result:=i else result:=-1;
end;

function extractsuffix;
var
st:string;
begin
  if pos('=',s)<>0 then st:=trim(copy(s,pos('=',s)+1,length(s)-pos('=',s))) else st:='';
  result:=st;
end;


constructor tlanguagefile.init;
begin
  filemap:=nil;
  filename:=fs;
  opened:=false;
  cached:=false;
  
  cache;
end;

destructor tlanguagefile.done;
begin
  if opened then close;
  if cached then filemap.free;
end;

procedure tlanguagefile.cache;
var
s:string;
begin
  if cached then
  begin
    filemap.free;
    cached:=false;
  end;
  filemap:=tstringlist.create;

  open;
  while not eof do
  begin
    readln(f,s);
    filemap.Add(s);
  end;
  close;

  cached:=true;
end;

procedure tlanguagefile.open;
begin
  if opened then exit;
  if cached then
  begin
    index:=0;
    exit;
  end;
  assignfile(f,filename);
  reset(f);
  opened:=true;
end;

procedure tlanguagefile.close;
begin
  if opened then closefile(f);
  opened:=false;
end;

procedure tlanguagefile.gofirst;
begin
  if not cached then
  begin
    close;
    open;
  end else index:=0;
end;

{$HINTS OFF}
function tlanguagefile.getnextstring;
var
s:string;
i,j:integer;
begin
  if eof then
  begin
    result:='';
    exit;
  end;
  repeat
    s:=getnext;
    i:=extractprefix(s);
    if i<>-1 then i:=0;
  until (i=0)or(eof);
  if (eof)and(i<>0) then result:='' else result:=s;
end;

function tlanguagefile.getstring;
var
s:string;
i:integer;
begin
  gofirst;
  repeat
    s:=getnext;
    if pos('=',s)>0 then
    begin
      i:=extractprefix(s);
      if (i=nr)then i:=0 else i:=1;
    end else i:=1;
  until (i=0)or(eof);
  if (eof)and(i<>0) then result:='' else result:=s;
end;

function tlanguagefile.getnextcomment;
var
s:string;
i,j:integer;
begin
  if (eof)then
  begin
    result:='';
    exit;
  end;
  repeat
    s:=getnext;
    if pos('=',s)<>0 then
    begin
      val(copy(s,1,pos('=',s)-1),j,i);
      if (i=0)then i:=1 else i:=0;
    end else i:=0;
    if trim(s)='' then i:=1;
  until (i=0)or(eof);
  if (eof)and(i<>0) then result:='' else result:=s;
end;
{$HINTS ON}

function tlanguagefile.stringexists;
begin
  result:=getstring(nr)<>'';
end;

function tlanguagefile.eof;
begin
  if not cached then
    result:=system.eof(f) else
  begin
    if index>=filemap.count then
    begin
      result:=true;
    end else result:=false;
  end;
end;

function tlanguagefile.getnext;
var
s:string;
begin
  if cached then
  begin
    result:=filemap[index];
    inc(index);
  end else begin
    readln(f,s);
    result:=s;
  end;
end;

end.
