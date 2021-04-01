unit uMainNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMAINDLL, StdCtrls, ComCtrls, ExtCtrls,StrUtils,FwdPlan;

// Revison Info
//
//  Ver 2.3 - Add Branch Code to end of layout.
//  Ver 2.4 - 2.6
//  Ver 2.7 - Increase Size field length and add 2 blanks
//  Ver 2.8 - Re-compile for Opt 4.20
//  Ver 2.9 - Holeproof/Underwear stuff
//  Ver 3.0 - Holeproof/Underwear enable use of transit LT
//  Ver 3.1 - All sites to use standard for FOB Date as per JT email Tuesday, 4 May 2010 10:58 AM
//  Ver 3.2 - Warehouse code for Holeproof
//  Ver 3.3 - Bug in warehouse code for Holeproof
//  Ver 3.4 - Simulation/Projection Mode
//  Ver 3.5 - Add logic for Workwear consolidation
//  Ver 3.6 - Workwear now gets the warehouse code from reporting category Branch Code JT 10/08/2011 Email
//  Ver 3.7 - Includes interim changes to Div codes and WH codes
//  Ver 3.8 - Includes final changes to Div codes and WH codes for OMNI
//  Ver 3.9 - Include WH Codes from database (Report category type 51,41,27) for OMNI, Workwear and Footwear
//  Ver 3.10 -       CM 8/3/2012 - Updated to change AU to ET (Email JT - 29/2/2012)
//  Ver 3.11 - Changed logic for Warehouse code return for WWPlan see email JT 27/03/2011
//  Ver 3.12 - Recompiled to pick up Comapany Code for Sheridan
//  Ver 3.13 - Recompiled to pick changes for new FwdPlanDLL.dll
//  Ver 3.14 - Reapplied version 3.11 changes
//  Ver 3.16 - Add new Tontine processing for BOB 2010
//  Ver 3.17 - Change Warehouse return codes for PBUG
//  Ver 4.0  - Workwear add 'ED' to location INT-SKU
//  Ver 4.1  - Footwear return Company code of FW or BL depending on division code
//  Ver 4.2  - Workwear restructure Locations
//  Ver 4.3  - Workwear change WE-SKU to VW-SKU
//  Ver 4.4  - Changes for Workwear restructure
//  Ver 4.5  - Sheridan changes to return Branch reporting category
//  Ver 4.6  - PBUG split up PAPSKU location and add INTSKU
//  Ver 4.7  - add file dumps if a single product is selected
//  Ver 4.8  - Sheridan change back to location based and not branch
//  Ver 4.9  - PBUG change Warehouse code W2 to SH
//  Ver 5.0  - Sheridan location restructure
//  Ver 5.1  - Tontine Generic changes
//  Ver 5.2  - PBUG restructure
//  Ver 5.3  - PBUG increase max locations to 200
//Ver 5.4  - Sheridan use division code from master feed file
//Ver 5.5  - Sheridan change C03SKU and C97SKU to return ET
//Ver 5.6  - Sheridan change TDDSKU to return JC
//Version 5.7 Apparel add new warehouses and update structure - 400 locations max
//  Ver 6.0  - Forked from PlaceChaseCancelDelay Anerlich 30 Mar 2021

//test git by AN

type

  TfrmMainNew = class(TfrmMainDLL)
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FCompany:Integer;
    FDailyPurchaseOrders: Array[0..MAX_DAYS_ARRAY_SIZE] of Integer;

    procedure StartProcess;
    procedure OpenItemTable(ItemNo:Integer);
    procedure OpenOrderItemTable(LocCodes:String);
    procedure OpenPODaily;
    function FileOutFormat:String;
    procedure SetDailyPO(DownDate:TDateTime);
    Procedure GetItemData(ItemNo:Integer);
    function CommaTextToLines(TheCommaText: String): String;
    function GetWarehouseCodeDevColour(CompanyID:Integer; LocCode:String): String;
    procedure ConvertDevColourCode(CompanyID:Integer;ProdCode:String;
                         var StyleCode,ColourCode,DimCode,SizeCode:String);
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
  LocCode,OutStr, Ead,ProdCode,Fname,BrnCode,TempLocCode,loc2 : String;
  RecCount, n,ErrorCode,OffsetPO:Integer;
  TempDate,downDate,EndDate,OrderDate,FOBDate,CutOffDate:TDateTime;
  MyCursor : TCursor;
  Qty:Integer;
  LtDays:Real;
  DelayBuffer,EndNo:Integer;
  DivCode,StyleCode,ColourCode,DimCode,SizeCode,OutFormat,CompanyCode,Loc1,SkuFlag:String;
  UseTransitLT:Boolean;
  IncludeItem:Boolean;
  WCount:Integer;
