Update Item Set 
  ParetoCategory = "A"
  ,StockingIndicator = "Y"
Where 
  LocationNo in (1)
and age = 0
and itemno in (
Select i.itemno
  from item i left join itemforecast f on i.itemno = f.itemno and f.forecasttypeno = 1 and f.calendarno = (SELECT TypeOfInteger FROM Configuration  WHERE ConfigurationNo = 100)
              left outer join itemforecast df on i.itemno = df.itemno and df.forecasttypeno = 4 and df.calendarno =  (SELECT TypeOfInteger FROM Configuration  WHERE ConfigurationNo = 100)
              left outer join itemforecast bf on i.itemno = bf.itemno and bf.forecasttypeno = 3 and bf.calendarno =  (SELECT TypeOfInteger FROM Configuration  WHERE ConfigurationNo = 100)
     where
          (f.forecast_0+f.forecast_1+f.forecast_2+
                 f.forecast_3+f.forecast_4+f.forecast_5+
                 f.forecast_6+f.forecast_7+f.forecast_8+
                 f.forecast_9+f.forecast_10+f.forecast_11) = 0
             AND (df.forecast_0+df.forecast_1+df.forecast_2+
                 df.forecast_3+df.forecast_4+df.forecast_5+
                 df.forecast_6+df.forecast_7+df.forecast_8+
                 df.forecast_9+df.forecast_10+df.forecast_11) = 0
             AND (bf.forecast_0+bf.forecast_1+bf.forecast_2+
                 bf.forecast_3+bf.forecast_4+bf.forecast_5+
                 bf.forecast_6+bf.forecast_7+bf.forecast_8+
                 bf.forecast_9+bf.forecast_10+bf.forecast_11) = 0
)