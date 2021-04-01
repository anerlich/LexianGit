ALTER PROCEDURE UP_GETSURPLUSSTOCK(
  LOCCODE VARCHAR(10) CHARACTER SET NONE COLLATE NONE)
RETURNS(
  PRODUCTCODE VARCHAR(30) CHARACTER SET NONE COLLATE NONE,
  SUPPLIERCODE VARCHAR(30) CHARACTER SET NONE COLLATE NONE,
  DIVISION VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
  WAREHOUSE VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
  QTY DOUBLE PRECISION,
  EAD DATE,
  CANCELIND VARCHAR(6) CHARACTER SET NONE COLLATE NONE,
  XITEMNO INTEGER,
  WWDIVISION VARCHAR(15) CHARACTER SET NONE COLLATE NONE)
AS
/* Ver 3.11 - 11/04/2012 CM Add extra field for WWPlan */
DECLARE VARIABLE XSTOCKDATE DATE;
DECLARE VARIABLE XLT DOUBLE PRECISION;
DECLARE VARIABLE XSS DOUBLE PRECISION;
DECLARE VARIABLE XRC DOUBLE PRECISION;
DECLARE VARIABLE XRP DOUBLE PRECISION;
DECLARE VARIABLE XTOTALDEMAND DOUBLE PRECISION;
DECLARE VARIABLE XTOTALCO DOUBLE PRECISION;
DECLARE VARIABLE XTOTALPO DOUBLE PRECISION;
DECLARE VARIABLE XFORWARDSSLTRC DOUBLE PRECISION;
DECLARE VARIABLE XLOCNO INTEGER;
DECLARE VARIABLE XCALNO INTEGER;
DECLARE VARIABLE XSTOCKED CHAR(1);
DECLARE VARIABLE XNETSTOCK DOUBLE PRECISION;
DECLARE VARIABLE FIRSTPERIODRATIO DOUBLE PRECISION;
DECLARE VARIABLE FIRST_PERIOD_RATIO DOUBLE PRECISION;
DECLARE VARIABLE SALES_0 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_0 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_1 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_2 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_3 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_4 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_5 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_6 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_7 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_8 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_9 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_10 DOUBLE PRECISION;
DECLARE VARIABLE FORECAST_11 DOUBLE PRECISION;
DECLARE VARIABLE USEOFCO CHAR(1);
DECLARE VARIABLE USEOFBOM CHAR(1);
DECLARE VARIABLE USEOFDRP CHAR(1);
DECLARE VARIABLE PRORATEBOM CHAR(1);
DECLARE VARIABLE PRORATEDRP CHAR(1);
DECLARE VARIABLE XCOST DOUBLE PRECISION;
DECLARE VARIABLE XCOSTPER DOUBLE PRECISION;
DECLARE VARIABLE XSURPLUS DOUBLE PRECISION;
DECLARE VARIABLE XMAXPOLICY DOUBLE PRECISION;
DECLARE VARIABLE XMAXPO DOUBLE PRECISION;
DECLARE VARIABLE XNOWORDER DOUBLE PRECISION;
DECLARE VARIABLE XSTOCKPOCOVER DOUBLE PRECISION;
DECLARE VARIABLE DUMMYRETURN DOUBLE PRECISION;
begin
Select TypeOfDate from Configuration where  ConfigurationNo = 104
   into :xStockDate;
   
