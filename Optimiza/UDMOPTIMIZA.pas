unit uDmOptimiza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db,  Registry, IBDatabase, IBStoredProc, IBCustomDataSet,
  IBQuery, Math, IBSQL,StrUtils;

type
  TypeofDate= Array[0..1] Of TdateTime;

  ForecastTypeRec = record
    AllTheSame: Boolean;
    ForecastArray: Array[0..11] of Real;
  end;


type
  TdmOptimiza = class(TDataModule)
    dbOptimiza: TIBDatabase;
    qryLocation: TIBQuery;
    prcFireEvent: TIBStoredProc;
    trnOptimiza: TIBTransaction;
    qryDownloadDate: TIBQuery;
    qryCalendarPeriod: TIBQuery;
    srcCalendarPeriod: TDataSource;
    qryCalendarDate: TIBQuery;
    qryForecastAndPolicy: TIBQuery;
    srcForecastAndPolicy: TDataSource;
    qryGetCurrentPeriod: TIBQuery;
    qryForecastAndPolicyLOCATIONCODE: TIBStringField;
    qryForecastAndPolicyPRODUCTCODE: TIBStringField;
    qryForecastAndPolicyGENERIC: TIBStringField;
    qryForecastAndPolicyPRIMARYCHILD: TIBStringField;
    qryForecastAndPolicySTOCKINGINDICATOR: TIBStringField;
    qryForecastAndPolicyPARETOCATEGORY: TIBStringField;
    qryForecastAndPolicySAFETYSTOCK: TFloatField;
    qryForecastAndPolicyLEADTIME: TFloatField;
    qryForecastAndPolicyREVIEWPERIOD: TFloatField;
    qryForecastAndPolicyREPLENISHMENTCYCLE: TFloatField;
    qryForecastAndPolicyBINLEVEL: TFloatField;
    qryForecastAndPolicyCALENDARNO: TIntegerField;
    qryForecastAndPolicyF0: TFloatField;
    qryForecastAndPolicyF1: TFloatField;
    qryForecastAndPolicyF2: TFloatField;
    qryForecastAndPolicyF3: TFloatField;
    qryForecastAndPolicyF4: TFloatField;
    qryForecastAndPolicyF5: TFloatField;
    qryForecastAndPolicyF6: TFloatField;
    qryForecastAndPolicyF7: TFloatField;
    qryForecastAndPolicyF8: TFloatField;
    qryForecastAndPolicyF9: TFloatField;
    qryForecastAndPolicyF10: TFloatField;
    qryForecastAndPolicyF11: TFloatField;
    qryForecastAndPolicyBF0: TFloatField;
    qryForecastAndPolicyBF1: TFloatField;
    qryForecastAndPolicyBF2: TFloatField;
    qryForecastAndPolicyBF3: TFloatField;
    qryForecastAndPolicyBF4: TFloatField;
    qryForecastAndPolicyBF5: TFloatField;
    qryForecastAndPolicyBF6: TFloatField;
    qryForecastAndPolicyBF7: TFloatField;
    qryForecastAndPolicyBF8: TFloatField;
    qryForecastAndPolicyBF9: TFloatField;
    qryForecastAndPolicyBF10: TFloatField;
    qryForecastAndPolicyBF11: TFloatField;
    qryForecastAndPolicyGF0: TFloatField;
    qryForecastAndPolicyGF1: TFloatField;
    qryForecastAndPolicyGF2: TFloatField;
    qryForecastAndPolicyGF3: TFloatField;
    qryForecastAndPolicyGF4: TFloatField;
    qryForecastAndPolicyGF5: TFloatField;
    qryForecastAndPolicyGF6: TFloatField;
    qryForecastAndPolicyGF7: TFloatField;
    qryForecastAndPolicyGF8: TFloatField;
    qryForecastAndPolicyGF9: TFloatField;
    qryForecastAndPolicyGF10: TFloatField;
    qryForecastAndPolicyGF11: TFloatField;
    qryForecastAndPolicyCO0: TFloatField;
    qryForecastAndPolicyCO1: TFloatField;
    qryForecastAndPolicyCO2: TFloatField;
    qryForecastAndPolicyCO3: TFloatField;
    qryForecastAndPolicyCO4: TFloatField;
    qryForecastAndPolicyCO5: TFloatField;
    qryForecastAndPolicyCO6: TFloatField;
    qryForecastAndPolicyCO7: TFloatField;
    qryForecastAndPolicyCO8: TFloatField;
    qryForecastAndPolicyCO9: TFloatField;
    qryForecastAndPolicyCO10: TFloatField;
    qryForecastAndPolicyCO11: TFloatField;
    qryForecastAndPolicySALESAMOUNT_0: TFloatField;
    qryForecastAndPolicySTOCKONHAND: TFloatField;
    qryForecastAndPolicyBACKORDER: TFloatField;
    qryForecastAndPolicyCOSTPRICE: TFloatField;
    qryForecastAndPolicyRETAILPRICE: TFloatField;
    qryForecastAndPolicyGROUPCODE: TIBStringField;
    qryForecastAndPolicyPRODUCTDESCRIPTION: TIBStringField;
    qryForecastAndPolicyGROUPMINOR1DESC: TIBStringField;
    qryForecastAndPolicyUSERCHAR1: TIBStringField;
    qryForecastAndPolicyEFFECTIVERC: TFloatField;
    qryCheckProcedure: TIBQuery;
    qryInstallProcedure: TIBSQL;
    qrySelectLocation: TIBQuery;
    srcSelectLocation: TDataSource;
    qryLocationListCodes: TIBQuery;
    qryGetConfiguration: TIBQuery;
    ReadConfig: TIBSQL;
    ReadConfigLoc: TIBSQL;
    qryCode: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
    function GetLocationNo(Location: String):Integer;
    function GetLocationDesc(Location: String):String;
    function GetDownloadDate:String;
    function GetDownloadDateAsDate:TDateTime;
    function GetCalendarPeriod(InDate: String):Integer;
    function FireEvent(SuccessFail: Char):Boolean;
    function GetCalendarDate(CalendarNo: Integer):TypeOfDate;
    function PeriodToUnit(PeriodValue: Real;Fcs: ForecastTypeRec):Real;
    function GetCurrentPeriod:Integer;
    procedure OpenForecastAndPolicy;
    procedure GetForecasts(var ForecastData:ForecastTypeRec);

  private
    { Private declarations }
    FProrateFactor: Real;
    FDbDescription:String;
    FDebugTemplate:Boolean;
    FConnected:Boolean;

    Procedure SetProrateFactor(Value: Real);
    procedure GetBuildInfo(var V1, V2, V3, V4: Word);

  public
    { Public declarations }
    function getProrate:Real;
    property ProrateFactor: Real read FProrateFactor write SetProrateFactor;
    property DbDescription: String read FDbDescription write FDbDescription;
    property DebugTemplate: Boolean read FDebugTemplate write FDebugTemplate;
    function kfVersionInfo: String;
    function DoesProcedureExist(ProcName: String): Boolean;
    function InstallProcedure(ProcName, FileName: String):Boolean;
    procedure CreateTemplateSQL(TemplateNo, UserNo, LocationNo : integer;
                                var SQL, JoinClause : TStringList);
    function GetLocationListNo(LocCodes:String):String;
    function GetConfigAsString(ConfigNo:Integer):String;
    function GetOptimizaVersion:Real;
    function GetCompanyName:String;
    function ReadConfigInt(ConfigNo : integer) : integer;overload;
    function ReadConfigInt(ConfigNo,LocationNo : integer) : integer;overload;
    function ReadConfigFloat(ConfigNo : integer) : double;overload;
    function ReadConfigStr(ConfigNo : integer) : string;
    function ReadConfigLongStr(ConfigNo : integer) : string;
    function ReadConfigDate(ConfigNo : integer) : TDateTime;
    function ReadConfigFloat(ConfigNo,LocationNo : integer) : double;overload;
    function GetLogFileName:String;
    function WindowsLogonAs(aUserName,aDomainName,aPassword:String): Cardinal;
   // function WindowsTestLogonAs(aUserName, aDomainName,aPassword: String): Boolean;
   end;

