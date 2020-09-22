# Microsoft Developer Studio Project File - Name="Skinampc" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** NICHT BEARBEITEN **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=Skinampc - Win32 Debug
!MESSAGE Dies ist kein gültiges Makefile. Zum Erstellen dieses Projekts mit NMAKE
!MESSAGE verwenden Sie den Befehl "Makefile exportieren" und führen Sie den Befehl
!MESSAGE 
!MESSAGE NMAKE /f "Skinampc.mak".
!MESSAGE 
!MESSAGE Sie können beim Ausführen von NMAKE eine Konfiguration angeben
!MESSAGE durch Definieren des Makros CFG in der Befehlszeile. Zum Beispiel:
!MESSAGE 
!MESSAGE NMAKE /f "Skinampc.mak" CFG="Skinampc - Win32 Debug"
!MESSAGE 
!MESSAGE Für die Konfiguration stehen zur Auswahl:
!MESSAGE 
!MESSAGE "Skinampc - Win32 Release" (basierend auf  "Win32 (x86) Dynamic-Link Library")
!MESSAGE "Skinampc - Win32 Debug" (basierend auf  "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Skinampc - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 1
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "SKINAMPC_EXPORTS" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "SKINAMPC_EXPORTS" /FD /c
# SUBTRACT CPP /Fr /YX /Yc /Yu
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x407 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib zlibstat.lib /nologo /dll /machine:I386 /nodefaultlib:"libc.lib" /nodefaultlib:"msvcrt.lib" /nodefaultlib:"libcd.lib" /nodefaultlib:"libcmtd.lib" /nodefaultlib:"msvcrtd.lib" /out:"../Skinampc.dll"
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "Skinampc - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 1
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "SKINAMPC_EXPORTS" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "SKINAMPC_EXPORTS" /FR /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x407 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib zlibstat.lib /nologo /dll /debug /machine:I386 /nodefaultlib:"libc.lib" /nodefaultlib:"libcmt.lib" /nodefaultlib:"libcd.lib" /nodefaultlib:"msvcrt.lib" /nodefaultlib:"msvcrtd.lib" /out:"../Skinampc.dll" /implib:"Skinampc.lib"
# SUBTRACT LINK32 /pdb:none

!ENDIF 

# Begin Target

# Name "Skinampc - Win32 Release"
# Name "Skinampc - Win32 Debug"
# Begin Group "Quellcodedateien"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\Cheats.cpp
# End Source File
# Begin Source File

SOURCE=.\Cursoreditor.cpp
# End Source File
# Begin Source File

SOURCE=.\language.cpp
# End Source File
# Begin Source File

SOURCE=.\Skinampc.cpp
# End Source File
# Begin Source File

SOURCE=.\Skinampc.def
# End Source File
# Begin Source File

SOURCE=.\Skinampc.rc
# End Source File
# Begin Source File

SOURCE=.\Sonstiges.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# Begin Source File

SOURCE=.\ZipFiles.cpp
# End Source File
# End Group
# Begin Group "Header-Dateien"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\language.h
# End Source File
# Begin Source File

SOURCE=.\Skinampc.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Ressourcendateien"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\bmp101.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp102.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp103.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp104.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp105.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp106.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp107.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp108.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp109.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp120.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp125.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp126.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp127.bmp
# End Source File
# Begin Source File

SOURCE=.\bmp130.bmp
# End Source File
# Begin Source File

SOURCE=.\cur101.cur
# End Source File
# Begin Source File

SOURCE=.\cur102.cur
# End Source File
# Begin Source File

SOURCE=.\cur103.cur
# End Source File
# Begin Source File

SOURCE=.\cur104.cur
# End Source File
# Begin Source File

SOURCE=.\cur105.cur
# End Source File
# Begin Source File

SOURCE=.\cur106.cur
# End Source File
# Begin Source File

SOURCE=.\cur107.cur
# End Source File
# Begin Source File

SOURCE=.\cur201.cur
# End Source File
# Begin Source File

SOURCE=.\cur202.cur
# End Source File
# Begin Source File

SOURCE=.\cur203.cur
# End Source File
# Begin Source File

SOURCE=.\cur204.cur
# End Source File
# Begin Source File

SOURCE=.\cur205.cur
# End Source File
# Begin Source File

SOURCE=.\ico110.ico
# End Source File
# Begin Source File

SOURCE=.\splashscreen.bmp
# End Source File
# End Group
# Begin Group "Sonstiger Quellcode"

# PROP Default_Filter "*.c*"
# Begin Source File

SOURCE=.\zip.c

!IF  "$(CFG)" == "Skinampc - Win32 Release"

# SUBTRACT CPP /u

!ELSEIF  "$(CFG)" == "Skinampc - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# End Target
# End Project
