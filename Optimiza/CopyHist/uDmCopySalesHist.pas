unit uDmCopySalesHist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery,
  IBSQL;

type
  TdmCopySalesHist = class(TdmOptimiza)
    qryAllLocations: TIBQuery;
    srcAllLocations: TDataSource;
    qrySearchProduct: TIBQuery;
    srcSearchProduct: TDataSource;
    qryTargetLocations: TIBQuery;
    srcTargetLocations: TDataSource;
    prcUpdateSales: TIBStoredProc;
    qryCheckTarget: TIBQuery;
    srcCheckTarget: TDataSource;
    qryAddStoredProc: TIBSQL;
    qryCheckProc: TIBSQL;
    qryPeriod: TIBQuery;
    srcPeriod: TDataSource;
    qryAddSpecial: TIBSQL;
    qryDrop: TIBSQL;
    prcUpdateSalesSpecial: TIBStoredProc;
    qrySpecialOriginal: TIBSQL;
    SQLWork: TIBSQL;
    prcUpdateItemDetails: TIBStoredProc;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure OpenSearchProd(KeyData: String);
    procedure UpdateSale(SrcLoc, TgtLoc, SrcProd, TgtProd,ReplaceInd: String;Special:Boolean);
    procedure UpdateItemDetails(SrcLoc, TgtLoc, SrcProd, TgtProd: String);
    procedure CommitSale;
    function CheckTarget(LocCode, ProdCode: String): Boolean;
    function CheckProcedure:Boolean;
    procedure OpenPeriod;
    procedure UpdateItemProc();
    procedure OpenFC_Period;
  end;

var
  dmCopySalesHist: TdmCopySalesHist;

implementation

uses uStatus, uCopyMultipleHistory;

{$R *.DFM}

procedure TdmCopySalesHist.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryAllLocations.Open;
end;

procedure TdmCopySalesHist.OpenSearchProd(KeyData: String);
var
  cSql: String;
begin

  With qrySearchProduct do
  begin
    Close;
    cSql := 'Select ProductCode, ProductDescription, ProductNo  From Product where ProductCode >= "'+KeyData+'" Order by ProductCode';
    SQL.Clear;
    SQL.Add(cSql);
    Open;
  end;

end;

procedure TdmCopySalesHist.UpdateSale(SrcLoc, TgtLoc, SrcProd, TgtProd,ReplaceInd: String;Special:Boolean);
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  try

    if frmCopySalesHist.cbCopySales.Checked then
    begin
      if Special then
      begin

        with prcUpdateSalesSpecial do
        begin
         ParamByName('SourceLocationCode').AsString := SrcLoc;
         ParamByName('TargetLocationCode').AsString := TgtLoc;
         ParamByName('SourceProductCode').AsString := SrcProd;
         ParamByName('TargetProductCode').AsString := TgtProd;
         ParamByName('ReplaceInd').AsString := ReplaceInd;
         Prepare;
         ExecProc;
        end;

      end
      else
      begin

        with prcUpdateSales do
        begin
         ParamByName('SourceLocationCode').AsString := SrcLoc;
         ParamByName('TargetLocationCode').AsString := TgtLoc;
         ParamByName('SourceProductCode').AsString := SrcProd;
         ParamByName('TargetProductCode').AsString := TgtProd;
         ParamByName('ReplaceInd').AsString := ReplaceInd;
         Prepare;
         ExecProc;
        end;

      end;


      frmStatus.ListBox1.Items.Add('Copied Product '+SrcProd + ' From ' +SrcLoc+' to Product '+TgtProd+' in ' + TgtLoc);
      frmStatus.Show;

    end;
  except
  end;

end;

procedure TdmCopySalesHist.UpdateItemDetails(SrcLoc, TgtLoc, SrcProd, TgtProd: String);
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  try

    with prcUpdateItemDetails do
    begin
      ParamByName('SourceLocationCode').AsString := SrcLoc;
      ParamByName('TargetLocationCode').AsString := TgtLoc;
      ParamByName('SourceProductCode').AsString := SrcProd;
      ParamByName('TargetProductCode').AsString := TgtProd;
      Prepare;
      ExecProc;
    end;


    frmStatus.ListBox1.Items.Add('Copied Product '+SrcProd + ' From ' +SrcLoc+' to Product '+TgtProd+' in ' + TgtLoc);
    frmCopySalesHist.Say('    Copied Product '+SrcProd + ' From ' +SrcLoc+' to Product '+TgtProd+' in ' + TgtLoc);
    frmStatus.Show;
  except
  end;

