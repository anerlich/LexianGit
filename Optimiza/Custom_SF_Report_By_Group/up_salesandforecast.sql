create procedure up_sf_valuation_detail_frf (ICALCTYPE integer, ICALENDAR integer,
 ILOCATIONNO integer, IGROUPTYPE integer)
returns (ITEMNO integer, PRODUCTNO integer,
 GROUPMAJOR integer, GROUPMINOR1 integer, GROUPMINOR2 integer, SUPPLIERNO1 integer,
 PARETOCATEGORY char(1), CRITICALITY char(1), STOCKINGINDICATOR char(1), GENERIC char(1),
 COTHREEMNTAVE float, HFTHREEMNTAVE float, FCTHREEMNTAVE float, FCCOTHREEMNTAVE float,
 HSTHREEMNTAVE float, STTHREEMNTAVE float, HFSIXMNTAVE float, HSSIXMNTAVE float, STSIXMNTAVE float,
 CATEGORY char(50), OVERDUECUSTOMERORDER float, CUSTOMERORDER_0 float, CUSTOMERORDER_1 float,
 CUSTOMERORDER_2 float, CUSTOMERORDER_3 float, CUSTOMERORDER_4 float, CUSTOMERORDER_5 float,
 FCHISTORY_1 float, FCHISTORY_2 float, FCHISTORY_3 float, FCHISTORY_4 float, FCHISTORY_5 float,
 FCHISTORY_6 float, FORECAST_0 float, FORECAST_1 float, FORECAST_2 float, FORECAST_3 float,
 FORECAST_4 float, FORECAST_5 float, FCCO_0 float, FCCO_1 float, FCCO_2 float, FCCO_3 float,
 FCCO_4 float, FCCO_5 float, SALESAMOUNT_0 float, SALESAMOUNT_1 float, SALESAMOUNT_2 float,
 SALESAMOUNT_3 float, SALESAMOUNT_4 float, SALESAMOUNT_5 float, SALESAMOUNT_6 float,
 SALESAMOUNT_7 float, SALESAMOUNT_8 float, SALESAMOUNT_9 float, SALESAMOUNT_10 float,
 SALESAMOUNT_11 float, SALESAMOUNT_12 float, SALESAMOUNT_13 float, SALESAMOUNT_14 float,
 SALESAMOUNT_15 float, SALESAMOUNT_16 float, SALESAMOUNT_17 float, SALESAMOUNT_18 float,
 LOCATIONNO integer, SUPERCESSIONFLAG integer, COSTPRICE float, COSTPER float, ORDERFAMILYNO integer,
 MAJORGROUPCODE varchar(30), MINORGROUPCODE1 varchar(30), MINORGROUPCODE2 varchar(30))
as
declare variable fFactor Float;
     declare variable fCostPrice Float;
     declare variable fCostPer Float;
     declare variable fRetailPrice Float;
     declare variable fStockingUnitFactor Float;
     declare variable fMass Float;
     declare variable fVolume Float;
     declare variable Age integer;