begin

  Say('Exporting place-chase-cancel-delay');

  try
    UseTransitLT := False;
    frmParameters.LoadParam;
    FName := frmParameters.GetParam('Output File Name');
    AssignFile(OutFile,FName);
    ReWrite(OutFile);
    Say('Opening Data');
    dmExport.OpenLocationList(frmParameters.GetParam('Location Codes'));

    Say('Company :'+frmParameters.GetParam('Company'));

    FCompany := GetCompanyID(frmParameters.GetParam('Company'));
    if FCompany < 0 then
     raise ERangeError.Create('Invalid company specified');
    BuildLookupStructure(FCompany);
    CompanyCode := GetCompanyCode(GetCompanyName(FCompany));

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

    dmMainDLL.Lex_TypeOfSimulation :=  'S';  //force current mode S=current sim, P=projection
    //dmMainDLL.Lex_UsePO := False;   //exclude POs
    dmMainDll.CalculateMonthly := False;  //Only need daily numbers

    myCursor := Cursor;

    Cursor := crSQLWait;
    Application.ProcessMessages;

    if not dmMainDLL.trnOptimiza.InTransaction then
      dmMainDLL.trnOptimiza.StartTransaction;


    DownDate := dmMainDll.FStockDownloadDate;


    //JT - Tuesday, 14 September 2010 3:15 PM
    // 12 months only
    CutOffDate := DownDate + 365;

    SetCalendar;
    //-----------------------------------------------------------------------


     Say('Exporting Place Orders');
     RecCount := 0;
     WCount := 0;
     EndNo := 0;


      with dmMainDLL do begin
        OpenOrderItemTable(frmParameters.GetParam('Location Codes'));

        while not qryItem.eof do begin

          SkuFlag := qryItem.FieldByNAme('SkuFlag').AsString;

          //Revision see JT email -  Tuesday, 5 October 2010 5:53 PM
          //if (Pos(SkuFlag,'F,R,1') > 0) or (FCompany in [_Tontine]) then
          begin
            ErrorCode := dmMainDll.DLL_Calc;

            if ((Trim(frmParameters.GetParam('Product Code'))<>'')
                and (qryItem.FieldByNAme('ProductCode').AsString = Trim(frmParameters.GetParam('Product Code'))))then
            begin
              dmMainDLL.SaveResultsToFile('D:\Optimiza\Place_R.txt');
              dmMainDLL.SaveToFile('D:\Optimiza\Place_I.txt');
            end;

            if ErrorCode = 0 then begin

              ProdCode := qryItem.FieldByNAme('ProductCode').AsString;
              //LTDays := qryItem.FieldByName('LTDays').asFloat;
              LocCode := qryItem.FieldByNAme('LocationCode').AsString;
              BrnCode := '';
              IncludeItem := true;

                if (FCompany in [_Holeproof]) then                     //Workwear consol and Branch from Database
                begin
                  if (FCompany = _Holeproof)  then // and (LocCode <> 'UHG')) then
                  Begin
                    brnCode := GetWarehouseCodeDevColour(FCompany,LocCode);
                  end
                  else
                    BrnCode := qryItem.FieldByNAme('Warehouse').AsString;
                end
                else if (FCompany in [_Sheridan]) then
                begin
                  //BrnCode := qryItem.FieldByNAme('Warehouse').AsString;
                  BrnCode := GetWarehouseCode(FCompany,qryItem.FieldByName('Division').AsString,qryItem.FieldByNAme('LocationCode').AsString);
                  {BrnCode := qryItem.FieldByNAme('LocationCode').AsString;

                  if Trim(BrnCode) = 'ADESKU' then
                    BrnCode := 'TG';
                  if Trim(BrnCode) = 'DASSKU' then
                    BrnCode := 'E1';
                  if Trim(BrnCode) = 'DAUSKU' then
                    BrnCode := 'E2';
                  if Trim(BrnCode) = 'PAPSKU' then
                    BrnCode := 'X1';
                  if Trim(BrnCode) = 'WHOSKUNZL' then
                    BrnCode := 'ET';}                     //Version 6.12 -       CM 8/3/2012 - Updated to change AU to ET (Email JT - 29/2/2012)
                end
                else
                  BrnCode := GetWarehouseCode(FCompany,qryItem.FieldByName('Division').AsString,LocCode);

              if (FCompany in [_Holeproof,_Sheridan]) then
                LocCode := qryItem.FieldByNAme('Division').AsString;

              if (FCompany in [_Holeproof]) then
              begin
                UseTransitLT := True;
              end;

              if FCompany = _Tontine then
              Begin
                LocCode := dmMainDLL.qryItem.FieldByNAme('Division').AsString;
                if LocCode = 'DEF' then LocCode:='??';
              end;

              if (FCompany in [_Holeproof]) and (BrnCode = '') then
                IncludeItem := false;

              ConvertDevColourCode(FCompany,ProdCode,StyleCode,ColourCode,DimCode,SizeCode);

              For n := 0 to FFP.Cnt-1 do
              begin

                if dmMainDLL.FFP.Dat[n].Receive <> 0 then
                begin

                  OrderDate := (DownDate+n) - LTDays; //LTDays defined by DLL routines

                  if OrderDate < DownDate then
                    OrderDate := DownDate;

                  //Get FOB date which is EAD - TransitLT
                  //if UseTransitLT then
                  // All sites to use standard as per JT email Tuesday, 4 May 2010 10:58 AM
                  FOBDate := DownDate+n - Round(qryItem.FieldByName('TransitDays').AsFloat);
                  //else
                  //  FOBDate := OrderDate ;

                  if FOBDate < OrderDate then
                    FOBDate := OrderDate ;


                  OutStr := Format(OutFormat,
                                   [Copy(LocCode,1,2),
                                           StyleCode,
                                           ColourCode,
                                           DimCode,
                                           SizeCode,
                                    Copy(qryItem.FieldByName('SupplierCode').AsString,1,6),
                                    'PLACE',
                                    dmMainDLL.FFP.Dat[n].Receive,
                                    FormatDateTime('yyyymmdd',OrderDate),  //OrderDate
                                    FormatDateTime('yyyymmdd',DownDate+n),
                                    FormatDateTime('yyyymmdd',FOBDate),  //FOB Date
                                    'Place order',
                                    BrnCode,
                                    companyCode,
                                    Copy(qryItem.FieldByName('PlannerCode').AsString,1,6),
                                    'E',
                                    qryItem.FieldByName('OrderMultiples').AsInteger

                                    ]);

                  if OrderDate <= CutOffDate then
                  begin
                    if (IncludeItem) then
                    begin

                      WriteLn(OutFile,OutStr);
                      Inc(WCount);
                    end;
                  end;

                end;

              end;

            end
            else
            begin
              Say('Error : ' + IntToStr(ErrorCode) + ' Prod: ' + qryItem.FieldByName('PRODUCTCODE').AsString);
            end;

          end;

          Inc(RecCount);

          if (RecCount mod 50) = 0 then begin
            Label1.Caption := IntToStr(RecCount);
            Application.ProcessMessages;
          end;

          qryItem.Next;
        end;

      end;


      Say('Records read : '+IntToStr(RecCount));
      Say('Records written : '+IntToStr(WCount));
      Say('----------------------------------------------------------------------------------------------------');

    //-----------------------------------------------------------------------