select MONTHFACTOR
  From GETMONTHFACTOR
  into :FIRST_PERIOD_RATIO;
  
  /*do not prorate 1st month forecast */
  FIRSTPERIODRATIO = 1;
 
 select TYPEOFSTRING
    from CONFIGURATION
   where CONFIGURATIONNO = 198
    into :UseOfCO;  
 
  /* use BOM in forward functions? */
  select TYPEOFSTRING
  from CONFIGURATION
  where CONFIGURATIONNO = 203
  into :USEOFBOM;
  
  /* use DRP in forward functions? */
  select TYPEOFSTRING
  from CONFIGURATION
  where CONFIGURATIONNO = 206
  into :USEOFDRP;
  
  /* prorate BOM demand in forward functions? */
  select TYPEOFSTRING
  from CONFIGURATION
  where CONFIGURATIONNO = 205
  into :PRORATEBOM;
  
  /* prorate DRP demand in forward functions? */
  select TYPEOFSTRING
  from CONFIGURATION
  where CONFIGURATIONNO = 207
  into :PRORATEDRP;
  
   Select LocationNo,LocationCode from Location
    where LocationCode = :LocCode
    into :xLocNo,:Division; 
  
  Select TypeOfInteger from Configuration where  ConfigurationNo = 100
   into :xCalNo;
   
  for Select i.ItemNo, (i.StockOnHand - i.BackOrder),
             i.CostPrice, i.CostPer,i.TASKLISTVALUE,i.LeadTime,i.StockingIndicator, i.StockOnOrder,
             i.SafetyStock,i.ReplenishmentCycle,i.ReviewPeriod,i.Forward_LTSSRC,sa.SalesAmount_0,
             p.ProductCode,S.SupplierCode, rc41.ReportCategoryCode  , rc40.ReportCategoryCode WWDiv from Item i		/* Ver 3.11 */
    left join product p on i.productno=p.productno 
    left join itemsales sa on i.itemno=sa.itemno
    join Supplier s on i.SupplierNo1=s.SupplierNo
    left join ITEM_REPORTCATEGORY rrr4 on i.ITEMNO = rrr4.ITEMNO and rrr4.REPORTCATEGORYTYPE = 4
    left join ITEM_REPORTCATEGORY rrr13 on i.ITEMNO = rrr13.ITEMNO and rrr13.REPORTCATEGORYTYPE = 13
    left join ITEM_REPORTCATEGORY r41 on i.ITEMNO = r41.ITEMNO and r41.REPORTCATEGORYTYPE = 41
    left join ReportCategory rc41 on r41.ReportCategoryNo=rc41.ReportCategoryNo and rc41.ReportCategoryType=41    
    left join ITEM_REPORTCATEGORY r40 on i.ITEMNO = r40.ITEMNO and r40.REPORTCATEGORYTYPE = 40						/* Ver 3.11 */
    left join ReportCategory rc40 on r40.ReportCategoryNo=rc40.ReportCategoryNo and rc40.ReportCategoryType=40		/* Ver 3.11 */
    
    where i.Status = "S" and i.LocationNo = :xLocNo
          and rrr4.REPORTCATEGORYNO <> 6   /* Exclude D sku flag */
          and ((rrr13.REPORTCATEGORYNO = 2 and i.STOCKINGINDICATOR = "Y") 
              or (rrr13.REPORTCATEGORYNO <> 2))/* V codes that are stocked   OR non V codes */
      into :xItemNo,:xNetStock, :xCost,:xCostPer,:xSurplus,:xLT,:xStocked,:xTotalPO,:xSS,:xRC,:xRP,:xForwardSSLTRC,:Sales_0,:ProductCode,:SupplierCode,:Warehouse, :WWDivision	/* Ver 3.11 */
  do begin
  
      QTY = 0;
      CancelInd = ' ';
      
 
 execute procedure UP_FWD_DEMAND(:xITEMNO, :xCalNo, :FIRSTPERIODRATIO, :xStocked, 
                                 :UseOfCO, :USEOFBOM, :USEOFDRP, :PRORATEBOM, :PRORATEDRP, :Sales_0)
    returning_values(
    :FORECAST_0, :FORECAST_1, :FORECAST_2, :FORECAST_3, :FORECAST_4, :FORECAST_5,
    :FORECAST_6, :FORECAST_7, :FORECAST_8, :FORECAST_9, :FORECAST_10, :FORECAST_11);   
    
    xTotalDemand = (:FORECAST_0+ :FORECAST_1+ :FORECAST_2+ 
                     :FORECAST_3+ :FORECAST_4+ :FORECAST_5+
                     :FORECAST_6+ :FORECAST_7+ :FORECAST_8+
                     :FORECAST_9+ :FORECAST_10+ :FORECAST_11);        
    if((xCOSTPER = 0.0) or (xCOSTPER is null)) then
      xCOSTPER = 1.0;

    if((xCOST = 0.0) or (xCOST is null)) then
      xCOST = 1.0;
      
    xCOST = xCOST / xCOSTPER;
  
    /* Convert tasklistvalue back to qty */
    xSurplus = xSurplus / xCost;
      
      if (xStocked = 'Y') then
      begin
  
        if ((xSS+xLT+xRC) < 12) then
        begin
              
          if (((:xNetStock + :xTotalPO) - :xTotalDemand) > 0) then
          begin
           
            if (((:xNetStock + :xTotalPO) - :xTotalDemand) < :xTotalPO) then
              QTY = (:xNetStock + :xTotalPO) - :xTotalDemand;
            else
              QTY = :xTotalPO;
              
            CancelInd = 'CANCEL';
          end
          else
          begin
            QTY = 0;
            CancelInd = 'DELAY';
          end
          
        end
        
      end
      else
      begin

          if (((:xNetStock + :xTotalPO) - :xTotalDemand) > 0) then
          begin
           
            if (((:xNetStock + :xTotalPO) - :xTotalDemand) < :xTotalPO) then
              QTY = (:xNetStock + :xTotalPO) - :xTotalDemand;
            else
              QTY = :xTotalPO;
              
            CancelInd = 'CANCEL';
          end
          else
          begin
            QTY = 0;
            CancelInd = 'DELAY';
          end
          
      end
      
      if (QTY > 0) then /* and CancelInd = "CANCEL") then*/
      begin 
        EAD = :xStockDate;
      end

      if (CancelInd = 'DELAY') then
      begin 
        
        if (xStocked = 'Y') then
        begin
          xMaxPolicy = :xLT + :xSS + :xRC;
        end
        else
        begin
          xMaxPolicy = :xLT;
        end
        
        /* get POs over the policy period */
        Select Sum(Quantity) From PurchaseOrder
          where ItemNo = :xItemNo
           and ExpectedArrivalDate <= (:xStockDate + (:xMaxPolicy * 30))
           into :xMaxPO;
           
        /*Make sure we have POs */
        if (xMaxPO > 0) then
        begin
        
          /*Stock and PO's in max cover period must be greater than
             the Max Level */
          if ((xNetStock+xMaxPO) > xForwardSSLTRC) then
          begin
            xNowOrder = :xForwardSSLTRC - :xNetStock;
            
            if (:xNowOrder < 0 ) then xNowOrder = 0;
            
            QTY = :xMaxPO - :xNowOrder;
            
            if (Qty <= 0) then
            begin
              Qty = 0;
            end
            else
            begin
              /*xMaxPO = :xNetStock + :xMaxPO;
              
              execute procedure SuperFwdX(:FIRST_PERIOD_RATIO, :xMaxPO,
                    0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
                   :FORECAST_0, :FORECAST_1, :FORECAST_2, :FORECAST_3, 
                   :FORECAST_4, :FORECAST_5, :FORECAST_6, :FORECAST_7, 
                   :FORECAST_8, :FORECAST_9, :FORECAST_10, :FORECAST_11,
                   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
                   returning_values(:xStockPOCover, :DUMMYRETURN, :DUMMYRETURN, :DUMMYRETURN,
                   :DUMMYRETURN, :DUMMYRETURN, :DUMMYRETURN, :DUMMYRETURN, :DUMMYRETURN, :DUMMYRETURN);
              
               EAD = :xStockDate + ((:xStockPOCover - :xSS) * 30);
                */
                
               EAD = :xStockDate;                 
            end
          
          end
          
        end
           
        
      end

      
      if (QTY > 0) then  
      begin      
        suspend;
      end
          
      
    
  end
  
    
end;