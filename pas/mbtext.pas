unit mbtext;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ColorField;

type
  Tmbtextdlg = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    mt1: TColorField;
    mt2: TColorField;
    procedure FormCreate(Sender: TObject);
    procedure mt1LeftClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mt1RightClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

uses searchcolor, main,language,funktionen;

{$R *.DFM}

procedure Tmbtextdlg.FormCreate(Sender: TObject);
begin
  caption:=loadstring(1400);
  groupbox1.caption:=loadstring(1400);
  label1.caption:=loadstring(1401);
  label2.caption:=loadstring(1402);
  button1.caption:=loadstring(901);
  setids(self);
end;

procedure Tmbtextdlg.mt1LeftClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pagesdlg.colordialog.color:=(sender as tcolorfield).color;
  if pagesdlg.colordialog.execute then (sender as tcolorfield).color:=pagesdlg.colordialog.color;
end;

procedure Tmbtextdlg.mt1RightClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (sender as tcolorfield).color:=getcolor((sender as tcolorfield).color);
end;

procedure Tmbtextdlg.Button1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
