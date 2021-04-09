unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ComCtrls, ToolWin,IniFiles, StdCtrls, ExtCtrls,
  Grids, ValEdit,StrUtils;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    ToolButton4: TToolButton;
    Export1: TMenuItem;
    ToolButton5: TToolButton;
    SaveDialog1: TSaveDialog;
    ToolButton6: TToolButton;
    OpenMultiple1: TMenuItem;
    StringGrid1: TStringGrid;
    ToolButton7: TToolButton;
    ImageList2: TImageList;
    OpenManyCompareeachprocess1: TMenuItem;
    ToolButton8: TToolButton;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
  private
    { Private declarations }
     IniFile:TIniFile;
     LastPath: String;
     function getTimeTaken(Seconds:Integer):String;
     function GetStartTime(aStr:String):String;
     procedure UpdateRow(aKey,aTime:String);
     procedure BuildTime(aTitle:String;StartEnd:Boolean);
     procedure InitGrid;
     procedure FinaliseGrid;
     procedure MoveToBottom(aStr:String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses uScanSelect;

{$R *.dfm}

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := LastPath;

  if OpenDialog1.Execute then
  begin
    LastPath := ExtractFilePath(OpenDialog1.FileName);
    IniFile.WriteString('Paths','LastPath',LastPath);
    IniFile.UpdateFile;

    try
      Memo1.Lines.LoadFromFile(Opendialog1.FileName);
    except
      MessageDlg('Unable to open '+#10+ Opendialog1.FileName,mtError,[mbOK],0);
    end;

    Statusbar1.Panels[0].Text := Opendialog1.FileName;

    InitGrid;
    BuildTime('Elapsed Time',False);
    FinaliseGRid;

    Export1.Enabled := True;
    Toolbutton4.Enabled := True;

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  IniFileName: String;
begin
  IniFileName := ParamStr(0);
  IniFileName := Copy(IniFileName,1,Length(IniFileName)-3) + 'ini';
  IniFile := TIniFile.Create(IniFileName);
  LastPath := Trim(IniFile.ReadString('Paths','LastPath',''));

  if LastPath = '' then
  begin
    LastPath := ExtractFilePath(ParamStr(0));
    IniFile.WriteString('Paths','LastPath',LastPath);
    IniFile.UpdateFile;

  end;


end;

function TForm1.getTimeTaken(Seconds: Integer): String;
var
  nHour, nMinute, nSec, nRem: Integer;
//  nRem: Real;
begin

  if Seconds > 0 then
  begin
    nRem := Seconds;
    nSec := 0;

    nHour := trunc(int(Seconds / 3600));

    if nHour > 0 then
    begin
      nRem := nRem - (nHour * 3600);
    end;

    nMinute := trunc(int(nRem / 60));

    if nMinute > 0 then
    begin
      nRem := nRem - (nMinute * 60);
    end;

    if nRem > 0 then
      nSec := nRem;


    Result := Format('%2dX%2dX%2d',[nHour,nMinute,nSec]) ;
    Result := StringReplace(Result,'X',':',[rfReplaceAll]);
    Result := StringReplace(Result,' ','0',[rfReplaceAll]);

  end
  else
    Result := '00:00:00';


end;

procedure TForm1.Export1Click(Sender: TObject);
var
  rCount, cCount: Integer;
  CsvFile: TextFile;
  aString: String;
  OverWrite: Boolean;
begin
  SaveDialog1.InitialDir := LastPath;

  if SaveDialog1.Execute then
  begin
    OverWrite := True;

    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageDlg(SaveDialog1.Filename+#10+'exists. Overwrite ? ',mtWarning,[mbYes,mbNo],0) = mrNo then
        Overwrite := False;
    end;

    if OverWrite then
    begin
      AssignFile(CsvFile, SaveDialog1.FileName);
      Rewrite(CsvFile);

      for rCount := 0 to StringGrid1.RowCount -1 do
      begin

        aString := Stringgrid1.Rows[rCount].CommaText;
        //for cCount := 0 to StringGrid1.Rows[rCount].Count - 1 do
        //begin
        //  aString := StringGrid1.Rows[rCount].Strings[cCount];
        //  aString := StringReplace(aString,'=',',',[rfReplaceAll]);

          Writeln(CsvFile,aString);
        //end;

      end;

      CloseFile(CsvFile);

      MessageDlg(SaveDialog1.FileName+#10+'Saved !',mtInformation,[mbOK],0);

    end;


  end;

end;

procedure TForm1.ToolButton6Click(Sender: TObject);
var
  LogFile: TextFile;
  FName, aString, Elapsed, prevRec: String;
  nCount, SelCount : Integer;
begin

  {$I-}

  if Form2.showmodal = mrOk then
  begin
    Memo1.Clear;
    SelCount := 0;

    for nCount := 0 to Form2.ListBox1.Items.Count-1 do
    begin

      if Form2.ListBox1.Selected[nCount] then
      begin
        inc(SelCount);

        FName := ExtractFilePath(Form2.Edit1.Text)+ Form2.ListBox1.Items.Strings[nCount];
        Memo1.Lines.Add('Log File: '+FName);
        AssignFile(LogFile, FName);
        Reset(LogFile);
        PrevRec := '';

        while not eof(LogFile) do
        begin
          ReadLn(LogFile, aString);

          if Pos('ELAPSED',UpperCase(aString)) > 0 then
            Elapsed := aString
          else
            PrevRec := aString;

        end;

        aString := UpperCase(PrevRec+' '+Elapsed);
        aString := StringReplace(aString,'PROCESS','',[rfReplaceAll]);
        Memo1.Lines.Add(aString);
        CloseFile(LogFile);

      end;

    end;

    Export1.Enabled := True;
    Toolbutton4.Enabled := True;

  end;
  {$I+}
  InitGrid;
  BuildTime('Elapsed Time',False);
  FinaliseGRid;
end;

procedure TForm1.BuildTime(aTitle: String;StartEnd:Boolean);
var
  aKey, aValue, rStr,StartTime: String;
  nTot, rCount, nStartPos, nEndPos, nSec, GridCount, colCount: Integer;
begin

    GridCount := 0;
    colCount := StringGrid1.ColCount;
    StringGrid1.ColCount := colCount+1;
    StringGrid1.Cells[ColCount,0] := aTitle;

//    ValueListEditor1.Strings.Clear;


    aKey := '';
    aValue := '';
    StartTime := '';

    nTot := 0;
    nSec := 0;

    for rCount := 0 to Memo1.Lines.Count - 1 do
    begin
      rStr := UpperCase(Memo1.Lines.Strings[rCount]);

      if (Pos('STARTED ON',rStr) > 0) then
      begin
        StartTime := GetStartTime(rStr);
        UpdateRow('Start Time',StartTime);
      end;

      if StartEnd then
      begin
        if (Pos('FINISHED ON',rStr) > 0) then
        begin
          StartTime := GetStartTime(rStr);
          UpdateRow('End Time',StartTime);
        end;
      end;

      if (Pos('PROCESS',rStr) > 0) or (Pos('LOG FILE',rStr)>0) then
      begin

        if (Pos('LOG FILE',rStr)>0) then
          aKey := Copy(rStr,Pos('LOG FILE',rStr)+9,Length(rStr))
        else
          aKey := Copy(rStr,Pos('PROCESS',rStr)+8,Length(rStr));

        aKey := StringReplace(aKey,'"','',[rfReplaceAll]);
        aKey := StringReplace(aKey,',',' ',[rfReplaceAll]);
      end
      else
      if Pos('ELAPSED TIME',rStr) > 0 then
      begin
        nStartPos := Pos('ELAPSED TIME',rStr) + 13;
        nEndPos := Pos('SECONDS',rStr);

        if nEndPos <= 0 then
          nEndPos := Length(rStr)+1;


        aValue := Trim(Copy(rStr,nStartPos,nEndPos-nStartPos));
        aValue := Trim(AnsiReplaceStr(aValue,':',''));
        if aValue <> '' then
        begin
        try
          nSec := Round(StrToFloat(aValue));

        except
        end;
        end;

      end;

      if (aValue <> '') and (aKey <> '') then
      begin

        if not StartEnd then
        begin
          UpdateRow(aKey,getTimeTaken(nSec));
          nTot := nTot + nSec;
        end;

        aValue := '';
        aKey := '';

      end;


    end;


    if not StartEnd then
    begin
      UpdateRow('Total',getTimeTaken(nTot));
      MoveToBottom('Total');
    end;


    StringGrid1.Refresh;
end;

procedure TForm1.InitGrid;
begin
  StringGrid1.ColCount := 2;
  StringGrid1.Cells[0,0] := 'No.';
  StringGrid1.Cells[1,0] := 'Process';

  StringGrid1.RowCount := 1;
  //StringGRid1.FixedRows := 1;
  StringGRid1.FixedCols := 0;
  //StringGrid1.ColWidths[2]:=150;

end;

procedure TForm1.ToolButton7Click(Sender: TObject);
var
  FName, aTitle: String;
  nCount, fCount, SelCount: Integer;
begin

  if Form2.showmodal = mrOk then
  begin
    Memo1.Clear;
    SelCount := 0;

    InitGrid;

    for nCount := 0 to Form2.ListBox1.Items.Count-1 do
    begin

      //Only process selected ones
      if Form2.ListBox1.Selected[nCount] then
      begin
        inc(SelCount);

        FName := ExtractFilePath(Form2.Edit1.Text)+ Form2.ListBox1.Items.Strings[nCount];

        try
          Memo1.Lines.LoadFromFile(Fname);


        except
          MessageDlg('Unable to open '+#10+ FName,mtError,[mbOK],0);
        end;

        FName := ExtractFileName(Form2.ListBox1.Items.Strings[nCount]);
        aTitle := '';

        for fCount := 1 to Length(Fname) do
        begin


          if not (FName[fCount] in ['0'..'9']) then
          begin
              break;
          end;
           aTitle := aTitle + FName[fCount];
        end;

        BuildTime(aTitle,False);
      end;

    end;

    if SelCount > 0 then
    begin
  //    MoveToBottom('Start Time');
      FinaliseGRid;
      StringGrid1.FixedCols := 2;
      Export1.Enabled := True;
      Toolbutton4.Enabled := True;
    end;

  end;

end;

procedure TForm1.UpdateRow(aKey, aTime: String);
var
  rCount: Integer;
  FoundRow: Boolean;
begin

  FoundRow := False;

  with StringGrid1 do
  begin

    for rCount := 0 to RowCount-1 do
    begin

      if Cells[1,rCount] = aKey then
      begin
        FoundRow := True;
        break;
      end;

    end;

    if not FoundRow then
    begin
      RowCount := RowCount + 1;
      rCount := RowCount - 1;
      Cells[0,rCount] := IntToStr(rCount);
      Cells[1,rCount] := aKey;
    end;

    Cells[ColCount-1,rCount] := aTime;

    //if aKey = 'Total' then
    //  RowCount := RowCount + 1;

  end;


end;

procedure TForm1.FinaliseGrid;
begin
  StringGrid1.FixedRows := 1;

end;

procedure TForm1.MoveToBottom(aStr:String);
var
  rCount, tCount, cCount: Integer;
  FoundRow: Boolean;
begin

  FoundRow := False;

  with StringGrid1 do
  begin

    for rCount := 0 to RowCount-1 do
    begin

      if Cells[1,rCount] = aStr then
      begin
        FoundRow := True;
        break;
      end;

    end;

    if (FoundRow) and (RCount <> RowCount-1) then
    begin
      tCount := rCount;
      RowCount := RowCount + 1;
      rCount := RowCount - 1;
      Cells[0,tCount] := '';

      for cCount := 1 to ColCount-1 do
      begin
        Cells[cCount,rCount] := Cells[cCount,tCount];
        Cells[cCount,tCount] := '----';
      end;

      Cells[1,tCount] := ' ';


    end;


  end;


end;

function TForm1.GetStartTime(aStr: String): String;
var
  FirstPos:Integer;
begin

  Result := '';

  FirstPos := Pos(':',aStr);

  if FirstPos > 0 then
  begin
    Result := Trim(Copy(aStr,FirstPos-2,8));
  end;

end;

procedure TForm1.ToolButton8Click(Sender: TObject);
var
  FName, aTitle: String;
  nCount, fCount, SelCount: Integer;
begin

  if Form2.showmodal = mrOk then
  begin
    Memo1.Clear;
    SelCount := 0;

    InitGrid;

    for nCount := 0 to Form2.ListBox1.Items.Count-1 do
    begin

      //Only process selected ones
      if Form2.ListBox1.Selected[nCount] then
      begin
        inc(SelCount);

        FName := ExtractFilePath(Form2.Edit1.Text)+ Form2.ListBox1.Items.Strings[nCount];

        try
          Memo1.Lines.LoadFromFile(Fname);


        except
          MessageDlg('Unable to open '+#10+ FName,mtError,[mbOK],0);
        end;

        FName := ExtractFileName(Form2.ListBox1.Items.Strings[nCount]);
        aTitle := '';

        for fCount := 1 to Length(Fname) do
        begin


          if not (FName[fCount] in ['0'..'9']) then
          begin
              break;
          end;
           aTitle := aTitle + FName[fCount];
        end;

        BuildTime(aTitle,True);
      end;

    end;

    if SelCount > 0 then
    begin
  //    MoveToBottom('Start Time');
      FinaliseGRid;
      StringGrid1.FixedCols := 2;
      Export1.Enabled := True;
      Toolbutton4.Enabled := True;
    end;

  end;

end;

end.
