unit uMainNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMAINDLL, StdCtrls, ComCtrls, ExtCtrls,StrUtils;

type
  TfrmMainNew = class(TfrmMainDLL)
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

    FCompany:Integer;

    procedure StartProcess;
    procedure OpenItemTable(ItemNo:Integer);
    procedure OpenOrderItemTable(LocCodes:String);
    procedure OpenPODaily;
    function FileOutFormat:String;

  public
    { Public declarations }
  end;

var
  frmMainNew: TfrmMainNew;

implementation

uses udmExport, uParameters, udmMainDLL, uCompany;

{$R *.dfm}

{ TfrmMainNew }

procedure TfrmMainNew.StartProcess;
var
  OutFile:TextFile;
  LocCode,OutStr, Ead,ProdCode,Fname : String;
  RecCount, n,ErrorCode,OffsetPO:Integer;
  TempDate,downDate,EndDate:TDateTime;
  MyCursor : TCursor;
  Engine : Pointer;
  Qty,LtDays:Real;
  DelayBuffer,EndNo:Integer;
  DivCode,StyleCode,ColourCode,DimCode,SizeCode,OutFormat:String;

begin

  Say('Exporting place-chase-cancel-delay');

  try
    frmParameters.LoadParam;
    FName := frmParameters.GetParam('Output File Name');
    AssignFile(OutFile,FName);
    ReWrite(OutFile);
    Say('Opening Data');
    dmExport.OpenLocationList(frmParameters.GetParam('Location Codes'));
    RecCount := 0;

    Say('Company :'+frmParameters.GetParam('Company'));

    FCompany := GetCompanyID(frmParameters.GetParam('Company'));

    if FCompany < 0 then
     raise ERangeError.Create('Invalid company specified');


    OutFormat := FileOutFormat;

    //----------------------------------------------------------------------
    // Initialize Stuff DLL
    //System may not use BOM or DRP, so initialize here
    //  This is for the Delay action where
    //    we call the DLL


    if not dmMainDLL.trnOptimiza.InTransaction then
        dmMainDLL.trnOptimiza.StartTransaction;

    //set all FWP parameters
    SetAllParameters;

    for n := 0 to FNoPeriodsToFC do
      FBOMForecast.PeriodForecast[n] := 0.00;

    for n := 0 to FNoPeriodsToFC do
      FDRPForecast.PeriodForecast[n] := 0.00;

    //We never load PO's so initialize to zero here
    FPurchaseOrder.NoEntries := 0;

    myCursor := Cursor;

    //now set overrides
    FLocationParams.SystemWeeks := 'D';      //Daily output
    FLocationParams.TypeOfSimulation := 'S';  //force simulation mode

    Engine := nil;
    Cursor := crSQLWait;
    Application.ProcessMessages;

    if not dmMainDLL.trnOptimiza.InTransaction then
      dmMainDLL.trnOptimiza.StartTransaction;


    DownDate := FLocationParams.StockDownloadDate;

    SetCalendar;
    InitialiseEngine(Engine, @FLocationParams, @FCalendar);
    //-----------------------------------------------------------------------


     Say('Exporting Place Orders');
     RecCount := 0;
     EndNo := 0;


      with dmMainDLL do begin
        OpenOrderItemTable(frmParameters.GetParam('Location Codes'));

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

          for n:= 0 to 342 do
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
            LocCode := GetItemData.FieldByNAme('LocationCode').AsString;

            if (FCompany in [_KingGee,_Leisure]) then
              LocCode := GetItemData.FieldByNAme('Division').AsString;

            if (FCompany in [_Hosiery]) then
              LocCode := 'HO';

            if (FCompany in [_Tontine]) then
              LocCode := 'TB';

            if (FCompany in [_Leisure]) then
              LocCode := 'LF';

            ConvertSKUCode(FCompany,ProdCode,StyleCode,ColourCode,DimCode,SizeCode);

            For n := 0 to 342 do
            begin

              if FCalculatedReceipts.CR[n] <> 0 then
              begin

                TempDate := (DownDate+n) - Round(LTDays);

                if TempDate < DownDate then
                  TempDate := DownDate;

                OutStr := Format(OutFormat,
                                 [Copy(LocCode,1,2),
                                         StyleCode,
                                         ColourCode,
                                         DimCode,
                                         SizeCode,
                                  Copy(GetItemData.FieldByName('SupplierCode').AsString,1,6),
                                  'PLACE',
                                  FCalculatedReceipts.CR[n],
                                  FormatDateTime('yyyymmdd',TempDate),
                                  FormatDateTime('yyyymmdd',DownDate+n),
                                  FormatDateTime('yyyymmdd',TempDate),
                                  'Place order'

                                  ]);

                WriteLn(OutFile,OutStr);
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


      Say('Records written : '+IntToStr(RecCount));

    //-----------------------------------------------------------------------
    dmExport.qryLocationList.First;

    while not dmExport.qryLocationList.eof do
    begin

      LocCode := dmExport.qryLocationList.FieldByName('LocationCode').AsString;
      Say('Opening expedite orders for '+LocCode);
      dmExport.OpenExpediteOrder(LocCode);
      RecCount := 0;

      with dmExport.qryExpediteOrder do
      begin

       Say('Exporting  expedite orders');

        while not eof do
        begin
          ProdCode := FieldByName('ProductCode').AsString;

          ConvertSKUCode(FCompany,ProdCode,StyleCode,ColourCode,DimCode,SizeCode);

          if (FCompany  in [_KingGee,_Leisure]) then
            LocCode := FieldByNAme('Division').AsString;

            if (FCompany in [_Hosiery]) then
              LocCode := 'HO';

            if (FCompany in [_Tontine]) then
              LocCode := 'TB';

            if (FCompany in [_Leisure]) then
              LocCode := 'LF';

          OutStr := Format(OutFormat,
                           [Copy(LocCode,1,2),
                                         StyleCode,
                                         ColourCode,
                                         DimCode,
                                         SizeCode,
                            Copy(FieldByName('SupplierCode').AsString,1,6),
                            'CHASE',
                            FieldByName('QTY').asFloat,
                            ' ',
                            FormatDateTime('yyyymmdd',FieldByNAme('EAD').AsDateTime),
                            ' ',
                            'Expedite orders '

                            ]);

          WriteLn(OutFile,OutStr);

          inc(RecCount);

          if (RecCount mod 50)=0 then
          begin
            Label1.Caption := IntToStr(RecCount);
            Application.ProcessMessages;
          end;

          next;
        end;

        Close;

      end;

      Say('Records written : '+IntToStr(RecCount));
      dmExport.qryLocationList.Next;

    end;


    //-----------------------------------------------------------------------
    dmExport.qryLocationList.First;

    while not dmExport.qryLocationList.eof do
    begin

      LocCode := dmExport.qryLocationList.FieldByName('LocationCode').AsString;

      Say('Opening Potential Stockouts for '+LocCode);
      dmExport.OpenPotentialStockout(LocCode);
      RecCount := 0;

      with dmExport.qryPotentialStockout do
      begin

       Say('Exporting Potential Stockouts');

        while not eof do
        begin

          ProdCode := FieldByName('ProductCode').AsString;

          if (FCompany  in [_KingGee,_Leisure]) then
            LocCode := FieldByNAme('Division').AsString;

            if (FCompany in [_Hosiery]) then
              LocCode := 'HO';

            if (FCompany in [_Tontine]) then
              LocCode := 'TB';

            if (FCompany in [_Leisure]) then
              LocCode := 'LF';

          ConvertSKUCode(FCompany,ProdCode,StyleCode,ColourCode,DimCode,SizeCode);

          OutStr := Format(OutFormat,
                           [Copy(LocCode,1,2),
                                         StyleCode,
                                         ColourCode,
                                         DimCode,
                                         SizeCode,
                            Copy(FieldByName('SupplierCode').AsString,1,6),
                            'CHASE',
                            FieldByName('QTY').asFloat,
                            ' ',
                            FormatDateTime('yyyymmdd',FieldByNAme('EAD').AsDateTime),
                            ' ',
                            'Replenish inventory or expedite orders '

                            ]);

          WriteLn(OutFile,OutStr);

          inc(RecCount);

          if (RecCount mod 50)=0 then
          begin
            Label1.Caption := IntToStr(RecCount);
            Application.ProcessMessages;
          end;

          next;
        end;

        Close;

      end;

      dmExport.qryLocationList.Next;
      Say('Records written : '+IntToStr(RecCount));

    end;

    //-----------------------------------------------------------------------
    dmExport.qryLocationList.First;

    DelayBuffer := StrToInt(frmParameters.GetParam('Delay Action Buffer Days'));


    while not dmExport.qryLocationList.eof do
    begin

      LocCode := dmExport.qryLocationList.FieldByName('LocationCode').AsString;

      Say('Opening Surplus Stock for '+LocCode);


      dmExport.OpenSurplusStock(LocCode);
      RecCount := 0;

      with dmExport.qrySurplusStock do
      begin

       Say('Exporting Surplus Stock');

        while not eof do
        begin

          Qty := FieldByName('QTY').asFloat;
          ProdCode := FieldByNAme('ProductCode').AsString;

          if (FCompany in [_KingGee,_Leisure]) then
            LocCode := FieldByNAme('Division').AsString;

            if (FCompany in [_Hosiery]) then
              LocCode := 'HO';

            if (FCompany in [_Tontine]) then
              LocCode := 'TB';

            if (FCompany in [_Leisure]) then
              LocCode := 'LF';

          ConvertSKUCode(FCompany,ProdCode,StyleCode,ColourCode,DimCode,SizeCode);

          if (FieldByName('CancelInd').asString <> 'DELAY') then
            EAD := ''
          else
          begin

            EAD := '';

            //---------------------------------------------------------------
            if Engine <> nil then begin

              with dmMainDLL do begin

                OpenItemTable(dmExport.qrySurplusStock.fieldbyName('xItemNo').AsInteger);

                SetItemStuff;
                //SetPOStuff;    exclude PO's
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

                for n:= 0 to 342 do
                begin
                  FCalculatedReceipts.CR[n] := 0;
                  FBackOrders.BO[n] := 0;
                end;

                ErrorCode := GetRecommendedOrders(Engine, @FLocationParams, @FItemParams,
                                        @FPurchaseOrder,  @FCustomerOrder, @FLocalForecast,
                                        @FBOMForecast, @FDRPForecast, @FRecommendedOrders,
                                        @FOpeningStock,@FCalculatedReceipts,@FBackOrders,
                                        @FCumLostSales,@FExcess);




                if ErrorCode = 0 then
                begin

                  OffsetPO := 0;

                  for n := 0 to 342 do
                  begin

                    if (FCalculatedReceipts.CR[n] > 0) or (FBackOrders.BO[n] > 0) then
                    begin
                      EAD := FormatDateTime('yyyymmdd',(FLocationParams.StockDownloadDate + n));
                      OffSetPO := (n-DelayBuffer);
                      break;
                    end;

                  end;

                  if EAD <> '' then
                  begin

                    OpenPODaily;
                    Qty := 0;

                    for n:= 0 to OffSetPO do
                    begin
                      Qty := Qty + FDailyPurChaseOrders.PO[n];
                    end;


                  end;

                end
                else
                begin
                  Say('** Error : '+IntToStr(ErrorCode) + ' ProdCode: '+ProdCode+' see Forward Plan for detail');

                end;


              end;

            end;


            //---------------------------------------------------------------

            if (EAD = '-1') or (EAD = '') then
              EAD := '99999999';

          end;

          if Qty > 0 then
          begin
            OutStr := Format(OutFormat,
                           [Copy(LocCode,1,2),
                                         StyleCode,
                                         ColourCode,
                                         DimCode,
                                         SizeCode,
                              Copy(FieldByName('SupplierCode').AsString,1,6),
                              FieldByName('CancelInd').asString,
                              Qty,
                              ' ',
                              EAD,
                              ' ',
                              FieldByName('CancelInd').asString + ' orders '

                              ]);

            WriteLn(OutFile,OutStr);
          end;

          inc(RecCount);

          if (RecCount mod 50)=0 then
          begin
            Label1.Caption := IntToStr(RecCount);
            Application.ProcessMessages;
          end;

          next;
        end;

        Close;
        Say('Records written : '+IntToStr(RecCount));

      end;

      dmExport.qryLocationList.Next;
    end;

    //----------------------------------------------------------------------
    CloseFile(OutFile);

    FinaliseEngine(Engine);

    Cursor := MyCursor;



    dmExport.FireEvent('S');

  except
      on e: exception do begin
        Say('*** Export place-chase-cancel-delay failed');
        Say('*** ' + e.Message);
        dmExport.FireEvent('F');
      end;
  end;

