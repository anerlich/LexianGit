unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils,Math;

const
  _MaxField = 15;
  _FLocCode = 1;
  _FProdCode = 2;
  _FSupplier = 3;
  _FOrderNumber = 4;
  _FOrderDate = 5;
  _FEAD = 6;
  _FActualDelivery=7;
  _FQty = 8;

type
  TFieldInfo = record
    LTFieldName:String;
    SourceFieldName:String;
    Calculation:String;
    Data:String;
    SourceFieldNo:Integer;
  end;

  TSourceDataInfo = record
    FieldLen:Integer;
    Calculated:Boolean;
    Data:String;
  end;

  TImportFileType = (ftCSV, ftFixedLength);

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
    FFieldInfo:Array[1.._MaxField] of TFieldInfo;

    FSourceData:Array[1.._MaxField] of TSourceDataInfo;
    FFileType: TImportFileType;
    FDateFormat:String;
    FDayOffset:Integer;
    FMthOffset:Integer;
    FYearOffset:Integer;
    FYearLen:Integer;
    procedure Say(Line : string);
    procedure StartProcess;
    procedure GetFieldNames;
    procedure UpdateArray(StringOfData:String);
    function CalculateData(TargetArr:Integer):String;
    function ConvertMyDate(DateString:String):TDateTime;
    function ConvertMyQty(QtyString:String):Real;
    procedure SetDateFormat;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

uses uParameters, udmImport, uSetAppend;

{$R *.DFM}

