unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Menus,StrUtils;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    SavetoCSV1: TMenuItem;
    BitBtn3: TBitBtn;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SavetoCSV1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    FirstShow:Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if FirstShow then
  begin
    FirstShow := False;
    StatusBar1.Panels[1].Text := dmData.DbDescription;
  end;

end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  FName:String;
  FCount:Integer;
begin

  if not dmData.trnOptimiza.InTransaction then
    dmData.trnOptimiza.StartTransaction;

  Memo1.Clear;
  FCount:=0;

  with dmData.qrySched do
  begin
    ExecQuery;

    While not eof do
    begin
      FName := FieldByName('ExecutablePath').AsString;
      FName := Fname + FieldByName('Executable').AsString;

      if not FileExists(FName) then
      begin
        Memo1.Lines.Add(FieldByName('SchedName').AsString + '|'+FieldByName('SchedDesc').AsString+'|'+
                        FName);
        inc(FCount);
      end;

      next;
    end;

    Close;
  end;

  if FCount = 0 then
    Memo1.Lines.Add('All executable paths appear to be correct');

  MessageDlg('Complete',mtInformation,[mbOK],0);

end;

procedure TfrmMain.SavetoCSV1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);

  end;

end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
var
  sr: TSearchRec;
  FileAttrs: Integer;
  FName, FPath, FData: String;
  ScriptFile:TextFile;
  FCount:Integer;
begin

    if Opendialog1.Execute then
    begin

      Memo1.Clear;

      FileAttrs := faAnyFile;

      FPath := ExtractFilePath(OpenDialog1.FileName)+'*.bat';
      FCount := 0;

      if FindFirst(FPath, FileAttrs, sr) = 0 then
      begin
        repeat

          if (sr.Attr and FileAttrs) = sr.Attr then
          begin
            AssignFile(ScriptFile,sr.Name);
            Reset(ScriptFile);

            while not eof(ScriptFile) do
            begin
              Readln(ScriptFile,FData);
              FData := UpperCase(FData);

              if (Pos('FIREEVENT.EXE',FData) > 0) or (Pos('FIREEVENTMP.EXE',FData)>0) then
              begin
                FData := AnsiReplaceStr(FData,'"','');

                //Remove parameter
                if (RightStr(FData,2) = ' S') or  (RightStr(FData,2) = ' F') then
                  FData := LeftStr(FData,Length(FData)-2);

                if not FileExists(FData) then
                begin
                  Memo1.Lines.Add(sr.Name + '--->'+Fdata+' ---> Cannot Find File.');
                  inc(FCount);
                end;


              end;


            end;

            CloseFile(ScriptFile);

          end;

        until FindNext(sr) <> 0;

        FindClose(sr);

      end;

      if FCount = 0 then
         Memo1.Lines.Add('All scripts in this folder appear to be correct');

      MessageDlg('Complete',mtInformation,[mbOK],0);
    end;

end;

end.
