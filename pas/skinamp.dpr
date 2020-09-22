program SkinAmp;
{$I cs.inc}

{%ToDo 'skinamp.todo'}

{$R *.res}

uses
  sysutils,
  windows,
  funktionen in 'funktionen.pas',
  konstanten in 'konstanten.pas',
  Forms,
  main in 'main.pas' {PagesDlg},
  saveform in 'saveform.pas' {saveskin},
  wmain in 'wmain.pas',
  bmps in 'bmps.pas',
  weq in 'weq.pas',
  wpl in 'wpl.pas',
  info in 'info.pas' {infodialog},
  artwork in 'artwork.pas' {ArtDlg},
  flowframe in 'flowframe.pas' {FlowFrm: TFrame},
  flowform in 'flowform.pas' {FlowDlg},
  wmb in 'wmb.pas',
  wavs in 'wavs.pas',
  viscolor in 'viscolor.pas' {viscolordlg},
  pltext in 'pltext.pas' {pltextdlg},
  cheatdlg in 'cheatdlg.pas' {skincheat},
  regions in 'regions.pas' {Regionsdlg},
  searchcolor in 'searchcolor.pas' {getcolor},
  mbtext in 'mbtext.pas' {mbtextdlg},
  language in 'language.pas',
  langselect in 'langselect.pas' {languagedlg},
  cureditor in 'cureditor.pas' {cursoreditor},
  ctest in 'ctest.pas' {cursortest},
  skinampc in 'skinampc.pas',
  regiotest in 'regiotest.pas';

procedure testcomplete;
procedure error(const s:string);
begin
  if application.messagebox(pchar(s),pchar(loadstringid(3)),mb_okcancel or mb_iconhand)=idcancel then 
  halt;
end;
procedure testfile(fn:string);
var
s:string;
f:file;
begin
  s:=extractfilepath(paramstr(0));
  if s[length(s)]<>'\' then s:=s+'\';
  s:=s+fn;
  assignfile(f,s);
  filemode:=0;
  {$I-}
  reset(f);
  {$I+}
  if ioresult<>0 then error(format(loadstringid(2),[s]))
    else closefile(f);
end;
begin
  testfile('MASKS.BMP');
  testfile('BITMAPS.BMP');
  testfile('ENGLISH.LNG');
  testfile('SKINAMPC.DLL');
end;

begin
  Application.Initialize;
  Application.Title := 'SkinAmp';
  testcomplete;
  Application.CreateForm(TPagesDlg, PagesDlg);
  Application.CreateForm(TFlowDlg, FlowDlg);
  Application.CreateForm(Tviscolordlg, viscolordlg);
  Application.CreateForm(TRegionsdlg, Regionsdlg);
  pagesdlg.initialisate;
  Application.Run;
end.
