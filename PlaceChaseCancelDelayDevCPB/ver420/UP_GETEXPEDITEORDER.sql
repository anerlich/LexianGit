ALTER PROCEDURE UP_GETEXPEDITEORDER(
  LOCCODE VARCHAR(10) CHARACTER SET NONE COLLATE NONE)
RETURNS(
  PRODUCTCODE VARCHAR(30) CHARACTER SET NONE COLLATE NONE,
  SUPPLIERCODE VARCHAR(30) CHARACTER SET NONE COLLATE NONE,
  DIVISION VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
  WAREHOUSE VARCHAR(15) CHARACTER SET NONE COLLATE NONE,
  QTY DOUBLE PRECISION,
  EAD DATE,
  WWDIVISION VARCHAR(15) CHARACTER SET NONE COLLATE NONE)
AS
/* Ver 3.11 - 11/04/2012 CM Add extra field for WWPlan */
DECLARE VARIABLE XITEMNO INTEGER;
DECLARE VARIABLE XLOCNO INTEGER;
DECLARE VARIABLE XCOST DOUBLE PRECISION;
DECLARE VARIABLE XCOSTPER DOUBLE PRECISION;
DECLARE VARIABLE XEXPEDITE DOUBLE PRECISION;
begin
  Select LocationNo,LocationCode from Location
    where LocationCode = :LocCode
    into :xLocNo,:Division; 
    
  Select TypeOfDate From Configuration
    where ConfigurationNo = 104
    into :EAD;
  
   /*Only products that are Expedite status*/ 
  for Select i.ItemNo,i.CostPrice, i.CostPer,i.TASKLISTVALUE,
             p.ProductCode,S.SupplierCode, rc41.ReportCategoryCode, rc40.ReportCategoryCode WWDiv from Item i		/* Ver 3.11 */
    left join product p on i.productno=p.productno 
    join Supplier s on i.SupplierNo1=s.SupplierNo
    left join ITEM_REPORTCATEGORY rrr4 on i.ITEMNO = rrr4.ITEMNO and rrr4.REPORTCATEGORYTYPE = 4
    left join ITEM_REPORTCATEGORY rrr13 on i.ITEMNO = rrr13.ITEMNO and rrr13.REPORTCATEGORYTYPE = 13
    left join ITEM_REPORTCATEGORY r41 on i.ITEMNO = r41.ITEMNO and r41.REPORTCATEGORYTYPE = 41
    left join ReportCategory rc41 on r41.ReportCategoryNo=rc41.ReportCategoryNo and rc41.ReportCategoryType=41    
    left join ITEM_REPORTCATEGORY r40 on i.ITEMNO = r40.ITEMNO and r40.REPORTCATEGORYTYPE = 40						/* Ver 3.11 */
    left join ReportCategory rc40 on r40.ReportCategoryNo=rc40.ReportCategoryNo and rc40.ReportCategoryType=40		/* Ver 3.11 */
    
    where i.Status = "E" and i.LocationNo = :xLocNo
          and rrr4.REPORTCATEGORYNO <> 6   /* Exclude D sku flag */
          and ((rrr13.REPORTCATEGORYNO = 2 and i.STOCKINGINDICATOR = "Y") 
              or (rrr13.REPORTCATEGORYNO <> 2))/* V codes that are stocked   OR non V codes */

      into :xItemNo,:xCost,:xCostPer,:xExpedite,:ProductCode,:SupplierCode, :Warehouse, :WWDivision					/* Ver 3.11 */
  do begin
  
    
    if((xCOSTPER = 0.0) or (xCOSTPER is null)) then
      xCOSTPER = 1.0;

    if((xCOST = 0.0) or (xCOST is null)) then
      xCOST = 1.0;
      
    xCOST = xCOST / xCOSTPER;
  
    /* Convert tasklistvalue back to qty */
    QTY = xExpedite / xCost;
    
    if (QTY > 0) then
    begin
      suspend;
    end
    
  end
  
    
end;