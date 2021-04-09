// Ver 1.0 - Initial version.

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, uExelManip;


type
  TfrmMain = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    LogFile : TextFile;
    FirstShow:Boolean;
    procedure Say(Line : string);
    procedure OpenLogFile;
    procedure StartProcess;
    procedure PopulateInputRow(var CurInputRow : string);
    function GetParam(ParamName : String): String;
    function ValidateDataRow(CurInputRow : String; var Msg : String): Boolean;
    function IfNull( const Value, Default : OleVariant ) : OleVariant;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses uParameters, uDmDataImport, uDMData;

{$R *.dfm}

procedure TfrmMain.Say(Line : string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Application.ProcessMessages;
end;

procedure TfrmMain.OpenLogFile;
var
  FName:String;
begin
  FName := dmdataImport.GetLogFileName;
  AssignFile(LogFile,FName );
  Rewrite(LogFile);
end;

procedure TfrmMain.StartProcess;
var
  FilePath, ExceptName  : string;
  i,procRowCount,totRowCount,_numCols,_numHddrs :integer;
  ExceptFile : TextFile;
  CurInputRow,tblName,sep: String;
  ValidLocsForOrgModel,ValidLocsForTgtModel,TgtLocCodeStrings : TStrings;
  searchResult : TSearchRec;
  ErrorsFound: boolean;
begin
  Say('Start');
  ErrorsFound := false;
  //Load parameters
  frmParameters.LoadParam;
  Say('Parameter File: '+frmParameters.edtIniFile.Text);
  FilePath := GetParam('Input Folder');
  ForceDirectories(FilePath+'\Processed');
  ForceDirectories(FilePath+'\Rejected');
  ForceDirectories(GetParam('Exception Folder') );

  _numCols := strToInt(GetParam('Columns'));
  _numHddrs := strToInt(GetParam('Header Lines'));

  //Open the exception file
  ExceptName := GetParam('Exception Folder') + '\ImportExcelExcept.csv';

  Say('Creating Exceptions : '+ExceptName);
  AssignFile(ExceptFile,ExceptName);
  Rewrite(ExceptFile);
  //CloseFile(ExceptFile);
  //DeleteFile(ExceptName);

  Say('Create import Statement');
  dmDataImport.qryInsertExcelData.SQL.Clear;
  dmDataImport.qryInsertExcelData.SQL.Add('UPDATE OR INSERT INTO ' + GetParam('Table Name'));
  dmDataImport.qryInsertExcelData.SQL.Add('(');
  sep := '';
  for i := 0 to _numCols-1 do
  begin
    tblName :=  GetParam('Col'+IntToStr(i));
    if tblName <> '' then
    begin
      dmDataImport.qryInsertExcelData.SQL.Add(sep+tblName);
      sep :=',' ;
    end;
  end;
  dmDataImport.qryInsertExcelData.SQL.Add(') VALUES ( ');
  sep := '';
  for i := 0 to _numCols-1 do
  begin
    tblName :=  GetParam('Col'+IntToStr(i));
    if tblName <> '' then
    begin
      dmDataImport.qryInsertExcelData.SQL.Add(sep+':'+tblName);
      sep :=',';
    end;
  end;
  dmDataImport.qryInsertExcelData.SQL.Add(');');


  // Try to find regular files matching *.* in the current dir
  SetCurrentDir(FilePath);
  if findfirst('*.*', faAnyFile, searchResult) = 0 then
  begin
    repeat
      try
        if (searchResult.attr and faDirectory) <> faDirectory  then
        begin
          Say('Looking for Excel File: '+searchResult.Name);
          if (not fileexists(searchResult.Name)) then
          begin
            Say('==========================================================================');
            Say('Excel Input file not found - '+searchResult.Name);
          end;
          WriteLn(ExceptFile,''' ========================================================================== ''');
          WriteLn(ExceptFile,' Excel Input file not found - '+searchResult.Name);
          WriteLn(ExceptFile,' Record Number,Error Message');

          Say('Connecting to Excel');
          dmDataImport.ConnectToExcel(searchResult.Name);
          dmDataImport.ADOQuery1.Close;
          dmDataImport.ADOQuery1.SQL.Text := 'select * from [Sell-Thru$]';

          if not dmDataImport.trnOptimiza.InTransaction then
            dmDataImport.trnOptimiza.StartTransaction;

          Say('Opening Excel query');
          dmDataImport.AdoQuery1.Open;

          //Loop through all the rows of data
          Say('Validating and processing data.');
          procRowCount := 0;
          //Check total field count is valid
          if dmDataImport.AdoQuery1.Fields.Count = _numCols then
          begin
            dmDataImport.AdoQuery1.last;
            totRowCount := dmDataImport.AdoQuery1.RecordCount;
            dmDataImport.AdoQuery1.first;

            while not dmDataImport.AdoQuery1.eof do
            begin
              // Need to validate?
              //PopulateInputRow(CurInputRow);
              //Ignore blank rows
              //TgtModelCode := Trim(IfNull(dmDataImport.AdoQuery1.Fields[_targetModel].Value,''));

              for i := 0 to _numCols-1 do
              begin
                tblName :=  GetParam('Col'+IntToStr(i));
                if tblName <> '' then
                begin
                  dmDataImport.qryInsertExcelData.ParamByName(tblName).AsString := Trim(IfNull(dmDataImport.AdoQuery1.Fields[i].Value,''));
                end;
              end;
              dmDataImport.qryInsertExcelData.ExecQuery;
              procRowCount := procRowCount + 1;
              dmDataImport.AdoQuery1.next;
            end;
            dmDataImport.trnOptimiza.Commit;
          end
          else
          begin
            Say('The import file contains an incorrect number of columns. Process was aborted.');
            WriteLn(ExceptFile,'N/A,The import file contains an incorrect number of columns. Process was aborted.');
            Say('Move input file to rejectedfolder');
            if fileexists(FilePath+'\Rejected\'+extractfilename  (searchResult.Name)) then
            begin
              if not SysUtils.DeleteFile(FilePath+'\Rejected\'+extractfilename  (searchResult.Name)) then
              begin
                Say('Unable to delete file ' + FilePath+'\Rejected\'+extractfilename  (searchResult.Name) );
              end;
            end;
            MoveFile(PChar(searchResult.Name), PChar(FilePath+'\Rejected\'+extractfilename  (searchResult.Name)));
            ErrorsFound := true;
          end;
          dmDataImport.AdoQuery1.Close;
          dmDataImport.DisconnectFromExcel;
          Say('Processed ' +  inttostr(procRowCount) + ' rows.');
          Say('Move input file to processed folder');
          if fileexists(FilePath+'\Processed\'+extractfilename  (searchResult.Name)) then
          begin
            if not SysUtils.DeleteFile(FilePath+'\Processed\'+extractfilename  (searchResult.Name)) then
            begin
              Say('Unable to delete file ' + FilePath+'\Processed\'+extractfilename  (searchResult.Name) );
            end;
          end;
          MoveFile(PChar(searchResult.Name), PChar(FilePath+'\Processed\'+extractfilename  (searchResult.Name)));
          //if not RenameFile(FilePath,FilePath + '.old') then
          //begin
            //Say('Unable to rename input file from ' + FilePath + ' to ' + FilePath + '.old' );
          //end;
          //dmDataImport.FireEvent('S');
        end;
        except
          on e: exception do begin
            Say('***  failed');
            Say('*** ' + e.Message);
            WriteLn(ExceptFile,'N/A,The import failed - '+e.Message);
           //dmDataImport.FireEvent('S');
            dmDataImport.ADOQuery1.Close;
            dmDataImport.DisconnectFromExcel;
            Say('Move input file to rejectedfolder');
            if fileexists(FilePath+'\Rejected\'+extractfilename  (searchResult.Name)) then
            begin
              if not SysUtils.DeleteFile(FilePath+'\Rejected\'+extractfilename  (searchResult.Name)) then
              begin
                Say('Unable to delete file ' + FilePath+'\Rejected\'+extractfilename  (searchResult.Name) );
              end;
            end;
            MoveFile(PChar(searchResult.Name), PChar(FilePath+'\Rejected\'+extractfilename  (searchResult.Name)));
            ErrorsFound := true;
          end;
        end;
    until FindNext(searchResult) <> 0;
    CloseFile(ExceptFile);
    if ErrorsFound = false then
    begin
      if not SysUtils.DeleteFile(ExceptName) then
      begin
        Say('Unable to delete file ' + ExceptName );
      end;
    end;

    // Must free up resources used by these successful finds
    FindClose(searchResult);
    dmDataImport.FireEvent('S');
  end;
end;

procedure TfrmMain.PopulateInputRow(var CurInputRow : string);
begin
end;

function TfrmMain.ValidateDataRow(CurInputRow : String; var Msg : String): Boolean;
var
  i,index : integer;
  TgtLocCodeStrings : TStrings;
  FoundLoc : Boolean;
begin
  Result := true;
 end;



function TfrmMain.IfNull( const Value, Default : OleVariant ) : OleVariant;
begin
  if Value = NULL then
    Result := Default
  else
    Result := Value;
end;

function TfrmMain.GetParam(ParamName: String): String;
begin
  Result := frmParameters.vleParameters.Values[ParamName];
end;


procedure TfrmMain.FormActivate(Sender: TObject);
var
  StartTime : TDateTime;
  RunProcess:Boolean;
  FName:String;
begin
  if FirstShow then
  begin
    Caption := Caption + ' ' + dmDataImport.DbDescription + ' Ver ' + dmDataImport.kfVersionInfo;
    FirstShow := False;
    if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) then
    begin
      frmParameters.edtIniFile.Text := ParamStr(1);
      RunProcess := True;
      frmParameters.LoadParam;
    end
    else
    begin
      Memo1.Lines.add('Parameter Setup');
      frmParameters.Caption := 'Parameter Setup - Ver ' +dmDataImport.kfVersionInfo;
       if UpperCase(ParamStr(1)) = '-Z' then
       begin
        frmParameters.edtIniFile.Text := ParamStr(3);
       end;
      frmParameters.ShowModal;
      RunProcess := frmParameters.CreateOutput;
    end;
    if RunProcess then
    begin
      OpenLogFile;
      StartTime := Now;
      Say(FName+' started on ' + DateTimeToStr(StartTime));
      StartProcess;
      Say(FName+' finished on ' + DateTimeToStr(Now));
      Say(Format('Elapsed Time: %.2f seconds', [(Now - StartTime) * 86400]));
      CloseFile(LogFile);
      Close;
    end
    else
      Close;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

end.
