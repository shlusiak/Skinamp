#include "stdafx.h"
#include "stdio.h"
#include "zip.h"


const compresslevel=Z_DEFAULT_COMPRESSION;


#define ERR_CREATE_ZIP 1
#define ERR_FIND_FILE 2


uLong filetime(CHAR *f, tm_zip *tmzip, uLong *dt)
{
	int ret = 0;
	{
		FILETIME ftLocal;
		HANDLE hFind;
		WIN32_FIND_DATA  ff32;

		hFind = FindFirstFile(f,&ff32);
		if (hFind != INVALID_HANDLE_VALUE)
		{
	        FileTimeToLocalFileTime(&(ff32.ftLastWriteTime),&ftLocal);
			FileTimeToDosDateTime(&ftLocal,((LPWORD)dt)+1,((LPWORD)dt)+0);
			FindClose(hFind);
			ret = 1;
		}
	}
	return ret;
}

int ZipFile(zipFile zf,CHAR *filename,CHAR *filenameinzip)
{
	int size_buf=16384;
	void* buf=(void*)malloc(size_buf);

	int err;
	FILE * fin;
    int size_read;
	zip_fileinfo zi;
	
    zi.tmz_date.tm_sec = zi.tmz_date.tm_min = zi.tmz_date.tm_hour = 
    zi.tmz_date.tm_mday = zi.tmz_date.tm_min = zi.tmz_date.tm_year = 0;
    zi.dosDate = 0;
    zi.internal_fa = 0;
    zi.external_fa = 0;
    filetime(filename,&zi.tmz_date,&zi.dosDate);


    err = zipOpenNewFileInZip(zf,filenameinzip,&zi,
		NULL,0,NULL,0,NULL,
		(compresslevel != 0) ? Z_DEFLATED : 0,
		compresslevel);

    if (err != ZIP_OK);
    else
    {
        fin = fopen(filename,"rb");
        if (fin==NULL)
        {
            err=ZIP_ERRNO;
        }
    }

    if (err == ZIP_OK)
        do
        {
            err = ZIP_OK;
            size_read = fread(buf,1,size_buf,fin);
            if (size_read < size_buf)
                if (feof(fin)==0)
            {
                err = ZIP_ERRNO;
            }

            if (size_read>0)
            {
                err = zipWriteInFileInZip (zf,buf,size_read);
                if (err<0)
                {
                }
            }
        } while ((err == ZIP_OK) && (size_read>0));

    fclose(fin);
    if (err<0)
        err=ZIP_ERRNO;
    else
    {                    
        err = zipCloseFileInZip(zf);
    }
	
	free(buf);
	if (err>=0)return 0; else return err;
}



BOOLEAN ZipFiles(PCHAR files,PCHAR dest)
{
    zipFile zf;
	CHAR filename[MAX_PATH];

    zf = zipOpen(dest,0);
    if (zf == NULL) return FALSE;

	WIN32_FIND_DATA FindFileData;
	HANDLE hFind;

	strcpy(&filename[0],files);
	strcat(&filename[0],"*.*");
	hFind = FindFirstFile(&filename[0], &FindFileData);
	if (hFind == INVALID_HANDLE_VALUE) 
	{
		zipClose(zf,NULL);
		return FALSE;
	}

	do
	{
		if ((strcmp(FindFileData.cFileName,".")!=0)&&(strcmp(FindFileData.cFileName,"..")!=0))
		{
			strcpy(&filename[0],files);
			strcat(&filename[0],FindFileData.cFileName);

			int e=ZipFile(zf,&filename[0],FindFileData.cFileName);
			if (e!=0)
			{
				FindClose(hFind);
				zipClose(zf,NULL);
				return FALSE;
			}
		}
	}while (FindNextFile(hFind,&FindFileData));
	FindClose(hFind);

	zipClose(zf,NULL);

	return TRUE;
}

