unit langtestmain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,sascha, ActnList, Menus, ComCtrls, language, langtestthread,langfile;

type
  TLangtestform = class(TForm)
    Panel: TPanel;
    ergebnis: TMemo;
    Button1: TButton;
    Button2: TButton;
    Splitter1: TSplitter;
    StaticText1: TStaticText;
    langlist: TListView;
    Timer: TTimer;
    PaintBox1: TPaintBox;
    StaticText2: TStaticText;
    Button3: TButton;
    StaticText3: TStaticText;
    PopupMenu: TPopupMenu;
    Edit1: TMenuItem;
    Refresh1: TMenuItem;
    ActionList1: TActionList;
    Action1: TAction;
    N1: TMenuItem;
    Quit1: TMenuItem;
    Button4: TButton;
    Action2: TAction;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure langlistChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure langlistDblClick(Sender: TObject);
    procedure langlistContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Edit1Click(Sender: TObject);
    procedure Test1Click(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Quit1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private-Deklarationen }
    firstshow:boolean;
    testthread:ttestthread;
    working:boolean;
    notchange:boolean;
    procedure testthreadterminated;
  public
    { Public-Deklarationen }
    procedure refresh;
    procedure teste;
    procedure refreshstatus;
  end;

var
  Langtestform: TLangtestform;

implementation

{$R *.DFM}


procedure TLangtestform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure tlangtestform.refresh;
var
dirinfo:tsearchrec;
i:integer;
li,newest:tlistitem;
t:ttestthread;
time:integer;
b:byte;
begin
  notchange:=true;
  langlist.items.beginupdate;
  time:=0;
  langlist.selected:=nil;
  langlist.items.Clear;
  newest:=nil;
  b:=0;
  if (findfirst('*.lng',faarchive,dirinfo)=0)then b:=1
    else if (findfirst('..\*.lng',faarchive,dirinfo)=0) then b:=2;
  if b<>0 then 
  repeat
    li:=langlist.items.add;
    li.caption:=dirinfo.name;
    li.SubItems.add(loadstringfromfile(12,findfile(dirinfo.name)));
    li.subitems.add('-');
    li.subitems.add('-');
    li.subitems.add('-');
    li.subitems.add('-');
    li.subitems.add('-');

    if fileage(findfile(dirinfo.name))>time then
    begin
      time:=fileage(findfile(dirinfo.name));
      newest:=li;
    end;
    statictext3.caption:='Languages: '+str(langlist.items.count);
  until findnext(dirinfo)<>0;
  for i:=0 to langlist.items.count-1 do
  begin
    t:=ttestthread.mycreate(findfile(langlist.items[i].caption),langlist.items[i],nil);

    t.exitproc:=testthreadterminated;
    if langlist.items[i]=newest then t.priority:=tphigher;
    t.resume;
  end;
  refreshstatus;
  langlist.items.endupdate;
  warte;
  notchange:=false;
  langlist.selected:=newest;
  teste;
end;

procedure TLangtestform.FormCreate(Sender: TObject);
begin
  firstshow:=true;
  notchange:=false;
  testthread:=nil;
end;

procedure TLangtestform.Button2Click(Sender: TObject);
begin
  terminatetestthread:=true;
  langlist.selected:=nil;
  while threads>0 do
  begin
    warte;
    sleep(5);
    warte;
  end;
  terminatetestthread:=false;
  refresh;
end;

