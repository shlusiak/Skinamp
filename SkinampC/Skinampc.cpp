#include "stdafx.h"
#include "stdlib.h"
#include "Skinampc.h"


HINSTANCE hInstance;

BOOL APIENTRY DllMain(HANDLE hModule,DWORD ul_reason_for_call,LPVOID lpReserved)
{
    switch (ul_reason_for_call)
	{
		case DLL_PROCESS_ATTACH:
			srand(1234);
			hInstance=(HINSTANCE)hModule;
			break;
		case DLL_THREAD_ATTACH:
			break;
		case DLL_THREAD_DETACH:
			break;
		case DLL_PROCESS_DETACH:
			break;
    }
    return TRUE;
}



// Hier werden alle Konstanten definiert:

const helligkeitsstufe=96;			// Farb-Summand für Heller / Dunkler
const CHAR *wclass="Winamp v1.x";	// Klassennamen für Winamp-Fenster
const CHAR *weqclass="Winamp EQ";	// Klassennamen für Winamp-Fenster
const CHAR *wplclass="Winamp PE";	// Klassennamen für Winamp-Fenster
const CHAR *wvis="WinampVis";		// Klassennamen für Winamp-Fenster
const fontx=110;					// Ursprung-X der Schrift im Quellbitmap (Bitmaps.bmp)
const fonty=200;					// Ursprung-Y der Schrift im Quellbitmap (Bitmaps.bmp)
const colordivisions=5;				// Anzahl der Unterteilungen einer Farbe 
//	(in GetRandomColor). Mit Schwarz und Weiss maximale Anzahl: colordivisions^3
const rosa=RGB(255,0,255);			// Farbkonstante (hier rosa=Transparenz)
const black=RGB(0,0,0);				// Farbkonstante
const white=RGB(255,255,255);		// Farbkonstante
const WM_CLOSESPLASH=WM_USER+2;
const CHAR* Title="SkinAmp";
const SplashScreenWidth=480;
const SplashScreenHeight=360;




//	Gibt Handle der Instanz zurück, damit Bitmaps und Icons 
//	von anderen Modulen geladen werden können
HINSTANCE GetInstance()
{
	return hInstance;
}


//	Heller Funktion als Makro um Zeit zu sparen
#define Heller(dc,x,y)\
{\
	const COLORREF c=GetPixel(dc,x,y);\
	const BYTE r=GetRValue(c),g=GetGValue(c),b=GetBValue(c);\
	SetPixelV(dc,x,y,RGB(\
		r+helligkeitsstufe<255 ? r+helligkeitsstufe : 255,\
		g+helligkeitsstufe<255 ? g+helligkeitsstufe : 255,\
		b+helligkeitsstufe<255 ? b+helligkeitsstufe : 255));\
}

//	Dunkler auch als Makro definiert (wird so im Quelltext eingefügt)
#define Dunkler(dc,x,y)\
{\
	const COLORREF c=GetPixel(dc,x,y);\
	const BYTE r=GetRValue(c),g=GetGValue(c),b=GetBValue(c);\
	SetPixelV(dc,x,y,RGB(\
		r-helligkeitsstufe>0 ? r-helligkeitsstufe : 0,\
		g-helligkeitsstufe>0 ? g-helligkeitsstufe : 0,\
		b-helligkeitsstufe>0 ? b-helligkeitsstufe : 0));\
}



void LineH(const HDC dc,const int x1,const int y1,const int x2,const int y2,const BOOLEAN h)
{
	if (h) for (int i=x1;i<=x2;i++) Heller(dc,i,y1)
		else for (int i=x1;i<=x2;i++) Dunkler(dc,i,y1);
}

void LineV(const HDC dc,const int x1,const int y1,const int x2,const int y2,const BOOLEAN h)
{
	if (h) for (int i=y1;i<=y2;i++) Heller(dc,x1,i)
		else for (int i=y1;i<=y2;i++) Dunkler(dc,x1,i);
}

COLORREF GetRandomColor()
{
	int r=(rand()%(colordivisions))*(256/(colordivisions-1));
	if (r>=256) r=255;

	int g=(rand()%(colordivisions))*(256/(colordivisions-1));
	if (g>=256) g=255;

	int b=(rand()%(colordivisions))*(256/(colordivisions-1));
	if (b>=256) b=255;

	return RGB(r,g,b);
}

