unit uValidateLocs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, Buttons;

type
  TfrmValidateLocs = class(TForm)
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmValidateLocs: TfrmValidateLocs;

implementation

uses udmAddNewProduct;

{$R *.DFM}

end.
