unit flowframe;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ColorField,skinampc,funktionen;

type
  TFlowFrm = class(TFrame)
    Label1: TLabel;
    numbers: TComboBox;
    text1: TStaticText;
    text2: TStaticText;
    Beispiel: TPaintBox;
    c1: TColorField;
    c2: TColorField;
    c3: TColorField;
    c4: TColorField;
    c5: TColorField;
    procedure numbersChange(Sender: TObject);
    procedure BeispielPaint(Sender: TObject);
    procedure c1LeftClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c1Redraw(Sender: TObject);
    procedure c1RightClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure numbersContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function getcolor(what:integer):tcolorref;
    procedure setcolor(what:integer;c:tcolorref);
    function getnum:integer;
  end;

implementation

uses bmps,searchcolor, main;

{$R *.DFM}

procedure TFlowFrm.numbersChange(Sender: TObject);
begin
  if numbers.itemindex<4 then c5.visible:=false else c5.visible:=true;
  if numbers.itemindex<3 then c4.visible:=false else c4.visible:=true;
  if numbers.itemindex<2 then c3.visible:=false else c3.visible:=true;
  if numbers.itemindex<1 then c2.visible:=false else c2.visible:=true;
  case numbers.itemindex of
    1:text2.top:=c2.top;
    2:text2.top:=c3.top;
    3:text2.top:=c4.top;
    4:text2.top:=c5.top;
  end;
  beispiel.invalidate;
end;

function tflowfrm.getcolor;
begin
  case what of
    1:result:=c1.color;
    2:result:=c2.color;
    3:result:=c3.color;
    4:result:=c4.color;
    5:result:=c5.color;
    else result:=rgb(0,0,0);
  end;
end;

procedure tflowfrm.setcolor;
begin
  case what of
    1:c1.color:=c;
    2:c2.color:=c;
    3:c3.color:=c;
    4:c4.color:=c;
    5:c5.color:=c;
  end;
end;

function tflowfrm.getnum;
begin
  result:=numbers.itemindex+1;
end;

var
colors:array[0..19]of tcolorref;

procedure TFlowFrm.BeispielPaint(Sender: TObject);
procedure cb(p:integer;c:tcolorref); cdecl;
begin
  colors[p]:=c;
end;
var
i:integer;
begin
  beispiel.canvas.brush.style:=bssolid;
  beispiel.canvas.pen.style:=psclear;
  multiflow(0,19,getcolor(1),getcolor(2),getcolor(3),getcolor(4),getcolor(5),getnum,@cb);
  for i:=0 to 19 do
  begin
    beispiel.canvas.brush.color:=colors[i];
    beispiel.canvas.rectangle(0,round(beispiel.height/20*i),beispiel.width,1+round((beispiel.height/20*(i+1))));
  end;
end;

procedure TFlowFrm.c1LeftClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pagesdlg.colordialog.color:=(sender as tcolorfield).color;
  if pagesdlg.colordialog.execute then (sender as tcolorfield).color:=pagesdlg.colordialog.color;
end;

procedure TFlowFrm.c1Redraw(Sender: TObject);
begin
  beispiel.invalidate;
end;

procedure TFlowFrm.c1RightClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (sender as tcolorfield).color:=searchcolor.getcolor((sender as tcolorfield).color);
end;

procedure TFlowFrm.numbersContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
