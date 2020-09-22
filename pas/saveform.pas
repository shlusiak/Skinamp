unit saveform;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst,skinampc;

type
  Tsaveskin = class(TForm)
    Button1: TButton;
    Button2: TButton;
    dir: TEdit;
    StaticText1: TStaticText;
    what: TCheckListBox;
    Zipped: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ZippedClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dirEnter(Sender: TObject);
    procedure StaticText1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    skindir:string;
  end;

implementation

uses inifiles,main,sascha,filectrl,language,funktionen,konstanten;


{$R *.DFM}

procedure Tsaveskin.FormCreate(Sender: TObject);
begin
  StaticText1.caption:=loadstring(1150);
  Zipped.caption:=loadstring(1151);
  Button1.caption:=loadstring(1152);
  button2.caption:=loadstring(903);
  caption:=loadstring(1153);
  setids(self);
end;

procedure Tsaveskin.ZippedClick(Sender: TObject);
begin
  if zipped.checked then
  begin
    if (pos('.',copy(dir.text,length(dir.text)-4,4))=0)and(
    dir.text[length(dir.text)]<>'\') then dir.text:=dir.text+'.wsz';
  end else
  begin
    if grosswort(copy(dir.text,length(dir.text)-3,4))='.WSZ' then dir.text:=copy(dir.text,1,pos('.',dir.text)-1);
  end;
end;

procedure Tsaveskin.Button1Click(Sender: TObject);
begin
  if (trim(dir.text)='')then
  begin
    dir.text:=main.skindir+myskin;
    exit;
  end;
  if ((zipped.checked=false)and(directoryexists(dir.text)))or((zipped.checked=true)and(fileexists(dir.text)))then
  begin
    if application.messagebox(pchar(loadstring(32)),pchar(l_title),mb_yesno or mb_iconinformation)=idyes then
    begin
      modalresult:=mrok;
    end;
  end else modalresult:=mrok;
end;

procedure Tsaveskin.FormShow(Sender: TObject);
begin
  activecontrol:=dir;
end;                      

procedure Tsaveskin.dirEnter(Sender: TObject);
var
i:integer;
begin
  for i:=length(dir.text)downto 1 do if dir.text[i]='\' then break;
  dir.selstart:=i;
  if zipped.checked then dir.sellength:=pos('.',dir.text)-i-1
    else dir.sellength:=length(dir.text)-i+1;
end;

procedure Tsaveskin.StaticText1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
