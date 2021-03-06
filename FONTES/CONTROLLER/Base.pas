unit Base;

interface

uses DB, SysUtils, Classes, Rtti, System.TypInfo,
  System.Generics.Collections;

type
  TCamposArray = array of string;
  TFlagCampos = (fcAdd, fcIgnore);
  TTypeproject = (tpVCL, tpFMX);

  TTabela = class(TPersistent)
  end;

  IBaseGeraSql = interface
    ['{7B049A3F-89BD-4245-96EE-396E9541BD20}']
    function GeraSqlCreateTable(ATabela: TTabela): string; overload;

    function GeraSqlAlterTable(ATabela: TTabela; ACamposWhere: array of string): string; overload;

    function GeraSqlDropTable(ATabela: TTabela): string; overload;

    function ListaofClass(aUnitFile: string):TStringList;

    function CreateTable(ABanco : String; ATabela: TTabela): boolean;
  end;
  IBaseSql = interface
    ['{3890762A-9CF2-46C3-A75C-62947D3DAD7B}']

    // gera��o do sql padrao
    function GerarSqlInsert(ATabela: TTabela; TipoRtti: TRttiType;
      ACampos: array of string; AFlag: TFlagCampos = fcAdd): string;

    function GerarSqlUpdate(ATabela: TTabela; TipoRtti: TRttiType;
      ACampos: array of string; AFlag: TFlagCampos = fcAdd): string;

    function GerarSqlDelete(ATabela: TTabela): string;

    function GerarSqlSelect(ATabela: TTabela): string; overload;

    function GerarSqlSelect(ATabela: TTabela; ACamposWhere: array of string): string;
       overload;

    function GerarSqlSelect(ATabela: TTabela; ACampos: array of string;
      ACamposWhere: array of string): string; overload;

  end;

  TPadraoSql = class(TInterfacedObject, IBaseSql)
  public
    function GerarSqlInsert(ATabela: TTabela; TipoRtti: TRttiType;
      ACampos: array of string; AFlag: TFlagCampos = fcAdd): string;

    function GerarSqlUpdate(ATabela: TTabela; TipoRtti: TRttiType;
      ACampos: array of string; AFlag: TFlagCampos = fcAdd): string;

    function GerarSqlDelete(ATabela: TTabela): string; virtual;

    function GerarSqlSelect(ATabela: TTabela): string; overload;

    function GerarSqlSelect(ATabela: TTabela; ACamposWhere: array of string): string;
       overload;

    function GerarSqlSelect(ATabela: TTabela; ACampos: array of string;
      ACamposWhere: array of string): string; overload;

  end;

  TPadraoGeraSql = class(TInterfacedObject, IBaseGeraSql)
  public
    function GeraSqlCreateTable(ATabela: TTabela): string; overload;

    function GeraSqlAlterTable(ATabela: TTabela; ACamposWhere: array of string): string; overload;

    function GeraSqlDropTable(ATabela: TTabela): string; overload;

    function ListaofClass(aUnitFile: string):TStringList; overload;

    function CreateTable(ABanco : String; ATabela: TTabela): boolean; overload;
  end;

  IQueryParams = interface
  ['{FBE0114E-931B-44FB-8325-45A68D2DE4E3}']
  // configura par�mentro para cada tipo de dado
    procedure SetParamInteger(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamString(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamDate(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamDateTime(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);

    procedure SetParamCurrency(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamBoolean(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamVariant(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamFileStream(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetParamStream(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);

  // m�todos para setar os variados tipos de campos
    procedure SetCamposInteger(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposString(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposDate(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposDateTime(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposCurrency(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposBoolean(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposFileStream(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
    procedure SetCamposStream(AProp: TRttiProperty; ACampo: string; ATabela: TTabela; AQry: TObject);
  end;

Type
  IDaoBase = interface
  ['{6E2AFB66-465B-4924-9221-88E283E81EA7}']
  // configura e executa a query
    function ExecutaQuery: Integer;

  // gerar classe
    function GerarClasse(ATabela, ANomeUnit: string; ANomeClasse: string = ''; ADescrToTypes: Boolean=False; ASmlIntToBool: Boolean=False): string;

  // pega campo autoincremento
    function GetID(ATabela:TTabela; ACampo: string): Integer;

  // comandos crud
    function Inserir(ATabela: TTabela): Integer; overload;
    function Inserir(ATabela: TTabela; ACampos: array of string;
      AFlag: TFlagCampos = fcIgnore): Integer; overload;

    function Salvar(ATabela: TTabela): Integer; overload;
    function Salvar(ATabela: TTabela; ACampos: array of string; AFlag: TFlagCampos = fcAdd): Integer; overload;

    function Excluir(ATabela: TTabela): Integer; overload;
    function Excluir(ATabela: TTabela; AWhere: array of string): Integer; overload;
    function Excluir(ATabela: string; AWhereValue: string): Integer; overload;
    function ExcluirTodos(ATabela: TTabela): Integer; overload;

    function Buscar(ATabela: TTabela): Integer;

    // dataset para as consultas
    function ConsultaAll(ATabela: TTabela; AOrderBy: string = ''): TDataSet;
    function ConsultaSql(ASql: string): TDataSet; overload;
    function ConsultaSql(ASql: string; const ParamList: Array of Variant): TDataSet; overload;
    function ConsultaSql(ATabela: string; AWhere: string): TDataSet; overload;
    function ConsultaTab(ATabela: TTabela; ACamposWhere: array of string): TDataSet; overload;
    function ConsultaTab(ATabela: TTabela; ACampos, ACamposWhere: array of string): TDataSet; overload;
    function ConsultaTab(ATabela: TTabela; ACampos, ACamposWhere, AOrdem: array of string; TipoOrdem: Integer = 0): TDataSet; overload;

    // limpar campos da tabela
    procedure Limpar(ATabela: TTabela);

    // comandos transa��o
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
    function  InTransaction: Boolean;
  end;

  IBaseGerarClasseBanco = Interface
  ['{D82EC768-996A-4E06-A59E-0C87CB305D0E}']

     //obtem sql com nome, tamanho e tipo dos campos
    function GetSQLCamposTabela(ATabela: string): string;

    //obtem sql com chave prim�rias
    function GetSQLCamposPK(ATabela: string): string;

    procedure GerarFields(Ads: TDataSet; AResult: TStrings; ADescrToTypes, ASmlIntToBool: Boolean); overload;
    procedure GerarProperties(Ads: TDataSet; AResult: TStrings; ACamposPK: string; ADescrToTypes, ASmlIntToBool: Boolean); overload;
  End;

implementation

uses Atributos;

{ PadraoSql}
function TPadraoSql.GerarSqlDelete(ATabela: TTabela): string;
var
  Campo, Separador: string;
  ASql: TStringList;
  Atributos: IAtributos;
begin
  Atributos := TAtributos.Create;
  ASql := TStringList.Create;
  try
    with ASql do
    begin
      Add('Delete from ' + Atributos.PegaNomeTab(ATabela));
      Add('Where');
      Separador := '';
      for Campo in Atributos.PegaPks(ATabela) do
      begin
        Add(Separador + Campo + '= :' + Campo);
        Separador := ' and ';
      end;
    end;
    Result := ASql.Text;
  finally
    ASql.Free;
  end;
end;

function TPadraoSql.GerarSqlInsert(ATabela: TTabela; TipoRtti: TRttiType;
  ACampos: array of string; AFlag: TFlagCampos): string;
var
  Separador: string;
  ASql: TStringList;
  PropRtti: TRttiProperty;
  Atributos: IAtributos;
begin
  Atributos := TAtributos.Create;
  ASql := TStringList.Create;
  try
    with ASql do
    begin
      Add('Insert into ' + Atributos.PegaNomeTab(ATabela));
      Add('(');

      // campos da tabela
      Separador := '';
      for PropRtti in TipoRtti.GetProperties do
      begin
        if Length(ACampos) > 0 then
          if ((AFlag = fcIgnore) and (Atributos.LocalizaCampo(PropRtti.Name, ACampos))) or
            ((AFlag = fcAdd) and (not Atributos.LocalizaCampo(PropRtti.Name, ACampos))) then
            continue;

        Add(Separador + PropRtti.Name);
        Separador := ',';
      end;
      Add(')');

      // par�metros
      Add('Values (');
      Separador := '';

      for PropRtti in TipoRtti.GetProperties do
      begin
        if Length(ACampos) > 0 then
          if ((AFlag = fcIgnore) and (Atributos.LocalizaCampo(PropRtti.Name, ACampos))) or
            ((AFlag = fcAdd) and (not Atributos.LocalizaCampo(PropRtti.Name, ACampos))) then
            continue;

        Add(Separador + ':' + PropRtti.Name);
        Separador := ',';
      end;
      Add(')');
    end;
    Result := ASql.Text;
  finally
    ASql.Free;
  end;
end;

function TPadraoSql.GerarSqlSelect(ATabela: TTabela): string;
var
  Campo, Separador: string;
  ASql: TStringList;
  Atributos: IAtributos;
begin
  Atributos := TAtributos.Create;
  ASql := TStringList.Create;
  try
    with ASql do
    begin
      Add('Select * from ' + Atributos.PegaNomeTab(ATabela));
      Add('Where');
      Separador := '';
      for Campo in Atributos.PegaPks(ATabela) do
      begin
        Add(Separador + Campo + '= :' + Campo);
        Separador := ' and ';
      end;
    end;
    Result := ASql.Text;
  finally
    ASql.Free;
  end;
end;

function TPadraoSql.GerarSqlSelect(ATabela: TTabela; ACamposWhere: array of string): string;
var
  Campo, Separador: string;
  ASql: TStringList;
begin
  ASql := TStringList.Create;
  try
    with ASql do
    begin
      Add('Select * from ' + TAtributos.Get.PegaNomeTab(ATabela));
      Add('Where 1=1');
      Separador := ' and ';
      for Campo in ACamposWhere do
        Add(Separador + Campo + '= :' + Campo);
    end;
    Result := ASql.Text;
  finally
    ASql.Free;
  end;
end;

function TPadraoSql.GerarSqlSelect(ATabela: TTabela; ACampos,
  ACamposWhere: array of string): string;
var
  Campo, Separador: string;
  ASql: TStringList;
begin
  ASql := TStringList.Create;
  try
    with ASql do
    begin
      Add('Select ');

      if Length(ACampos)>0 then
      begin
        Separador := '';
        for Campo in ACampos do
        begin
          Add(Separador + Campo);
          Separador := ',';
        end;
      end
      else
        Add('*');

      Add(' from ' + TAtributos.Get.PegaNomeTab(ATabela));

      Add('Where 1=1');

      Separador := ' and ';

      for Campo in ACamposWhere do
        Add(Separador + Campo + '= :' + Campo);
    end;
    Result := ASql.Text;
  finally
    ASql.Free;
  end;
end;

function TPadraoSql.GerarSqlUpdate(ATabela: TTabela;
  TipoRtti: TRttiType; ACampos: array of string; AFlag: TFlagCampos): string;
var
  Campo, Separador: string;
  ASql: TStringList;
  PropRtti: TRttiProperty;
  Atributos: IAtributos;
begin
  Atributos := TAtributos.Create;
  ASql := TStringList.Create;
  try
    with ASql do
    begin
      Add('Update ' + Atributos.PegaNomeTab(ATabela));
      Add('set');

      // campos da tabela
      Separador := '';
      for PropRtti in TipoRtti.GetProperties do
      begin
        if Length(ACampos) > 0 then
          if ((AFlag = fcIgnore) and (Atributos.LocalizaCampo(PropRtti.Name, ACampos))) or
            ((AFlag = fcAdd) and (not Atributos.LocalizaCampo(PropRtti.Name, ACampos))) then
            continue;

        Add(Separador + PropRtti.Name + '=:' + PropRtti.Name);
        Separador := ',';
      end;
      Add('where');

      // par�metros da cl�usula where
      Separador := '';
      for Campo in Atributos.PegaPks(ATabela) do
      begin
        Add(Separador + Campo + '= :' + Campo);
        Separador := ' and ';
      end;
    end;
    Result := ASql.Text;
  finally
    ASql.Free;
  end;
end;

function TPadraoGeraSql.CreateTable(ABanco: String; ATabela: TTabela): boolean;
begin
  Result := false;
end;

function TPadraoGeraSql.GeraSqlAlterTable(ATabela: TTabela; ACamposWhere: array of string): string;
var
  Atributos: IAtributos;
  Campo: string;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
  sText, Sep1, Sep2: string;
  ASql: TStringList;
begin
  Atributos := TAtributos.Create;
  ASql := TStringList.Create;
  try
    with ASql do
    begin
      Add('ALTER TABLE ' + Atributos.PegaNomeTab(ATabela) + ' (');
      RttiType := TRttiContext.Create.GetType(ATabela);
      Sep1 := '';
      Sep2 := ' ';
      for PropRtti in RttiType.GetProperties do
      begin
//        for Campo in ACamposWhere do

        case PropRtti.PropertyType.TypeKind of
          tkInt64:begin
                    Add('ALTER '+PropRtti.Name+Sep2+'BIGINT'+Sep1);
                  end;

          tkInteger: begin
                       Add('ALTER '+PropRtti.Name+Sep2+'INTEGER'+Sep1);
                     end;

          tkChar: begin
                    Add('ALTER '+PropRtti.Name+Sep2+'CHAR'+Sep1);
                  end;

          tkString, tkUString:
                  begin
                    Add('ALTER '+PropRtti.Name+Sep2+'VARCHAR()'+Sep1);
                  end;

          tkFloat:
          begin
            if CompareText(PropRtti.PropertyType.Name, 'TDate') = 0 then
            begin
              Add('ALTER '+PropRtti.Name+Sep2+'DATE'+Sep1);
            end
            else
            if CompareText(PropRtti.PropertyType.Name, 'TDateTime') = 0 then
            begin
              Add('ALTER '+PropRtti.Name+Sep2+'DATE'+Sep1);
            end
            else
            begin
              Add('ALTER '+PropRtti.Name+Sep2+'DECIMAL(15,2)'+Sep1);
            end;
          end;

  //        tkVariant: ShowMessage(PropRtti.Name +' tkVariant: '+ PropRtti.PropertyType.Name);

          tkEnumeration: if CompareText(PropRtti.PropertyType.Name, 'Boolean') = 0 then
                         begin
                           Add(PropRtti.Name+Sep2+'SMALINT'+Sep1);
                         end;

          tkClass : if CompareText(PropRtti.PropertyType.Name, 'TFileStream') = 0 then
                    begin
                      Add(PropRtti.Name+Sep2+'BLOB SUB_TYPE 1 SEGMENT SIZE 80'+Sep1);
                    end
                    else
                    begin
                      Add(PropRtti.Name+Sep2+'BLOB SUB_TYPE 0 SEGMENT SIZE 80'+Sep1);
                    end
        else
          raise Exception.Create('Tipo de campo n�o conhecido: ' +
          PropRtti.PropertyType.ToString);
        end;

        Result := Text;
      end;
    end;
  finally
    ASql.Free
  end;
end;

function TPadraoGeraSql.GeraSqlCreateTable(ATabela: TTabela): string;
var
  Atributos: IAtributos;
  Campo: string;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
  sText, Sep1, Sep2: string;
  ASql: TStringList;
begin
  Atributos := TAtributos.Create;
  ASql := TStringList.Create;
  try
    with ASql do
    begin

      Add('CREATE TABLE ' + Atributos.PegaNomeTab(ATabela) + ' (');
      RttiType := TRttiContext.Create.GetType(ATabela);
      Sep1 := '';
      Sep2 := ' ';
      for PropRtti in RttiType.GetProperties do
      begin
      Sep1 := ',';
        case PropRtti.PropertyType.TypeKind of
          tkInt64:begin
                    Add(PropRtti.Name+Sep2+'BIGINT'+Sep1);
                  end;

          tkInteger: begin
                       Add(PropRtti.Name+Sep2+'INTEGER'+Sep1);
                     end;

          tkChar: begin
                    Add(PropRtti.Name+Sep2+'CHAR'+Sep1);
                  end;

          tkString, tkUString:
                  begin
                    Add(PropRtti.Name+Sep2+'VARCHAR()'+Sep1);
                  end;

          tkFloat:
          begin
            if CompareText(PropRtti.PropertyType.Name, 'TDate') = 0 then
            begin
              Add(PropRtti.Name+Sep2+'DATE'+Sep1);
            end
            else
            if CompareText(PropRtti.PropertyType.Name, 'TDateTime') = 0 then
            begin
              Add(PropRtti.Name+Sep2+'DATE'+Sep1);
            end
            else
            begin
              Add(PropRtti.Name+Sep2+'DECIMAL(15,2)'+Sep1);
            end;
          end;

  //        tkVariant: ShowMessage(PropRtti.Name +' tkVariant: '+ PropRtti.PropertyType.Name);

          tkEnumeration: if CompareText(PropRtti.PropertyType.Name, 'Boolean') = 0 then
                         begin
                           Add(PropRtti.Name+Sep2+'SMALINT'+Sep1);
                         end;

          tkClass : if CompareText(PropRtti.PropertyType.Name, 'TFileStream') = 0 then
                    begin
                      Add(PropRtti.Name+Sep2+'BLOB SUB_TYPE 1 SEGMENT SIZE 80'+Sep1);
                    end
                    else
                    begin
                      Add(PropRtti.Name+Sep2+'BLOB SUB_TYPE 0 SEGMENT SIZE 80'+Sep1);
                    end
        else
          raise Exception.Create('Tipo de campo n�o conhecido: ' +
          PropRtti.PropertyType.ToString);
        end;

        Result := Text;
      end;
    end;
  finally
    ASql.Free
  end;
end;

function TPadraoGeraSql.GeraSqlDropTable(ATabela: TTabela): string;
begin

end;

function TPadraoGeraSql.ListaofClass(aUnitFile: string): TStringList;
Var
 RttiType : TRttiType;
  //extract the unit name from the  QualifiedName property
  function GetUnitName(lType: TRttiType): string;
  begin
    Result := StringReplace(lType.QualifiedName, '.' + lType.Name, '',[rfReplaceAll])
  end;

begin
  Result := TStringList.Create;
  try
    if not (FileExists(aUnitFile)) then
      exit;

    //list all the types of the System.SysUtils unit
    for RttiType in TRttiContext.Create.GetTypes do
     if SameText(aUnitFile,GetUnitName(RttiType)) and (RttiType.IsInstance) then
       Result.Add(RttiType.Name);

  except on E: Exception do

  end;
end;

end.
