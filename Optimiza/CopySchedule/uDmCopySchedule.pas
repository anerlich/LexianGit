unit uDmCopySchedule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBDatabase, IBStoredProc, IBCustomDataSet, IBQuery, stdctrls,
  IBSQL, uCopySchedule;

type
  TdmCopySchedule = class(TdmOptimiza)
    qryAllLocations: TIBQuery;
    srcAllLocations: TDataSource;
    qrySuppliers: TIBQuery;
    srcsuppliers: TDataSource;
    qryScheduleList: TIBQuery;
    qryTaskList: TIBQuery;
    qryTask: TIBQuery;
    qryTaskMove: TIBQuery;
    qryTaskInsert: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    listNames: TStringList;
    listSchedulerSetNo: TStringList;
    listTasks: TStringList;
    listScheduleSequenceNo: TStringList;
    { Public declarations }
    function LoadScheduleList():TStringList;
    function LoadScheduleTasks(SchedulerSetNo: String):TStringList;
    function LoadScheduleTask(SchedulerSetNo,SCHEDULESEQUENCENO: String): ScheduleRec;
  end;

var
  dmCopySchedule: TdmCopySchedule;

implementation

{$R *.DFM}

procedure TdmCopySchedule.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryAllLocations.Active := True;
  qrysuppliers.Active := True;
end;


function TdmCopySchedule.LoadScheduleList:TStringList;
begin
  qryScheduleList.Active:= true;
  qryScheduleList.Open;
  listNames := TStringList.Create;
  listSchedulerSetNo := TStringList.Create;
  while (not qryScheduleList.Eof) do
  begin
    listNames.Add(qryScheduleList.FieldByName('Description').AsString);
    listSchedulerSetNo.Add(qryScheduleList.FieldByName('SchedulerSetNo').asString);
    qryScheduleList.Next;
  end;
  qryScheduleList.Close;
  Result := listNames;
end;


function TdmCopySchedule.LoadScheduleTasks(SchedulerSetNo: String):TStringList;
begin
  qryTaskList.Active:= true;
  qryTaskList.Close;
  qryTaskList.Params.ParamByName('SchedulerSetNo').AsString := SchedulerSetNo;
  qryTaskList.Open;
  listTasks := TStringList.Create;
  listScheduleSequenceNo := TStringList.Create;
  while (not qryTaskList.Eof) do
  begin
    listTasks.Add(qryTaskList.FieldByName('Description').AsString);
    listScheduleSequenceNo.Add(qryTaskList.FieldByName('ScheduleSequenceNo').asString);
    qryTaskList.Next;
  end;
  qryTaskList.Close;
  Result := listTasks;
end;


function TdmCopySchedule.LoadScheduleTask(SchedulerSetNo,SCHEDULESEQUENCENO: String):ScheduleRec;
var
  rec :  ScheduleRec;
begin
  qryTask.Active:= true;
  qryTask.Close;
  qryTask.Params.ParamByName('SchedulerSetNo').AsString := SchedulerSetNo;
  qryTask.Params.ParamByName('ScheduleSequenceNo').AsString := SCHEDULESEQUENCENO;
  qryTask.Open;
  while (not qryTask.Eof) do
  begin
    rec.Description := qryTask.FieldByName('Description').asString;
    rec.ExecutablePath := qryTask.FieldByName('ExecutablePath').asString;
    rec.Executable := qryTask.FieldByName('Executable').asString;
    rec.TaskActive := qryTask.FieldByName('TaskActive').asString;
    rec.WaitToFinish := qryTask.FieldByName('WaitToFinish').asString;
    rec.ExecutableParams := qryTask.FieldByName('ExecutableParams').asString;
    qryTask.Next;
  end;
  qryTask.Close;
  Result := rec;
end;


end.