end;

procedure TdmCopySalesHist.CommitSale;
begin
  if trnOptimiza.InTransaction then
    trnOptimiza.commit;

  frmStatus.ListBox1.Items.Add('...Done');
  frmCopySalesHist.Say('    ...Done');
  qryAllLocations.Open;
end;

function TdmCopySalesHist.CheckTarget(LocCode, ProdCode: String): Boolean;
var
 TestCode: String;
begin

  Result := False;

  try
    qryCheckTarget.Close;
    qrycheckTarget.ParamByName('LocCode').AsString := LocCode;
    qrycheckTarget.ParamByName('ProdCode').AsString := ProdCode;
    qryCheckTarget.Prepare;
    qryCheckTarget.Open;

    TestCode := Trim(qryCheckTarget.FieldByName('ItemNo').AsString);

    if TestCode <> '' then Result := True;

  except

    Result := False;
  end;

  if result = False then
  begin
    frmStatus.ListBox1.Items.Add('Product Code: '+ProdCode+' Does not exist in Location: '+LocCode);
    frmCopySalesHist.Say('    Product Code: '+ProdCode+' Does not exist in Location: '+LocCode);
  end;

end;


function TdmCopySalesHist.CheckProcedure:Boolean;
var
  Installed:Boolean;
begin

    if not trnOptimiza.InTransaction then
      trnOptimiza.StartTransaction;

    with qryCheckProc do
    begin
      ExecQuery;

      Installed := False;

      if FieldByName('Rdb$Procedure_ID').AsInteger > 0 then
        Installed := True;

    end;

    if not Installed then
    begin

      if MessageDlg('Add Sales Stored Proc not installed, Install Now',mtConfirmation,[mbYes,mbNo],0) = mrYes then
      begin

        try
          with qryAddStoredProc do
          begin
            ExecQuery;
            Close;
          end;

          trnOptimiza.Commit;
          trnOptimiza.StartTransaction;
          Installed:=true;

          MessageDlg('Stored proc installed',mtInformation,[mbOK],0);
        except
          Installed:=False;
          MessageDlg('Stored proc Failed to install. Contact Optimiza Administrator',mtError,[mbOK],0);
        end;



      end;


    end;

    Result := Installed;

end;

procedure TdmCopySalesHist.OpenPeriod;
var
  StartPeriod, EndPeriod: Integer;
begin
  StartPeriod := GetCurrentPeriod - 36;
  EndPeriod := GetCurrentPeriod;

  qryPeriod.Close;
  qryPeriod.SQL.Clear;
  qryPeriod.SQL.Add('Select Description,Calendarno from Calendar where Calendarno >= :StartPeriod and CalendarNo <= :EndPeriod Order by 2 descending');
  qryPeriod.ParamByName('StartPeriod').AsInteger := StartPeriod;
  qryPeriod.ParamByName('EndPeriod').AsInteger := EndPeriod;
  qryPeriod.Prepare;
  qryPeriod.Open;

end;

procedure TdmCopySalesHist.OpenFC_Period;
var
  StartPeriod, EndPeriod: Integer;
  tempStr:  String;
begin
  StartPeriod := GetCurrentPeriod;
  EndPeriod := GetCurrentPeriod + 36;

  qryPeriod.Close;
  qryPeriod.SQL.Clear;
  qryPeriod.SQL.Add('Select Description,Calendarno from Calendar where Calendarno >= :StartPeriod and CalendarNo <= :EndPeriod Order by 2');
  qryPeriod.ParamByName('StartPeriod').AsInteger := StartPeriod;
  qryPeriod.ParamByName('EndPeriod').AsInteger := EndPeriod;
  qryPeriod.Prepare;
  qryPeriod.Open;

end;

