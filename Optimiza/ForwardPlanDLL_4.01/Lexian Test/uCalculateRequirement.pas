unit uCalculateRequirement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uMainDLL, StdCtrls, ComCtrls, ExtCtrls;

type
  TfrmCalculateRequirement = class(TfrmMainDLL)
  private
    { Private declarations }
    procedure StartProcess;
    procedure OpenItemTable;
  public
    FName:String;
    FLocationNo:Integer;
    { Public declarations }
    procedure RunTheProcess;
  end;

var
  frmCalculateRequirement: TfrmCalculateRequirement;

implementation

uses udmMainDLL, FwdPlan;

{$R *.dfm}

{ TfrmMainDLL1 }

procedure TfrmCalculateRequirement.StartProcess;
var
  StartTime,DownDate,TempDate : TDateTime;
  OutData,LocCode,OrderType,ProdCode: String;
  OrderNum,OrderDate,ExpectedDate,ExpectedSupplierDate,ActualDeliveryDate:String;
  RecCount,RoCount: Integer;
  OutFile: TextFile;
  n : integer;
  MyCursor : TCursor;
  ErrorCode : integer;

begin
  StartTime := Now;
  Say('file creation started on ' + DateTimeToStr(StartTime));

  Say('Creating :'+Fname);
  RecCount := 0;
  RoCount := 0;

  try

      AssignFile(OutFile,FName);
      rewrite(OutFile);

      myCursor := Cursor;

      if not dmMainDLL.trnOptimiza.InTransaction then
          dmMainDLL.trnOptimiza.StartTransaction;

      SetAllParameters;

      Cursor := crSQLWait;
      Application.ProcessMessages;

      if not dmMainDLL.trnOptimiza.InTransaction then
        dmMainDLL.trnOptimiza.StartTransaction;

      DownDate := dmMainDll.FStockDownloadDate;

      SetCalendar;

        try

          with dmMainDLL do begin
            OpenItemTable;

            while not getItemData.eof do begin
              SetItemStuff;
              SetPOStuff;
              SetCOStuff;

              //for ROCO we use customer order demand only.
              if OrderType <> 'ROCO' then
                SetLocalFC;

              if (FUseBOM) then
              begin
                SetBOMFC;
              end;

              if (FUseDRP) then
              begin
                SetDRPFC;
              end;

              SetDemandAndLevel;

              ErrorCode := FPProject(FFP, FPO, FParams);

              if ErrorCode = 0 then begin

                ProdCode := GetItemData.FieldByNAme('ProductCode').AsString;


                For n := 0 to FFP.Cnt-1 do
                begin

                  if dmMainDLL.FFP.Dat[n].Receive <> 0 then
                  begin
                    inc(RoCount);
                    OutData := '';

                    BuildOutData(OutData,LocCode);
                    BuildOutData(OutData,'RO');
                    BuildOutData(OutData,ProdCode);

                    TempDate := ((DownDate+n) - Round(LTDays))-1;

                    if TempDate < DownDate then
                      TempDate := DownDate;

                    OrderDate := FormatDateTime('yyyymmdd',TempDate);
                    ExpectedDate := FormatDateTime('yyyymmdd',DownDate+n);
                    ExpectedSupplierDate := FormatDateTime('yyyymmdd',DownDate+n);
                    ActualDeliveryDate := FormatDateTime('yyyymmdd',DownDate+n);


                    BuildOutData(OutData,OrderNum);
                    BuildOutData(OutData,IntToStr(dmMainDLL.FFP.Dat[n].Receive));
                    BuildOutData(OutData,OrderDate);
                    BuildOutData(OutData,ExpectedDate);
                    BuildOutData(OutData,ExpectedSupplierDate);
                    BuildOutData(OutData,ActualDeliveryDate);
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
          Cursor := MyCursor;
        end;


 {----------------------------------------------------------------
      end;
}
    Say('Records written: ' + IntToStr(RoCount));
    Say('Records processed: ' + IntToStr(RecCount));
    Say('Dummy PO file creation successful');

    CloseFile(OutFile);

  except
      on e: exception do begin
        Say('*** The file creation failed');
        Say('*** ' + e.Message);
      end;
  end;

  Say('File creation finished on ' + DateTimeToStr(Now));
  Say(Format('Elapsed Time: %.2f seconds', [(Now - StartTime) * 86400]));
end;

procedure TfrmCalculateRequirement.OpenItemTable;
var
  sCount:Integer;
begin

  //Use Item query to retrieve othe bits of info aswell!
  //
  with dmMainDLL.GetItemData do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select p.ProductCode, p.ProductDescription,');
    SQL.Add('         l.LocationCode,           ');
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
    SQL.Add('         sale.SalesAmount_0 as S0,');
    SQL.Add('         sale.SalesAmount_0');
    SQL.Add('         ,i.TransitLT,');
    SQL.Add('          i.Stock_BuildNo,');
    SQL.Add('          sb.Start_Build,');
    SQL.Add('          sb.Start_ShutDown,');
    SQL.Add('          sb.End_Shutdown,');
    SQL.Add('          sb.Orders_During_Shutdown');
    SQL.Add('         ,i.BackOrderRatio');
    SQL.Add('         ,i.Forward_SS,');
    SQL.Add('         i.FOrward_SSRC,');
    SQL.Add('         i.RecommendedOrder,');
    SQL.Add('         i.TopupOrder,');
    SQL.Add('         i.IdealOrder,');
    SQL.Add('         i.AbsoluteMinimumQuantity,');
    SQL.Add('         i.CALC_IDEAL_ARRIVAL_DATE,');
    SQL.Add('         i.StockOnOrder,');
    SQL.Add('         i.StockOnOrder_Other,');
    SQL.Add('         i.StockOnOrderInLT,');
    SQL.Add('         i.StockOnOrderInLT_Other,');
    SQL.Add('         i.BOMBackOrderRatio,');
    SQL.Add('         i.DRPBackOrderRatio');

    SQL.Add(' from Item i join product p on p.productno = i.productno');
    SQL.Add('               join location l on l.locationno=i.locationno');
    SQL.Add('               join ItemSales sale on i.Itemno=sale.ItemNo');
    SQL.Add('               join Supplier S on s.SupplierNo=i.SupplierNo1');
    SQL.Add('               left Join Stock_Build sb on i.Stock_BuildNo=sb.Stock_BuildNo');

    SQL.Add(' where i.LocationNo =:LocNo');

    //NB must be in prodcode sequence for other processes
    SQL.Add(' order by p.ProductCode');


    Say('---- Start SQL ---');

    for SCount := 0 to SQL.Count - 1 do
    begin
      Say(SQL.Strings[SCount]);
    end;

    Say('---- End SQL ---');

    Say('Parameter : '+IntToStr(FLocationNo));

    ParamByName('LocNo').AsInteger := FLocationNo;
    ExecQuery;
  end;



end;

procedure TfrmCalculateRequirement.RunTheProcess;
begin
  OpenLogFile('Calculate Requirement');
  StartProcess;
  CloseLogFile;
end;

end.
