unit uCopySalesHist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, DBCtrls, CheckLst, Buttons, ExtCtrls, Grids, DBGrids,
  MyDBGrid, db;

type
  TfrmCopySalesHist = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    CheckListBox1: TCheckListBox;
    TabSheet2: TTabSheet;
    BitBtn4: TBitBtn;
    StringGrid1: TStringGrid;
    BitBtn5: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCopySalesHist: TfrmCopySalesHist;
  FirstShow:Boolean;

implementation

uses uDmCopySalesHist, uLookupProd;

{$R *.DFM}

procedure TfrmCopySalesHist.FormShow(Sender: TObject);
begin

  if FirstShow then
  begin
    StatusBar1.Panels[1].Text := dmCopySalesHist.dbOptimiza.DatabaseName;

    CheckListBox1.Items.Clear;

    with dmCopySalesHist.srcAllLocations.DataSet do
    begin
      First;
      while not eof do
      begin

      ChecklistBox1.Items.Add(FieldByName('LocationCode').AsString + ' - ' + FieldByName('Description').AsString);
        next;
      end;

      first;


    end;

  end;

  PageControl1.ActivePage := TabSheet1;

  StringGrid1.Cells[0,0] := 'Source';
  StringGrid1.Cells[1,0] := 'Target';

  FirstShow := False;

end;

procedure TfrmCopySalesHist.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmCopySalesHist.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCopySalesHist.BitBtn5Click(Sender: TObject);
begin
  if frmLookupProduct.ShowModal = mrOK then
  begin
    if StringGrid1.Cells[0,StringGrid1.RowCount-1] <> '' then
      StringGrid1.RowCount := StringGrid1.RowCount + 1;

    StringGrid1.Cells[0,StringGrid1.RowCount-1] := frmLookupProduct.Edit2.Text;
    StringGrid1.Cells[1,StringGrid1.RowCount-1] := frmLookupProduct.Edit3.Text;
    StringGrid1.Refresh;
  end;
end;

procedure TfrmCopySalesHist.BitBtn4Click(Sender: TObject);
var
  DeleteRow, Count: Integer;
begin
  DeleteRow := StringGrid1.Row;

  If DeleteRow > 0 then
  begin
    StringGrid1.Cells[0,DeleteRow] := '';
    StringGrid1.Cells[1,DeleteRow] := '';
  end;

  if StringGrid1.RowCount  > 2 then
  begin
    For Count := DeleteRow to StringGrid1.RowCount do
    begin
      StringGrid1.Rows[Count] := StringGrid1.Rows[Count+1];
    end;

    StringGrid1.RowCount := StringGrid1.RowCount -1;
  end;

end;

end.