procedure TLangtestform.teste;
var
s1:string;
begin
  { Teste Sprache durch... }
  if langlist.selected=nil then exit;
  warte;
  if not (fileexists('english.lng')or(fileexists('..\english.lng'))) then
  begin
    ergebnis.lines.add('Standard file not found: ENGLISH.LNG!');
    exit;
  end;

  warte;
  s1:=langlist.selected.caption;
  if not (fileexists(s1)or(fileexists('..\'+s1))) then
  begin
    ergebnis.lines.add('File not found: '+s1);
    exit;
  end;

  working:=true;
  paintbox1.visible:=true;
  if testthread<>nil then
  begin
    testthread.Terminate;
    testthread.waitfor;
  end;
  warte;
  testthread:=ttestthread.mycreate(findfile(s1),nil,ergebnis);
  testthread.testthread:=true;
  testthread.exitproc:=testthreadterminated;
  testthread.priority:=tphigher;
  testthread.resume;
  statictext2.caption:='Workerthreads: '+str(threads);
end;

procedure TLangtestform.langlistChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if notchange then exit;
  if (langlist.selected<>nil)then button3.enabled:=true else button3.enabled:=false;
  teste;
end;

procedure TLangtestform.FormShow(Sender: TObject);
begin
  if firstshow then
  begin
    firstshow:=false;
    refresh;
  end;
end;

procedure tlangtestform.testthreadterminated;
begin
  testthread:=nil;
  refreshstatus;
end;

procedure TLangtestform.TimerTimer(Sender: TObject);
begin
  if working=false then exit;
  paintbox1.tag:=paintbox1.tag+1;
  if paintbox1.tag=4 then paintbox1.tag:=0;
  paintbox1.invalidate;
  if threads=0 then refreshstatus;
end;

procedure TLangtestform.PaintBox1Paint(Sender: TObject);
procedure line(x1,y1,x2,y2:integer);
begin
  paintbox1.canvas.moveto(x1,y1);
  paintbox1.canvas.lineto(x2,y2);
end;
const
dif=4;
begin
  with paintbox1.canvas do
  begin
    pen.Width:=3;
    pen.color:=rgb(255,0,0);
    case paintbox1.tag of
      0:line(dif,dif,paintbox1.width-dif,paintbox1.height-dif);
      1:line(paintbox1.width div 2,0,paintbox1.width div 2,paintbox1.height);
      2:line(paintbox1.width-dif,dif,dif,paintbox1.height-dif);
      3:line(0,paintbox1.height div 2,paintbox1.width,paintbox1.height div 2);
    end;
  end;
end;

procedure TLangtestform.Button3Click(Sender: TObject);
begin
  winexec(pchar('notepad '+findfile(langlist.selected.caption)),sw_show);
end;

procedure TLangtestform.langlistDblClick(Sender: TObject);
begin
  if langlist.selected<>nil then button3.Click;
end;

procedure TLangtestform.langlistContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if langlist.selected<>nil then
  begin
    mousepos:=langlist.clienttoscreen(mousepos);
    popupmenu.Popup(mousepos.x,mousepos.y);
  end;
end;

procedure TLangtestform.Edit1Click(Sender: TObject);
begin
  button3.click;
end;

procedure TLangtestform.Test1Click(Sender: TObject);
begin
  teste;
end;

procedure TLangtestform.Refresh1Click(Sender: TObject);
var
li:tlistitem;
begin
  if testthread<>nil then testthread.terminate;
  li:=langlist.selected;
  li.SubItems.Strings[0]:=loadstringfromfile(12,findfile(li.caption));
  li.SubItems.Strings[1]:='-';
  li.SubItems.Strings[2]:='-';
  li.SubItems.Strings[3]:='-';
  li.SubItems.Strings[4]:='-';
  li.SubItems.Strings[5]:='-';
  testthread:=ttestthread.mycreate(findfile(li.caption),li,ergebnis);
  testthread.testthread:=true;
  testthread.exitproc:=testthreadterminated;
  testthread.resume;
  refreshstatus;
end;

procedure TLangtestform.Action1Execute(Sender: TObject);
begin
  if threads=0 then refresh;
end;

procedure TLangtestform.Quit1Click(Sender: TObject);
begin
  if not working then close;
end;

procedure TLangtestform.Button4Click(Sender: TObject);
var
s:string;
i:integer;
begin
  if langlist.selected=nil then exit;
  if InputQuery('Enter string to add','Enter the string,to add to the selected files:',s)=false then exit;

  for i:=0 to langlist.items.count-1 do if langlist.items[i].selected then
    tlangaddthread.create(findfile(langlist.Items[i].caption),s);
  refreshstatus;
end;

procedure tlangtestform.refreshstatus;
begin
  if (working=false)and(threads>0) then
  begin
    working:=true;
    paintbox1.visible:=true;
//    button2.enabled:=false;
  end else
  if (working=true)and(threads=0)then
  begin
    working:=false;
    paintbox1.visible:=false;
//    button2.enabled:=true;
  end;
  statictext2.caption:='Workerthreads: '+str(threads);
end;

procedure TLangtestform.Button5Click(Sender: TObject);
var
i:integer;
begin
  ergebnis.lines.clear;
  ergebnis.lines.add('Testing all files for non-found strings...');
  ergebnis.lines.add('');
  for i:=0 to langlist.items.count-1 do tmatchthread.create(findfile(langlist.items[i].caption),ergebnis);
  refreshstatus;
end;

end.
