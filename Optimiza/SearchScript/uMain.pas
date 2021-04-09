unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,DateUtils, Buttons,Filectrl,
  Grids, ValEdit,ShellApi;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    ListBox1: TListBox;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cmbSearch: TComboBox;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    vleParameters: TValueListEditor;
    Label2: TLabel;
    ListBox2: TListBox;
    chkPartial: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    edtMostRecent: TEdit;
    Label6: TLabel;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure StartSearch;
    procedure Button1Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);

  private
    FirstShow:Boolean;
    FParamFileName:String;
    procedure StartProcess;
    procedure SaveParams;
    procedure LoadParams;
    function GetFileName(Index:Integer):String;
    procedure OpenTheFile(FileToOpen:String);

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

uses uParameters;

{$R *.DFM}


procedure TfrmMain.StartProcess;
begin
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin

    FirstShow := False;
    FParamFileName := ExtractFilePath(ParamStr(0))+'SearchScript.ini';
    LoadParams;

  end;



end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;




procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
  ListBox1.DeleteSelected;
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  Dir:String;
const
   SELDIRHELP = 1000;

begin
  Dir := 'C:\';

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
    ListBox1.Items.Add(Dir);

end;

procedure TfrmMain.LoadParams;
begin
  vleParameters.Strings.LoadFromFile(FParamFileName);
  ListBox1.Items.CommaText :=  vleParameters.Values['Folders'];
  cmbSearch.Text := vleParameters.Values['Search'];
  cmbSearch.Items.CommaText := vleParameters.Values['Search List'];
end;

procedure TfrmMain.SaveParams;
begin

  vleParameters.Values['Folders'] := ListBox1.Items.CommaText;
  vleParameters.Values['Search'] := cmbSearch.Text;
  vleParameters.Values['Search List'] := cmbSearch.Items.CommaText;
  vleParameters.Strings.SaveToFile(FParamFileName);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveParams;
end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
begin

  if cmbSearch.Items.IndexOf(cmbSearch.Text) < 0 then
    cmbSearch.Items.Add(cmbSearch.Text);

  StartSearch;
      
end;

procedure TfrmMain.StartSearch;
var
  sr: TSearchRec;
  FileAttrs: Integer;
  FName, FPath, FData,FSearchData,TempName: String;
  ScriptFile:TextFile;
  FCount,dCount,lCount,SPos:Integer;
  FoundData:Boolean;
begin

  ListBox2.Clear;
  FSearchData := ' PROCEDURE ' + UpperCase(cmbSearch.Text);

  for dCount := 0 to ListBox1.Count-1 do
  begin

      FileAttrs := faAnyFile;

      FPath := ListBox1.Items.Strings[dCount]+'\*.Sql';
      FCount := 0;

      if FindFirst(FPath, FileAttrs, sr) = 0 then
      begin
        repeat


          if (sr.Attr and FileAttrs) = sr.Attr then
          begin
            AssignFile(ScriptFile,ListBox1.Items.Strings[dCount]+'\'+sr.Name);
            Reset(ScriptFile);
            lCount := 0;
            inc(FCount);

            if FCount mod 10 = 0 then
            begin
              Label5.Caption := ListBox1.Items.Strings[dCount]+'\'+sr.Name;
              Application.ProcessMessages;
            end;


            while not eof(ScriptFile) do
            begin
              Readln(ScriptFile,FData);
              FData := UpperCase(FData);

              if (Pos('ALTER'+FsearchData,FData) > 0) or
                 (Pos('CREATE'+FsearchData,FData) > 0) or
                 (Pos('DROP'+FsearchData,FData) > 0)
              then
              begin

                FoundData := True;

                if not chkPartial.Checked then
                begin
                  FoundData := False;
                  SPos := Pos(FsearchData,FData) + Length(FsearchData);


                  if (Copy(FData,SPos,1) = ' ') or (Copy(FData,SPos,1) = ')') then
                    FoundData := True;

                end;

                if FoundData then
                begin
                  TempName := sr.Name;

                  If pos('_',sr.Name) > 0 then
                    TempName := 'Script9'+Copy(sr.Name,pos('_',sr.Name)+1,Length(sr.Name));

                  ListBox2.Items.Add(TempName+'--->'+IntToStr(dCount)+'--->'+sr.Name + '--->'+FData);
                end;

                Break;
              end;

              inc(LCount);
              if lCount > 5 then
                Break;

            end;

            CloseFile(ScriptFile);

          end;

        until FindNext(sr) <> 0;

        FindClose(sr);

      end;


    end;
     edtMostRecent.Text := GetFileName(ListBox2.Count-1);
     MessageDlg('Complete',mtInformation,[mbOK],0);
end;


function TfrmMain.GetFileName(Index: Integer):String;
var
  TempStr,TempFolder:String;
begin
  Result := '';

  if Index >= 0 then
    Result := ListBox2.Items.Strings[Index];

  if result <> '' then
  begin
    TempStr := Copy(Result,Pos('--->',Result)+4,Length(REsult));
    TempFolder := Copy(TempStr,1,Pos('--->',TempStr)-1);
    TempStr := Copy(Tempstr,Pos('--->',TempStr)+4,Length(TempStr));
    Result := Copy(TempStr,1,Pos('--->',TempStr)-1);
    TempStr := Copy(Tempstr,Pos('--->',TempStr)+4,Length(TempStr));
    Result := ListBox1.Items.Strings[StrToInt(TempFolder)]+'\'+ Result;
  end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  OpenTheFile(edtMostRecent.Text);
end;

procedure TfrmMain.ListBox2DblClick(Sender: TObject);
var
  sCount:Integer;
  TheFileName:String;
begin
  for SCount := 0 to ListBox2.Count -1 do

  if ListBox2.Selected[sCount] then
  begin
    TheFileName := GetFileName(SCount);
    if theFileName <> '' then
      OpenTheFile(TheFileName);
  end;

end;

procedure TfrmMain.OpenTheFile(FileToOpen: String);
begin
 ShellExecute(GetDesktopWindow(), 'open', PChar(FileToOpen), nil, nil,
    SW_SHOWNORMAL);

end;

end.
