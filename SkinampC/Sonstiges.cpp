#include "stdafx.h"
#include "skinampc.h"
#include "math.h"
#include "resource.h"
#include "shlobj.h"


// If SplashScreenThread is defined, a Thread is created to manage the Splash Screen with all
// its messages. 
// Don't work right; the owner window is not activated after destroying the thread.

//#define SplashScreenThread



FlowRec::FlowRec()
{
	SetData(0,0,0,0,NULL);
}

FlowRec::FlowRec(int vf,int vt,COLORREF vc,COLORREF tc,PFlowProc cb)
{	// vfrom, vto, voncolor, tocolor, callback
	SetData(vf,vt,vc,tc,cb);
}

void FlowRec::SetData(int vf,int vt,COLORREF vc,COLORREF tc,PFlowProc cb)
{
	f=vf;
	t=vt;
	fromc=vc;
	toc=tc;
	callbackproc=cb;
	if (f>t)		// Wenn from<to, Tausche from/bis
	{
		Change(f,t);
		COLORREF dummy=fromc;
		fromc=toc;
		toc=dummy;
	}
}

void FlowRec::DoFlow()
{
	int zhl,r,g,b,tf=(t-f);
	double aktr,aktg,aktb;
	
	if (fromc==toc)
	{
		for (zhl=f;zhl<=t;zhl++) callbackproc(zhl,fromc);
		return;
	}

	r=GetRValue(toc)-GetRValue(fromc);
	g=GetGValue(toc)-GetGValue(fromc);
	b=GetBValue(toc)-GetBValue(fromc);
	aktr=GetRValue(fromc);
	aktg=GetGValue(fromc);
	aktb=GetBValue(fromc);

	for (zhl=f;zhl<=t;zhl++)
	{
		callbackproc(zhl,RGB(int(aktr),int(aktg),int(aktb)));
		aktr+=(r/tf);
		aktg+=(g/tf);
		aktb+=(b/tf);
	}
}



void MultiFlow(int min,int max,COLORREF c1,COLORREF c2,COLORREF c3,COLORREF c4,COLORREF c5,int colors,PFlowProc p)
{
	PFlowRec fr;
	double abschnitt;
	COLORREF fc,tc;

	if (colors==1)
	{
		fr=new FlowRec(min,max,c1,c1,p);
		fr->DoFlow();
		delete fr;
		return;
	}
	abschnitt=(double)(max-min)/(colors-1);

	fr=new FlowRec();
	for (int i=1;i<=colors-1;i++)
	{
		switch (i)
		{
		case 1:
			fc=c1; tc=c2;
			break;
		case 2:
			fc=c2; tc=c3;
			break;
		case 3:
			fc=c3; tc=c4;
			break;
		case 4:
			fc=c4; tc=c5;
			break;
		default:
			fc=0; tc=0;
			break;
		}

		fr->SetData((int)ceil(min+abschnitt*(i-1)),(int)ceil(min+abschnitt*i),fc,tc,p);
		fr->DoFlow();
	}
	delete fr;
}



TSplashScreen *splashscreen=NULL;


LRESULT CALLBACK SplashWndProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{
	return splashscreen->WndProc(hwnd,uMsg,wParam,lParam);
}



TSplashScreen::TSplashScreen()
{
	refcount=0;
	created=FALSE;
	owner=0;
}

TSplashScreen::~TSplashScreen()
{
#ifdef SplashScreenThread
	PostQuitMessage(0);
#endif
}

void TSplashScreen::Create(HWND vowner)
{
	owner=vowner;
	const CHAR *classname="SkinampSplashScreen";
	int x=(GetSystemMetrics(SM_CXSCREEN)-SplashScreenWidth)/2,
		y=(GetSystemMetrics(SM_CYSCREEN)-SplashScreenHeight)/2;
	WNDCLASS wndclass;

//	Klasse registrieren
	memset(&wndclass,0,sizeof(wndclass));
	wndclass.hbrBackground=(HBRUSH)GetStockObject(NULL_BRUSH);
	wndclass.hCursor=LoadCursor(NULL,IDC_WAIT);
	wndclass.hInstance=(HINSTANCE)hInstance;
	wndclass.lpszClassName=classname;
	wndclass.lpfnWndProc=SplashWndProc;
	RegisterClass(&wndclass);

	m_hWnd=CreateWindowEx(0,classname,Title,WS_POPUP|WS_DLGFRAME,
		x,y,SplashScreenWidth,SplashScreenHeight,owner,NULL,hInstance,NULL);


	created=TRUE;

	if (m_hWnd)		// Fenster erfolgreich erzeugt
	{
		refcount++;
		ShowWindow(m_hWnd,SW_SHOW);
		UpdateWindow(m_hWnd);
		return;
	}
	else
	{	
		CHAR buf[50];
		LoadString(hInstance,1,buf,50);
		MessageBox(owner,buf,Title,MB_OK|MB_ICONEXCLAMATION);
		return;
	}
}

