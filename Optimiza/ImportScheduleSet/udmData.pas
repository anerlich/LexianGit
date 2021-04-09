unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery, IBTable,StrUtils;

type
  TDataImportType = (ditInteger,ditString);

  TDataImportField = record
    Name:String;
    DataType:TDataImportType;
    TypeOfString:String;
  end;

type
  TdmData = class(TdmOptimiza)
    tblSCHEDULERSETS: TIBTable;
    qryDelete: TIBQuery;
    tblSCHEDULE: TIBTable;
    qrySeqNo: TIBQuery;
    qryMaxSeqNo: TIBQuery;
  private
    { Private declarations }
    SchedulerDataType:Array of TDataImportField;
    procedure SetupFieldType(TheTable:TIBTable);
    procedure WriteData(TheTable:TIBTable);
    function GetSetSeqno(SeqID:String;SeqNo:Integer):Integer;
    function GetMaxSeqno(TableName:String):Integer;

  public
    { Public declarations }
    procedure SetupDataType(LineOfData,TableName: String);
    procedure ReadWriteData(LineOfData,TableName: String);
    procedure DeleteAllData;
    procedure SetSeqno;



  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

{ TdmExport }



{ TdmExport }



{ TdmData }


{ TdmData }


{ TdmData }

procedure TdmData.DeleteAllData;
begin

  with qryDelete do
  begin
    SQL.Clear;
    SQL.Add('Delete From Schedule');
    ExecSQL;
    Close;
    SQL.Clear;
    SQL.Add('Delete From SchedulerSets');
    ExecSQL;
    Close;

  end;

  trnOptimiza.Commit;
  trnOptimiza.StartTransaction;

end;

function TdmData.GetMaxSeqno(TableNAme: String): Integer;
var
  FieldName:String;
begin

  FieldName := 'ScheduleNo';

  if UpperCase(TableName) = 'SCHEDULERSETS' then
    FieldName := 'SchedulerSetNo';

  with qryMaxSeqNo do
  begin
    SQL.Clear;
    SQL.Add('Select Max('+FieldName+') as SeqNo ');
    SQL.Add(' from '+TableName);
    Open;
    Result := FieldByName('SeqNo').AsInteger;
  end;

end;

function TdmData.GetSetSeqno(SeqID:String;SeqNo: Integer): Integer;
begin

  with qrySeqNo do
  begin
    SQL.Clear;
    SQL.Add('Select Gen_id('+SeqID+'_SeqNo,'+IntToStr(SeqNo)+') as SeqNo ');
    SQL.Add(' from Configuration');
    SQL.Add(' where ConfigurationNo = 100');
    Open;
    Result := FieldByName('SeqNo').AsInteger;
  end;


end;

procedure TdmData.ReadWriteData(LineOfData,TableName: String);
var
  ArrCount, PCount: Integer;
  aChar:String;
begin

  ArrCount := 0;
  PCount := 1;
  SchedulerDataType[ArrCount].TypeOfString := '';

  if Length(LineOfData) > 15 then
  begin
    repeat
      aChar := Copy(LineOfData,PCount,1);

      if Copy(LineOfData,PCount,1) = ',' then
      begin

        Inc(ArrCount);
        SchedulerDataType[ArrCount].TypeOfString := '';

      end
      else
      begin

         if aChar <> #133 then
           SchedulerDataType[ArrCount].TypeOfString := SchedulerDataType[ArrCount].TypeOfString + aChar;

      end;

      inc(PCount);

    until (aChar = '') or (aChar = #133);


    if TableName = 'SHEDULERSETS' then
        WriteData(tblSCHEDULERSETS)
    else
        WriteData(tblSCHEDULE);

  end;



end;

procedure TdmData.SetSeqno;
var
  SeqNo,NewSeqNo:Integer;
begin

  //Get Current No
  SeqNo := GetSetSeqNo('SCHEDULERSETS',0);
  NewSeqNo := GetMaxSeqNo('SCHEDULERSETS');
  //Increment Seqno
  SeqNo := GetSetSeqNo('SCHEDULERSETS',NewSeqNo-SeqNo);

  //Get Current No
  SeqNo := GetSetSeqNo('SCHEDULER',0);
  NewSeqNo := GetMaxSeqNo('SCHEDULE');
  //Increment Seqno
  SeqNo := GetSetSeqNo('SCHEDULER',NewSeqNo-SeqNo);


end;

procedure TdmData.SetupDataType(LineOfData,TableName: String);
var
  ArrCount, PCount: Integer;
  aChar:String;
begin

  ArrCount := 0;
  PCount := 1;
  SetLength(SchedulerDataType,0);
  Inc(ArrCount);
  SetLength(SchedulerDataType,ArrCount);
  SchedulerDataType[ArrCount-1].Name := '';
  SchedulerDataType[ArrCount-1].TypeOfString := '';

  if Length(LineOfData) > 15 then
  begin
    repeat
      aChar := Copy(LineOfData,PCount,1);

      if Copy(LineOfData,PCount,1) = ',' then
      begin

        Inc(ArrCount);
        SetLength(SchedulerDataType,ArrCount);
        SchedulerDataType[ArrCount-1].Name := '';
        SchedulerDataType[ArrCount-1].TypeOfString := '';

      end
      else
      begin

         if aChar <> #133 then
           SchedulerDataType[ArrCount-1].Name := SchedulerDataType[ArrCount-1].Name + aChar;

      end;

      inc(PCount);

    until (aChar = '') or (aChar = #133);

  end;

  if TableName = 'SHEDULERSETS' then
        SetupFieldType(tblSCHEDULERSETS)
  else
        SetupFieldType(tblSCHEDULE);

end;

procedure TdmData.SetupFieldType(TheTable:TIBTable);
var
  ArrCount:Integer;
  FieldName:String;
begin

  with TheTable do
  begin
    Open;

    for ArrCount := 0 to High(SchedulerDataType) do
    begin

      if FieldDefs.IndexOf(SchedulerDataType[ArrCount].Name) > -1 then
      begin

        if FieldDefs.Items[FieldDefs.IndexOf(SchedulerDataType[ArrCount].Name)].DataType
                                                              in [ftInteger] then
          SchedulerDataType[ArrCount].DataType := ditInteger
        else
          SchedulerDataType[ArrCount].DataType := ditString;
      end;


    end;

  end;

end;


procedure TdmData.WriteData(TheTable: TIBTable);
var
  arrCount:Integer;
  TheData:String;
begin

  with TheTable do
  begin
    Insert;

    for ArrCount:=0 to High(SchedulerDataType) do
    begin
      TheData :=SchedulerDataType[ArrCount].TypeOfString;

      //Remove leading&trailing quotes if string type
      if SchedulerDataType[ArrCount].DataType = ditString then
      begin
        if Copy(TheData,Length(TheData),1) = '"' then
          TheData := LeftStr(TheData,Length(TheData)-1);

        if Copy(TheData,1,1) = '"' then
          TheData := Copy(TheData,2,Length(TheData));

      end;

      FieldByName(SchedulerDataType[ArrCount].Name).AsString := TheData;
    end;

    Post;
  end;


end;

end.
