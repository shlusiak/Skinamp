#include "windows.h"
#include "language.h"



#define CACHED 1

int ExtractPrefix(PCHAR s)
{
	CHAR *f=strchr(s,'='),*error;
	if (f==NULL)return -1;
	int ret=strtol(s,&error,10);
	if (error==s)return -1;else return ret;
}

BOOLEAN ExtractSuffix(PCHAR s,PCHAR result)
{
	CHAR *f=strchr(s,'=');
	if (f==NULL)return FALSE;
	strcpy(result,f+1);
	return TRUE;
}



TLanguageFile::TLanguageFile(PCHAR fn)
{
	filename=(PCHAR)malloc(strlen(fn));
	strcpy(filename,fn);
	opened=cached=FALSE;
	cache=NULL;
	cachesize=0;
	index=0;
	file=0;
}

TLanguageFile::~TLanguageFile()
{
	if (opened)Close();
	if (cached)VirtualFree(cache,0,MEM_RELEASE);
}

BOOLEAN TLanguageFile::Open()
{
	if (opened)return FALSE;
	if (cached)
	{
		index=0;
		return TRUE;
	}
	file=(HFILE)CreateFile(filename,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,0,NULL);
	if (file!=0)opened=TRUE;
	return opened;
}

void TLanguageFile::Close()
{
	if (opened)
	{
		CloseHandle((HANDLE)file);
		opened=FALSE;
	}
}

void TLanguageFile::GoFirst()
{
	if (cached)index=0;
	else
	{
		Close();
		Open();
	}
}

BOOLEAN TLanguageFile::GetNextString(PCHAR result)
{
	int i;
	if (eof())return FALSE;
	CHAR temp[MAX_CHAR];
	do
	{
		if (GetNext(&temp[0])==FALSE)return FALSE;
		i=ExtractPrefix(&temp[0]);
		if (i!=-1)i=0;
	}while ((i!=0)&&(eof()==FALSE));
	if ((eof())&&(i!=0))return FALSE;
	if (result)strcpy(result,&temp[0]);
	return TRUE;
}

BOOLEAN TLanguageFile::GetString(int nr,PCHAR result)
{
	GoFirst();
	CHAR temp[MAX_CHAR];
	int i;
	do
	{
		if (GetNext(&temp[0])==FALSE)return FALSE;
		if (strchr(&temp[0],'=')!=NULL)
		{
			i=ExtractPrefix(&temp[0]);
			if (i==nr)
			{
				if (result)strcpy(result,&temp[0]);
				return TRUE;
			}
		}

	}while(!eof());
	return FALSE;
}

BOOLEAN TLanguageFile::GetNextComment(PCHAR result)
{
	if (eof())return FALSE;
	CHAR temp[MAX_CHAR];
	do
	{
		if (!GetNext(&temp[0]))return FALSE;
		if ((temp[0]!='\0')&&(ExtractPrefix(&temp[0])==-1))
		{
			if (result)strcpy(result,&temp[0]);
			return TRUE;
		}
	}while (!eof());
	return FALSE;
}

BOOLEAN TLanguageFile::StringExists(int nr)
{
	return GetString(nr,NULL);
}

void TLanguageFile::Cache()
{
	Open();
	GoFirst();
	cache=VirtualAlloc(NULL,cachesize=GetFileSize((HANDLE)file,NULL),MEM_COMMIT,PAGE_READWRITE);
	if (cache==NULL)
	{
		return;
	}
	DWORD read;
	ReadFile((HANDLE)file,cache,cachesize,&read,NULL);
	cached=TRUE;
	Close();
}

BOOLEAN TLanguageFile::eof()
{
	if (cached)
	{
		return (index>=cachesize);
	}else{
		DWORD cfp=SetFilePointer((HANDLE)file,0,NULL,FILE_CURRENT);
		return (GetFileSize((HANDLE)file,NULL)<=cfp); 
	}
}

BOOLEAN TLanguageFile::GetNext(PCHAR result)
{
	if (cached)
	{
		CHAR temp[MAX_CHAR],c;
		int i=0;
		do
		{
			c=((PCHAR)cache)[index];
			index++;
			if (index>cachesize)return FALSE;
			if (c=='\n')
			{
				i--;
				break;
			}
			temp[i]=c;
			i++;
			if (i==MAX_CHAR-1)return FALSE;
		}while(TRUE);
		temp[i]='\0';
		strcpy(result,&temp[0]);
		return TRUE;
	}else{
		CHAR temp[MAX_CHAR],c;
		int i=0;
		DWORD read;
		do
		{
			if (ReadFile((HANDLE)file,&c,1,&read,NULL)==FALSE)break;
			if (read!=1)return FALSE;
			if (c=='\n')
			{
				i--;
				break;
			}
			temp[i]=c;
			i++;
			if (i==MAX_CHAR-1)return FALSE;
		}while(TRUE);
		temp[i]='\0';
		strcpy(result,&temp[0]);
		return TRUE;
	}
}

PLanguageFile CreateLanguageFile(PCHAR fn,BOOLEAN cacheing)
{
	PLanguageFile lf=new TLanguageFile(fn);
	if (cacheing)lf->Cache();
	return lf;
}

void DestroyLanguageFile(PLanguageFile lf)
{
	delete lf;
}

BOOLEAN GetLanguageString(PLanguageFile lf,int nr,PCHAR result)
{
	return lf->GetString(nr,result);
}

PCHAR GetLanguageFileName(PLanguageFile lf)
{
	return lf->filename;
}

DWORD LanguageFileOp(PLanguageFile lf,DWORD op,DWORD p1)
{
	switch (op)
	{
	case 0:lf->Close();
		return 1;

	case 1:return lf->eof();

	case 2:return lf->GetNext(PCHAR(p1));

	case 3:return lf->GetNextComment(PCHAR(p1));

	case 4:return lf->GetNextString(PCHAR(p1));

	case 5:lf->GoFirst();
		return 1;

	case 6:return lf->Open();

	case 7:return lf->StringExists(p1);

	case 8:lf->Cache();
		return 1;

	default:
		return 0;
	}
}








