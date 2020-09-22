unit artwork;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, flowframe, ExtCtrls,colorfield,skinampc,funktionen;

type
  TArtDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Frame: TFlowFrm;
    GroupBox1: TGroupBox;
    Direction: TRadioGroup;
    bisfenster: TRadioGroup;
    Button3: TButton;
    CheckBox1: TCheckBox;
    procedure DirectionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FramenumbersChange(Sender: TObject);
    procedure Button3DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Button3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure DirectionContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


implementation

uses bmps,language, main;

{$R *.DFM}

procedure TArtDlg.DirectionClick(Sender: TObject);
begin
  if direction.itemindex=0 then
  begin
    frame.text1.caption:=loadstring(18);
    frame.text2.caption:=loadstring(19);
    bisfenster.enabled:=true;
  end;
  if direction.itemindex=1 then
  begin
    frame.text1.caption:=loadstring(24);
    frame.text2.caption:=loadstring(25);
    bisfenster.enabled:=false;
  end;
  if direction.itemindex=2 then
  begin
    frame.text1.caption:=loadstring(26);
    frame.text2.caption:=loadstring(29);
    bisfenster.enabled:=false;
  end;
  if direction.itemindex=3 then
  begin
    frame.text1.caption:=loadstring(27);
    frame.text2.caption:=loadstring(28);
    bisfenster.enabled:=false;
  end;
end;

procedure TArtDlg.FormCreate(Sender: TObject);
begin
  caption:=loadstring(1258);
  direction.caption:=loadstring(1259);
  setstrings(direction.items,1250,4);
  groupbox1.caption:=loadstring(1256);
  frame.label1.caption:=loadstring(904);
  frame.text1.caption:=loadstring(18);
  frame.text2.caption:=loadstring(19);
  button1.caption:=loadstring(902);
  button2.caption:=loadstring(903);
  button3.caption:=loadstring(1300);
  bisfenster.caption:=loadstring(1257);
  setstrings(bisfenster.items,1254,2);

  checkbox1.caption:=loadstring(1152);
    
  frame.numbers.itemindex:=4;
  frame.numbersChange(frame.numbers);
  frame.c1.color:=rgb(intensiv,0,0);
  frame.c2.color:=rgb(intensiv,intensiv,0);
  frame.c3.color:=rgb(0,intensiv,0);
  frame.c4.color:=rgb(0,intensiv,intensiv);
  frame.c5.color:=rgb(0,0,intensiv);

  frame.beispiel.visible:=false;
  setids(self);
end;

procedure TArtDlg.FramenumbersChange(Sender: TObject);
begin
  Frame.numbersChange(Sender);
end;

procedure TArtDlg.Button3DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if source is tcolorfield then accept:=true else accept:=false;
end;

procedure TArtDlg.Button3DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  (source as tcolorfield).color:=getrandomcolor;
end;

procedure TArtDlg.Button3Click(Sender: TObject);
var
i:integer;
begin
  for i:=1 to frame.getnum do frame.setcolor(i,getrandomcolor);
end;

procedure TArtDlg.DirectionContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (sender is twincontrol)and((sender as twincontrol).helpcontext<>0)then
  begin
    runcontexthelp(sender as twincontrol);
    handled:=true;
  end else handled:=false;
end;

end.       
