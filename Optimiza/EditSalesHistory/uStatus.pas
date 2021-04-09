unit uStatus;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,DateUtils;

type
  TfrmStatus = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    LogFile : TextFile;
    StartTime : TDateTime;
    FirstShow:Boolean;
  public
    { Public declarations }
    procedure Say(Line : string);
    procedure OpenLogFile;
    procedure CloseLogFile;
  end;

var
  frmStatus: TfrmStatus;


implementation

uses udmData;

{$R *.DFM}

procedure TfrmStatus.Say(Line : string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Application.ProcessMessages;
end;

procedure TfrmStatus.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    Caption := AnsiReplaceStr(ExtractFileName(ParamStr(0)),'.exe','');

    Caption := Caption + ' ' + dmData.DbDescription;
    FirstShow := False;
  end;




end;

procedure TfrmStatus.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;



procedure TfrmStatus.OpenLogFile;
var
  FName:String;
  Year,Month,Day:Word;
  FCount:Integer;
begin
  FName := ExtractFileName(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.exe','');
  DecodeDate(Now, Year, Month, Day);
  FName := Format('%d%d%d '+FName+'.log', [Year, Month, Day]);

  for FCount := 1 to 100 do
  begin

    If FileExists(FName) then
    begin

      if FCount = 1 then
        FName := AnsiReplaceStr(FName,'.log',IntToStr(FCount)+'.log')
      else
        FName := AnsiReplaceStr(FName,IntToStr(FCount-1)+'.log',IntToStr(FCount)+'.log');


    end
    else
      Break;

  end;

  AssignFile(LogFile,FName );
  Rewrite(LogFile);

  Memo1.Clear;

  StartTime := Now;
  Say('Started on ' + DateTimeToStr(StartTime));
  Label1.Caption := '';


end;



procedure TfrmStatus.CloseLogFile;
begin
  Say('--------------------');
  Say('Finished on ' + DateTimeToStr(Now));
  Say(Format('Elapsed Time: %.2f seconds', [(Now - StartTime) * 86400]));
  CloseFile(LogFile);
end;

end.
