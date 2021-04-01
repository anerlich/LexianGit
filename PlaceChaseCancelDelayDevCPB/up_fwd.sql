create procedure up_fwd (XITEMNO integer, FIRST_PERIOD_RATIO double precision, PERIODS double precision,
 XSTOCKED char(1), USEOFCO char(1), USEOFBOM char(1), USEOFDRP char(1), PRORATEBOM char(1),
 PRORATEDRP char(1), SALES_0 double precision, XCALNO integer)
returns (DEMAND double precision)
as
declare variable CURRENTPERIOD integer;
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
declare variable FORECAST_12 double precision;
declare variable FORECAST_13 double precision;
declare variable FORECAST_14 double precision;
declare variable FORECAST_15 double precision;
declare variable FORECAST_16 double precision;
declare variable FORECAST_17 double precision;
declare variable FORECAST_18 double precision;
declare variable FORECAST_19 double precision;
declare variable FORECAST_20 double precision;
declare variable FORECAST_21 double precision;
declare variable FORECAST_22 double precision;
declare variable FORECAST_23 double precision;
declare variable FORECAST_24 double precision;
declare variable FORECAST_25 double precision;


begin

execute procedure UP_FWD_DEMAND(:xITEMNO, :xCalNo, 1.0, :xStocked, 
                                 :UseOfCO, :USEOFBOM, :USEOFDRP, :PRORATEBOM, :PRORATEDRP, :Sales_0)
    returning_values(
    :FORECAST_0, :FORECAST_1, :FORECAST_2, :FORECAST_3, :FORECAST_4, :FORECAST_5,
    :FORECAST_6, :FORECAST_7, :FORECAST_8, :FORECAST_9, :FORECAST_10, :FORECAST_11);   
    
  FORECAST_12 = 0;
  FORECAST_13 = 0;
  FORECAST_14 = 0;
  FORECAST_15 = 0;
  FORECAST_16 = 0;
  FORECAST_17 = 0;
  FORECAST_18 = 0;
  FORECAST_19 = 0;
  FORECAST_20 = 0;
  FORECAST_21 = 0;
  FORECAST_22 = 0;
  FORECAST_23 = 0;
  FORECAST_24 = 0;
  FORECAST_25 = 0;
 
  DEMAND = 0.0;
  if(PERIODS > FIRST_PERIOD_RATIO) then begin
    DEMAND = DEMAND + FORECAST_0;
    PERIODS = PERIODS - FIRST_PERIOD_RATIO;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_0 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_1;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_1 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_2;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_2 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_3;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_3 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_4;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_4 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_5;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_5 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_6;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_6 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_7;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_7 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_8;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_8 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_9;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_9 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_10;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_10 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_11;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_11 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_12;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_12 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_13;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_13 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_14;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_14 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_15;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_15 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_16;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_16 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_17;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_17 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_18;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_18 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_19;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_19 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_20;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_20 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_21;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_21 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_22;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_22 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_23;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_23 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_24;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_24 * PERIODS);
    PERIODS = 0.0;
  end

  if(PERIODS > 1.0) then begin
    DEMAND = DEMAND + FORECAST_25;
    PERIODS = PERIODS - 1.0;
  end
  else begin
    DEMAND = DEMAND + (FORECAST_25 * PERIODS);
    PERIODS = 0.0;
  end

  if(DEMAND is null) then
    DEMAND = 0.0;
    
  suspend;
  
end
