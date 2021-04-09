unit uExcelUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj, cnsExcel;

type
  TExcelCellFormat = (ecfText, ecfFloat, ecfInteger, ecfPercent, ecfCurrency,ecfPercentOneDecimal);

type
  TfrmExcelUnit = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    FExcel:variant;
    FisConnected:boolean;
    procedure StartExcel;
    procedure StopExcel;
    procedure AddWorkBook(TheName:String);overload;
    procedure AddWorkBook(TheName:String;NumSheets:Integer);overload;
    procedure SelectWorkBook(TheName:String);
    procedure SelectSheet(TheName:String);
    procedure DeleteSheet(TheName:String);
    procedure SaveAndCloseWorkBook(TheName:String);
    procedure ConnectToExcel;
    procedure RenameSheet(OldName, NewName:String);
    procedure InsertSheet(NewName:String);
    procedure FormatThickOutline(Range: Variant);
    procedure FormatGridLineInside(Range: Variant);
    procedure FormatThinOutline(Range: Variant);
    procedure FormatLeftThin(Range: Variant);
    function GetColumnName(ColPos:Integer):String;
    function GetColumnRowName(RowNo,ColPos:Integer):String;
    procedure FormatRange(RangeStr:String;CellFormat:TExcelCellFormat;FontBold:Boolean);
    procedure SaveWorkBookAs(NewName:String);
    procedure FormatRangeBold(RangeStr:String);
  end;

var
  frmExcelUnit: TfrmExcelUnit;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmExcelUnit.AddWorkBook(TheName: String);
var
 WBook:variant;
begin
 FExcel.SheetsInNewWorkbook:=1;
 FExcel.WorkBooks.Add;

 WBook:=FExcel.ActiveWorkBook;

 if not VarIsEmpty(WBook)then
 begin
  Wbook.SaveAs(TheName);
 end;

end;

procedure TfrmExcelUnit.AddWorkBook(TheName: String;NumSheets:Integer);
var
 WBook:variant;
begin
 FExcel.SheetsInNewWorkbook:=NumSheets;
 FExcel.WorkBooks.Add;

 WBook:=FExcel.ActiveWorkBook;

 if not VarIsEmpty(WBook)then
 begin
  Wbook.SaveAs(TheName);
 end;

end;

procedure TfrmExcelUnit.ConnectToExcel;
var
 Excel1:variant;
begin
  try
    Excel1:=GetActiveOleObject('Excel.Application');
    FExcel:=Unassigned;
    Excel1:=Unassigned;
    FExcel:=GetActiveOleObject('Excel.Application');
    FisConnected:=true;
  except
    FExcel:=Unassigned;
    showmessage('Active Excel not found');
  end;

  SetForegroundWindow(Handle);
end;

procedure TfrmExcelUnit.DeleteSheet(TheName: String);
var
 Sheet:variant;
 Wbook:variant;
begin
 SelectSheet(TheName);
 Sheet:=FExcel.ActiveSheet;
 if not VarIsEmpty(Sheet) then
 begin
   Wbook:=FExcel.ActiveWorkBook;

   if Wbook.Sheets.Count>1 then
     Sheet.Delete;

 end;

end;

procedure TfrmExcelUnit.FormatGridLineInside(Range: Variant);
begin
  FormatThinOutLine(Range);
end;

procedure TfrmExcelUnit.FormatLeftThin(Range: Variant);
begin
  Range.Borders.Item[xlEdgeLeft].Weight := xlThin;
  Range.Borders.Item[xlEdgeLeft].LineStyle := xlContinuous;
end;

procedure TfrmExcelUnit.FormatRange(RangeStr: String;CellFormat:TExcelCellFormat;FontBold:Boolean);
var
 Sheet,Range:variant;
 TheFormat:String;
begin

 Sheet:=FExcel.ActiveSheet;
 //Text format
 Range := Sheet.Range[RangeStr];

 Case CellFormat of
   ecfText:TheFormat := '@';
   ecfInteger:TheFormat :=  '#,##0';
   ecfFloat:TheFormat := '#,##0.00';
   ecfPercent:TheFormat := '0.00%';
   ecfPercentOneDecimal:TheFormat := '0.0%';
   ecfCurrency:TheFormat :=  '$#,##0';
 end;

 Range.NumberFormat := TheFormat;
 Range.Font.Bold := FontBold;


end;

procedure TfrmExcelUnit.FormatRangeBold(RangeStr: String);
var
 Sheet,Range:variant;