void PaintBmp(const HDC sdc,const HDC dc,const int x,const int y,const int w,const int h,const int sx,const int sy)
{
	COLORREF rosa=RGB(255,0,255),p;
	int i,j;
	for (i=sx;i<sx+w;i++) for (j=sy;j<sy+h;j++)
	{
		p=GetPixel(sdc,i,j);
		if (p!=rosa) SetPixelV(dc,x+i-sx,y+j-sy,p);
	}
}

void PaintBmpColor(const HDC sdc,const HDC dc,const int x,const int y,const int w,const int h,const int sx,const int sy,const COLORREF color)
{
	COLORREF p;
	int i,j;
	for (i=sx;i<sx+w;i++) for (j=sy;j<sy+h;j++)
	{
		p=GetPixel(sdc,i,j);
		if (p!=rosa) SetPixelV(dc,x+i-sx,y+j-sy,color);
	}
}

void PaintMask(const HDC sdc,const HDC dc,const int x,const int y,const int w,const int h,const int sx,const int sy)
{
	COLORREF p;
	int i,j;
	for (i=sx;i<sx+w;i++) for (j=sy;j<sy+h;j++)
	{
		p=GetPixel(sdc,i,j);
		if (p==black) Dunkler(dc,x+i-sx,y+j-sy)
		else if (p==white) Heller(dc,x+i-sx,y+j-sy);
	}
}

void SmallTextOut(const HDC sdc,const HDC dc,const int x,const int y,const PCHAR s,const COLORREF color)
{
	int i,j,k,tx,ty;
	const strl=strlen(s);

	for (i=0;i<strl;i++)
	{
		tx=0;
		ty=0;
		CHAR c=toupper(s[i]);

		if ((c>='A')&&(c<='Z'))
		{
			tx=fontx+(BYTE(c)-BYTE('A'))*4;
			ty=fonty;
		}
		if ((c>='0')&&(c<='9'))
		{
			tx=fontx+(BYTE(c)-BYTE('0'))*4;
			ty=fonty+6;
		}
		switch (c)
		{	
		case '-':
			tx=fontx+40;
			ty=fonty+6;
			break;
		case '!':
			tx=fontx+44;
			ty=fonty+6;
			break;
		case '+':
			tx=fontx+48;
			ty=fonty+6;
			break;
		case '/':
			tx=fontx+52;
			ty=fonty+6;
			break;
		case ':':
			tx=fontx+56;
			ty=fonty+6;
			break;
		}
		if ((tx!=0)||(ty!=0))
		{
			for (j=0;j<=2;j++)for (k=0;k<=4;k++)
				if (GetPixel(sdc,tx+j,ty+k)==0)
					SetPixelV(dc,x+((i)*4)+j,y+k,color);
		}
	}
}

void Rahmen(const HDC dc,const int x1,const int y1,const int w,const int h,const BOOLEAN dd,const COLORREF color)
{
	const HBRUSH brush=CreateSolidBrush(color);
	const HPEN pen=CreatePen(PS_SOLID,1,color);
	const HGDIOBJ oldbrush=SelectObject(dc,brush),oldpen=SelectObject(dc,pen);

	if (dd)
	{
		LineH(dc,x1,y1,x1+w-1,y1,FALSE);
		LineH(dc,x1,y1+h-1,x1+w-1,y1+h-1,TRUE);
		LineV(dc,x1,y1,x1,y1+h-1,FALSE);
		LineV(dc,x1+w-1,y1,x1+w-1,y1+h-1,TRUE);
		Rectangle(dc,x1+1,y1+1,x1+w-1,y1+h-1);
	} else Rectangle(dc,x1,y1,x1+w,y1+h);

	SelectObject(dc,oldpen);
	SelectObject(dc,oldbrush);
	DeleteObject(brush);
	DeleteObject(pen);
}


BOOL IsWinamp(POINT p)
{
	CHAR c[100];
	HWND wnd=WindowFromPoint(p);
	GetClassName(wnd,c,100);

	if (strcmp(c,wvis)==0)
	{
		wnd=GetParent(wnd);
		GetClassName(wnd,c,100);
	}
	if (strcmp(c,wclass)==0)return TRUE;
	if (strcmp(c,weqclass)==0)return TRUE;
	if (strcmp(c,wplclass)==0)return TRUE;

	return FALSE;
}

