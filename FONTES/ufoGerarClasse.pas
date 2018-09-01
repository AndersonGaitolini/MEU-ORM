unit ufoGerarClasse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  JvExControls, JvSwitch, Vcl.Menus, SplitView, Vcl.ComCtrls, System.Rtti,
  Base, GerarSQL.BancoFireBird, JvBaseDlg, JvSelectDirectory;

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
    edFileBD: TLabeledEdit;
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
    edFileClass: TLabeledEdit;
    btnGetFileClass: TSpeedButton;
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
    procedure btnGetFileClassClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaBotao;
    procedure PreencheTabelas;
    procedure PreencheClasses;
    procedure GeraClasse;
    procedure SalvarArquivo;
    procedure GeraSQL;

  public
    { Public declarations }
    SplitView : TSplitView;

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
  if DirectoryExists(ExtractFileDir(Trim(edFileBD.Text))) then
    dlgOpen1.InitialDir := Trim(edFileBD.Text)
  else
    dlgOpen1.InitialDir := ExtractFileDir(ParamStr(0));

  dlgOpen1.FilterIndex := 2;

  if dlgOpen1.Execute then
   edFileBD.Text := dlgOpen1.FileName;

  if edFileBD.CanFocus then
   edFileBD.SelStart := Length(Trim(edFileBD.Text));
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
      conORM_FD.Params.Database := Trim(edFileBD.Text);
      conORM_FD.Connected := True;
      PreencheTabelas;
      PreencheClasses;
    end;


    AtualizaBotao;

  except on E: Exception do
         begin
           ShowMessage(E.Message);
           AtualizaBotao;
         end;

  end;
end;

procedure TfoGeraClasse.btnGerarClick(Sender: TObject);
begin
   if pgc1.ActivePage = tsSQL then
     GeraSQL
   else
   if pgc1.ActivePage = tsClass then
   begin
     if DM.conORM_FD.Connected then
       GeraClasse
     else
       ShowMessage('Base de Dados '+QuotedStr(ExtractFileName(edFileBD.Text))+ ' não Conectado!');
   end;
end;

procedure TfoGeraClasse.btnGetFileClassClick(Sender: TObject);
begin

  if DirectoryExists(ExtractFileDir(Trim(edFileClass.Text))) then
    dlgOpen1.InitialDir := Trim(edFileClass.Text)
  else
    dlgOpen1.InitialDir := ExtractFileDir(ParamStr(0));

  dlgOpen1.FilterIndex := 3;
  if dlgOpen1.Execute then
  begin
    edFileClass.Clear;
    edFileClass.Text := dlgOpen1.FileName;
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
var GerarSQLFB : TGerarSQLBancoFirebird;
    Tabela : string;
    Banco  : string;
begin
   GerarSQLFB := TGerarSQLBancoFirebird.Create;
   try
     try

       Tabela := lstClasses.items[lstClasses.ItemIndex];
       Tabela := GerarSQLFB.GeraSqlCreateTable(TTabela(Tabela));
       mmGerarSQL.Lines.Text := Tabela;
     finally
       GerarSQLFB.Free;
     end;
   except on E: Exception do
   end;
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
  lstClasses.Clear;
end;

procedure TfoGeraClasse.PreencheClasses;
var GerarSQLFB : TGerarSQLBancoFirebird;
    Lista : TStrings;
    aFile : string;
    I: integer;
begin
   lstClasses.Items.Clear;
   Lista := TStrings.Create;
   GerarSQLFB := TGerarSQLBancoFirebird.Create;
   try
     try
       aFile := '';
       if FileExists(Trim(edFileClass.Text))  then
        aFile :=  ChangeFileExt(ExtractFileName(Trim(edFileClass.Text)),EmptyStr);

       Lista := GerarSQLFB.ListaofClass(aFile);
       for I := 0 to Lista.Count-1 do
         lstClasses.Items.Add(Lista.Strings[i]);

       lstClasses.ItemIndex := 0;
       mmGerarSQL.Lines.Text := GerarSQLFB.GeraSqlCreateTable(TTabela(lstClasses.Items[lstClasses.ItemIndex]));
     finally
       GerarSQLFB.Free;
     end;
   except

   end;


end;

procedure TfoGeraClasse.PreencheTabelas;
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
