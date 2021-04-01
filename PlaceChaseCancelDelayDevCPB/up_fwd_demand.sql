create procedure up_fwd_demand (ITEMNO integer, CALENDARNO integer, FIRSTPERIODRATIO double precision,
 STOCKED char(1), USEOFCO char(1), USEOFBOM char(1), USEOFDRP char(1), PRORATEBOM char(1),
 PRORATEDRP char(1), SALES_0 double precision)
returns (FORECAST_0 double precision,
 FORECAST_1 double precision, FORECAST_2 double precision, FORECAST_3 double precision,
 FORECAST_4 double precision, FORECAST_5 double precision, FORECAST_6 double precision,
 FORECAST_7 double precision, FORECAST_8 double precision, FORECAST_9 double precision,
 FORECAST_10 double precision, FORECAST_11 double precision)
as
declare variable CUSTOMERORDER_0 double precision;
     declare variable CUSTOMERORDER_1 double precision;
     declare variable CUSTOMERORDER_2 double precision;
     declare variable CUSTOMERORDER_3 double precision;
     declare variable CUSTOMERORDER_4 double precision;
     declare variable CUSTOMERORDER_5 double precision;
     declare variable CUSTOMERORDER_6 double precision;
     declare variable CUSTOMERORDER_7 double precision;
     declare variable CUSTOMERORDER_8 double precision;
     declare variable CUSTOMERORDER_9 double precision;
     declare variable CUSTOMERORDER_10 double precision;
     declare variable CUSTOMERORDER_11 double precision;


     declare variable AFORECAST_0 double precision;
     declare variable AFORECAST_1 double precision;
     declare variable AFORECAST_2 double precision;
     declare variable AFORECAST_3 double precision;
     declare variable AFORECAST_4 double precision;
     declare variable AFORECAST_5 double precision;
     declare variable AFORECAST_6 double precision;
     declare variable AFORECAST_7 double precision;
     declare variable AFORECAST_8 double precision;
     declare variable AFORECAST_9 double precision;
     declare variable AFORECAST_10 double precision;
     declare variable AFORECAST_11 double precision;
     declare variable FORECASTTYPENO integer;
