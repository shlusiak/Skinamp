#include "stdafx.h"
#include "skinampc.h"
#include "math.h"
#include "resource.h"
#include "shlobj.h"
#include "ddraw.h"



const maxp=7;
const double gravity=0.6;
const minspeed=22;
const time=16;
const maxwackel=5;


#define Schweifkollision



struct TInfoCheat
{
	PCheatObject obj1,obj2;
	HDC screen,doublebuffer;
	HBITMAP screenbitmap,doublebufferbitmap;
	int wackelx,wackely,wackeldirx,wackeldiry;
	COLORREF halb;
	BOOLEAN closed;

	TInfoCheat(PCheatObject o1,PCheatObject o2,COLORREF vhalb);
	~TInfoCheat();
	void Run();
	void DunkleAb(PCheatObject o);
	void ExecuteObject(PCheatObject o);
	HWND CreateWnd();
	LRESULT WndProc(HWND hWnd,UINT uMsg,WPARAM wParam,LPARAM lParam);
}*Cheat;



#define Rectangle2(dc,r) { Rectangle(dc,r.left,r.top,r.right+1,r.bottom+1); }

TInfoCheat *infocheat;

LRESULT InfoCheatWndProc(HWND hWnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{
	return infocheat->WndProc(hWnd,uMsg,wParam,lParam);
}



TInfoCheat::TInfoCheat(PCheatObject o1,PCheatObject o2,COLORREF vhalb)
{
	infocheat=this;
	obj1=o1;
	obj2=o2;
	halb=vhalb;
}

TInfoCheat::~TInfoCheat()
{
	delete obj2;
	delete obj1;
}

void TInfoCheat::DunkleAb(PCheatObject o)
{
	RECT r=o->Rec();
    SetPixelV(screen,r.left,r.top,halb);
    SetPixelV(screen,r.right-1,r.top,halb);
    SetPixelV(screen,r.left,r.bottom-1,halb);
    SetPixelV(screen,r.right-1,r.bottom-1,halb);
}

void TInfoCheat::ExecuteObject(PCheatObject o)
{
	int i=o->Execute();
	if (i%10==-1)
	{
		wackelx=-1;
		wackeldirx=2;
	}
	if (i%10==1)
	{
		wackelx=1;
		wackeldirx=1;
	}
	if (i>=10)
	{	
		wackely=1;
		wackeldiry=1;
	}
}

HWND TInfoCheat::CreateWnd()
{
	const CHAR classname[]="InfoCheat";
	WNDCLASS wc;
	ZeroMemory(&wc,sizeof(wc));
	wc.hbrBackground=(HBRUSH)GetStockObject(NULL_BRUSH);
	wc.hCursor=LoadCursor(0,IDC_ARROW);
	wc.hInstance=hInstance;
	wc.lpfnWndProc=(WNDPROC)InfoCheatWndProc;
	wc.lpszClassName=classname;
	wc.style=0;
	RegisterClass(&wc);

	return CreateWindowEx(WS_EX_TOPMOST,classname,"",WS_POPUP,0,0,GetSystemMetrics(SM_CXSCREEN),GetSystemMetrics(SM_CYSCREEN),0,0,hInstance,NULL);
}

LRESULT TInfoCheat::WndProc(HWND hWnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{
	switch (uMsg)
	{
	case WM_PAINT:
		{
			PAINTSTRUCT ps;
			HDC dc=BeginPaint(hWnd,&ps);
			if ((wackely!=0)||(wackelx!=0))
			{
				SelectObject(doublebuffer,GetStockObject(BLACK_BRUSH));
				Rectangle(doublebuffer,0,0,GetSystemMetrics(SM_CXSCREEN),wackely);
				Rectangle(doublebuffer,0,0,wackelx,GetSystemMetrics(SM_CYSCREEN));
				Rectangle(doublebuffer,GetSystemMetrics(SM_CXSCREEN)+wackelx,0,GetSystemMetrics(SM_CXSCREEN),GetSystemMetrics(SM_CYSCREEN));
			}
			BitBlt(doublebuffer,wackelx,wackely,GetSystemMetrics(SM_CXSCREEN)-wackelx,GetSystemMetrics(SM_CYSCREEN)-wackely,screen,0,0,SRCCOPY);
			obj1->Draw(doublebuffer);
			obj2->Draw(doublebuffer);

			BitBlt(dc,0,0,GetSystemMetrics(SM_CXSCREEN),GetSystemMetrics(SM_CYSCREEN),doublebuffer,0,0,SRCCOPY);

			EndPaint(hWnd,&ps);
		}
		break;
	case WM_LBUTTONDOWN:
	case WM_RBUTTONDOWN:
	case WM_KEYDOWN:
		closed=TRUE;
		break;
	default: return DefWindowProc(hWnd,uMsg,wParam,lParam);
	}
	return 0;
}

#define animatewackel(wackel,wackeldir) {\
		if ((wackel!=0)||(wackeldir==2))\
		{	if (wackeldir==1)wackel++; else wackel--;\
			if (((wackel==maxwackel)&&(wackeldir==1))||((wackel==-maxwackel)&&(wackeldir==2)))wackeldir=3-wackeldir;\
			if ((wackeldir==2)&&(wackel==0))wackeldir=1;\
			InvalidateRect(wnd,NULL,FALSE);}\
		}


void TInfoCheat::Run()
{
	HDC temp=GetDC(GetDesktopWindow());
	int oldtime;
	HWND wnd;

	screen=CreateCompatibleDC(temp);
	screenbitmap=(HBITMAP)CreateCompatibleBitmap(temp,GetSystemMetrics(SM_CXSCREEN),GetSystemMetrics(SM_CYSCREEN));
	SelectObject(screen,screenbitmap);
	BitBlt(screen,0,0,GetSystemMetrics(SM_CXSCREEN),GetSystemMetrics(SM_CYSCREEN),temp,0,0,SRCCOPY);

	doublebuffer=CreateCompatibleDC(temp);
	doublebufferbitmap=CreateCompatibleBitmap(temp,GetSystemMetrics(SM_CXSCREEN),GetSystemMetrics(SM_CYSCREEN));
	SelectObject(doublebuffer,doublebufferbitmap);
	ReleaseDC(GetDesktopWindow(),temp);

	{
		wackelx=wackely=0;
		wackeldirx=wackeldiry=1;

		SelectObject(screen,GetStockObject(NULL_PEN));
		SelectObject(screen,GetStockObject(BLACK_BRUSH));
		Rectangle2(screen,obj1->Rec());
		Rectangle2(screen,obj2->Rec());

		DunkleAb(obj1);
		DunkleAb(obj2);

		closed=FALSE;
	}

	wnd=obj1->wnd=obj2->wnd=CreateWnd();


	UpdateWindow(wnd);
	ShowWindow(wnd,SW_SHOW);

	while (!closed)
	{
		oldtime=GetTickCount();


/*		if ((wackely!=0)||(wackeldiry==2))
		{	// Wackel, wenn notwendig
			if (wackeldiry==1)wackely++; else wackely--;
			if ((wackely==maxwackel)&&(wackeldiry==1))wackeldiry=2;
			if ((wackeldiry==2)&&(wackely==0))wackeldiry=1;
			InvalidateRect(wnd,NULL,FALSE);
		}
		if ((wackelx!=0)||(wackeldirx==2))
		{
			if (wackeldirx==1) wackelx++; else wackelx--;
			if (((wackelx==maxwackel)&&(wackeldirx==1))||((wackelx==-maxwackel)&&(wackeldirx==2))) wackeldirx=3-wackeldirx;
			if ((wackeldirx==2)&&(wackelx==0))wackeldirx=1;
			InvalidateRect(wnd,NULL,FALSE);
		}*/
		animatewackel(wackely,wackeldiry);
		animatewackel(wackelx,wackeldirx);

		{	// Execute all Objects
			ExecuteObject(obj1);
			ExecuteObject(obj2);
			if (wackely!=0) 
				InvalidateRect(wnd,NULL,FALSE);
		}

		do
		{	// Warten, bis Framezeit vorrüber
			Warte();
			if (GetTickCount()-oldtime<time-1) Sleep(1);
		}while (GetTickCount()-oldtime<time);
	}
	DeleteDC(screen);
	DeleteObject(screenbitmap);
	DeleteDC(doublebuffer);
	DeleteObject(doublebufferbitmap);
	DestroyWindow(wnd);
}



void RunInfoCheat(PCheatObject o1,PCheatObject o2,COLORREF halb)
{
	TInfoCheat i(o1,o2,halb);
	i.Run();
}



PCheatObject CreateCheatObject(POINT vp,POINT vsi,POINT vsp,HDC graphic)
{
	PCheatObject o=new TCheatObject(vp,vsi,vsp,graphic);
	return o;
}

void AddOtherCheatObject(PCheatObject ob,PCheatObject other)
{
	ob->AddOther(other);
}


TCheatObject::TCheatObject(POINT vp,POINT vsi,POINT vsp,HDC graphic)
{
	int i;
	wnd=0;
//	Speicher für Positionen reservieren
	Positions=(PPUNKT)malloc(sizeof(PUNKT)*maxp);
//	Startposition setzen
	Positions[0].x=vp.x;
	Positions[0].y=vp.y;
//	Lösche alle Positionen (ausser Positions[0])
	if (maxp>1) for (i=1;i<maxp;i++)
	{	
		Positions[i].x=-1;
		Positions[i].y=-1;
	}
//	Parameter setzen
	Size=vsi;
	Speed.x=vsp.x;
	Speed.y=vsp.y;
	SDC=CreateCompatibleDC(graphic);
	bmp=CreateCompatibleBitmap(graphic,Size.x,Size.y);
	SelectObject(SDC,bmp);
	BitBlt(SDC,0,0,Size.x,Size.y,graphic,0,0,SRCCOPY);
	for (i=0;i<20;i++) Others[i]=NULL;
}

TCheatObject::~TCheatObject()
{
	RestoreDC(SDC,-1);
	DeleteDC(SDC);
	DeleteObject(bmp);
	free(Positions);	
}

RECT TCheatObject::Rec()
{
//	Begrenzungsrechteck des Objekts zurückgeben
	RECT r;
	r.left=(int)Pos()->x;
	r.top=(int)Pos()->y;
	r.right=r.left+Size.x;
	r.bottom=r.top+Size.y;
	return r;
}

PUNKT* TCheatObject::Pos()
{
//	aktuelle Positions[0] zurückgeben
	return &(Positions[0]);
}

void TCheatObject::Draw(HDC dc)
{
//	Auf alle "DrawPositions" die Graphik mit BitBlt malen
	for (int i=maxp-1;i>=0;i--) if ((Positions[i].x!=-1)&&(Positions[i].y!=-1))
	{
		BitBlt(dc,(int)Positions[i].x,(int)Positions[i].y,Size.x,Size.y,SDC,0,0,SRCCOPY);
	}
}

void TCheatObject::Invalidate(int nr)
{
//	Rechteck von Positions[nr] neuzeichnen
	if ((Positions[nr].x!=-1)&&(Positions[nr].y!=-1))
	{
		RECT r;
		r.left=(int)Positions[nr].x;
		r.top=(int)Positions[nr].y;
		r.right=r.left+Size.x;
		r.bottom=r.top+Size.y;
		InvalidateRect(wnd,&r,FALSE);
	}
}

void TCheatObject::InvalidateAll()
{
//	Rechtecke der Positionen (sofern vorhanden) als ungültig erklären
	for (int i=0;i<maxp;i++) 
	{
		if ((Positions[i].x!=-1)&&(Positions[i].y!=-1))
		{
			RECT r;
			r.left=(int)Positions[i].x;
			r.top=(int)Positions[i].y;
			r.right=r.left+Size.x;
			r.bottom=r.top+Size.y;
			InvalidateRect(wnd,&r,FALSE);
		}
	}
}

void TCheatObject::ReflektHorizontal(PCheatObject other)
{
//	Neue Geschwindigkeit anhand Kräftedifferenz berechnen
	double f=other->Speed.x-Speed.x;
	Speed.x+=f;
	other->Speed.x-=f;
}

void TCheatObject::ReflektVertikal(PCheatObject other)
{
//	Gravitation hinzuaddieren !?
	Speed.y+=gravity;
//	Neue Geschwindigkeit anhand Kräftedifferenz berechnen
	double f=other->Speed.y-Speed.y;
	Speed.y+=f;
	other->Speed.y-=f;
}

int TCheatObject::Execute()
{
	Invalidate(maxp-1);		// Letztes Element der Kette neuzeichnen
	int i,wackel=0;
	PUNKT oldpos=Positions[0];

//	Positionen hochschieben (Blur-Effekt)
	for (i=maxp-1;i>=1;i--)Positions[i]=Positions[i-1];
 
//	Geschwindigkeit zu Position addieren
	Positions[0].x+=Speed.x;
	Positions[0].y+=Speed.y;

//	Wenn rechts/links ausserhalb des Bildschirms, Geschwindigkeit.x umkehren und wackeln
	if (((Pos()->x>GetSystemMetrics(SM_CXSCREEN)-Size.x)&&(Speed.x>=0))||
		((Pos()->x<Speed.x)&&(Speed.x<=0)))
	{
		if (Speed.x<0) wackel-=1; else wackel+=1;
		Speed.x=-Speed.x;
	}
//	Wenn unten/oben ausserhalb des Bildschirms, Geschwindigkeit.y umkehren und wackeln
	if (((Pos()->y>GetSystemMetrics(SM_CYSCREEN)-Size.y)&&(Speed.y>0))||
		((Pos()->y<0)&&(Speed.y<0)))
	{
		Speed.y=-Speed.y;
//		if (rand()%10==1)Speed.y+=(rand()%3)-1;
		if (Speed.y>-minspeed) Speed.y=-minspeed;
		wackel+=10;
	}
//	Wenn unterhalb des Bildschirms, wieder in gültigen Bereich des Bildschirms setzen
	if (Pos()->y>GetSystemMetrics(SM_CYSCREEN)-Size.y)
	{
//		Pos()->y=2*GetSystemMetrics(SM_CYSCREEN)-2*Size.y-Pos()->y;
		Pos()->y=GetSystemMetrics(SM_CYSCREEN)-Size.y;
	}

//	mit anderen Objekten Kollidieren
	for (i=0;i<20;i++)if (Others[i]!=NULL)
	{
//		Horizontal testen		
		if (((Speed.x>0)&&(Pos()->x+Size.x>=Others[i]->Pos()->x)&&(oldpos.x+Size.x<Others[i]->Pos()->x)&&
			(Pos()->y+Size.y>Others[i]->Pos()->y)&&(Pos()->y<Others[i]->Pos()->y+Others[i]->Size.y))||
		   ((Speed.x<0)&&(Pos()->x<=Others[i]->Pos()->x+Others[i]->Size.x)&&(oldpos.x>Others[i]->Pos()->x+Others[i]->Size.x)&&
			(Pos()->y+Size.y>Others[i]->Pos()->y)&&(Pos()->y<Others[i]->Pos()->y+Others[i]->Size.y)))
		{	
			ReflektHorizontal(Others[i]);
		}

//		Vertikal testen
		if (((Speed.y>0)&&(Pos()->y+Size.y>=Others[i]->Pos()->y)&&(oldpos.y+Size.y<Others[i]->Pos()->y)&&
			(Pos()->x+Size.x>Others[i]->Pos()->x)&&(Pos()->x<Others[i]->Pos()->x+Others[i]->Size.x))||
			((Speed.y<0)&&(Pos()->y<=Others[i]->Pos()->y+Others[i]->Size.y)&&(oldpos.y>Others[i]->Pos()->y+Others[i]->Size.y)&&
			(Pos()->x+Size.x>Others[i]->Pos()->x)&&(Pos()->x<Others[i]->Pos()->x+Others[i]->Size.x)))
		{	// von oben
			ReflektVertikal(Others[i]);
		}
	}
#ifdef Schweifkollision
	// Mit Schweif von anderen Objekten kollidieren
	for (i=0;i<20;i++)if (Others[i]!=NULL)
	{
		for (int j=0;j<maxp;j++)if (Others[i]->Positions[j].x>=0)
		{
			PPUNKT p=&Others[i]->Positions[j];
			if (((Speed.x>0)&&(Pos()->x+Size.x>=p->x)&&(oldpos.x+Size.x<p->x)&&
				(Pos()->y+Size.y>p->y)&&(Pos()->y<p->y+Others[i]->Size.y))||
				((Speed.x<0)&&(Pos()->x<=p->x+Others[i]->Size.x)&&(oldpos.x>p->x+Others[i]->Size.x)&&
				(Pos()->y+Size.y>p->y)&&(Pos()->y<p->y+Others[i]->Size.y)))
			{	
				Speed.x=-Speed.x;
				break;
			}

//		Vertikal testen
			if (((Speed.y>0)&&(Pos()->y+Size.y>=p->y)&&(oldpos.y+Size.y<p->y)&&
				(Pos()->x+Size.x>p->x)&&(Pos()->x<p->x+Others[i]->Size.x))||
				((Speed.y<0)&&(Pos()->y<=p->y+Others[i]->Size.y)&&(oldpos.y>p->y+Others[i]->Size.y)&&
				(Pos()->x+Size.x>p->x)&&(Pos()->x<p->x+Others[i]->Size.x)))
			{	// von oben
				Speed.y=-Speed.y;
				break;
			}
		}
	}
#endif
//	Vertikale Geschwindigkeit erhöhen
	Speed.y=double(Speed.y)+double(gravity);
	Invalidate(0);	// Erstes Element der Kette neuzeichnen
	
	return wackel;
}

void TCheatObject::AddOther(TCheatObject *o)
{
	for (int i=0;i<20;i++)if (Others[i]==NULL)
	{
		Others[i]=o;
		return;
	}
	return;
}
