// Include Datei für die DLL-Datei SkinampC.Dll.
// Beinhaltet alle Exportierten Funktionen und die dafür benötigten Typen

// Externe Variablen oder Konstanten, die in SkinampC definiert sind.
extern HINSTANCE hInstance; 
extern const maxp;
extern const helligkeitsstufe;		
extern const CHAR *wclass;
extern const CHAR *weqclass;	
extern const CHAR *wplclass;	
extern const CHAR *wvis;		
extern const fontx;
extern const fonty;
extern const colordivisions;	
extern const rosa;
extern const black;		
extern const white;
extern const WM_CLOSESPLASH;
extern const CHAR* Title;
extern const double gravity;
extern const minspeed;
extern const SplashScreenWidth;
extern const SplashScreenHeight;



// Typen definieren
typedef void FlowProc(int p,COLORREF c);
typedef FlowProc *PFlowProc;
typedef void CurCBProc(int x,int y,int Farbe,int p1,int p2);
typedef BYTE CurArray[32][32];

// Strukturen und Zeiger auf Strukturen definieren
struct FlowRec
{
	int f,t;
	COLORREF fromc,toc;
	PFlowProc callbackproc;

	FlowRec(int vf,int vt,COLORREF fc,COLORREF tc,PFlowProc cb);
	FlowRec();
	void SetData(int vf,int vt,COLORREF fc,COLORREF tc,PFlowProc cb);
	void DoFlow();
};
typedef FlowRec *PFlowRec;
struct PUNKT
{
	double x,y;
};
typedef PUNKT* PPUNKT;
struct TCheatObject
{
    POINT Size;
    PUNKT Speed;
	PPUNKT Positions;
	HDC SDC;
	HBITMAP bmp;
	TCheatObject *Others[20];
	HWND wnd;

	TCheatObject(POINT vp,POINT vsi,POINT vsp,HDC graphic);
	~TCheatObject();
	void Draw(HDC dc);
	int Execute();
	void AddOther(TCheatObject *o);
	void Invalidate(int nr);
	void InvalidateAll();
	RECT Rec();
	PPUNKT Pos();
	void ReflektHorizontal(TCheatObject *other);
	void ReflektVertikal(TCheatObject *other);
};
typedef TCheatObject *PCheatObject;
struct TSplashScreen
{
	int refcount;
	HBITMAP bmp;
	HWND m_hWnd,owner;
	BOOLEAN created;

	TSplashScreen();
	~TSplashScreen();

	void Create(HWND owner);
	LRESULT WndProc(HWND hwnd,UINT uMsg,WPARAM wParam,LPARAM lParam);

	void OnCreate();
	void OnDestroy();
	void OnPaint();
	void OnClose();
};



//	Funktionen und Prozeduren deklarieren, die exportiert werden
HINSTANCE GetInstance();
void Heller(const HDC dc,const int x,const int y);
void Dunkler(const HDC dc,const int x,const int y);
void LineH(const HDC dc,const int x1,const int y1,const int x2,const int y2,const BOOLEAN h);
void LineV(const HDC dc,const int x1,const int y1,const int x2,const int y2,const BOOLEAN h);
COLORREF GetRandomColor();
void PaintBmp(const HDC sdc,const HDC dc,const int x,const int y,const int w,const int h,const int sx,const int sy);
void PaintBmpColor(const HDC sdc,const HDC dc,const int x,const int y,const int w,const int h,const int sx,const int sy,const COLORREF color);
void PaintMask(const HDC sdc,const HDC dc,const int x,const int y,const int w,const int h,const int sx,const int sy);
void SmallTextOut(const HDC sdc,const HDC dc,const int x,const int y,const PCHAR s,const COLORREF color);
void Rahmen(const HDC dc,const int x1,const int y1,const int w,const int h,const BOOLEAN dd,const COLORREF color);
BOOL IsWinamp(POINT p);
void Move(HWND wnd,int x,int y);
void Delay(UINT ms);
void InfoMoveIt(POINT p);
void CurLine(CurCBProc &SetPixelProc,int x1,int y1,int x2,int y2,int farbe,int p1,int p2);
int CurFloodFill(CurArray *a,CurCBProc &SetPixelProc,int x,int y,int farbe);
BOOLEAN CurIsPaletteColor(COLORREF c,COLORREF p);
void CopyFonts(HDC bdc,HDC tdc,COLORREF color);
void MultiFlow(int min,int max,COLORREF c1,COLORREF c2,COLORREF c3,COLORREF c4,COLORREF c5,int colors,PFlowProc p);
PCheatObject CreateCheatObject(POINT vp,POINT vsi,POINT vsp,HDC graphic);
HWND CreateSplashScreen(HWND);
void DestroySplashScreen(HWND);





// Sonstige, nicht exportierte, Funktionen
void Change(int &v1,int &v2);
void Warte();
