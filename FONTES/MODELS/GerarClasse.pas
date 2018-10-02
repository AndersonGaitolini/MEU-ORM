unit GerarClasse;

interface

uses
  Base, Classes;

type
  TGerarClasse = class
  private

    function Capitalize(ATexto: String): string;
  protected
    Resultado: TStringList;
    GerarClasseBanco: IBaseGerarClasseBanco;

    FTabela,
    FUnit,
    FClasse: string;
    FDescrToTypes: Boolean;
    FSmlIntToBool: Boolean;

    function GetCamposPK: string; virtual; abstract;

    procedure GerarCabecalhoVCL;
    procedure GerarCabecalhoFMX;
    procedure GerarFieldsProperties; virtual; abstract;
    procedure GerarRodape;
  public

    property DescrToTypes: Boolean read FDescrToTypes;
    property SmlIntToBool: Boolean read FSmlIntToBool;

    constructor Create(AClasseBanco: IBaseGerarClasseBanco);
    destructor Destroy; override;

    function Gerar(ATabela, ANomeUnit: string; ANomeClasse: string = '';
                   ADescrToTypes: Boolean=False; ASmlIntToBool: Boolean=False;
                   TipoProjeto : TTypeproject = tpVCL): string;
  end;

implementation

{ TGerarClasse }

uses SysUtils;

function TGerarClasse.Capitalize(ATexto: String): string;
begin
  Result := UpperCase(ATexto[1]) + LowerCase(Copy(ATexto, 2, Length(ATexto)));
end;

constructor TGerarClasse.Create(AClasseBanco: IBaseGerarClasseBanco);
begin
  inherited Create;
  Resultado := TStringList.Create;
  GerarClasseBanco := AClasseBanco;
end;

destructor TGerarClasse.Destroy;
begin
  Resultado.Free;
  inherited;
end;

function TGerarClasse.Gerar(ATabela, ANomeUnit, ANomeClasse: string; ADescrToTypes, ASmlIntToBool: Boolean; TipoProjeto : TTypeproject): string;
begin
  FTabela := ATabela;
  FSmlIntToBool := ASmlIntToBool;
  FDescrToTypes := ADescrToTypes;

  FUnit := Capitalize(ANomeUnit);

  if Trim(ANomeClasse) = '' then
    FClasse := Capitalize(FTabela)
  else
    FClasse := Capitalize(ANomeClasse);

  if TipoProjeto = tpVCL then
    GerarCabecalhoVCL
  else
    GerarCabecalhoFMX;

  GerarFieldsProperties;

  GerarRodape;

  Result := Resultado.Text;
end;

procedure TGerarClasse.GerarCabecalhoFMX;
begin
Resultado.clear;
  Resultado.add('unit ' + FUnit + ';');
  Resultado.add('');
  Resultado.add('interface');
  Resultado.add('');
  Resultado.add('uses');
  Resultado.add('  System.SysUtils,');
  Resultado.add('  System.Classes,');
  Resultado.add('  Vcl.Forms,');
  Resultado.add('  FMX.Dialogs,');
  Resultado.add('  FMX.Controls,');
  Resultado.add('  FMX.DBGrids,');
  Resultado.add('  Data.DB,');
  Resultado.add('  FireDAC.Comp.Client,');
  Resultado.add(' ');
  Resultado.add('  uDM{SEU DATA MODULE}');
  Resultado.add('  Base,');
  Resultado.add('  Atributos;');
  Resultado.add('{Fonte criado automaticamente pelo ORM by ANDERSON GAITOLINI}');
  Resultado.add('');
  Resultado.add('type');
  Resultado.add('  [attTabela(' + QuotedStr(FTabela) + ')]');
  Resultado.add('  T' + FClasse + ' = class(TTabela)');
end;

procedure TGerarClasse.GerarCabecalhoVCL;
begin
  Resultado.clear;
  Resultado.add('unit ' + FUnit + ';');
  Resultado.add('');
  Resultado.add('interface');
  Resultado.add('');
  Resultado.add('uses');
  Resultado.add('  System.SysUtils,');
  Resultado.add('  System.Classes,');
  Resultado.add('  Vcl.Forms,');
  Resultado.add('  Vcl.Dialogs,');
  Resultado.add('  Vcl.Controls,');
  Resultado.add('  Vcl.DBGrids,');
  Resultado.add('  Data.DB,');
  Resultado.add('  FireDAC.Comp.Client,');
  Resultado.add(' ');
  Resultado.add('  uDM{SEU DATA MODULE}');
  Resultado.add('  Base,');
  Resultado.add('  Atributos;');
  Resultado.add('{Fonte criado automaticamente pelo ORM by ANDERSON GAITOLINI}');
  Resultado.add('');
  Resultado.add('type');
  Resultado.add('  [attTabela(' + QuotedStr(FTabela) + ')]');
  Resultado.add('  T' + FClasse + ' = class(TTabela)');
end;

procedure TGerarClasse.GerarRodape;
begin
  Resultado.Add('  end;');
  Resultado.Add('');
  Resultado.Add('  var');
  Resultado.Add('  o'+FTabela+': T' + FClasse + ';');
  Resultado.Add('');
  Resultado.Add('implementation');
  Resultado.Add('');
  Resultado.Add('');
  Resultado.Add('');
  Resultado.Add('end.');
end;

end.
