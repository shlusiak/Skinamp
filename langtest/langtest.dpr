program langtest;

uses
  Forms,
  langtestmain in 'langtestmain.pas' {Langtestform},
  langtestthread in 'langtestthread.pas',
  langfile in 'langfile.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TLangtestform, Langtestform);
  Application.Run;
end.
