set term ; !!
create procedure up_salesandforecast 
returns (LOCATIONCODE varchar(10), PRODUCTCODE varchar(30),
 STOCKINGINDICATOR char(1), PARETOCATEGORY char(1), MAJORGROUP varchar(10), MINORGROUP1 varchar(10),
 MINORGROUP2 varchar(10), F0 double precision, F1 double precision, F2 double precision,
 F3 double precision, F4 double precision, F5 double precision, F6 double precision,
 F7 double precision, F8 double precision, F9 double precision, F10 double precision,
 F11 double precision, F12 double precision, F13 double precision, F14 double precision,
 F15 double precision, F16 double precision, F17 double precision, S0 double precision,
 S1 double precision, S2 double precision, S3 double precision, S4 double precision,
 S5 double precision, S6 double precision, S7 double precision, S8 double precision,
 S9 double precision, S10 double precision, S11 double precision, S12 double precision)
as
declare variable CURRENTPERIOD integer;
declare variable CO0 double precision; 
declare variable CO1 double precision; 
declare variable CO2 double precision;
declare variable CO3 double precision; 
declare variable CO4 double precision; 
declare variable CO5 double precision;
declare variable CO6 double precision; 
declare variable CO7 double precision; 
declare variable CO8 double precision;
declare variable CO9 double precision; 
declare variable CO10 double precision; 
declare variable CO11 double precision;
declare variable CO12 double precision; 
declare variable CO13 double precision; 
declare variable CO14 double precision;
declare variable CO15 double precision; 
declare variable CO16 double precision; 
declare variable CO17 double precision;
begin
  select TYPEOFINTEGER
  from CONFIGURATION
  where CONFIGURATIONNO = 100
  into :CURRENTPERIOD;
  for Select l.locationCode
  ,p.productcode
  ,i.StockingIndicator,i.ParetoCategory
  ,gm.GroupCode
  ,gm1.GroupCode
  ,gm2.GroupCode
  ,f.forecast_0 * i.CostPrice, f.forecast_1 * i.CostPrice, f.forecast_2 * i.CostPrice
  ,f.forecast_3 * i.CostPrice, f.forecast_4 * i.CostPrice, f.forecast_5 * i.CostPrice
  ,f.forecast_6 * i.CostPrice, f.forecast_7 * i.CostPrice, f.forecast_8 * i.CostPrice
  ,f.forecast_9 * i.CostPrice, f.forecast_10 * i.CostPrice, f.forecast_11 * i.CostPrice
  ,f.forecast_12 * i.CostPrice, f.forecast_13 * i.CostPrice, f.forecast_14 * i.CostPrice
  ,f.forecast_15 * i.CostPrice, f.forecast_16, f.forecast_17 * i.CostPrice
  ,co.customerorder_0  * i.CostPrice, co.customerorder_1 * i.CostPrice, co.customerorder_2 * i.CostPrice
  ,co.customerorder_3 * i.CostPrice, co.customerorder_4 * i.CostPrice, co.customerorder_5 * i.CostPrice
  ,co.customerorder_6 * i.CostPrice, co.customerorder_7 * i.CostPrice, co.customerorder_8 * i.CostPrice
  ,co.customerorder_9 * i.CostPrice, co.customerorder_10 * i.CostPrice, co.customerorder_11 * i.CostPrice
  ,co.customerorder_12 * i.CostPrice, co.customerorder_13 * i.CostPrice, co.customerorder_14 * i.CostPrice
  ,co.customerorder_15 * i.CostPrice, co.customerorder_16 * i.CostPrice, co.customerorder_17 * i.CostPrice
  ,s.SalesAmount_0 * i.CostPrice, s.SalesAmount_1 * i.CostPrice, s.SalesAmount_2 * i.CostPrice
  ,s.SalesAmount_3 * i.CostPrice, s.SalesAmount_4 * i.CostPrice, s.SalesAmount_5 * i.CostPrice
  ,s.SalesAmount_6 * i.CostPrice, s.SalesAmount_7 * i.CostPrice, s.SalesAmount_8 * i.CostPrice
  ,s.SalesAmount_9 * i.CostPrice, s.SalesAmount_10 * i.CostPrice, s.SalesAmount_11 * i.CostPrice
  ,s.SalesAmount_12 * i.CostPrice
  from item i left outer join itemforecast f on i.itemno = f.itemno 
                              and f.forecasttypeno = 1 and f.calendarno = :CurrentPeriod
              left outer join Product P on i.ProductNo = P.ProductNo
              left outer join Location L on i.LocationNo = L.LocationNo
              left outer join itemorder co on i.itemno = co.itemno
              left outer join ItemSales s on i.itemno = s.itemno
              left outer join GroupMajor gm on i.GroupMajor = gm.GroupNo
              left outer join GroupMinor1 gm1 on i.GroupMinor1 =gm1.GroupNo 
              left outer join GroupMinor2 gm2 on i.GroupMinor2 = gm2.GroupNo
          where 
           (f.forecast_0  + f.forecast_1 + f.forecast_2 + f.forecast_3 
           + f.forecast_4 + f.forecast_5 + f.forecast_6 
           + f.forecast_7 + f.forecast_8 + f.forecast_9 
           + f.forecast_10 + f.forecast_11 + f.forecast_12 
           + f.forecast_13 + f.forecast_14 + f.forecast_15 
           + f.forecast_16 + f.forecast_17 ) > 0.00  or
           (co.customerorder_0  + co.customerorder_1 + co.customerorder_2
           +co.customerorder_3 + co.customerorder_4 + co.customerorder_5
           +co.customerorder_6 + co.customerorder_7 + co.customerorder_8
           +co.customerorder_9 + co.customerorder_10 + co.customerorder_11
           +co.customerorder_12 + co.customerorder_13 + co.customerorder_14
           +co.customerorder_15 + co.customerorder_16 + co.customerorder_17) > 0.00 or
           (s.SalesAmount_0 + s.SalesAmount_1 + s.SalesAmount_2
            +s.SalesAmount_3 + s.SalesAmount_4 + s.SalesAmount_5
            +s.SalesAmount_6 + s.SalesAmount_7 + s.SalesAmount_8
            +s.SalesAmount_9 + s.SalesAmount_10 + s.SalesAmount_11
            +s.SalesAmount_12) > 0.00

        into
  :LocationCode
  ,:ProductCode
  ,:StockingIndicator,:ParetoCategory
  ,:MajorGroup
  ,:MinorGroup1
  ,:MinorGroup2
  ,:F0 , :F1, :F2, :F3, :F4, :F5, :F6, :F7, :F8, :F9, :F10, :F11 
  ,:F12, :F13, :F14, :F15, :F16, :F17
  ,:CO0 , :CO1, :CO2, :CO3, :CO4, :CO5, :CO6, :CO7, :CO8, :CO9, :CO10, :CO11
  ,:CO12, :CO13, :CO14, :CO15, :CO16, :CO17
  ,:S0, :S1, :S2, :S3, :S4, :S5, :S6 , :S7, :S8, :S9, :S10, :S11, :S12
  do begin
  if (CO0 > F0) then
      F0 = CO0;
  if(CO1 > F1) then
    F1 = CO1;
  if(CO2 > F2) then
    F2 = CO2;
  if(CO3 > F3) then
    F3 = CO3;
  if(CO4 > F4) then
    F4 = CO4;
  if(CO5 > F5) then
    F5 = CO5;
  if(CO6 > F6) then
    F6 = CO6;
  if(CO7 > F7) then
    F7 = CO7;
  if(CO8 > F8) then
    F8 = CO8;
  if(CO9 > F9) then
    F9 = CO9;
  if(CO10 > F10) then
    F10 = CO10;
  if(CO11 > F11) then
    F11 = CO11;
  if(CO12 > F12) then
    F12 = CO12;
  if(CO13 > F13) then
    F13 = CO13;
  if(CO14 > F14) then
    F14 = CO14;
  if(CO15 > F15) then
    F15 = CO15;
  if(CO16 > F16) then
    F16 = CO16;
  if(CO17 > F17) then
    F17 = CO17;
    Suspend;
  end            
end !!

set term !! ;
