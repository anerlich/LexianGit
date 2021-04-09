unit uDmSaleAndFC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery;

type
  TdmCopySaleAndFC = class(TdmOptimiza)
    qryFromLoc: TIBQuery;
    qryToLoc: TIBQuery;
    srcFromLoc: TDataSource;
    srcToLoc: TDataSource;
    qryFromItem: TIBQuery;
    srcFromItem: TDataSource;
    qryToItem: TIBQuery;
    srcToItem: TDataSource;
    qryInsertItem: TIBQuery;
    qrysetSeqNo: TIBQuery;
    srcsetSeqNo: TDataSource;
    qryFromSales: TIBQuery;
    srcFromSales: TDataSource;
    qryUpdateSales: TIBQuery;
    qryFromFC: TIBQuery;
    srcFromFC: TDataSource;
    qryFromFrozen: TIBQuery;
    srcFromFrozen: TDataSource;
    qryUpdateFC: TIBQuery;
    qryUpdateFrozen: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryFromItemAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    procedure ScrollToItem;
    procedure BuildField(FieldName: String; FieldType: Char);
    procedure UpdateFCandSales(ItemCode, CurPeriod:String);
    procedure OpenFrozen(CurPeriod: String);
  public
    { Public declarations }
    function SameLocations: Boolean;
    procedure UpdateItems;
    procedure OpenItems;
    procedure InsertTheItem(SeqNo:Integer;LocNo:Integer);
  end;

var
  dmCopySaleAndFC: TdmCopySaleAndFC;
  AllFields, AllValues: TStringList;

implementation

uses uStatus;

{$R *.DFM}

procedure TdmCopySaleAndFC.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryFromLoc.Open;
  qryToLoc.Open;
  AllFields := TStringList.Create ;
  AllValues := TStringList.Create ;
end;

function TdmCopySaleAndFC.SameLocations:Boolean;
begin

  if srcFromLoc.DataSet.FieldByName('LocationNo').AsInteger =
     srcToLoc.DataSet.FieldByName('LocationNo').AsInteger then
     Result := True
  else
    Result := False;

end;

procedure TdmCopySaleAndFC.OpenItems;
begin
  qryFromItem.Open;
  qryFromSales.Open;
end;

procedure TdmCopySaleAndFC.ScrollToItem;
begin

  With qryToItem do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select ItemNo From Item ');
    SQL.Add(' where LocationNo = '+srcToLoc.DataSet.FieldByName('LocationNo').AsString);
    SQL.Add(' and ProductNo = '+srcFromItem.DataSet.FieldByName('ProductNo').AsString);
    Prepare;
    Open;
  end;


end;

procedure TdmCopySaleAndFC.qryFromItemAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ScrollToItem;
end;

procedure TdmCopySaleAndFC.UpdateItems;
var
  CurrentPeriod, RecCount, SeqNo, LocNo: Integer;
  ItemCode, CurPeriod: String;
begin
  OpenItems;
  CurPeriod := IntToStr(GetCurrentPeriod);

 qrysetSeqNo.SQL.Clear;

  qrysetSeqNo.SQL.Add('Select ItemNo from Item order by ItemNo descending');
  qrysetSeqNo.Active := True;
  SeqNo := srcsetSeqNo.DataSet.FieldByName('ItemNo').AsInteger;

  qrysetSeqNo.Close;

  LocNo := srcToLoc.DataSet.FieldByName('LocationNo').AsInteger;


  srcFromItem.DataSet.First;
  RecCount := 0;
  frmStatus.ListBox1.items.Add('Processing');
  frmStatus.Show;
  frmStatus.Refresh;

  While not srcFromItem.DataSet.Eof do
  begin
    inc(RecCount);

    if RecCount mod 50 = 0 then
    begin
      frmStatus.StatusBar1.Panels[1].Text := IntToStr(RecCount);
      frmStatus.StatusBar1.Refresh;
    end;


    ItemCode := srcToItem.DataSet.FieldbyName('ItemNo').AsString;
      InsertTheItem(SeqNo, LocNo);     //Insert new item using all from locs data

    if length(ItemCode) = 0 then
    begin
      InsertTheItem(SeqNo, LocNo);     //Insert new item using all from locs data
      ScrollToItem;             //now position record pointer
      ItemCode := srcToItem.DataSet.FieldbyName('ItemNo').AsString;

      if length(ItemCode) > 0 then
        UpdateFCandSales(ItemCode, CurPeriod);

    end
    else
    begin

      UpdateFCandSales(ItemCode, CurPeriod);

    end;


    srcFromItem.DataSet.Next;
  end;

  qrysetSeqNo.SQL.Clear;
  qrysetSeqNo.SQL.Add('SET GENERATOR ITEM_SEQNO TO ' +
                     IntToStr(SeqNo));
  qrysetSeqNo.Active := True;

  qrysetSeqNo.Close;
  trnOptimiza.Commit;

  MessageDlg('Complete',mtConfirmation,[mbOK],0);

