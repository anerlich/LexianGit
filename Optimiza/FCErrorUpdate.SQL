Set Term !! ;

Alter Procedure UP_UpdateFCAccuracy
As

/* KG 18/07/01 Patch for FC Error */
/* KG 31/7/01 Amended for DRP forecast */
/* KG 31/7/01 Amended for Branch forecast */
/* KG 02/08/01 Amended for AGE < 13 and 12 periods of FC */

Declare variable xItemNo Integer;
Declare variable xCalendarNo Integer;

Begin

SELECT TypeOfInteger FROM Configuration
  WHERE ConfigurationNo = 100
   Into :xCalendarNo;


For Select i.itemno
  from item i left join itemforecast f on i.itemno = f.itemno and f.forecasttypeno = 1 and f.calendarno = :xCALENDARNO
              left join ItemSales s on i.itemNo = s.itemNo
              left outer join itemforecast df on i.itemno = df.itemno and df.forecasttypeno = 4 and df.calendarno = :xCALENDARNO
              left outer join itemforecast bf on i.itemno = bf.itemno and bf.forecasttypeno = 3 and bf.calendarno = :xCALENDARNO

  where i.StockingIndicator = "Y"
        and i.Age < 13
        and (   (f.forecast_0+f.forecast_1+f.forecast_2+
                 f.forecast_3+f.forecast_4+f.forecast_5+
                 f.forecast_6+f.forecast_7+f.forecast_8+
                 f.forecast_9+f.forecast_10+f.forecast_11) > 0
             OR (df.forecast_0+df.forecast_1+df.forecast_2+
                 df.forecast_3+df.forecast_4+df.forecast_5+
                 df.forecast_6+df.forecast_7+df.forecast_8+
                 df.forecast_9+df.forecast_10+df.forecast_11) > 0
             OR (bf.forecast_0+bf.forecast_1+bf.forecast_2+
                 bf.forecast_3+bf.forecast_4+bf.forecast_5+
                 bf.forecast_6+bf.forecast_7+bf.forecast_8+
                 bf.forecast_9+bf.forecast_10+bf.forecast_11) > 0)
        and s.SalesAmount_1 = 0 
        and s.SalesAmount_2 = 0
        and s.SalesAmount_3 = 0
        and s.SalesAmount_4 = 0
        and s.SalesAmount_5 = 0
        and s.SalesAmount_6 = 0
        Into :xItemNo

  Do Begin
    Update Item Set ForecastAccuracy = 50
     where ItemNo = :xItemNo;
  End

End!!

Set Term ; !!
