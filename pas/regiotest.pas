unit regiotest;
{$I cs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,sascha;

function createpreview(parent:hwnd):hwnd;

const
wm_regiotestclose=wm_user+4;


implementation

uses regions,konstanten;


const
regiotestclassname='RegioTestClass';

var
moving:boolean;
movcor:tpoint;

function regiotestwndproc(wnd:hwnd;msg:dword;wparam:wparam;lparam:lparam):lresult; cdecl;
var
dc:hdc;
ps:tpaintstruct;
p:tpoint;
r:trect;
begin
  result:=0;
  case msg of
    wm_create:begin
      moving:=false;
    end;
    wm_destroy:begin
      postmessage(getparent(wnd),wm_regiotestclose,0,0);
    end;
    wm_paint:begin
      dc:=beginpaint(wnd,ps);
      if moving=false then
        bitblt(dc,0,0,275,116,regionsdlg.bmp.canvas.handle,0,0,srccopy)
        else bitblt(dc,0,0,275,116,regionsdlg.bmp.canvas.handle,0,0,notsrccopy);
      endpaint(wnd,ps);
    end;
    wm_lbuttondown,wm_rbuttondown:begin
      setcapture(wnd);
      moving:=true;
      movcor.x:=smallint(LOWORD(lParam));
      movcor.y:=smallint(HIWORD(lParam));
      clienttoscreen(wnd,movcor);
      invalidaterect(wnd,nil,false);
    end;
    wm_mousemove:begin
      if moving then
      begin
        p.x:=smallint(loword(lparam));
        p.y:=smallint(hiword(lparam));
        clienttoscreen(wnd,p);
        getwindowrect(wnd,r);
        setwindowpos(wnd,0,r.left+p.x-movcor.x,r.top+p.y-movcor.y,0,0,swp_nosize);
        movcor:=p;
      end;
    end;
    wm_lbuttonup,wm_rbuttonup:begin
      moving:=false;
      Invalidaterect(wnd,nil,false);
      releasecapture;
    end;
    else result:=defwindowproc(wnd,msg,wparam,lparam);
  end;
end;

function createpreview;
var
wnd:hwnd;
r:trect;
begin
  getwindowrect(parent,r);
  wnd:=createwindowex(ws_ex_topmost,regiotestclassname,'',
    ws_popup,r.right+10,r.top+30,mainwidth,mainheight,parent,0,hinstance,nil);
  updatewindow(wnd);
  result:=wnd;
end;


var
wc:wndclass;
initialization        { Preview Klasse registrieren }
  ZeroMemory(@wc,sizeof(wndclass));
  wc.hbrBackground:=GetStockObject(NULL_BRUSH);
  wc.hCursor:=LoadCursor(0,IDC_sizeall);
  wc.hInstance:=hInstance;
  wc.lpszClassName:=regiotestclassname;
  wc.lpfnWndProc:=@regiotestwndproc;
  windows.RegisterClass(wc);
end.