begin

      ItemNo = 0;
      GroupMajor = 0;
      GroupMinor1 = 0;
      GroupMinor2 = 0;
      MajorGroupCode = '';
      MinorGroupCode1 = '';
      MinorGroupCode2 = '';
      SupplierNo1 = 0;
      ParetoCategory = 'A';
      Criticality = '0';
      StockingIndicator = 'Y';
      Generic = 'N';
      ProductNo = 0;
      CostPrice = 0;
      CostPer = 0;
      fRetailPrice = 0;
      fStockingUnitFactor = 0;
      fMass = 0;
      fVolume = 0;
      OVERDUECUSTOMERORDER = 0;
      CUSTOMERORDER_0 = 0;
      CUSTOMERORDER_1 = 0;
      CUSTOMERORDER_2 = 0;
      CUSTOMERORDER_3 = 0;
      CUSTOMERORDER_4 = 0;
      CUSTOMERORDER_5 = 0;
      FCHISTORY_1 = 0;
      FCHISTORY_2 = 0;
      FCHISTORY_3 = 0;
      FCHISTORY_4 = 0;
      FCHISTORY_5 = 0;
      FCHISTORY_6 = 0;
      FORECAST_0 = 0;
      FORECAST_1 = 0;
      FORECAST_2 = 0;
      FORECAST_3 = 0;
      FORECAST_4 = 0;
      FORECAST_5 = 0;
      SALESAMOUNT_0 = 0;
      SALESAMOUNT_1 = 0;
      SALESAMOUNT_2 = 0;
      SALESAMOUNT_3 = 0;
      SALESAMOUNT_4 = 0;
      SALESAMOUNT_5 = 0;
      SALESAMOUNT_6 = 0;
      SALESAMOUNT_7 = 0;
      SALESAMOUNT_8 = 0;
      SALESAMOUNT_9 = 0;
      SALESAMOUNT_10 = 0;
      SALESAMOUNT_11 = 0;
      SALESAMOUNT_12 = 0;
      SALESAMOUNT_13 = 0;
      SALESAMOUNT_14 = 0;
      SALESAMOUNT_15 = 0;
      SALESAMOUNT_16 = 0;
      SALESAMOUNT_17 = 0;
      SALESAMOUNT_18 = 0;
      LocationNo = :iLocationNo;
      SupercessionFlag=0;
      Age = 0;
      OrderFamilyNo = 0;


      fFactor = 1.0;

    FCCO_0 = 0;
    FCCO_1 = 0;
    FCCO_2 = 0;
    FCCO_3 = 0;
    FCCO_4 = 0;
    FCCO_5 = 0;
    

    COTHREEMNTAVE = (((:CUSTOMERORDER_0 + :CUSTOMERORDER_1 + :CUSTOMERORDER_2) ) / 3);

    HFSIXMNTAVE   = (((:FCHISTORY_1 + :FCHISTORY_2 + :FCHISTORY_3 + :FCHISTORY_4 + :FCHISTORY_5 + :FCHISTORY_6)) / 6);
    HFTHREEMNTAVE = (((:FCHISTORY_1 + :FCHISTORY_2 + :FCHISTORY_3)) / 3);

    FCTHREEMNTAVE = (((:FORECAST_0 + :FORECAST_1 + :FORECAST_2)) / 3);
    FCCOTHREEMNTAVE = (((:FCCO_0 + :FCCO_1 + :FCCO_2)) / 3);

    STSIXMNTAVE   = (((:SALESAMOUNT_1 + :SALESAMOUNT_2 + :SALESAMOUNT_3 + :SALESAMOUNT_4 + :SALESAMOUNT_5 + :SALESAMOUNT_6)) / 6);
    STTHREEMNTAVE = (((:SALESAMOUNT_1 + :SALESAMOUNT_2 + :SALESAMOUNT_3)) / 3);

    HSSIXMNTAVE   = (((:SALESAMOUNT_13 + :SALESAMOUNT_14 + :SALESAMOUNT_15 + :SALESAMOUNT_16 + :SALESAMOUNT_17 + :SALESAMOUNT_18)) / 6);
    HSTHREEMNTAVE = (((:SALESAMOUNT_13 + :SALESAMOUNT_14 + :SALESAMOUNT_15)) / 3);

    /* return each category for all groups*/
    if (IGroupType = 1) then
    begin
      for select GroupNo,GroupCode from GroupMajor
      into :GroupMajor, :MajorGroupCode
      do begin
        ParetoCategory = 'F';
        StockingIndicator = 'N';
        Category = 'Non-stocked Items';
        suspend;
  
        ParetoCategory = 'A';
        StockingIndicator = 'Y';
        Category = 'A Items';
        suspend;
  
        ParetoCategory = 'B';
        StockingIndicator = 'Y';
        Category = 'B-F Items';
        suspend;
  
        ParetoCategory = 'M';
        StockingIndicator = 'Y';
        Category = 'Multi-bin Items';
        suspend;
      
      
      end
    end
    
    if (IGroupType = 2) then
    begin
      for select GroupNo,GroupCode from GroupMinor1
      into :GroupMinor1, :MinorGroupCode1
      do begin
        ParetoCategory = 'F';
        StockingIndicator = 'N';
        Category = 'Non-stocked Items';
        suspend;
  
        ParetoCategory = 'A';
        StockingIndicator = 'Y';
        Category = 'A Items';
        suspend;
  
        ParetoCategory = 'B';
        StockingIndicator = 'Y';
        Category = 'B-F Items';
        suspend;
  
        ParetoCategory = 'M';
        StockingIndicator = 'Y';
        Category = 'Multi-bin Items';
        suspend;
      
      
      end
    end

    if (IGroupType = 3) then
    begin
      for select GroupNo,GroupCode from GroupMinor2
      into :GroupMinor2, :MinorGroupCode2
      do begin
        ParetoCategory = 'F';
        StockingIndicator = 'N';
        Category = 'Non-stocked Items';
        suspend;
  
        ParetoCategory = 'A';
        StockingIndicator = 'Y';
        Category = 'A Items';
        suspend;
  
        ParetoCategory = 'B';
        StockingIndicator = 'Y';
        Category = 'B-F Items';
        suspend;
  
        ParetoCategory = 'M';
        StockingIndicator = 'Y';
        Category = 'Multi-bin Items';
        suspend;
      
      
      end
    end

