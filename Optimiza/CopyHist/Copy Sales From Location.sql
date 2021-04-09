Set Term !! ;

Create Procedure UP_CopySales(
 SOURCELOCATIONCODE VARCHAR(10),
  TARGETLOCATIONCODE VARCHAR(10),
 SOURCEPRODUCTCODE VARCHAR(30),
  TARGETPRODUCTCODE VARCHAR(30) )
as
  declare variable xSourceLocationNo integer;
  declare variable xTargetLocationNo integer;
  declare variable xSourceItemNo integer;
  declare variable xTargetItemNo integer;
  declare variable xSourceAge integer;
  declare variable xTargetAge integer;
  declare variable xSALESAMOUNT_0         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_1         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_2         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_3         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_4         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_5         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_6         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_7         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_8         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_9         DOUBLE PRECISION;
  declare variable xSALESAMOUNT_10        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_11        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_12        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_13        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_14        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_15        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_16        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_17        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_18        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_19        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_20        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_21        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_22        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_23        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_24        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_25        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_26        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_27        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_28        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_29        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_30        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_31        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_32        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_33        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_34        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_35        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_36        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_37        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_38        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_39        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_40        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_41        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_42        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_43        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_44        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_45        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_46        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_47        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_48        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_49        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_50        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_51        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_52        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_53        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_54        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_55        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_56        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_57        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_58        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_59        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_60        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_61        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_62        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_63        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_64        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_65        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_66        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_67        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_68        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_69        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_70        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_71        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_72        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_73        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_74        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_75        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_76        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_77        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_78        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_79        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_80        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_81        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_82        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_83        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_84        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_85        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_86        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_87        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_88        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_89        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_90        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_91        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_92        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_93        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_94        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_95        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_96        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_97        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_98        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_99        DOUBLE PRECISION;
  declare variable xSALESAMOUNT_100       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_101       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_102       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_103       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_104       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_105       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_106       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_107       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_108       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_109       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_110       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_111       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_112       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_113       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_114       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_115       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_116       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_117       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_118       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_119       DOUBLE PRECISION;
  declare variable xSALESAMOUNT_120       DOUBLE PRECISION;

begin
 Select LocationNO From Location where LocationCode =
      :TARGETLOCATIONCODE
      into :xTargetLocationNo;
  Select LocationNO From Location where LocationCode =
      :SOURCELOCATIONCODE
      into :xSourceLocationNo;

Select ItemNo, Age From Item where locationno = :xSourceLocationNo
           and productno = (Select ProductNO From Product where ProductCode =
      :SOURCEPRODUCTCODE)
      into :xSourceItemNo, :xSourceAge;

Select ItemNo, Age From Item where locationno = :xTargetLocationNo
           and productno = (Select ProductNO From Product where ProductCode =
      :TARGETPRODUCTCODE)
      into :xTargetItemNo, :xTargetAge;

IF (xSourceAge > xTargetAge) Then
begin
  xTargetAge = xSourceAge;
end

