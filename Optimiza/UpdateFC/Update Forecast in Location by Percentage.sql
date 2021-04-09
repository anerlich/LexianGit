alter procedure up_updatefcbyperc (SOURCELOCATIONCODE varchar(10), SOURCEPRODUCTCODE varchar(30),
 MONTHCOUNT integer, OFFSET integer, FREEZEIND varchar(1), PERC double precision)
as
declare variable xSourceItem      Integer;
  declare variable xLocationNo      Integer;
  declare variable xProductNo       Integer;
  declare variable xCalendarNo integer;
  declare variable xsfFORECAST_0    CHAR(1) ;
  declare variable xsfFORECAST_1    CHAR(1) ;
  declare variable xsfFORECAST_2    CHAR(1) ;
  declare variable xsfFORECAST_3    CHAR(1) ;
  declare variable xsfFORECAST_4    CHAR(1) ;
  declare variable xsfFORECAST_5    CHAR(1) ;
  declare variable xsfFORECAST_6    CHAR(1) ;
  declare variable xsfFORECAST_7    CHAR(1) ;
  declare variable xsfFORECAST_8    CHAR(1) ;
  declare variable xsfFORECAST_9    CHAR(1) ;
  declare variable xsfFORECAST_10   CHAR(1) ;
  declare variable xsfFORECAST_11   CHAR(1) ;
  declare variable xsfFORECAST_12   CHAR(1) ;
  declare variable xsfFORECAST_13   CHAR(1) ;
  declare variable xsfFORECAST_14   CHAR(1) ;
  declare variable xsfFORECAST_15   CHAR(1) ;
  declare variable xsfFORECAST_16   CHAR(1) ;
  declare variable xsfFORECAST_17   CHAR(1) ;
  declare variable xsfFORECAST_18   CHAR(1) ;
  declare variable xsfFORECAST_19   CHAR(1) ;
  declare variable xsfFORECAST_20   CHAR(1) ;
  declare variable xsfFORECAST_21   CHAR(1) ;
  declare variable xsfFORECAST_22   CHAR(1) ;
  declare variable xsfFORECAST_23   CHAR(1) ;
  declare variable xsfFORECAST_24   CHAR(1) ;
  declare variable xsfFORECAST_25   CHAR(1) ;
  declare variable xsnFORECAST_0    DOUBLE PRECISION;
  declare variable xsnFORECAST_1    DOUBLE PRECISION;
  declare variable xsnFORECAST_2    DOUBLE PRECISION;
  declare variable xsnFORECAST_3    DOUBLE PRECISION;
  declare variable xsnFORECAST_4    DOUBLE PRECISION;
  declare variable xsnFORECAST_5    DOUBLE PRECISION;
  declare variable xsnFORECAST_6    DOUBLE PRECISION;
  declare variable xsnFORECAST_7    DOUBLE PRECISION;
  declare variable xsnFORECAST_8    DOUBLE PRECISION;
  declare variable xsnFORECAST_9    DOUBLE PRECISION;
  declare variable xsnFORECAST_10   DOUBLE PRECISION;
  declare variable xsnFORECAST_11   DOUBLE PRECISION;
  declare variable xsnFORECAST_12   DOUBLE PRECISION;
  declare variable xsnFORECAST_13   DOUBLE PRECISION;
  declare variable xsnFORECAST_14   DOUBLE PRECISION;
  declare variable xsnFORECAST_15   DOUBLE PRECISION;
  declare variable xsnFORECAST_16   DOUBLE PRECISION;
  declare variable xsnFORECAST_17   DOUBLE PRECISION;
  declare variable xsnFORECAST_18   DOUBLE PRECISION;
  declare variable xsnFORECAST_19   DOUBLE PRECISION;
  declare variable xsnFORECAST_20   DOUBLE PRECISION;
  declare variable xsnFORECAST_21   DOUBLE PRECISION;
  declare variable xsnFORECAST_22   DOUBLE PRECISION;
  declare variable xsnFORECAST_23   DOUBLE PRECISION;
  declare variable xsnFORECAST_24   DOUBLE PRECISION;
  declare variable xsnFORECAST_25   DOUBLE PRECISION;
begin
SELECT TypeOfInteger FROM Configuration
  WHERE ConfigurationNo = 100
   Into :xCalendarNo;
