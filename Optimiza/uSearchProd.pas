unit uSearchProd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls;

type
  TfrmSearch = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearch: TfrmSearch;

implementation

uses uDmUpdateSpecial;

{$R *.DFM}

procedure TfrmSearch.Button1Click(Sender: TObject);
begin
  dmUpdateSpecial.OpenSearchProd(Edit1.text);
end;

procedure TfrmSearch.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
