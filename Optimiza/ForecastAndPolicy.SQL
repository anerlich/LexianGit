Select l.locationCode
,p.productcode,p.generic
,g.primarychild
,i.StockingIndicator,i.ParetoCategory,i.Safetystock, i.LeadTime, i.ReviewPeriod, i.ReplenishmentCycle,  i.BinLevel
, f.calendarno
, f.forecast_0 AS f0  , f.forecast_1 AS f1  , f.forecast_2 AS f2  , f.forecast_3 AS f3  , f.forecast_4 AS f4  , f.forecast_5 AS f5  , f.forecast_6 AS f6  , f.forecast_7 AS f7  , f.forecast_8 AS f8  , f.forecast_9 AS f9  , f.forecast_10 AS f10  , f.forecast_11 AS f11
, bf.forecast_0 AS bf0, bf.forecast_1 AS bf1, bf.forecast_2 AS bf2, bf.forecast_3 AS bf3, bf.forecast_4 AS bf4, bf.forecast_5 AS bf5, bf.forecast_6 AS bf6, bf.forecast_7 AS bf7, bf.forecast_8 AS bf8, bf.forecast_9 AS bf9, bf.forecast_10 AS bf10, bf.forecast_11 AS bf11
, gf.forecast_0 AS gf0, gf.forecast_1 AS gf1, gf.forecast_2 AS gf2, gf.forecast_3 AS gf3, gf.forecast_4 AS gf4, gf.forecast_5 AS gf5, gf.forecast_6 AS gf6, gf.forecast_7 AS gf7, gf.forecast_8 AS gf8, gf.forecast_9 AS gf9, gf.forecast_10 AS gf10, gf.forecast_11 AS gf11
, co.customerorder_0 AS co0  , co.customerorder_1 AS co1  , co.customerorder_2 AS co2  , co.customerorder_3 AS co3  , co.customerorder_4 AS co4  , co.customerorder_5 AS co5  , co.customerorder_6 AS co6  , co.customerorder_7 AS co7  , co.customerorder_8 AS co8  , co.customerorder_9 AS co9  , co.customerorder_10 AS co10  , co.customerorder_11 AS co11

from item i left outer join itemforecast f on i.itemno = f.itemno and f.forecasttypeno = 1 and f.calendarno = :CALENDARNO
            left outer join itemforecast bf on i.itemno = bf.itemno and bf.forecasttypeno = 2 and bf.calendarno = :CALENDARNO
            left outer join itemforecast gf on i.itemno = gf.itemno and gf.forecasttypeno = 2 and gf.calendarno = :CALENDARNO
            left outer join Product P on i.ProductNo = P.ProductNo
            left outer join Location L on i.LocationNo = L.LocationNo
            left outer join generic g on i.productno = g.childproductno
            left outer join itemorder co on i.itemno = co.itemno
