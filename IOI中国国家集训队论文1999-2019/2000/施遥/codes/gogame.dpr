program gogame;

uses
  Forms,
  gomain in 'gomain.pas' {Form1},
  readme in 'readme.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