end;

procedure TdmCopySaleAndFC.InsertTheItem(SeqNo:Integer;LocNo:Integer);
begin

  //try

   AllFields.Clear;
   AllValues.Clear;
   AllFields.Add('(');
   AllValues.Add('(');
   AllFields.Add('ItemNo');
   Inc(SeqNo);
   AllValues.Add(IntToStr(SeqNo));
   AllFields.Add(',LOCATIONNO');
   AllValues.Add(','+IntToStr(LocNo));

   BuildField('PRODUCTNO             ','D');
   BuildField('INVENTORYMANAGER       ','D');
   BuildField('PARETOCATEGORY         ','C');
   BuildField('STOCKINGINDICATOR      ','C');
   BuildField('STATUS                 ','C');
   BuildField('AGE                  ','D');
   BuildField('STOCKONHAND            ','D');
   BuildField('STOCKONORDER           ','D');
   BuildField('BACKORDER              ','D');
   BuildField('SAFETYSTOCK            ','D');
   BuildField('LEADTIME               ','D');
   BuildField('REPLENISHMENTCYCLE     ','D');
   BuildField('REVIEWPERIOD           ','D');
   BuildField('MINIMUMORDERQUANTITY   ','D');
   BuildField('ORDERMULTIPLES         ','D');
   BuildField('BINLEVEL               ','D');
   BuildField('AUTOBINITEM            ','C');
   BuildField('COSTPRICE              ','D');
   BuildField('COSTPER                ','D');
   BuildField('RETAILPRICE            ','D');
   BuildField('MANUALFORECAST         ','C');
   BuildField('MANUALPOLICY           ','C');
   BuildField('EXCLUDE                ','C');
   BuildField('CRITICALITY            ','D');
   BuildField('SUPPLIERNO1            ','D');
   BuildField('SUPPLIERNO2            ','D');
   BuildField('SUPPLIERNO3            ','D');
   BuildField('SUPPLIERNO4            ','D');
   BuildField('SUPPLIERNO5            ','D');
   BuildField('LEADTIMECATEGORY       ','C');
   BuildField('LEADTIMEVARIANCE       ','D');
   BuildField('FORECASTVARIANCE       ','D');
   BuildField('FORECASTACCURACY       ','D');
   BuildField('DATEOFLASTSTOCKTAKE    ','D');
   BuildField('SERVICELEVEL           ','D');
   BuildField('AVAILABILITY           ','D');
   BuildField('EARLYORDERARRIVALDATE  ','D');
   BuildField('PERIODSONHAND          ','D');
   BuildField('PERIODSONORDER         ','D');
   BuildField('RECOMMENDEDORDER       ','D');
   BuildField('PARETOVALUE            ','D');
   BuildField('TASKLISTVALUE          ','D');
   BuildField('FORWARDTASKLISTVALUE   ','D');
   BuildField('FORWARDLEADTIME        ','D');
   BuildField('FORWARD_LTSSRC         ','D');
   BuildField('FORWARD_LTSSRP         ','D');
   BuildField('FORWARD_SS             ','D');
   BuildField('FORWARD_SSRC           ','D');
   BuildField('FORWARD_SSHALFRC       ','D');
   BuildField('FORWARD_SSRP           ','D');
   BuildField('FORWARD_N              ','D');
   BuildField('FORWARDX_N             ','D');
   BuildField('FORWARDX_SONHBACKO     ','D');
   BuildField('BARCODE                ','C');
   BuildField('STOCKINGUNITFACTOR     ','D');
   BuildField('UNITSSOLDTOTAL         ','D');
   BuildField('MIN_SS_UNITS           ','D');
   BuildField('FORWARDX_SONHBACKOSONO ','D');
   BuildField('FC_FITCOEFFICIENT      ','D');
   BuildField('FC_TRENDCOEFFICIENT    ','D');
   BuildField('FC_SEASONALCOEFFICIENT ','D');
   BuildField('FC_MADCOEFFICIENT      ','D');
   BuildField('FC_UNRELIABLECOEFFICIENT','D');
   BuildField('FC_RMSE                 ','D');
   BuildField('FC_MAD                  ','D');
   BuildField('FC_MAPE                 ','D');
   BuildField('FC_MEANERROR            ','D');
   BuildField('FORECASTMETHOD          ','D');
   BuildField('STOCKOUTCOUNT           ','D');
   BuildField('PREVIOUSSTOCKOUTCOUNT   ','D');
   BuildField('FC_ERRORVALUE           ','D');
   BuildField('FC_TOURNAMENT           ','C');
   BuildField('EFFECTIVERC             ','D');
   BuildField('FORWARD_SSLT            ','D');
   BuildField('STOCKONORDERINLT        ','D');
   BuildField('CENTRALWAREHOUSENO      ','D');
   BuildField('MODELVALUE              ','D');
   BuildField('NEWITEM                 ','C');
   BuildField('FORWARD_SSHALFRC_PLAIN   ','D');
   BuildField('FAIRSHARE                ','D');
   BuildField('IMPORTED                 ','C');
   BuildField('OVERUNDERFORECAST        ','C');
   BuildField('ROUNDPERIODSONHAND       ','D');
   BuildField('ECONOMICORDERQUANTITY    ','D');
   BuildField('STATSCATEGORYNO          ','D');
   BuildField('GENERIC                  ','C');
   BuildField('EXCESSVALUE               ','D');
   BuildField('SHORTFALLVALUE            ','D');
   BuildField('USERDOUBLE1               ','D');
   BuildField('USERDOUBLE2               ','D');
   BuildField('USERDOUBLE3               ','D');
   BuildField('USERDOUBLE4               ','D');
   BuildField('USERDOUBLE5               ','D');
   BuildField('USERCHAR1                 ','C');
   BuildField('USERCHAR2                 ','C');
   BuildField('USERCHAR3                 ','C');
   BuildField('USERCHAR4                 ','C');
   BuildField('USERCHAR5                 ','C');
   BuildField('USERDATE1                 ','D');
   BuildField('USERDATE2                 ','D');
   BuildField('USERDATE3                 ','D');
   BuildField('USERDATE4                 ','D');
   BuildField('USERDATE5                 ','D');
   BuildField('USERINTEGER1              ','D');
   BuildField('USERINTEGER2              ','D');
   BuildField('USERINTEGER3              ','D');
   BuildField('USERINTEGER4              ','D');
   BuildField('USERINTEGER5              ','D');
   BuildField('CONSOLIDATEDBRANCHORDERS  ','D');
   BuildField('LOSTSALES                 ','D');
   BuildField('GROUPMAJOR                ','D');
   BuildField('GROUPMINOR1               ','D');
   BuildField('GROUPMINOR2               ','D');
   BuildField('FORWARDX_SONHBACKOSONOINLT','D');
   BuildField('SAFETYSTOCKCALCIND         ','C');
   BuildField('TEMPAUTOBINLEVEL           ','C');
   BuildField('AUTOBINLEVEL               ','C');
   BuildField('ROUNDUPFROM                ','D');

   AllFields.Add(') ');
   AllValues.Add(') ');

    with qryInsertItem do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Insert into Item ');
      qryInsertItem.SQL.AddStrings(AllFields);
      qryInsertItem.SQL.Add(' Values ');
      qryInsertItem.SQL.AddStrings(AllValues);
      //Prepare;
      //ExecSQL;

    end;


