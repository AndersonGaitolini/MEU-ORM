program MeuORM_VCL;

uses
  Vcl.Forms,
  ufoGerarClasse in '..\FONTES\VIEWS\VCL\ufoGerarClasse.pas' {foGeraClasse},
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
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfoGeraClasse, foGeraClasse);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
