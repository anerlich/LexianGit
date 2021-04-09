unit uUpdateMultipleForecast;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, DBCtrls, CheckLst, Buttons, ExtCtrls, Grids, DBGrids,
  MyDBGrid, db, iniFiles;

type
  TfrmUpdateForecast = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    TabSheet2: TTabSheet;
    BitBtn4: TBitBtn;
    StringGrid1: TStringGrid;
    BitBtn5: TBitBtn;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MyDBGrid1: TMyDBGrid;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    BitBtn6: TBitBtn;
    TabSheet3: TTabSheet;
    grpMonth: TRadioGroup;
    BitBtn7: TBitBtn;
    OpenDialog1: TOpenDialog;
    ListBox1: TListBox;
    StringGrid2: TStringGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    SpeedButton5: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure StringGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure StringGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MyDBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure StringGrid2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure StringGrid2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    { Private declarations }
   procedure MoveToString;
  public
    { Public declarations }
  end;

var
  frmUpdateForecast: TfrmUpdateForecast;
  FirstShow:Boolean;
  TheCopyFile: Tinifile;

implementation

uses uStatus, uHelp, uDmUpdateForecast, uEdit;

{$R *.DFM}

procedure TfrmUpdateForecast.FormShow(Sender: TObject);
var
  TheCopyFileName: String;
  FileHandle: Integer;
begin

  if FirstShow then
  begin
    StatusBar1.Panels[1].Text := dmUpdateForecast.dbOptimiza.DatabaseName;

    ListBox1.Items.Clear;

    with dmUpdateForecast.srcAllLocations.DataSet do
    begin
      First;
      while not eof do
      begin

      listBox1.Items.Add(FieldByName('LocationCode').AsString + ' - ' + FieldByName('Description').AsString);
        next;
      end;

      first;


    end;

    TheCopyFileName := ExtractFilePath(ParamStr(0))+'SourceLocations.txt';

    //if it doesn't exist first create
    if not FileExists(TheCopyFileName) then
    begin
      FileHandle := FileCreate(theCopyFileName);
      FileClose(FileHandle);
    end;
    
    StringGrid1.Cols[0].LoadFromFile(TheCopyFileName);

    PageControl1.ActivePage := TabSheet3;

    StringGrid1.Cells[0,0] := 'Products';

    StringGrid2.Cells[0,0] := 'Locations';
    StringGrid2.Cells[1,0] := 'Update %';

    Listbox1.ItemIndex := 0;

    ComboBox1.Items.Clear;

    With dmUpdateForecast.srcPeriod.DataSet do
    begin
      First;

      While not Eof do
      begin
        ComboBox1.Items.Add(FieldbyName('Description').asString);
        Next;
      end;

      Close;

      ComboBox1.Text := ComboBox1.Items.Strings[0];
      ComboBox1.ItemIndex := 0;

    end;

    FirstShow := False;
  end;

end;

