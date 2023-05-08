program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Clicker in 'Clicker.pas' {ClickerForm},
  Games in 'Games.pas' {GamesForm},
  Login in 'Login.pas' {LoginForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TClickerForm, ClickerForm);
  Application.CreateForm(TGamesForm, GamesForm);
  Application.Run;
end.
