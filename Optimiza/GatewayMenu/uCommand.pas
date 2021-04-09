unit uCommand;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs,Clipbrd, Grids, ValEdit,StrUtils;

type
  TfrmCommand = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Label5: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    ComboBox1: TComboBox;
    Button3: TButton;
    Button4: TButton;
    vleVariables: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure LoadVariables;
    function ConvertVariablesToStr(InStr:String):String;
    function ConvertStrToVariables(InStr:String):String;
  end;

var
  frmCommand: TfrmCommand;

implementation

uses uFileWait, uDefinedPaths;

{$R *.dfm}

procedure TfrmCommand.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit2.Text := ExtractFilePath(OpenDialog1.FileName);

    Edit2.Hint := Edit2.Text;

    Edit2.Text := ConvertStrToVariables(Edit2.Text);

    Edit3.Text := ExtractFileName(OpenDialog1.FileName);
  end;

end;

procedure TfrmCommand.Button2Click(Sender: TObject);
var
  CmdLine,ClipText:String;
begin

  CmdLine := ConvertVariablesToStr(Edit2.Text) +
             Edit3.Text + ' ' +
             Edit6.Text + ' ' +
             ConvertVariablesToStr(Edit4.text);

  ExecuteFileWait(CmdLine,'');
  ClipText := Clipboard.AsText;

  if UpperCase(Copy(Cliptext,1,8)) = 'OPTIMIZA' then
  begin
    Edit4.Text := Copy(Cliptext,10,Length(ClipText));
     Edit4.Hint := Edit4.Text;
    Edit4.Text := ConvertStrToVariables(Edit4.Text);
  end;
end;

procedure TfrmCommand.Button3Click(Sender: TObject);
var
  lCount:Integer;
begin
  frmDefinedPaths.TabSheet1.TabVisible := False;
  frmDefinedPaths.TabSheet2.TabVisible := True;
  frmDefinedPaths.DefinedPaths := Edit2.Text;

  if frmDefinedPaths.ShowModal = mrOK then
  begin
    Edit2.Text := frmDefinedPaths.DefinedPaths;
    Edit2.Hint := frmDefinedPaths.Edit1.Text;
  end;

end;

procedure TfrmCommand.Button4Click(Sender: TObject);
begin
  frmDefinedPaths.TabSheet1.TabVisible := True;
  frmDefinedPaths.TabSheet2.TabVisible := False;

  if frmDefinedPaths.ShowModal = mrOK then
  begin
    LoadVariables;
  end;

end;

function TfrmCommand.ConvertStrToVariables(InStr: String): String;
var
  TempStr,NewStr:String;
  cCount:Integer;
begin

  //check that not already converted
  if Pos('[',InStr) = 0 then
  begin


    TempStr := '';
    InStr := UpperCase(InStr);

    Result := '';

    for cCount := 1 to vleVariables.RowCount-1 do
    begin
      TempStr := UpperCase(vleVariables.Cells[1,cCount]);
      NewStr := UpperCase('['+vleVariables.Cells[0,cCount]+']');

      if Pos(TempStr,InStr) > 0 then
        InStr := AnsiReplaceStr(InStr,TempStr,NewStr);

    end;

    Result := InStr;

  end
  else
    Result := InStr;   //nothing to convert

end;

function TfrmCommand.ConvertVariablesToStr(InStr: String): String;
var
  TempStr,NewStr:String;
  cCount:Integer;
begin

  //check if variables in string
  if Pos('[',InStr) > 0 then
  begin


    TempStr := '';

    Result := '';

    InStr := UpperCase(InStr);

    for cCount := 1 to vleVariables.RowCount-1 do
    begin
      TempStr := UpperCase('['+vleVariables.Cells[0,cCount]+']');
      NewStr := UpperCase(vleVariables.Cells[1,cCount]);

      if Pos(TempStr,InStr) > 0 then
        InStr := AnsiReplaceStr(InStr,TempStr,NewStr);

    end;

    Result := InStr;

    if (Pos('[',InStr) > 0) or (Pos(']',InStr) > 0) then
    begin
      MessageDlg('Error in folder path, check variables.',mtError,[mbOK],0);
    end;

  end
  else
    Result := InStr;   //nothing to convert




end;

procedure TfrmCommand.FormActivate(Sender: TObject);
begin
  LoadVariables;
end;

procedure TfrmCommand.LoadVariables;
var
  AFileName:String;
  vCount:Integer;
begin
  AFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_var.dat';

  if FileExists(aFileName) then
    vleVariables.Strings.LoadFromFile(AFileName);

end;

end.
