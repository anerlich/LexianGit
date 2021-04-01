create procedure up_getsurplusstock (LOCCODE varchar(10))
returns (PRODUCTCODE varchar(30),
 SUPPLIERCODE varchar(30), DIVISION varchar(15), QTY double precision, EAD date, CANCELIND varchar(6),
 XITEMNO integer)
as
declare variable xStockDate date;
declare variable xLT double precision;
declare variable xSS double precision;
declare variable xRC double precision;
declare variable xRP double precision;
declare variable xTotalDemand double precision;
declare variable xTotalCO double precision;
declare variable xTotalPO double precision;
declare variable xForwardSSLTRC double precision;
declare variable xLocNo Integer;
declare variable xCalNo Integer;
declare variable xStocked Char(1);
declare variable xNetSTock double precision;
declare variable FIRSTPERIODRATIO DOUBLE PRECISION;
declare variable FIRST_PERIOD_RATIO DOUBLE PRECISION;
declare variable Sales_0 double precision;  
declare variable FORECAST_0 double precision;  
declare variable FORECAST_1 double precision;
declare variable FORECAST_2 double precision;
declare variable FORECAST_3 double precision;
declare variable FORECAST_4 double precision;
declare variable FORECAST_5 double precision;
declare variable FORECAST_6 double precision;
declare variable FORECAST_7 double precision;
declare variable FORECAST_8 double precision;
declare variable FORECAST_9 double precision;
declare variable FORECAST_10 double precision;
declare variable FORECAST_11 double precision;
declare variable UseOfCO Char(1);
declare variable USEOFBOM char(1);
declare variable USEOFDRP char(1);
declare variable PRORATEBOM char(1);
declare variable PRORATEDRP char(1);
declare variable xCost double precision;
declare variable xCostPer double precision;
declare variable xSurplus double precision;
declare variable xMaxPolicy double precision;
declare variable xMaxPO double precision;
declare variable xNowOrder double precision;
declare variable xStockPOCover double precision;
declare variable DummyReturn double precision;


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
             p.ProductCode,S.SupplierCode  from Item i
    left join product p on i.productno=p.productno 
    left join itemsales sa on i.itemno=sa.itemno
    join Supplier s on i.SupplierNo1=s.SupplierNo
    where i.Status = "S" and i.LocationNo = :xLocNo
      into :xItemNo,:xNetStock, :xCost,:xCostPer,:xSurplus,:xLT,:xStocked,:xTotalPO,:xSS,:xRC,:xRP,:xForwardSSLTRC,:Sales_0,:ProductCode,:SupplierCode
  do begin
  
      QTY = 0;
      CancelInd = " ";
      
 
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
      
    xCOST = xCOST / xCOSTPER;
  
    /* Convert tasklistvalue back to qty */
    xSurplus = xSurplus / xCost;
      
      if (xStocked = "Y") then
      begin
  
        if ((xSS+xLT+xRC) < 12) then
        begin
              
          if (((:xNetStock + :xTotalPO) - :xTotalDemand) > 0) then
          begin
           
            if (((:xNetStock + :xTotalPO) - :xTotalDemand) < :xTotalPO) then
              QTY = (:xNetStock + :xTotalPO) - :xTotalDemand;
            else
              QTY = :xTotalPO;
              
            CancelInd = "CANCEL";
          end
          else
          begin
            QTY = 0;
            CancelInd = "DELAY";
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
              
            CancelInd = "CANCEL";
          end
          else
          begin
            QTY = 0;
            CancelInd = "DELAY";
          end
          
      end
      
      if (QTY > 0) then /* and CancelInd = "CANCEL") then*/
      begin 
        EAD = :xStockDate;
      end

      if (CancelInd = "DELAY") then
      begin 
        
        if (xStocked = "Y") then
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
  
    
end
