unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ComCtrls, ToolWin,IniFiles, StdCtrls, ExtCtrls,
  Grids, ValEdit;

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
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    ValueListEditor1: TValueListEditor;
    ToolButton4: TToolButton;
    Export1: TMenuItem;
    ToolButton5: TToolButton;
    SaveDialog1: TSaveDialog;
    ToolButton6: TToolButton;
    OpenMultiple1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
  private
    { Private declarations }
     IniFile:TIniFile;
     LastPath: String;
     function getTimeTaken(Seconds:Integer):String;
     procedure BuildTime;
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

    BuildTime;

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
  rCount: Integer;
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

      for rCount := 0 to ValueListEditor1.Strings.Count-1 do
      begin

        aString := ValueListEditor1.Strings.Strings[rCount];
        aString := StringReplace(aString,'=',',',[rfReplaceAll]);

        Writeln(CsvFile,aString);
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
  nCount : Integer;
begin

  {$I-}

  if Form2.showmodal = mrOk then
  begin
    Memo1.Clear;

    for nCount := 0 to Form2.ListBox1.Items.Count-1 do
    begin
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

    Export1.Enabled := True;
    Toolbutton4.Enabled := True;

  end;
  {$I+}
  BuildTime;
end;

procedure TForm1.BuildTime;
var
  aKey, aValue, rStr: String;
  nTot, rCount, nStartPos, nEndPos, nSec: Integer;
begin
    ValueListEditor1.Strings.Clear;

    aKey := '';
    aValue := '';
    
    nTot := 0;
    nSec := 0;

    for rCount := 0 to Memo1.Lines.Count - 1 do
    begin
      rStr := UpperCase(Memo1.Lines.Strings[rCount]);

      if (Pos('PROCESS',rStr) > 0) or (Pos('LOG FILE',rStr)>0) then
      begin
        
        if (Pos('LOG FILE',rStr)>0) then
          aKey := Copy(rStr,Pos('LOG FILE',rStr)+9,Length(rStr))
        else
          aKey := Copy(rStr,Pos('PROCESS',rStr)+9,Length(rStr));

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
        ValueListEditor1.InsertRow(aKey,getTimeTaken(nSec),True) ;
        nTot := nTot + nSec;
        aValue := '';
        aKey := '';
      end;


    end;

    ValueListEditor1.InsertRow('Total',getTimeTaken(nTot),True) ;

end;

end.
