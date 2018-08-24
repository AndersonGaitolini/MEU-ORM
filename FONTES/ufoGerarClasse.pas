unit ufoGerarClasse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  JvExControls, JvSwitch, Vcl.Menus, SplitView, Vcl.ComCtrls, System.Rtti,
  Base;

type
  TfoGeraClasse = class(TForm)
    pnlRodape: TPanel;
    btnSalvar: TButton;
    btnSair: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnGerar: TButton;
    Salvar: TSaveDialog;
    pnlMenu: TPanel;
    edBD: TLabeledEdit;
    btn1: TSpeedButton;
    dlgOpen1: TOpenDialog;
    btnConexao: TJvSwitch;
    btnInfo: TSpeedButton;
    pm1: TPopupMenu;
    opcLimpartabela: TMenuItem;
    opcLimparPas: TMenuItem;
    mo: TSpeedButton;
    pnlConfig: TPanel;
    pnlMain: TPanel;
    pgc1: TPageControl;
    tsClass: TTabSheet;
    tsSQL: TTabSheet;
    lstTabelas: TListBox;
    mmGerarSQL: TMemo;
    mmGerarCLass: TMemo;
    lstClasses: TListBox;
    btnExecPackage: TButton;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConexaoClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure opcLimpartabelaClick(Sender: TObject);
    procedure opcLimparPasClick(Sender: TObject);
    procedure moClick(Sender: TObject);
    procedure btnExecPackageClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaBotao;
    procedure PegaTabelas;
    procedure GeraClasse;
    procedure GeraSQL;
    procedure SalvarArquivo;
  public
    { Public declarations }
    SplitView : TSplitView;

    procedure CarregaPKG;
    procedure CriaPacote;
    procedure abrirPacote;
    procedure CarregaDLL;
  end;

var
  foGeraClasse: TfoGeraClasse;

implementation

{$R *.dfm}

uses uDMORM, uClassPerfilEmail, Atributos;//udmPrin;

procedure TfoGeraClasse.CriaPacote;
var
APackage : array of Cardinal;
APersistentClass: TPersistentClass;
AForm: TForm;
sFile: string;
i:Integer;
begin
  SetLength(APackage, 0);

  dlgOpen1.FilterIndex := 3;
  dlgOpen1.InitialDir := ExtractFileDir(ParamStr(0));
  if dlgOpen1.Execute then
    sFile := dlgOpen1.FileName;

  if FileExists(sFile) then
  begin
    SetLength(APackage, Length(APackage) + 1);
    APackage[Length(APackage)-1] := LoadPackage(sFile); ///// abri pacote
  end;
end;

////////////////////////// procedimento para abrir um formulário ////////////////////////
procedure TfoGeraClasse.abrirPacote;
var
APersistentClass: TPersistentClass;
AForm: TForm;
begin
  APersistentClass := GetClass('TUsuarios');
  if APersistentClass = nil then
    showmessage('Classe não localizada!')
  else
  begin
    ShowMessage(APersistentClass.ClassName);
//    AForm := TComponentClass(APersistentClass).Create(Application) as TForm;
//    AForm.ShowModal;
  end;
end;

procedure TfoGeraClasse.AtualizaBotao;
begin
  btnConexao.Caption := '';
  btnConexao.StateOn := dm.conORM_FD.Connected;
  if dm.conORM_FD.Connected then
    btnConexao.Caption := 'Conectado!'
  else
    btnConexao.Caption := 'Desconectado!';

  pgc1.ActivePage := tsClass;
end;

procedure TfoGeraClasse.btn1Click(Sender: TObject);
begin
  if dlgOpen1.Execute then
   edBD.Text := dlgOpen1.FileName;

  if edBD.CanFocus then
   edBD.SelStart := Length(Trim(edBD.Text));
end;

procedure TfoGeraClasse.btnInfoClick(Sender: TObject);
begin
 //
 ShowMessage(DM.conORM_FD.Params.Text);
end;

procedure TfoGeraClasse.btnConexaoClick(Sender: TObject);
begin
  try
    with DM do
    if DM.conORM_FD.Connected  then
    begin

      conORM_FD.Connected := False;
      lstTabelas.Clear;
      if mmGerarCLass.Lines.Count > 0 then
      begin
        if MessageDlg('Deseja salvar o arquivo gerado?',mtInformation,mbYesNo,0) = mrNo then
          mmGerarCLass.Clear
        else
         SalvarArquivo;
      end;

    end
    else
    begin
      conORM_FD.Params.Database := Trim(edBD.Text);
      conORM_FD.Connected := True;
      PegaTabelas;
    end;


    AtualizaBotao;

  except on E: Exception do
         begin
           ShowMessage(E.Message);
           AtualizaBotao;
         end;

  end;