Select ItemNo From Item
  Where LocationNo = (Select LocationNO From Location
                      where LocationCode = :SOURCELOCATIONCODE)
  and ProductNo = (Select ProductNo From Product
                    where ProductCode = :SOURCEPRODUCTCODE)
      into :xSourceItem;
Select        sf.FORECAST_0
                , sf.FORECAST_1
                , sf.FORECAST_2
                , sf.FORECAST_3
                , sf.FORECAST_4
                , sf.FORECAST_5
                , sf.FORECAST_6
                , sf.FORECAST_7
                , sf.FORECAST_8
                , sf.FORECAST_9
                , sf.FORECAST_10
                , sf.FORECAST_11
                , sf.FORECAST_12
                , sf.FORECAST_13
                , sf.FORECAST_14
                , sf.FORECAST_15
                , sf.FORECAST_16
                , sf.FORECAST_17
                , sf.FORECAST_18
                , sf.FORECAST_19
                , sf.FORECAST_20
                , sf.FORECAST_21
                , sf.FORECAST_22
                , sf.FORECAST_23
                , sf.FORECAST_24
                , sf.FORECAST_25
                , sn.FORECAST_0
                , sn.FORECAST_1
                , sn.FORECAST_2
                , sn.FORECAST_3
                , sn.FORECAST_4
                , sn.FORECAST_5
                , sn.FORECAST_6
                , sn.FORECAST_7
                , sn.FORECAST_8
                , sn.FORECAST_9
                , sn.FORECAST_10
                , sn.FORECAST_11
                , sn.FORECAST_12
                , sn.FORECAST_13
                , sn.FORECAST_14
                , sn.FORECAST_15
                , sn.FORECAST_16
                , sn.FORECAST_17
                , sn.FORECAST_18
                , sn.FORECAST_19
                , sn.FORECAST_20
                , sn.FORECAST_21
                , sn.FORECAST_22
                , sn.FORECAST_23
                , sn.FORECAST_24
                , sn.FORECAST_25
       From ItemFrozenForecast sf
           , ItemForecast sn
           where sf.itemno = :xSourceItem
           and sn.itemno = :xSourceItem
           and sn.CalendarNo = :xCalendarNo
           and sf.CalendarNo = :xCalendarNo
           and sn.ForecastTypeNo = 1
                Into :xsfFORECAST_0
                , :xsfFORECAST_1
                , :xsfFORECAST_2
                , :xsfFORECAST_3
                , :xsfFORECAST_4
                , :xsfFORECAST_5
                , :xsfFORECAST_6
                , :xsfFORECAST_7
                , :xsfFORECAST_8
                , :xsfFORECAST_9
                , :xsfFORECAST_10
                , :xsfFORECAST_11
                , :xsfFORECAST_12
                , :xsfFORECAST_13
                , :xsfFORECAST_14
                , :xsfFORECAST_15
                , :xsfFORECAST_16
                , :xsfFORECAST_17
                , :xsfFORECAST_18
                , :xsfFORECAST_19
                , :xsfFORECAST_20
                , :xsfFORECAST_21
                , :xsfFORECAST_22
                , :xsfFORECAST_23
                , :xsfFORECAST_24
                , :xsfFORECAST_25
                , :xsnFORECAST_0
                , :xsnFORECAST_1
                , :xsnFORECAST_2
                , :xsnFORECAST_3
                , :xsnFORECAST_4
                , :xsnFORECAST_5
                , :xsnFORECAST_6
                , :xsnFORECAST_7
                , :xsnFORECAST_8
                , :xsnFORECAST_9
                , :xsnFORECAST_10
                , :xsnFORECAST_11
                , :xsnFORECAST_12
                , :xsnFORECAST_13
                , :xsnFORECAST_14
                , :xsnFORECAST_15
                , :xsnFORECAST_16
                , :xsnFORECAST_17
                , :xsnFORECAST_18
                , :xsnFORECAST_19
                , :xsnFORECAST_20
                , :xsnFORECAST_21
                , :xsnFORECAST_22
                , :xsnFORECAST_23
                , :xsnFORECAST_24
                , :xsnFORECAST_25;
          IF (OffSet <= 0) Then
          BEGIN
            IF ((Offset+MonthCount) > 0) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_0 = "Y";
              xsnFORECAST_0 = xsnFORECAST_0 * Perc / 100;
            END
    END
          IF (OffSet <= 1) Then
          BEGIN
            IF ((Offset+MonthCount) > 1) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_1 = "Y";
              xsnFORECAST_1 = xsnFORECAST_1 * Perc / 100;
            END
    END
          IF (OffSet <= 2) Then
          BEGIN
            IF ((Offset+MonthCount) > 2) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_2 = "Y";
              xsnFORECAST_2 = xsnFORECAST_2 * Perc / 100;
            END
    END
          IF (OffSet <= 3) Then
          BEGIN
            IF ((Offset+MonthCount) > 3) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_3 = "Y";
              xsnFORECAST_3 = xsnFORECAST_3 * Perc / 100;
            END
    END
          IF (OffSet <= 4) Then
          BEGIN
            IF ((Offset+MonthCount) > 4) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_4 = "Y";
              xsnFORECAST_4 = xsnFORECAST_4 * Perc / 100;
            END
    END
          IF (OffSet <= 5) Then
          BEGIN
            IF ((Offset+MonthCount) > 5) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_5 = "Y";
              xsnFORECAST_5 = xsnFORECAST_5 * Perc / 100;
            END
    END
          IF (OffSet <= 6) Then
            IF ((Offset+MonthCount) > 6) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_6 = "Y";
              xsnFORECAST_6 = xsnFORECAST_6 * Perc / 100;
            END
          IF (OffSet <= 7) Then
            IF ((Offset+MonthCount) > 7) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_7 = "Y";
              xsnFORECAST_7 = xsnFORECAST_7 * Perc / 100;
            END
          IF (OffSet <= 8) Then
            IF ((Offset+MonthCount) > 8) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_8 = "Y";
              xsnFORECAST_8 = xsnFORECAST_8 * Perc / 100;
            END
          IF (OffSet <= 9) Then
            IF ((Offset+MonthCount) > 9) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_9 = "Y";
              xsnFORECAST_9 = xsnFORECAST_9 * Perc / 100;
            END
          IF (OffSet <= 10) Then
            IF ((Offset+MonthCount) > 10) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_10 = "Y";
              xsnFORECAST_10 = xsnFORECAST_10 * Perc / 100;
            END
          IF (OffSet <= 11) Then
            IF ((Offset+MonthCount) > 11) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_11 = "Y";
              xsnFORECAST_11 = xsnFORECAST_11 * Perc / 100;
            END
          IF (OffSet <= 12) Then
            IF ((Offset+MonthCount) > 12) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_12 = "Y";
              xsnFORECAST_12 = xsnFORECAST_12 * Perc / 100;
            END
          IF (OffSet <= 13) Then
            IF ((Offset+MonthCount) > 13) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_13 = "Y";
              xsnFORECAST_13 = xsnFORECAST_13 * Perc / 100;
            END
          IF (OffSet <= 14) Then
            IF ((Offset+MonthCount) > 14) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_14 = "Y";
              xsnFORECAST_14 = xsnFORECAST_14 * Perc / 100;
            END
          IF (OffSet <= 15) Then
            IF ((Offset+MonthCount) > 15) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_15 = "Y";
              xsnFORECAST_15 = xsnFORECAST_15 * Perc / 100;
            END
          IF (OffSet <= 16) Then
            IF ((Offset+MonthCount) > 16) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_16 = "Y";
              xsnFORECAST_16 = xsnFORECAST_16 * Perc / 100;
            END
          IF (OffSet <= 17) Then
            IF ((Offset+MonthCount) > 17) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_17 = "Y";
              xsnFORECAST_17 = xsnFORECAST_17 * Perc / 100;
            END
          IF (OffSet <= 18) Then
            IF ((Offset+MonthCount) > 18) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_18 = "Y";
              xsnFORECAST_18 = xsnFORECAST_18 * Perc / 100;
            END
          IF (OffSet <= 19) Then
            IF ((Offset+MonthCount) > 19) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_19 = "Y";
              xsnFORECAST_19 = xsnFORECAST_19 * Perc / 100;
            END
          IF (OffSet <= 20) Then
            IF ((Offset+MonthCount) > 20) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_20 = "Y";
              xsnFORECAST_20 = xsnFORECAST_20 * Perc / 100;
            END
          IF (OffSet <= 21) Then
            IF ((Offset+MonthCount) > 21) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_21 = "Y";
              xsnFORECAST_21 = xsnFORECAST_21 * Perc / 100;
            END
          IF (OffSet <= 22) Then
            IF ((Offset+MonthCount) > 22) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_22 = "Y";
              xsnFORECAST_22 = xsnFORECAST_22 * Perc / 100;
            END
          IF (OffSet <= 23) Then
            IF ((Offset+MonthCount) > 23) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_23 = "Y";
              xsnFORECAST_23 = xsnFORECAST_23 * Perc / 100;
            END
          IF (OffSet <= 24) Then
            IF ((Offset+MonthCount) > 24) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_24 = "Y";
              xsnFORECAST_24 = xsnFORECAST_24 * Perc / 100;
            END
          /*Support 24 Month Parameter */
          IF (OffSet <= 24) Then
            IF ((Offset+MonthCount) > 24) Then
            BEGIN
              IF (FreezeInd = "Y") Then
                xsfFORECAST_25 = "Y";
              xsnFORECAST_25 = xsnFORECAST_25 * Perc / 100;
            END
          Update ItemFrozenForecast
          Set FORECAST_0      = :xsfFORECAST_0
                , FORECAST_1      = :xsfFORECAST_1
                , FORECAST_2      = :xsfFORECAST_2
                , FORECAST_3      = :xsfFORECAST_3
                , FORECAST_4      = :xsfFORECAST_4
                , FORECAST_5      = :xsfFORECAST_5
                , FORECAST_6      = :xsfFORECAST_6
                , FORECAST_7      = :xsfFORECAST_7
                , FORECAST_8      = :xsfFORECAST_8
                , FORECAST_9      = :xsfFORECAST_9
                , FORECAST_10     = :xsfFORECAST_10
                , FORECAST_11     = :xsfFORECAST_11
                , FORECAST_12     = :xsfFORECAST_12
                , FORECAST_13     = :xsfFORECAST_13
                , FORECAST_14     = :xsfFORECAST_14
                , FORECAST_15     = :xsfFORECAST_15
                , FORECAST_16     = :xsfFORECAST_16
                , FORECAST_17     = :xsfFORECAST_17
                , FORECAST_18     = :xsfFORECAST_18
                , FORECAST_19     = :xsfFORECAST_19
                , FORECAST_20     = :xsfFORECAST_20
                , FORECAST_21     = :xsfFORECAST_21
                , FORECAST_22     = :xsfFORECAST_22
                , FORECAST_23     = :xsfFORECAST_23
                , FORECAST_24     = :xsfFORECAST_24
                , FORECAST_25     = :xsfFORECAST_25
                where ItemNo = :xSourceItem
                        and CalendarNo = :xCalendarNo;
          Update ItemForecast
          Set FORECAST_0      = :xsnFORECAST_0
                , FORECAST_1      = :xsnFORECAST_1
                , FORECAST_2      = :xsnFORECAST_2
                , FORECAST_3      = :xsnFORECAST_3
                , FORECAST_4      = :xsnFORECAST_4
                , FORECAST_5      = :xsnFORECAST_5
                , FORECAST_6      = :xsnFORECAST_6
                , FORECAST_7      = :xsnFORECAST_7
                , FORECAST_8      = :xsnFORECAST_8
                , FORECAST_9      = :xsnFORECAST_9
                , FORECAST_10     = :xsnFORECAST_10
                , FORECAST_11     = :xsnFORECAST_11
                , FORECAST_12     = :xsnFORECAST_12
                , FORECAST_13     = :xsnFORECAST_13
                , FORECAST_14     = :xsnFORECAST_14
                , FORECAST_15     = :xsnFORECAST_15
                , FORECAST_16     = :xsnFORECAST_16
                , FORECAST_17     = :xsnFORECAST_17
                , FORECAST_18     = :xsnFORECAST_18
                , FORECAST_19     = :xsnFORECAST_19
                , FORECAST_20     = :xsnFORECAST_20
                , FORECAST_21     = :xsnFORECAST_21
                , FORECAST_22     = :xsnFORECAST_22
                , FORECAST_23     = :xsnFORECAST_23
                , FORECAST_24     = :xsnFORECAST_24
                , FORECAST_25     = :xsnFORECAST_25
                where ItemNo = :xSourceItem
                        and CalendarNo = :xCalendarNo
                        and ForecastTypeNo = 1;
end
