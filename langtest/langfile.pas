unit langfile;

interface

uses windows;

type
planguagefile=pointer;

function extractprefix(s:pchar):integer; cdecl;
function extractsuffix(s,r:pchar):boolean; cdecl; overload;
function createlanguagefile(filename:pchar;cacheing:boolean):planguagefile; cdecl;
procedure destroylanguagefile(lf:planguagefile); cdecl;
function getlanguagefilestring(lf:planguagefile;nr:integer;r:pchar):boolean; cdecl;
function getlanguagefilename(lf:planguagefile):pchar; cdecl;
function languagefileop(lf:planguagefile;op,p1:dword):dword; cdecl;


function extractsuffix(s:string):string; overload; 
function findfile(f:string):string;

type
plangfile=^tlangfile;
tlangfile=object
  lf:planguagefile;

  constructor init(f:string);
  destructor done;
  procedure open;
  procedure close;
  procedure gofirst;
  function eof:boolean;
  function getnextstring:string;
  function getnextcomment:string;
  function getnext:string;
  function stringexists(nr:integer):boolean;
  procedure cache;
end;


implementation

uses sysutils;

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
function languagefileop(lf:planguagefile;op,p1:dword):dword; cdecl; external dll index 36;

function findfile;
begin
  if fileexists(f) then result:=f else result:='..\'+f;
end;



constructor tlangfile.init;
begin
  lf:=createlanguagefile(pchar(f),true);
end;

destructor tlangfile.done;
begin
  destroylanguagefile(lf);
end;

procedure tlangfile.open;
begin
  languagefileop(lf,6,0);
end;

procedure tlangfile.close;
begin
  languagefileop(lf,0,0);
end;

procedure tlangfile.gofirst;
begin
  languagefileop(lf,5,0);
end;

function tlangfile.eof;
begin
  result:=languagefileop(lf,1,0)<>0;
end;

function tlangfile.getnextstring;
var
a:array[0..max_char]of char;
begin
  languagefileop(lf,4,dword(@a));
  if eof then result:='' else result:=a;
end;

function tlangfile.getnextcomment;
var
a:array[0..max_char]of char;
begin
  languagefileop(lf,3,dword(@a));
  if eof then result:='' else result:=a;
end;

function tlangfile.getnext;
var
a:array[0..max_char]of char;
begin
  languagefileop(lf,2,dword(@a));
  if eof then result:='' else result:=a;
end;

function tlangfile.stringexists;
begin
  result:=languagefileop(lf,7,nr)<>0;
end;

procedure tlangfile.cache;
begin
  languagefileop(lf,8,0);
end;




// Overload external functions

function extractsuffix(s:string):string; overload;
var
a:array[0..max_char]of char;
begin
  if extractsuffix(pchar(s),@a[0])=true then result:=string(a) else result:='';
end;

end.
