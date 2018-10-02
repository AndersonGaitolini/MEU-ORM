unit PanelSplitViewFMX;

interface

uses
  FMX.ExtCtrls,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ActnList, FMX.StdActns, System.Actions,
  FMX.TabControl, FMX.Layouts, FMX.Ani, System.ImageList, FMX.ImgList;

type
  TSVCloseStyle = (svColapse, svCompact);
  TSVPlacement = (svLeft, svRight);
  TSVViewState = (Colapsado, Expandido);

  TPanelSplitView = class(TPanel)
  private
    { Private declarations }
  fSplitViewState     : TSVViewState; // Estado do SplitView
  fSaveWidthSplitView : Single;      // Tamanho do painel antes de estar colapsado
  fImageVisibleWidth  : Integer;      // Tamanho das impagens visiveis quando o closeStyle = Compact
  fUseAnimation       : Boolean;      // Anima o recolhimento/Expansão ou não
  fPlacement          : TSVPlacement; // Local do Split View
  fCloseStyle         : TSVCloseStyle; // Modo de Fechamento (Compact ou Colapse)

  procedure SetCloseStyle (CloseStyle : TSVCloseStyle);
  procedure SetPlacement (aPlacement : TSVPlacement);
  procedure SetAnimation (Animation : Boolean);
  procedure SetViewState (aViewState : TSVViewState);

  protected
    { Protected declarations }
  procedure Colapse;
  procedure Expand;

  public
    { Public declarations }
  constructor  Create (aPanel : TPanel); overload;
  procedure  MoveSplitView;

  published
    { Published declarations }
  property SplitViewState     : TSVViewState read fSplitViewState write SetViewState;
  property SaveWidthSplitView : Single read fSaveWidthSplitView write fSaveWidthSplitView;
  property ImageVisibleWidth  : Integer read fImageVisibleWidth write fImageVisibleWidth;
  property UseAnimation       : Boolean read fUseAnimation write SetAnimation;
  property Placement          : TSVPlacement read fPlacement write SetPlacement;
  property CloseStyle         : TSVCloseStyle read fCloseStyle write SetCloseStyle;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TPanelSplitView]);
end;

procedure TPanelSplitView.SetCloseStyle (CloseStyle : TSVCloseStyle);
begin
     if CloseStyle = svCompact Then
        ImageVisibleWidth := 50
     else
        ImageVisibleWidth := 0;
End;

procedure TPanelSplitView.SetPlacement (aPlacement : TSVPlacement);
begin
     fPlacement := aPlacement;
     if aPlacement = svLeft then
        Align := TAlignLayout.Left
     else
        Align := TAlignLayout.Right;
end;

procedure TPanelSplitView.SetAnimation (Animation : Boolean);
begin
     fUseAnimation := Animation;
end;

procedure TPanelSplitView.SetViewState (aViewState : TSVViewState);
begin
     fSplitViewState := aViewState;
end;

procedure TPanelSplitView.Colapse;
Var
     Cont : Integer;
Begin
     SaveWidthSplitView := Width;
     if UseAnimation then
     Begin
        for Cont := 1 to Trunc(Width) - ImageVisibleWidth do
        begin
            Width := Width - 1;
            Application.ProcessMessages;
        end;
     End
     else
     begin
        Width := ImageVisibleWidth;
     end;
     SplitViewState := Colapsado;
End;

constructor TPanelSplitView.Create(aPanel: TPanel);
begin
  Width := 80;
  Align := TAlignLayout.Left;
  SetViewState (Expandido);
  SetAnimation (True);
  SetCloseStyle (svColapse);
end;

procedure TPanelSplitView.Expand;
Var
     Cont : Integer;
Begin
     if UseAnimation then
     Begin
        for Cont := 1 to Trunc(SaveWidthSplitView) - ImageVisibleWidth do
        begin
            Width := Width + 1;
            Application.ProcessMessages;
        end;
     End
     ELse
     Begin
        SetPlacement(fPlacement);
        Width := SaveWidthSplitView;
     End;
     SplitViewState := Expandido;
End;


procedure TPanelSplitView.MoveSplitView;
begin
     if SplitViewState = Expandido then
        Colapse
     else
        Expand;
end;
end.
