ALTER PROCEDURE UP_GETPOTENTIALSTOCKOUT(
  LOCCODE VARCHAR(10) CHARACTER SET NONE COLLATE NONE)
RETURNS(
  PRODUCTCODE VARCHAR(30) CHARACTER SET NONE COLLATE NONE,
  SUPPLIERCODE VARCHAR(30) CHARACTER SET NONE COLLATE NONE,
  DIVISION VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
  WAREHOUSE VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
  QTY DOUBLE PRECISION,
  ORDERDATE DATE,
  EAD DATE,
  WWDIVISION VARCHAR(15) CHARACTER SET NONE COLLATE NONE)
AS
/* Ver 3.11 - 11/04/2012 CM Add extra field for WWPlan */
DECLARE VARIABLE XENDDATE DATE;
DECLARE VARIABLE XITEMNO INTEGER;
DECLARE VARIABLE XLT DOUBLE PRECISION;
DECLARE VARIABLE XLOCNO INTEGER;
DECLARE VARIABLE XONORDER DOUBLE PRECISION;
DECLARE VARIABLE XONORDERINLT DOUBLE PRECISION;
DECLARE VARIABLE XPOTENTIALSTOCKOUT DOUBLE PRECISION;
DECLARE VARIABLE XCOST DOUBLE PRECISION;
DECLARE VARIABLE XCOSTPER DOUBLE PRECISION;
DECLARE VARIABLE XSECONDSTATUS CHAR(1);
DECLARE VARIABLE XLTCOVER DOUBLE PRECISION;
DECLARE VARIABLE XLTDAYS DOUBLE PRECISION;
DECLARE VARIABLE XSS DOUBLE PRECISION;
begin
  Select LocationNo,LocationCode from Location
    where LocationCode = :LocCode
    into :xLocNo,:Division; 
  
  Select TypeOfDate from Configuration where  ConfigurationNo = 104
   into :xEndDate;
  
  /*Only products that are Potential Stockouts*/ 
  for Select i.ItemNo,i.CostPrice, i.CostPer,i.LeadTime,i.StockOnOrder, i.StockOnOrderInLT,i.TASKLISTVALUE,
             p.ProductCode,S.SupplierCode,i.SecondaryStatus,
             i.ForwardX_SonhBackoSonoInLT, i.SafetyStock, rc41.ReportCategoryCode, rc40.ReportCategoryCode WWDiv	/* Ver 3.11 */
               from Item i
    left join product p on i.productno=p.productno 
    join Supplier s on i.SupplierNo1=s.SupplierNo
    left join ITEM_REPORTCATEGORY rrr4 on i.ITEMNO = rrr4.ITEMNO and rrr4.REPORTCATEGORYTYPE = 4
    left join ITEM_REPORTCATEGORY rrr13 on i.ITEMNO = rrr13.ITEMNO and rrr13.REPORTCATEGORYTYPE = 13
    left join ITEM_REPORTCATEGORY r41 on i.ITEMNO = r41.ITEMNO and r41.REPORTCATEGORYTYPE = 41
    left join ReportCategory rc41 on r41.ReportCategoryNo=rc41.ReportCategoryNo and rc41.ReportCategoryType=41
    left join ITEM_REPORTCATEGORY r40 on i.ITEMNO = r40.ITEMNO and r40.REPORTCATEGORYTYPE = 40						/* Ver 3.11 */
    left join ReportCategory rc40 on r40.ReportCategoryNo=rc40.ReportCategoryNo and rc40.ReportCategoryType=40		/* Ver 3.11 */
    where i.Status = "P" and i.LocationNo = :xLocNo
          and rrr4.REPORTCATEGORYNO <> 6   /* Exclude D sku flag */
          and ((rrr13.REPORTCATEGORYNO = 2 and i.STOCKINGINDICATOR = "Y") 
              or (rrr13.REPORTCATEGORYNO <> 2))/* V codes that are stocked   OR non V codes */
      into :xItemNo,:xCost,:xCostPer,:xLT,:xOnOrder, :xOnOrderInLT, :xPotentialStockout, 
           :ProductCode,:SupplierCode, :xSecondStatus, :xLTCover, :xSS, :Warehouse, :WWDivision						/* Ver 3.11 */
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

      if((xCOST = 0.0) or (xCOST is null)) then
        xCOST = 1.0;
        
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
  
    
end;