for
    select
      i.ItemNo,
      i.GroupMajor,
      i.GroupMinor1,
      i.GroupMinor2,
      i.SupplierNo1,
      i.ParetoCategory,
      i.Criticality,
      i.StockingIndicator,
      i.Generic,
      i.ProductNo,
      i.COSTPRICE,
      i.COSTPER,
      i.RETAILPRICE,
      i.StockingUnitFactor,
      p.Mass,
      p.Volume,
      c.OVERDUECUSTOMERORDER,
      c.CUSTOMERORDER_0,
      c.CUSTOMERORDER_1,
      c.CUSTOMERORDER_2,
      c.CUSTOMERORDER_3,
      c.CUSTOMERORDER_4,
      c.CUSTOMERORDER_5,
      f.FCHISTORY_1,
      f.FCHISTORY_2,
      f.FCHISTORY_3,
      f.FCHISTORY_4,
      f.FCHISTORY_5,
      f.FCHISTORY_6,
      f.FORECAST_0,
      f.FORECAST_1,
      f.FORECAST_2,
      f.FORECAST_3,
      f.FORECAST_4,
      f.FORECAST_5,
      a.SALESAMOUNT_0,
      a.SALESAMOUNT_1,
      a.SALESAMOUNT_2,
      a.SALESAMOUNT_3,
      a.SALESAMOUNT_4,
      a.SALESAMOUNT_5,
      a.SALESAMOUNT_6,
      a.SALESAMOUNT_7,
      a.SALESAMOUNT_8,
      a.SALESAMOUNT_9,
      a.SALESAMOUNT_10,
      a.SALESAMOUNT_11,
      a.SALESAMOUNT_12,
      a.SALESAMOUNT_13,
      a.SALESAMOUNT_14,
      a.SALESAMOUNT_15,
      a.SALESAMOUNT_16,
      a.SALESAMOUNT_17,
      a.SALESAMOUNT_18,
      i.LocationNo,
      i.SupercessionFlag,
      i.Age,
      i.OrderFAmilyNo,
      gm.GroupCode,
      gm1.GroupCode,
      gm2.GroupCode
    from ITEM i left outer join ITEMORDER c    on i.ITEMNO = c.ITEMNO
                left outer join ITEMFORECAST f on i.ITEMNO = f.ITEMNO and f.CALENDARNO = :ICalendar and f.FORECASTTYPENO = 1
                left outer join ITEMSALES a    on i.ITEMNO = a.ITEMNO
                left outer join PRODUCT p      on i.PRODUCTNO = p.PRODUCTNO
                left join GroupMajor gm        on i.GROUPMAJOR=gm.groupNo
                left join GroupMinor1 gm1      on i.GROUPMINOR1=gm1.groupNo
                left join GroupMinor2 gm2      on i.GROUPMINOR2=gm2.groupNo
    where i.LOCATIONNO = :ILOCATIONNO
    ORDER BY ITEMNO
    into
      :ItemNo,
      :GroupMajor,
      :GroupMinor1,
      :GroupMinor2,
      :SupplierNo1,
      :ParetoCategory,
      :Criticality,
      :StockingIndicator,
      :Generic,
      :ProductNo,
      :CostPrice,
      :CostPer,
      :fRetailPrice,
      :fStockingUnitFactor,
      :fMass,
      :fVolume,
      :OVERDUECUSTOMERORDER,
      :CUSTOMERORDER_0,
      :CUSTOMERORDER_1,
      :CUSTOMERORDER_2,
      :CUSTOMERORDER_3,
      :CUSTOMERORDER_4,
      :CUSTOMERORDER_5,
      :FCHISTORY_1,
      :FCHISTORY_2,
      :FCHISTORY_3,
      :FCHISTORY_4,
      :FCHISTORY_5,
      :FCHISTORY_6,
      :FORECAST_0,
      :FORECAST_1,
      :FORECAST_2,
      :FORECAST_3,
      :FORECAST_4,
      :FORECAST_5,
      :SALESAMOUNT_0,
      :SALESAMOUNT_1,
      :SALESAMOUNT_2,
      :SALESAMOUNT_3,
      :SALESAMOUNT_4,
      :SALESAMOUNT_5,
      :SALESAMOUNT_6,
      :SALESAMOUNT_7,
      :SALESAMOUNT_8,
      :SALESAMOUNT_9,
      :SALESAMOUNT_10,
      :SALESAMOUNT_11,
      :SALESAMOUNT_12,
      :SALESAMOUNT_13,
      :SALESAMOUNT_14,
      :SALESAMOUNT_15,
      :SALESAMOUNT_16,
      :SALESAMOUNT_17,
      :SALESAMOUNT_18,
      :LocationNo,
      :SupercessionFlag,
      :Age,
      :OrderFamilyNo,
      :MajorGroupCode,
      :MinorGroupCode1,
      :MinorGroupCode2
  do begin
    /* calculate the factor based on the input paramater */
    if          (:ICalcType = 1) then begin
      fFactor = 1.0;
    end else if (:ICalcType = 2) then begin
      fFactor =  :CostPrice / :CostPer;
    end else if (:ICalcType = 3) then begin
      fFactor = :fRetailPrice;
    end else if (:ICalcType = 4) then begin
      fFactor = :fRetailPrice - (:CostPrice / :CostPer);
    end else if (:ICalcType = 5) then begin
      fFactor = :fMass;
    end else if (:ICalcType = 6) then begin
      fFactor = :fVolume;
    end else begin /* (:ICalcType = 7) */
      fFactor = :fStockingUnitFactor;
    end

    /* Place the record into a categorry */
    if (:STOCKINGINDICATOR = 'N') then begin
      Category = 'Non-stocked Items';
    end else if (ParetoCategory = 'A') then begin
      Category = 'A Items';
    end else if ((ParetoCategory >= 'B')  and (ParetoCategory <= 'F')) then begin
      Category = 'B-F Items';
    end else if (ParetoCategory = 'M') then begin
      Category = 'Multi-bin Items';
    end else begin
      Category = 'Other';
    end
    
    if (MinorGroupCode1 is null) then
      MinorGroupCode1 = 'Unknown';
    

    OVERDUECUSTOMERORDER = :OVERDUECUSTOMERORDER * :fFactor;

    CUSTOMERORDER_0 = :CUSTOMERORDER_0 * :fFactor;
    CUSTOMERORDER_1 = :CUSTOMERORDER_1 * :fFactor;
    CUSTOMERORDER_2 = :CUSTOMERORDER_2 * :fFactor;
    CUSTOMERORDER_3 = :CUSTOMERORDER_3 * :fFactor;
    CUSTOMERORDER_4 = :CUSTOMERORDER_4 * :fFactor;
    CUSTOMERORDER_5 = :CUSTOMERORDER_5 * :fFactor;

    FCHISTORY_1 = :FCHISTORY_1 * :fFactor;
    FCHISTORY_2 = :FCHISTORY_2 * :fFactor;
    FCHISTORY_3 = :FCHISTORY_3 * :fFactor;
    FCHISTORY_4 = :FCHISTORY_4 * :fFactor;
    FCHISTORY_5 = :FCHISTORY_5 * :fFactor;
    FCHISTORY_6 = :FCHISTORY_6 * :fFactor;

    FORECAST_0 = :FORECAST_0 * :fFactor;
    FORECAST_1 = :FORECAST_1 * :fFactor;
    FORECAST_2 = :FORECAST_2 * :fFactor;
    FORECAST_3 = :FORECAST_3 * :fFactor;
    FORECAST_4 = :FORECAST_4 * :fFactor;
    FORECAST_5 = :FORECAST_5 * :fFactor;
    
    FCCO_0 = :FORECAST_0;
    FCCO_1 = :FORECAST_1;
    FCCO_2 = :FORECAST_2;
    FCCO_3 = :FORECAST_3;
    FCCO_4 = :FORECAST_4;
    FCCO_5 = :FORECAST_5;
    
    /* use max of FC and CO */
    if (CUSTOMERORDER_0 > FORECAST_0) then
      FCCO_0 = :CUSTOMERORDER_0;
    if (CUSTOMERORDER_1 > FORECAST_1) then
      FCCO_1 = :CUSTOMERORDER_1;
    if (CUSTOMERORDER_2 > FORECAST_2) then
      FCCO_2 = :CUSTOMERORDER_2;
    if (CUSTOMERORDER_3 > FORECAST_3) then
      FCCO_3 = :CUSTOMERORDER_3;
    if (CUSTOMERORDER_4 > FORECAST_4) then
      FCCO_4 = :CUSTOMERORDER_4;
    if (CUSTOMERORDER_5 > FORECAST_5) then
      FCCO_5 = :CUSTOMERORDER_5;

    if (Age < 1) then
      SALESAMOUNT_1 = 0;

    if (Age < 2) then
      SALESAMOUNT_2 = 0;

    if (Age < 3) then
      SALESAMOUNT_3 = 0;

    if (Age < 4) then
      SALESAMOUNT_4 = 0;

    if (Age < 5) then
      SALESAMOUNT_5 = 0;

    if (Age < 6) then
      SALESAMOUNT_6 = 0;

    if (Age < 7) then
      SALESAMOUNT_7 = 0;

    if (Age < 8) then
      SALESAMOUNT_8 = 0;

    if (Age < 9) then
      SALESAMOUNT_9 = 0;

    if (Age < 10) then
      SALESAMOUNT_10 = 0;

    if (Age < 11) then
      SALESAMOUNT_11 = 0;

    if (Age < 12) then
      SALESAMOUNT_12 = 0;

    if (Age < 13) then
      SALESAMOUNT_13 = 0;

    if (Age < 14) then
      SALESAMOUNT_14 = 0;

    if (Age < 15) then
      SALESAMOUNT_15 = 0;

    if (Age < 16) then
      SALESAMOUNT_16 = 0;

    if (Age < 17) then
      SALESAMOUNT_17 = 0;

    if (Age < 18) then
      SALESAMOUNT_18 = 0;

    SALESAMOUNT_0  = :SALESAMOUNT_0  * :fFactor;
    SALESAMOUNT_1  = :SALESAMOUNT_1  * :fFactor;
    SALESAMOUNT_2  = :SALESAMOUNT_2  * :fFactor;
    SALESAMOUNT_3  = :SALESAMOUNT_3  * :fFactor;
    SALESAMOUNT_4  = :SALESAMOUNT_4  * :fFactor;
    SALESAMOUNT_5  = :SALESAMOUNT_5  * :fFactor;
    SALESAMOUNT_6  = :SALESAMOUNT_6  * :fFactor;
    SALESAMOUNT_7  = :SALESAMOUNT_7  * :fFactor;
    SALESAMOUNT_8  = :SALESAMOUNT_8  * :fFactor;
    SALESAMOUNT_9  = :SALESAMOUNT_9  * :fFactor;
    SALESAMOUNT_10 = :SALESAMOUNT_10 * :fFactor;
    SALESAMOUNT_11 = :SALESAMOUNT_11 * :fFactor;
    SALESAMOUNT_12 = :SALESAMOUNT_12 * :fFactor;
    SALESAMOUNT_13 = :SALESAMOUNT_13 * :fFactor;

    SALESAMOUNT_14 = :SALESAMOUNT_14 * :fFactor;
    SALESAMOUNT_15 = :SALESAMOUNT_15 * :fFactor;
    SALESAMOUNT_16 = :SALESAMOUNT_16 * :fFactor;
    SALESAMOUNT_17 = :SALESAMOUNT_17 * :fFactor;
    SALESAMOUNT_18 = :SALESAMOUNT_18 * :fFactor;

    COTHREEMNTAVE = (((:CUSTOMERORDER_0 + :CUSTOMERORDER_1 + :CUSTOMERORDER_2) ) / 3);

    HFSIXMNTAVE   = (((:FCHISTORY_1 + :FCHISTORY_2 + :FCHISTORY_3 + :FCHISTORY_4 + :FCHISTORY_5 + :FCHISTORY_6)) / 6);
    HFTHREEMNTAVE = (((:FCHISTORY_1 + :FCHISTORY_2 + :FCHISTORY_3)) / 3);

    FCTHREEMNTAVE = (((:FORECAST_0 + :FORECAST_1 + :FORECAST_2)) / 3);
    FCCOTHREEMNTAVE = (((:FCCO_0 + :FCCO_1 + :FCCO_2)) / 3);

    STSIXMNTAVE   = (((:SALESAMOUNT_1 + :SALESAMOUNT_2 + :SALESAMOUNT_3 + :SALESAMOUNT_4 + :SALESAMOUNT_5 + :SALESAMOUNT_6)) / 6);
    STTHREEMNTAVE = (((:SALESAMOUNT_1 + :SALESAMOUNT_2 + :SALESAMOUNT_3)) / 3);

    HSSIXMNTAVE   = (((:SALESAMOUNT_13 + :SALESAMOUNT_14 + :SALESAMOUNT_15 + :SALESAMOUNT_16 + :SALESAMOUNT_17 + :SALESAMOUNT_18)) / 6);
    HSTHREEMNTAVE = (((:SALESAMOUNT_13 + :SALESAMOUNT_14 + :SALESAMOUNT_15)) / 3);

    suspend;
  end
end