void TSplashScreen::OnCreate()
{
	bmp=LoadBitmap(hInstance,MAKEINTRESOURCE(100));
}

void TSplashScreen::OnDestroy()
{
	DeleteObject(bmp);
	delete splashscreen;
	splashscreen=NULL;
}

void TSplashScreen::OnPaint()
{
	PAINTSTRUCT ps;
	HDC dc=BeginPaint(m_hWnd,&ps);
	HDC memdc=CreateCompatibleDC(dc);
	HBITMAP oldbmp=(HBITMAP)SelectObject(memdc,bmp);
			
	SetStretchBltMode(dc,HALFTONE);
	StretchBlt(dc,0,0,SplashScreenWidth,SplashScreenHeight,memdc,0,0,320,240,SRCCOPY);

	SelectObject(memdc,oldbmp);
	DeleteDC(memdc);
	EndPaint(m_hWnd,&ps);
}

void TSplashScreen::OnClose()
{
	refcount--;
	if (refcount==0)DestroyWindow(m_hWnd);
}

LRESULT TSplashScreen::WndProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{
	switch (uMsg)
	{
	case WM_CREATE:
		OnCreate();
		break;
	case WM_DESTROY:
		OnDestroy();
		break;
	case WM_PAINT:
		OnPaint();
		break;
	case WM_CLOSE:
		OnClose();
		break;
	default: 
		return DefWindowProc(hwnd,uMsg,wParam,lParam);
	}
	return 0;
}

#ifdef SplashScreenThread
DWORD WINAPI SplashScreenThreadProc(void *param)
{
	HWND owner=(HWND)param;
	if (splashscreen==NULL)splashscreen=new TSplashScreen();
	splashscreen->Create(HWND(param));
	
	MSG msg;
	while (GetMessage(&msg,0,0,0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
	return 0;
}
#endif



HWND CreateSplashScreen(HWND owner)
{
#ifdef SplashScreenThread
	DWORD id;
	HANDLE h;
	h=CreateThread(NULL,0,&SplashScreenThreadProc,LPVOID(owner),0,&id);

	while ((splashscreen==NULL)||(!splashscreen->created)) ;

#else
	if (splashscreen==NULL)splashscreen=new TSplashScreen();
	splashscreen->Create(owner);

#endif

	if (splashscreen->m_hWnd==0)
	{
		delete splashscreen;
		splashscreen=NULL;
		return 0;
	}
	return splashscreen->m_hWnd;
}

void DestroySplashScreen(HWND wnd)
{
	PostMessage(wnd,WM_CLOSE,0,0);
}



HRESULT GetShellLinkTarget(PCHAR shfile,PCHAR result,int max)
{
    HRESULT hres;
    IShellLink *psl;
	char szGotPath[MAX_PATH];
	WIN32_FIND_DATA wfd;

    // Get a pointer to the IShellLink interface.
    hres = CoCreateInstance(CLSID_ShellLink, NULL, CLSCTX_INPROC_SERVER,
                            IID_IShellLink, (void **)&psl);
    if (SUCCEEDED(hres))
    {
        IPersistFile *ppf;

        // Get a pointer to the IPersistFile interface.
        hres = psl->QueryInterface(IID_IPersistFile, (void **)&ppf);
        if (SUCCEEDED(hres))
        {
             WORD wsz[MAX_PATH];   // buffer for Unicode string

             MultiByteToWideChar(CP_ACP, 0, shfile, -1, wsz,MAX_PATH);
			 
			 // Load the shortcut.
             hres = ppf->Load(wsz, STGM_READ);
             if (SUCCEEDED(hres))
             {
				strcpy(szGotPath, shfile);
               	hres = psl->GetPath(szGotPath, MAX_PATH,
               	   (WIN32_FIND_DATA *)&wfd, 0 );
				strcpy(result,szGotPath);
			 }
          ppf->Release();
      }
      psl->Release();
   }
   return hres;
}


void Warte()
{
	MSG msg;
	while (PeekMessage(&msg,0,0,0,PM_REMOVE))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
}
