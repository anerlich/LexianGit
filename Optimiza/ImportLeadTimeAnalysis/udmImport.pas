unit udmImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery, IBTable,StrUtils;

const
  _MaxCalendar = 18;

type
  TCalendarData = Record
    StartDate:TDateTime;
    EndDate:TDateTime;
    CalendarNo:Integer;
  end;

  TdmImport = class(TdmOptimiza)
    qryDelete: TIBSQL;
    qryGarbage: TIBSQL;
    qryItem: TIBSQL;
    qryDaysInPeriod: TIBSQL;
    qryPeriods: TIBSQL;
    prcInsert: TIBStoredProc;
    qryCheckTrigger: TIBSQL;
    qryDropTrigger: TIBSQL;
    qryCheckUpdate: TIBSQL;
    qryAlterProcedure: TIBSQL;
    qryCheckUp: TIBSQL;
    qryCreateUP: TIBSQL;
  private

    { Private declarations }

    FDownloadDate:TDateTime;
    FDaysInPeriod:Integer;
    FCurrentPeriod:Integer;
    FCalendarData:Array[1.._MaxCalendar]of TCalendarData;
    function GetThePeriod(ADate:TDateTime):Integer;
    function TriggerExists:Boolean;
    Function ProcedureExists:Boolean;


  public
    { Public declarations }
    procedure DeleteData;
    procedure InitParams;
    function InsertLTAnalysis(LocCode, ProdCode, Supplier,
                           OrderNumber: String; OrderDate, EAD, FinalDate: TDateTime;
                           Qty: Real): Boolean;
    function CheckInstall:Boolean;
  end;

var
  dmImport: TdmImport;

implementation

{$R *.dfm}

{ TdmExport }



{ TdmExport }



function TdmImport.CheckInstall: Boolean;
var
  TempStr:String;
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  Result := True;

  qryCheckUP.Close;
  qryCheckUP.ExecQuery;

  TempStr := UpperCase(Trim(qryCheckUP.FieldByName('RDB$PROCEDURE_NAME').AsString));

  if TempStr <> 'UP_INSERTLTANALYSIS' then
  begin
    if MessageDlg('This appears to be a NEW installation.'+#10+
                  'Do you wish to install all necessary procedures for the'+#10+
                  'Lead Time Analysis Import process.'+#10+
                  'This will remove the Optimiza functionality to populate the'+#10+
                  'Lead Time Analysis table via the Purchase Order Import.',
                  mtWarning,[mbOK,mbCancel],0) = mrOK then
    begin
      qryCreateUp.ExecQuery;

      if TriggerExists then
        qryDropTrigger.ExecQuery;

      if ProcedureExists then
        qryAlterProcedure.ExecQuery;

    end;

  end
  else
  begin

    if TriggerExists then
    begin

      Result := False;

      if MessageDlg('PURCHASEORDERLTANAL trigger exists in database, Please remove this'+
                  ' trigger in order to use this import functionality.'+
                  'Do you wish to remove this trigger now and continue processing',
                     mtConfirmation,[mbYes,mbNo],0) = mrYes then
      begin
        qryDropTrigger.ExecQuery;
        Result := True;
      end;

    end;

    if ProcedureExists then
    begin
      Result := False;

      if MessageDlg('UPDATELEADTIMEANALYSIS stored procedure exists in database, Please alter this'+
                  ' procedure according to the requirement in order to use this import functionality'+
                  'Do you wish to alter this procedure now and continue processing',
                     mtConfirmation,[mbYes,mbNo],0) = mrYes then
      begin
        qryAlterProcedure.ExecQuery;
        Result := True;
      end;

    end;


  end;

  trnOptimiza.Commit;

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

end;

procedure TdmImport.DeleteData;
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  qryDelete.ExecQuery;

  trnOptimiza.Commit;

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  qryGarbage.ExecQuery;

  trnOptimiza.Commit;

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

end;

function TdmImport.GetThePeriod(ADate: TDateTime): Integer;
var
  RCount:Integer;
begin

  Result := 18;

  for RCount := 1 to _MaxCalendar do
  begin

    if (ADate >= FCalendarData[RCount].StartDate) and
                (ADate <= FCalendarData[RCount].EndDate) then
    begin
      Result := FCalendarData[RCount].CalendarNo;
      Break;
    end;

  end;

end;

procedure TdmImport.InitParams;
var
  RCount:Integer;