procedure TfrmMain.Say(Line : string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Application.ProcessMessages;
end;

procedure TfrmMain.StartProcess;
var
  InFile:TextFile;
  FName,FIniName,StringOfData, ImportType: String;
  WCount,RCount:Integer;
  TempDate:String;
  InsertRecord:Boolean;
  LocCode,
  ProdCode,
  Supplier,
  OrderNumber:String;
  OrderDate,
  EAD,
  ActualDate,LastImportDate:TDateTime;
  Qty:Real;

begin



  try
    FName := frmParameters.ValueListEditor1.Values['Input Filename'];

    if frmParameters.ValueListEditor1.Values['File Format'] = 'CSV' then
      FFileType := ftCSV
    else
      FFileType := ftFixedLength;

    AssignFile(InFile,FName);
    Reset(InFile);

    Say('Opening : '+FName);

    {$IFDEF VER140}
ShortDateFormat := 'yyyy/mm/dd';
{$ELSE}
FormatSettings.ShortDateFormat := 'yyyy/mm/dd';
{$ENDIF}

    TempDate := frmParameters.ValueListEditor2.Values['Last Import Date'];

    if TempDate = '' then
      TempDate := '1980/01/01';

    LastImportDate := StrToDate(TempDate);

    ImportType :=  frmParameters.ValueListEditor1.Values['Append or Replace Data'];
    FDateFormat := frmParameters.ValueListEditor1.Values['Date Format'];

    Say('Append or Replace Data: '+ImportType);

   if ImportType = _Replace then
   begin
     Say('Clearing LT Analysis Table');
     dmImport.DeleteData;
   end
   else
     Say('Appending to LT Analysis Table');

   SetDateFormat;
   GetFieldNames;
   dmImport.InitParams;

   Wcount := 0;
   RCount := 0;

   if not dmImport.trnOptimiza.InTransaction then
     dmImport.trnOptimiza.StartTransaction;

   While not eof(InFile) do
   begin
     ReadLn(InFile,StringOfData);
     UpdateArray(StringOfData);

     InsertRecord := True;
     ActualDate := ConvertMyDate(FFieldInfo[_FActualDelivery].Data);

     if (ImportType = _AppendAllLast) or (ImportType = _AppendAllLastUpdate) then
     begin

       if ActualDate <= LastImportDate then
         InsertRecord := False;

     end;

     if InsertRecord then
     begin
      LocCode := FFieldInfo[_FLocCode].Data;
      ProdCode := FFieldInfo[_FProdCode].Data;
      Supplier := FFieldInfo[_FSupplier].Data;
      OrderNumber := FFieldInfo[_FOrderNumber].Data;
      OrderDate := ConvertMyDate(FFieldInfo[_FOrderDate].Data);
      EAD := ConvertMyDate(FFieldInfo[_FEAD].Data);
      QTY := ConvertMyQty(FFieldInfo[_FQty].Data);

      if not dmImport.InsertLTAnalysis(LocCode,ProdCode,Supplier,OrderNumber,
                        OrderDate,EAD,ActualDate,Qty) then
      begin
        Say('Product not imported : ' + ProdCode);
      end;

      inc(WCount);

      if WCount mod 10000 = 0 then
      begin

        Say('Committing After ' + IntToStr(WCount));
        dmImport.trnOptimiza.Commit;

        if not dmImport.trnOptimiza.InTransaction then
         dmImport.trnOptimiza.StartTransaction;

      end;


     end;

     inc(RCount);

      if RCount mod 50 = 0 then
      begin
        Label1.Caption := IntToStr(RCount);
        Application.ProcessMessages;

      end;


   end;

   if not dmImport.trnOptimiza.InTransaction then
     dmImport.trnOptimiza.StartTransaction;

   dmImport.trnOptimiza.Commit;


   //Update the download date
   if ImportType = _AppendAllLastUpdate then
   begin
     frmParameters.ValueListEditor2.Values['Last Import Date']:=FormatDateTime('yyyy/mm/dd',dmImport.GetDownloadDateAsDate);
     FIniName := AnsiReplaceStr(UpperCase(ParamStr(0)),'.EXE','.ini');
     frmParameters.ValueListEditor2.Strings.SaveToFile(FIniName);
   end;


   Say('Records written : '+IntToStr(WCount));
   Say('Total Records   : '+IntToStr(RCount));


    //-----------------------------------------------------------------------

     CloseFile(InFile);

    dmImport.FireEvent('S');

  except
      on e: exception do begin
        Say('*** Export excess failed');
        Say('*** ' + e.Message);
        dmImport.FireEvent('F');
      end;
  end;


end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  Year,Month,Day:Word;
  StartTime : TDateTime;
  FName:String;
  RunTheProcess:Boolean;

begin

  if FirstShow then
  begin
    Caption := Caption + ' ' + dmImport.DbDescription;
    FirstShow := False;

    //1st check to see if all necessary procs are in place
    if dmImport.CheckInstall then
    begin

      FName := AnsiReplaceStr(UpperCase(ParamStr(0)),'.EXE','.ini');

      RunTheProcess := False;

      if FileExists(FName) then
        frmParameters.ValueListEditor2.Strings.LoadFromFile(FName);

      if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) then
      begin

        if ParamStr(1) <> '' then
        begin
           frmParameters.edtParamFile.Text := ParamStr(1);
           frmParameters.ValueListEditor1.Strings.LoadFromFile(ParamStr(1));
        end;

        frmParameters.InitList;

        RunTheProcess := True;


      end
      else
      Begin
         if UpperCase(ParamStr(1)) = '-Z' then
         begin
          Memo1.Lines.add('Parameter Setup');
          frmParameters.Caption := 'Export excess Parameter Setup';


         if ParamStr(3) <> '' then
         begin
           frmParameters.edtParamFile.Text := ParamStr(3);
           frmParameters.ValueListEditor1.Strings.LoadFromFile(ParamStr(3));

         end;

          frmParameters.InitList;

          frmParameters.showmodal;

          if frmParameters.FExport then
          begin
             RunTheProcess := True;
          end;


         end
         else
         begin
           frmParameters.InitList;
           frmParameters.showmodal;

           if frmParameters.FExport then
           begin
             RunTheProcess := True;
           end;


         end;

      end;

      if RunTheProcess then
      begin
        StartTime := Now;
        DecodeDate(Now, Year, Month, Day);
        AssignFile(LogFile, Format('%d%d%d Export Excess.log', [Year, Month, Day]));
        Rewrite(LogFile);
        Say('Export excess started on ' + DateTimeToStr(StartTime));

        StartProcess;

        Say('Export excess finished on ' + DateTimeToStr(Now));
        Say(Format('Elapsed Time: %.2f seconds', [(Now - StartTime) * 86400]));

        CloseFile(LogFile);

      end;


    end
    else
    begin
      Say('*** All of the relevant procedures or triggers are not valid');
      Say('*** Aborting');
      dmImport.FireEvent('F');

    end;

    Close;


  end;