var
  dmOptimiza: TdmOptimiza;






implementation

//uses uCompany;



{$R *.DFM}
procedure TdmOptimiza.DataModuleCreate(Sender: TObject);
Var
  cVar, cPth,aClassName,aParentName: String;
  SvpReg: TRegistry;
  ClassRef: TClass;
Const svpPath = 'Path';
begin

  ClassRef := Sender.ClassType;
  aClassName := '';

  if ClassRef <> nil then
    aClassName := UpperCase(ClassRef.ClassName);

    //IMPORTANT - the database name will not appear in the registry unless it is
    //connected at USER level via Optimiza Database Manager

    svpReg := Tregistry.Create;
    svpReg.Access := KEY_READ;
    svpreg.RootKey :=   HKEY_CURRENT_USER;
    cVar := 'SOFTWARE\Execulink\Optimiza\Database' ;
    cPth := '';

    If svpReg.OpenKey(cVar,False) = True then Begin
     cPth := svpReg.ReadString(svpPath);
     FDbDescription := svpReg.ReadString('Name');
    End;

    if cPth = '' then
    Begin
     svpreg.RootKey :=   HKEY_LOCAL_MACHINE;
     cVar := 'SOFTWARE\Execulink\Svp\Database' ;
     cPth := '';

     If svpReg.OpenKey(cVar,False) = True then Begin
       cPth := svpReg.ReadString(svpPath);
       FDbDescription := svpReg.ReadString('Name');
     End;
    End;

    svpReg.CloseKey;
    svpReg.Free;

    Application.ProcessMessages;

    With dbOptimiza do Begin
      dbOptimiza.Connected := False;
      DatabaseName := cPth       ;
      Params.Clear;
      Params.Add('user_name=sysdba');
      Params.Add('password=masterkey');
      Application.ProcessMessages;
      Connected := True;
    End;

  //Only execute this in the inherited datamodule
  if aClassName <> 'TDMOPTIMIZA' then
  begin

  end;

end;

function TdmOptimiza.GetLocationNo(Location: String):Integer;
begin
    With qryLocation do begin
      //dmOptimiza.qryLocation.Active := False;
      Active := False;
      ParamByName('iLocation').AsString := Location;
      Active := True;
      Result := FieldByName('LocationNo').AsInteger;
      Active := False;
    end;
end;

function TdmOptimiza.GetDownloadDate:String;
begin
    Application.ProcessMessages;
//    With dmOptimiza.qryDownloadDate do begin
//            dmOptimiza.qryDownloadDate.Active := True;
    With qryDownloadDate do begin
            qryDownloadDate.Active := True;
      Result := DateTimeToStr(FieldByName('TYPEOFDATE').AsDateTime);
      Active := False;
    end;
end;

function TdmOptimiza.GetCurrentPeriod:Integer;
begin

    With qryGetCurrentPeriod do begin
      Active := True;
      Result := FieldByName('TypeOfInteger').AsInteger;
      Active := False;
    end;
end;

function TdmOptimiza.GetCalendarPeriod(InDate: String):Integer;
begin
  InDate := FormatDateTime('mm/dd/yyyy',StrToDateTime(InDate));


    With qryCalendarPeriod do begin
      Active := False;
      SQL.Clear;
      SQL.Add('select * from Calendar where startdate <= "'+
              InDate + '" and enddate >= "' + InDate + '"');
      Active := True;

      Result := srcCalendarPeriod.Dataset.FieldByName('CalendarNo').AsInteger;

    end;

end;

function TdmOptimiza.GetCalendarDate(CalendarNo: Integer):TypeOfDate;
var
  DateArray: TypeofDate;
begin

   With qryCalendarDate do begin
      Active := False;
      SQL.Clear;
      SQL.Add('select * from Calendar where CalendarNo = '+IntToStr(CalendarNo));
      Active := True;
      DateArray[0] := qryCalendarDate.FieldByName('StartDate').AsDateTime;
      DateArray[1] := qryCalendarDate.FieldByName('EndDate').AsDateTime;

      Result := DateArray;

    end;

end;

function TdmOptimiza.FireEvent(SuccessFail: Char):Boolean;
begin

  //prcFireEvent.Params.Clear;
  try
    With prcFireEvent do begin

      if  not trnOptimiza.InTransaction then
        trnOptimiza.StartTransaction;

      Params[0].Value :=SuccessFail;
      Prepare;
      ExecProc;
      trnOptimiza.Commit;
      Result := True;
    end;
  except
    Result := False;
  end;



end;

procedure TdmOptimiza.SetProrateFactor(Value: Real);
var
  DownDate: String;
  DownDateAsDate: TdateTime;
  StartEnd: TypeofDate;
  Year,Month,StartDay,EndDay,DownDay,DaysInMonth: Word;
  ConvertNum: Real;
begin
  DownDate := GetDownloadDate;
  DownDateAsDate := StrToDateTime(DownDate);
  StartEnd := GetCalendarDate(GetCalendarPeriod(DownDate));

  DecodeDate(StartEnd[0],Year,Month,StartDay);
  DecodeDate(StartEnd[1],Year,Month,EndDay);

  DaysInMonth := EndDay - StartDay+1;
  DecodeDate(DownDateAsDate,Year,Month,DownDay);

  ConvertNum := (DaysInMonth - DownDay) / DaysInMonth;

  ConvertNum := StrToFloat(FormatFloat('000.00',ConvertNum));
  FProrateFactor := ConvertNum;
end;

procedure TdmOptimiza.OpenForecastAndPolicy;
var
  CurrentPeriod: Integer;
begin
  CurrentPeriod := GetCurrentPeriod;

  With qryForecastAndPolicy do
  Begin
    Active := False;
    ParamByName('CALENDARNO').Value := CurrentPeriod;
    Active := True;
  end;

end;

function TdmOptimiza.PeriodToUnit(PeriodValue: Real;Fcs: ForecastTypeRec):Real;
var


  Counter: Integer;
