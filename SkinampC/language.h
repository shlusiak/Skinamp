const MAX_CHAR=512;

int ExtractPrefix(PCHAR s);
BOOLEAN ExtractSuffix(PCHAR s,PCHAR result);

typedef struct TLanguageFile
{
	PCHAR filename;
	BOOLEAN cached,opened;
	int index;
	HFILE file;
	LPVOID cache;
	int cachesize;

	TLanguageFile(PCHAR fn);
	~TLanguageFile();
	BOOLEAN Open();
	void Close();
	void GoFirst();
	void Cache();
	BOOLEAN GetNextString(PCHAR result);
	BOOLEAN GetNextComment(PCHAR result);
	BOOLEAN GetString(int nr,PCHAR result);
	BOOLEAN StringExists(int nr);
	BOOLEAN eof();
	BOOLEAN GetNext(PCHAR result);
}*PLanguageFile;

