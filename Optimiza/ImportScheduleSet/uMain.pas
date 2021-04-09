unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils,DB;





type
  TfrmMain = class(TForm)
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
    FirstShow:Boolean;
    procedure Say(Line : string);
    procedure StartProcess;
    procedure OpenLogFile;
    function GetParam(ParamName: String): String;

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

uses udmData, uParameters;

{$R *.DFM}

procedure TfrmMain.Say(Line : string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Application.ProcessMessages;
end;

procedure TfrmMain.StartProcess;
var
    ProdCode,Style,Col,Size,Dim,StringOfData:String;
    RecCount, WCount,CCount,ArrCount:Integer;
    OutStr,AField,TempStr,LocCode,NewCode: String;
    SchedulerFile,SchedulerSetFile:TextFile;
    LT:Real;

begin

  Say('Start');


  try



      frmParameters.LoadParam;
      Say('Parameter File: '+frmParameters.edtIniFile.Text);

      RecCount := 0;
      WCount := 0;


      dmData.DeleteAllData;

      if not dmData.trnOptimiza.InTransaction then
        dmData.trnOptimiza.StartTransaction;

      //------------------------------------------------------------------
      Say('Opening : '+GetParam('Scheduler Set File Name'));
      AssignFile(SchedulerSetFile,GetParam('Scheduler Set File Name'));
      Reset(SchedulerSetFile);

      ReadLn(SchedulerSetFile,StringOfData);
      dmData.SetupDataType(StringOfData,'SHEDULERSETS');


      While not eof(SchedulerSetFile) do
      begin

        ReadLn(SchedulerSetFile,StringOfData);
        dmData.ReadWriteData(StringOfData,'SHEDULERSETS');
        inc(RecCount);
        Label1.Caption := IntToStr(REcCount);
        Application.ProcessMessages;

      end;

      //------------------------------------------------------------------
      Say('Opening : '+GetParam('Schedule File Name'));
      AssignFile(SchedulerFile,GetParam('Schedule File Name'));
      Reset(SchedulerFile);

      ReadLn(SchedulerFile,StringOfData);
      dmData.SetupDataType(StringOfData,'SHEDULE');


      While not eof(SchedulerFile) do
      begin

        ReadLn(SchedulerFile,StringOfData);
        dmData.ReadWriteData(StringOfData,'SHEDULE');
        inc(RecCount);
        Label1.Caption := IntToStr(REcCount);
        Application.ProcessMessages;

      end;

      //------------------------------------------------------------------
      Say('Records read : '+IntToStr(RecCount));
      CloseFile(SchedulerSetFile);
      CloseFile(SchedulerFile);

      dmData.SetSeqno;
      
      dmData.trnOptimiza.Commit;
      dmData.trnOptimiza.StartTransaction;


      dmData.FireEvent('S');

  except
      on e: exception do begin
        Say('***  failed');
        Say(StringOfData);
        Say('*** ' + e.Message);
        dmData.FireEvent('F');
      end;
  end;


end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  StartTime : TDateTime;
  RunProcess:Boolean;
  FName:String;
begin

  if FirstShow then
  begin
    Caption := AnsiReplaceStr(ExtractFileName(ParamStr(0)),'.exe','');
    
    Caption := Caption + ' ' + dmData.DbDescription;
    FirstShow := False;

    if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) then
    begin
      frmParameters.edtIniFile.Text := ParamStr(1);
      RunProcess := True;

    end
    else
    Begin

      Memo1.Lines.add('Parameter Setup');
      frmParameters.Caption := 'Parameter Setup';

       if UpperCase(ParamStr(1)) = '-Z' then
       begin

        frmParameters.edtIniFile.Text := ParamStr(3);
        frmParameters.LoadParam;


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



procedure TfrmMain.OpenLogFile;
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

end;

function TfrmMain.GetParam(ParamName: String): String;
begin
  Result := frmParameters.vleParameters.Values[ParamName];
end;



end.