end;


procedure TfrmMainNew.OpenOrderItemTable(LocCodes: String);
var
  OptVer:REal;
  dCount:Integer;
begin

  OptVer := dmMainDLL.GetOptimizaVersion;

  //Use Item query to retrieve othe bits of info aswell!
  //
  with dmMainDLL.GetItemData do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select p.ProductCode, p.ProductDescription,');
    SQL.Add('         l.LocationCode,              ');

    if (FCompany in [_KingGee,_Leisure]) then
      SQL.Add('         rc.REportCategoryCode as Division, ')
    else
      SQL.Add('         r4.REportCategoryCode as Division, ');

    SQL.Add('         i.ItemNo,              ');
    SQL.Add('         s.SupplierCode,              ');
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
    SQL.Add('         i.LeadTime * 30.4 as LTDays,');
    SQL.Add('         i.OrderMultiples,');
    SQL.Add('         sale.SalesAmount_0 as S0');

    if OptVer >= 3.6 then
    begin
      SQL.Add('         ,i.TransitLT,');
      SQL.Add('          i.Stock_BuildNo,');
      SQL.Add('          sb.Start_Build,');
      SQL.Add('          sb.Start_ShutDown,');
      SQL.Add('          sb.End_Shutdown,');
      SQL.Add('          sb.Orders_During_Shutdown');
    end;

    SQL.Add(' from Item i join product p on p.productno = i.productno');
    SQL.Add('               join ItemSales sale on i.Itemno=sale.ItemNo');
    SQL.Add('               join Location l on i.LocationNo=l.LocationNo');
    SQL.Add('               left join Supplier s on i.SupplierNo1=s.SupplierNo');

    if FCompany = _KingGee then
    begin
      SQL.Add('               left join ITEM_REPORTCATEGORY r2 on i.ITEMNO = r2.ITEMNO and r2.REPORTCATEGORYTYPE = 2');
      SQL.Add('               left join ReportCategory rc on r2.ReportCategoryNo=rc.ReportCategoryNo and rc.ReportCategoryType=2');
    end
    else
    begin
      if FCompany = _Leisure then
      begin
        SQL.Add('               left join ITEM_REPORTCATEGORY r9 on i.ITEMNO = r9.ITEMNO and r9.REPORTCATEGORYTYPE = 9');
        SQL.Add('               left join ReportCategory rc on r9.ReportCategoryNo=rc.ReportCategoryNo and rc.ReportCategoryType=9');
      end
      else
      begin
        SQL.Add('               left join ITEM_REPORTCATEGORY r3 on i.ITEMNO = r3.ITEMNO and r3.REPORTCATEGORYTYPE = 1');
        SQL.Add('               left join ReportCategory r4 on r3.reportCategoryNo = r4.reportCategoryNo and r4.REPORTCATEGORYTYPE = 1');
      end;
    end;


    if OptVer >= 3.6 then
      SQL.Add('               left Join Stock_Build sb on i.Stock_BuildNo=sb.Stock_BuildNo');
    SQL.Add(' where LocationCode in ('+LocCodes+')');

    Say('--- Start SQL ---');

    for DCount := 0 to SQL.Count -1 do
    begin
      Say(SQL.Strings[DCount]);
    end;

    Say('--- End SQL ---')  ;

    ExecQuery;
  end;



