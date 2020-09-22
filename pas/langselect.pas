unit langselect;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls,skinampc,funktionen, ImgList;

type
  Tlanguagedlg = class(TForm)
    okbutton: TButton;
    StaticText1: TStaticText;
    Languages: TListView;
    Image1: TImage;
    procedure LanguagesDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LanguagesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure LanguagesContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.DFM}

procedure Tlanguagedlg.LanguagesDblClick(Sender: TObject);
var
m:tpoint;
i:tlistitem;
begin
  m:=languages.screentoclient(mouse.cursorpos);
  i:=languages.GetItemAt(m.x,m.y);
  if i<>nil then close;
end;

procedure Tlanguagedlg.FormCreate(Sender: TObject);
var
i:hicon;
dll:thandle;
begin
  dll:=dllinstance;
  i:=LoadIcon(dll,makeintresource(110));
  image1.Picture.icon.handle:=i;
  setids(self);
end;

procedure Tlanguagedlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  canclose:=(languages.selected<>nil)or(languages.items.count=0);
end;

procedure Tlanguagedlg.LanguagesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if languages.selected=nil then okbutton.enabled:=false else okbutton.enabled:=true;
end;

procedure Tlanguagedlg.LanguagesContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