end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;


procedure TfrmMain.GetFieldNames;
var
  FCount,AFieldNo, ArrCount:Integer;
  AKeyName,AField,TempStr:String;
begin

  for ArrCount := 1 to _MaxField do
  begin
    FFieldInfo[ArrCount].LTFieldName := '';
    FFieldInfo[ArrCount].SourceFieldName := '';
    FFieldInfo[ArrCount].Calculation := '';
    FFieldInfo[ArrCount].Data := '';
    FFieldInfo[ArrCount].SourceFieldNo := 0;

    FSourceData[ArrCount].FieldLen := 0;
    FSourceData[ArrCount].Calculated := False;
    FSourceData[ArrCount].Data := '';
  end;

  with frmParameters.ValueListEditor1 do
  begin

    //Get the mandatory field info for LT analysis
    for FCount := 20 to Strings.Count do
    begin
      AKeyName := Cells[0,FCount];
      AField := Cells[1,FCount];

      if Trim(AField) <> '' then
      begin
        AFieldNo := StrToInt(Copy(AField,Pos(',',AField)+1,Length(AField)));
        AField := Copy(AField,1,Pos(',',AField)-1);

        TempStr := Values['Field'+IntToStr(AFieldNo)];
        TempStr := Copy(TempStr,Pos(',',TempStr)+1,Length(TempStr));

        FFieldInfo[FCount-19].LTFieldName := AnsiReplaceStr(AKeyName,' ','');
        FFieldInfo[FCount-19].SourceFieldName := AField;
        FFieldInfo[FCount-19].SourceFieldNo := AFieldNo;

        if Pos(',',TempStr) > 0 then
        begin
          FFieldInfo[FCount-19].Calculation := Copy(TempStr,Pos(',',TempStr)+1,Length(TempStr));
        end;

      end;

    end;

    //Get Field Lengths
      for FCount := 4 to 19 do
      begin
        TempStr := Values['Field'+IntToStr(FCount-3)];

        if Pos(',',TempStr) > 0 then
        begin
          TempStr := Copy(TempStr,Pos(',',TempStr)+1,Length(TempStr));

          if Pos(',',TempStr) > 0 then
          begin
            TempStr := Copy(TempStr,1,Pos(',',TempStr)-1);
            FSourceData[FCount-3].Calculated := True;
          end;

          FSourceData[FCount-3].FieldLen := StrToInt(TempStr);
        end;

      end;



  end;

  Say('Field Structure');
  Say('---------------');
  for ArrCount := 1 to _MaxField do
  begin
    if Trim(FFieldInfo[ArrCount].SourceFieldName) <> '' then
      Say('FieldNo'+IntToStr(ArrCount)+'->'+FFieldInfo[ArrCount].SourceFieldName+'='+FFieldInfo[ArrCount].LTFieldName);
  end;
  Say('---------------');

  Application.ProcessMessages;

end;

procedure TfrmMain.UpdateArray(StringOfData: String);

var
  ArrCount, PCount: Integer;
  aChar:String;
