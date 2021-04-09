unit uScanSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl, ExtCtrls;

type
  TForm2 = class(TForm)
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Button1: TButton;
    Edit1: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Edit2: TEdit;
    ListBox1: TListBox;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function getProcess(FileName:String):String;
    procedure LoadFiles;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin

  if OpenDialog1.execute then
  begin
    Edit1.Text := Opendialog1.FileName;
    LoadFiles;
  end;

end;

function TForm2.getProcess(FileName: String): String;
var
  nCount, nLen: Integer;
  aChar: Char;
begin
  FileName := ExtractFileName(FileName);
  Result := '';
  nLen := Length(FileName);

  for nCount := 1 to Length(Filename) do
  begin
    aChar := FileName[nCount];
    if not (FileName[nCount] in ['0'..'9']) then
    begin
        break;
    end;

  end;

  if (nCount <> 0) and (nCount <  Length(FileName)) then
  begin

      Result := Trim(Copy(FileNAme,nCount,Length(FileName)-nCount+1));
  end;


end;

procedure TForm2.LoadFiles;
var
  sr: TSearchRec;
  FileAttrs: Integer;
  FName, FPath: String;
begin
    ListBox1.Clear;

    FileAttrs := faAnyFile;

    Edit2.text :=  getProcess(Edit1.Text);
    FPath := ExtractFilePath(Edit1.Text)+'*.*';

    if FindFirst(FPath, FileAttrs, sr) = 0 then
    begin
      repeat

        if (sr.Attr and FileAttrs) = sr.Attr then
        begin
          if Pos(Edit2.Text,sr.Name)>0 then
            ListBox1.Items.Add(sr.Name);
        end;

      until FindNext(sr) <> 0;

      FindClose(sr);

    end;

end;

end.