void Move(HWND wnd,int x,int y)
{
	RECT r;
	GetWindowRect(wnd,&r);
	SetWindowPos(wnd,0,r.left+x,r.top+y,r.right-r.left,r.bottom-r.top,SWP_NOSIZE|SWP_SHOWWINDOW);
}

void Delay(UINT ms)
{
	UINT start=GetTickCount();
	MSG msg;

	while (GetTickCount()-start<ms)
	{
		if (PeekMessage(&msg,0,0,0,PM_REMOVE))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}
}

void InfoMoveIt(POINT p)
{
	if (!IsWinamp(p))return;
	HWND wnd;
	int i;
	CHAR c[100];

	wnd=WindowFromPoint(p);
	GetClassName(wnd,c,100-1);
	if (strcmp(c,wvis)==0) wnd=GetParent(wnd);
	SetForegroundWindow(wnd);
	for (i=1;i<=5;i++)
	{
		Move(wnd,-2,0);
		Delay(10);
	}
	for (i=1;i<=10;i++)
	{
		Move(wnd,2,0);
		Delay(9);
	}
	for (i=1;i<=5;i++)
	{
		Move(wnd,-2,0);
		Delay(10);
	}
}

void CopyFonts(HDC bdc,HDC tdc,COLORREF color)
{
	for (int i=0;i<155;i++)for (int j=0;j<18;j++)
	{
		if (GetPixel(bdc,245+i,25+j)!=rosa)
			SetPixel(tdc,i,j,color);
	}
}


BOOLEAN SetWinampSkin(PCHAR path)
{
	const bufsize=1024;
	LPVOID p;
	HANDLE handle;
	DWORD process,written;
	HWND wnd=FindWindow(wclass,NULL);
	if (wnd==0)return FALSE;

/*	Lässt Winamp den Skin laden, der in path angegeben wurde. 
	Dazu wird Speicher im Fremd-Process reserviert und path
	hineinkopiert. Mit SendMessage lädt Winamp den Skin neu */

//	Klappt leider nur unter Windows 2000... =(

//	Diesen Code nur ausführen, wenn ein Windows NT gefunden wurde!

	typedef BOOL (WINAPI *WRITEPROCESSMEMORY)(HANDLE,LPVOID,LPVOID,DWORD,LPDWORD);
	typedef LPVOID (WINAPI *VIRTUALALLOCEX)(HANDLE,LPVOID,SIZE_T,DWORD,DWORD);
	typedef BOOL (WINAPI *VIRTUALFREEEX)(HANDLE,LPVOID,SIZE_T,DWORD);


	// Dll laden
	HINSTANCE hDll=LoadLibrary("KERNEL32.DLL");
	if (hDll<(HINSTANCE)HINSTANCE_ERROR)return FALSE;

	// Funktionen suchen 
	WRITEPROCESSMEMORY MyWriteProcessMemory;
	VIRTUALALLOCEX MyVirtualAllocEx;
	VIRTUALFREEEX MyVirtualFreeEx;

	MyWriteProcessMemory=(WRITEPROCESSMEMORY)GetProcAddress(hDll,"WriteProcessMemory");
	MyVirtualAllocEx=(VIRTUALALLOCEX)GetProcAddress(hDll,"VirtualAllocEx");
	MyVirtualFreeEx=(VIRTUALFREEEX)GetProcAddress(hDll,"VirtualFreeEx");

	// Nur, wenn alle Funktionen gefunden, dann weitermachen
	if ((MyWriteProcessMemory==NULL)||(MyVirtualAllocEx==NULL)||(MyVirtualFreeEx==NULL))
	{
		FreeLibrary(hDll);
		return FALSE;
	}

	{

		GetWindowThreadProcessId(wnd,&process);
		handle=OpenProcess(PROCESS_ALL_ACCESS,TRUE,process);

		p=MyVirtualAllocEx(handle,NULL,bufsize,MEM_COMMIT,PAGE_READWRITE);
		if (p==NULL)
		{
			CloseHandle(handle);
			FreeLibrary(hDll);
			return FALSE;
		}

		// Wenn Speicherblock kopiert, Winamp zeigen, wo's lang geht.
		if (MyWriteProcessMemory(handle,p,path,strlen(path)+2,&written)==TRUE)
			SendMessage(wnd,WM_USER,(unsigned int)(p),200);

		MyVirtualFreeEx(handle,p,bufsize,MEM_RELEASE);
		CloseHandle(handle);
	}
	FreeLibrary(hDll);
	return TRUE;
}

