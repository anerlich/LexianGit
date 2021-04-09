unit uStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,StrUtils;

type
  TfrmStatus = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
  private
    { Private declarations }
    LogFile : TextFile;
  public
    { Public declarations }
    procedure OpenLogFile;
    procedure Say(Line : string;ToScreen:Boolean=True);
    procedure CloseLogFile;
  end;

var
  frmStatus: TfrmStatus;

implementation

uses udmData;

{$R *.dfm}

{ TfrmStatus }

procedure TfrmStatus.CloseLogFile;
begin
  CloseFile(LogFile);
end;

procedure TfrmStatus.OpenLogFile;
var
  FName:String;
  Year,Month,Day:Word;
  FCount:Integer;
begin
  FName := dmData.GetLogFileName;

  AssignFile(LogFile,FName );
  Rewrite(LogFile);

end;

procedure TfrmStatus.Say(Line: string; ToScreen: Boolean);
begin
  if ToScreen then
    Memo1.Lines.Add(Line);

  WriteLn(LogFile, Line);
  Application.ProcessMessages;
end;

end.