{*    dmExport.qryLocationList.First;

    while not dmExport.qryLocationList.eof do
    begin

      LocCode := dmExport.qryLocationList.FieldByName('LocationCode').AsString;
      Say('Opening expedite orders for '+LocCode);
      dmExport.OpenExpediteOrder(LocCode);
      Loc1 := LocCode;
      RecCount := 0;

      with dmExport.qryExpediteOrder do
      begin

       Say('Exporting  expedite orders');

        while not eof do
        begin
          ProdCode := FieldByName('ProductCode').AsString;

          ConvertSKUCode(FCompany,ProdCode,StyleCode,ColourCode,DimCode,SizeCode);
          BrnCode := '';
          IncludeItem := true;

            if (FCompany in [_Holeproof]) then    //Workwear consol and Branch from Database
            begin
              if ((FCompany = _Holeproof) and (Loc1 <> 'UHG'))  then
                brnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,Loc1)
              else
                BrnCode := FieldByName('Warehouse').AsString;
            end
            else if (FCompany in [_Sheridan]) then
            begin
              //BrnCode := FieldByNAme('Warehouse').AsString;
              BrnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,FieldByNAme('LocationCode').AsString);
              {BrnCode := FieldByNAme('LocationCode').AsString;

              if Trim(BrnCode) = 'ADESKU' then
                BrnCode := 'TG';
              if Trim(BrnCode) = 'DASSKU' then
                BrnCode := 'E1';
              if Trim(BrnCode) = 'DAUSKU' then
                BrnCode := 'E2';
              if Trim(BrnCode) = 'PAPSKU' then
                BrnCode := 'X1';
              if Trim(BrnCode) = 'WHOSKUNZL' then
                BrnCode := 'ET';}                     //Version 6.12 -       CM 8/3/2012 - Updated to change AU to ET (Email JT - 29/2/2012)
 {*           end
            else
              BrnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,Loc1);
              //BrnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,Loc1);


          if (FCompany  in [_Holeproof]) then
            LocCode := FieldByNAme('Division').AsString;

            if FCompany = _Tontine then
            Begin
              LocCode := dmExport.qryExpediteOrder.FieldByNAme('Division').AsString;
              if LocCode = 'DEF' then LocCode:='??';
            end;

            if FCompany = _Sheridan then
            Begin
              LocCode := dmExport.qryExpediteOrder.FieldByNAme('Division').AsString;
              if LocCode = 'DEF' then LocCode:='??';
            end;

            if (FCompany in [_Holeproof]) and (BrnCode = '') then
              IncludeItem := false;

          OutStr := Format(OutFormat,
                           [Copy(LocCode,1,2),
                                         StyleCode,
                                         ColourCode,
                                         DimCode,
                                         SizeCode,
                            Copy(FieldByName('SupplierCode').AsString,1,6),
                            'CHASE',
                            FieldByName('QTY').asInteger,
                            ' ',
                            FormatDateTime('yyyymmdd',FieldByNAme('EAD').AsDateTime),
                            ' ',
                            'Expedite orders ',
                            BrnCode

                            ]);

          if IncludeItem then
          begin

            WriteLn(OutFile,OutStr+CompanyCode);
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

      end;

      Say('Records written : '+IntToStr(RecCount));
      dmExport.qryLocationList.Next;

    end;
 *}


    //-----------------------------------------------------------------------
{*    dmExport.qryLocationList.First;

    while not dmExport.qryLocationList.eof do
    begin

      LocCode := dmExport.qryLocationList.FieldByName('LocationCode').AsString;

      Say('Opening Potential Stockouts for '+LocCode);
      dmExport.OpenPotentialStockout(LocCode);
      RecCount := 0;
      Loc1 := LocCode;

      with dmExport.qryPotentialStockout do
      begin

       Say('Exporting Potential Stockouts');

        while not eof do
        begin

          ProdCode := FieldByName('ProductCode').AsString;

          BrnCode := '';
          IncludeItem := true;

            if (FCompany in [ _Holeproof]) then    //Workwear consol and Branch from Database
            begin
              if ((FCompany = _Holeproof) and (Loc1 <> 'UHG'))  then
                brnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,Loc1)
              else
                BrnCode := FieldByName('Warehouse').AsString;
            end
            else if (FCompany in [_Sheridan]) then
            begin
              //BrnCode := FieldByNAme('Warehouse').AsString;
              BrnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,FieldByNAme('LocationCode').AsString);
              {BrnCode := FieldByNAme('LocationCode').AsString;

              if Trim(BrnCode) = 'ADESKU' then
                BrnCode := 'TG';
              if Trim(BrnCode) = 'DASSKU' then
                BrnCode := 'E1';
              if Trim(BrnCode) = 'DAUSKU' then
                BrnCode := 'E2';
              if Trim(BrnCode) = 'PAPSKU' then
                BrnCode := 'X1';
              if Trim(BrnCode) = 'WHOSKUNZL' then
                BrnCode := 'ET';}                     //Version 6.12 -       CM 8/3/2012 - Updated to change AU to ET (Email JT - 29/2/2012)
 {*           end
            else
              BrnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,Loc1);
              //BrnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,Loc1);

          if (FCompany  in [_Holeproof]) then
            LocCode := FieldByNAme('Division').AsString;

            if FCompany = _Tontine then
            Begin
              LocCode := dmExport.qryPotentialStockout.FieldByNAme('Division').AsString;
              if LocCode = 'DEF' then LocCode:='??';
            end;

            if FCompany = _Sheridan then
            Begin
              LocCode := dmExport.qryPotentialStockout.FieldByNAme('Division').AsString;
              if LocCode = 'DEF' then LocCode:='??';
            end;

          ConvertSKUCode(FCompany,ProdCode,StyleCode,ColourCode,DimCode,SizeCode);

            if (FCompany in [_Holeproof]) and (BrnCode = '') then
              IncludeItem := false;


          OutStr := Format(OutFormat,
                           [Copy(LocCode,1,2),
                                         StyleCode,
                                         ColourCode,
                                         DimCode,
                                         SizeCode,
                            Copy(FieldByName('SupplierCode').AsString,1,6),
                            'CHASE',
                            FieldByName('QTY').asInteger,
                            ' ',
                            FormatDateTime('yyyymmdd',FieldByNAme('EAD').AsDateTime),
                            ' ',
                            'Replenish inventory or expedite orders ',
                            BrnCode

                            ]);

          if (IncludeItem) then
          begin
            WriteLn(OutFile,OutStr+companyCode);
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

      end;

      dmExport.qryLocationList.Next;
      Say('Records written : '+IntToStr(RecCount));

    end;
 *}
    //-----------------------------------------------------------------------
{*    dmExport.qryLocationList.First;

    DelayBuffer := StrToInt(frmParameters.GetParam('Delay Action Buffer Days'));


    while not dmExport.qryLocationList.eof do
    begin

      LocCode := dmExport.qryLocationList.FieldByName('LocationCode').AsString;

      Say('Opening Surplus Stock for '+LocCode);

      dmExport.OpenSurplusStock(LocCode);
      RecCount := 0;
      OpenItemTable(0);  //This prepares the query
              Loc1 := LocCode;

      with dmExport.qrySurplusStock do
      begin

       Say('Exporting Surplus Stock');


        while not eof do
        begin

          Qty := FieldByName('QTY').AsInteger;
          ProdCode := FieldByNAme('ProductCode').AsString;
          BrnCode := '';
          IncludeItem := true;

            if (FCompany in [ _Holeproof]) then    //Workwear consol and Branch from Database
            begin
              if ((FCompany = _Holeproof) and (Loc1 <> 'UHG'))  then
                brnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,Loc1)
              else
                BrnCode := FieldByName('Warehouse').AsString;
            end
            else if (FCompany in [_Sheridan]) then
            begin
              //BrnCode := FieldByNAme('Warehouse').AsString;
              BrnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,FieldByNAme('LocationCode').AsString);
              {BrnCode := FieldByNAme('LocationCode').AsString;

              if Trim(BrnCode) = 'ADESKU' then
                BrnCode := 'TG';
              if Trim(BrnCode) = 'DASSKU' then
                BrnCode := 'E1';
              if Trim(BrnCode) = 'DAUSKU' then
                BrnCode := 'E2';
              if Trim(BrnCode) = 'PAPSKU' then
                BrnCode := 'X1';
              if Trim(BrnCode) = 'WHOSKUNZL' then
                BrnCode := 'ET';}                     //Version 6.12 -       CM 8/3/2012 - Updated to change AU to ET (Email JT - 29/2/2012)
 {*           end
            else
              BrnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,Loc1);
              //BrnCode := GetWarehouseCode(FCompany,FieldByName('Division').AsString,Loc1);


          if (FCompany in [_Holeproof]) then
            LocCode := FieldByNAme('Division').AsString;

            if FCompany = _Tontine then
            Begin
              LocCode := dmExport.qrySurplusStock.FieldByNAme('Division').AsString;
              if LocCode = 'DEF' then LocCode:='??';
            end;

            if FCompany = _Sheridan then
            Begin
              LocCode := dmExport.qrySurplusStock.FieldByNAme('Division').AsString;
              if LocCode = 'DEF' then LocCode:='??';
            end;

          ConvertSKUCode(FCompany,ProdCode,StyleCode,ColourCode,DimCode,SizeCode);

          if (FCompany in [_Holeproof]) and (BrnCode = '') then
              IncludeItem := false;

          if (FieldByName('CancelInd').asString <> 'DELAY') then
            EAD := ''
          else
          begin

            EAD := '';

            //---------------------------------------------------------------

              with dmMainDLL do begin

                GetItemData(dmExport.qrySurplusStock.fieldbyName('xItemNo').AsInteger);

                ErrorCode := dmMainDll.DLL_Calc;

                if ErrorCode = 0 then
                begin

                  OffsetPO := 0;

                  for n := 0 to MAX_DAYS_ARRAY_SIZE do
                  begin

                    if (FFP.Dat[n].Receive > 0) or (FFP.Dat[n].BO > 0) then
                    begin
                      EAD := FormatDateTime('yyyymmdd',(dmMainDLL.FStockDownloadDate + n));
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
                      Qty := Qty + FDailyPurChaseOrders[n];
                    end;


                  end;

                end
                else
                begin
                  Say('** Error : '+IntToStr(ErrorCode) + ' ProdCode: '+ProdCode+' see Forward Plan for detail');

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
                              FieldByName('CancelInd').asString + ' orders ',
                              BrnCode


                              ]);
            if (IncludeItem) then
            begin
              WriteLn(OutFile,OutStr+companyCode);
            end;

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
*}
    //----------------------------------------------------------------------
    CloseFile(OutFile);

    Cursor := MyCursor;



    dmExport.FireEvent('S');

  except
      on e: exception do begin

        Say('*** Export place-chase-cancel-delay dev colour failed');
        Say('Last prod:'+ProdCode);
        Say('*** ' + e.Message);
        dmExport.FireEvent('F');
      end;
  end;

