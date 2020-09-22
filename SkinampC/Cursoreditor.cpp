#include "stdafx.h"
#include "skinampc.h"




void Change(int &v1,int &v2)
{
	int dummy=v1;
	v1=v2;
	v2=dummy;
}

void CurLine(CurCBProc &SetPixelProc,int x1,int y1,int x2,int y2,int farbe,int p1,int p2)
{
	if ((x1==x2)&&(y1==y2))
	{
		SetPixelProc(x1,y1,farbe,p1,p2);
		return;
	}

	if (x1>x2)
	{
		Change(x1,x2);
		Change(y1,y2);
	}

	int dx=x2-x1,dy=y2-y1;
	int hilf1=dx,hilf2=dy;

	if ((dx<-dy)&&(dy<0))		// Steigung < -1 ?
	{
		y1=-y1;
		y2=-y2;
		Change(x1,y1);
		Change(x2,y2);
	}
	if ((dx>=-dy)&&(dy<0))		// Steigung zwischen -1 und 0
	{
		y1=-y1;
		y2=-y2;
	}
	if ((dx<=dy)&&(dy>0))
	{
		Change(x1,y1);
		Change(x2,y2);
	}

	dx=x2-x1;
	dy=y2-y1;

	int dAB=2*dy-dx;
	int IncA=2*(dy-dx),IncB=2*dy;
	int x=x1,y=y1;

	if ((hilf1<-hilf2)&&(hilf2<0))		// Steigung kleiner als -1 ?
		SetPixelProc(y,-x,farbe,p1,p2);
	if ((hilf1>=-hilf2)&&(hilf2<0))		// Steigund zw. -1 und 0 ?
		SetPixelProc(x,-y,farbe,p1,p2);
	if ((hilf1>hilf2)&&(hilf2>=0))		// Steigung zw. 0 und 1 ?
		SetPixelProc(x,y,farbe,p1,p2);
	if ((hilf1<=hilf2)&&(hilf2>0))		// Steigung größer/gleich 1 ?
		SetPixelProc(y,x,farbe,p1,p2);

	for (x=x1+1;x<=x2;x++)
	{
		if (dAB<0) dAB+=IncB;
		else 
		{
			dAB+=IncA;
			y++;
		}
		if ((hilf1<-hilf2)&&(hilf2<0))		// Steigung kleiner als -1 ?
			SetPixelProc(y,-x,farbe,p1,p2);
		if ((hilf1>=-hilf2)&&(hilf2<0))		// Steigund zw. -1 und 0 ?
			SetPixelProc(x,-y,farbe,p1,p2);
		if ((hilf1>hilf2)&&(hilf2>=0))		// Steigung zw. 0 und 1 ?
			SetPixelProc(x,y,farbe,p1,p2);
		if ((hilf1<=hilf2)&&(hilf2>0))		// Steigung größer/gleich 1 ?
			SetPixelProc(y,x,farbe,p1,p2);
	}
}


int CurFloodFill(CurArray *a,CurCBProc &SetPixelProc,int x,int y,int farbe)
{
	BOOLEAN IsChanged[32][32],Changed;
	int i,j;
	BYTE thecolor=(*a)[x][y];

	for (i=0;i<=31;i++)for (j=0;j<=31;j++) IsChanged[i][j]=FALSE;
	SetPixelProc(x,y,farbe,0,0);
	IsChanged[x][y]=Changed=TRUE;

	while (Changed) 
	{
		Changed=FALSE;
		for (i=0;i<=31;i++)for (j=0;j<=31;j++)if (((*a)[i][j]==thecolor)&&(!IsChanged[i][j]))
		{
			if (((i<=30)&&(IsChanged[i+1][j]))||
				((i>=1)&&(IsChanged[i-1][j]))||
				((j<=30)&&(IsChanged[i][j+1]))||
				((j>=1)&&(IsChanged[i][j-1])))
			{
				SetPixelProc(i,j,farbe,0,0);
				IsChanged[i][j]=Changed=TRUE;
			}
		}
	}
	return 0;
}

BOOLEAN CurIsPaletteColor(COLORREF c,COLORREF p)
{
	const uhoch=8,urunter=8;
	int i=GetRValue(p),j=GetGValue(p),k=GetBValue(p);
	int rc=GetRValue(c),gc=GetGValue(c),bc=GetBValue(c);

	if ((rc>=i-urunter)&&(rc<=i+uhoch)&&
		(gc>=j-urunter)&&(gc<=j+uhoch)&&
		(bc>=k-urunter)&&(bc<=k+uhoch))return TRUE;
	
	return FALSE;
}