For Select s.SALESAMOUNT_0
        , s.SALESAMOUNT_1
        , s.SALESAMOUNT_2
        , s.SALESAMOUNT_3
        , s.SALESAMOUNT_4
        , s.SALESAMOUNT_5
        , s.SALESAMOUNT_6
        , s.SALESAMOUNT_7
        , s.SALESAMOUNT_8
        , s.SALESAMOUNT_9
        , s.SALESAMOUNT_10
        , s.SALESAMOUNT_11
        , s.SALESAMOUNT_12
        , s.SALESAMOUNT_13
        , s.SALESAMOUNT_14
        , s.SALESAMOUNT_15
        , s.SALESAMOUNT_16
        , s.SALESAMOUNT_17
        , s.SALESAMOUNT_18
        , s.SALESAMOUNT_19
        , s.SALESAMOUNT_20
        , s.SALESAMOUNT_21
        , s.SALESAMOUNT_22
        , s.SALESAMOUNT_23
        , s.SALESAMOUNT_24
        , s.SALESAMOUNT_25
        , s.SALESAMOUNT_26
        , s.SALESAMOUNT_27
        , s.SALESAMOUNT_28
        , s.SALESAMOUNT_29
        , s.SALESAMOUNT_30
        , s.SALESAMOUNT_31
        , s.SALESAMOUNT_32
        , s.SALESAMOUNT_33
        , s.SALESAMOUNT_34
        , s.SALESAMOUNT_35
        , s.SALESAMOUNT_36
        , s.SALESAMOUNT_37
        , s.SALESAMOUNT_38
        , s.SALESAMOUNT_39
        , s.SALESAMOUNT_40
        , s.SALESAMOUNT_41
        , s.SALESAMOUNT_42
        , s.SALESAMOUNT_43
        , s.SALESAMOUNT_44
        , s.SALESAMOUNT_45
        , s.SALESAMOUNT_46
        , s.SALESAMOUNT_47
        , s.SALESAMOUNT_48
        , s.SALESAMOUNT_49
        , s.SALESAMOUNT_50
        , s.SALESAMOUNT_51
        , s.SALESAMOUNT_52
        , s.SALESAMOUNT_53
        , s.SALESAMOUNT_54
        , s.SALESAMOUNT_55
        , s.SALESAMOUNT_56
        , s.SALESAMOUNT_57
        , s.SALESAMOUNT_58
        , s.SALESAMOUNT_59
        , s.SALESAMOUNT_60
        , s.SALESAMOUNT_61
        , s.SALESAMOUNT_62
        , s.SALESAMOUNT_63
        , s.SALESAMOUNT_64
        , s.SALESAMOUNT_65
        , s.SALESAMOUNT_66
        , s.SALESAMOUNT_67
        , s.SALESAMOUNT_68
        , s.SALESAMOUNT_69
        , s.SALESAMOUNT_70
        , s.SALESAMOUNT_71
        , s.SALESAMOUNT_72
        , s.SALESAMOUNT_73
        , s.SALESAMOUNT_74
        , s.SALESAMOUNT_75
        , s.SALESAMOUNT_76
        , s.SALESAMOUNT_77
        , s.SALESAMOUNT_78
        , s.SALESAMOUNT_80
        , s.SALESAMOUNT_81
        , s.SALESAMOUNT_82
        , s.SALESAMOUNT_83
        , s.SALESAMOUNT_84
        , s.SALESAMOUNT_85
        , s.SALESAMOUNT_86
        , s.SALESAMOUNT_87
        , s.SALESAMOUNT_88
        , s.SALESAMOUNT_89
        , s.SALESAMOUNT_90
        , s.SALESAMOUNT_91
        , s.SALESAMOUNT_92
        , s.SALESAMOUNT_93
        , s.SALESAMOUNT_94
        , s.SALESAMOUNT_95
        , s.SALESAMOUNT_96
        , s.SALESAMOUNT_97
        , s.SALESAMOUNT_98
        , s.SALESAMOUNT_99
        , s.SALESAMOUNT_100
        , s.SALESAMOUNT_101
        , s.SALESAMOUNT_102
        , s.SALESAMOUNT_103
        , s.SALESAMOUNT_104
        , s.SALESAMOUNT_105
        , s.SALESAMOUNT_106
        , s.SALESAMOUNT_107
        , s.SALESAMOUNT_108
        , s.SALESAMOUNT_109
        , s.SALESAMOUNT_110
        , s.SALESAMOUNT_111
        , s.SALESAMOUNT_112
        , s.SALESAMOUNT_113
        , s.SALESAMOUNT_114
        , s.SALESAMOUNT_115
        , s.SALESAMOUNT_116
        , s.SALESAMOUNT_117
        , s.SALESAMOUNT_118
        , s.SALESAMOUNT_119
        , s.SALESAMOUNT_120

       From ItemSales s
            where s.ItemNo = :xSourceItemNo

        Into
          :xSALESAMOUNT_0
        , :xSALESAMOUNT_1
        , :xSALESAMOUNT_2
        , :xSALESAMOUNT_3
        , :xSALESAMOUNT_4
        , :xSALESAMOUNT_5
        , :xSALESAMOUNT_6
        , :xSALESAMOUNT_7
        , :xSALESAMOUNT_8
        , :xSALESAMOUNT_9
        , :xSALESAMOUNT_10
        , :xSALESAMOUNT_11
        , :xSALESAMOUNT_12
        , :xSALESAMOUNT_13
        , :xSALESAMOUNT_14
        , :xSALESAMOUNT_15
        , :xSALESAMOUNT_16
        , :xSALESAMOUNT_17
        , :xSALESAMOUNT_18
        , :xSALESAMOUNT_19
        , :xSALESAMOUNT_20
        , :xSALESAMOUNT_21
        , :xSALESAMOUNT_22
        , :xSALESAMOUNT_23
        , :xSALESAMOUNT_24
        , :xSALESAMOUNT_25
        , :xSALESAMOUNT_26
        , :xSALESAMOUNT_27
        , :xSALESAMOUNT_28
        , :xSALESAMOUNT_29
        , :xSALESAMOUNT_30
        , :xSALESAMOUNT_31
        , :xSALESAMOUNT_32
        , :xSALESAMOUNT_33
        , :xSALESAMOUNT_34
        , :xSALESAMOUNT_35
        , :xSALESAMOUNT_36
        , :xSALESAMOUNT_37
        , :xSALESAMOUNT_38
        , :xSALESAMOUNT_39
        , :xSALESAMOUNT_40
        , :xSALESAMOUNT_41
        , :xSALESAMOUNT_42
        , :xSALESAMOUNT_43
        , :xSALESAMOUNT_44
        , :xSALESAMOUNT_45
        , :xSALESAMOUNT_46
        , :xSALESAMOUNT_47
        , :xSALESAMOUNT_48
        , :xSALESAMOUNT_49
        , :xSALESAMOUNT_50
        , :xSALESAMOUNT_51
        , :xSALESAMOUNT_52
        , :xSALESAMOUNT_53
        , :xSALESAMOUNT_54
        , :xSALESAMOUNT_55
        , :xSALESAMOUNT_56
        , :xSALESAMOUNT_57
        , :xSALESAMOUNT_58
        , :xSALESAMOUNT_59
        , :xSALESAMOUNT_60
        , :xSALESAMOUNT_61
        , :xSALESAMOUNT_62
        , :xSALESAMOUNT_63
        , :xSALESAMOUNT_64
        , :xSALESAMOUNT_65
        , :xSALESAMOUNT_66
        , :xSALESAMOUNT_67
        , :xSALESAMOUNT_68
        , :xSALESAMOUNT_69
        , :xSALESAMOUNT_70
        , :xSALESAMOUNT_71
        , :xSALESAMOUNT_72
        , :xSALESAMOUNT_73
        , :xSALESAMOUNT_74
        , :xSALESAMOUNT_75
        , :xSALESAMOUNT_76
        , :xSALESAMOUNT_77
        , :xSALESAMOUNT_78
        , :xSALESAMOUNT_80
        , :xSALESAMOUNT_81
        , :xSALESAMOUNT_82
        , :xSALESAMOUNT_83
        , :xSALESAMOUNT_84
        , :xSALESAMOUNT_85
        , :xSALESAMOUNT_86
        , :xSALESAMOUNT_87
        , :xSALESAMOUNT_88
        , :xSALESAMOUNT_89
        , :xSALESAMOUNT_90
        , :xSALESAMOUNT_91
        , :xSALESAMOUNT_92
        , :xSALESAMOUNT_93
        , :xSALESAMOUNT_94
        , :xSALESAMOUNT_95
        , :xSALESAMOUNT_96
        , :xSALESAMOUNT_97
        , :xSALESAMOUNT_98
        , :xSALESAMOUNT_99
        , :xSALESAMOUNT_100
        , :xSALESAMOUNT_101
        , :xSALESAMOUNT_102
        , :xSALESAMOUNT_103
        , :xSALESAMOUNT_104
        , :xSALESAMOUNT_105
        , :xSALESAMOUNT_106
        , :xSALESAMOUNT_107
        , :xSALESAMOUNT_108
        , :xSALESAMOUNT_109
        , :xSALESAMOUNT_110
        , :xSALESAMOUNT_111
        , :xSALESAMOUNT_112
        , :xSALESAMOUNT_113
        , :xSALESAMOUNT_114
        , :xSALESAMOUNT_115
        , :xSALESAMOUNT_116
        , :xSALESAMOUNT_117
        , :xSALESAMOUNT_118
        , :xSALESAMOUNT_119
        , :xSALESAMOUNT_120

  Do Begin
      Update ItemSales

      Set SALESAMOUNT_0  =:xSALESAMOUNT_0
        , SALESAMOUNT_1  =:xSALESAMOUNT_1
        , SALESAMOUNT_2  =:xSALESAMOUNT_2
        , SALESAMOUNT_3  =:xSALESAMOUNT_3
        , SALESAMOUNT_4  =:xSALESAMOUNT_4
        , SALESAMOUNT_5  =:xSALESAMOUNT_5
        , SALESAMOUNT_6  =:xSALESAMOUNT_6
        , SALESAMOUNT_7  =:xSALESAMOUNT_7
        , SALESAMOUNT_8  =:xSALESAMOUNT_8
        , SALESAMOUNT_9  =:xSALESAMOUNT_9
        , SALESAMOUNT_10 =:xSALESAMOUNT_10
        , SALESAMOUNT_11 =:xSALESAMOUNT_11
        , SALESAMOUNT_12 =:xSALESAMOUNT_12
        , SALESAMOUNT_13 =:xSALESAMOUNT_13
        , SALESAMOUNT_14 =:xSALESAMOUNT_14
        , SALESAMOUNT_15 =:xSALESAMOUNT_15
        , SALESAMOUNT_16 =:xSALESAMOUNT_16
        , SALESAMOUNT_17 =:xSALESAMOUNT_17
        , SALESAMOUNT_18 =:xSALESAMOUNT_18
        , SALESAMOUNT_19 =:xSALESAMOUNT_19
        , SALESAMOUNT_20 =:xSALESAMOUNT_20
        , SALESAMOUNT_21 =:xSALESAMOUNT_21
        , SALESAMOUNT_22 =:xSALESAMOUNT_22
        , SALESAMOUNT_23 =:xSALESAMOUNT_23
        , SALESAMOUNT_24 =:xSALESAMOUNT_24
        , SALESAMOUNT_25 =:xSALESAMOUNT_25
        , SALESAMOUNT_26 =:xSALESAMOUNT_26
        , SALESAMOUNT_27 =:xSALESAMOUNT_27
        , SALESAMOUNT_28 =:xSALESAMOUNT_28
        , SALESAMOUNT_29 =:xSALESAMOUNT_29
        , SALESAMOUNT_30 =:xSALESAMOUNT_30
        , SALESAMOUNT_31 =:xSALESAMOUNT_31
        , SALESAMOUNT_32 =:xSALESAMOUNT_32
        , SALESAMOUNT_33 =:xSALESAMOUNT_33
        , SALESAMOUNT_34 =:xSALESAMOUNT_34
        , SALESAMOUNT_35 =:xSALESAMOUNT_35
        , SALESAMOUNT_36 =:xSALESAMOUNT_36
        , SALESAMOUNT_37 =:xSALESAMOUNT_37
        , SALESAMOUNT_38 =:xSALESAMOUNT_38
        , SALESAMOUNT_39 =:xSALESAMOUNT_39
        , SALESAMOUNT_40 =:xSALESAMOUNT_40
        , SALESAMOUNT_41 =:xSALESAMOUNT_41
        , SALESAMOUNT_42 =:xSALESAMOUNT_42
        , SALESAMOUNT_43 =:xSALESAMOUNT_43
        , SALESAMOUNT_44 =:xSALESAMOUNT_44
        , SALESAMOUNT_45 =:xSALESAMOUNT_45
        , SALESAMOUNT_46 =:xSALESAMOUNT_46
        , SALESAMOUNT_47 =:xSALESAMOUNT_47
        , SALESAMOUNT_48 =:xSALESAMOUNT_48
        , SALESAMOUNT_49 =:xSALESAMOUNT_49
        , SALESAMOUNT_50 =:xSALESAMOUNT_50
        , SALESAMOUNT_51 =:xSALESAMOUNT_51
        , SALESAMOUNT_52 =:xSALESAMOUNT_52
        , SALESAMOUNT_53 =:xSALESAMOUNT_53
        , SALESAMOUNT_54 =:xSALESAMOUNT_54
        , SALESAMOUNT_55 =:xSALESAMOUNT_55
        , SALESAMOUNT_56 =:xSALESAMOUNT_56
        , SALESAMOUNT_57 =:xSALESAMOUNT_57
        , SALESAMOUNT_58 =:xSALESAMOUNT_58
        , SALESAMOUNT_59 =:xSALESAMOUNT_59
        , SALESAMOUNT_60 =:xSALESAMOUNT_60
        , SALESAMOUNT_61 =:xSALESAMOUNT_61
        , SALESAMOUNT_62 =:xSALESAMOUNT_62
        , SALESAMOUNT_63 =:xSALESAMOUNT_63
        , SALESAMOUNT_64 =:xSALESAMOUNT_64
        , SALESAMOUNT_65 =:xSALESAMOUNT_65
        , SALESAMOUNT_66 =:xSALESAMOUNT_66
        , SALESAMOUNT_67 =:xSALESAMOUNT_67
        , SALESAMOUNT_68 =:xSALESAMOUNT_68
        , SALESAMOUNT_69 =:xSALESAMOUNT_69
        , SALESAMOUNT_70 =:xSALESAMOUNT_70
        , SALESAMOUNT_71 =:xSALESAMOUNT_71
        , SALESAMOUNT_72 =:xSALESAMOUNT_72
        , SALESAMOUNT_73 =:xSALESAMOUNT_73
        , SALESAMOUNT_74 =:xSALESAMOUNT_74
        , SALESAMOUNT_75 =:xSALESAMOUNT_75
        , SALESAMOUNT_76 =:xSALESAMOUNT_76
        , SALESAMOUNT_77 =:xSALESAMOUNT_77
        , SALESAMOUNT_78 =:xSALESAMOUNT_78
        , SALESAMOUNT_80 =:xSALESAMOUNT_80
        , SALESAMOUNT_81 =:xSALESAMOUNT_81
        , SALESAMOUNT_82 =:xSALESAMOUNT_82
        , SALESAMOUNT_83 =:xSALESAMOUNT_83
        , SALESAMOUNT_84 =:xSALESAMOUNT_84
        , SALESAMOUNT_85 =:xSALESAMOUNT_85
        , SALESAMOUNT_86 =:xSALESAMOUNT_86
        , SALESAMOUNT_87 =:xSALESAMOUNT_87
        , SALESAMOUNT_88 =:xSALESAMOUNT_88
        , SALESAMOUNT_89 =:xSALESAMOUNT_89
        , SALESAMOUNT_90 =:xSALESAMOUNT_90
        , SALESAMOUNT_91 =:xSALESAMOUNT_91
        , SALESAMOUNT_92 =:xSALESAMOUNT_92
        , SALESAMOUNT_93 =:xSALESAMOUNT_93
        , SALESAMOUNT_94 =:xSALESAMOUNT_94
        , SALESAMOUNT_95 =:xSALESAMOUNT_95
        , SALESAMOUNT_96 =:xSALESAMOUNT_96
        , SALESAMOUNT_97 =:xSALESAMOUNT_97
        , SALESAMOUNT_98 =:xSALESAMOUNT_98
        , SALESAMOUNT_99 =:xSALESAMOUNT_99
        , SALESAMOUNT_100=:xSALESAMOUNT_100
        , SALESAMOUNT_101=:xSALESAMOUNT_101
        , SALESAMOUNT_102=:xSALESAMOUNT_102
        , SALESAMOUNT_103=:xSALESAMOUNT_103
        , SALESAMOUNT_104=:xSALESAMOUNT_104
        , SALESAMOUNT_105=:xSALESAMOUNT_105
        , SALESAMOUNT_106=:xSALESAMOUNT_106
        , SALESAMOUNT_107=:xSALESAMOUNT_107
        , SALESAMOUNT_108=:xSALESAMOUNT_108
        , SALESAMOUNT_109=:xSALESAMOUNT_109
        , SALESAMOUNT_110=:xSALESAMOUNT_110
        , SALESAMOUNT_111=:xSALESAMOUNT_111
        , SALESAMOUNT_112=:xSALESAMOUNT_112
        , SALESAMOUNT_113=:xSALESAMOUNT_113
        , SALESAMOUNT_114=:xSALESAMOUNT_114
        , SALESAMOUNT_115=:xSALESAMOUNT_115
        , SALESAMOUNT_116=:xSALESAMOUNT_116
        , SALESAMOUNT_117=:xSALESAMOUNT_117
        , SALESAMOUNT_118=:xSALESAMOUNT_118
        , SALESAMOUNT_119=:xSALESAMOUNT_119
        , SALESAMOUNT_120=:xSALESAMOUNT_120

      where Itemno = :xTargetItemNo;

      Update Item
          Set AGE = :xTargetAge
          where ItemNo = :xTargetItemNo;

  end


end!!

Set Term ; !!