begin

  FDownloadDate := GetDownloadDateAsDate;
  FCurrentPeriod := GetCurrentPeriod;

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  with qryDaysInPeriod do
  begin
    ExecQuery;
    FDaysInPeriod := FieldByName('TypeOfInteger').AsInteger;
    close;
  end;

  if FDAYSINPERIOD = 0 then
    FDAYSINPERIOD := 30;

  with qryPeriods do
  begin
    ParambyName('CurrentPeriod').AsInteger := FCurrentPeriod;
    ParamByname('MaxPeriod').AsInteger := FCurrentPeriod - (_MaxCalendar + 2);
    ExecQuery;

    for RCount := 1 to _MaxCalendar do
    begin
      FCalendarData[RCount].StartDate :=FieldByName('StartDate').AsDateTime;
      FCalendarData[RCount].EndDate :=FieldByName('EndDate').AsDateTime;
      FCalendarData[RCount].CalendarNo :=FieldByName('CalendarNo').AsInteger;
      next;
    end;

    close;
  end;

end;

function TdmImport.InsertLTAnalysis(LocCode, ProdCode, Supplier,
  OrderNumber: String; OrderDate, EAD, FinalDate: TDateTime;
  Qty: Real): Boolean;
var
  ItemNo, OrdSupplierNo, ItemSupplierNo, CalendarPeriod:Integer;
  LT, CostPrice, CostPer, ActualLT, LTVariance, CurrentLTVariance:Real;
  LTCat: String;
begin

  with qryItem do
  begin
    Close;
    ParambyName('LocCode').AsString := LocCode;
    ParambyName('ProdCode').AsString := ProdCode;
    ExecQuery;

    ItemNo := FieldByName('ItemNo').AsInteger;
    result := False;

    if ItemNo > 0 then
    begin

      LT := FieldByName('LeadTime').AsFloat;
      CostPrice := FieldByName('CostPrice').AsFloat;
      CostPer := FieldByName('CostPer').AsFloat;
      LTCat := FieldByName('LeadTimeCategory').AsString;
      ItemSupplierNo := FieldByName('SupplierNo1').AsInteger;

      if Supplier = '' then
      begin
        //Set ord supplier Same as item
        Supplier := FieldByName('SupplierCode').AsString;
        OrdSupplierNo := ItemSupplierNo;
      end
      else
      begin
        //This will force the stored proc to lookup the order supplier no
        OrdSupplierNo := -1;
      end;


      ActualLT := (FINALDATE - ORDERDATE) / FDAYSINPERIOD;
      LTVariance := ActualLT - LT;
      CurrentLTVariance := LTVariance;

      CalendarPeriod := GetThePeriod(FinalDate);


      Result := True;
    end
    else
    begin
      Result := False;
    end;

  end;

  if Result then
  begin

      with prcInsert do
      begin
        ParambyName('ItemNo').AsInteger := ItemNo;
        ParambyName('OrderNumber').AsString := OrderNumber;
        ParamByName('OriginalEAD').AsDateTime := EAD;
        ParambyName('LTCaT').AsString := LTCAT;
        ParambyName('LT').AsFloat := LT;
        ParambyName('CostPrice').AsFloat := CostPrice;
        ParambyName('CostPer').AsFloat := CostPer;
        ParambyName('OrdSupplierCode').AsString := Supplier;
        ParambyName('OrdSupplierNo').AsInteger := OrdSupplierNo;
        ParambyName('ItemSupplierNo').AsInteger := ItemSupplierNo;
        ParambyName('OrderDate').AsDate := OrderDate;
        ParambyName('FinalDeliveryDate').AsDate := FinalDate;
        ParambyName('EAD').AsDate := EAD;
        ParambyName('Qty').AsFloat := Qty;
        ParambyName('ActualLT').AsFloat := ActualLT;
        ParambyName('LTVariance').AsFloat := LTVariance;
        ParambyName('CurrentLTVariance').AsFloat := CurrentLTVariance;
        ParambyName('DeliveredCalendarNo').AsInteger := CalendarPeriod;
        ExecProc;
      end;


  end;

end;

function TdmImport.ProcedureExists: Boolean;
var
  TempStr:String;
begin
  Result := False;

  with qryCheckUpdate do
  begin
    Close;
    ExecQuery;
    TempStr := Trim(FieldbyName('RDB$Procedure_Source').AsString);
    Close;

    if (TempStr = '') or
       (Pos('/* Special LT Analysis Import Override Ver 1.0 */',TempStr) = 0) then
    begin
      Result := True;
    end;

  end;


end;

function TdmImport.TriggerExists: Boolean;
begin

 Result := False;

 with qryCheckTrigger do
 begin
   Close;
   ExecQuery;

   if Trim(FieldByName('RDB$TRIGGER_NAME').AsString) = 'PURCHASEORDERLTANAL' then
   begin
     Result := True;
   end;

   Close;
 end;

end;

end.


