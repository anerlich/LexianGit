create procedure up_getexpediteorder (LOCCODE varchar(10))
returns (PRODUCTCODE varchar(30),
 SUPPLIERCODE varchar(30), DIVISION varchar(15), QTY double precision, EAD date)
as
declare variable xItemNo Integer;

declare variable xLocNo Integer;
declare variable xCost double precision;
declare variable xCostPer double precision;
declare variable xExpedite double precision;
declare variable xExpedite2 double precision;
declare variable xStatus Char(1);
declare variable xStatus2 Char(1);


begin
  Select LocationNo from Location
    where LocationCode = :LocCode
    into :xLocNo; 
    
  Select TypeOfDate From Configuration
    where ConfigurationNo = 104
    into :EAD;
  
   /*Only products that are Expedite status*/ 
  for Select i.ItemNo,i.CostPrice, i.CostPer,i.Status, i.SecondaryStatus,
             i.TASKLISTVALUE,i.SecondaryTASKLISTVALUE,
             p.ProductCode,S.SupplierCode,r2.reportcategorycode  from Item i
    left join product p on i.productno=p.productno 
    join ITEM_REPORTCATEGORY r1 on i.ITEMNO = r1.ITEMNO and r1.REPORTCATEGORYTYPE = 1
    join REPORTCATEGORY r2 on r1.REPORTCATEGORYNO =  r2.REPORTCATEGORYNO and r2.REPORTCATEGORYTYPE = 1
    join Supplier s on i.SupplierNo1=s.SupplierNo
    where (i.Status = "E" or i.SecondaryStatus = "E") and i.LocationNo = :xLocNo
      into :xItemNo,:xCost,:xCostPer,:xStatus,:xStatus2,:xExpedite,:xExpedite2,:ProductCode,:SupplierCode,:Division
  do begin
  
    QTY = 0;
    
    if((xCOSTPER = 0.0) or (xCOSTPER is null)) then
      xCOSTPER = 1.0;

    if((xCOST = 0.0) or (xCOST is null)) then
      xCOST = 1.0;
      
    xCOST = xCOST / xCOSTPER;
  
    /* Convert tasklistvalue back to qty */
    /* if ist status is expedite then use tasklistvalue */
    /*if 2nd status is expedite then make sure 1st status is Stockout
       and then use secondarytasklistvalue */
    if (xStatus = "E") then
    begin
      QTY = xExpedite / xCost;
    end
    else
    begin
      if (xStatus = "Y") then
        QTY = xExpedite2 / xCost;
        
    end
    
    if (QTY > 0) then
    begin
      suspend;
    end
    
  end
  
    
end
