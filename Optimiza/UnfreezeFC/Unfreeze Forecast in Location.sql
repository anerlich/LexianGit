create procedure up_unfreezefc (SOURCELOCATIONCODE varchar(10), SOURCEPRODUCTCODE varchar(30),
 MONTHCOUNT integer, OFFSET integer)
as
declare variable xSourceItem      Integer;
  declare variable xLocationNo      Integer;
  declare variable xProductNo       Integer;
  declare variable xCalendarNo      integer;
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

      Select     sf.FORECAST_0
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
       From ItemFrozenForecast sf
           where sf.itemno = :xSourceItem
           and sf.CalendarNo = :xCalendarNo
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
                , :xsfFORECAST_25;

          IF (OffSet <= 0) Then
          BEGIN
            IF ((Offset+MonthCount) > 0) Then
            BEGIN
                xsfFORECAST_0 = "N";
            END
          END
          
          IF (OffSet <= 1) Then
          BEGIN
            IF ((Offset+MonthCount) > 1) Then
            BEGIN
                xsfFORECAST_1 = "N";
            END
          END

          IF (OffSet <= 2) Then
          BEGIN
            IF ((Offset+MonthCount) > 2) Then
            BEGIN
                xsfFORECAST_2 = "N";
            END
          END
          IF (OffSet <= 3) Then
          BEGIN
            IF ((Offset+MonthCount) > 3) Then
            BEGIN
                xsfFORECAST_3 = "N";
            
            END
          END
          
          IF (OffSet <= 4) Then
          BEGIN
            IF ((Offset+MonthCount) > 4) Then
            BEGIN
                xsfFORECAST_4 = "N";
       
            END
          END
          
          IF (OffSet <= 5) Then
          BEGIN
            IF ((Offset+MonthCount) > 5) Then
            BEGIN
                xsfFORECAST_5 = "N";
            END
          END
          
          IF (OffSet <= 6) Then
            IF ((Offset+MonthCount) > 6) Then
            BEGIN
            
                xsfFORECAST_6 = "N";
            END
          IF (OffSet <= 7) Then
            IF ((Offset+MonthCount) > 7) Then
            BEGIN
                xsfFORECAST_7 = "N";
            END
          IF (OffSet <= 8) Then
            IF ((Offset+MonthCount) > 8) Then
            BEGIN
                xsfFORECAST_8 = "N";
            END
          IF (OffSet <= 9) Then
            IF ((Offset+MonthCount) > 9) Then
            BEGIN
                xsfFORECAST_9 = "N";
            END
          IF (OffSet <= 10) Then
            IF ((Offset+MonthCount) > 10) Then
            BEGIN
                xsfFORECAST_10 = "N";
            END
          IF (OffSet <= 11) Then
            IF ((Offset+MonthCount) > 11) Then
            BEGIN
                xsfFORECAST_11 = "N";
            END
          IF (OffSet <= 12) Then
            IF ((Offset+MonthCount) > 12) Then
            BEGIN
                xsfFORECAST_12 = "N";
            END
          IF (OffSet <= 13) Then
            IF ((Offset+MonthCount) > 13) Then
            BEGIN
                xsfFORECAST_13 = "N";
            END
          IF (OffSet <= 14) Then
            IF ((Offset+MonthCount) > 14) Then
            BEGIN
                xsfFORECAST_14 = "N";
            END
          IF (OffSet <= 15) Then
            IF ((Offset+MonthCount) > 15) Then
            BEGIN
                xsfFORECAST_15 = "N";
            END
          IF (OffSet <= 16) Then
            IF ((Offset+MonthCount) > 16) Then
            BEGIN
                xsfFORECAST_16 = "N";
            END
          IF (OffSet <= 17) Then
            IF ((Offset+MonthCount) > 17) Then
            BEGIN
                xsfFORECAST_17 = "N";
            END
          IF (OffSet <= 18) Then
            IF ((Offset+MonthCount) > 18) Then
            BEGIN
                xsfFORECAST_18 = "N";
            END
          IF (OffSet <= 19) Then
            IF ((Offset+MonthCount) > 19) Then
            BEGIN
                xsfFORECAST_19 = "N";
            END
          IF (OffSet <= 20) Then
            IF ((Offset+MonthCount) > 20) Then
            BEGIN
                xsfFORECAST_20 = "N";
            END
          IF (OffSet <= 21) Then
            IF ((Offset+MonthCount) > 21) Then
            BEGIN
                xsfFORECAST_21 = "N";
            END
          IF (OffSet <= 22) Then
            IF ((Offset+MonthCount) > 22) Then
            BEGIN
                xsfFORECAST_22 = "N";
            END
          IF (OffSet <= 23) Then
            IF ((Offset+MonthCount) > 23) Then
            BEGIN
                xsfFORECAST_23 = "N";
            END
          
          IF (OffSet <= 24) Then
            IF ((Offset+MonthCount) > 24) Then
            BEGIN
                xsfFORECAST_24 = "N";
            END
          
          /*Support 24 Month Parameter */
          IF (OffSet <= 24) Then
            IF ((Offset+MonthCount) > 24) Then
            BEGIN
                xsfFORECAST_25 = "N";
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
end
