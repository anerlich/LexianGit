unit uSelectUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Data.DB;

type
  TfrmSelectUser = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelectUser: TfrmSelectUser;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmSelectUser.FormShow(Sender: TObject);
begin

    if not dmData.qryUser.Active then
      dmData.qryUser.Open;

end;

end.
