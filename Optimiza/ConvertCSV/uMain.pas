unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls, ComCtrls, Menus,Math;
const
 _MaxArray = 20;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    StringGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    ColumnHeader1: TMenuItem;
    Footer1: TMenuItem;
    PageBreak1: TMenuItem;
    ColumnSeparator1: TMenuItem;
    StringGrid2: TStringGrid;
    SaveDialog1: TSaveDialog;
    DeleteColumnSeparator1: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure ColumnHeader1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Footer1Click(Sender: TObject);
    procedure PageBreak1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DeleteColumnSeparator1Click(Sender: TObject);
  private
    { Private declarations }
    FCsvFile:TextFile;
    FCurrentRow:Integer;
    FCurrentCol:Integer;
    FColumnHeading:Array of Integer;
    FPageBreak:Array of Integer;
    FFooter:Array of Integer;
    FSeperator:Array of Integer;

    procedure ReadData;
    procedure InitArray;
    function getRowColor(RowNo:Integer):TColor;
    function IsSeperator(ColNo:Integer):Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit1.Text := OpenDialog1.FileName;
    ReadData;
  end;
end;

procedure TForm1.ReadData;
var
  TheData,aChar:String;
  ArrLen,RCount,ColCount:Integer;
  PageCount:Integer;
begin
  AssignFile(FCsvFile,Edit1.Text);
  Reset(FCSVFile);
  RCount := 0;


  StringGrid1.RowCount := 1;
  StringGrid1.Cells[0,0] := '';

  StringGrid2.RowCount := 1;
  StringGrid2.Cells[0,0] := '';

  PageCount:=0;
  FCurrentRow:=0;
  InitArray;
  ArrLen:=0;

  while not eof(FCSVFile) do
  begin
    ReadLn(FCsVFile,TheData);

    if Pos(#12,TheData) > 0 then
    begin
      Inc(ArrLen);
      SetLength(FPageBreak,ArrLen);
      FPageBreak[ArrLen-1] := RCount;
      //TheData := '### Page Break ###';
      Inc(PageCount);
    end;

    StringGrid2.Cells[0,RCount] := TheData;

    for ColCount := 0 to Length(TheData) do
    begin
      aChar := Copy(TheData,ColCount+1,1);
      StringGrid1.Cells[ColCount,RCount] := aChar;

      if ColCount > StringGrid1.ColCount - 1 then
        StringGrid1.ColCount := ColCount;

    end;

    if PageCount > 3 then
      break;

    inc(RCount);
    if RCount > StringGrid1.RowCount -1 then
    begin
      StringGrid1.RowCount := RCount;
      StringGrid2.RowCount := RCount;
    end;

  end;

  CloseFile(FCsvFile);

end;

procedure TForm1.ColumnHeader1Click(Sender: TObject);
var
  ArrLen,RCount:Integer;
  TheData:String;
begin
 TheData := StringGrid2.Cells[0,FCurrentRow];

 for RCount := 0 to StringGrid2.RowCount - 1 do
 begin

   if StringGrid2.Cells[0,RCount] = TheData then
   begin
     ArrLen := High(FColumnHeading) + 1;
     SetLength(FColumnHeading,ArrLen+1);
     FColumnHeading[ArrLen] := RCount;
   end;

 end;

 StringGrid1.Repaint;
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  AColor:TColor;
  TheText:String;
begin

  TheText := StringGrid1.Cells[ACol,ARow];

  if TheText = '|' then
    AColor := clSilver
  else
    AColor := GetRowColor(ARow);

  if AColor <> clBlack then
  begin

    with Sender as TDrawGrid do
    begin
      Canvas.Brush.Color := AColor;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left,Rect.Top,TheText);
    end;

  end;


end;

procedure TForm1.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Column, Row: Longint;
begin
  StringGrid1.MouseToCell(X, Y, Column, Row);
  FCurrentRow := Row;
  FCurrentCol := Column;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  InitArray;
end;

procedure TForm1.InitArray;
begin
  SetLength(FColumnHeading,0);
  SetLength(FPageBreak,0);
  SetLength(FFooter,0);
  SetLength(FSeperator,0);
end;

function TForm1.getRowColor(RowNo:Integer): TColor;
var
  ArrLen,ACount:Integer;
begin
  ArrLen := High(FColumnHeading);
  ArrLen := Max(ArrLen,High(FPageBreak));
  ArrLen := Max(ArrLen,High(FFooter));

  Result := clBlack;

  for ACount := 0 to ArrLen do
  begin
    if (Acount <= High(FColumnHeading)) and (FColumnHeading[ACount] = RowNo) then
    begin
      Result := clRed;
      Break;
    end;

    if (Acount <= High(FPageBreak)) and (FPageBreak[ACount] = RowNo) then
    begin
      Result := clYellow;
      Break;
    end;

    if (Acount <= High(FFooter)) and (FFooter[ACount] = RowNo) then
    begin
      Result := clBlue;
      Break;
    end;

  end;

end;

