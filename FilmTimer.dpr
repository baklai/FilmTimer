program FilmTimer;

uses
  Forms,
  FTMain in 'FTMain.pas' {FFilmTimer},
  FTTime in 'FTTime.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := true;
  Application.Title := 'FilmTimer - автовыключение компьютера...';
  Application.CreateForm(TFFilmTimer, FFilmTimer);
  Application.Run;
end.
