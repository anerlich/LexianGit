unit uRunScript;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, CustomFileOpen, StdCtrls, Mask, DBCtrls, ComCtrls;

type
  TfrmRunScript = class(TForm)
    CustomFileOpen1: TCustomFileOpen;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Edit3: TEdit;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure StatusBar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    procedure LoadScript(NextScript: Boolean);
  public
    { Public declarations }
  end;

var
  frmRunScript: TfrmRunScript;
  FirstShow: Boolean;

implementation

uses udmRunScript;

{$R *.DFM}

procedure TfrmRunScript.StatusBar1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFileDir(dmRunScript.dbOptimiza.DatabaseName);

  if OpenDialog1.Execute then
  begin

    if dmRunScript.OpenNew(OpenDialog1.FileName) then
    begin
      Statusbar1.Panels[1].Text := dmRunScript.dbOptimiza.DatabaseName;
      Edit1.Text := dbedit1.Text;
    end;

  end;

end;

procedure TfrmRunScript.FormCreate(Sender: TObject);
begin
  FirstShow:= True;

end;

procedure TfrmRunScript.FormShow(Sender: TObject);

begin
  if FirstShow then
  begin
    Statusbar1.Panels[1].Text := dmRunScript.dbOptimiza.DatabaseName;
    CustomFileOpen1.InitialDir := ExtractFileDir(dmRunScript.dbOptimiza.DatabaseName);
    Edit1.Text := dbedit1.Text;
    if Edit1.text <> '' then
      Edit1.text := IntToStr(StrToInt(Edit1.text));

    FirstShow:= False;

  end;

end;

procedure TfrmRunScript.Button1Click(Sender: TObject);
var
  ScriptCount: Integer;
  ScriptName, ScriptDir: String;
  Finished: Boolean;

begin

  ScriptDir := ExtractFileDir(CustomFileOpen1.FileName);

  if Edit1.text = '' then
  begin
    ScriptName := CustomFileOpen1.FileName;
    try
      ScriptCount := StrToInt(Copy(ScriptName,Length(ScriptName)-7,4));
    except
      ScriptCount := 0;
    end;

  end
  else
  begin
    ScriptCount := StrToInt(Edit1.text);
    Inc(ScriptCount);
    ScriptName := ScriptDir + '\script'+IntToStr(ScriptCount)+'.sql';
  end;

  Finished := False;

  Repeat

    Edit2.text := ScriptName;
    Edit2.Refresh;

    try
      Memo1.Lines.Clear;
      Memo1.Lines.LoadFromFile(ScriptName);

    except

      if ScriptCount = 0 then
      begin
        MessageDlg('Error loading file ' + ScriptName,mtError,[mbOK],0);
      end;

      Finished := True;
    end;

    if not Finished then
    begin

      if not dmRunScript.UpdateIt(ScriptName, ScriptCount,(dbEdit1.text <> '')) then
      begin
          Finished := True;
      end
      else
      begin
        Inc(ScriptCount);
        ScriptName := ScriptDir + '\script'+IntToStr(ScriptCount)+'.sql';
        Edit1.Text := IntToStr(ScriptCount);
        Edit1.Refresh;
      end;

    end;

  Until Finished;



end;

procedure TfrmRunScript.Button2Click(Sender: TObject);

begin
 LoadScript(True);

end;

procedure TfrmRunScript.LoadScript(NextScript: Boolean);
var
  ScriptCount: Integer;
  ScriptName, ScriptDir: String;
  Finished: Boolean;

begin

  ScriptDir := ExtractFileDir(CustomFileOpen1.FileName);

  if Edit1.text = '' then
  begin
    ScriptName := CustomFileOpen1.FileName;
    try
      ScriptCount := StrToInt(Copy(ScriptName,Length(ScriptName)-7,4));
    except
      ScriptCount := 0;
    end;


  end
  else
  begin
    ScriptCount := StrToInt(Edit1.text);

    if NextScript then
      Inc(ScriptCount);

    ScriptName := ScriptDir + '\script'+IntToStr(ScriptCount)+'.sql';
  end;

    Edit1.text := IntToStr(ScriptCount);

    Edit2.text := ScriptName;
    Edit2.Refresh;

    Memo1.Lines.Clear;
    Memo1.Lines.LoadFromFile(ScriptName);

end;

procedure TfrmRunScript.Button3Click(Sender: TObject);
begin

dmRunScript.UpdateIt(Edit2.text, StrToInt(Edit1.text),(dbEdit1.text <> ''));


end;

procedure TfrmRunScript.Button4Click(Sender: TObject);
begin
  dmRunScript.UpdateScriptNo(StrToInt(Edit3.text));
  Edit1.Text := Edit3.Text;
end;

procedure TfrmRunScript.Button5Click(Sender: TObject);
begin
  LoadScript(False);
end;

procedure TfrmRunScript.Button6Click(Sender: TObject);
var
  ScriptCount: Integer;
  ScriptName, ScriptDir: String;
  Finished: Boolean;

begin

  ScriptDir := ExtractFileDir(CustomFileOpen1.FileName);

  if Edit1.text = '' then
  begin
    ScriptName := CustomFileOpen1.FileName;
    try
      ScriptCount := StrToInt(Copy(ScriptName,Length(ScriptName)-7,4));
    except
      ScriptCount := 0;
    end;


  end
  else
  begin
    ScriptCount := StrToInt(Edit1.text);
    Dec(ScriptCount);
    ScriptName := ScriptDir + '\script'+IntToStr(ScriptCount)+'.sql';
  end;

    Edit1.text := IntToStr(ScriptCount);

    Edit2.text := ScriptName;
    Edit2.Refresh;

    Memo1.Lines.Clear;
    Memo1.Lines.LoadFromFile(ScriptName);

end;


procedure TfrmRunScript.Edit1Change(Sender: TObject);
begin
  Edit3.text := Edit1.text;
end;

end.
