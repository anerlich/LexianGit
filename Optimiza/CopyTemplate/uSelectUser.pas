unit uSelectUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls;

type
  TfrmSelectUser = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MultiSelectOn(SelectOn:Boolean);
  end;

var
  frmSelectUser: TfrmSelectUser;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmSelectUser.FormShow(Sender: TObject);
begin

    dmData.OpenUser;
                           
end;

procedure TfrmSelectUser.MultiSelectOn(SelectOn: Boolean);
begin
  if SelectOn then
  begin
    dbGrid1.Options := [dgTitles,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgConfirmDelete,dgCancelOnExit,dgMultiSelect];
    Label1.Visible := True;
  end
  else
  begin
    dbGrid1.Options := [dgTitles,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgConfirmDelete,dgCancelOnExit];
    Label1.Visible := False;
  end;

end;

end.