begin
  FORECAST_0 = 0.0;
  FORECAST_1 = 0.0;
  FORECAST_2 = 0.0;
  FORECAST_3 = 0.0;
  FORECAST_4 = 0.0;
  FORECAST_5 = 0.0;
  FORECAST_6 = 0.0;
  FORECAST_7 = 0.0;
  FORECAST_8 = 0.0;
  FORECAST_9 = 0.0;
  FORECAST_10 = 0.0;
  FORECAST_11 = 0.0;

  if (UseOfCO <> 'N') then
    select CUSTOMERORDER_0, CUSTOMERORDER_1, CUSTOMERORDER_2, CUSTOMERORDER_3,
         CUSTOMERORDER_4, CUSTOMERORDER_5, CUSTOMERORDER_6, CUSTOMERORDER_7,
         CUSTOMERORDER_8, CUSTOMERORDER_9, CUSTOMERORDER_10, CUSTOMERORDER_11
    from ITEMORDER
    where ITEMNO = :ITEMNO
    into :CUSTOMERORDER_0, :CUSTOMERORDER_1, :CUSTOMERORDER_2, :CUSTOMERORDER_3,
       :CUSTOMERORDER_4, :CUSTOMERORDER_5, :CUSTOMERORDER_6, :CUSTOMERORDER_7,
       :CUSTOMERORDER_8, :CUSTOMERORDER_9, :CUSTOMERORDER_10, :CUSTOMERORDER_11;

  for select FORECAST_0, FORECAST_1, FORECAST_2, FORECAST_3, FORECAST_4,
             FORECAST_5, FORECAST_6, FORECAST_7, FORECAST_8, FORECAST_9, FORECAST_10,
             FORECAST_11, FORECASTTYPENO
      from ITEMFORECAST
      where ITEMNO = :ITEMNO
        and FORECASTTYPENO < 4
        and CALENDARNO = :CALENDARNO
      into :AFORECAST_0, :AFORECAST_1, :AFORECAST_2, :AFORECAST_3, :AFORECAST_4,
           :AFORECAST_5, :AFORECAST_6, :AFORECAST_7, :AFORECAST_8, :AFORECAST_9, :AFORECAST_10,
           :AFORECAST_11,:FORECASTTYPENO
  do begin
    if(FORECASTTYPENO = 1) then begin /* for forecast type 1 we use the customer order override rules */
      
      /*non stocked then we only use customer order here */
      if (stocked = "N") then
      begin
        AFORECAST_0 = 0.0;
        AFORECAST_1 = 0.0;
        AFORECAST_2 = 0.0;
        AFORECAST_3 = 0.0;
        AFORECAST_4 = 0.0;
        AFORECAST_5 = 0.0;
        AFORECAST_6 = 0.0;
        AFORECAST_7 = 0.0;
        AFORECAST_8 = 0.0;
        AFORECAST_9 = 0.0;
        AFORECAST_10 = 0.0;
        AFORECAST_11 = 0.0;
      end
      
      AFORECAST_0 = AFORECAST_0 * FIRSTPERIODRATIO;
      
      AFORECAST_0 = AFORECAST_0 - Sales_0;
      
      if (AFORECAST_0 <0) then
        AFORECAST_0 = 0;
        
      if (UseOfCO = 'I') then begin
        if(CUSTOMERORDER_0 > AFORECAST_0) then 
          FORECAST_0 = FORECAST_0 + CUSTOMERORDER_0;
        else
          FORECAST_0 = FORECAST_0 + AFORECAST_0;
        if(CUSTOMERORDER_1 > AFORECAST_1) then
          FORECAST_1 = FORECAST_1 + CUSTOMERORDER_1;
        else
          FORECAST_1 = FORECAST_1 + AFORECAST_1;
        if(CUSTOMERORDER_2 > AFORECAST_2) then
          FORECAST_2 = FORECAST_2 + CUSTOMERORDER_2;
        else
          FORECAST_2 = FORECAST_2 + AFORECAST_2;
        if(CUSTOMERORDER_3 > AFORECAST_3) then
          FORECAST_3 = FORECAST_3 + CUSTOMERORDER_3;
        else
          FORECAST_3 = FORECAST_3 + AFORECAST_3;
        if(CUSTOMERORDER_4 > AFORECAST_4) then
          FORECAST_4 = FORECAST_4 + CUSTOMERORDER_4;
        else
          FORECAST_4 = FORECAST_4 + AFORECAST_4;
        if(CUSTOMERORDER_5 > AFORECAST_5) then
          FORECAST_5 = FORECAST_5 + CUSTOMERORDER_5;
        else
          FORECAST_5 = FORECAST_5 + AFORECAST_5;
        if(CUSTOMERORDER_6 > AFORECAST_6) then
          FORECAST_6 = FORECAST_6 + CUSTOMERORDER_6;
        else
          FORECAST_6 = FORECAST_6 + AFORECAST_6;
        if(CUSTOMERORDER_7 > AFORECAST_7) then
          FORECAST_7 = FORECAST_7 + CUSTOMERORDER_7;
        else
          FORECAST_7 = FORECAST_7 + AFORECAST_7;
        if(CUSTOMERORDER_8 > AFORECAST_8) then
          FORECAST_8 = FORECAST_8 + CUSTOMERORDER_8;
        else
          FORECAST_8 = FORECAST_8 + AFORECAST_8;
        if(CUSTOMERORDER_9 > AFORECAST_9) then
          FORECAST_9 = FORECAST_9 + CUSTOMERORDER_9;
        else
          FORECAST_9 = FORECAST_9 + AFORECAST_9;
        if(CUSTOMERORDER_10 > AFORECAST_10) then
          FORECAST_10 = FORECAST_10 + CUSTOMERORDER_10;
        else
          FORECAST_10 = FORECAST_10 + AFORECAST_10;
        if(CUSTOMERORDER_11 > AFORECAST_11) then
          FORECAST_11 = FORECAST_11 + CUSTOMERORDER_11;
        else
          FORECAST_11 = FORECAST_11 + AFORECAST_11;
      end
      else
        if(UseOfCO = 'A') then begin
          FORECAST_0 = FORECAST_0 + AFORECAST_0 + CUSTOMERORDER_0;
          FORECAST_1 = FORECAST_1 + AFORECAST_1 + CUSTOMERORDER_1;
          FORECAST_2 = FORECAST_2 + AFORECAST_2 + CUSTOMERORDER_2;
          FORECAST_3 = FORECAST_3 + AFORECAST_3 + CUSTOMERORDER_3;
          FORECAST_4 = FORECAST_4 + AFORECAST_4 + CUSTOMERORDER_4;
          FORECAST_5 = FORECAST_5 + AFORECAST_5 + CUSTOMERORDER_5;
          FORECAST_6 = FORECAST_6 + AFORECAST_6 + CUSTOMERORDER_6;
          FORECAST_7 = FORECAST_7 + AFORECAST_7 + CUSTOMERORDER_7;
          FORECAST_8 = FORECAST_8 + AFORECAST_8 + CUSTOMERORDER_8;
          FORECAST_9 = FORECAST_9 + AFORECAST_9 + CUSTOMERORDER_9;
          FORECAST_10 = FORECAST_10 + AFORECAST_10 + CUSTOMERORDER_10;
          FORECAST_11 = FORECAST_11 + AFORECAST_11 + CUSTOMERORDER_11;
        end
        else begin /* ignore means me just add the forecast */
          FORECAST_0 = FORECAST_0 + AFORECAST_0;
          FORECAST_1 = FORECAST_1 + AFORECAST_1;
          FORECAST_2 = FORECAST_2 + AFORECAST_2;
          FORECAST_3 = FORECAST_3 + AFORECAST_3;
          FORECAST_4 = FORECAST_4 + AFORECAST_4;
          FORECAST_5 = FORECAST_5 + AFORECAST_5;
          FORECAST_6 = FORECAST_6 + AFORECAST_6;
          FORECAST_7 = FORECAST_7 + AFORECAST_7;
          FORECAST_8 = FORECAST_8 + AFORECAST_8;
          FORECAST_9 = FORECAST_9 + AFORECAST_9;
          FORECAST_10 = FORECAST_10 + AFORECAST_10;
          FORECAST_11 = FORECAST_11 + AFORECAST_11;
        end
    end
    else begin /* for forecast type 2 and 3 we just add up */
      if((FORECASTTYPENO = 2) and (USEOFBOM = 'Y')) then begin
        if (PRORATEBOM = 'Y') then
          AFORECAST_0 = AFORECAST_0 * FIRSTPERIODRATIO;
        FORECAST_0 = FORECAST_0 + AFORECAST_0;
        FORECAST_1 = FORECAST_1 + AFORECAST_1;
        FORECAST_2 = FORECAST_2 + AFORECAST_2;
        FORECAST_3 = FORECAST_3 + AFORECAST_3;
        FORECAST_4 = FORECAST_4 + AFORECAST_4;
        FORECAST_5 = FORECAST_5 + AFORECAST_5;
        FORECAST_6 = FORECAST_6 + AFORECAST_6;
        FORECAST_7 = FORECAST_7 + AFORECAST_7;
        FORECAST_8 = FORECAST_8 + AFORECAST_8;
        FORECAST_9 = FORECAST_9 + AFORECAST_9;
        FORECAST_10 = FORECAST_10 + AFORECAST_10;
        FORECAST_11 = FORECAST_11 + AFORECAST_11;
      end
      
      if((FORECASTTYPENO = 3) and (USEOFDRP = 'Y')) then begin
        if (PRORATEDRP = 'Y') then
          AFORECAST_0 = AFORECAST_0 * FIRSTPERIODRATIO;
        FORECAST_0 = FORECAST_0 + AFORECAST_0;
        FORECAST_1 = FORECAST_1 + AFORECAST_1;
        FORECAST_2 = FORECAST_2 + AFORECAST_2;
        FORECAST_3 = FORECAST_3 + AFORECAST_3;
        FORECAST_4 = FORECAST_4 + AFORECAST_4;
        FORECAST_5 = FORECAST_5 + AFORECAST_5;
        FORECAST_6 = FORECAST_6 + AFORECAST_6;
        FORECAST_7 = FORECAST_7 + AFORECAST_7;
        FORECAST_8 = FORECAST_8 + AFORECAST_8;
        FORECAST_9 = FORECAST_9 + AFORECAST_9;
        FORECAST_10 = FORECAST_10 + AFORECAST_10;
        FORECAST_11 = FORECAST_11 + AFORECAST_11;
      end
    end
  end
end