procedure TdmCopySalesHist.UpdateItemProc();
Var
  LineNo,SCount,lCount:Integer;
  SqlStr, Cont, Tempstr:String;
  ChangeItemDetails: boolean;
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  //always drop, then we re-create necessary
  //drop may fail id doesn't exist
  try
    SQLWork.SQL.Clear;
    SQLWork.SQL.Add('execute block as begin');
    SQLWork.SQL.Add('    if (exists (Select * from rdb$procedures where RDB$PROCEDURE_NAME = "UP_COPYITEMDETAILS")) then');
    SQLWork.SQL.Add('    begin');
    SQLWork.SQL.Add('       execute STATEMENT("drop procedure up_copyItemDetails;");');
    SQLWork.SQL.Add('    end');
    SQLWork.SQL.Add('end;');
    SQLWork.ExecQuery;
    SQLWork.Close;
    trnOptimiza.Commit;
  except
    exit;
  end;

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;
  try
    SQLWork.SQL.Clear;
    SQLWork.SQL.Add('CREATE PROCEDURE UP_COPYITEMDETAILS(');
    SQLWork.SQL.Add('SOURCELOCATIONCODE VARCHAR(10),');
    SQLWork.SQL.Add('TARGETLOCATIONCODE VARCHAR(10),');
    SQLWork.SQL.Add('SOURCEPRODUCTCODE VARCHAR(30),');
    SQLWork.SQL.Add('TARGETPRODUCTCODE VARCHAR(30))');
    SQLWork.SQL.Add('AS');
    SQLWork.SQL.Add('DECLARE VARIABLE CALENDARNO INTEGER;');
    SQLWork.SQL.Add('DECLARE VARIABLE xSourceLocationNo INTEGER;');
    SQLWork.SQL.Add('DECLARE VARIABLE xTargetLocationNo INTEGER;');
    SQLWork.SQL.Add('DECLARE VARIABLE xSourceItemNo INTEGER;');
    SQLWork.SQL.Add('DECLARE VARIABLE xTargetItemNo INTEGER;');

    ChangeItemDetails := false;
    SCount := SQLWork.SQL.Count;
    TempStr := '';
    Cont := '';
    if frmCopySalesHist.cbPareto.Checked then
    begin
      SQLWork.SQL.Add('DECLARE VARIABLE XPARETOCATEGORY CHAR(1);');
      TempStr := TempStr + Cont + 'Pareto';
      Cont := ', ';
    end;
    if frmCopySalesHist.cbStockingIndicator.Checked then
    begin
      SQLWork.SQL.Add('DECLARE VARIABLE XSTOCKINGINDICATOR CHAR(1);');
      TempStr := TempStr + Cont + 'Stocking Indicator';
      Cont := ', ';
    end;
    if frmCopySalesHist.cbCriticality.Checked then
    begin
      SQLWork.SQL.Add('DECLARE VARIABLE XCRITICALITY CHAR(1);');
      TempStr := TempStr + Cont + 'Criticality';
      Cont := ', ';
    end;
    if frmCopySalesHist.cbBinLevel.Checked then
    begin
      SQLWork.SQL.Add('DECLARE VARIABLE XBINLEVEL DOUBLE PRECISION;');
      TempStr := TempStr + Cont + 'Bin Level';
      Cont := ', ';
    end;
    if frmCopySalesHist.cbMOQ.Checked then
    begin
      SQLWork.SQL.Add('DECLARE VARIABLE XMINIMUMORDERQUANTITY DOUBLE PRECISION;');
      TempStr := TempStr + Cont + 'Minimum Order Qty';
      Cont := ', ';
    end;
    if frmCopySalesHist.cbMOQ.Checked then
    begin
      SQLWork.SQL.Add('DECLARE VARIABLE XORDERMULTIPLES DOUBLE PRECISION;');
      TempStr := TempStr + Cont + 'Multiples';
      Cont := ', ';
    end;
    if frmCopySalesHist.cbSupplier.Checked then
    begin
      SQLWork.SQL.Add('DECLARE VARIABLE XSUPPLIERNO1 INTEGER;');
      TempStr := TempStr + Cont + 'Supplier';
      Cont := ', ';
    end;
    if SCount <> SQLWork.SQL.Count then
    begin
      ChangeItemDetails := true;
      frmCopySalesHist.Say('  Copy the following item details: '+TempStr);
    end;

    SQLWork.SQL.Add('DECLARE VARIABLE xSourceAge INTEGER;');
    SQLWork.SQL.Add('DECLARE VARIABLE xTargetAge INTEGER;');

    if frmCopySalesHist.cbCopySales.Checked then
    begin
      if frmCopySalesHist.rgSalesReplaceAdd.ItemIndex = 0 then
      begin
        for SCount := 0 to 120 do
        begin
          SQLWork.SQL.Add('DECLARE VARIABLE SALESAMOUNT_'+IntToStr(SCount)+' DOUBLE PRECISION;');
        end;
        if frmCopySalesHist.rgSalesAdd.ItemIndex = 0 then
        begin
          // Replace History
          frmCopySalesHist.Say('  Copy ALL Sales Details (Replace destination)');
        end
        else
        begin
          // Add History
          frmCopySalesHist.Say('  Copy ALL Sales Details (Add  to destination)');
        end;
     end
      else
      begin
        for SCount := frmCopySalesHist.cbSalesStartMth.ItemIndex to frmCopySalesHist.cbSalesBacktoMth.ItemIndex do
        begin
          SQLWork.SQL.Add('DECLARE VARIABLE SALESAMOUNT_'+IntToStr(SCount)+' DOUBLE PRECISION;');
        end;
        if frmCopySalesHist.rgSalesAdd.ItemIndex = 0 then
        begin
          // Replace History
          frmCopySalesHist.Say('  Copy Sales details for: ' + frmCopySalesHist.cbSalesBacktoMth.Text + ' to ' + frmCopySalesHist.cbSalesStartMth.Text + ' (Replace destination)');
        end
        else
        begin
          // Add History
          frmCopySalesHist.Say('  Copy Sales details for: ' + frmCopySalesHist.cbSalesBacktoMth.Text + ' to ' + frmCopySalesHist.cbSalesStartMth.Text + ' (Add to destination)');
        end;
      end;
    end;

    if frmCopySalesHist.cbCopyForecast.Checked then
    begin
      if frmCopySalesHist.rgFC_ReplaceAdd.ItemIndex = 0 then
      begin
        for SCount := 0 to 51 do
        begin
          SQLWork.SQL.Add('DECLARE VARIABLE FORECAST_'+IntToStr(SCount)+' DOUBLE PRECISION;');
        end;
        if frmCopySalesHist.rgFC_Add.ItemIndex = 0 then
        begin
          // Replace History
          frmCopySalesHist.Say('  Copy ALL Forecast Details (Replace destination)');
        end
        else
        begin
          // Add History
          frmCopySalesHist.Say('  Copy ALL Forecast Details (Add to destination)');
        end;
      end
      else
      begin
        for SCount := frmCopySalesHist.cbFC_StartMth.ItemIndex to frmCopySalesHist.cbFC_ForwardtoMth.ItemIndex do
        begin
          SQLWork.SQL.Add('DECLARE VARIABLE FORECAST_'+IntToStr(SCount)+' DOUBLE PRECISION;');
        end;
        if frmCopySalesHist.rgFC_Add.ItemIndex = 0 then
        begin
          // Replace History
          frmCopySalesHist.Say('  Copy Forecast details for: ' + frmCopySalesHist.cbFC_ForwardtoMth.Text + ' to ' + frmCopySalesHist.cbFC_StartMth.Text + ' (Replace destination)');
        end
        else
        begin
          // Add History
          frmCopySalesHist.Say('  Copy Forecast details for: ' + frmCopySalesHist.cbFC_ForwardtoMth.Text + ' to ' + frmCopySalesHist.cbFC_StartMth.Text + ' (Add to destination)');
        end;
      end;
    end;

    frmCopySalesHist.Say('============================================================================================');
    frmCopySalesHist.Say(' ');

    SQLWork.SQL.Add('begin');
    SQLWork.SQL.Add(' Select LocationNO From Location where LocationCode =');
    SQLWork.SQL.Add('      :TARGETLOCATIONCODE');
    SQLWork.SQL.Add('      into :xTargetLocationNo;');
    SQLWork.SQL.Add(' ');
    SQLWork.SQL.Add('  Select LocationNO From Location where LocationCode =');
    SQLWork.SQL.Add('      :SOURCELOCATIONCODE');
    SQLWork.SQL.Add('      into :xSourceLocationNo;');
    SQLWork.SQL.Add(' ');
    SQLWork.SQL.Add('  Select ItemNo, Age From Item where locationno = :xSourceLocationNo');
    SQLWork.SQL.Add('           and productno = (Select ProductNO From Product where ProductCode =');
    SQLWork.SQL.Add('      :SOURCEPRODUCTCODE)');
    SQLWork.SQL.Add('      into :xSourceItemNo, :xSourceAge;');
    SQLWork.SQL.Add(' ');
    SQLWork.SQL.Add('  Select ItemNo, Age From Item where locationno = :xTargetLocationNo');
    SQLWork.SQL.Add('           and productno = (Select ProductNO From Product where ProductCode =');
    SQLWork.SQL.Add('      :TARGETPRODUCTCODE)');
    SQLWork.SQL.Add('      into :xTargetItemNo, :xTargetAge;');
    SQLWork.SQL.Add(' ');
    SQLWork.SQL.Add('  IF (xSourceAge > xTargetAge) Then');
    SQLWork.SQL.Add('  begin');
    SQLWork.SQL.Add('    xTargetAge = xSourceAge;');
    SQLWork.SQL.Add('  end');
    SQLWork.SQL.Add(' ');
    SQLWork.SQL.Add('  select TYPEOFINTEGER from CONFIGURATION where CONFIGURATIONNO = 100 into :CALENDARNO;');
    SQLWork.SQL.Add(' ');

    if ChangeItemDetails then
    begin
      SQLWork.SQL.Add('  For Select');
      Cont:='';
      if frmCopySalesHist.cbPareto.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'PARETOCATEGORY');
        Cont := ',';
      end;
      if frmCopySalesHist.cbStockingIndicator.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'STOCKINGINDICATOR');
        Cont := ',';
      end;
      if frmCopySalesHist.cbCriticality.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'CRITICALITY');
        Cont := ',';
      end;
      if frmCopySalesHist.cbBinLevel.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'BINLEVEL');
        Cont := ',';
      end;
      if frmCopySalesHist.cbMOQ.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'MINIMUMORDERQUANTITY');
        Cont := ',';
      end;
      if frmCopySalesHist.cbMOQ.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'ORDERMULTIPLES');
        Cont := ',';
      end;
      if frmCopySalesHist.cbSupplier.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'SUPPLIERNO1');
        Cont := ',';
      end;
      SQLWork.SQL.Add('       From Item');
      SQLWork.SQL.Add('            where ItemNo = :xSourceItemNo');
      SQLWork.SQL.Add('        Into');

      Cont:='';
      if frmCopySalesHist.cbPareto.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+':xPARETOCATEGORY');
        Cont := ',';
      end;
      if frmCopySalesHist.cbStockingIndicator.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+':xSTOCKINGINDICATOR');
        Cont := ',';
      end;
      if frmCopySalesHist.cbCriticality.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+':xCRITICALITY');
        Cont := ',';
      end;
      if frmCopySalesHist.cbBinLevel.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+':xBINLEVEL');
        Cont := ',';
      end;
      if frmCopySalesHist.cbMOQ.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+':xMINIMUMORDERQUANTITY');
        Cont := ',';
      end;
      if frmCopySalesHist.cbMOQ.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+':xORDERMULTIPLES');
        Cont := ',';
      end;
      if frmCopySalesHist.cbSupplier.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+':xSUPPLIERNO1');
        Cont := ',';
      end;
      SQLWork.SQL.Add('  Do Begin');
      SQLWork.SQL.Add('      Update Item');
      SQLWork.SQL.Add('      Set');
      Cont:='';
      if frmCopySalesHist.cbPareto.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'PARETOCATEGORY = :xPARETOCATEGORY');
        Cont := ',';
      end;
      if frmCopySalesHist.cbStockingIndicator.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'STOCKINGINDICATOR = :xSTOCKINGINDICATOR');
        Cont := ',';
      end;
      if frmCopySalesHist.cbCriticality.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'CRITICALITY = :xCRITICALITY');
        Cont := ',';
      end;
      if frmCopySalesHist.cbBinLevel.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'BINLEVEL = :xBINLEVEL');
        Cont := ',';
      end;
      if frmCopySalesHist.cbMOQ.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'MINIMUMORDERQUANTITY = :xMINIMUMORDERQUANTITY');
        Cont := ',';
      end;
      if frmCopySalesHist.cbMOQ.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'ORDERMULTIPLES = :xORDERMULTIPLES');
        Cont := ',';
      end;
      if frmCopySalesHist.cbSupplier.Checked then
      begin
        SQLWork.SQL.Add('        '+Cont+'SUPPLIERNO1 = :xSUPPLIERNO1');
        Cont := ',';
      end;
      SQLWork.SQL.Add('      where Itemno = :xTargetItemNo;');
      SQLWork.SQL.Add('  end ');
    end;

    if frmCopySalesHist.cbCopySales.Checked then
    begin
      SQLWork.SQL.Add(' ');
      SQLWork.SQL.Add('  For Select');
      Cont:='';
      if frmCopySalesHist.rgSalesReplaceAdd.ItemIndex = 0 then
      begin
        for SCount := 0 to 120 do
        begin
          SQLWork.SQL.Add('        '+Cont+'s.SALESAMOUNT_'+IntToStr(SCount));
          Cont:=',';
        end;
      end
      else
      begin
        for SCount := frmCopySalesHist.cbSalesStartMth.ItemIndex to frmCopySalesHist.cbSalesBacktoMth.ItemIndex do
        begin
          SQLWork.SQL.Add('        '+Cont+'s.SALESAMOUNT_'+IntToStr(SCount));
          Cont:=',';
        end;
      end;
      SQLWork.SQL.Add('       From ItemSales s');
      SQLWork.SQL.Add('            where s.ItemNo = :xSourceItemNo');
      SQLWork.SQL.Add('        Into');
      Cont:='';
      if frmCopySalesHist.rgSalesReplaceAdd.ItemIndex = 0 then
      begin
        for SCount := 0 to 120 do
        begin
          SQLWork.SQL.Add('        '+Cont+':SALESAMOUNT_'+IntToStr(SCount));
          Cont:=',';
        end;
      end
      else
      begin
        for SCount := frmCopySalesHist.cbSalesStartMth.ItemIndex to frmCopySalesHist.cbSalesBacktoMth.ItemIndex do
        begin
          SQLWork.SQL.Add('        '+Cont+':SALESAMOUNT_'+IntToStr(SCount));
          Cont:=',';
        end;
      end;
      SQLWork.SQL.Add('  Do Begin');
      SQLWork.SQL.Add('      Update ItemSales');
      SQLWork.SQL.Add('      Set');
      Cont:='';
      if frmCopySalesHist.rgSalesReplaceAdd.ItemIndex = 0 then
      begin
        for SCount := 0 to 120 do
        begin
          if frmCopySalesHist.rgSalesAdd.ItemIndex = 0 then
          begin
            // Replace History
            SQLWork.SQL.Add('        '+Cont+'SALESAMOUNT_'+IntToStr(SCount)+' = :SALESAMOUNT_'+IntToStr(SCount));
          end
          else
          begin
            // Add History
            SQLWork.SQL.Add('        '+Cont+'SALESAMOUNT_'+IntToStr(SCount)+' = SALESAMOUNT_'+IntToStr(SCount)+' + :SALESAMOUNT_'+IntToStr(SCount));
          end;
          Cont:=',';
        end;
      end
      else
      begin
        for SCount := frmCopySalesHist.cbSalesStartMth.ItemIndex to frmCopySalesHist.cbSalesBacktoMth.ItemIndex do
        begin
          if frmCopySalesHist.rgSalesAdd.ItemIndex = 0 then
          begin
            // Replace History
            SQLWork.SQL.Add('        '+Cont+'SALESAMOUNT_'+IntToStr(SCount)+' = :SALESAMOUNT_'+IntToStr(SCount));
          end
          else
          begin
            // Add History
            SQLWork.SQL.Add('        '+Cont+'SALESAMOUNT_'+IntToStr(SCount)+' = SALESAMOUNT_'+IntToStr(SCount)+' + :SALESAMOUNT_'+IntToStr(SCount));
          end;
          Cont:=',';
        end;
      end;
      SQLWork.SQL.Add('      where Itemno = :xTargetItemNo;');
      SQLWork.SQL.Add('      execute procedure GetItemAge(:xTargetItemNo) returning_values (:xTargetAge);');
      SQLWork.SQL.Add('      Update Item ');
      SQLWork.SQL.Add('          Set AGE = :xTargetAge');
      SQLWork.SQL.Add('          where ItemNo = :xTargetItemNo;');
      SQLWork.SQL.Add('  end ');
    end;



    if frmCopySalesHist.cbCopyForecast.Checked then
    begin
      SQLWork.SQL.Add(' ');
      SQLWork.SQL.Add('  For Select');
      Cont:='';
      if frmCopySalesHist.rgFC_ReplaceAdd.ItemIndex = 0 then
      begin
        for SCount := 0 to 51 do
        begin
          SQLWork.SQL.Add('        '+Cont+'ifc.Forecast_'+IntToStr(SCount));
          Cont:=',';
        end;
      end
      else
      begin
        for SCount := frmCopySalesHist.cbFC_StartMth.ItemIndex to frmCopySalesHist.cbFC_ForwardtoMth.ItemIndex do
        begin
          SQLWork.SQL.Add('        '+Cont+'ifc.Forecast_'+IntToStr(SCount));
          Cont:=',';
        end;
      end;
      SQLWork.SQL.Add('       From ItemForecast ifc');
      SQLWork.SQL.Add('            where ifc.ItemNo = :xSourceItemNo and ifc.ForecastTypeNo = 1 and ifc.CalendarNo = :CALENDARNO');
      SQLWork.SQL.Add('        Into');
      Cont:='';
      if frmCopySalesHist.rgFC_ReplaceAdd.ItemIndex = 0 then
      begin
        for SCount := 0 to 51 do
        begin
          SQLWork.SQL.Add('        '+Cont+':FORECAST_'+IntToStr(SCount));
          Cont:=',';
        end;
      end
      else
      begin
        for SCount := frmCopySalesHist.cbFC_StartMth.ItemIndex to frmCopySalesHist.cbFC_ForwardtoMth.ItemIndex do
        begin
          SQLWork.SQL.Add('        '+Cont+':FORECAST_'+IntToStr(SCount));
          Cont:=',';
        end;
      end;
      SQLWork.SQL.Add('  Do Begin');
      SQLWork.SQL.Add('      Update ItemForecast');
      SQLWork.SQL.Add('      Set');
      Cont:='';
      if frmCopySalesHist.rgFC_ReplaceAdd.ItemIndex = 0 then
      begin
        for SCount := 0 to 51 do
        begin
          if frmCopySalesHist.rgFC_Add.ItemIndex = 0 then
          begin
            // Replace History
            SQLWork.SQL.Add('        '+Cont+'FORECAST_'+IntToStr(SCount)+' = :FORECAST_'+IntToStr(SCount));
          end
          else
          begin
            // Add History
            SQLWork.SQL.Add('        '+Cont+'FORECAST_'+IntToStr(SCount)+' = FORECAST_'+IntToStr(SCount)+' + :FORECAST_'+IntToStr(SCount));
          end;
          Cont:=',';
        end;
      end
      else
      begin
        for SCount := frmCopySalesHist.cbFC_StartMth.ItemIndex to frmCopySalesHist.cbFC_ForwardtoMth.ItemIndex do
        begin
          if frmCopySalesHist.rgFC_Add.ItemIndex = 0 then
          begin
            // Replace History
            SQLWork.SQL.Add('        '+Cont+'FORECAST_'+IntToStr(SCount)+' = :FORECAST_'+IntToStr(SCount));
          end
          else
          begin
            // Add History
            SQLWork.SQL.Add('        '+Cont+'FORECAST_'+IntToStr(SCount)+' = FORECAST_'+IntToStr(SCount)+' + :FORECAST_'+IntToStr(SCount));
          end;
          Cont:=',';
        end;
      end;
      SQLWork.SQL.Add('      where Itemno = :xTargetItemNo and ForecastTypeNo = 1 and CalendarNo = :CALENDARNO;');
      SQLWork.SQL.Add('  end ');
    end;






    SQLWork.SQL.Add('end;');

    SQLWork.ExecQuery;
    SQLWork.Close;
    trnOptimiza.Commit;
  except
  end;

end;


end.
