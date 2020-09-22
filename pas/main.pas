unit main;
{$I cs.inc}

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Menus, Dialogs, ExtDlgs, CheckLst,jpeg, Mask,
  messages,funktionen,clipbrd, ActnList, AppEvnts, StdActns,
  ColorField,commctrl,skinampc,konstanten,inifiles,commdlg,gifimage,
  cureditor;

type
 TPagesDlg = class(TForm)
    MainMenu: TMainMenu;
    Programm1: TMenuItem;
    Beenden1: TMenuItem;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    OpenPictureDialog: TOpenPictureDialog;
    Speichern1: TMenuItem;
    cliptyp: TRadioGroup;
    mainpicture: TPaintBox;
    Button1: TButton;
    TabSheet2: TTabSheet;
    Buttons: TRadioGroup;
    options: TCheckListBox;
    TabSheet3: TTabSheet;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    RadioGroup2: TRadioGroup;
    Button2: TButton;
    Button3: TButton;
    Bildladen1: TMenuItem;
    Info1: TMenuItem;
    Label2: TLabel;
    Edit2: TEdit;
    eqoptions: TCheckListBox;
    TabSheet4: TTabSheet;
    Label3: TLabel;
    Edit3: TEdit;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    ploptions: TCheckListBox;
    RadioGroup3: TRadioGroup;
    Hilfe1: TMenuItem;
    Skin1: TMenuItem;
    Hintergrundbildgenerieren1: TMenuItem;
    N1: TMenuItem;
    TabSheet5: TTabSheet;
    Edit4: TEdit;
    RadioGroup4: TRadioGroup;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Label4: TLabel;
    mboptions: TCheckListBox;
    TabSheet6: TTabSheet;
    Edit5: TEdit;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    Label5: TLabel;
    TabSheet7: TTabSheet;
    readme: TMemo;
    Button9: TButton;
    Button10: TButton;
    RadioGroup5: TRadioGroup;
    Button11: TButton;
    RadioGroup6: TRadioGroup;
    Main1: TMenuItem;
    Equalizer1: TMenuItem;
    Playlist1: TMenuItem;
    Lautstrke1: TMenuItem;
    Visualisierung1: TMenuItem;
    Balance1: TMenuItem;
    Kurve1: TMenuItem;
    Regler1: TMenuItem;
    Text1: TMenuItem;
    N3: TMenuItem;
    GroupBox1: TGroupBox;
    Edit6: TEdit;
    StaticText1: TStaticText;
    Label6: TLabel;
    Label7: TLabel;
    Edit7: TEdit;
    StaticText2: TStaticText;
    Voreinstellung1: TMenuItem;
    N2: TMenuItem;
    N3D1: TMenuItem;
    Bitmaps1: TMenuItem;
    NurBild1: TMenuItem;
    CheckBox11: TCheckBox;
    SP: TProgressBar;
    Button12: TButton;
    Button13: TButton;
    Skincheat1: TMenuItem;
    Sprachen1: TMenuItem;
    Button14: TButton;
    FontDialog: TFontDialog;
    RadioGroup7: TRadioGroup;
    RadioGroup8: TRadioGroup;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    Button15: TButton;
    N4: TMenuItem;
    Speichern2: TMenuItem;
    Laden1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Pasteclipboard1: TMenuItem;
    SavePictureDialog: TSavePictureDialog;
    Hilfe2: TMenuItem;
    N5: TMenuItem;
    ActionList: TActionList;
    Refresh: TAction;
    FontMenu: TPopupMenu;
    Standard1: TMenuItem;
    Label8: TLabel;
    Label9: TLabel;
    ColorDialog: TColorDialog;
    Minibrowser1: TMenuItem;
    AVS1: TMenuItem;
    Text2: TMenuItem;
    N6: TMenuItem;
    NeuesFenster1: TMenuItem;
    N7: TMenuItem;
    ColorField2: TColorField;
    ColorField1: TColorField;
    Button16: TButton;
    Cursors1: TMenuItem;
    redrawtimer: TTimer;
    AlsBild1: TMenuItem;
    SaveSkinbitmapDialog: TSavePictureDialog;
    RefreshTest: TAction;
    Template1: TMenuItem;
    Bitmapbmp1: TMenuItem;
    Masksbmp1: TMenuItem;
    N9: TMenuItem;
    Standard2: TMenuItem;
    CheckBox14: TCheckBox;
    Minimize: TAction;
    N8: TMenuItem;
    BBearbeiten1: TMenuItem;
    MBearbeiten1: TMenuItem;
    ReloadSource: TAction;
    Label10: TLabel;
    ColorField3: TColorField;
    Label11: TLabel;
    Edit8: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mainpictureMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mainpictureMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mainpictureMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Speichern1Click(Sender: TObject);
    procedure cliptypClick(Sender: TObject);
    procedure Redraw1(Sender: TObject);
    procedure RedrawAll(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure Redraw2(Sender: TObject);
    procedure Redraw3(Sender: TObject);
    procedure mainpicturePaint(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure Redraw4(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure RadioGroup5Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6Enter(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure N3D1Click(Sender: TObject);
    procedure Bitmaps1Click(Sender: TObject);
    procedure NurBild1Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
    procedure StaticText2Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure RadioGroup8Click(Sender: TObject);
    procedure RadioGroup7Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Speichern2Click(Sender: TObject);
    procedure Laden1Click(Sender: TObject);
    procedure Pasteclipboard1Click(Sender: TObject);
    procedure Redraw5(Sender: TObject);
    procedure Hilfe2Click(Sender: TObject);
    procedure RefreshExecute(Sender: TObject);
    procedure Button14ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Button9ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Standard1Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure NeuesFenster1Click(Sender: TObject);
    procedure ColorField2LeftClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ColorField2Redraw(Sender: TObject);
    procedure ColorField2RightClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button16Click(Sender: TObject);
    procedure redrawtimerTimer(Sender: TObject);
    procedure AlsBild1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RefreshTestExecute(Sender: TObject);
    procedure Masksbmp1Click(Sender: TObject);
    procedure Bitmapbmp1Click(Sender: TObject);
    procedure Standard2Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure optionsClickCheck(Sender: TObject);
    procedure MinimizeExecute(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Button2ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure BBearbeiten1Click(Sender: TObject);
    procedure MBearbeiten1Click(Sender: TObject);
    procedure ReloadSourceExecute(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
  private
    { Private declarations }
    mousedown:byte;
    mx,my:integer;
    bitmap:tbitmap;
    viewing:integer;
    moving:boolean;
    winampdirfound:boolean;
    cursors:tcursors;

    procedure createfonts;
    procedure dropfiles(var msg:tmessage); message wm_dropfiles;
    procedure wmredraw(var msg:tmessage); message wm_redraw;
  public
    { Public declarations }
    testwarn:boolean;
    loadedfilename:string;
    disableupdate:boolean;
    fontmenucallbackproc:tcb;
    cheattext:string;
    saveskinr:record
      dir:string;
      what:array[0..9]of boolean;
      zipped:boolean;
    end;
    artr:record
      direction,bis:byte;
      numcolors:byte;
      colors:array[1..5]of tcolorref;
    end;
    textr:record
      pl:array[1..4]of tcolorref;
      font:string;
      mb:array[1..2]of tcolorref;
    end;
    splash:hwnd;

    procedure lang_select(sender:tobject);
    procedure initialisate;
    procedure loadreg;
    procedure savereg;
    procedure correctpos;
    procedure redraw(what:integer;created:boolean);
    procedure drawfontmenuitem(Sender:TObject;ACanvas:TCanvas;ARect:TRect;Selected:Boolean);
    procedure selectfontmenuitem(sender:tobject);
    procedure measurefontmenuitem(Sender:TObject;ACanvas:TCanvas;var Width,Height:Integer);
    procedure StepIt;
    procedure createnewinstance(filename:string;offset:integer);
    procedure handlemousewheel(shift:tshiftstate;wheeldelta:integer;mousepos:tpoint);
  end;

var
PagesDlg: TPagesDlg;
winampdir,skindir,progdir:string;


implementation

uses saveform,wmain,bmps,weq,wpl, info, flowform, artwork,wmb,wavs,
  viscolor, pltext,registry,sascha, cheatdlg, regions, language,shellapi,
  math, mbtext , langselect,searchcolor,
  filectrl;

{$R *.DFM}



const redrawtimertime=10;


procedure TPagesDlg.FormCreate(Sender: TObject);
var
i:integer;
        
procedure getwinampdir;
var
i:tregistry;
s:string;
zhl:integer;
begin
  i:=tregistry.Create;
  i.rootkey:=hkey_local_machine;
  winampdir:='';
  if i.OpenKey('software\microsoft\windows\currentversion\uninstall\winamp',false)=true then
  begin           // Erst Uninstallstring prüfen
    s:=i.ReadString('uninstallstring');
    while s[length(s)]<>'\' do delete(s,length(s),1);
    if s[1]='"' then delete(s,1,1);
    if s<>'' then winampdir:=s;

    i.CloseKey;
  end;

  
  if winampdir='' then
  begin           // Dann Programmverzeichnis+'\Winamp' prüfen
    if i.OpenKey('software\microsoft\windows\currentversion',false)=true then
    begin
      s:=i.readstring('programfilesdir');
      if s<>'' then
      begin
        if s[length(s)]<>'\' then s:=s+'\';
        s:=s+'Winamp\';
      end;
      if s<>'' then winampdir:=s;
      i.closekey;
    end;
  end;
  if fileexists(winampdir+loadstringid(13))=false then
  begin            // Sonst anderes Verzeichnis oder Eingabe benutzen
    winampdir:='c:\program files\winamp\';
    if fileexists(winampdir+loadstringid(13))=false then winampdir:='c:\programme\winamp\';
  end;

  i.free;
  for zhl:=1 to length(winampdir) do winampdir[zhl]:=upcase(winampdir[zhl]);
  winampdirfound:=true;
  if fileexists(winampdir+loadstringid(13))=false then
  begin
    winampdirfound:=false;
    messagebox(splash,pchar(loadstring(13)),pchar(l_title),mb_ok or mb_iconinformation);
    winampdir:=progdir;
  end;
end;
procedure getprogdir;
begin
  progdir:=extractfilepath(paramstr(0));
  if progdir[length(progdir)]<>'\' then progdir:=progdir+'\';
end;
procedure initsaveskin;
var
i:tinifile;
s:string;
z:integer;
begin
  i:=tinifile.create(winampdir+'winamp.ini');

  s:=i.ReadString('winamp','skindir',winampdir+'SKINS');
  if s[length(s)]<>'\' then s:=s+'\';
  for z:=1 to length(s) do s[z]:=upcase(s[z]);
  skindir:=s;
  with saveskinr do
  begin
    dir:=skindir+MySkin;
    for z:=0 to 8 do what[z]:=true;
    what[9]:=false;
    zipped:=true;
  end;
  i.free;
end;
procedure initart;
begin
  with artr do
  begin
    colors[1]:=rgb(intensiv,0,0);
    colors[2]:=rgb(intensiv,intensiv,0);
    colors[3]:=rgb(0,intensiv,0);
    colors[4]:=rgb(0,intensiv,intensiv);
    colors[5]:=rgb(0,0,intensiv);
    numcolors:=4;
    direction:=0;
    bis:=1;
  end;
end;
procedure inittextr;
begin
  with textr do
  begin
    pl[1]:=rgb(0,216,0);
    pl[2]:=rgb(255,255,255);
    pl[3]:=rgb(0,0,0);
    pl[4]:=rgb(0,0,216);
    mb[1]:=rgb(0,0,0);
    mb[2]:=rgb(0,208,0);
    
    font:='Arial';
  end;
end;
begin
  if param(loadstringid(14))then splash:=0
    else splash:=createsplashscreen(handle);
  application.helpfile:=extractfilepath(paramstr(0))+'Skinamp.hlp';
  disableupdate:=true;
  getprogdir;
  setdefault;
  initlanguages;
  loadreg;
  getwinampdir;
  originalpicture:=tbitmap.create;
  originalpicture.width:=picturewidth;
  originalpicture.height:=pictureheight;
  originalpicture.pixelformat:=pixelformat;
  loadedfile:=tbitmap.create;
  loadedfile.pixelformat:=pixelformat;
  bitmap:=tbitmap.create;
  bitmap.width:=picturewidth;
  bitmap.height:=pictureheight;
  bitmap.pixelformat:=pixelformat;
  createpicture(rgb(intensiv,0,0),rgb(intensiv,intensiv,0),rgb(0,intensiv,0),rgb(0,intensiv,intensiv),rgb(0,0,intensiv),5,0,1);
  fromx:=0;
  fromy:=0;
  for i:=0 to 9 do options.checked[i]:=true;
  for i:=0 to 4 do eqoptions.checked[i]:=true;
  eqoptions.Checked[4]:=false;
  for i:=0 to 3 do ploptions.checked[i]:=true;
  for i:=0 to 1 do mboptions.checked[i]:=true;
  colorfield1.color:=rgb(0,208,0);
  colorfield2.color:=rgb(0,208,0);
  colorfield3.color:=rgb(0,0,0);

  initmask;
  initmainbitmaps;
  initeqbitmaps;

  viewing:=1;
  moving:=false;
  mousedown:=0;
  pagecontrol.ActivePageIndex:=0;
  dragacceptfiles(handle,true);
  loadedfilename:='';
  createfonts;
  redrawtimer.tag:=-1;
  doublebuffered:=true;
  cheattext:=neuercheattext('');
  initsaveskin;
  initart;
  inittextr;
  cursors.init;
  setids(self);

  disableupdate:=false;
end;

procedure TPagesDlg.FormDestroy(Sender: TObject);
begin
  cursors.done;
  savereg;
  originalpicture.free;
  loadedfile.free;
  bitmap.free;
  freemask;
  donelanguages;
end;

procedure TPagesDlg.Button1Click(Sender: TObject);
var
i:integer;
begin
  if openpicturedialog.Execute then
  begin
    disableupdate:=true;
    loadpicture(openpicturedialog.filename,true);
    clearbitmap(bitmap,rgb(255,255,255));
    fromx:=0;
    fromy:=0;
    disableupdate:=false;
    cliptypchanged;
    redraw(0,true);
    if openpicturedialog.files.count>1 then for i:=1 to openpicturedialog.files.count-1 do
    begin
      createnewinstance(openpicturedialog.files[i],i);
    end;
  end;
end;

procedure TPagesDlg.mainpictureMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mousedown<>0 then exit;
  if button=mbleft then
  begin
    if cliptyp.itemindex=1 then exit;
    mousedown:=1;
    mx:=x;
    my:=y;
    redraw(0,false);
  end;
  if button=mbright then
  begin
    if cliptyp.itemindex=1 then exit;
    mousedown:=2;
    mx:=x;
    my:=y;
    redraw(0,false);
    SetCaptureControl(mainpicture);
  end;
end;

procedure TPagesDlg.mainpictureMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mousedown=1 then
  begin
    mousedown:=0;
    mx:=0;
    my:=0;
    redraw(0,true);
  end;
  if mousedown=2 then
  begin
    mousedown:=0;
    mx:=0;
    my:=0;
    redraw(0,true);
    releasecapture;
  end;
end;

procedure tpagesdlg.correctpos;
begin
  if disableupdate then exit;
  if cliptyp.itemindex=0 then
  begin                  // Teilausschnitt
    if (loadedfile.width*prozentx) div 100>=maxwidth then
    begin
      if fromx<0 then fromx:=0;
      if fromx>loadedfile.width-(maxwidth*100) div prozentx then
        fromx:=loadedfile.width-(maxwidth*100)div prozentx;
    end else fromx:=0;
    if (loadedfile.height*prozenty) div 100>=maxheight then
    begin
      if fromy<0 then fromy:=0;
      if fromy>loadedfile.height-(maxheight*100) div prozenty then
        fromy:=loadedfile.height-(maxheight*100)div prozenty;
    end else fromy:=0;
  end else
  begin              // Kacheln
    if fromx<0 then fromx:=0;
    if fromx>=ceil((loadedfile.width*prozentx)/100) then
    fromx:=ceil((loadedfile.width*prozentx)/100);

    if fromy<0 then fromy:=0;
    if fromy>=ceil((loadedfile.height*prozenty)/100) then
    fromy:=ceil((loadedfile.height*prozenty)/100);
  end;
end;

procedure TPagesDlg.mainpictureMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
ox,oy:integer;
begin
  if mousedown=1 then
  begin
    if cliptyp.itemindex=1 then exit;
    if (originalpicture.width<picturewidth)or(originalpicture.height<pictureheight)then exit;
    if moving then exit;
    moving:=true;
    ox:=fromx;
    oy:=fromy;
    fromx:=fromx+(mx-x);
    fromy:=fromy+(my-y);
    mx:=x;
    my:=y;

    correctpos;

    if (fromx<>ox)or(fromy<>oy)then
    begin
      cliptypchanged;
      redraw(0,false);
    end;
    moving:=false;
  end;
  if mousedown=2 then
  begin
    if cliptyp.itemindex=1 then exit;
    if moving then exit;
    moving:=true;
    prozenty:=prozenty-my+y;
    prozentx:=prozentx-mx+x;
    if (cliptyp.itemindex=0)then
    begin
      if prozenty<ceil((maxheight*100)/loadedfile.height) then
         prozenty:=ceil((maxheight*100)/loadedfile.height);
      if prozentx<ceil((maxwidth*100)/loadedfile.width) then
         prozentx:=ceil((maxwidth*100)/loadedfile.width);
    end;
    if prozentx<1 then prozentx:=1;
    if prozenty<1 then prozenty:=1;
    // Wenn Gestretchtes Bild<5 Pixel dann setze p auf 5 Pixel
    if ((loadedfile.width*prozentx)/100)<minstretch then
      prozentx:=ceil((minstretch*100)/loadedfile.width);
    if ((loadedfile.height*prozenty)/100)<minstretch then
      prozenty:=ceil((minstretch*100)/loadedfile.height);

    mx:=x;
    my:=y;
    disableupdate:=true;
    edit6.text:=str(prozentx);
    edit7.text:=str(prozenty);
    disableupdate:=false;
    correctpos;
    cliptypchanged;
    redraw(0,false);
    moving:=false;
  end;
end;

function threadproc1(param:pointer):integer;
begin
  result:=0;
  if (pagesdlg.saveskinr.what[6]) then saveviscolor(param);
  if (pagesdlg.saveskinr.what[7]) then savepltext(param);
  if (pagesdlg.saveskinr.what[8]) then regionsdlg.saveregions(param);
end;

type
twhatarr=record
  what:array[0..9]of boolean;
  dir:pchar;
end;

function threadproc2(param:pointer):integer;
var
what:^twhatarr;
v:pchar;
function save(i:byte):boolean;
begin
  result:=(what^.what[i]);
end;
begin
  what:=param;
  v:=what^.dir;
  lockbitmaps;
  if save(0) then savemainbitmaps(v);
  if save(1) then saveeqbitmaps(v);
  if save(2) then saveplbitmaps(v);
  if save(3) then savembbitmaps(v);
  if save(4) then saveavsbitmaps(v);
  if save(9) then pagesdlg.cursors.save(v);
  unlockbitmaps;
  result:=0;
end;

procedure TPagesDlg.Speichern1Click(Sender: TObject);
procedure savereadme(v:pchar);
var
f:textfile;
b:array[0..100]of char;
begin
  if (readme.lines.text='')and(checkbox11.checked=false)then exit;
  assignfile(f,v+'readme.txt');
  rewrite(f);
  warte;
  if readme.lines.text<>'' then
  begin                        { Echter Text }
    writeln(f,readme.lines.text);
    if checkbox11.checked then
    begin
      writeln(f);
      writeln(f,'-------------');
    end;
  end;
  warte;
  if checkbox11.checked then
  begin                        { Werbung }
    writeln(f,'This Skin was partial generated using SkinAmp. '+
      'Skinamp is freeware, you can download it on my homepage!');
    writeln(f);
    writeln(f,loadstringid(17));
    writeln(f,'My email: '+loadstringid(8));
    writeln(f);
    writeln(f,'P.S.: I''m NOT the author of this skin!!!');
    writeln(f);
    warte;
    writeln(f,'Thank you for reading,');
    writeln(f,'      Dr. Algebra.');
    writeln(f);
    getdateformat(0,0,nil,'dd MMM, yyyy',b,100);
    writeln(f,'Date: '+b);
  end;
  warte;
  closefile(f);
  stepit;
end;
var
verz,dest:array[0..maxchar]of char;
procedure delfiles;
begin
  if saveskinr.zipped then exit;
  deletefile(verz+'region.txt');
  deletefile(verz+'pledit.txt');
  deletefile(verz+'mb.ini');
end;
const
tempfiles:array[1..48]of string=
('avs.bmp','balance.bmp','cbuttons.bmp','eq_ex.bmp','eqmain.bmp','main.bmp','mb.bmp','monoster.bmp','numbers.bmp','playpaus.bmp',
'pledit.bmp','pledit.txt','posbar.bmp','readme.txt','region.txt','shufrep.bmp','text.bmp','titlebar.bmp','viscolor.txt','volume.bmp',
'close.cur','eqclose.cur','eqnormal.cur','eqslid.cur','eqtitle.cur','mainmenu.cur','min.cur','normal.cur','pclose.cur','pnormal.cur',
'posbar.cur','psize.cur','ptbar.cur','pvscroll.cur','pwinbut.cur','pwsnorm.cur','pwssize.cur','songname.cur','titlebar.cur','volbal.cur','volbar.cur',
'winbut.cur','wsclose.cur','wsmin.cur','wsnormal.cur','wsposbar.cur','wswinbut.cur','mb.ini');

var
i:integer;
id:array[1..2]of longword;
threads:array[1..2]of thandle;
v:pchar;
saveskin:tsaveskin;
wa:twhatarr;


procedure testfilecreate;
var
f:textfile;
begin
  assignfile(f,verz+'testfile.tmp');
  rewrite(f);
  writeln(f,'Test');
  closefile(f);
  deletefile(verz+'testfile.tmp');
end;
procedure enablecontrols(e:boolean);
var
i:integer;
begin
  pagecontrol.enabled:=e;
  mainpicture.enabled:=e;
  for i:=0 to mainmenu.Items.count-1 do mainmenu.items[i].enabled:=e;
end;
begin
  { Skin speichern }
  saveskin:=tsaveskin.create(self);
  saveskin.dir.text:=saveskinr.dir;
  saveskin.zipped.checked:=saveskinr.zipped;
  for i:=0 to 9 do saveskin.what.checked[i]:=saveskinr.what[i];
  if saveskin.showmodal=mrok then
  begin
    saveskinr.zipped:=saveskin.zipped.checked;
    saveskinr.dir:=saveskin.dir.text;
    for i:=0 to 9 do saveskinr.what[i]:=saveskin.what.checked[i];
    saveskin.free;

    screen.cursor:=crhourglass;
    button2.visible:=false;
    button11.visible:=false;
    button3.visible:=false;
    sp.visible:=true;
    enablecontrols(false);
    warte;
    sp.max:=13;
    if saveskinr.zipped then sp.max:=sp.max+2;
    if saveskinr.what[9] then sp.max:=sp.max+1;
    sp.position:=0;
    strcopy(dest,pchar(saveskinr.dir));
    try
    if saveskinr.zipped=false then
    begin
      if dest[strlen(dest)-1]<>'\' then strcat(dest,'\');
      verz:=dest;
      {$I-}
      forcedirectories(verz);
      {$I+}
      if ioresult<>0 then ;
    end else begin
      if forcedirectories(extractfilepath(dest))=false then raise exception.create('Error creating destination directory!');
      gettemppath(220,verz);
      if verz[strlen(verz)-1]<>'\' then strcat(verz,'\');
      strcat(verz,'Skinamp.$$$');
      {$I-}
      mkdir(verz);
      {$I+}
      if ioresult<>0 then ;
      strcat(verz,'\');
    end;
    StepIt;
    warte;
    delfiles;

    testfilecreate;

    v:=verz;

    for i:=0 to 9 do wa.what[i]:=saveskinr.what[i];
    wa.dir:=v;

    warte;
    if (saveskinr.what[5]) then savereadme(v);
    threads[1]:=beginthread(nil,0,@threadproc1,pointer(v),0,id[1]);
    while msgwaitformultipleobjects(1,threads[1],false,infinite,qs_sendmessage or qs_postmessage or qs_allevents)<>wait_object_0 do warte;
    threads[2]:=beginthread(nil,0,@threadproc2,pointer(@wa),0,id[2]);
    while msgwaitformultipleobjects(1,threads[2],false,infinite,qs_sendmessage or qs_postmessage or qs_allevents)<>wait_object_0 do warte;
//    threadproc2(@wa);
    closehandle(threads[1]);
    closehandle(threads[2]);

    StepIt;

    if saveskinr.zipped then
    begin
      begin
        if fileexists(dest) then deletefile(dest);
        if zipfiles(verz,dest)=false then
          raise exception.create('Error zipping files to '+dest);
        stepit;
      end;
      
      for i:=1 to 48 do if fileexists(verz+tempfiles[i]) then deletefile(verz+tempfiles[i]);
      if removedir(verz)=false then application.messagebox(pchar(loadstring(14)+' ('+verz+')'),pchar(l_title),mb_ok or mb_iconexclamation);
      stepit;
    end;

    except
      on e:exception do
        application.messagebox(pchar(loadstringid(15)+#13+'Message: "'+e.message+'"'),pchar(l_title),mb_iconhand or mb_ok);
    end;
    enablecontrols(true);
    sp.visible:=false;
    button2.visible:=true;
    button11.visible:=true;
    button3.visible:=true;
    screen.cursor:=crdefault;
  end else saveskin.free;
end;

procedure TPagesDlg.cliptypClick(Sender: TObject);
begin
  case cliptyp.itemindex of
    0,2:begin
      edit6.enabled:=true;
      edit7.enabled:=true;
      groupbox1.enabled:=true;
      Label6.enabled:=true;
      Label7.enabled:=true;
    end;
    1:begin
      groupbox1.enabled:=false;
      edit6.enabled:=false;
      edit7.enabled:=false;
      Label6.enabled:=false;
      Label7.enabled:=false;
    end;
  end;
  clearbitmap(bitmap,rgb(255,255,255));
  if disableupdate=false then
  begin
    fromx:=0;
    fromy:=0;
    if cliptyp.itemindex=0 then
    begin
      if prozentx<ceil((maxwidth*100)/loadedfile.width)then
      begin
        prozentx:=ceil((maxwidth*100)/loadedfile.width);
        edit6.text:=str(prozentx);
      end;
      if prozenty<ceil((maxheight*100)/loadedfile.height)then
      begin
        prozenty:=ceil((maxheight*100)/loadedfile.height);
        edit7.text:=str(prozenty);
      end;
    end;
    cliptypchanged;
    redraw(0,true);
  end;
end;

procedure tpagesdlg.redraw;
var
tmp:tbitmap;
begin
  if disableupdate then exit;
  if what=0 then
  begin
    bitmap.canvas.brush.color:=color;
    bitmap.canvas.pen.style:=psclear;
    bitmap.canvas.brush.style:=bssolid;
    bitmap.canvas.rectangle(0,0,picturewidth+1,pictureheight+1);
  end;
  tmp:=tbitmap.create;
  tmp.width:=picturewidth;
  tmp.height:=pictureheight;
  clearbitmap(tmp,rgb(255,255,255));

  if (what in [0,1])and(viewing=1) then
  begin
    getmainbitmap(tmp,created);
    bitmap.canvas.draw(0,0,tmp);
  end;

  if (what in [0,2])and(viewing=1)then
  begin
    geteqbitmap(tmp,created);
    bitmap.canvas.draw(0,mainheight,tmp);
  end;

  if (what in [0,3])and(viewing=1) then
  begin
    getplbitmap(tmp,created,true);
    bitmap.canvas.draw(0,mainheight+eqheight,tmp);
  end;

  if (what in [0,4])and(viewing=2)then
  begin
    getmbbitmap(tmp,created);
    bitmap.canvas.draw(0,0,tmp);
  end;

  if (what in [0,5])and(viewing=3)then
  begin
    getavsbitmap(tmp,created);
    bitmap.canvas.draw(0,0,tmp);
  end;

  tmp.free;
  mainpicture.repaint;
end;

procedure TPagesDlg.Redraw1(Sender: TObject);
begin
  redraw(1,true);
end;

procedure TPagesDlg.RedrawAll(Sender: TObject);
begin
  redraw(0,true);
end;

procedure TPagesDlg.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TPagesDlg.Info1Click(Sender: TObject);
var
infodialog:tinfodialog;
begin
  infodialog:=tinfodialog.create(self);
  infodialog.showmodal;
  infodialog.free;
end;

procedure TPagesDlg.Redraw2(Sender: TObject);
begin
  redraw(2,true);
end;

procedure TPagesDlg.Redraw3(Sender: TObject);
begin
  redraw(3,true);
end;

procedure TPagesDlg.mainpicturePaint(Sender: TObject);
begin
  mainpicture.canvas.Draw(0,0,bitmap);
end;

procedure TPagesDlg.Button4Click(Sender: TObject);
procedure cb(i:integer;c:tcolorref); cdecl;
begin
  eqbezier[i]:=c;
end;
begin
  flowdlg.frame.text1.caption:=loadstring(18);
  flowdlg.frame.text2.caption:=loadstring(19);
  if (flowdlg.showmodal=mrok)then
  begin
    multiflow(1,19,flowdlg.frame.getcolor(1),flowdlg.frame.getcolor(2),flowdlg.frame.getcolor(3),flowdlg.frame.getcolor(4),flowdlg.frame.getcolor(5),flowdlg.frame.getnum,@cb);
    redraw(2,true);
  end;
end;

procedure TPagesDlg.Button5Click(Sender: TObject);
procedure cb(i:integer;c:tcolorref); cdecl;
begin
  eqbar[i]:=c;
end;
begin
  flowdlg.frame.text1.caption:=loadstring(18);
  flowdlg.frame.text2.caption:=loadstring(19);
  if (flowdlg.showmodal=mrok)then
  begin
    multiflow(0,27,flowdlg.frame.getcolor(1),flowdlg.frame.getcolor(2),flowdlg.frame.getcolor(3),flowdlg.frame.getcolor(4),flowdlg.frame.getcolor(5),flowdlg.frame.getnum,@cb);
    redraw(2,true);
  end;
end;

procedure TPagesDlg.Button6Click(Sender: TObject);
procedure cb(i:integer;c:tcolorref); cdecl;
begin
  volume[i]:=c;
end;
begin
  flowdlg.frame.text1.caption:=loadstring(20);
  flowdlg.frame.text2.caption:=loadstring(21);
  if (flowdlg.showmodal=mrok)then
  begin
    multiflow(0,27,flowdlg.frame.getcolor(1),flowdlg.frame.getcolor(2),flowdlg.frame.getcolor(3),flowdlg.frame.getcolor(4),flowdlg.frame.getcolor(5),flowdlg.frame.getnum,@cb);
    redraw(1,true);
  end;
end;

procedure TPagesDlg.Button7Click(Sender: TObject);
procedure cb(i:integer;c:tcolorref); cdecl;
begin
  balance[i]:=c;
end;
begin
  flowdlg.frame.text1.caption:=loadstring(22);
  flowdlg.frame.text2.caption:=loadstring(23);
  if (flowdlg.showmodal=mrok)then
  begin
    multiflow(0,27,flowdlg.frame.getcolor(1),flowdlg.frame.getcolor(2),flowdlg.frame.getcolor(3),flowdlg.frame.getcolor(4),flowdlg.frame.getcolor(5),flowdlg.frame.getnum,@cb);
    redraw(1,true);
  end;
end;

procedure TPagesDlg.Button8Click(Sender: TObject);
var
artdlg:tartdlg;
i:integer;
s:string;
begin
  artdlg:=tartdlg.create(self);
  artdlg.direction.itemindex:=artr.direction;
  artdlg.bisfenster.itemindex:=artr.bis;
  artdlg.Frame.numbers.itemindex:=artr.numcolors;
  artdlg.frame.numbersChange(artdlg.frame.numbers);
  for i:=1 to 5 do artdlg.frame.setcolor(i,artr.colors[i]);

  if (artdlg.showmodal=mrok)then
  begin
    artr.direction:=artdlg.direction.itemindex;
    artr.bis:=artdlg.bisfenster.itemindex;
    artr.numcolors:=artdlg.Frame.numbers.itemindex;
    for i:=1 to 5 do artr.colors[i]:=artdlg.frame.getcolor(i);

    createpicture(
      artdlg.frame.getcolor(1),
      artdlg.frame.getcolor(2),
      artdlg.frame.getcolor(3),
      artdlg.frame.getcolor(4),
      artdlg.frame.getcolor(5),
      artdlg.frame.getnum,
      artdlg.direction.itemindex,
      artdlg.bisfenster.itemindex);
    if artdlg.checkbox1.checked then
    begin
      s:=getsavefile(handle,'Bitmaps (*.bmp)'#0'*.bmp'#0'All types (*.*)'#0'*.*'#0#0,2);
      if (s<>'')then
      begin
        loadedfile.SaveToFile(s);
        loadedfilename:=s;
      end;
    end;
    fromx:=0;
    fromy:=0;
    edit6.text:='100';
    edit7.text:='100';

    cliptypchanged;
    redraw(0,true);
  end;
  artdlg.free;
end;

procedure TPagesDlg.PageControlChange(Sender: TObject);
var
ov:integer;
begin
  ov:=viewing;
  case pagecontrol.ActivePageIndex of
    1,2,3:viewing:=1;
    4:viewing:=2;
    5:viewing:=3;    
  end;
  radiogroup5.itemindex:=viewing-1;
  if ov<>viewing then
  begin
    redraw(0,true);
  end;
end;

procedure TPagesDlg.Redraw4(Sender: TObject);
begin
  redraw(4,true);
end;

procedure TPagesDlg.Beenden1Click(Sender: TObject);
begin
  close;
end;

procedure TPagesDlg.Button10Click(Sender: TObject);
begin
  viscolordlg.showmodal;
  redraw(1,true);
end;

procedure TPagesDlg.Button9Click(Sender: TObject);
var
pltext:tpltextdlg;
begin
  pltext:=tpltextdlg.create(self);
  pltext.pt1.color:=textr.pl[1];
  pltext.pt2.color:=textr.pl[2];
  pltext.pt3.color:=textr.pl[3];
  pltext.pt4.color:=textr.pl[4];
  pltext.font.text:=textr.font;

  pltext.showmodal;

  textr.pl[1]:=pltext.pt1.color;
  textr.pl[2]:=pltext.pt2.color;
  textr.pl[3]:=pltext.pt3.color;
  textr.pl[4]:=pltext.pt4.color;
  textr.font:=pltext.font.text;
  
  pltext.free;
  redraw(1,true);
  redraw(3,true);
end;

procedure TPagesDlg.RadioGroup5Click(Sender: TObject);
begin
  viewing:=radiogroup5.ItemIndex+1;
  redraw(0,true);
end;

procedure TPagesDlg.Button11Click(Sender: TObject);
var
winamp:hwnd;
i:integer;
begin
  { WinAmp starten, Skin testen }
  winamp:=findwindow(wclass,nil);
  if winamp=0 then
  begin
    if winampdirfound=false then
    begin
      messagebox(handle,pchar(loadstring(13)),pchar(l_title),mb_ok or mb_iconexclamation);
      exit;
    end;
    if application.MessageBox(pchar(loadstring(15)),pchar(l_title),mb_yesno or mb_iconquestion)=idyes then
    begin
      if winexec(pchar(winampdir+loadstringid(13)),sw_show)<=31 then
      begin
        exit;
      end;
      i:=0;
      repeat
        sleep(1);
        winamp:=findwindow(wclass,nil);
        inc(i);
      until (winamp<>0)xor(i>100);
    end else exit;
  end;
  if iswindow(winamp)=false then raise exception.Create('Winamp is still not running!');

  if winamp<>0 then begin
    { Skin setzen/neuladen... }

    if setwinampskin(pchar(saveskinr.dir))=false then
    begin { Wenn Skin nicht gesetzt, dann warnen+neuladen }
      if testwarn=false then
      begin
        application.messagebox(pchar(loadstring(31)),pchar(l_title),mb_ok or mb_iconinformation);
        testwarn:=true;
      end;
      sendmessage(winamp,wm_command,40291,0);
    end;


    // Winamp in Vordergrund holen
    sendmessage(winamp,wm_user+1,0,$202);
    showwindow(winamp,sw_restore);

    setactivewindow(winamp);
    setforegroundwindow(winamp);
  end;
end;

procedure TPagesDlg.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  if key in ['0'..'9'] then exit;
  if key in [#8,#3,#22,#24]then exit;
  if key=#13 then redraw(0,true);

  key:=#0;
end;

procedure TPagesDlg.Edit6Enter(Sender: TObject);
begin
  redraw(0,false);
  redrawtimer.enabled:=true;
end;

procedure TPagesDlg.Edit6Exit(Sender: TObject);
begin
  cliptypchanged;
  redraw(0,true);
  redrawtimer.enabled:=false;
  redrawtimer.tag:=0;
end;

procedure TPagesDlg.Edit6Change(Sender: TObject);
var
p1,p2:integer;
i:integer;
function getx:boolean;
begin
  result:=false;
  val(edit6.text,p1,i);
  if i<>0 then exit;
  if p1=0 then exit;
  if (loadedfile.width<(maxwidth*100)div p1)and(cliptyp.itemindex=0) then exit;
  if (ceil((loadedfile.width*p1)/100)<minstretch)then exit;
  if fromx>loadedfile.width-(maxwidth*100) div p1 then fromx:=loadedfile.width-(maxwidth*100)div p1;
  bmps.prozentx:=p1;
  result:=true;
end;
function gety:boolean;
begin
  result:=false;
  val(edit7.text,p2,i);
  if i<>0 then exit;
  if p2=0 then exit;
  if (loadedfile.height<(maxheight*100)div p2)and(cliptyp.itemindex=0) then exit;
  if (ceil((loadedfile.height*p2)/100)<minstretch)then exit;
  if fromy>loadedfile.height-(maxheight*100) div p2 then fromy:=loadedfile.height-(maxheight*100)div p2;
  bmps.prozenty:=p2;
  result:=true;
end;
var
rd:boolean;
begin
  // Alles testen
  if disableupdate then exit;
  rd:=getx;
  if gety then rd:=true;
  correctpos;
  if rd then redrawtimer.tag:=redrawtimertime;
end;

procedure TPagesDlg.N3D1Click(Sender: TObject);
var
i:integer;
begin
  radiogroup2.itemindex:=1;
  radiogroup6.itemindex:=0;
  buttons.itemindex:=2;
  checkbox3.checked:=true;
  checkbox4.checked:=true;
  for i:=0 to 9 do options.checked[i]:=true;

  radiogroup1.itemindex:=2;
  checkbox1.checked:=true;
  checkbox2.checked:=true;
  for i:=0 to 3 do eqoptions.checked[i]:=true;

  radiogroup3.itemindex:=2;
  checkbox5.checked:=true;
  checkbox6.checked:=true;
  for i:=0 to 3 do ploptions.checked[i]:=true;

  radiogroup4.itemindex:=2;
  checkbox7.checked:=true;
  checkbox8.checked:=true;
  for i:=0 to 1 do mboptions.checked[i]:=true;

  checkbox9.checked:=true;
  checkbox10.checked:=true;

  redraw(0,true);
end;

procedure TPagesDlg.Bitmaps1Click(Sender: TObject);
var
i:integer;
begin
  radiogroup2.itemindex:=1;
  radiogroup6.itemindex:=0;
  buttons.itemindex:=1;
  checkbox3.checked:=true;
  checkbox4.checked:=true;
  for i:=0 to 9 do options.checked[i]:=true;

  radiogroup1.itemindex:=1;
  checkbox1.checked:=true;
  checkbox2.checked:=true;
  for i:=0 to 3 do eqoptions.checked[i]:=true;

  radiogroup3.itemindex:=1;
  checkbox5.checked:=true;
  checkbox6.checked:=true;
  for i:=0 to 3 do ploptions.checked[i]:=true;

  radiogroup4.itemindex:=1;
  checkbox7.checked:=true;
  checkbox8.checked:=true;
  for i:=0 to 1 do mboptions.checked[i]:=true;

  checkbox9.checked:=true;
  checkbox10.checked:=true;

  redraw(0,true);
end;

procedure TPagesDlg.NurBild1Click(Sender: TObject);
var
i:integer;
begin
  radiogroup2.itemindex:=2;
  radiogroup6.itemindex:=0;
  
  buttons.itemindex:=2;
  checkbox3.checked:=false;
  checkbox4.checked:=true;
  options.checked[0]:=false;
  options.checked[1]:=false;
  options.checked[2]:=false;
  options.checked[3]:=false;
  options.checked[4]:=false;
  options.checked[5]:=true;
  options.checked[6]:=true;
  options.checked[7]:=true;
  options.checked[8]:=true;
  options.checked[9]:=false;

  radiogroup1.itemindex:=0;
  checkbox1.checked:=false;
  checkbox2.checked:=false;
  checkbox14.checked:=false;
  for i:=0 to 3 do eqoptions.checked[i]:=false;
  edit2.text:='';

  radiogroup3.itemindex:=0;
  checkbox5.checked:=false;
  checkbox6.checked:=false;
  for i:=0 to 3 do ploptions.checked[i]:=false;
  edit3.text:='';

  radiogroup4.itemindex:=0;
  checkbox7.checked:=false;
  checkbox8.checked:=false;
  for i:=0 to 1 do mboptions.checked[i]:=false;
  edit4.text:='';

  checkbox9.checked:=false;
  checkbox10.checked:=true;

  redraw(0,true);
end;

procedure TPagesDlg.Button12Click(Sender: TObject);
var
skincheat:tskincheat;
begin
  skincheat:=tskincheat.create(self);
  skincheat.cheattext.text:=cheattext;
  if skincheat.showmodal=mrok then cheattext:=skincheat.cheattext.text;
  skincheat.free;
end;

procedure TPagesDlg.Button13Click(Sender: TObject);
begin
  regionsdlg.showmodal;
end;

procedure tpagesdlg.dropfiles;
var
a:array[0..200]of char;
e:string;
num,i:integer;
begin
  setforegroundwindow(handle);
  num:=dragqueryfile(msg.wparam,uint(-1),pchar(@a[0]),200);
  for i:=0 to num-1 do
  begin
    dragqueryfile(msg.wparam,i,pchar(@a[0]),200);
    if i<>0 then
    begin
      createnewinstance(string(a),i);
    end else begin
      e:=grosswort(extractfileext(string(a)));
      if e='.SKN' then loadskinfile(string(a)) else
      begin
        loadpicture(a,true);
        redraw(0,true);
      end;
    end;
  end;
end;

procedure TPagesDlg.Label6Click(Sender: TObject);
begin
  edit6.text:='100';
  cliptypchanged;
  redraw(0,true);
end;

procedure TPagesDlg.Label7Click(Sender: TObject);
begin
  edit7.text:='100';
  cliptypchanged;
  redraw(0,true);
end;

procedure TPagesDlg.StaticText1Click(Sender: TObject);
begin
  edit6.text:=str(ceil((maxwidth*100)/loadedfile.width));
  cliptypchanged;
  redraw(0,true);
end;

procedure TPagesDlg.StaticText2Click(Sender: TObject);
begin
  edit7.text:=str(ceil((maxheight*100)/loadedfile.height));
  cliptypchanged;
  redraw(0,true);
end;

procedure tpagesdlg.lang_select;
var
i:integer;
begin
  currentlanguage:=(sender as tmenuitem).tag;
  setlanguage;
  for i:=1 to maxlang do if (langfiles[i]<>'')then mainmenu.items[2].items[i-1].checked:=false;
  (sender as tmenuitem).checked:=true;
end;

procedure tpagesdlg.initialisate;
procedure runlangselect;
var
zhl:integer;
s:string;
i:tlistitem;
languagedlg:tlanguagedlg;
begin
  destroywindow(splash);
  splash:=0;
  languagedlg:=tlanguagedlg.create(self);

  with languagedlg do
  begin
    languages.items.clear;
    for zhl:=1 to maxlang do if langfiles[zhl]<>'' then
    begin
      s:=loadstringfromfile(0,langfiles[zhl]);
      if pos('&',s)>0 then delete(s,pos('&',s),1);
      i:=languages.items.Add;
      i.ImageIndex:=-1;
      i.caption:=s;
      s:=loadstringfromfile(12,langfiles[zhl]);
      if (length(s)>1)and(s[1]='*')then s:='';
      i.subitems.add(s);
      i.subitems.Add(langfiles[zhl]);
      if grosswort(langfiles[zhl])='ENGLISH.LNG' then
      begin
        i.selected:=true;
        i.focused:=true;
      end;
    end;

    showmodal;
    for zhl:=1 to languages.items.count do if grosswort(langfiles[zhl])=grosswort(languages.Selected.subitems[1]) then currentlanguage:=zhl;
  end;
  languagedlg.free;
end;
var
i,j,k:integer;
begin
  disableupdate:=true;
  if (currentlanguage<=0)or(currentlanguage>maxlang) then runlangselect;
  setlanguage;
  for i:=1 to paramcount do if grosswort(copy(paramstr(i),1,3))='/Y=' then
  begin
    val(copy(paramstr(i),4,length(paramstr(i))-3),j,k);
    if (k=0)and(j<screen.height-height) then top:=j;
    break;
  end;
  for i:=1 to paramcount do if grosswort(copy(paramstr(i),1,3))='/X=' then
  begin
    val(copy(paramstr(i),4,length(paramstr(i))-3),j,k);
    if (k=0)and(j<screen.width-width) then left:=j;
    break;
  end;
  if fileexists(progdir+'default.skn')then loadskinfile(progdir+'default.skn');
  if (paramstr(1)<>'')and(fileexists(paramstr(1))) then
  begin
    if grosswort(extractfileext(paramstr(1)))='.SKN' then
      loadskinfile(paramstr(1))
    else loadpicture(paramstr(1),true);
  end;
  if paramcount>1 then for i:=2 to paramcount do
  begin
    if fileexists(paramstr(i)) then
      createnewinstance(paramstr(i),i-1);
  end;
  disableupdate:=false;
  cliptypchanged;
  redraw(0,true);
end;

const
reg_path='Software\Sascha Hlusiak Software\SkinAmp';

procedure tpagesdlg.loadreg;
var
i:tregistry;
begin
  i:=tregistry.create;
  i.rootkey:=hkey_current_user;
  if i.OpenKey(reg_path,false) then
  begin
    try
      currentlanguage:=i.Readinteger('Language');
    except 
      currentlanguage:=0;
    end;
    try
      testwarn:=i.readbool('Testwarn');
      openpicturedialog.initialdir:=i.readstring('PictureDir');
      opendialog.initialdir:=i.readstring('SaveFilesDir');
      savedialog.initialdir:=opendialog.initialdir;
      colordialog.customcolors.commatext:=i.readstring('CustomColors');
      defaultbitmapsfile:=i.readstring('DefaultBitmaps');
      defaultmasksfile:=i.readstring('DefaultMasks');
    except
      testwarn:=false;
      openpicturedialog.initialdir:='';
      opendialog.initialdir:='';
      savedialog.initialdir:='';
      defaultbitmapsfile:=progdir+'bitmaps.bmp';
      defaultmasksfile:=progdir+'masks.bmp';
    end;
  end else
  begin
    testwarn:=false;
    currentlanguage:=0;
    openpicturedialog.initialdir:='';
    opendialog.initialdir:='';
    savedialog.initialdir:='';
    defaultbitmapsfile:=progdir+'bitmaps.bmp';
    defaultmasksfile:=progdir+'masks.bmp';
  end;
  if (langfiles[currentlanguage]='')then currentlanguage:=0;
  if (defaultbitmapsfile='')or(not fileexists(defaultbitmapsfile)) then defaultbitmapsfile:=progdir+loadstringid(5);
  if (defaultmasksfile='')or(not fileexists(defaultbitmapsfile)) then defaultmasksfile:=progdir+loadstringid(4);
  i.free;
end;

procedure tpagesdlg.savereg;
var
i:tregistry;
s:string;
begin
  i:=tregistry.create;
  i.rootkey:=hkey_current_user;
  if i.openkey(reg_path,true)then
  begin
    i.writeinteger('Language',currentlanguage);
    i.writebool('Testwarn',testwarn);
    s:=extractfilepath(openpicturedialog.filename);
    if s='' then s:=openpicturedialog.InitialDir;
    i.writestring('PictureDir',s);
    s:=extractfilepath(opendialog.filename);
    if s='' then s:=opendialog.InitialDir;
    i.writestring('SaveFileDir',s);
    i.writestring('CustomColors',colordialog.customcolors.CommaText);
    i.writestring('DefaultBitmaps',defaultbitmapsfile);
    i.writestring('DefaultMasks',defaultmasksfile);
  end;
  i.free;
end;

procedure TPagesDlg.Button14Click(Sender: TObject);
begin
  if fontdialog.Execute then redraw(0,true);
end;

procedure TPagesDlg.RadioGroup8Click(Sender: TObject);
begin
  originalpicture.height:=maxheight;
  originalpicture.width:=maxwidth;
  correctpos;
  cliptypchanged;
  redraw(4,true);
end;

procedure TPagesDlg.RadioGroup7Click(Sender: TObject);
begin
  originalpicture.height:=maxheight;
  originalpicture.width:=maxwidth;
  correctpos;
  cliptypchanged;
  redraw(3,true);
end;

procedure TPagesDlg.Button15Click(Sender: TObject);
var
mbtext:tmbtextdlg;
begin
  mbtext:=tmbtextdlg.create(self);
  mbtext.mt1.color:=textr.mb[1];
  mbtext.mt2.color:=textr.mb[2];
  mbtext.showmodal;
  textr.mb[1]:=mbtext.mt1.color;  
  textr.mb[2]:=mbtext.mt2.color;  
  mbtext.free;
  redraw(4,true);
end;

procedure TPagesDlg.Speichern2Click(Sender: TObject);
begin
  { Skin als .skn Datei abspeichern }
  if loadedfilename='#1' then
  begin
    if savepicturedialog.execute=false then exit;
    loadedfile.savetofile(savepicturedialog.filename);
    loadedfilename:=savepicturedialog.filename;
  end;
  if savedialog.execute then
  begin
    opendialog.filename:=savedialog.filename;
    saveskinfile(savedialog.filename);
  end;
end;

procedure TPagesDlg.Laden1Click(Sender: TObject);
begin
  if opendialog.execute then
  begin
    savedialog.filename:=opendialog.filename;
    loadskinfile(opendialog.filename);
  end;
end;

procedure TPagesDlg.Pasteclipboard1Click(Sender: TObject);
var
temp:tbitmap;
begin
  if clipboard.hasformat(cf_bitmap)=false then
  begin
    application.messagebox(pchar(loadstring(10)),pchar(l_title),mb_iconexclamation or mb_ok);
    exit;
  end;
  temp:=tbitmap.create;
  temp.assign(clipboard);
  loadedfile.width:=temp.width;
  loadedfile.height:=temp.height;
  loadedfile.canvas.copyrect(rect(0,0,temp.width,temp.height),temp.canvas,rect(0,0,temp.width,temp.height));
  loadedfilename:='#1';
  temp.free;
  cliptypchanged;
  redraw(0,true);
end;

procedure TPagesDlg.Redraw5(Sender: TObject);
begin
  redraw(5,true);
end;

procedure TPagesDlg.Hilfe2Click(Sender: TObject);
begin
  application.helpjump('main_index');
end;

procedure TPagesDlg.RefreshExecute(Sender: TObject);
begin
  redraw(0,true);
end;

procedure TPagesDlg.createfonts;
var
i:integer;
mi:tmenuitem;
begin
  fontmenu.items.clear;
  for i:=0 to screen.fonts.count-1 do
  begin
    mi:=tmenuitem.create(fontmenu);
    mi.caption:=screen.fonts[i];
    mi.ondrawitem:=drawfontmenuitem;
    mi.onmeasureitem:=measurefontmenuitem;
    mi.onclick:=selectfontmenuitem;

    if (i<>0)and((i) mod (getsystemmetrics(sm_cyscreen)div getsystemmetrics(sm_cymenu))=0) then mi.break:=mbbarbreak;
    fontmenu.items.add(mi);
  end;
end;

const
schrift=-16;
menuheight=17;

procedure TPagesDlg.drawfontmenuitem(Sender:TObject;ACanvas:TCanvas;ARect:TRect;Selected:Boolean);
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

procedure tpagesdlg.selectfontmenuitem;
begin
  fontmenucallbackproc((sender as tmenuitem).caption);
end;

procedure tpagesdlg.measurefontmenuitem;
begin
  acanvas.font.name:=tmenuitem(sender).caption;
  acanvas.font.height:=schrift;
  width:=acanvas.textwidth(tmenuitem(sender).caption);
  height:=menuheight;
end;

procedure globalfontcb(f:string); far;
begin
  pagesdlg.fontdialog.font.name:=f;
  pagesdlg.redraw(0,true);
end;

procedure TPagesDlg.Button14ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  mousepos:=(sender as tbutton).clienttoscreen(mousepos);
  popupfontmenu(mousepos,@globalfontcb);
  handled:=true;
end;

procedure pltabcb(s:string);
begin
  pagesdlg.textr.Font:=s;
  pagesdlg.redraw(3,true);
end;

procedure TPagesDlg.Button9ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  popupfontmenu((sender as tbutton).clienttoscreen(mousepos),@pltabcb);
  handled:=true;
end;

procedure TPagesDlg.Standard1Click(Sender: TObject);
begin
  saveskinfile(progdir+'default.skn');
end;

procedure TPagesDlg.N6Click(Sender: TObject);
begin
  pagesdlg.PageControl.ActivePageIndex:=5;
end;

procedure TPagesDlg.NeuesFenster1Click(Sender: TObject);
var
temp:array[0..100]of char;
s:string;
begin
  gettemppath(100,temp);
  s:=temp;
  if s[length(s)]<>'\' then s:=s+'\';
  s:=s+'skinamp.skn';
  saveskinfile(s);
  createnewinstance(s,1);
  deletefile(s);
end;

procedure TPagesDlg.ColorField2LeftClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  colordialog.color:=(sender as tcolorfield).color;
  if colordialog.execute then (sender as tcolorfield).color:=colordialog.color;
end;

procedure TPagesDlg.ColorField2Redraw(Sender: TObject);
begin
  redraw(1,true);
  redraw(3,true);
end;

procedure TPagesDlg.ColorField2RightClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  (sender as tcolorfield).color:=getcolor((sender as tcolorfield).color);
end;

procedure TPagesDlg.Button16Click(Sender: TObject);
begin
  cursors.showmodal;
end;

procedure TPagesDlg.redrawtimerTimer(Sender: TObject);
var
up:boolean;
begin
  if redrawtimer.tag=0 then exit;
  if redrawtimer.tag<0 then up:=true else up:=false;

  if up then redrawtimer.tag:=redrawtimer.tag+1
    else redrawtimer.tag:=redrawtimer.tag-1;
  if redrawtimer.tag<>0 then exit;

  begin
    if cliptyp.itemindex=2 then screen.cursor:=crhourglass;
    cliptypchanged;
    redraw(0,up);
    if cliptyp.itemindex=2 then screen.cursor:=crdefault;
  end;
end;

procedure TPagesDlg.StepIt;
begin
  postmessage(sp.handle,pbm_stepit,0,0);
  warte;
end;

procedure TPagesDlg.AlsBild1Click(Sender: TObject);
var
b,temp:tbitmap;
g:tgraphic;
begin
  if saveskinbitmapdialog.execute then with saveskinbitmapdialog do
  begin
    screen.cursor:=crhourglass;
    b:=tbitmap.create;
    b.width:=picturewidth;
    b.height:=pictureheight;
    b.pixelformat:=pixelformat;
    temp:=tbitmap.create;

    getmainbitmap(temp,true);
    b.canvas.draw(0,0,temp);
    geteqbitmap(temp,true);
    b.canvas.draw(0,mainheight,temp);
    getplbitmap(temp,true,false);
    b.canvas.draw(0,mainheight+eqheight,temp);

    temp.free;

    case filterindex of
      1:g:=tjpegimage.create;
      2:begin
        b.pixelformat:=pf8bit;
        savetofilesingle(filename,b,false,false,0);
        b.free;
        screen.cursor:=crdefault;
        exit;
      end;
      else g:=tbitmap.create;
    end;

    g.assign(b);
    b.free;

    g.savetofile(filename);
    g.free;
    screen.cursor:=crdefault;
  end;
end;

procedure TPagesDlg.FormShow(Sender: TObject);
begin
  if splash<>0 then
  begin
    destroysplashscreen(splash);
    splash:=0;
  end;
end;

procedure tpagesdlg.createnewinstance;
begin
  trunthread.create(paramstr(0),'"'+filename+'" /X='+str(left+offset*15)+' /Y='+str(top+offset*15)+' '+loadstringid(14));
end;

procedure TPagesDlg.RefreshTestExecute(Sender: TObject);
var
start,stop:dword;
begin
  start:=gettickcount;
  redraw(0,true);
  stop:=gettickcount-start;
  application.messagebox(pchar('Refresh in '+str(stop)+' ms.'),'Test',mb_ok or mb_iconinformation);
end;

procedure TPagesDlg.Masksbmp1Click(Sender: TObject);
var
op:openfilename;
b:array[0..1024]of char;
begin
  b:=#0;
  zeromemory(@op,sizeof(op));
  op.lStructSize:=sizeof(op);
  op.hWndOwner:=handle;
  op.hInstance:=hinstance;
  op.lpstrFilter:='Bitmaps (*.bmp)'#0'*.bmp'#0'All files (*.*)'#0'*.*'#0#0;
  op.lpstrTitle:='Load masks';
  op.Flags:=ofn_pathmustexist or ofn_filemustexist;
  op.lpstrfile:=@b;
  op.nmaxfile:=1024-1;
  op.nMaxCustFilter:=2;
  op.lpstrdefext:='bmp';

  if getopenfilename(op)=false then exit;

  screen.cursor:=crhourglass;
  assignmasksfile(b);
  redraw(0,true);
  screen.cursor:=crdefault;
end;

procedure TPagesDlg.Bitmapbmp1Click(Sender: TObject);
var
op:openfilename;
b:array[0..1024]of char;
begin
  b:=#0;
  zeromemory(@op,sizeof(op));
  op.lStructSize:=sizeof(op);
  op.hWndOwner:=handle;
  op.hInstance:=hinstance;
  op.lpstrFilter:='Bitmaps (*.bmp)'#0'*.bmp'#0'All files (*.*)'#0'*.*'#0#0;
  op.lpstrTitle:='Load bitmaps file';
  op.Flags:=ofn_pathmustexist or ofn_filemustexist;
  op.lpstrfile:=@b;
  op.nmaxfile:=1024-1;
  op.nMaxCustFilter:=2;
  op.lpstrdefext:='bmp';

  if getopenfilename(op)=false then exit;

  screen.cursor:=crhourglass;
  assignbitmapsfile(b);
  redraw(0,true);
  screen.cursor:=crdefault;
end;

procedure TPagesDlg.Standard2Click(Sender: TObject);
begin
  defaultmasksfile:=masksfile;
  defaultbitmapsfile:=bitmapsfile;
end;

procedure TPagesDlg.CheckBox14Click(Sender: TObject);
var
b:boolean;
begin
  b:=checkbox14.checked;
  eqoptions.itemenabled[1]:=b;
  eqoptions.itemenabled[2]:=b;
  eqoptions.itemenabled[3]:=b;
  button4.enabled:=b;
  button5.enabled:=b;
  eqoptions.invalidate;
  redraw2(sender);
end;

procedure TPagesDlg.optionsClickCheck(Sender: TObject);
var
c:tchecklistbox;
i:integer;
begin
  c:=sender as tchecklistbox;
  for i:=0 to 9 do if
    (c.state[i]=cbgrayed)and(i in [0..1,5..9])then c.state[i]:=cbchecked;
  redraw1(sender);
end;

procedure TPagesDlg.MinimizeExecute(Sender: TObject);
begin
  application.minimize;
end;

procedure tpagesdlg.wmredraw;
begin
  if hiword(msg.wparam)=1 then cliptypchanged;
  redraw(loword(msg.wparam),boolean(msg.lparam));
end;

procedure tpagesdlg.handlemousewheel;
begin
  wheeldelta:=wheeldelta div wheel_delta;

  if (ssalt in shift)=false then wheeldelta:=wheeldelta*5;

  if (ssshift in shift) then fromx:=fromx-wheeldelta
    else fromy:=fromy-wheeldelta;
  correctpos;

  redrawtimer.enabled:=true;
  redrawtimer.tag:=-redrawtimertime;
end;

procedure TPagesDlg.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
msg:tmsg;
begin
  handled:=false;

  mousepos:=mainpicture.ScreenToClient(mousepos);
  if (mousepos.x<0)or(mousepos.y<0)or(mousepos.x>mainpicture.width)or(mousepos.y>mainpicture.height)then exit;

  handlemousewheel(shift,wheeldelta,mousepos);

  if (peekmessage(msg,0,wm_mousewheel,wm_mousewheel,pm_noremove)=false)and
     (peekmessage(msg,0,wm_redraw,wm_redraw,pm_noremove)=false) then
  begin
    cliptypchanged;
    redraw(0,false);
  end;

  handled:=true;
end;

procedure TPagesDlg.Button2ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

procedure TPagesDlg.BBearbeiten1Click(Sender: TObject);
begin
  shellexecute(handle,'edit',pchar(bitmapsfile),nil,nil,sw_show);
end;

procedure TPagesDlg.MBearbeiten1Click(Sender: TObject);
begin
  shellexecute(handle,'edit',pchar(masksfile),nil,nil,sw_show);
end;

procedure TPagesDlg.ReloadSourceExecute(Sender: TObject);
begin
  if loadedfilename='' then exit;
  screen.cursor:=crhourglass;
  loadpicture(loadedfilename,false);
  cliptypchanged;
  redraw(0,true);
  screen.cursor:=crdefault;
end;

procedure TPagesDlg.Edit8Change(Sender: TObject);
begin
  redraw(4,TRUE);
end;

end.




