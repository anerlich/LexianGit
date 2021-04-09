unit uCopyMultipleForecast;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, DBCtrls, CheckLst, Buttons, ExtCtrls, Grids, DBGrids,
  MyDBGrid, db, iniFiles;

type
  TfrmCopyForecast = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    CheckListBox1: TCheckListBox;
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
    chkFreeze: TCheckBox;
    grpAdd: TRadioGroup;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCopyForecast: TfrmCopyForecast;
  FirstShow:Boolean;
  TheCopyFile: Tinifile;

implementation

uses uStatus, uHelp, uDmCopyForecast;

{$R *.DFM}

procedure TfrmCopyForecast.FormShow(Sender: TObject);
var
  TheCopyFileName: String;
  FileHandle: Integer;
begin

  if FirstShow then
  begin
    StatusBar1.Panels[1].Text := dmCopyForecast.dbOptimiza.DatabaseName;

    CheckListBox1.Items.Clear;

    with dmCopyForecast.srcAllLocations.DataSet do
    begin
      First;
      while not eof do
      begin

      ChecklistBox1.Items.Add(FieldByName('LocationCode').AsString + ' - ' + FieldByName('Description').AsString);
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

    TheCopyFileName := ExtractFilePath(ParamStr(0))+'TargetLocations.txt';
    //if it doesn't exist first create
    if not FileExists(TheCopyFileName) then
    begin
      FileHandle := FileCreate(theCopyFileName);
      FileClose(FileHandle);
    end;

    StringGrid1.Cols[1].LoadFromFile(TheCopyFileName);

    PageControl1.ActivePage := TabSheet3;

    StringGrid1.Cells[0,0] := 'Source';
    StringGrid1.Cells[1,0] := 'Target';

    ComboBox1.Items.Clear;

    With dmCopyForecast.srcPeriod.DataSet do
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

procedure TfrmCopyForecast.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmCopyForecast.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCopyForecast.BitBtn5Click(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;

end;

procedure TfrmCopyForecast.BitBtn4Click(Sender: TObject);
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

procedure TfrmCopyForecast.BitBtn1Click(Sender: TObject);
var
  MonthCount, CountItem, CountLoc, Offset: Integer;
  LocList: TStringList;
  TheCopyFileName, LocCode, FreezeInd,AddInd: String;


begin
  frmStatus.ListBox1.Items.Add('Started...');

  TheCopyFileName := ExtractFilePath(ParamStr(0))+'SourceLocations.txt';
  frmStatus.ListBox1.Items.Add('Source Products Saved to :'+ TheCopyFileName);

  StringGrid1.Cols[0].SaveToFile(TheCopyFileName);
  TheCopyFileName := ExtractFilePath(ParamStr(0))+'TargetLocations.txt';

  frmStatus.ListBox1.Items.Add('Target Products Saved to :'+ TheCopyFileName);
  StringGrid1.Cols[1].SaveToFile(TheCopyFileName);


  if grpAdd.ItemIndex = 0 then
  begin
    frmStatus.ListBox1.Items.Add('Forecasts will be replaced');
    AddInd := 'R'
  end
  else
  begin
    frmStatus.ListBox1.Items.Add('Forecasts will be added');
    addInd := 'A';
  end;


  if chkFreeze.Checked then
  begin
    frmStatus.ListBox1.Items.Add('Forecasts will be frozen');
    FreezeInd := 'Y'
  end
  else
  begin
    frmStatus.ListBox1.Items.Add('Forecasts will NOT be frozen');
    FreezeInd := 'N';
  end;

  MonthCount := 6;

  Case grpMonth.ItemIndex  of
    0: MonthCount := 6;
    1: MonthCount := 12;
    2: MonthCount := 18;
    3: MonthCount := 24;
  end;

  frmStatus.ListBox1.Items.Add('Months forecast: ' +intTostr(MonthCount));
  frmStatus.ListBox1.Items.Add('Starting Month: ' +ComboBox1.text);



  frmStatus.ListBox1.Items.Add('Locations: ');
  LocList := TStringList.Create;

  Offset := ComboBox1.ItemIndex;

  if  Offset < 0 then
  begin
    frmStatus.ListBox1.Items.Add('*** Invalid Starting Month ***');
  end
  else
  begin

    for CountItem := 0 to CheckListBox1.Items.Count -1 do
    begin
       if CheckListBox1.Checked[CountItem] then
       begin
         LocCode := Trim(Copy(CheckListBox1.Items.Strings[CountItem],1,Pos('-',CheckListBox1.Items.Strings[CountItem])-1));

         LocList.Add(LocCode);
         frmStatus.ListBox1.Items.Add(LocCode);

       end;
    end;

    frmStatus.ListBox1.Items.Add('-------------------');

  end;

  for CountLoc := 0 to LocList.Count -1 do
  begin


    for CountItem := 1 to StringGrid1.RowCount -1 do
    begin

     if dmCopyForecast.CheckTarget(LocList.Strings[CountLoc],StringGrid1.Cells[0,CountItem]) then
     begin

       if dmCopyForecast.CheckTarget(LocList.Strings[CountLoc],StringGrid1.Cells[1,CountItem])then
       begin
         dmCopyForecast.UpdateFC(LocList.Strings[CountLoc],
                                     StringGrid1.Cells[0,CountItem],
                                     StringGrid1.Cells[1,CountItem],
                                     FreezeInd, AddInd, MonthCount, Offset );
       end;

     end;

    end;

  end;

  if (LocList.Count > 0) and (CountItem > 1) then
   dmCopyForecast.CommitFc
  else
     frmStatus.ListBox1.Items.Add('No Forecast Copied !');



  LocList.Free;
  frmStatus.Show;

end;

procedure TfrmCopyForecast.Edit1Exit(Sender: TObject);
begin
  Edit1.text := UpperCase(Edit1.text);

end;

procedure TfrmCopyForecast.BitBtn3Click(Sender: TObject);
begin
  dmCopyForecast.OpenSearchProd(Edit1.text);

end;

procedure TfrmCopyForecast.StringGrid1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := True;
end;

procedure TfrmCopyForecast.StringGrid1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  MCord: TGridCoord;
  StringRow, StringCol: Integer;
begin
  //Get Cell under mouse pointer
  MCord := StringGrid1.MouseCoord(X,Y);

  //if co-ordinates are outside the range then
  // use physical x,y to detemine which column to add
  //  new record
  if (MCord.x < 0) or (MCord.Y < 1) then
  begin
    if  x < 102 then
    begin
      StringCol := 0;
    end
    else
    begin
      StringCol := 1;
    end;

    if StringGrid1.Cells[StringCol,StringGrid1.RowCount-1] <> '' then
    begin
        StringGrid1.RowCount := StringGrid1.RowCount + 1;
    end;

    StringRow := StringGrid1.RowCount - 1;

  end
  else
  begin
    StringRow := MCord.Y;
    StringCol := MCord.X;
  end;

  try
    StringGrid1.Cells[StringCol, StringRow] := MyDBGrid1.DataSource.DataSet.FieldByName('ProductCode').AsString;
  except
    MessageDlg('Invalid Product Code',mtError,[mbOK],0);
  end;


end;

procedure TfrmCopyForecast.MyDBGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Getx, Gety: Integer;
begin
  Getx := x;
  Gety := y;
  MyDBGrid1.BeginDrag(False,10);
end;

procedure TfrmCopyForecast.BitBtn6Click(Sender: TObject);
begin
  frmHelp.ShowModal;
end;

end.
