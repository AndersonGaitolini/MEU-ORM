program MeuORM;

uses
  Vcl.Forms,
  Atributos in '..\FONTES\Atributos.pas',
  Base in '..\FONTES\Base.pas',
  GerarClasse.BancoFirebird in '..\FONTES\GerarClasse.BancoFirebird.pas',
  GerarClasse in '..\FONTES\GerarClasse.pas',
  uDMORM in '..\FONTES\uDMORM.pas' {DM: TDataModule},
  ufoGerarClasse in '..\FONTES\ufoGerarClasse.pas' {foGeraClasse},
  DaoFD in '..\FONTES\DaoFD.pas',
  GerarClasseFireDac in '..\FONTES\GerarClasseFireDac.pas',
  SplitView in '..\FONTES\SplitView.pas',
  GerarSQL.BancoFireBird in '..\FONTES\GerarSQL.BancoFireBird.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfoGeraClasse, foGeraClasse);
  Application.Run;
end.
