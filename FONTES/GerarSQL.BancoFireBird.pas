unit GerarSQL.BancoFireBird;

interface
uses
  Base, Atributos, DB, SysUtils, Classes, System.Rtti;

 type
   TGerarSQLBancoFirebird = class(TInterfacedObject, IBaseSql)
   private

   public
     function GeraSqlCreateTable(ATabela: TTabela): string; overload;
   published

   end;

implementation

{ TGerarSQLBancoFirebird }

function TGerarSQLBancoFirebird.GeraSqlCreateTable(ATabela: TTabela): string;
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
          raise Exception.Create('Tipo de campo não conhecido: ' +
          PropRtti.PropertyType.ToString);
        end;

        Result := Text;
      end;
    end;
  finally
    ASql.Free
  end;
end;

end.
