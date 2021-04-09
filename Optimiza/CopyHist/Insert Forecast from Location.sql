Set Term !! ;

Create Procedure UP_AddFC(
 SOURCELOCATIONCODE VARCHAR(10),
  TARGETLOCATIONCODE VARCHAR(10) )
as
  declare variable xSourceLocationNo integer;
  declare variable xTargetLocationNo integer;
  declare variable xItemNo       Integer;
  declare variable xNewItemNo       Integer;
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

  declare variable xtfFORECAST_0    CHAR(1) ;
  declare variable xtfFORECAST_1    CHAR(1) ;
  declare variable xtfFORECAST_2    CHAR(1) ;
  declare variable xtfFORECAST_3    CHAR(1) ;
  declare variable xtfFORECAST_4    CHAR(1) ;
  declare variable xtfFORECAST_5    CHAR(1) ;
  declare variable xtfFORECAST_6    CHAR(1) ;
  declare variable xtfFORECAST_7    CHAR(1) ;
  declare variable xtfFORECAST_8    CHAR(1) ;
  declare variable xtfFORECAST_9    CHAR(1) ;
  declare variable xtfFORECAST_10   CHAR(1) ;
  declare variable xtfFORECAST_11   CHAR(1) ;
  declare variable xtfFORECAST_12   CHAR(1) ;
  declare variable xtfFORECAST_13   CHAR(1) ;
  declare variable xtfFORECAST_14   CHAR(1) ;
  declare variable xtfFORECAST_15   CHAR(1) ;
  declare variable xtfFORECAST_16   CHAR(1) ;
  declare variable xtfFORECAST_17   CHAR(1) ;
  declare variable xtfFORECAST_18   CHAR(1) ;
  declare variable xtfFORECAST_19   CHAR(1) ;
  declare variable xtfFORECAST_20   CHAR(1) ;
  declare variable xtfFORECAST_21   CHAR(1) ;
  declare variable xtfFORECAST_22   CHAR(1) ;
  declare variable xtfFORECAST_23   CHAR(1) ;
  declare variable xtfFORECAST_24   CHAR(1) ;
  declare variable xtfFORECAST_25   CHAR(1) ;

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

  declare variable xtnFORECAST_0    DOUBLE PRECISION;
  declare variable xtnFORECAST_1    DOUBLE PRECISION;
  declare variable xtnFORECAST_2    DOUBLE PRECISION;
  declare variable xtnFORECAST_3    DOUBLE PRECISION;
  declare variable xtnFORECAST_4    DOUBLE PRECISION;
  declare variable xtnFORECAST_5    DOUBLE PRECISION;
  declare variable xtnFORECAST_6    DOUBLE PRECISION;
  declare variable xtnFORECAST_7    DOUBLE PRECISION;
  declare variable xtnFORECAST_8    DOUBLE PRECISION;
  declare variable xtnFORECAST_9    DOUBLE PRECISION;
  declare variable xtnFORECAST_10   DOUBLE PRECISION;
  declare variable xtnFORECAST_11   DOUBLE PRECISION;
  declare variable xtnFORECAST_12   DOUBLE PRECISION;
  declare variable xtnFORECAST_13   DOUBLE PRECISION;
  declare variable xtnFORECAST_14   DOUBLE PRECISION;
  declare variable xtnFORECAST_15   DOUBLE PRECISION;
  declare variable xtnFORECAST_16   DOUBLE PRECISION;
  declare variable xtnFORECAST_17   DOUBLE PRECISION;
  declare variable xtnFORECAST_18   DOUBLE PRECISION;
  declare variable xtnFORECAST_19   DOUBLE PRECISION;
  declare variable xtnFORECAST_20   DOUBLE PRECISION;
  declare variable xtnFORECAST_21   DOUBLE PRECISION;
  declare variable xtnFORECAST_22   DOUBLE PRECISION;
  declare variable xtnFORECAST_23   DOUBLE PRECISION;
  declare variable xtnFORECAST_24   DOUBLE PRECISION;
  declare variable xtnFORECAST_25   DOUBLE PRECISION;

begin

SELECT TypeOfInteger FROM Configuration
  WHERE ConfigurationNo = 100
   Into :xCalendarNo;


Select LocationNO From Location where LocationCode =
      :TARGETLOCATIONCODE
      into :xTargetLocationNo;
  Select LocationNO From Location where LocationCode =
      :SOURCELOCATIONCODE
      into :xSourceLocationNo;

