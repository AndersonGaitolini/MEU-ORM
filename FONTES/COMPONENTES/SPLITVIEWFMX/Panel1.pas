unit Panel1;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TPanelSplitView = class(TPanel)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TPanelSplitView]);
end;

end.