//  except
    frmStatus.ListBox1.Items.AddStrings(qryInsertItem.SQL);
    frmStatus.ListBox1.Items.SaveToFile('d:\temp\fchist.txt');
    frmStatus.ShowModal;
 // end;

end;

procedure TdmCopySaleAndFC.BuildField(FieldName:String; FieldType: Char);
var
  FieldValue,ValueSep: String;
begin
  FieldValue := srcFromItem.Dataset.FieldByName(Trim(FieldName)).AsString;

  if Length(FieldValue) > 0 then
  begin
    FieldName := Trim(FieldName);

    if FieldType = 'C' then
      ValueSep := '"'
    else
      ValueSep := '';

    if AllFields.Count > 1 then
      FieldName := ', ' + FieldName ;

    AllFields.Add(FieldName);

    FieldValue := ValueSep + Trim(FieldValue) + ValueSep;

    if AllValues.Count > 1 then
      FieldValue := ', ' + FieldValue;

    AllValues.Add(FieldValue);

  end;

end;

procedure TdmCopySaleAndFC.UpdateFCandSales(ItemCode, CurPeriod:String);
var
  FldCount: Integer;
  FValue, FName, FSep, SQLFrozen, SQLFC:STring;
begin


 try

  with qryUpdateSales do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Update ItemSales Set ');

    For FldCount := 0 to 120 do
    begin

      if FldCount > 0 then
        FSep := ', '
      else
        FSep := '';

      FName := 'SALESAMOUNT_' + IntToStr(FldCount);
      SQL.Add(FSep + FName + '=' +FName + '+' + srcFromSales.DataSet.FieldByName(FNAME).AsString);

    end;

    SQL.Add(' where ItemNo = '+ItemCode);

    Prepare;
    ExecSql;
  end;



 except
    frmStatus.ListBox1.Items.AddStrings(qryUpdateSales.SQL);
    frmStatus.ShowModal;

 end;

 OpenFrozen(CurPeriod);
 SQLFrozen := '';
 SQLFC := '';

 For FldCount := 0 to 25 do
 begin
   FName := 'FORECAST_'+IntToStr(FldCount);

   if srcFromFrozen.Dataset.FieldByName(FNAME).AsString = 'Y' then
   Begin

     if SQLFrozen <> '' then
     begin
       SQLFrozen := SQLFrozen + ', ';
       SQLFC := SQLFC + ', ';
     end;

     SQLFrozen := SQLFrozen + FName + '="Y"';
     FValue := srcFromFC.Dataset.FieldByName(FName).asString;
     SQLFC := SQLFC + Fname + '='+FName+'+'+FValue;
   end;
 end;

   if length(SQLFrozen) > 0 then
   begin

     with qryUpdateFrozen do
     begin
       Close;
       SQL.Clear;
       SQL.add('Update ItemFrozenForecast Set ');
       SQL.Add(SQLFrozen);
       SQL.Add(' where ItemNo = '+ItemCode);
       SQL.Add(' and CalendarNo = '+CurPeriod);
       Prepare;
       ExecSQL;
     end;

     with qryUpdateFC do
     begin
       Close;
       SQL.Clear;
       SQL.add('Update ItemForecast Set ');
       SQL.Add(SQLFC);
       SQL.Add(' where ItemNo = '+ItemCode);
       SQL.Add(' and CalendarNo = '+CurPeriod);
       SQL.Add(' and ForecastTypeNo = 1');
       Prepare;
       ExecSQL;
     end;

 
 end;


end;

procedure TdmCopySaleAndFC.OpenFrozen(CurPeriod: String);
var
  ItemStr: String;
begin

  ItemStr := srcFromItem.DataSet.FieldbyName('ItemNo').AsString;

  with qryFromFrozen do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from ITEMFROZENFORECAST ');
    SQL.Add(' where ItemNo = '+Itemstr);
    SQL.Add(' and CalendarNo = '+CurPeriod);
    Prepare;
    Open;

  end;

  with qryFromFC do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * from ITEMFORECAST ');
    SQL.Add(' where ItemNo = '+ItemStr);
    SQL.Add(' and CalendarNo = '+CurPeriod);
    SQL.Add(' and ForecastTypeNo = 1');
    Prepare;
    Open;

  end;


end;

end.