end;

procedure TfoGeraClasse.btnExecPackageClick(Sender: TObject);
var
  Atributos: IAtributos;
  Campo: string;
  PropRtti: TRttiProperty;
  RttiType: TRttiType;
  sText, Sep1, Sep2: string;

begin
  mmGerarSQL.Clear;
  try
    sText := 'CREATE TABLE ' + UpperCase(copy(TPerfilEmail.ClassName,2,length(TPerfilEmail.ClassName)))  + ' (';
    mmGerarSQL.Lines.Add('CREATE TABLE ' + UpperCase(copy(TPerfilEmail.ClassName,2,length(TPerfilEmail.ClassName))) + ' (');

    RttiType := TRttiContext.Create.GetType(TPerfilEmail);
    Sep1 := '';
    Sep2 := ' ';
    for PropRtti in RttiType.GetProperties do
    begin
    Sep1 := ',';
      case PropRtti.PropertyType.TypeKind of
        tkInt64:begin
                  sText := sText + PropRtti.Name+Sep2+'BIGINT'+Sep1;
                  mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'BIGINT'+Sep1)
                end;

        tkInteger: begin
                     sText := sText + PropRtti.Name+Sep2+'INTEGER'+Sep1;
                      mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'INTEGER'+Sep1);
                   end;

        tkChar: begin
                  sText := sText + PropRtti.Name+Sep2+'CHAR'+Sep1;
                  mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'CHAR'+Sep1);
                end;

        tkString, tkUString:
                begin
                  sText := sText + PropRtti.Name+Sep2+'VARCHAR()'+Sep1;
                  mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'VARCHAR()'+Sep1);
                end;

        tkFloat:
        begin
          if CompareText(PropRtti.PropertyType.Name, 'TDate') = 0 then
          begin
            sText := sText + PropRtti.Name+Sep2+'DATE'+Sep1;
            mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'DATE'+Sep1);
          end
          else
          if CompareText(PropRtti.PropertyType.Name, 'TDateTime') = 0 then
          begin
            sText := sText + PropRtti.Name+Sep2+'DATE'+Sep1;
            mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'DATE'+Sep1);
          end
          else
          begin
            sText := sText + PropRtti.Name+Sep2+'DECIMAL(15,2)'+Sep1;
            mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'DECIMAL(15,2)'+Sep1);
          end;
        end;

        tkVariant: ShowMessage(PropRtti.Name +' tkVariant: '+ PropRtti.PropertyType.Name);

        tkEnumeration: if CompareText(PropRtti.PropertyType.Name, 'Boolean') = 0 then
                       begin
                         sText := sText + PropRtti.Name+Sep2+'SMALINT'+Sep1;
                         mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'DECIMAL(15,2)'+Sep1);
                       end;

        tkClass : if CompareText(PropRtti.PropertyType.Name, 'TFileStream') = 0 then
                  begin
                    sText := sText + PropRtti.Name+Sep2+'BLOB SUB_TYPE 1 SEGMENT SIZE 80'+Sep1;
                    mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'BLOB SUB_TYPE 1 SEGMENT SIZE 80'+Sep1);
                  end
                  else
                  begin
                    sText := sText + PropRtti.Name+Sep2+'BLOB SUB_TYPE 0 SEGMENT SIZE 80'+Sep1;
                    mmGerarSQL.Lines.Add(PropRtti.Name+Sep2+'BLOB SUB_TYPE 0 SEGMENT SIZE 80'+Sep1);
                  end
      else
        raise Exception.Create('Tipo de campo não conhecido: ' +
        PropRtti.PropertyType.ToString);
      end;

      sText := sText + ')';
      mmGerarSQL.Lines.Add(')');
    end;
    mmGerarSQL.Text := sText;
    pgc1.ActivePage := tsClass;
  except
    raise;
  end;
end;

procedure TfoGeraClasse.btnGerarClick(Sender: TObject);
begin
   if pgc1.ActivePage = tsSQL then
     mmGerarSQL.lines.Text := DM.Dao.GerarClasse;
   else
   if pgc1.ActivePage = tsClass then
   begin
     if DM.conORM_FD.Connected then
       GeraClasse
     else
       ShowMessage('Base de Dados '+QuotedStr(ExtractFileName(edBD.Text))+ ' não Conectado!');
   end;
end;

procedure TfoGeraClasse.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfoGeraClasse.btnSalvarClick(Sender: TObject);
begin
  SalvarArquivo;
end;