begin
 Sheet:=FExcel.ActiveSheet;
 Range := Sheet.Range[RangeStr];
 Range.Font.Bold := True;
end;

procedure TfrmExcelUnit.FormatThickOutline(Range: Variant);
begin
  Range.Borders.Item[xlEdgeBottom].Weight := xlThick;
  Range.Borders.Item[xlEdgeBottom].LineStyle := xlContinuous;
  Range.Borders.Item[xlEdgeTop].Weight := xlThick;
  Range.Borders.Item[xlEdgeTop].LineStyle := xlContinuous;
  Range.Borders.Item[xlEdgeLeft].Weight := xlThick;
  Range.Borders.Item[xlEdgeLeft].LineStyle := xlContinuous;
  Range.Borders.Item[xlEdgeRight].Weight := xlThick;
  Range.Borders.Item[xlEdgeRight].LineStyle := xlContinuous;
end;

procedure TfrmExcelUnit.FormatThinOutline(Range: Variant);
begin
 Range.Borders.Item[xlEdgeBottom].Weight := xlThin;
 Range.Borders.Item[xlEdgeBottom].LineStyle := xlContinuous;
 Range.Borders.Item[xlEdgeTop].Weight := xlThin;
 Range.Borders.Item[xlEdgeTop].LineStyle := xlContinuous;
 Range.Borders.Item[xlEdgeLeft].Weight := xlThin;
 Range.Borders.Item[xlEdgeLeft].LineStyle := xlContinuous;
 Range.Borders.Item[xlEdgeRight].Weight := xlThin;
 Range.Borders.Item[xlEdgeRight].LineStyle := xlContinuous;

end;

function TfrmExcelUnit.GetColumnName(ColPos: Integer): String;
var
  RemainNum,DivNum:Integer;
  FirstChar,SecondChar:String;
begin


  SecondChar := '';
  FirstChar := '';

  DivNum := (ColPos-1) div 26;

  if (DivNum >= 1) then
     FirstChar := UpCase(Chr(DivNum+64));

  RemainNum := ColPos - (DivNum * 26);

  if (RemainNum > 0) and (RemainNum <= 26) then
     SecondChar := UpCase(Chr(RemainNum+64));


  Result := FirstChar+SecondChar;

end;

function TfrmExcelUnit.GetColumnRowName(RowNo, ColPos: Integer): String;
begin
  Result := Trim(GetColumnName(ColPos)+IntToStr(RowNo));
end;

procedure TfrmExcelUnit.InsertSheet(NewName: String);
var
 Wbook,Sheet:variant;
begin
 WBook:=FExcel.ActiveWorkBook;

 if not VarIsEmpty(WBook) then
 begin
   Wbook.Worksheets.Add;
   Sheet:=FExcel.ActiveSheet;
   Sheet.Name:=NewName;   
 end;

end;

procedure TfrmExcelUnit.RenameSheet(OldName, NewName: String);
var
 Sheet:variant;
begin
  SelectSheet(OldName);
  Sheet:=FExcel.ActiveSheet;
  Sheet.Name:=NewName;
end;

procedure TfrmExcelUnit.SaveAndCloseWorkBook(TheName: String);
var
 WBook:variant;
begin
 SelectWorkBook(TheName);
 WBook:=FExcel.ActiveWorkBook;
 if not VarIsEmpty(WBook) then
 begin
   WBook.Saved := true;
   WBook.Save;
   WBook.Close;
 end;

end;


procedure TfrmExcelUnit.SaveWorkBookAs(NewName: String);
var
 Wbook:variant;
begin
  Wbook:=FExcel.ActiveWorkBook;

  if not VarIsEmpty(Wbook) then
  begin
    Wbook.SaveAs(NewName);
  end;

end;

procedure TfrmExcelUnit.SelectSheet(TheName: String);
begin
  FExcel.ActiveWorkBook.Sheets[TheName].Activate;
end;

procedure TfrmExcelUnit.SelectWorkBook(TheName: String);
begin
  FExcel.WorkBooks[TheName].Activate;
end;

procedure TfrmExcelUnit.StartExcel;
begin
  FExcel:=UnAssigned;
  FExcel:=CreateOleObject('Excel.Application');
  FExcel.Visible:=True;
  FExcel.DisplayAlerts:=false;
  FIsConnected:=false;
  SetForegroundWindow(Handle);
end;

procedure TfrmExcelUnit.StopExcel;
begin

  try
    FExcel.Quit;
  finally
    FExcel:=Unassigned;
  end;


end;

end.
