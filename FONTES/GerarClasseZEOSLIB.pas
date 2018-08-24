unit GerarClasseZEOSLIB;

interface

uses
  Base, GerarClasse, DB, DaoZeos, SysUtils;

type
  TGerarClasseZeosLib = class(TGerarClasse)
  private
    FDao: TDaoZ;
  protected
    function GetCamposPK: string; override;

    procedure GerarFieldsProperties; override;

  public
    constructor Create(AClasseBanco: IBaseGerarClasseBanco; ADao: TDaoZ);
  end;

implementation

{ TDaoFireDac }

constructor TGerarClasseZeosLib.Create(AClasseBanco: IBaseGerarClasseBanco;
  ADao: TDaoZ);
begin
  inherited Create(AClasseBanco);

  FDao := ADao;
end;

procedure TGerarClasseZeosLib.GerarFieldsProperties;
var
  Ds: TDataSet;
begin
  inherited;

  Ds :=  FDao.ConsultaSql(GerarClasseBanco.GetSQLCamposTabela(FTabela));

  GerarClasseBanco.GerarFields(Ds, Resultado);

  GerarClasseBanco.GerarProperties(Ds, Resultado, GetCamposPK);
end;

function TGerarClasseZeosLib.GetCamposPK: string;
var
  Sep: string;
begin
  Sep := '';

  with FDao.ConsultaSql(GerarClasseBanco.GetSQLCamposPK(FTabela)) do
    while not Eof do
    begin
      if Result <> '' then
        Sep := ',';

      Result := Result + Sep + Trim(FieldByName('campo').AsString);

      Next;
    end;
end;

end.
