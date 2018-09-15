program MeuORM_FMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufoGerarClasse in '..\FONTES\VIEWS\FMX\ufoGerarClasse.pas' {Form1},
  GerarClasse.BancoFirebird in '..\FONTES\MODELS\GerarClasse.BancoFirebird.pas',
  GerarClasse in '..\FONTES\MODELS\GerarClasse.pas',
  GerarClasseFireDac in '..\FONTES\MODELS\GerarClasseFireDac.pas',
  GerarSQL.BancoFireBird in '..\FONTES\MODELS\GerarSQL.BancoFireBird.pas',
  DaoFD in '..\FONTES\DAO\DaoFD.pas',
  uDMORM in '..\FONTES\DAO\uDMORM.pas' {DM: TDataModule},
  Atributos in '..\FONTES\CONTROLLER\Atributos.pas',
  Base in '..\FONTES\CONTROLLER\Base.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
