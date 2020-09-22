unit flowform;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  flowframe, StdCtrls,bmps, ExtCtrls,skinampc,funktionen;

type
  TFlowDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Frame: TFlowFrm;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Button3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Button1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure executeflow(min,max:integer;fp:tflowproc);
  end;

var
  FlowDlg: TFlowDlg;

implementation

{$R *.DFM}

procedure TFlowDlg.FormCreate(Sender: TObject);
begin
  frame.numbers.itemindex:=2;
  setids(self);
end;

procedure tflowdlg.executeflow;
begin
end;

procedure TFlowDlg.Button3Click(Sender: TObject);
begin
  with frame do
  begin
    setcolor(1,getrandomcolor);
    repeat
      setcolor(2,getrandomcolor);
    until getcolor(2)<>getcolor(1);
    repeat
      setcolor(3,getrandomcolor);
    until getcolor(3)<>getcolor(2);
    repeat
      setcolor(4,getrandomcolor);
    until getcolor(4)<>getcolor(3);
    repeat
      setcolor(5,getrandomcolor);
    until getcolor(5)<>getcolor(4);
    beispiel.invalidate;
  end;
end;

procedure TFlowDlg.Button4Click(Sender: TObject);
var
zhl:integer;
c:tcolorref;
begin
  for zhl:=1 to round(int(frame.getnum/2)) do
  begin
    c:=frame.getcolor(zhl);
    frame.setcolor(zhl,frame.getcolor(frame.getnum-zhl+1));
    frame.setcolor(frame.getnum-zhl+1,c);
  end;
  frame.Beispiel.invalidate;
end;

procedure TFlowDlg.Button3DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if source is tshape then accept:=true else accept:=false;
end;

procedure TFlowDlg.Button3DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  (source as tshape).brush.color:=getrandomcolor;
  frame.beispiel.invalidate;
end;

procedure TFlowDlg.Button1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.
