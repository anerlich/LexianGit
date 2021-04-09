unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, ExtCtrls, DBCtrls, DBGrids, StdCtrls, Buttons,
  CustomGrid1;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    GroupBox5: TGroupBox;
    DBLookupComboBox1: TDBLookupComboBox;
    GroupBox4: TGroupBox;
    Edit2: TEdit;
    BitBtn8: TBitBtn;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBGrid2: TDBGrid;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FirstShow:Boolean;
    procedure ShowParameters;
    procedure DeleteRow(aRow:Integer);
    procedure DeleteAllRows;
    function FindRow(TgtLoc,TgtProd:String):Boolean;
    procedure CloseSales;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses udmData, uStatus;

{$R *.dfm}

procedure TfrmMain.BitBtn8Click(Sender: TObject);
var
  Save_Cursor:TCursor;
Begin
  Save_Cursor := Screen.Cursor;

  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try
    dmData.GetSrcProdList(Edit2.Text);
  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;

end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  Col:Integer;
begin
  if FirstShow then
  begin
    dmData.OpenData;
    StatusBar1.Panels[1].Text := dmData.DbDescription;


    dmData.openPeriod;
    With dmData.srcPeriod.DataSet do
    begin
      First;
      Col := 0;

      While not Eof do
      begin
        dbGrid2.Columns.Items[Col].Title.Caption := FieldByName('Description').AsString;
        dbGrid2.Columns.Items[Col].FieldName := 'SalesAmount_'+IntToStr(Col);
        Next;
        Inc(Col);

        if Col > 40 then
          break;

      end;

      Close;

    end;

    FirstShow := False;

  end;


end;

procedure TfrmMain.DBGrid1CellClick(Column: TColumn);
begin
  Edit2.Text := dmData.qrySrcProd.fieldByName('ProductCode').asString;
  dmData.OpenSales;
  Label1.Caption := dmData.qrySrcProd.fieldByName('ProductCode').asString;
  Label2.Caption := dmData.qrySrcProd.fieldByName('ProductDescription').asString;

end;

procedure TfrmMain.ShowParameters;
begin
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmMain.DeleteRow(aRow: Integer);
begin
end;

procedure TfrmMain.DeleteAllRows;
begin

end;

function TfrmMain.FindRow(TgtLoc, TgtProd: String): Boolean;
begin
end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
  dmData.srcSales.DataSet.Post;


end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
begin
  dmData.srcSales.DataSet.Cancel;

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmData.CommitData;
end;

procedure TfrmMain.CloseSales;
begin
  dmData.srcSales.DataSet.Close;
  Label1.Caption := '';
  Label2.Caption := '';
end;

end.
