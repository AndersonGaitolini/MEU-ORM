unit GerarClasse.BancoFirebird;

interface

uses
  Base, DB, SysUtils, Classes;

type
  TGerarClasseBancoFirebird = class(TInterfacedObject, IBaseGerarClasseBanco)
  private
    function GetTypeField(Tipo, SubTipo, Precisao: Integer; Descricao: string; ADescrToTypes, ASmlIntToBool: Boolean): string;
  public
     //obtem sql com nome, tamanho e tipo dos campos
    function GetSQLCamposTabela(ATabela: string): string;

    //obtem sql com chave primárias
    function GetSQLCamposPK(ATabela: string): string;

    procedure GerarFields(Ads: TDataSet; AResult: TStrings; ADescrToTypes, ASmlIntToBool: Boolean); overload;
    procedure GerarProperties(Ads: TDataSet; AResult: TStrings;ACamposPK: string; ADescrToTypes, ASmlIntToBool: Boolean); overload;
  end;

implementation

procedure TGerarClasseBancoFirebird.GerarFields(Ads: TDataSet; AResult: TStrings; ADescrToTypes, ASmlIntToBool: Boolean);
var
  Tipo,
  SubTipo,
  Precisao: Integer;
  Nome, Descricao: string;
  DescrType: Boolean;
begin
  AResult.Add('  private');
  ADs.First;
  while not Ads.eof do
  begin
    Tipo := Ads.FieldByName('tipo').AsInteger;
    SubTipo := Ads.FieldByName('subtipo').AsInteger;
    Precisao := Ads.FieldByName('precisao').AsInteger;
    Nome := Trim(Ads.FieldByName('nome').AsString);
    Descricao := Trim(Ads.FieldByName('Descricao').AsString);
    Nome := 'F' + UpperCase(Nome[1]) + LowerCase(Copy(Nome, 2, Length(Nome)));
    AResult.Add('    ' + Nome + ': ' + GetTypeField(Tipo, SubTipo, Precisao, Descricao, ADescrToTypes, ASmlIntToBool) + ';');
    Ads.Next;
  end;
end;

procedure TGerarClasseBancoFirebird.GerarProperties(Ads: TDataSet; AResult: TStrings;ACamposPK: string; ADescrToTypes, ASmlIntToBool: Boolean);
var
  Tipo,
  SubTipo,
  Precisao: Integer;
  Nome: string;
  Dominio: string;
  Descricao: string;

begin
  AResult.Add('  public');
  ADs.First;
  while not Ads.eof do
  begin
    Tipo := Ads.FieldByName('tipo').AsInteger;
    SubTipo := Ads.FieldByName('subtipo').AsInteger;
    Precisao := Ads.FieldByName('precisao').AsInteger;
    Nome := Trim(Ads.FieldByName('nome').AsString);
    Descricao := Trim(Ads.FieldByName('Descricao').AsString);

    if pos(Nome, ACamposPK) > 0 then
      AResult.Add('    [attPK]');

    Nome := UpperCase(Nome[1]) + LowerCase(Copy(Nome, 2, Length(Nome)));

    AResult.Add('    property ' +
                       Nome +': ' + GetTypeField(Tipo, SubTipo, Precisao, Descricao, ADescrToTypes, ASmlIntToBool) +
                       ' read F' + Nome +
                       ' write F' + Nome + ';');
    Ads.Next;
  end;
end;

function TGerarClasseBancoFirebird.GetSQLCamposPK(ATabela: string): string;
begin
  Result := 'SELECT RDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME AS TABELA, ' +
            'RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_NAME AS CHAVE, ' +
            'RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME AS INDICE_DA_CHAVE, ' +
            'RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS CAMPO, ' +
            'RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION AS POSICAO ' +
            'FROM RDB$RELATION_CONSTRAINTS, ' +
            'RDB$INDICES, ' +
            'RDB$INDEX_SEGMENTS ' +
            'WHERE RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ' +
            'AND RDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME = ' + QuotedStr(ATabela) +
            'AND RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
            'AND RDB$INDEX_SEGMENTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
            'ORDER BY RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_NAME, ' +
            'RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION';
end;

function TGerarClasseBancoFirebird.GetSQLCamposTabela(ATabela: string): string;
begin
  Result := 'SELECT r.RDB$FIELD_NAME AS nome,' +
            'r.RDB$DESCRIPTION AS descricao,' +
            'f.RDB$FIELD_LENGTH AS tamanho,' +
            'f.RDB$FIELD_TYPE AS tipo,' +
            'f.RDB$FIELD_SUB_TYPE AS subtipo, ' +
            'f.RDB$FIELD_PRECISION AS precisao ' +
            'FROM RDB$RELATION_FIELDS r ' +
            'LEFT JOIN RDB$FIELDS f ON r.RDB$FIELD_SOURCE = f.RDB$FIELD_NAME ' +
            'WHERE r.RDB$RELATION_NAME='+ QuotedStr(ATabela) + ' ' +
            'ORDER BY r.RDB$FIELD_POSITION;';
end;

function TGerarClasseBancoFirebird.GetTypeField(Tipo, SubTipo, Precisao: Integer; Descricao: string; ADescrToTypes, ASmlIntToBool: Boolean): string;
const
  cBoolean = 'Boolean';
  cWord    = 'Word';
begin

  if (ADescrToTypes) and (Tipo <> 7) then
    Result := Descricao
  else
  case Tipo of
    7: begin
         if ASmlIntToBool then
          Result := 'Boolean'
         else
         if ADescrToTypes then
           Result := Descricao
         else
           Result := 'Word';
       end;

    08,
    09: Result := 'Integer';
    10,
    11: Result := 'Float';
    12: Result := 'TDate';
    13: Result := 'TTime';
    14: Result := 'Char';
    16:                                     //Data type code for the column:
      begin
        if Precisao = 0 then              //8 = INTEGER
          Result := 'LongInt'             //10 = FLOAT
        else                              //12 = DATE
          Result := 'Double';              //13 = TIME
      end;                                //14 = CHAR
                                            //16 = BIGINT
    27: Result := 'Currency';
    37,                                     //27 = DOUBLE PRECISION
    40: Result := 'string';                 //35 = TIMESTAMP
                                            //37 = VARCHAR
                                            //261 = BLOB
    35: Result := 'TDateTime';              //Codes for DECIMAL and NUMERIC are the same as for the integer types used to store them
    261:
    begin
      if SubTipo = 0 then
        Result := 'TFileStream'
      else
        Result := 'TStringStream';
    end;

  else
    Result := 'TUnknown';
  end;

end;
end.
