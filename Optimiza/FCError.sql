CREATE PROCEDURE BACKP_FORECASTERROR_PERC (
  ITEMNO INTEGER,
  CURRENTPERIOD INTEGER
) RETURNS (
  FORECASTERROR DOUBLE PRECISION
) AS 
declare variable FCHISTORY_1 double precision;
declare variable FCHISTORY_2 double precision;
declare variable FCHISTORY_3 double precision;
declare variable FCHISTORY_4 double precision;
declare variable FCHISTORY_5 double precision;
declare variable FCHISTORY_6 double precision;
declare variable SALESAMOUNT_1 double precision;
declare variable SALESAMOUNT_2 double precision;
declare variable SALESAMOUNT_3 double precision;
declare variable SALESAMOUNT_4 double precision;
declare variable SALESAMOUNT_5 double precision;
declare variable SALESAMOUNT_6 double precision;
declare variable TOTAL6_FORECAST double precision;
declare variable TOTAL6_SALES double precision;
declare variable DEVIATION double precision;
declare variable TOTAL_DEVIATION double precision;
declare variable NORMAL_FCERROR double precision;
declare variable BIAS double precision;
declare variable AVGDEMAND double precision;
declare variable VOLATILITY double precision;
begin
  select FCHISTORY_1, FCHISTORY_2, FCHISTORY_3, FCHISTORY_4, FCHISTORY_5, FCHISTORY_6
  from ITEMFORECAST
  where ITEMNO = :ITEMNO
    and CALENDARNO = :CURRENTPERIOD
    and FORECASTTYPENO = 1
  into :FCHISTORY_1, :FCHISTORY_2, :FCHISTORY_3, :FCHISTORY_4, :FCHISTORY_5, :FCHISTORY_6;

  select SALESAMOUNT_1, SALESAMOUNT_2, SALESAMOUNT_3, SALESAMOUNT_4, SALESAMOUNT_5, SALESAMOUNT_6
  from ITEMSALES
  where ITEMNO = :ITEMNO
  into :SALESAMOUNT_1, :SALESAMOUNT_2, :SALESAMOUNT_3, :SALESAMOUNT_4, :SALESAMOUNT_5, :SALESAMOUNT_6;

  TOTAL6_FORECAST = FCHISTORY_1 + FCHISTORY_2 + FCHISTORY_3 + FCHISTORY_4 + FCHISTORY_5 + FCHISTORY_6;
  TOTAL6_SALES = SALESAMOUNT_1 + SALESAMOUNT_2 + SALESAMOUNT_3 + SALESAMOUNT_4 + SALESAMOUNT_5 + SALESAMOUNT_6;

  /* first calculation normal fc error */
  TOTAL_DEVIATION = 0.0;

  DEVIATION = FCHISTORY_1 - SALESAMOUNT_1;
  if(DEVIATION < 0.0) then
    DEVIATION = DEVIATION * -1.0;
  TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

  DEVIATION = FCHISTORY_2 - SALESAMOUNT_2;
  if(DEVIATION < 0.0) then
    DEVIATION = DEVIATION * -1.0;
  TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

  DEVIATION = FCHISTORY_3 - SALESAMOUNT_3;
  if(DEVIATION < 0.0) then
    DEVIATION = DEVIATION * -1.0;
  TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

  DEVIATION = FCHISTORY_4 - SALESAMOUNT_4;
  if(DEVIATION < 0.0) then
    DEVIATION = DEVIATION * -1.0;
  TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

  DEVIATION = FCHISTORY_5 - SALESAMOUNT_5;
  if(DEVIATION < 0.0) then
    DEVIATION = DEVIATION * -1.0;
  TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

  DEVIATION = FCHISTORY_6 - SALESAMOUNT_6;
  if(DEVIATION < 0.0) then
    DEVIATION = DEVIATION * -1.0;
  TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

  if(TOTAL6_FORECAST <> 0.0) then
    NORMAL_FCERROR = TOTAL_DEVIATION / TOTAL6_FORECAST * 100.0;
  else begin
    if(TOTAL_DEVIATION = 0.0) then
      NORMAL_FCERROR = 0.0;
    else
      NORMAL_FCERROR = 100.0;
  end

  /* now test for over-forecasting bias */
  if(TOTAL6_FORECAST <> 0.0) then
    BIAS = TOTAL6_SALES / TOTAL6_FORECAST;
  else
    BIAS = 1.0;

  if(BIAS < 0.90) then begin
    AVGDEMAND = TOTAL6_SALES / 6.0;
    TOTAL_DEVIATION = 0.0;

    DEVIATION = AVGDEMAND - SALESAMOUNT_1;
    if(DEVIATION < 0.0) then
      DEVIATION = DEVIATION * -1.0;
    TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

    DEVIATION = AVGDEMAND - SALESAMOUNT_2;
    if(DEVIATION < 0.0) then
      DEVIATION = DEVIATION * -1.0;
    TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

    DEVIATION = AVGDEMAND - SALESAMOUNT_3;
    if(DEVIATION < 0.0) then
      DEVIATION = DEVIATION * -1.0;
    TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

    DEVIATION = AVGDEMAND - SALESAMOUNT_4;
    if(DEVIATION < 0.0) then
      DEVIATION = DEVIATION * -1.0;
    TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

    DEVIATION = AVGDEMAND - SALESAMOUNT_5;
    if(DEVIATION < 0.0) then
      DEVIATION = DEVIATION * -1.0;
    TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

    DEVIATION = AVGDEMAND - SALESAMOUNT_6;
    if(DEVIATION < 0.0) then
      DEVIATION = DEVIATION * -1.0;
    TOTAL_DEVIATION = TOTAL_DEVIATION + DEVIATION;

    TOTAL_DEVIATION = TOTAL_DEVIATION / 6.0;
    if(AVGDEMAND <> 0.0) then
      VOLATILITY = TOTAL_DEVIATION / AVGDEMAND * 100.0;
    else
      VOLATILITY = 100.0;
  end
  else
    VOLATILITY = 100.0;

  /* and we use the lower of the two to return to the sender */
  if(NORMAL_FCERROR < VOLATILITY) then
    FORECASTERROR = NORMAL_FCERROR;
  else
    FORECASTERROR = VOLATILITY;
end