unit uProgressForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls;

type
  TfrmProgressForm = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CreateLogFile;
  public
    { Public declarations }
    LogFile : TextFile;
    procedure Say(Line : string);
  end;

var
  frmProgressForm: TfrmProgressForm;

implementation

{$R *.DFM}

{ TfrmProgressForm }

procedure TfrmProgressForm.CreateLogFile;
var
  Year, Month, Day : word;
  logFileName: String;
begin
  logFileName := ExtractFileName(ParamStr(0));
  logFileName := StringReplace(logFileName,'.exe','.log',[rfIgnoreCase]);
  DecodeDate(Now, Year, Month, Day);
  AssignFile(LogFile, Format('%d%d%d '+logFileName, [Year, Month, Day]));
  Rewrite(LogFile);
end;

procedure TfrmProgressForm.Say(Line: string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Memo1.Refresh;
  Application.ProcessMessages;
end;

procedure TfrmProgressForm.FormCreate(Sender: TObject);
begin
  CreateLogFile;
end;

procedure TfrmProgressForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 CloseFile(LogFile);
end;

end.