begin

  IF PeriodValue < ProrateFactor then
    Result := Fcs.ForecastArray[0] / ProrateFactor * PeriodValue
  Else
    IF Fcs.AllTheSame Then
      Result := Fcs.ForecastArray[0] + ((PeriodValue - ProrateFactor) * fcs.Forecastarray[1])
    Else
    Begin
        Result := Fcs.ForecastArray[0];
        PeriodValue := PeriodValue - ProrateFactor;

        For Counter :=  1 to 11 do
        begin

          IF PeriodValue <= 1 Then
          begin
            Result := Result + (Fcs.ForecastArray[Counter] * PeriodValue);
            PeriodValue := 0;
            Break;
          end
          Else
          begin
            PeriodValue := PeriodValue - 1;
            Result := Result + Fcs.ForecastArray[Counter];
          end;

        end;

        //Need to code for Forecast past the end if periods consume all
        // 12 forecasts.
        If PeriodValue <> 0 then
          Result := Result + (Fcs.ForecastArray[11] * PeriodValue);

    end;



end;

procedure TdmOptimiza.GetForecasts(var ForecastData:ForecastTypeRec);
var
  UpFC, DnFC, FirstFC, ThisFC, Counter: Integer;
  Sts: String;

begin

With ForecastData do
begin
  AllTheSame := True;
  Sts := qryForecastAndPolicyStockingIndicator.Value;

  //ForecastArray[0] := qryForecastAndPolicyF0.Value * ProrateFactor;
  If Sts = 'Y' then
  begin
    ForecastArray[0] := Max(qryForecastAndPolicyCO0.Value,qryForecastAndPolicyF0.Value)
                     +qryForecastAndPolicyBF0.Value
                     +qryForecastAndPolicyGF0.Value;

    ForecastArray[0] := Max(0,ForecastArray[0]-qryForecastAndPolicySALESAMOUNT_0.Value);

    ForecastArray[1] :=  Max(qryForecastAndPolicyCO1.Value,qryForecastAndPolicyF1.Value)
                     +qryForecastAndPolicyBF1.Value
                     +qryForecastAndPolicyGF1.Value;
    ForecastArray[2] :=  Max(qryForecastAndPolicyCO2.Value,qryForecastAndPolicyF2.Value)
                     +qryForecastAndPolicyBF2.Value
                     +qryForecastAndPolicyGF2.Value;
    ForecastArray[3] :=  Max(qryForecastAndPolicyCO3.Value,qryForecastAndPolicyF3.Value)
                     +qryForecastAndPolicyBF3.Value
                     +qryForecastAndPolicyGF3.Value;
    ForecastArray[4] :=  Max(qryForecastAndPolicyCO4.Value,qryForecastAndPolicyF4.Value)
                     +qryForecastAndPolicyBF4.Value
                     +qryForecastAndPolicyGF4.Value;
    ForecastArray[5] :=  Max(qryForecastAndPolicyCO5.Value,qryForecastAndPolicyF5.Value)
                     +qryForecastAndPolicyBF5.Value
                     +qryForecastAndPolicyGF5.Value;
    ForecastArray[6] :=  Max(qryForecastAndPolicyCO6.Value,qryForecastAndPolicyF6.Value)
                     +qryForecastAndPolicyBF6.Value
                     +qryForecastAndPolicyGF6.Value;
    ForecastArray[7] :=  Max(qryForecastAndPolicyCO7.Value,qryForecastAndPolicyF7.Value)
                     +qryForecastAndPolicyBF7.Value
                     +qryForecastAndPolicyGF7.Value;
    ForecastArray[8] :=  Max(qryForecastAndPolicyCO8.Value,qryForecastAndPolicyF8.Value)
                     +qryForecastAndPolicyBF8.Value
                     +qryForecastAndPolicyGF8.Value;
    ForecastArray[9] :=  Max(qryForecastAndPolicyCO9.Value,qryForecastAndPolicyF9.Value)
                     +qryForecastAndPolicyBF9.Value
                     +qryForecastAndPolicyGF9.Value;
    ForecastArray[10] :=  Max(qryForecastAndPolicyCO10.Value,qryForecastAndPolicyF10.Value)
                      +qryForecastAndPolicyBF10.Value
                      +qryForecastAndPolicyGF10.Value;
    ForecastArray[11] :=  Max(qryForecastAndPolicyCO11.Value,qryForecastAndPolicyF11.Value)
                      +qryForecastAndPolicyBF11.Value
                      +qryForecastAndPolicyGF11.Value;

  end
  Else
  begin
    //ForecastArray[0] := Max(qryForecastAndPolicyCO0.Value,ForecastArray[0])
    //                 +qryForecastAndPolicyBF0.Value
    //                 +qryForecastAndPolicyGF0.Value;
    //ForecastArray[0] := Max(0,ForecastArray[0]-qryForecastAndPolicySALESAMOUNT_0.Value);
    ForecastArray[0] := 0;

    ForecastArray[1] :=  qryForecastAndPolicyCO1.Value
                     +qryForecastAndPolicyBF1.Value
                     +qryForecastAndPolicyGF1.Value;
    ForecastArray[2] :=  qryForecastAndPolicyCO2.Value
                     +qryForecastAndPolicyBF2.Value
                     +qryForecastAndPolicyGF2.Value;
    ForecastArray[3] :=  qryForecastAndPolicyCO3.Value
                     +qryForecastAndPolicyBF3.Value
                     +qryForecastAndPolicyGF3.Value;
    ForecastArray[4] :=  qryForecastAndPolicyCO4.Value
                     +qryForecastAndPolicyBF4.Value
                     +qryForecastAndPolicyGF4.Value;
    ForecastArray[5] :=  qryForecastAndPolicyCO5.Value
                     +qryForecastAndPolicyBF5.Value
                     +qryForecastAndPolicyGF5.Value;
    ForecastArray[6] :=  qryForecastAndPolicyCO6.Value
                     +qryForecastAndPolicyBF6.Value
                     +qryForecastAndPolicyGF6.Value;
    ForecastArray[7] :=  qryForecastAndPolicyCO7.Value
                     +qryForecastAndPolicyBF7.Value
                     +qryForecastAndPolicyGF7.Value;
    ForecastArray[8] :=  qryForecastAndPolicyCO8.Value
                     +qryForecastAndPolicyBF8.Value
                     +qryForecastAndPolicyGF8.Value;
    ForecastArray[9] :=  qryForecastAndPolicyCO9.Value
                     +qryForecastAndPolicyBF9.Value
                     +qryForecastAndPolicyGF9.Value;
    ForecastArray[10] := qryForecastAndPolicyCO10.Value
                      +qryForecastAndPolicyBF10.Value
                      +qryForecastAndPolicyGF10.Value;
    ForecastArray[11] := qryForecastAndPolicyCO11.Value
                      +qryForecastAndPolicyBF11.Value
                      +qryForecastAndPolicyGF11.Value;
  end;

  FirstFC := Round(Forecastarray[0]);

  If (FirstFC > 10) or (FirstFC = 0) then
  begin
    UpFC := FirstFC + 1;
    DnFC := FirstFC - 1;
  end
  else
  begin
    UpFC := FirstFC;
    DnFC := FirstFC;
  end;

  For Counter := 1 to 11 do
  begin
    ThisFC := Round(ForecastArray[Counter]);
    AllTheSame := (AllTheSame) and ((ThisFC  <= UpFc)  and (ThisFC >= DnFc));
  end;


