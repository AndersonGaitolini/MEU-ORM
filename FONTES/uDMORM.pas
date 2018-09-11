unit uDMORM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Comp.Client, Data.DB,Vcl.Dialogs,
  DaoFD;

type
  TDao<T:Class> = class
  private
    FConnection : T;
    fConFD   : TFDConnection;
    procedure SetConnection(prValue: T);
    property Connection: T read FConnection write SetConnection;
  public

  end;

  TDM = class(TDataModule)
    conORM_FD: TFDConnection;
    tranORM: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }


  public
    { Public declarations }
    Dao: TDaoFD;
    DaoFD: TDao<TDaoFD>;
    end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  Dao := TDaoFD.Create(conORM_FD, tranORM);
end;

{ TDao<T> }

procedure TDao<T>.SetConnection(prValue: T);
begin
  FConnection := prValue;
end;

end.