end;


procedure TfrmMainNew.OpenOrderItemTable(LocCodes: String);
var
  dCount:Integer;
  UseFilter:Boolean;
begin
  UseFilter := frmParameters.GetParam('Use Filter')='Yes';

  with dmMainDLL.qryItem do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select iif(p.Generic=''P'',replace(p.ProductCode,''-GEN'',''''),p.ProductCode) ProductCode, p.ProductDescription as PDescription,');
    SQL.Add('         l.LocationCode,l.Description as LDescription,              ');
 
    //Sheridan branch code
    if FCompany in [_Sheridan] then
    begin
      SQL.Add('         rc40.ReportCategoryCode as Warehouse, ');   //Uses this field as the Branch Code
      SQL.Add('         rc43.ReportCategoryCode as Division, ');
    end;

    //(WorkwearConsol)
    //if (FCompany in [_KingGee,_Leisure,_Footwear]) then
      //SQL.Add('         rc.REportCategoryCode as Division, ')
    //else
      //SQL.Add('         r4.REportCategoryCode as Division, ');

          if FCompany in [_Tontine] then
          begin
            //SQL.Add('         rc32.ReportCategoryCode as Division, ');
          end
          else
            SQL.Add('         r4.REportCategoryCode as Division, ');

    if FCompany in [_Holeproof] then
    begin
      SQL.Add('         rc51.ReportCategoryCode as Warehouse, ')   //Uses this field as the Branch Code
    end;

    SQL.Add('         sup.SupplierCode,              ');
    SQL.Add('        (i.TransitLT * 30.4) as TransitDays,');

    SQL.Add('         i.ItemNo,              ');
    SQL.Add('         i.LocationNo,              ');
    SQL.Add('         i.ParetoCategory, ');
    SQL.Add('         i.StockingIndicator, ');
    SQL.Add('         i.SafetyStock,');
    SQL.Add('         i.LeadTime,');
    SQL.Add('         i.TransitLT,');
    SQL.Add('         i.ReplenishmentCycle,');
    SQL.Add('         i.ReviewPeriod,');
    SQL.Add('         i.StockOnHand, ');
    SQL.Add('         i.BackOrder,');
    SQL.Add('         i.MINIMUMORDERQUANTITY,');
    SQL.Add('         i.OrderMultiples,');
    SQL.Add('         i.EffectiveRC,');
    SQL.Add('         i.STOCKONORDER_OTHER,');
    SQL.Add('         i.STOCKONORDERINLT_OTHER,');

    //Remove DRP Backorders TJ 25/06/04
    // Make it Zero becuase engine still needs a number
    SQL.Add('         0 as CONSOLIDATEDBRANCHORDERS,');

    SQL.Add('         i.BinLevel,');
    SQL.Add('         s.SalesAmount_0,');
    SQL.Add('         i.Forward_SS,');
    SQL.Add('         i.Forward_SSRC,');
    SQL.Add('         i.RecommendedOrder,');
    SQL.Add('         i.TopupOrder,');
    SQL.Add('         i.IdealOrder,');
    SQL.Add('         i.AbsoluteMinimumQuantity,');
    SQL.Add('         i.CALC_IDEAL_ARRIVAL_DATE,');
    SQL.Add('         i.StockOnOrder,');
    SQL.Add('         i.StockOnOrderInLT,');
    SQL.Add('         i.BackOrderRatio,');
    SQL.Add('         i.BOMBackOrderRatio,');
    SQL.Add('         i.DRPBackOrderRatio,');
    SQL.Add('         i.Stock_BuildNo,');
    SQL.Add('         sb.START_BUILD,sb.START_SHUTDOWN,sb.END_SHUTDOWN,sb.ORDERS_DURING_SHUTDOWN,');
    SQL.Add('         i.StockOnHand - i.BackOrder as NetStock,');
    SQL.Add('         r16.ReportCategoryCode as PlannerCode');

    if UseFilter then
      if (frmParameters.GetParam('Filter - Join SQL') <> '') then
        SQL.Add(CommaTextToLines(frmParameters.GetParam('Filter - Add Fields')));



    SQL.Add(' from Item i join product p on p.productno = i.productno');
    SQL.Add('               join location l on l.locationno=i.locationno');
    SQL.Add('               join ItemSales s on i.Itemno=s.ItemNo');
    SQL.Add('               left join Stock_Build sb on i.Stock_BuildNo=sb.Stock_BuildNo');
    SQL.Add('               left join Supplier sup on i.SupplierNo1=sup.SupplierNo');


          SQL.Add('               left join ITEM_REPORTCATEGORY r3 on i.ITEMNO = r3.ITEMNO and r3.REPORTCATEGORYTYPE = 1');
          SQL.Add('               left join ReportCategory r4 on r3.reportCategoryNo = r4.reportCategoryNo and r4.REPORTCATEGORYTYPE = 1');
       SQL.Add('               left join ITEM_REPORTCATEGORY ir16 on i.ITEMNO = ir16.ITEMNO and ir16.REPORTCATEGORYTYPE = 16');
      SQL.Add('               left join ReportCategory r16 on ir16.reportCategoryNo = r16.reportCategoryNo and r16.REPORTCATEGORYTYPE = 16');

    if FCompany in [_Holeproof] then
    begin
        SQL.Add('               left join ITEM_REPORTCATEGORY r51 on i.ITEMNO = r51.ITEMNO and r51.REPORTCATEGORYTYPE = 51');
        SQL.Add('               left join ReportCategory rc51 on r51.ReportCategoryNo=rc51.ReportCategoryNo and rc51.ReportCategoryType=51');
    end;

    //Sheridan branch code
    if FCompany in [_Sheridan] then
    begin
      SQL.Add('               left join ITEM_REPORTCATEGORY r40 on i.ITEMNO = r40.ITEMNO and r40.REPORTCATEGORYTYPE = 40');
      SQL.Add('               left join ReportCategory rc40 on r40.ReportCategoryNo=rc40.ReportCategoryNo and rc40.ReportCategoryType=40');
      SQL.Add('               left join ITEM_REPORTCATEGORY r43 on i.ITEMNO = r43.ITEMNO and r43.REPORTCATEGORYTYPE = 43');
      SQL.Add('               left join ReportCategory rc43 on r43.ReportCategoryNo=rc43.ReportCategoryNo and rc43.ReportCategoryType=43');
    end;

    if UseFilter then
      SQL.Add(CommaTextToLines(frmParameters.GetParam('Filter - Join SQL')));


    SQL.Add(' where LocationCode in ('+LocCodes+')');

    SQL.Add(' and (I.GENERIC in (''N'', ''P''))');

    if Trim(frmParameters.GetParam('Product Code')) <> '' then
      SQL.Add(' and ProductCode = "'+Trim(frmParameters.GetParam('Product Code'))+'"');

    if UseFilter then
      SQL.Add(CommaTextToLines(frmParameters.GetParam('Filter - Where SQL')));


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
  SCount:Integer;
begin

  with dmMainDLL.qryItem do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select   iif(p.Generic=''P'',replace(p.ProductCode,''-GEN'',''''),p.ProductCode) ProductCode, p.ProductDescription as PDescription,');
    SQL.Add('         l.LocationCode,l.Description as LDescription,');

    if FCompany in [_Tontine] then
    begin
      SQL.Add('         rc32.ReportCategoryCode as Division, ');
    end
    else if FCompany in [_Sheridan] then
    begin
      SQL.Add('         rc43.ReportCategoryCode as Division, ');
    end
    else
      SQL.Add('         r4.REportCategoryCode as Division, ');
 
    //Sheridan branch code
    if FCompany in [_Sheridan] then
    begin
      SQL.Add('         rc40.ReportCategoryCode as Warehouse, ');   //Uses this field as the Branch Code
    end;

    SQL.Add('         sup.SupplierCode,              ');

    SQL.Add('         i.ItemNo,              ');
    SQL.Add('         i.LocationNo,              ');
    SQL.Add('         i.ParetoCategory, ');
    SQL.Add('         i.StockingIndicator, ');
    SQL.Add('         i.SafetyStock,');
    SQL.Add('         i.LeadTime,');
    SQL.Add('         i.TransitLT,');
    SQL.Add('         i.ReplenishmentCycle,');
    SQL.Add('         i.ReviewPeriod,');
    SQL.Add('         i.StockOnHand, ');
    SQL.Add('         i.BackOrder,');
    SQL.Add('         i.MINIMUMORDERQUANTITY,');
    SQL.Add('         i.OrderMultiples,');
    SQL.Add('         r16.ReportCategoryCode as PlannerCode,');

    //Remove DRP Backorders TJ 25/06/04
    // Make it Zero becuase engine still needs a number
    SQL.Add('         0 as CONSOLIDATEDBRANCHORDERS,');

    SQL.Add('         i.BinLevel,');
    SQL.Add('         s.SalesAmount_0,');
    SQL.Add('         i.Forward_SS,');
    SQL.Add('         i.Forward_SSRC,');
    SQL.Add('         i.RecommendedOrder,');
    SQL.Add('         i.TopupOrder,');
    SQL.Add('         i.IdealOrder,');
    SQL.Add('         i.AbsoluteMinimumQuantity,');
    SQL.Add('         i.CALC_IDEAL_ARRIVAL_DATE,');
    SQL.Add('         i.StockOnOrder,');
    SQL.Add('         i.StockOnOrderInLT,');
    SQL.Add('         i.BackOrderRatio,');
    SQL.Add('         i.BOMBackOrderRatio,');
    SQL.Add('         i.DRPBackOrderRatio,');
      SQL.Add('         i.EffectiveRC,');
      SQL.Add('         i.STOCKONORDER_OTHER,');
      SQL.Add('         i.STOCKONORDERINLT_OTHER,');
    SQL.Add('         i.Stock_BuildNo,');
    SQL.Add('         sb.START_BUILD,sb.START_SHUTDOWN,sb.END_SHUTDOWN,sb.ORDERS_DURING_SHUTDOWN,');
    SQL.Add('         i.StockOnHand - i.BackOrder as NetStock');

    SQL.Add(' from Item i left join product p on p.productno = i.productno');
    SQL.Add('               left join location l on l.locationno=i.locationno');
    SQL.Add('               left join ItemSales s on i.Itemno=s.ItemNo');
    SQL.Add('               left join Stock_Build sb on i.Stock_BuildNo=sb.Stock_BuildNo');
    SQL.Add('               left join Supplier sup on i.SupplierNo1=sup.SupplierNo');

      SQL.Add('               left join ITEM_REPORTCATEGORY r3 on i.ITEMNO = r3.ITEMNO and r3.REPORTCATEGORYTYPE = 1');
      SQL.Add('               left join ReportCategory r4 on r3.reportCategoryNo = r4.reportCategoryNo and r4.REPORTCATEGORYTYPE = 1');
      SQL.Add('               left join ITEM_REPORTCATEGORY ir16 on i.ITEMNO = ir16.ITEMNO and ir16.REPORTCATEGORYTYPE = 16');
      SQL.Add('               left join ReportCategory r16 on ir16.reportCategoryNo = r16.reportCategoryNo and r16.REPORTCATEGORYTYPE = 16');

    if FCompany in [_Tontine] then
    begin
      SQL.Add('               left join ITEM_REPORTCATEGORY r32 on i.ITEMNO = r32.ITEMNO and r32.REPORTCATEGORYTYPE = 32');
      SQL.Add('               left join ReportCategory rc32 on r32.ReportCategoryNo=rc32.ReportCategoryNo and rc32.ReportCategoryType=32');
    end;

    if FCompany = _Sheridan then
    begin
      SQL.Add('               left join ITEM_REPORTCATEGORY r43 on i.ITEMNO = r43.ITEMNO and r43.REPORTCATEGORYTYPE = 43');
      SQL.Add('               left join ReportCategory rc43 on r43.ReportCategoryNo=rc43.ReportCategoryNo and rc43.ReportCategoryType=43');
    end;

    //Sheridan branch code
    if FCompany in [_Sheridan] then
    begin
      SQL.Add('               left join ITEM_REPORTCATEGORY r40 on i.ITEMNO = r40.ITEMNO and r40.REPORTCATEGORYTYPE = 40');
      SQL.Add('               left join ReportCategory rc40 on r40.ReportCategoryNo=rc40.ReportCategoryNo and rc40.ReportCategoryType=40');
    end;

    SQL.Add(' where i.ItemNo = :ItemNo');
    //SQL.Add(' where ItemNo = '+IntToStr(ItemNo));

    SQL.Add(' and (I.GENERIC in (''N'', ''P''))');

    if Trim(frmParameters.GetParam('Product Code')) <> '' then
      SQL.Add(' and ProductCode = "'+Trim(frmParameters.GetParam('Product Code'))+'"');

    //ExecQuery;

    Say('--- Start SQL ---');

    for SCount := 0 to SQL.Count-1 do
    begin
      Say(SQL.Strings[SCount]);
    end;
    Say('--- End SQL ---');
    Application.ProcessMessages;

  end;

end;

procedure TfrmMainNew.OpenPODaily;
begin

  with dmMainDLL do
  begin
    SqlPO.Close;
    SqlPO.ParamByName('ITEMNO').AsInteger := qryItem.FieldByName('ITEMNO').AsInteger;
    SqlPO.ExecQuery;
    SetDailyPO(dmMainDLL.FStockDownloadDate);
  end;

end;

procedure TfrmMainNew.SetDailyPO(DownDate:TDateTime);
var
  n, DayOffset : integer;
  TempDate:TDateTime;
begin

  for n := 0 to MAX_DAYS_ARRAY_SIZE do
    FDailyPurChaseOrders[n] := 0;

  // Combine POs due on same day into 1 number for the day
  with dmMainDLL.SqlPO do begin

    while not eof do
    begin

     TempDate := FieldByName('ExpectedArrivalDate').AsDateTime;
     DayOffset := Round((TempDate - DownDate)+1);

     if DayOffSet < 0 Then
       DayOffSet := 0;

     FDailyPurChaseOrders[DayOffSet] := FDailyPurChaseOrders[DayOffSet] + FieldByName('Quantity').AsInteger;

     next;

    end;

  end;

end;

function TfrmMainNew.FileOutFormat: String;
begin
  // Layout Div,Style,Colour,Dim,Size,...

  //Style Code Length = 9
      Result := '%-2.2s%-6.6s%-3.3s%-3.3s%-5.5s%-6.6s'+
                             '%-6.6s%7d%-8.8s%-8.8s%-8.8s%-50.50s%-3.3s%-3.3s%-1.1s%-1.1s%7d';
end;

procedure TfrmMainNew.GetItemData(ItemNo: Integer);
begin
    with dmMainDLL.qryItem do
    begin
      Close;
      ParamByName('ItemNo').AsInteger := ItemNo ;
      Prepare;
      ExecQuery;
    end;

end;

function TfrmMainNew.CommaTextToLines(TheCommaText: String): String;
var
  TempString:TStringList;
  iCount:Integer;
begin
  TempString := TStringList.Create;

  TempString.CommaText := TheCommatext;
  Result := '';

  for ICount := 0 to TempString.Count-1 do
  begin
    if ICount > 0 then Result := Result + #10;

    Result := Result+TempString.Strings[ICount];

  end;

  TempString.Free;


end;

function TfrmMainNew.GetWarehouseCodeDevColour(CompanyID:Integer; LocCode:String): String;
begin
	Result := 'TG';   //default
        if LocCode='DEVCLRAU' then
        	Result:='TG'
        else  if LocCode='DEVCLRNZ' then
        	Result:='ET';

end;

procedure TfrmMainNew.ConvertDevColourCode(CompanyID:Integer;ProdCode:String;
                         var StyleCode,ColourCode,DimCode,SizeCode:String);
var
  TempStr:String;
  posUnderscore: integer;
begin
  StyleCode := '';
  ColourCode := '';
  DimCode := '';
  SizeCode := '';

    // fixed length style/color with delimiter
    // then Size Dimension
    //  Style_Colour_Size_Dimension
    posUnderscore := Pos('_', ProdCode);
    StyleCode := Copy(ProdCode,1,posUnderscore-1);
    ColourCode := Copy(ProdCode,posUnderscore+1,3);

    //assume fixed length upto this position then size can vary.
    TempStr := Trim(Copy(ProdCode,12,Length(ProdCode)));

    SizeCode := '';
    DimCode := '';

end;


end.