procedure TfoGeraClasse.CarregaDLL;
var iHandle : THandle;
    aClasse : TObject;
begin
  iHandle := LoadLibrary('DLL1.dll');

  if iHandle <>  0 then
  begin
    aClasse := TObject(GetProcAddress(iHandle, 'TPerfilEmail'));
  end;
end;

procedure TfoGeraClasse.CarregaPKG;
var
Plugin : TObject;
Hnd : THandle;
sFile: string;
aClass : TPersistentClass;
begin
  dlgOpen1.FilterIndex := 3;
  dlgOpen1.InitialDir := ExtractFileDir(ParamStr(0));
  if dlgOpen1.Execute then
    sFile := dlgOpen1.FileName;

  if FileExists(sFile) then
  begin
    //-- Carrega o pacote
    Hnd := LoadPackage(sFile);

    if Hnd > 0 then
    begin
      aClass := GetClass('TUsuarios');
      if Assigned(aClass) then
      begin
        //-- Cria um objeto da classe do plugin
        Plugin := aClass.Create;
        ShowMessage(Plugin.ClassName);
//        Button1.Action := TPlugin(Plugin).Action;
//        Button1.Caption := TPlugin(Plugin).Caption;
      end;

      aClass := GetClass('TPerfilEmail');
      if Assigned(aClass) then
      begin
        //-- Cria um objeto da classe do plugin
        Plugin := aClass.Create;
        ShowMessage(Plugin.ClassName);
//        Button1.Action := TPlugin(Plugin).Action;
//        Button1.Caption := TPlugin(Plugin).Caption;
      end;
    end;
  end;
end;


procedure TfoGeraClasse.FormCreate(Sender: TObject);
begin
  //
  dm.conORM_FD.Connected := False;
  SplitView := TSplitView.Create(pnlConfig);
  SplitView.UseAnimation := True;
  SplitView.CloseStyle := svColapse;
  SplitView.Colapse;
end;

procedure TfoGeraClasse.FormShow(Sender: TObject);
begin

  AtualizaBotao;
  lstTabelas.Items.Clear;

end;

procedure TfoGeraClasse.GeraClasse;
var
  Unidade,
  Tabela,
  Classe: string;
begin
  if lstTabelas.Count = 0 then
    Exit;

  Tabela  := trim(lstTabelas.Items[lstTabelas.ItemIndex]);
  Unidade := Tabela;
  Classe  := Tabela;

  mmGerarCLass.lines.Text := DM.Dao.GerarClasse(Tabela, Unidade, Classe);

end;

procedure TfoGeraClasse.GeraSQL;
begin
//
end;

procedure TfoGeraClasse.moClick(Sender: TObject);
begin
  SplitView.MoveSplitView;
end;

procedure TfoGeraClasse.opcLimparPasClick(Sender: TObject);
begin
  if mmGerarCLass.Lines.Count > 0 then
  begin
    if MessageDlg('Deseja salvar o arquivo gerado?',mtInformation,mbYesNo,0) = mrNo then
      mmGerarCLass.Clear
    else
     SalvarArquivo;
  end;
end;

procedure TfoGeraClasse.opcLimpartabelaClick(Sender: TObject);
begin
  lstTabelas.Clear;
end;

procedure TfoGeraClasse.PegaTabelas;
const
  SQL: string = 'SELECT RDB$RELATION_NAME FROM RDB$RELATIONS ' +
                'WHERE RDB$VIEW_BLR IS NULL and ' +
                '(RDB$SYSTEM_FLAG = 0 OR RDB$SYSTEM_FLAG IS NULL) ' +
                'ORDER BY 1';

//  SQL: string =  'SHOW TABLES';
begin
  lstTabelas.Items.Clear;

  with DM.Dao.ConsultaSql(SQL) do
  begin
    while not EOF do
    begin
      if not (Copy(Fields[0].AsString,1,4) = 'IBE$') then
        lstTabelas.Items.Add(Fields[0].AsString);
      Next;
    end;
  end;

  lstTabelas.ItemIndex := 0;
end;

procedure TfoGeraClasse.SalvarArquivo;
var
  Arquivo: string;
begin
  if mmGerarCLass.lines.Count = 0 then
    Exit;

  Arquivo := Copy(mmGerarCLass.Lines[0], 6);
  Arquivo := Copy(Arquivo, 1, pos(';', Arquivo) - 1) + '.pas';

  Salvar.FileName := Arquivo;

  if Salvar.Execute then
  begin
    mmGerarCLass.Lines.SaveToFile(Salvar.FileName);
    ShowMessage('Arquivo Salvo com sucesso!');
  end;
end;

end.