For Select i.Itemno, i2.ItemNo
                , sf.FORECAST_0
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

                , tf.FORECAST_0
                , tf.FORECAST_1
                , tf.FORECAST_2
                , tf.FORECAST_3
                , tf.FORECAST_4
                , tf.FORECAST_5
                , tf.FORECAST_6
                , tf.FORECAST_7
                , tf.FORECAST_8
                , tf.FORECAST_9
                , tf.FORECAST_10
                , tf.FORECAST_11
                , tf.FORECAST_12
                , tf.FORECAST_13
                , tf.FORECAST_14
                , tf.FORECAST_15
                , tf.FORECAST_16
                , tf.FORECAST_17
                , tf.FORECAST_18
                , tf.FORECAST_19
                , tf.FORECAST_20
                , tf.FORECAST_21
                , tf.FORECAST_22
                , tf.FORECAST_23
                , tf.FORECAST_24
                , tf.FORECAST_25

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

                , tn.FORECAST_0
                , tn.FORECAST_1
                , tn.FORECAST_2
                , tn.FORECAST_3
                , tn.FORECAST_4
                , tn.FORECAST_5
                , tn.FORECAST_6
                , tn.FORECAST_7
                , tn.FORECAST_8
                , tn.FORECAST_9
                , tn.FORECAST_10
                , tn.FORECAST_11
                , tn.FORECAST_12
                , tn.FORECAST_13
                , tn.FORECAST_14
                , tn.FORECAST_15
                , tn.FORECAST_16
                , tn.FORECAST_17
                , tn.FORECAST_18
                , tn.FORECAST_19
                , tn.FORECAST_20
                , tn.FORECAST_21
                , tn.FORECAST_22
                , tn.FORECAST_23
                , tn.FORECAST_24
                , tn.FORECAST_25

       From Item i
           , item i2
           , ItemFrozenForecast sf
           , ItemFrozenForecast tf
           , ItemForecast sn
           , ItemForecast tn
           where i.locationno = :xSourceLocationNo
           and i2.locationno = :xTargetLocationNo
           and i2.productno = i.productno
           and i.itemno = sf.itemno
           and i2.itemno = tf.itemno
           and i.itemno = sn.itemno
           and i2.itemno = tn.itemno
           and sn.CalendarNo = :xCalendarNo
           and tn.CalendarNo = :xCalendarNo
           and sf.CalendarNo = :xCalendarNo
           and tf.CalendarNo = :xCalendarNo
           and sn.ForecastTypeNo = 1
           and tn.ForecastTypeNo = 1



                Into :xItemNo, :xNewItemNo
                , :xsfFORECAST_0
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

                , :xtfFORECAST_0
                , :xtfFORECAST_1
                , :xtfFORECAST_2
                , :xtfFORECAST_3
                , :xtfFORECAST_4
                , :xtfFORECAST_5
                , :xtfFORECAST_6
                , :xtfFORECAST_7
                , :xtfFORECAST_8
                , :xtfFORECAST_9
                , :xtfFORECAST_10
                , :xtfFORECAST_11
                , :xtfFORECAST_12
                , :xtfFORECAST_13
                , :xtfFORECAST_14
                , :xtfFORECAST_15
                , :xtfFORECAST_16
                , :xtfFORECAST_17
                , :xtfFORECAST_18
                , :xtfFORECAST_19
                , :xtfFORECAST_20
                , :xtfFORECAST_21
                , :xtfFORECAST_22
                , :xtfFORECAST_23
                , :xtfFORECAST_24
                , :xtfFORECAST_25

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
                , :xsnFORECAST_25

                , :xtnFORECAST_0
                , :xtnFORECAST_1
                , :xtnFORECAST_2
                , :xtnFORECAST_3
                , :xtnFORECAST_4
                , :xtnFORECAST_5
                , :xtnFORECAST_6
                , :xtnFORECAST_7
                , :xtnFORECAST_8
                , :xtnFORECAST_9
                , :xtnFORECAST_10
                , :xtnFORECAST_11
                , :xtnFORECAST_12
                , :xtnFORECAST_13
                , :xtnFORECAST_14
                , :xtnFORECAST_15
                , :xtnFORECAST_16
                , :xtnFORECAST_17
                , :xtnFORECAST_18
                , :xtnFORECAST_19
                , :xtnFORECAST_20
                , :xtnFORECAST_21
                , :xtnFORECAST_22
                , :xtnFORECAST_23
                , :xtnFORECAST_24
                , :xtnFORECAST_25

        Do Begin
          IF (xsfFORECAST_0 = "Y") Then
          begin
                xtnFORECAST_0 = xtnFORECAST_0 + xsnFORECAST_0;
                xtfFORECAST_0 = "Y";
          end
          IF (xsfFORECAST_1 = "Y") Then
          begin
                xtnFORECAST_1 = xtnFORECAST_1 + xsnFORECAST_1;
                xtfFORECAST_1 = "Y";
          end
          IF (xsfFORECAST_2 = "Y") Then
          begin
                xtnFORECAST_2 = xtnFORECAST_2 + xsnFORECAST_2;
                xtfFORECAST_2 = "Y";
          end
          IF (xsfFORECAST_3 = "Y") Then
          begin
                xtnFORECAST_3 = xtnFORECAST_3 + xsnFORECAST_3;
                xtfFORECAST_3 = "Y";
          end
          IF (xsfFORECAST_4 = "Y") Then
          begin
                xtnFORECAST_4 = xtnFORECAST_4 + xsnFORECAST_4;
                xtfFORECAST_4 = "Y";
          end
          IF (xsfFORECAST_5 = "Y") Then
          begin
                xtnFORECAST_5 = xtnFORECAST_5 + xsnFORECAST_5;
                xtfFORECAST_5 = "Y";
          end
          IF (xsfFORECAST_6 = "Y") Then
          begin
                xtnFORECAST_6 = xtnFORECAST_6 + xsnFORECAST_6;
                xtfFORECAST_6 = "Y";
          end
          IF (xsfFORECAST_7 = "Y") Then
          begin
                xtnFORECAST_7 = xtnFORECAST_7 + xsnFORECAST_7;
                xtfFORECAST_7 = "Y";
          end
          IF (xsfFORECAST_8 = "Y") Then
          begin
                xtnFORECAST_8 = xtnFORECAST_8 + xsnFORECAST_8;
                xtfFORECAST_8 = "Y";
          end
          IF (xsfFORECAST_9 = "Y") Then
          begin
                xtnFORECAST_9 = xtnFORECAST_9 + xsnFORECAST_9;
                xtfFORECAST_9 = "Y";
          end
          IF (xsfFORECAST_10 = "Y") Then
          begin
                xtnFORECAST_10 = xtnFORECAST_10 + xsnFORECAST_10;
                xtfFORECAST_10 = "Y";
          end
          IF (xsfFORECAST_11 = "Y") Then
          begin
                xtnFORECAST_11 = xtnFORECAST_11 + xsnFORECAST_11;
                xtfFORECAST_11 = "Y";
          end
          IF (xsfFORECAST_12 = "Y") Then
          begin
                xtnFORECAST_12 = xtnFORECAST_12 + xsnFORECAST_12;
                xtfFORECAST_12 = "Y";
          end
          IF (xsfFORECAST_13 = "Y") Then
          begin
                xtnFORECAST_13 = xtnFORECAST_13 + xsnFORECAST_13;
                xtfFORECAST_13 = "Y";
          end
          IF (xsfFORECAST_14 = "Y") Then
          begin
                xtnFORECAST_14 = xtnFORECAST_14 + xsnFORECAST_14;
                xtfFORECAST_10 = "Y";
          end
          IF (xsfFORECAST_15 = "Y") Then
          begin
                xtnFORECAST_15 = xtnFORECAST_15 + xsnFORECAST_15;
                xtfFORECAST_15 = "Y";
          end
          IF (xsfFORECAST_16 = "Y") Then
          begin
                xtnFORECAST_16 = xtnFORECAST_16 + xsnFORECAST_16;
                xtfFORECAST_16 = "Y";
          end
          IF (xsfFORECAST_17 = "Y") Then
          begin
                xtnFORECAST_17 = xtnFORECAST_17 + xsnFORECAST_17;
                xtfFORECAST_17 = "Y";
          end
          IF (xsfFORECAST_18 = "Y") Then
          begin
                xtnFORECAST_18 = xtnFORECAST_18 + xsnFORECAST_18;
                xtfFORECAST_18 = "Y";
          end
          IF (xsfFORECAST_19 = "Y") Then
          begin
                xtnFORECAST_19 = xtnFORECAST_19 + xsnFORECAST_19;
                xtfFORECAST_19 = "Y";
          end
          IF (xsfFORECAST_20 = "Y") Then
          begin
                xtnFORECAST_20 = xtnFORECAST_20 + xsnFORECAST_20;
                xtfFORECAST_20 = "Y";
          end
          IF (xsfFORECAST_21 = "Y") Then
          begin
                xtnFORECAST_21 = xtnFORECAST_21 + xsnFORECAST_21;
                xtfFORECAST_21 = "Y";
          end
          IF (xsfFORECAST_22 = "Y") Then
          begin
                xtnFORECAST_22 = xtnFORECAST_22 + xsnFORECAST_22;
                xtfFORECAST_22 = "Y";
          end
          IF (xsfFORECAST_23 = "Y") Then
          begin
                xtnFORECAST_23 = xtnFORECAST_23 + xsnFORECAST_23;
                xtfFORECAST_23 = "Y";
          end
          IF (xsfFORECAST_24 = "Y") Then
          begin
                xtnFORECAST_24 = xtnFORECAST_24 + xsnFORECAST_24;
                xtfFORECAST_24 = "Y";
          end
          IF (xsfFORECAST_25 = "Y") Then
          begin
                xtnFORECAST_25 = xtnFORECAST_25 + xsnFORECAST_25;
                xtfFORECAST_25 = "Y";
          end

          Update ItemFrozenForecast
          Set FORECAST_0      = :xtfFORECAST_0
                , FORECAST_1      = :xtfFORECAST_1
                , FORECAST_2      = :xtfFORECAST_2
                , FORECAST_3      = :xtfFORECAST_3
                , FORECAST_4      = :xtfFORECAST_4
                , FORECAST_5      = :xtfFORECAST_5
                , FORECAST_6      = :xtfFORECAST_6
                , FORECAST_7      = :xtfFORECAST_7
                , FORECAST_8      = :xtfFORECAST_8
                , FORECAST_9      = :xtfFORECAST_9
                , FORECAST_10     = :xtfFORECAST_10
                , FORECAST_11     = :xtfFORECAST_11
                , FORECAST_12     = :xtfFORECAST_12
                , FORECAST_13     = :xtfFORECAST_13
                , FORECAST_14     = :xtfFORECAST_14
                , FORECAST_15     = :xtfFORECAST_15
                , FORECAST_16     = :xtfFORECAST_16
                , FORECAST_17     = :xtfFORECAST_17
                , FORECAST_18     = :xtfFORECAST_18
                , FORECAST_19     = :xtfFORECAST_19
                , FORECAST_20     = :xtfFORECAST_20
                , FORECAST_21     = :xtfFORECAST_21
                , FORECAST_22     = :xtfFORECAST_22
                , FORECAST_23     = :xtfFORECAST_23
                , FORECAST_24     = :xtfFORECAST_24
                , FORECAST_25     = :xtfFORECAST_25

                where ItemNo = :xNewItemNo
                        and CalendarNo = :xCalendarNo;

          Update ItemForecast
          Set FORECAST_0      = :xtnFORECAST_0
                , FORECAST_1      = :xtnFORECAST_1
                , FORECAST_2      = :xtnFORECAST_2
                , FORECAST_3      = :xtnFORECAST_3
                , FORECAST_4      = :xtnFORECAST_4
                , FORECAST_5      = :xtnFORECAST_5
                , FORECAST_6      = :xtnFORECAST_6
                , FORECAST_7      = :xtnFORECAST_7
                , FORECAST_8      = :xtnFORECAST_8
                , FORECAST_9      = :xtnFORECAST_9
                , FORECAST_10     = :xtnFORECAST_10
                , FORECAST_11     = :xtnFORECAST_11
                , FORECAST_12     = :xtnFORECAST_12
                , FORECAST_13     = :xtnFORECAST_13
                , FORECAST_14     = :xtnFORECAST_14
                , FORECAST_15     = :xtnFORECAST_15
                , FORECAST_16     = :xtnFORECAST_16
                , FORECAST_17     = :xtnFORECAST_17
                , FORECAST_18     = :xtnFORECAST_18
                , FORECAST_19     = :xtnFORECAST_19
                , FORECAST_20     = :xtnFORECAST_20
                , FORECAST_21     = :xtnFORECAST_21
                , FORECAST_22     = :xtnFORECAST_22
                , FORECAST_23     = :xtnFORECAST_23
                , FORECAST_24     = :xtnFORECAST_24
                , FORECAST_25     = :xtnFORECAST_25

                where ItemNo = :xNewItemNo
                        and CalendarNo = :xCalendarNo
                        and ForecastTypeNo = 1;

        end


end!!

Set Term ; !!