procedure TfrmUpdateForecast.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmUpdateForecast.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmUpdateForecast.BitBtn5Click(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
  StringGrid1.Cells[0,StringGrid1.RowCount-1] :=
    MyDbGrid1.DataSource.DataSet.FieldbyName('ProductCode').AsString;

end;

procedure TfrmUpdateForecast.BitBtn4Click(Sender: TObject);
var
  DeleteRow, Count: Integer;
begin
  DeleteRow := StringGrid1.Row;

  If DeleteRow > 0 then
  begin
    StringGrid1.Cells[0,DeleteRow] := '';
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

procedure TfrmUpdateForecast.BitBtn1Click(Sender: TObject);
var
  MonthCount, Offset, CountItem, CountLoc: Integer;
  TheCopyFileName, LocCode, FreezeInd,AddInd,ProdCode: String;
  Perc: Real;


begin

  TheCopyFileName := ExtractFilePath(ParamStr(0))+'UpdateLocations.txt';

  StringGrid1.Cols[0].SaveToFile(TheCopyFileName);

  frmStatus.ListBox1.Items.Add('Started...');
  frmStatus.ListBox1.Items.Add('Product List Saved to :'+TheCopyFileName);


  FreezeInd := 'N';

  MonthCount := 6;

  Case grpMonth.ItemIndex  of
    0: MonthCount := 1;
    1: MonthCount := 3;
    2: MonthCount := 6;
    3: MonthCount := 12;
    4: MonthCount := 18;
    5: MonthCount := 24;
  end;

  frmStatus.ListBox1.Items.Add('Months forecast: ' +intTostr(MonthCount));
  frmStatus.ListBox1.Items.Add('Starting Months : '+Combobox1.text);
  frmStatus.ListBox1.Items.Add('Locations: ');


  for CountItem := 1 to StringGrid2.RowCount -1 do
  begin
       LocCode := Trim(Copy(StringGrid2.Cells[0,CountItem],1,Pos('-',StringGrid2.Cells[0,CountItem])-1));

       frmStatus.ListBox1.Items.Add(LocCode + ':'+StringGrid2.Cells[1,CountItem]+'%');
  end;

  frmStatus.ListBox1.Items.Add('-------------------');

  Offset := ComboBox1.ItemIndex;

  if  Offset < 0 then
  begin
    frmStatus.ListBox1.Items.Add('*** Invalid Starting Month ***');
  end
  else
  begin

    for CountLoc := 1 to StringGrid2.RowCount -1 do
    begin

      LocCode := Trim(Copy(StringGrid2.Cells[0,CountLoc],1,Pos('-',StringGrid2.Cells[0,CountLoc])-1));


      for CountItem := 1 to StringGrid1.RowCount -1 do
      begin

       ProdCode := Trim(StringGrid1.Cells[0,CountItem]);

       if ProdCode <> '' then
       begin

         if dmUpdateForecast.CheckTarget(LocCode,StringGrid1.Cells[0,CountItem]) then
         begin
           dmUpdateForecast.UpdateFC(LocCode, StringGrid1.Cells[0,CountItem],
                                       FreezeInd, MonthCount,Offset, Perc );
         end;

       end;

      end;

    end;

  end;

  if (StringGrid2.RowCount > 1) and (CountItem > 1) then
   dmUpdateForecast.CommitFc
  else
     frmStatus.ListBox1.Items.Add('No Forecast Updated !');



  frmStatus.Show;

end;

procedure TfrmUpdateForecast.Edit1Exit(Sender: TObject);
begin
  Edit1.text := UpperCase(Edit1.text);

end;

procedure TfrmUpdateForecast.BitBtn3Click(Sender: TObject);
begin
  dmUpdateForecast.OpenSearchProd(Edit1.text);

end;

procedure TfrmUpdateForecast.StringGrid1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := True;
end;

procedure TfrmUpdateForecast.StringGrid1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  MCord: TGridCoord;
  StringRow, StringCol: Integer;
begin
  //Get Cell under mouse pointer
  MCord := StringGrid1.MouseCoord(X,Y);
  StringCol := 0;

  //if co-ordinates are outside the range then
  // use physical x,y to detemine which column to add
  //  new record
  if (MCord.x < 0) or (MCord.Y < 1) then
  begin

    if StringGrid1.Cells[StringCol,StringGrid1.RowCount-1] <> '' then
    begin
        StringGrid1.RowCount := StringGrid1.RowCount + 1;
    end;

    StringRow := StringGrid1.RowCount - 1;

  end
  else
  begin
    StringRow := MCord.Y;
  end;

  try
    StringGrid1.Cells[StringCol, StringRow] := MyDBGrid1.DataSource.DataSet.FieldByName('ProductCode').AsString;
  except
    MessageDlg('Invalid Product Code',mtError,[mbOK],0);
  end;


end;

procedure TfrmUpdateForecast.MyDBGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Getx, Gety: Integer;
begin
  Getx := x;
  Gety := y;
  MyDBGrid1.BeginDrag(False,10);
end;

procedure TfrmUpdateForecast.BitBtn6Click(Sender: TObject);
begin
  frmHelp.ShowModal;
end;

procedure TfrmUpdateForecast.BitBtn7Click(Sender: TObject);
var
  fCount:Integer;
  InFile:TextFile;
  Data:String;
begin

  if OpenDialog1.Execute then
  begin
   // StringGrid1.Rows[0].LoadFromFile(OpenDialog1.FileName);
//    StringGRid1.Rows.LoadFromFile(OpenDialog1.FileName);
    StringGrid1.RowCount := 1;

    AssignFile(InFile,OpenDialog1.FileName);
    Reset(InFile);
    FCount := 0;

    while not Eof(InFile) do
    begin
      ReadLn(InFile,Data);
      StringGrid1.Cells[0,FCount] := Data;
      Inc(FCount);
      StringGrid1.RowCount := StringGrid1.RowCount+1;

    end;

    StringGrid1.FixedRows := 1;
//    StringGrid1.Cols[1].LoadFromFile(OpenDialog1.FileName);

    CloseFile(InFile);
  end;

end;

procedure TfrmUpdateForecast.StringGrid2DragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := TRue;

end;

procedure TfrmUpdateForecast.StringGrid2DragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  MoveToString;
end;

procedure TfrmUpdateForecast.MoveToString;
var
  Count: Integer;
begin
  for Count := 0 to (ListBox1.Items.Count - 1) do
  begin

    if ListBox1.Selected[Count] then
    begin
        if StringGrid2.Cells[0,StringGrid2.RowCount-1] <> '' then
          StringGrid2.RowCount := StringGrid2.RowCount + 1;

        StringGrid2.Cells[0,StringGrid2.RowCount-1] := ListBox1.Items.Strings[(count)];
        StringGrid2.Cells[1,StringGrid2.RowCount-1] := '100';
    end;

  end;

  for Count := (ListBox1.Items.Count - 1) downto 0 do
  begin

    if ListBox1.Selected[Count] then
    begin
      ListBox1.Items.delete(Count);
    end;

  end;

end;

procedure TfrmUpdateForecast.SpeedButton1Click(Sender: TObject);
begin
  MoveToString;
end;

procedure TfrmUpdateForecast.SpeedButton3Click(Sender: TObject);

var
  Count: Integer;
begin
  for Count := 0 to (ListBox1.Items.Count - 1) do
  begin

        if StringGrid2.Cells[0,StringGrid2.RowCount-1] <> '' then
          StringGrid2.RowCount := StringGrid2.RowCount + 1;

        StringGrid2.Cells[0,StringGrid2.RowCount-1] := ListBox1.Items.Strings[(count)];
        
  end;

  for Count := (ListBox1.Items.Count - 1) downto 0 do
  begin

      ListBox1.Items.delete(Count);
  end;

end;


procedure TfrmUpdateForecast.SpeedButton2Click(Sender: TObject);
var
  DeleteRow, Count: Integer;
begin
  DeleteRow := stringgrid2.Row;

  If DeleteRow > 0 then
  begin
    if stringgrid2.Cells[0,DeleteRow] <> '' then
      ListBox1.Items.Add(StringGrid2.Cells[0,DeleteRow]);
    stringgrid2.Cells[0,DeleteRow] := '';
    
  end;

  if stringgrid2.RowCount  > 2 then
  begin
    For Count := DeleteRow to stringgrid2.RowCount do
    begin
      stringgrid2.Rows[Count] := stringgrid2.Rows[Count+1];
    end;

    stringgrid2.RowCount := stringgrid2.RowCount -1;
  end;


end;

procedure TfrmUpdateForecast.SpeedButton4Click(Sender: TObject);
var
  Count: Integer;
begin

for Count := 1 to StringGrid2.RowCount -1 do
begin
  ListBox1.Items.Add(Stringgrid2.cells[0,Count]);
end;

StringGrid2.RowCount := 2;
Stringgrid2.cells[0,1] := '';



end;

procedure TfrmUpdateForecast.SpeedButton5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    StringGrid1.Cols[0].SaveToFile(OpenDialog1.FileName);
  end;

end;

end.