end;

end;

procedure TdmOptimiza.GetBuildInfo(var V1, V2, V3, V4: Word);
var
   VerInfoSize, VerValueSize, Dummy : DWORD;
   VerInfo : Pointer;
   VerValue : PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

  With VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;

  FreeMem(VerInfo, VerInfoSize);

end;

function TdmOptimiza.kfVersionInfo: String;
var
  V1,       // Major Version
  V2,       // Minor Version
  V3,       // Release
  V4: Word; // Build Number
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.'
            + IntToStr(V2); // + '.';
            //+ IntToStr(V3) + '.'
            //+ IntToStr(V4);
end;

function TdmOptimiza.getProrate: Real;
var
  DownDate: String;
  DownDateAsDate: TdateTime;
  StartEnd: TypeofDate;
  Year,Month,StartDay,EndDay,DownDay,DaysInMonth: Word;
  ConvertNum: Real;
begin
  DownDate := GetDownloadDate;
  DownDateAsDate := StrToDateTime(DownDate);
  StartEnd := GetCalendarDate(GetCalendarPeriod(DownDate));

  DecodeDate(StartEnd[0],Year,Month,StartDay);
  DecodeDate(StartEnd[1],Year,Month,EndDay);

  DaysInMonth := (EndDay - StartDay)+1;
  DecodeDate(DownDateAsDate,Year,Month,DownDay);

  ConvertNum := (DaysInMonth - DownDay+1) / DaysInMonth;

  ConvertNum := StrToFloat(FormatFloat('000.00',ConvertNum));
  Result := ConvertNum;
end;


function TdmOptimiza.DoesProcedureExist(ProcName: String): Boolean;
begin
  Result := False;

  ProcName := UpperCase(ProcName);

  try

    with qryCheckProcedure do
    begin
      ParamByName('ProcNAme').AsString := ProcName;
      Prepare;
      Open;

      if Trim(FieldByName('rdb$Procedure_Name').AsString) = ProcName then
        Result := True;

      Close;
    end;

  except

  end;

end;

function TdmOptimiza.InstallProcedure(ProcName, FileName: String):Boolean;
begin

  Result := True;

  try
    if not trnOptimiza.InTransaction then
      trnOptimiza.StartTransaction;

    with qryInstallProcedure do
    begin
      SQL.Clear;
      SQL.LoadFromFile(FileName);
      ExecQuery;
      trnOptimiza.Commit;
      trnOptimiza.StartTransaction;
    end;

  except
    Result := False;
  end;

end;

function TdmOptimiza.GetDownloadDateAsDate: TdateTime;
begin

    With qryDownloadDate do begin
      Active := True;
      Result := FieldByName('TypeOfDate').AsDateTime;
      Active := False;
    end;

end;

procedure TdmOptimiza.CreateTemplateSQL(TemplateNo, UserNo,
  LocationNo: integer; var SQL, JoinClause: TStringList);
var
  Line, JoinLine,InOrNotIn, tmpstr, CodeList : string;
  FirstOne : boolean;
  Count, WhereCount : integer;
  Template, TemplateMajorGroups,
  TemplateMinorGroups1,
  TemplateMinorGroups2,
  TemplateSuppliers,
  TemplateRepCats,
  TemplateUserConditions : TIBSQL;
  CurrentRepCatType : integer;

begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  Template := TIBSQL.Create(nil);
  Template.Database := dbOptimiza;
  Template.Transaction := trnOptimiza;
  Template.SQL.Clear;
  Template.SQL.Add('select TEMPLATENO, USERNO, DESCRIPTION, TEMPLATETYPE, MAJORGROUP, MINORGROUP1,');
  Template.SQL.Add('MINORGROUP2, PARETO_A, PARETO_B, PARETO_C, PARETO_D, PARETO_E, PARETO_F,');
  Template.SQL.Add('PARETO_M, PARETO_X, CRITICALITY_1, CRITICALITY_2, CRITICALITY_3, CRITICALITY_4,');
  Template.SQL.Add('CRITICALITY_5, STOCKED, NONSTOCKED, SUPPLIER, GENERICNONE, GENERICPARENTS, GENERICCHILDREN,');
  Template.SQL.Add('EXCLUDEMAJOR, EXCLUDEMINOR1, EXCLUDEMINOR2, EXCLUDESUPPLIER, REPORTCATEGORIES,EXCLUDEREPORTCATEGORY,');
  Template.SQL.Add('NON_BOM_ITEMS, BOM_ONLY, BOM_FINISHED_GOOD, BOM_RAW_MATERIAL');
  Template.SQL.Add('from TEMPLATE');
  Template.SQL.Add('where TEMPLATENO = ?TEMPLATENO');

  TemplateMajorGroups := TIBSQL.Create(nil);
  TemplateMajorGroups.Database := dbOptimiza;
  TemplateMajorGroups.Transaction := trnOptimiza;
  TemplateMajorGroups.SQL.Clear;
  TemplateMajorGroups.SQL.Add('select TEMPLATENO, USERNO, GROUPTYPE, GROUPNO');
  TemplateMajorGroups.SQL.Add('from TMPLT_GROUPS');
  TemplateMajorGroups.SQL.Add('where GROUPTYPE = ''M''');
  TemplateMajorGroups.SQL.Add('  and TEMPLATENO = ?TEMPLATENO');
  if UserNo <> -1 then
    TemplateMajorGroups.SQL.Add('  and USERNO = ?USERNO');

  TemplateMinorGroups1 := TIBSQL.Create(nil);
  TemplateMinorGroups1.Database := dbOptimiza;
  TemplateMinorGroups1.Transaction := trnOptimiza;
  TemplateMinorGroups1.SQL.Clear;
  TemplateMinorGroups1.SQL.Add('select TEMPLATENO, USERNO, GROUPTYPE, GROUPNO');
  TemplateMinorGroups1.SQL.Add('from TMPLT_GROUPS');
  TemplateMinorGroups1.SQL.Add('where GROUPTYPE = ''1''');
  TemplateMinorGroups1.SQL.Add('  and TEMPLATENO = ?TEMPLATENO');
  if UserNo <> -1 then
    TemplateMinorGroups1.SQL.Add('  and USERNO = ?USERNO');

  TemplateMinorGroups2 := TIBSQL.Create(nil);
  TemplateMinorGroups2.Database := dbOptimiza;
  TemplateMinorGroups2.Transaction := trnOptimiza;
  TemplateMinorGroups2.SQL.Add('select TEMPLATENO, USERNO, GROUPTYPE, GROUPNO');
  TemplateMinorGroups2.SQL.Add('from TMPLT_GROUPS');
  TemplateMinorGroups2.SQL.Add('where GROUPTYPE = ''2''');
  TemplateMinorGroups2.SQL.Add('  and TEMPLATENO = ?TEMPLATENO');
  if UserNo <> -1 then
    TemplateMinorGroups2.SQL.Add('  and USERNO = ?USERNO');

  TemplateSuppliers := TIBSQL.Create(nil);
  TemplateSuppliers.Database := dbOptimiza;
  TemplateSuppliers.Transaction := trnOptimiza;
  TemplateSuppliers.SQL.Add('select TEMPLATENO, USERNO, GROUPTYPE, GROUPNO');
  TemplateSuppliers.SQL.Add('from TMPLT_GROUPS');
  TemplateSuppliers.SQL.Add('where GROUPTYPE = ''S''');
  TemplateSuppliers.SQL.Add('  and TEMPLATENO = ?TEMPLATENO');
  if UserNo <> -1 then
    TemplateSuppliers.SQL.Add('  and USERNO = ?USERNO');

  TemplateRepCats := TIBSQL.Create(nil);
  TemplateRepCats.Database := dbOptimiza;
  TemplateRepCats.Transaction := trnOptimiza;
  TemplateRepCats.SQL.Add('select TEMPLATENO, REPORTCATEGORYTYPE, REPORTCATEGORYNO');
  TemplateRepCats.SQL.Add('from TMPLT_REPCATS');
  TemplateRepCats.SQL.Add('where TEMPLATENO = ?TEMPLATENO');
  TemplateRepCats.SQL.Add('Order by REPORTCATEGORYTYPE, REPORTCATEGORYNO');

  TemplateUserConditions := TIBSQL.Create(nil);
  TemplateUserConditions.Database := dbOptimiza;
  TemplateUserConditions.Transaction := trnOptimiza;
  TemplateUserConditions.SQL.Clear;
  TemplateUserConditions.SQL.Add('select TEMPLATENO, USERFIELD, FIELDVALUE, CONDITION');
  TemplateUserConditions.SQL.Add('from TMPLT_USERFIELD_CONDITIONS');
  TemplateUserConditions.SQL.Add('where TEMPLATENO = ?TEMPLATENO');
  TemplateUserConditions.SQL.Add('order by tmpltUserFieldConditions_ID');

  try
    with Template do begin
      Close;
      Params.ByName('TEMPLATENO').AsInteger := TemplateNo;
      ExecQuery;
    end;

    SQL.Clear;
    //SQL.Add('select count(*) as NUMBER');
    //SQL.Add('from ITEM i join PRODUCT p on i.PRODUCTNO = p.PRODUCTNO');

    JoinClause.Clear;

    WhereCount := 0;
    Line := 'i.PARETOCATEGORY in (';
    FirstOne := True;
    Count := 0;
    if Template.FieldByName('PARETO_A').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''A''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('PARETO_B').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''B''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('PARETO_C').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''C''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('PARETO_D').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''D''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('PARETO_E').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''E''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('PARETO_F').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''F''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('PARETO_M').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''M''';
      inc(Count);
    end;
    if Template.FieldByName('PARETO_X').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''X''';
      inc(Count);
    end;
    Line := Line + ')';
    if Count <> 0 then begin
      if WhereCount = 0 then
        Line := 'where ' + Line
      else
        Line := 'and ' + Line;

      SQL.Add(Line);
      inc(WhereCount);
    end;

    Line := 'i.CRITICALITY in (';
    FirstOne := True;
    Count := 0;

    if Template.FieldByName('CRITICALITY_1').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''1''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('CRITICALITY_2').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''2''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('CRITICALITY_3').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''3''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('CRITICALITY_4').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''4''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('CRITICALITY_5').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''5''';
      inc(Count);
    end;
    Line := Line + ')';
    if Count <> 0 then begin
      if WhereCount = 0 then
        Line := 'where ' + Line
      else
        Line := 'and ' + Line;

      SQL.Add(Line);
      inc(WhereCount);
    end;

    Line := '';
    if Template.FieldByName('NON_BOM_ITEMS').AsString = 'Y' then
    begin
      if Template.FieldByName('BOM_ONLY').AsString = 'Y' then
      begin
        Line := '(( not (I.BOMLevel is null) ';
        if (Template.FieldByName('BOM_FINISHED_GOOD').AsString = 'Y')
          and (Template.FieldByName('BOM_RAW_MATERIAL').AsString = 'N') then
        begin
          Line := Line + ' and (i.BOMFINISHEDGOOD in (''Y''))';
        end
        else if (Template.FieldByName('BOM_FINISHED_GOOD').AsString = 'N')
          and (Template.FieldByName('BOM_RAW_MATERIAL').AsString = 'Y') then
        begin
          Line := Line + ' and (i.BOMFINISHEDGOOD in (''N''))';
        end;
        Line := Line + ') or  (i.BomLevel is null)) ';
      end
      else
        Line := ' (i.BomLevel is null) ';
    end
    else if Template.FieldByName('BOM_ONLY').AsString = 'Y' then
    begin
      Line := '( not (I.BOMLevel is null) ';
      if (Template.FieldByName('BOM_FINISHED_GOOD').AsString = 'Y')
        and (Template.FieldByName('BOM_RAW_MATERIAL').AsString = 'N') then
      begin
        Line := Line + ' and (i.BOMFINISHEDGOOD in (''Y''))';
      end
      else if (Template.FieldByName('BOM_FINISHED_GOOD').AsString = 'N')
        and (Template.FieldByName('BOM_RAW_MATERIAL').AsString = 'Y') then
      begin
        Line := Line + ' and (i.BOMFINISHEDGOOD in (''N''))';
      end;
      Line := Line + ') ';
    end;
    if Line <> '' then
    begin
      if WhereCount = 0 then
        Line := 'where ' + Line
      else
        Line := 'and ' + Line;

      SQL.Add(Line);
      inc(WhereCount);
    end;

    Line := 'i.STOCKINGINDICATOR in (';
    FirstOne := True;
    Count := 0;

    if Template.FieldByName('STOCKED').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''Y''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('NONSTOCKED').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''N''';
      inc(Count);
    end;

    Line := Line + ')';
    if Count <> 0 then begin
      if WhereCount = 0 then
        Line := 'where ' + Line
      else
        Line := 'and ' + Line;

      SQL.Add(Line);
      inc(WhereCount);
    end;

    Line := 'i.GENERIC in (';
    FirstOne := True;
    Count := 0;
    // THis part must always be included so start the counter at 1 instead of 0

    if Template.FieldByName('GENERICNONE').AsString = 'Y' then begin
      Line := Line + '''N''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('GENERICPARENTS').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''P''';
      FirstOne := False;
      inc(Count);
    end;
    if Template.FieldByName('GENERICCHILDREN').AsString = 'Y' then begin
      if not FirstOne then
        Line := Line + ',';
      Line := Line + '''C''';
      inc(Count);
    end;

    Line := Line + ')';
    if Count <> 0 then begin
      if WhereCount = 0 then
        Line := 'where ' + Line
      else
        Line := 'and ' + Line;

      SQL.Add(Line);
      inc(WhereCount);
    end;

    if Template.FieldByName('MAJORGROUP').AsString = 'Y' then begin
      if Template.FieldByName('EXCLUDEMAJOR').AsString = 'Y' then
        Line := 'i.GROUPMAJOR not in ('
      else
        Line := 'i.GROUPMAJOR in (';
      FirstOne := True;
      Count := 0;
      TemplateMajorGroups.Close;
      TemplateMajorGroups.Params.ByName('TEMPLATENO').AsInteger := TemplateNo;
      if UserNo <> -1 then
        TemplateMajorGroups.Params.ByName('USERNO').AsInteger := UserNo;
      TemplateMajorGroups.ExecQuery;
      while not TemplateMajorGroups.eof do begin
        if not FirstOne then
          Line := Line + ',';
        Line := Line + TemplateMajorGroups.FieldByName('GROUPNO').AsString;
        FirstOne := False;
        inc(Count);
        TemplateMajorGroups.Next;
      end;
      Line := Line + ')';
      if Count <> 0 then begin
        if WhereCount = 0 then
          Line := 'where ' + Line
        else
          Line := 'and ' + Line;

        SQL.Add(Line);
        inc(WhereCount);
      end;
    end;

    if Template.FieldByName('MINORGROUP1').AsString = 'Y' then begin
      if Template.FieldByName('EXCLUDEMINOR1').AsString = 'Y' then
        Line := 'i.GROUPMINOR1 not in ('
      else
        Line := 'i.GROUPMINOR1 in (';
      FirstOne := True;
      Count := 0;
      TemplateMinorGroups1.Close;
      TemplateMinorGroups1.Params.ByName('TEMPLATENO').AsInteger := TemplateNo;
      if UserNo <> -1 then
        TemplateMinorGroups1.Params.ByName('USERNO').AsInteger := UserNo;
      TemplateMinorGroups1.ExecQuery;
      while not TemplateMinorGroups1.eof do begin
        if not FirstOne then
          Line := Line + ',';
        Line := Line + TemplateMinorGroups1.FieldByName('GROUPNO').AsString;
        FirstOne := False;
        inc(Count);
        TemplateMinorGroups1.Next;
      end;
      Line := Line + ')';
      if Count <> 0 then begin
        if WhereCount = 0 then
          Line := 'where ' + Line
        else
          Line := 'and ' + Line;

        SQL.Add(Line);
        inc(WhereCount);
      end;
    end;

    if Template.FieldByName('MINORGROUP2').AsString = 'Y' then begin
      if Template.FieldByName('EXCLUDEMINOR2').AsString = 'Y' then
        Line := 'i.GROUPMINOR2 not in ('
      else
        Line := 'i.GROUPMINOR2 in (';
      FirstOne := True;
      Count := 0;
      TemplateMinorGroups2.Close;
      TemplateMinorGroups2.Params.ByName('TEMPLATENO').AsInteger := TemplateNo;
      if UserNo <> -1 then
        TemplateMinorGroups2.Params.ByName('USERNO').AsInteger := UserNo;
      TemplateMinorGroups2.ExecQuery;
      while not TemplateMinorGroups2.eof do begin
        if not FirstOne then
          Line := Line + ',';
        Line := Line + TemplateMinorGroups2.FieldByName('GROUPNO').AsString;
        FirstOne := False;
        inc(Count);
        TemplateMinorGroups2.Next;
      end;
      Line := Line + ')';
      if Count <> 0 then begin
        if WhereCount = 0 then
          Line := 'where ' + Line
        else
          Line := 'and ' + Line;

        SQL.Add(Line);
        inc(WhereCount);
      end;

    end;

    if Template.FieldByName('SUPPLIER').AsString = 'Y' then begin
      if Template.FieldByName('EXCLUDESUPPLIER').AsString = 'Y' then
      begin
        Line := 'i.SUPPLIERNO1 not in (';
        if (FDebugTemplate = true) then
        begin
          CodeList := '-- Supplier Code not in (';
        end;
      end
      else
      begin
        Line := 'i.SUPPLIERNO1 in (';
        if (FDebugTemplate = true) then
        begin
          CodeList := '-- Supplier Code in (';
        end;
      end;
      if (FDebugTemplate = true) then
      begin
        qryCode.SQL.Clear;
        qryCode.ParamCheck := true;
        qryCode.SQL.Add('SELECT SUPPLIERCODE CODE FROM SUPPLIER WHERE SUPPLIERNO = :NO');
      end;
      FirstOne := True;
      Count := 0;
      TemplateSuppliers.Close;
      TemplateSuppliers.Params.ByName('TEMPLATENO').AsInteger := TemplateNo;
      if UserNo <> -1 then
        TemplateSuppliers.Params.ByName('USERNO').AsInteger := UserNo;
      TemplateSuppliers.ExecQuery;
      while not TemplateSuppliers.eof do begin
        if not FirstOne then
          Line := Line + ',';
        Line := Line + TemplateSuppliers.FieldByName('GROUPNO').AsString;
        if (FDebugTemplate = true) then
        begin
          qryCode.Close;
          qryCode.ParamByName('NO').AsInteger := TemplateSuppliers.FieldByName('GROUPNO').AsInteger;
          qryCode.Open;
          qryCode.First;
          CodeList := codeList + ' ' + qryCode.fieldbyname('CODE').asString;
        end;
        FirstOne := False;
        inc(Count);
        TemplateSuppliers.Next;
      end;
      Line := Line + ')';
      if (FDebugTemplate = true) then
      begin
        CodeList := codeList + ')';
      end;
      if Count <> 0 then begin
        if WhereCount = 0 then
          Line := 'where ' + Line
        else
          Line := 'and ' + Line;

        SQL.Add(Line);
        if (FDebugTemplate = true) then
        begin
          SQL.Add(CodeList);
        end;
        inc(WhereCount);
      end;
    end;


    FirstOne := True;
    Count := 0;
    Line := ' ';
    TemplateUserConditions.Close;
    TemplateUserConditions.Params.ByName('TEMPLATENO').AsInteger := TemplateNo;
    TemplateUserConditions.ExecQuery;
    while not TemplateUserConditions.eof do begin
      if not FirstOne then
        Line := Line + ') and ';

      tmpstr := uppercase(COPY(TemplateUserConditions.FieldByName('USERFIELD').AsString,5,2));
      if (tmpstr='CH') or (tmpstr='DA') then
      begin
        tmpstr := '''';
      end
      else
      begin
        tmpstr := '';
      end;
      Line := Line + '(' + TemplateUserConditions.FieldByName('USERFIELD').AsString + TemplateUserConditions.FieldByName('CONDITION').AsString + tmpstr + TemplateUserConditions.FieldByName('FIELDVALUE').AsString + tmpstr + ')';
      FirstOne := False;
      inc(Count);
      TemplateUserConditions.Next;
    end;
    //Line := Line + ')';
    if Count <> 0 then begin
      if WhereCount = 0 then
        Line := 'where ' + Line
      else
        Line := 'and ' + Line;

      SQL.Add(Line);
      inc(WhereCount);
    end;





    if Template.FieldByName('REPORTCATEGORIES').AsString = 'Y' then begin
      CurrentRepCatType := -1;

      if Template.FieldByName('EXCLUDEREPORTCATEGORY').AsString = 'Y' then
      begin
        InOrNotIn := 'not in';
      end
      else
      begin
        InOrNotIn := 'in';
      end;

      if (FDebugTemplate = true) then
      begin
        qryCode.SQL.Clear;
        qryCode.SQL.Add('SELECT REPORTCATEGORYCODE CODE FROM REPORTCATEGORY WHERE REPORTCATEGORYNO = :NO AND REPORTCATEGORYTYPE = :TYPE');
      end;

      TemplateRepCats.Close;
      TemplateRepCats.Params.ByName('TEMPLATENO').AsInteger := TemplateNo;
      TemplateRepCats.ExecQuery;
      Count := 0;
      Line := '';
      CodeList := '';
      while not TemplateRepCats.eof do begin
        if TemplateRepCats.FieldByName('REPORTCATEGORYTYPE').AsInteger <> CurrentRepCatType then begin
          if Count <> 0 then
          begin
            Line := Line + ')';
            if (FDebugTemplate = true) then
            begin
              CodeList := CodeList + ') ';
            end;
            if WhereCount = 0 then
              Line := 'where ' + Line
            else
              Line := 'and ' + Line;

            SQL.Add(Line);
            if (FDebugTemplate = true) then
            begin
              SQL.Add(CodeList);
              //CodeList := '-- ReportCategory Code '+IntToStr(CurrentRepCatType)+' '+InOrNotIn+' (';
            end;
            inc(WhereCount);

            JoinLine := 'join ITEM_REPORTCATEGORY r' + IntToStr(CurrentRepCatType) + ' on i.ITEMNO = r' + IntToStr(CurrentRepCatType) + '.ITEMNO and r' + IntToStr(CurrentRepCatType) + '.REPORTCATEGORYTYPE = ' + IntToStr(CurrentRepCatType);
            JoinClause.Add(JoinLine);
          end;
          CurrentRepCatType := TemplateRepCats.FieldByName('REPORTCATEGORYTYPE').AsInteger;
          FirstOne := True;
          Count := 0;
          Line := 'r' + IntToStr(CurrentRepCatType) + '.REPORTCATEGORYNO '+InOrNotIn+' (';
          if (FDebugTemplate = true) then
          begin
            CodeList := '-- ReportCategory Code '+IntToStr(CurrentRepCatType)+' '+InOrNotIn+' (';
          end;
        end;
        if not FirstOne then
          Line := Line + ','
        else
          FirstOne := False;
        Line := Line + TemplateRepCats.FieldByName('REPORTCATEGORYNO').AsString;
        if (FDebugTemplate = true) then
        begin
          qryCode.Close;
          qryCode.ParamByName('NO').AsInteger := TemplateRepCats.FieldByName('REPORTCATEGORYNO').AsInteger;
          qryCode.ParamByName('TYPE').AsInteger := CurrentRepCatType;
          qryCode.Open;
          qryCode.First;
          CodeList := codeList + ' ' + qryCode.fieldbyname('CODE').asString;
        end;
        inc(Count);
        TemplateRepCats.Next;
      end;
      if Count <> 0 then begin
        Line := Line + ')';
        if WhereCount = 0 then
          Line := 'where ' + Line
        else
          Line := 'and ' + Line;

        SQL.Add(Line);
        if (FDebugTemplate = true) then
        begin
          SQL.Add(CodeList+')');
        end;
        inc(WhereCount);

        JoinLine := 'join ITEM_REPORTCATEGORY r' + IntToStr(CurrentRepCatType) + ' on i.ITEMNO = r' + IntToStr(CurrentRepCatType) + '.ITEMNO and r' + IntToStr(CurrentRepCatType) + '.REPORTCATEGORYTYPE = ' + IntToStr(CurrentRepCatType);
        JoinClause.Add(JoinLine);
      end;
    end;


    //Specify -1 for Locno if this line should be excluded.
    if LocationNo >= 0 then
    begin

      if WhereCount = 0 then
        Line := 'where '
      else
        Line := 'and ';

      Line := Line + 'i.LOCATIONNO = ' + IntToStr(LocationNo);

// Debug:
//Line:=Line+' and i.itemno in (185755,185745,182368,186975) ';

      SQL.Add(Line);

    end;

{    inc(WhereCount);
    if UserNo <> -1 then begin
      if WhereCount = 0 then
        Line := 'where '
      else
        Line := 'and ';

      Line := Line + 'i.INVENTORYMANAGER = ' + IntToStr(UserNo);
      SQL.Add(Line);
      //inc(WhereCount);
    end; }
  finally
    //if trnOptimiza.InTransaction then
    //begin
    //  trnOptimiza.Commit;
    //  trnOptimiza.StartTransaction;
    //end;

    if Template.Open then
      Template.Close;

    Template.Free;
    TemplateMajorGroups.Free;
    TemplateMinorGroups1.Free;
    TemplateMinorGroups2.Free;
    TemplateSuppliers.Free;
    TemplateRepCats.Free;
  end;
end;

function TdmOptimiza.GetLocationListNo(LocCodes: String): String;
var
  SQLstr:String;

begin
  SQLstr := 'Select LocationNo,Description,LocationCode From Location ';
  SQLstr := SQLStr + 'where LocationCode in ('+LocCodes+') ';
  SQLstr := SQLStr + 'order by LocationCode';
  Result := '';

  with qryLocationListCodes do
  begin

    Close;
    SQL.Clear;
    SQL.Add(SQLstr);
    Open;

    while not eof do
    begin

      if Result <> '' then Result := Result + ',';

      Result := Result + FieldByName('LocationNo').AsString;
      Next;
    end;

    Close;

  end;

end;

function TdmOptimiza.GetConfigAsString(ConfigNo: Integer): String;
begin

  Result := '';

  with qryGetConfiguration do
  begin
    ParamByName('ConfigurationNo').AsInteger := ConfigNo;
    Open;

    if FieldByName('ConfigurationNo').AsInteger > 0 then
      Result := FieldByName('TypeOfString').AsString;

    Close;
  end;

end;

function TdmOptimiza.GetOptimizaVersion: Real;
var
 OptVer,TempStr:String;
 sCount:Integer;
begin
  OptVer := Trim(GetConfigAsString(241));

  if OptVer = '' then
    Result := 3.4
  else
  begin

    TempStr := '';


    //Remove any non numeric values
    for sCount := 1 to Length(OptVer) do
    begin
      if (OptVer[SCount] in ['0'..'9','.']) then
        TempStr := TempStr + Copy(OptVer,SCount,1);


    end;

    TempStr := Trim(TempStr);

    Result := StrToFloat(TempStr);

  end;


end;

function TdmOptimiza.GetLocationDesc(Location: String): String;
begin

    With qryLocation do begin
      Active := False;
      ParamByName('iLocation').AsString := Location;
      Active := True;
      Result := FieldByName('Description').AsString;
      Active := False;
    end;

end;

function TdmOptimiza.GetCompanyName: String;
begin
  Result := GetConfigAsString(239);
end;

function TdmOptimiza.ReadConfigInt(ConfigNo : integer) : integer;
var
  InTrans : boolean;

begin
  InTrans := trnOptimiza.InTransaction;
  if not InTrans then
    trnOptimiza.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFINTEGER').AsInteger;
  finally
    if not InTrans then
      trnOptimiza.Commit;
  end;
end;

function TdmOptimiza.ReadConfigFloat(ConfigNo : integer) : double;
var
  InTrans : boolean;

begin
  InTrans := trnOptimiza.InTransaction;
  if not InTrans then
    trnOptimiza.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFFLOAT').AsFloat;
  finally
    if not InTrans then
      trnOptimiza.Commit;
  end;
end;

function TdmOptimiza.ReadConfigStr(ConfigNo : integer) : string;
var
  InTrans : boolean;

begin
  InTrans := trnOptimiza.InTransaction;
  if not InTrans then
    trnOptimiza.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFSTRING').AsString;
  finally
    if not InTrans then
      trnOptimiza.Commit;
  end;
end;

function TdmOptimiza.ReadConfigDate(ConfigNo : integer) : TDateTime;
var
  InTrans : boolean;

begin
  InTrans := trnOptimiza.InTransaction;
  if not InTrans then
    trnOptimiza.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFDATE').AsDateTime;
  finally
    if not InTrans then
      trnOptimiza.Commit;
  end;
end;

function TdmOptimiza.ReadConfigFloat(ConfigNo,
  LocationNo: integer): double;
var
  InTrans : boolean;

begin

  InTrans := trnOptimiza.InTransaction;
  if not InTrans then
    trnOptimiza.StartTransaction;
  try
    with ReadConfigLoc do begin
      Close;
      Params.ByName('LocationNO').AsInteger := LocationNo;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFFLOAT').AsFloat;
  finally
    if not InTrans then
      trnOptimiza.Commit;
  end;

end;

function TdmOptimiza.ReadConfigInt(ConfigNo,
  LocationNo: integer): integer;
var
  InTrans : boolean;

begin
  InTrans := trnOptimiza.InTransaction;
  if not InTrans then
    trnOptimiza.StartTransaction;
  try
    with ReadConfigLoc do begin
      Close;
      Params.ByName('LocationNO').AsInteger := LocationNo;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFINTEGER').AsInteger;
  finally
    if not InTrans then
      trnOptimiza.Commit;
  end;
end;

function TdmOptimiza.ReadConfigLongStr(
  ConfigNo: integer): string;
var
  InTrans : boolean;
begin

  InTrans := trnOptimiza.InTransaction;
  if not InTrans then
    trnOptimiza.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFLONGSTRING').AsString;
  finally
    if not InTrans then
      trnOptimiza.Commit;
  end;

end;

function TdmOptimiza.GetLogFileName: String;
var
  Year,Month,Day:Word;
  FCount:Integer;
  aFileName, aFilePath:String;
  MonthStr,DayStr,LogPath:String;
begin

  aFileName := ExtractFileName(ParamStr(0));
  aFileName := AnsiReplaceStr(aFileName,'.exe','');

  //see if parameter is setup
  aFilePath := Trim(ReadConfigLongStr(286));

  //if not then use the exe path
  if aFilePath = '' then
    aFilePath := Trim(ExtractFilePath(ParamStr(0)));

  if RightStr(aFilePath,1) <> '\' then AFilePath := aFilePath + '\';

  DecodeDate(Now, Year, Month, Day);
  MonthStr := RightStr('0'+IntToStr(Month),2); //Pad with 0
  DayStr := RightStr('0'+IntToStr(Day),2);

  aFileName := aFilePath+Format('%d%s%s '+aFileName+'.log', [Year, Monthstr, DayStr]);

  //if all 100 files exist then we will use 100
  for FCount := 1 to 100 do
  begin

    If FileExists(aFileName) then
    begin

      if FCount = 1 then
        aFileName := AnsiReplaceStr(aFileName,'.log',IntToStr(FCount)+'.log')
      else
        aFileName := AnsiReplaceStr(aFileName,IntToStr(FCount-1)+'.log',IntToStr(FCount)+'.log');


    end
    else
      Break;

  end;

  Result := aFileName;

end;

{function TdmOptimiza.WindowsLogonAs(aUserName,aDomainName,aPassword:String):Boolean;

var hToken: Cardinal;

function PerformLogon(const User, Domain, Password: String): Cardinal;
begin
    if NOT LogonUser(pChar(User), pChar(Domain), pChar(Password),
                 LOGON32_LOGON_NETWORK,
                 LOGON32_PROVIDER_DEFAULT,
                 Result) then
        RaiseLastOSError;
end;

begin
    hToken := PerformLogon(aUserName,aDomainName,aPassword);
    try
        ImpersonateLoggedOnUser(hToken);
        try
             // Perform tasks as User.
        finally
            RevertToSelf;
        end;
    finally
        CloseHandle(hToken);
    end;
end;
 }

function TdmOptimiza.WindowsLogonAs(aUserName, aDomainName,
  aPassword: String): Cardinal;
begin

    {if NOT LogonUser(pChar(aUserName), pChar(aDomainName), pChar(aPassword),
                 LOGON32_LOGON_NETWORK,
                 LOGON32_PROVIDER_DEFAULT,
                 Result) then
        RaiseLastOSError;}

end;

{
function TdmOptimiza.WindowsTestLogonAs(aUserName, aDomainName,
  aPassword: String): Boolean;
var
  hToken: cardinal;
begin

      try

        hToken := dmData.WindowsLogonAs(aUserName, aDomainName, aPassword);

        try
            ImpersonateLoggedOnUser(hToken);
            try

              MessageDlg('Tested Impersonation OK for '+aUserName,mtInformation,[mbOK],0);
            finally
                RevertToSelf;
                MessageDlg('Reverted to original user - test OK',mtInformation,[mbOK],0);
            end;
        finally
            CloseHandle(hToken);
        end;

      except
        on e: exception do begin
          MessageDlg(e.Message+#10+'User '+aUserName+' Domain '+aDomainName,mtError,[mbOK],0);
        end;
      end;
end;
 }


end.


{
SE_TCB_NAME
EnableNTPrivilege('SeBackupPrivilege', SE_PRIVILEGE_ENABLED);

// Setting Access Privilage
Function SetAccessPrivilege(Const PrivilegeStr : String; State : Integer):Integer;
Var
  hToken : THandle;
  aluid : TLargeInteger;
  cbPrevTP : DWORD;
  tp, fPrevTP : PTokenPrivileges;
Begin
  result := 0;
  If OpenProcessToken (GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES Or
      TOKEN_QUERY, hToken) Then
  Try
    LookupPrivilegeValue (Nil, PChar (PrivilegeStr), aluid);
    cbPrevTP := SizeOf (TTokenPrivileges) + sizeof (TLUIDAndAttributes);
    GetMem (tp, cbPrevTP);
    GetMem (fPrevTP, cbPrevTP);
    Try
      tp^.PrivilegeCount := 1;
      tp^.Privileges [0].Luid := aLuid;
      tp^.Privileges [0].Attributes := State;
      If Not AdjustTokenPrivileges (hToken, False, tp^, cbPrevTP, fPrevTP^, cbPrevTP) Then
        RaiseLastWin32Error;
      Result := fPrevTP^.Privileges [0].Attributes;
    Finally
      FreeMem (fPrevTP);
      FreeMem (tp);
    End
  Finally
   CloseHandle (hToken);
  End
End;
}
