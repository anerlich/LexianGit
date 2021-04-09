unit uCalculateRequirement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uMainDLL, StdCtrls, ComCtrls, ExtCtrls;

type
  TfrmCalculateRequirement = class(TfrmMainDLL)
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure StartProcess;
    procedure OpenItemTable;
  public
    { Public declarations }
  end;

var
  frmCalculateRequirement: TfrmCalculateRequirement;

implementation

uses udmMainDLL, uParameters;

{$R *.dfm}

{ TfrmMainDLL1 }

procedure TfrmCalculateRequirement.StartProcess;
var
  StartTime,DownDate : TDateTime;
  OutData,LocCode,OrderType,ProdCode: String;
  OrderNum,OrderDate,ExpectedDate,ShipDate,ActualDeliveryDate:String;
  RecCount,RoCount: Integer;
  OutFile,AuditFile: TextFile;
  FName:String;
  n : integer;
  MyCursor : TCursor;
  Engine : Pointer;
  ErrorCode : integer;
  LTDays : Real;

begin
  StartTime := Now;
  Say('Dummy PO file creation started on ' + DateTimeToStr(StartTime));
  OrderType := ParamStr(1);
  LocCode := ParamStr(2);
  Fname := ParamStr(3);

  FIgnoreMOQMult := Uppercase(Paramstr(4)) = 'IGNORE';

  Say('Creating '+OrderType+ ' Orders');
  Say('MOQ and Order Multiple Parameter: '+ParamStr(4));
  Say('Creating for Location: '+LocCode);
  Say('Creating :'+Fname);
  RecCount := 0;
  RoCount := 0;

  try
      //System may not use BOM or DRP, so initialize here
      for n := 0 to FNoPeriodsToFC do
        FBOMForecast.PeriodForecast[n] := 0.00;

      for n := 0 to FNoPeriodsToFC do
        FDRPForecast.PeriodForecast[n] := 0.00;

      AssignFile(OutFile,FName);
      rewrite(OutFile);

      AssignFile(AuditFile,ExtractFileName(FName)+'.log');
      rewrite(AuditFile);

      myCursor := Cursor;

      if not dmMainDLL.trnOptimiza.InTransaction then
          dmMainDLL.trnOptimiza.StartTransaction;

      SetAllParameters;

      FLocationParams.SystemWeeks := 'D';      //Daily output

      Engine := nil;
      Cursor := crSQLWait;
      Application.ProcessMessages;

      if not dmMainDLL.trnOptimiza.InTransaction then
        dmMainDLL.trnOptimiza.StartTransaction;

      DownDate := FLocationParams.StockDownloadDate;


      SetCalendar;
      InitialiseEngine(Engine, @FLocationParams, @FCalendar);

      if Engine <> nil then begin
        try

          with dmMainDLL do begin
            OpenItemTable;

            while not GetItemData.eof do begin
              SetItemStuff;
              SetPOStuff;
              SetCOStuff;
              SetLocalFC;

              if FLocationParams.UseBOM = 'Y' then
              begin
                SetBOMFC;
              end;

              if FLocationParams.UseDRP = 'Y' then
              begin
                SetDRPFC;
              end;

              for n:= 1 to 342 do
              begin
                //We only need to deal with receipts
                FCalculatedReceipts.CR[n] := 0;
              end;


              ErrorCode := GetRecommendedOrders(Engine, @FLocationParams, @FItemParams,
                                      @FPurchaseOrder,  @FCustomerOrder, @FLocalForecast,
                                      @FBOMForecast, @FDRPForecast, @FRecommendedOrders,
                                      @FOpeningStock,@FCalculatedReceipts,@FBackOrders,
                                      @FCumLostSales,@FExcess);

              if ErrorCode = 0 then begin

                ProdCode := GetItemData.FieldByNAme('ProductCode').AsString;
                LTDays := GetItemData.FieldByName('LTDays').asFloat;

                //ResultString := ProdCode;

                //For n := 0 to 342 do
                //  ResultString := ResultString + ',' + Format('%10.0f',[FRecommendedOrders.RO[n]]);

                //WriteLn(AuditFile, ResultString);

                For n := 0 to 342 do
                begin

                  if FCalculatedReceipts.CR[n] <> 0 then
                  begin
                    inc(RoCount);
                    OutData := '';

                    BuildOutData(OutData,GetItemData.FieldByName('LocationCode').AsString);
                    BuildOutData(OutData,GetItemData.FieldByName('Division').AsString);
                    BuildOutData(OutData,'RO');
                    BuildOutData(OutData,Copy(ProdCode,1,6));
                    BuildOutData(OutData,Copy(ProdCode,8,3));
                    BuildOutData(OutData,'');
                    BuildOutData(OutData,Copy(ProdCode,12,3));

                    OrderNum := OrderType +'-'+ IntToStr(RoCount);
                    OrderDate := FormatDateTime('yyyymmdd',(DownDate+n) - LTDays);
                    ExpectedDate := FormatDateTime('yyyymmdd',DownDate+n);
                    ShipDate := FormatDateTime('yyyymmdd',DownDate+n);
                    ActualDeliveryDate := FormatDateTime('yyyymmdd',DownDate+n);

                    BuildOutData(OutData,OrderNum);
                    BuildOutData(OutData,FloatToStr(FCalculatedReceipts.CR[n]));
                    BuildOutData(OutData,OrderDate);
                    BuildOutData(OutData,ExpectedDate);
                    BuildOutData(OutData,ShipDate);
                    BuildOutData(OutData,ActualDeliveryDate);
                    BuildOutData(OutData,ProdCode);
                    BuildOutData(OutData,GetItemData.FieldByName('Vendor').AsString);
                    WriteLn(OutFile,OutData);

                  end;

                end;

              end
              else
              begin
                Say('Error : ' + IntToStr(ErrorCode) + ' Prod: ' + GetItemData.FieldByName('PRODUCTCODE').AsString);
              end;

              Inc(RecCount);

              if (RecCount mod 50) = 0 then begin
                Label1.Caption := IntToStr(RecCount);
                Application.ProcessMessages;
              end;

              GetItemData.Next;
            end;

          end;

        finally
          FinaliseEngine(Engine);

          Cursor := MyCursor;
        end;

      end;







 {----------------------------------------------------------------
      end;
}
    Say('Records written: ' + IntToStr(RoCount));
    Say('Records processed: ' + IntToStr(RecCount));
    Say('Dummy PO file creation successful');

    CloseFile(OutFile);
    CloseFile(AuditFile);

    dmMainDLL.FireEvent('S');

  except
      on e: exception do begin
        Say('*** The Dummy PO file creation failed');
        Say('*** ' + e.Message);
        dmMainDLL.FireEvent('F');
      end;
  end;

  Say('Dummy PO file creation finished on ' + DateTimeToStr(Now));
  Say(Format('Elapsed Time: %.2f seconds', [(Now - StartTime) * 86400]));
