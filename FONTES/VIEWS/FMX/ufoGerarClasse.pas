unit ufoGerarClasse;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Layouts,
  FMX.ListBox,
  FMX.TabControl,
  FMX.Edit, Winapi.Windows;

type
  TForm1 = class(TForm)
    pnlRodape: TPanel;
    pnlHeader: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    pnlMenu: TPanel;
    pnlMain: TPanel;
    tab1: TTabControl;
    tabGeraClasse: TTabItem;
    lstTabelas: TListBox;
    mmGerarCLass: TMemo;
    swtConexao: TSwitch;
    edFileBD: TEdit;
    btnOpen: TSpeedButton;
    btnGerar: TButton;
    btnSalvar: TButton;
    tabGeraSQL: TTabItem;
    lstClasses: TListBox;
    mmGerarSQL: TMemo;
    cbDescrToTypes: TCheckBox;
    cbSmlIntToBool: TCheckBox;
    dlgOpen1: TOpenDialog;
    dlgSalvar: TSaveDialog;
    procedure btnGerarClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure swtConexaoSwitch(Sender: TObject);
  private
    { Private declarations }
    procedure GerarSQL;
    procedure GerarClasse;
    procedure CarregaDLL;
    procedure PreencheClasses;
    procedure PreencheTabelas;
    procedure SalvarArquivo;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  DaoFD, GerarClasse.BancoFirebird, GerarClasseFireDac, GerarSQL.BancoFireBird, uDMORM, Atributos, Base, GerarClasse;

{$R *.fmx}

procedure TForm1.btnGerarClick(Sender: TObject);
begin
   if tab1.ActiveTab = tabGeraSQL then
     GerarSQL
   else
   if tab1.ActiveTab = tabGeraClasse then
   begin
     if DM.conORM_FD.Connected then
       GerarClasse
     else
       ShowMessage('Base de Dados '+QuotedStr(ExtractFileName(edFileBD.Text))+ ' não Conectado!');
   end;
end;


procedure TForm1.btnOpenClick(Sender: TObject);
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

procedure TForm1.GerarClasse;
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

  mmGerarCLass.lines.Text := DM.Dao.GerarClasse(Tabela, Unidade, Classe, cbDescrToTypes.IsChecked, cbSmlIntToBool.IsChecked);

end;

procedure TForm1.GerarSQL;
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

procedure TForm1.swtConexaoSwitch(Sender: TObject);
begin
 try
    with DM do
    if DM.conORM_FD.Connected  then
    begin

      conORM_FD.Connected := False;
      lstTabelas.Clear;
      if mmGerarCLass.Lines.Count > 0 then
      begin
//        if MessageDlg('Deseja salvar o arquivo gerado?',mtInformation,mbYesNo,0) = mrNo then
//          mmGerarCLass.Clear
//        else
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


//    AtualizaBotao;

  except on E: Exception do
         begin
           ShowMessage(E.Message);
//           AtualizaBotao;
         end;

  end;
end;

procedure TForm1.CarregaDLL;
var iHandle : THandle;
    aClasse : TObject;
begin
  iHandle := LoadLibrary('DLL1.dll');

  if iHandle <>  0 then
  begin
    aClasse := TObject(GetProcAddress(iHandle, 'TPerfilEmail'));
  end;
end;

procedure TForm1.SalvarArquivo;
var
  Arquivo: string;
begin
  if mmGerarCLass.lines.Count = 0 then
    Exit;

  Arquivo := Copy(mmGerarCLass.Lines[0], 6);
  Arquivo := Copy(Arquivo, 1, pos(';', Arquivo) - 1) + '.pas';

  dlgSalvar.FileName := Arquivo;

  if dlgSalvar.Execute then
  begin
    mmGerarCLass.Lines.SaveToFile(dlgSalvar.FileName);
    ShowMessage('Arquivo Salvo com sucesso!');
  end;
end;

procedure TForm1.PreencheClasses;
var GerarSQLFB : TGerarSQLBancoFirebird;
    Lista : TStrings;
    aFile : string;
    I: integer;
begin
//   lstClasses.Items.Clear;
//   Lista := TStrings.Create;
//   GerarSQLFB := TGerarSQLBancoFirebird.Create;
//   try
//     try
//       aFile := '';
//       if FileExists(Trim(edFileClass.Text))  then
//        aFile :=  ChangeFileExt(ExtractFileName(Trim(edFileClass.Text)),EmptyStr);
//
//       Lista := GerarSQLFB.ListaofClass(aFile);
//       for I := 0 to Lista.Count-1 do
//         lstClasses.Items.Add(Lista.Strings[i]);
//
//       lstClasses.ItemIndex := 0;
//       mmGerarSQL.Lines.Text := GerarSQLFB.GeraSqlCreateTable(TTabela(lstClasses.Items[lstClasses.ItemIndex]));
//     finally
//       GerarSQLFB.Free;
//     end;
//   except
//
//   end;


end;

procedure TForm1.PreencheTabelas;
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

end.
