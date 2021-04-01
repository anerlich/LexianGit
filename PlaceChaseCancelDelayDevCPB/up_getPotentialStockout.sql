create procedure up_getpotentialstockout (LOCCODE varchar(10))
returns (PRODUCTCODE varchar(30),
 SUPPLIERCODE varchar(30), DIVISION varchar(15), QTY double precision, ORDERDATE date,
 EAD date)
as
declare variable xEndDate date;
declare variable xItemNo Integer;
declare variable xLT double precision;
declare variable xLocNo Integer;
declare variable xOnOrder double precision;
declare variable xOnOrderInLT double precision;
declare variable xPotentialStockout double precision;
declare variable xCost double precision;
declare variable xCostPer double precision;
declare variable xSecondStatus Char(1);
declare Variable xLTCover double precision;
declare Variable xLTDays double precision;
declare Variable xSS double precision;


begin
  Select LocationNo,LocationCode from Location
    where LocationCode = :LocCode
    into :xLocNo,:Division; 
  
  Select TypeOfDate from Configuration where  ConfigurationNo = 104
   into :xEndDate;
  
  /*Only products that are Potential Stockouts*/ 
  for Select i.ItemNo,i.CostPrice, i.CostPer,i.LeadTime,i.StockOnOrder, i.StockOnOrderInLT,i.TASKLISTVALUE,
             p.ProductCode,S.SupplierCode,i.SecondaryStatus,
             i.ForwardX_SonhBackoSonoInLT, i.SafetyStock
               from Item i
    left join product p on i.productno=p.productno 
    join Supplier s on i.SupplierNo1=s.SupplierNo
    where i.Status = "P" and i.LocationNo = :xLocNo
      into :xItemNo,:xCost,:xCostPer,:xLT,:xOnOrder, :xOnOrderInLT, :xPotentialStockout, 
           :ProductCode,:SupplierCode, :xSecondStatus, :xLTCover, :xSS
  do begin

    /*Only orders outside LT */
  
   /* xLT = :xLT * 30.4;
  
    xEndDate = :xLT + :xEndDate;
      
    for select OrderDate, ExpectedArrivalDate,Quantity 
      from PurchaseOrder where ItemNo = :xItemno
         and ExpectedArrivalDate > :xEndDate
      into :OrderDate, :EAD, :QTY
    do begin
      suspend;
    end
    */
    

    if ((xOnOrder - xOnOrderInLT) > 0) then
    Begin

      if((xCOSTPER = 0.0) or (xCOSTPER is null)) then
        xCOSTPER = 1.0;
        
      xCOST = xCOST / xCOSTPER;
    
      /* Convert tasklistvalue back to qty */
      xPotentialStockout = xPotentialStockout / xCost;

      if ((xOnOrder - xOnOrderInLT)>= xPotentialStockout) then
      begin
        QTY = xPotentialStockout;
      
      end
      else
      begin
        QTY = xOnOrder - xOnOrderInLT;
      end
      
      
      if (QTY > 0) then
      begin
      
        if (xSecondStatus = 'E') then
        begin
          EAD = xEndDate;
        end
        else
        begin
          xLTDays = (xLTCover - xSS) * 30.4;
          
          EAD = xEndDate;
          
          if (xLtDays > 0) then
          begin
            EAD = xEndDate + xLTDays;
          end
          
        end
        
        suspend;
      end
    
    end
    
  end
  
    
end