end;


procedure TfrmMainNew.FormActivate(Sender: TObject);
var
  StartTime:TDateTime;
  RunProcess:Boolean;
  FName:String;
begin
  inherited;


  if FirstShow then
  begin
    Caption := AnsiReplaceStr(ExtractFileName(ParamStr(0)),'.exe','');

    Caption := Caption + ' (Ver'+dmMainDLL.kfVersionInfo+') ' + dmMainDLL.DbDescription;
    FirstShow := False;

    if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) then
    begin
      frmParameters.edtIniFile.Text := ParamStr(1);
      RunProcess := True;

    end
    else
    Begin

      Memo1.Lines.add('Parameter Setup');
      frmParameters.Caption := 'Parameter Setup'+ ' (Ver'+dmMainDLL.kfVersionInfo+') ';

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
      OpenLogFile('');

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


procedure TfrmMainNew.OpenItemTable(ItemNo:Integer);
var
  OptVer:REal;
begin

  OptVer := dmMainDLL.GetOptimizaVersion;

  //Use Item query to retrieve othe bits of info aswell!
  //
  with dmMainDLL.GetItemData do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select p.ProductCode, p.ProductDescription,');

    if FCompany = _KingGee then
      SQL.Add('         rc.REportCategoryCode as Division, ')
    else
      SQL.Add('         r4.REportCategoryCode as Division, ');

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
    SQL.Add('         sale.SalesAmount_0 as S0');

    if OptVer >= 3.6 then
    begin
      SQL.Add('         ,i.TransitLT,');
      SQL.Add('          i.Stock_BuildNo,');
      SQL.Add('          sb.Start_Build,');
      SQL.Add('          sb.Start_ShutDown,');
      SQL.Add('          sb.End_Shutdown,');
      SQL.Add('          sb.Orders_During_Shutdown');
    end;

    SQL.Add(' from Item i join product p on p.productno = i.productno');
    SQL.Add('               join ItemSales sale on i.Itemno=sale.ItemNo');

    if FCompany = _KingGee then
    begin
      SQL.Add('               left join ITEM_REPORTCATEGORY r2 on i.ITEMNO = r2.ITEMNO and r2.REPORTCATEGORYTYPE = 2');
      SQL.Add('               left join ReportCategory rc on r2.ReportCategoryNo=rc.ReportCategoryNo and rc.ReportCategoryType=2');
    end
    else
    begin
      SQL.Add('               left join ITEM_REPORTCATEGORY r3 on i.ITEMNO = r3.ITEMNO and r3.REPORTCATEGORYTYPE = 1');
      SQL.Add('               left join ReportCategory r4 on r3.reportCategoryNo = r4.reportCategoryNo and r4.REPORTCATEGORYTYPE = 1');
    end;


    if OptVer >= 3.6 then
      SQL.Add('               left Join Stock_Build sb on i.Stock_BuildNo=sb.Stock_BuildNo');




    SQL.Add(' where ItemNo = '+IntToStr(ItemNo));

    ExecQuery;
  end;

end;

procedure TfrmMainNew.OpenPODaily;
begin

  with dmMainDLL do
  begin
    GetPOData.Close;
    GetPOData.Params.ByName('ITEMNO').AsInteger := GetItemData.FieldByName('ITEMNO').AsInteger;
    GetPOData.Open;
    SetDailyPO(FLocationParams.StockDownloadDate);
  end;

end;

function TfrmMainNew.FileOutFormat: String;
begin
  // Layout Div,Style,Colour,Dim,Size,...

  //Style Code Length = 9
  if (FCompany = _DSE) or (FCompany = _DSA) then
    Result := '%-2.2s%-9.9s%-3.3s%-3.3s%-3.3s%-6.6s'+
                             '%-6.6s%7.0f%-8.8s%-8.8s%-8.8s%-50.50s'
  else
      Result := '%-2.2s%-6.6s%-3.3s%-3.3s%-3.3s%-6.6s'+
                             '%-6.6s%7.0f%-8.8s%-8.8s%-8.8s%-50.50s';
end;

end.