end;

procedure TfrmCalculateRequirement.FormActivate(Sender: TObject);

begin
  inherited;

  if FirstShow then
  begin

    Caption := Caption + ' ' + dmMainDLL.DbDescription;
    FirstShow := False;

    if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) then
    begin

      OpenLogFile('Calculate Requirement');
      StartProcess;

      CloseLogFile;
      Close;

    end
    else
    Begin
       if UpperCase(ParamStr(1)) = '-Z' then
       begin
        Memo1.Lines.add('Parameter Setup');
        frmParameters.Caption := 'Dummy Purchase Order Parameter Setup';

         if UpperCase(ParamStr(3)) = 'ROCO' then
           frmParameters.RadioGroup1.ItemIndex := 0
         else
            if UpperCase(ParamStr(3)) = 'ROOD' then
              frmParameters.RadioGroup1.ItemIndex := 2
            else
              frmParameters.RadioGroup1.ItemIndex := 3;


         frmParameters.Edit1.Text := ParamStr(4);
         frmParameters.Edit2.Text := ParamStr(5);
         frmParameters.chkIgnore.checked := UpperCase(ParamStr(6)) = 'IGNORE';

         frmParameters.showmodal;

         close;
       end;

    end;

  end;



end;

procedure TfrmCalculateRequirement.OpenItemTable;
begin

  with dmMainDLL.GetItemData do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select p.ProductCode, p.ProductDescription,');
    SQL.Add('         l.LocationCode,           ');
    SQL.Add('         r4.REportCategoryCode as Division, ');
    SQL.Add('         s.SupplierCode as Vendor,   ');
    SQL.Add('         i.ItemNo,              ');
    SQL.Add('         i.ParetoCategory, ');
    SQL.Add('         i.StockingIndicator, ');
    SQL.Add('         i.StockOnHand, ');
    SQL.Add('         i.CONSOLIDATEDBRANCHORDERS,');
    SQL.Add('         i.BackOrder,');
    SQL.Add('         i.BinLevel,');
    SQL.Add('         i.SafetyStock,');
    SQL.Add('         i.LeadTime,');
    SQL.Add('         i.ReviewPeriod,');
    SQL.Add('         i.ReplenishmentCycle,');
    SQL.Add('         i.MINIMUMORDERQUANTITY,');
    SQL.Add('         i.OrderMultiples,');
    SQL.Add('         i.LeadTime * 30.4 as LTDays,');
    SQL.Add('        sale.SalesAmount_0 as S0');
    SQL.Add(' from Item i join product p on p.productno = i.productno');
    SQL.Add('               join location l on l.locationno=i.locationno');
    SQL.Add('               join ItemSales sale on i.Itemno=sale.ItemNo');
    SQL.Add('               join Supplier S on s.SupplierNo=i.SupplierNo1');
    SQL.Add('               join ut_Capacity uc on i.GroupMajor = uc.GroupNo');
    SQL.Add('               left join ITEM_REPORTCATEGORY r3 on i.ITEMNO = r3.ITEMNO and r3.REPORTCATEGORYTYPE = 1');
    SQL.Add('               left join ReportCategory r4 on r3.reportCategoryNo = r4.reportCategoryNo and r4.REPORTCATEGORYTYPE = 1');
    SQL.Add(' where locationno = :LocNo');

    //Standard param will use different SQL to return
    //  all products except ROCO and ROOD,
    // i.e. Those that are not constrained by workcentre
    //       or have 0.000 minutes (Item.StockingUnitFactor)
    if UpperCase(ParamStr(1)) = 'STANDARD' then
    begin
      SQL.Add('  and (i.StockingUnitFactor <= 0.0000');
      SQL.Add(' or uc.GroupNo is null or (uc.Capacity_0+uc.Capacity_1+uc.Capacity_2+uc.Capacity_3+uc.Capacity_4+uc.Capacity_5+');
      SQL.Add(' uc.Capacity_6+uc.Capacity_7+uc.Capacity_8+uc.Capacity_9+uc.Capacity_10+uc.Capacity_11) <= 0)');
    end
    else
    Begin
      SQL.Add('  and i.StockingUnitFactor > 0.0000');
      SQL.Add('  and (uc.Capacity_0+uc.Capacity_1+uc.Capacity_2+uc.Capacity_3+uc.Capacity_4+uc.Capacity_5+');
      SQL.Add(' uc.Capacity_6+uc.Capacity_7+uc.Capacity_8+uc.Capacity_9+uc.Capacity_10+uc.Capacity_11) > 0');
    end;

    //NB must be in prodcode sequence for other processes
    SQL.Add(' order by p.ProductCode');

    ParamByName('LocNo').AsInteger := dmMainDLL.GetLocationNo(ParamStr(2));
    ExecQuery;
  end;

end;

end.
