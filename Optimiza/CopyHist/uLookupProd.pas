unit uLookupProd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, StdCtrls, Buttons, Grids, DBGrids, MyDBGrid;

type
  TfrmLookupProduct = class(TForm)
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    DBNavigator1: TDBNavigator;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure MyDBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit2DragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLookupProduct: TfrmLookupProduct;

implementation

uses uDmCopySalesHist;


{$R *.DFM}

procedure TfrmLookupProduct.BitBtn1Click(Sender: TObject);
begin
  DmCopySalesHist.OpenSearchProd(Edit1.text);
end;

procedure TfrmLookupProduct.Edit1Exit(Sender: TObject);
begin
  Edit1.text := UpperCase(Edit1.text);
end;

procedure TfrmLookupProduct.Button1Click(Sender: TObject);
begin
  Edit2.Text := dbgrid1.DataSource.DataSet.FieldbyName('ProductCode').AsString;
end;

procedure TfrmLookupProduct.Button2Click(Sender: TObject);
begin
  Edit3.Text := dbgrid1.DataSource.DataSet.FieldbyName('ProductCode').AsString;

end;

procedure TfrmLookupProduct.DBGrid1DblClick(Sender: TObject);
begin
  if Edit2.Text = '' then
  begin
    Edit2.Text := dbgrid1.DataSource.DataSet.FieldbyName('ProductCode').AsString;
  end
  else
  begin
    Edit3.Text := dbgrid1.DataSource.DataSet.FieldbyName('ProductCode').AsString;
  end;
end;

procedure TfrmLookupProduct.Edit2DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TfrmLookupProduct.MyDBGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//MyDBGrid1.BeginDrag(False,10);
end;

procedure TfrmLookupProduct.Edit2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
//  Edit2.text := MyDBGrid1.DataSource.DataSet.fieldbyname('ProductCode').asString;
end;

end.