procedure TForm1.Footer1Click(Sender: TObject);
var
  ArrLen,RCount:Integer;
  TheData:String;
begin
 TheData := StringGrid2.Cells[0,FCurrentRow];

 for RCount := 0 to StringGrid2.RowCount - 1 do
 begin

   if StringGrid2.Cells[0,RCount] = TheData then
   begin
     ArrLen := High(FFooter) + 1;
     SetLength(FFooter,ArrLen+1);
     FFooter[ArrLen] := RCount;
   end;

 end;

  StringGrid1.Repaint;

end;

procedure TForm1.PageBreak1Click(Sender: TObject);
var
  ArrLen,RCount:Integer;
  TheData:String;
begin
 TheData := StringGrid2.Cells[0,FCurrentRow];

 for RCount := 0 to StringGrid2.RowCount - 1 do
 begin

   if StringGrid2.Cells[0,RCount] = TheData then
   begin
     ArrLen := High(FPageBreak) + 1;
     SetLength(FPageBreak,ArrLen+1);
     FPageBreak[ArrLen] := RCount;
   end;

 end;

  StringGrid1.Repaint;

end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
var
  RCount,CCount,ColSize,ArrLen:Integer;
  AColor:TColor;
begin

  ColSize := StringGrid1.ColCount;
  StringGrid1.ColCount := ColSize + 1;
  ArrLen := High(FSeperator);
  for RCount := 0 to ArrLen do
  begin
    if FSeperator[ArrLen]  > FCurrentCol then
      FSeperator[ArrLen] := FSeperator[ArrLen] + 1;

  end;
  Inc(ArrLen);
  SetLength(FSeperator,ArrLen+1);
  FSeperator[ArrLen] := FCurrentCol;

  for rCount := 0 to StringGrid1.RowCount -1 do
  begin
    AColor := GetRowColor(rCount);
    if (AColor = clBlack) or (AColor = clRed) then
    begin
      for CCount := ColSize-2 downto FCurrentCol do
      begin
        StringGrid1.Cells[CCount+1,rCount] := StringGrid1.Cells[CCount,rCount];

      end;

      StringGrid1.Cells[FCurrentCol,rCount] := '|';
    end;
  end;

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  OutFile:TextFile;
  TheData,LineOfData,AField:String;
  StartData:Boolean;
  ACount,SCount:Integer;
begin

  if SaveDialog1.Execute then
  begin
    AssignFile(OutFile,SaveDialog1.FileName);
    Rewrite(OutFile);

    AssignFile(FCsvFile,Edit1.Text);
    Reset(FCsvFile);
    AField:='';
    LineOfData:='';

    StartData := False;

    while not eof(FCsvFile) do
    begin
      if StartData then
      begin
        WriteLn(OutFile,AField);
        AField := '';
      end;

      ReadLn(FCsvFile,TheData);

      if (TheData = StringGrid2.Cells[0,FColumnHeading[0]]) then
      begin
        StartData := True;
        AField := '';
      end;

      if (TheData = StringGrid2.Cells[0,FPageBreak[0]]) or
         (TheData = StringGrid2.Cells[0,FFooter[0]]) then
      begin
         StartData := False;
      end;

      if StartData then
      begin
        SCount := 1;

        for ACount := 1 to Length(TheData) do
        begin
          if IsSeperator(Acount-1) then
          begin
            AField := Afield +',';
            Inc(SCount);
          end;

          AField := AField + Copy(TheData,ACount,1);
        end;

      end;


    end;

    CloseFile(FCsvFile);
    CloseFile(OutFile);
  end;



end;

function TForm1.IsSeperator(ColNo: Integer): Boolean;
var
  ArrCount:Integer;
begin
  Result := False;
  for ArrCount := 0 to High(FSeperator) do
  begin
    if FSeperator[ArrCount] = ColNo then
    begin
      Result := True;
      Break;
    end;

  end;


end;

procedure TForm1.DeleteColumnSeparator1Click(Sender: TObject);
var
  RCount,CCount,ColSize,ArrLen:Integer;
  AColor:TColor;
  Found:Boolean;
begin

  ColSize := StringGrid1.ColCount;

  ArrLen := High(FSeperator);
  Found := False;
  for RCount := 0 to ArrLen do
  begin

    if FSeperator[RCount] = FCurrentCol then
    begin
      FSeperator[RCount] := -1;
      Found := True;
    end;

    if Found then
    begin
      FSeperator[RCount] := FSeperator[RCount] -1;
    end;

  end;

  if Found then
  begin

    for rCount := 0 to StringGrid1.RowCount -1 do
    begin
      AColor := GetRowColor(rCount);

      if (AColor = clBlack) or (AColor = clRed) then
      begin
        for CCount := FCurrentCol to ColSize-2 do
        begin
          StringGrid1.Cells[CCount,rCount] := StringGrid1.Cells[CCount+1,rCount];

        end;

      end;
    end;

  StringGrid1.ColCount := ColSize - 1;

  end;

end;

end.
