CREATE PROCEDURE UP_CONSOLIDATEMIN (
  SOURCELOCATIONCODE VARCHAR(10),
  TARGETLOCATIONCODE VARCHAR(10)
)  AS   
declare variable xProductNo integer;
declare variable xMINIMUMORDERQUANTITY double precision;
declare variable xORDERMULTIPLES double precision;
declare variable xSourceLocationNo integer;
declare variable xTargetLocationNo integer;
begin
  Select LocationNO From Location where LocationCode =
      :TARGETLOCATIONCODE
      into :xTargetLocationNo;
  Select LocationNO From Location where LocationCode =
      :SOURCELOCATIONCODE
      into :xSourceLocationNo;

 for Select TgtItem.ProductNo, 
             TgtItem.LocationNo, 
             SrcItem.LocationNo, 
             SrcItem.MinimumOrderQuantity ,
             SrcItem.OrderMultiples
      From Item TgtItem, Item SrcItem
      where TgtItem.LocationNo = :xTargetLocationNo and 
            SrcItem.LocationNo = :xSourceLocationNo and 
            TgtItem.ProductNo = SrcItem.ProductNo
      into :xProductNo,
           :xTargetLocationNo,
           :xSourceLocationNo,
           :xMINIMUMORDERQUANTITY,
           :xORDERMULTIPLES
  do begin
    update ITEM
    set MINIMUMORDERQUANTITY = :xMINIMUMORDERQUANTITY,
        ORDERMULTIPLES = :xORDERMULTIPLES
    where PRODUCTNO = :xPRODUCTNO
      and LOCATIONNO = :xTargetLOCATIONNO;
  end


end