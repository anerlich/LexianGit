unit uBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,StrUtils;
type
  TConst = record
     ConstName:String;
     ConstValue:String;
  end;

type
  TfrmBackup = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    edtBackupPath: TEdit;
    edtGdb: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    edtGBK: TEdit;
    edtDBPath: TEdit;
    edtGBak: TEdit;
    Button2: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtSoftware: TEdit;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure edtGdbChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FConst :Array of TConst;
    Function ReplaceConst(TheText:String):String;
    procedure AssignConst;
  public
    { Public declarations }
  end;

var
  frmBackup: TfrmBackup;

implementation

{$R *.dfm}

procedure TfrmBackup.Button1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := edtDBPath.Text;
  OpenDialog1.DefaultExt := '*.gdb';
  OpenDialog1.Filter := 'Optimiza Database (*.gdb)|*.gdb';
  OpenDialog1.FileName := '';

  if OpenDialog1.Execute then
    edtGdb.Text := OpenDialog1.FileName;
end;

procedure TfrmBackup.edtGdbChange(Sender: TObject);
begin
  if edtGBK.Text = '' then
  begin
    if Pos('.gdb',edtGDB.Text) > 0 then
      edtGBK.Text := AnsiReplaceStr(edtGDB.Text,'.gdb','.gbk');

    if Pos('.GDB',edtGDB.Text) > 0 then
      edtGBK.Text := AnsiReplaceStr(edtGDB.Text,'.GDB','.GBK');

  end;

end;

procedure TfrmBackup.BitBtn1Click(Sender: TObject);
var
  MCount:Integer;
begin
  AssignConst;
  Memo2.Clear;

  for MCount := 0 to Memo1.Lines.Count - 1 do
  begin
    Memo2.Lines.Add(ReplaceConst(Memo1.Lines.Strings[mCount]));
  end;

end;

function TfrmBackup.ReplaceConst(TheText: String): String;
var
  CCount:Integer;
begin

  //TheText := UpperCase(TheText);

  for cCount := 0 to high(FConst) do
  begin
     if Pos(FConst[cCount].ConstName,TheText) > 0 then
     begin
       TheText := AnsiReplaceStr(TheText,FConst[cCount].ConstName,FConst[cCount].ConstValue);
     end;

  end;

  Result := TheText;

end;

procedure TfrmBackup.FormCreate(Sender: TObject);
begin
  SetLength(FConst,8);
  FConst[0].ConstName := '%BACKUP_SOURCE%';
  FConst[1].ConstName := '%BACKUP_TARGET%';
  FConst[2].ConstName := '%GBAK_DRIVE%';
  FConst[3].ConstName := '%GBAK_PATH%';
  FConst[4].ConstName := '%GBAK%';
  FConst[5].ConstName := '%OPTIMIZA_DRIVE%';
  FConst[6].ConstName := '%OPTIMIZA_PATH%';
  FConst[7].ConstName := '%FIRE_EVENT%';
end;

procedure TfrmBackup.AssignConst;
var
  FEvent:String;
begin
  FConst[0].ConstValue := '"'+edtGdb.Text+'"';
  FConst[1].ConstValue := '"'+edtGbk.Text+'"';
  FConst[2].ConstValue := Copy(edtGBak.Text,1,2);
  FConst[3].ConstValue := '"'+Copy(ExtractFilePath(edtGBak.Text),4,Length(ExtractFilePath(edtGBak.Text))-1)+'"';
  FConst[4].ConstValue := edtGBak.Text;
  FConst[5].ConstValue := Copy(edtSoftware.Text,1,2);

  FEvent := 'FireEvent.exe';

  if RadioGroup1.ItemIndex = 1 then
    FEvent := 'FireEventMp.exe';

  FConst[7].ConstValue := edtSoftware.Text + FEvent;
end;

procedure TfrmBackup.Button2Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := 'c:\Program Files\Firebird\bin';
  OpenDialog1.DefaultExt := '*.exe';
  OpenDialog1.Filter := 'Applications (*.exe)|*.exe';
  OpenDialog1.FileName := 'gbak.exe';

  if OpenDialog1.Execute then
    edtGBak.Text := OpenDialog1.FileName;

end;

end.
