unit cheatdlg;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,language,funktionen;

type
  Tskincheat = class(TForm)
    Button1: TButton;
    cheattext: TEdit;
    Button3: TButton;
    StaticText1: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
    procedure neuertext;
  public
    { Public-Deklarationen }
  end;

function neuercheattext(old:string):string;

implementation

uses main;

{$R *.DFM}

const
maxtext=14;
texte:array[1..maxtext]of string=
(
'Looks best at 2 ‰',
'Nullsoft Winamp',
'by SkinAmp: Dr.Algebra@gmx.de',
'ó¿ó',
'Don''t forget to brush your teeth every day',
'http://members.tripod.de/DrAlgebra',
'Winamp makes me smile :-)',
'Yabba-dabba-duh!',
'Do do do do do - Hey...',
'www.winamp.com',
'Justin CAN code!!!',
'It really whips the skinners ass!',
'pi=3,1415926535897932384626433832',
'=)');


function neuercheattext(old:string):string;
var
s:string;
begin
  repeat
    s:=texte[random(maxtext)+1];
  until old<>s;
  result:=s;
end;

procedure tskincheat.neuertext;
begin
  cheattext.text:=neuercheattext(cheattext.text);
end;

procedure Tskincheat.FormCreate(Sender: TObject);
begin
  caption:=loadstring(1302);
  statictext1.caption:=loadstring(1301);
  button1.caption:=loadstring(901);
  button3.caption:=loadstring(1300);
  neuertext;
  setids(self);
end;

procedure Tskincheat.Button3Click(Sender: TObject);
begin
  neuertext;
end;

procedure Tskincheat.Button3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