begin

  ArrCount := 1;
  PCount := 1;
  FSourceData[ArrCount].Data := '';

  if FFileType = ftCSV then
  begin

    if Length(StringOfData) > 15 then
    begin
      repeat
        aChar := Copy(StringOfData,PCount,1);

        if aChar = ',' then
        begin
          Inc(ArrCount);
          FSourceData[ArrCount].Data := '';
        end
        else
        begin
          FSourceData[ArrCount].Data := FSourceData[ArrCount].Data + aChar;
        end;

        inc(PCount);

      until (ArrCount > _MaxField) or (aChar = '');
    end;

  end
  else
  begin

    PCount := 1;

    for ArrCount := 1 to _MaxField do
    begin

      FSourceData[ArrCount].Data := Copy(StringOfData,PCount,FSourceData[ArrCount].FieldLen);
      PCount := PCount + FSourceData[ArrCount].FieldLen;

      if PCount >= Length(StringOfData) then
        break;

    end;

  end;

  //Now perform calculations
  for ArrCount := 1 to _MaxField do
  begin

    if FFieldInfo[Arrcount].Calculation = '' then
    begin
      FFieldInfo[Arrcount].Data := FSourceData[FFieldInfo[Arrcount].SourceFieldNo].Data;
    end
    else
    begin
      FFieldInfo[Arrcount].Data := CalculateData(ArrCount);
    end;


  end;



end;




function TfrmMain.CalculateData(TargetArr: Integer): String;
var
  CalcStr, FieldFormat,FieldData:String;
  FieldArr:Array[1..6]of Integer;
  ArrField:Array[1..6]of String;
  CCount,NumChars:Integer;
begin

  CalcStr := UpperCase(FFieldInfo[TargetArr].Calculation);
  Result := '';
  NumChars := 1;

  if Pos('FORMAT',CalcStr) > 0 then
  begin
    FieldFormat := Copy(CalcStr,Pos('FORMAT(',CalcStr)+8,Pos('[',CalcStr)-11);
    FieldData := Copy(CalcStr,Pos('[',CalcStr)+1,Length(CalcStr));
    FieldData := Copy(FieldData,1,Pos(']',FieldData)-1);

    For CCount := 1 to Length(FieldFormat) do
    begin

      if Copy(FieldFormat,CCount,1) = '%' then
      begin
        if Pos(',',FieldData) > 0 then
          FieldArr[NumChars] := StrToInt(Copy(FieldData,1,Pos(',',FieldData)-1))
        else
          FieldArr[NumChars] := StrToInt(FieldData);

        Inc(NumChars);
        FieldData := Copy(FieldData,Pos(',',FieldData)+1,Length(FieldData));

      end;

    end;

    For CCount :=  NumChars to 6 do
    begin
      FieldFormat := FieldFormat + '%s';
      FieldArr[CCount] := 0;
    end;

    For CCount := 1 to NumChars do
    begin
      ArrField[CCount] := FSourceData[FieldArr[CCount]].Data;
    end;

    Result := Format(FieldFormat,[ArrField[1],
                                  ArrField[2],
                                  ArrField[3],
                                  ArrField[4],
                                  ArrField[5],
                                  ArrField[6] ]);

  end;

end;

function TfrmMain.ConvertMyDate(DateString: String): TDateTime;
var
  Day,Month,Year:Word;
begin

  Day := StrToInt(Copy(DateString,FDayOffset,2));
  Month := StrToInt(Copy(DateString,FMthOffset,2));
  Year := StrToInt(Copy(DateString,FYearOffset,FYearLen));

  Result := EnCodeDate(Year,Month,Day);
end;

procedure TfrmMain.SetDateFormat;
begin
//use this routine because StrToDate causes errors on YYYYMMDD format
  FDayOffset := Pos('DD',FDateFormat);
  FMthOffset := Pos('MM',FDateFormat);
  FYearOffset := Pos('YYYY',FDateFormat);
  FYearLen := 4;

  if FYearOffSet = 0 then
  begin
    FYearOffset := Pos('YY',FDateFormat);
    FYearLen := 4;
  end;


end;

function TfrmMain.ConvertMyQty(QtyString: String): Real;
var
  NegativeMultiplier:Integer;
begin
  NegativeMultiplier := 1;

  //if trailing or leading negative
  //  remove and then re-apply because
  //  trailing negative will not convert.
  if Pos('-',QtyString) > 0 then
  begin
    NegativeMultiplier := -1;
    QtyString := AnsiReplaceStr(QtyString,'-','');
  end;

  QtyString := Trim(QtyString);
  Result := StrToFloat(QtyString) * NegativeMultiplier;

end;

end.
