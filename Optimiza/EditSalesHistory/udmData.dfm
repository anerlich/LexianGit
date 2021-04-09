inherited dmData: TdmData
  OldCreateOrder = True
  inherited dbOptimiza: TIBDatabase
    Connected = False
    DatabaseName = ''
    Left = 320
  end
  inherited prcFireEvent: TIBStoredProc
    Left = 384
  end
  inherited trnOptimiza: TIBTransaction
    Active = True
    Left = 320
  end
  object srcSrcProd: TDataSource
    DataSet = qrySrcProd
    Left = 24
    Top = 8
  end
  object qrySrcProd: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select ProductCode, ProductDescription from Product'
      '  where 1=1'
      'Order by ProductCode')
    Left = 96
    Top = 8
  end
  object qrySrcLocation: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Location'
      'Order by Description')
    Left = 104
    Top = 72
  end
  object srcSrcLocation: TDataSource
    DataSet = qrySrcLocation
    Left = 24
    Top = 72
  end
  object qryPeriod: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select Description from Calendar'
      '  where Calendarno >= :StartPeriod'
      '  and CalendarNo <= :EndPeriod'
      'Order By CalendarNo Descending')
    Left = 24
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'StartPeriod'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EndPeriod'
        ParamType = ptUnknown
      end>
  end
  object srcPeriod: TDataSource
    DataSet = qryPeriod
    Left = 104
    Top = 136
  end
  object qrySales: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from ItemSales where'
      '  ItemNo = :ItemNo')
    UpdateObject = IBUpdateSQL1
    Left = 40
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ItemNo'
        ParamType = ptUnknown
      end>
  end
  object srcSales: TDataSource
    DataSet = qrySales
    Left = 120
    Top = 216
  end
  object IBUpdateSQL1: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  ITEMSALESNO,'
      '  ITEMNO,'
      '  SALESAMOUNT_0,'
      '  SALESAMOUNT_1,'
      '  SALESAMOUNT_2,'
      '  SALESAMOUNT_3,'
      '  SALESAMOUNT_4,'
      '  SALESAMOUNT_5,'
      '  SALESAMOUNT_6,'
      '  SALESAMOUNT_7,'
      '  SALESAMOUNT_8,'
      '  SALESAMOUNT_9,'
      '  SALESAMOUNT_10,'
      '  SALESAMOUNT_11,'
      '  SALESAMOUNT_12,'
      '  SALESAMOUNT_13,'
      '  SALESAMOUNT_14,'
      '  SALESAMOUNT_15,'
      '  SALESAMOUNT_16,'
      '  SALESAMOUNT_17,'
      '  SALESAMOUNT_18,'
      '  SALESAMOUNT_19,'
      '  SALESAMOUNT_20,'
      '  SALESAMOUNT_21,'
      '  SALESAMOUNT_22,'
      '  SALESAMOUNT_23,'
      '  SALESAMOUNT_24,'
      '  SALESAMOUNT_25,'
      '  SALESAMOUNT_26,'
      '  SALESAMOUNT_27,'
      '  SALESAMOUNT_28,'
      '  SALESAMOUNT_29,'
      '  SALESAMOUNT_30,'
      '  SALESAMOUNT_31,'
      '  SALESAMOUNT_32,'
      '  SALESAMOUNT_33,'
      '  SALESAMOUNT_34,'
      '  SALESAMOUNT_35,'
      '  SALESAMOUNT_36,'
      '  SALESAMOUNT_37,'
      '  SALESAMOUNT_38,'
      '  SALESAMOUNT_39,'
      '  SALESAMOUNT_40,'
      '  SALESAMOUNT_41,'
      '  SALESAMOUNT_42,'
      '  SALESAMOUNT_43,'
      '  SALESAMOUNT_44,'
      '  SALESAMOUNT_45,'
      '  SALESAMOUNT_46,'
      '  SALESAMOUNT_47,'
      '  SALESAMOUNT_48,'
      '  SALESAMOUNT_49,'
      '  SALESAMOUNT_50,'
      '  SALESAMOUNT_51,'
      '  SALESAMOUNT_52,'
      '  SALESAMOUNT_53,'
      '  SALESAMOUNT_54,'
      '  SALESAMOUNT_55,'
      '  SALESAMOUNT_56,'
      '  SALESAMOUNT_57,'
      '  SALESAMOUNT_58,'
      '  SALESAMOUNT_59,'
      '  SALESAMOUNT_60,'
      '  SALESAMOUNT_61,'
      '  SALESAMOUNT_62,'
      '  SALESAMOUNT_63,'
      '  SALESAMOUNT_64,'
      '  SALESAMOUNT_65,'
      '  SALESAMOUNT_66,'
      '  SALESAMOUNT_67,'
      '  SALESAMOUNT_68,'
      '  SALESAMOUNT_69,'
      '  SALESAMOUNT_70,'
      '  SALESAMOUNT_71,'
      '  SALESAMOUNT_72,'
      '  SALESAMOUNT_73,'
      '  SALESAMOUNT_74,'
      '  SALESAMOUNT_75,'
      '  SALESAMOUNT_76,'
      '  SALESAMOUNT_77,'
      '  SALESAMOUNT_78,'
      '  SALESAMOUNT_79,'
      '  SALESAMOUNT_80,'
      '  SALESAMOUNT_81,'
      '  SALESAMOUNT_82,'
      '  SALESAMOUNT_83,'
      '  SALESAMOUNT_84,'
      '  SALESAMOUNT_85,'
      '  SALESAMOUNT_86,'
      '  SALESAMOUNT_87,'
      '  SALESAMOUNT_88,'
      '  SALESAMOUNT_89,'
      '  SALESAMOUNT_90,'
      '  SALESAMOUNT_91,'
      '  SALESAMOUNT_92,'
      '  SALESAMOUNT_93,'
      '  SALESAMOUNT_94,'
      '  SALESAMOUNT_95,'
      '  SALESAMOUNT_96,'
      '  SALESAMOUNT_97,'
      '  SALESAMOUNT_98,'
      '  SALESAMOUNT_99,'
      '  SALESAMOUNT_100,'
      '  SALESAMOUNT_101,'
      '  SALESAMOUNT_102,'
      '  SALESAMOUNT_103,'
      '  SALESAMOUNT_104,'
      '  SALESAMOUNT_105,'
      '  SALESAMOUNT_106,'
      '  SALESAMOUNT_107,'
      '  SALESAMOUNT_108,'
      '  SALESAMOUNT_109,'
      '  SALESAMOUNT_110,'
      '  SALESAMOUNT_111,'
      '  SALESAMOUNT_112,'
      '  SALESAMOUNT_113,'
      '  SALESAMOUNT_114,'
      '  SALESAMOUNT_115,'
      '  SALESAMOUNT_116,'
      '  SALESAMOUNT_117,'
      '  SALESAMOUNT_118,'
      '  SALESAMOUNT_119,'
      '  SALESAMOUNT_120'
      'from ItemSales '
      'where'
      '  ITEMNO = :ITEMNO')
    ModifySQL.Strings = (
      'update ItemSales'
      'set'
      '  SALESAMOUNT_0 = :SALESAMOUNT_0,'
      '  SALESAMOUNT_1 = :SALESAMOUNT_1,'
      '  SALESAMOUNT_2 = :SALESAMOUNT_2,'
      '  SALESAMOUNT_3 = :SALESAMOUNT_3,'
      '  SALESAMOUNT_4 = :SALESAMOUNT_4,'
      '  SALESAMOUNT_5 = :SALESAMOUNT_5,'
      '  SALESAMOUNT_6 = :SALESAMOUNT_6,'
      '  SALESAMOUNT_7 = :SALESAMOUNT_7,'
      '  SALESAMOUNT_8 = :SALESAMOUNT_8,'
      '  SALESAMOUNT_9 = :SALESAMOUNT_9,'
      '  SALESAMOUNT_10 = :SALESAMOUNT_10,'
      '  SALESAMOUNT_11 = :SALESAMOUNT_11,'
      '  SALESAMOUNT_12 = :SALESAMOUNT_12,'
      '  SALESAMOUNT_13 = :SALESAMOUNT_13,'
      '  SALESAMOUNT_14 = :SALESAMOUNT_14,'
      '  SALESAMOUNT_15 = :SALESAMOUNT_15,'
      '  SALESAMOUNT_16 = :SALESAMOUNT_16,'
      '  SALESAMOUNT_17 = :SALESAMOUNT_17,'
      '  SALESAMOUNT_18 = :SALESAMOUNT_18,'
      '  SALESAMOUNT_19 = :SALESAMOUNT_19,'
      '  SALESAMOUNT_20 = :SALESAMOUNT_20,'
      '  SALESAMOUNT_21 = :SALESAMOUNT_21,'
      '  SALESAMOUNT_22 = :SALESAMOUNT_22,'
      '  SALESAMOUNT_23 = :SALESAMOUNT_23,'
      '  SALESAMOUNT_24 = :SALESAMOUNT_24,'
      '  SALESAMOUNT_25 = :SALESAMOUNT_25,'
      '  SALESAMOUNT_26 = :SALESAMOUNT_26,'
      '  SALESAMOUNT_27 = :SALESAMOUNT_27,'
      '  SALESAMOUNT_28 = :SALESAMOUNT_28,'
      '  SALESAMOUNT_29 = :SALESAMOUNT_29,'
      '  SALESAMOUNT_30 = :SALESAMOUNT_30,'
      '  SALESAMOUNT_31 = :SALESAMOUNT_31,'
      '  SALESAMOUNT_32 = :SALESAMOUNT_32,'
      '  SALESAMOUNT_33 = :SALESAMOUNT_33,'
      '  SALESAMOUNT_34 = :SALESAMOUNT_34,'
      '  SALESAMOUNT_35 = :SALESAMOUNT_35,'
      '  SALESAMOUNT_36 = :SALESAMOUNT_36,'
      '  SALESAMOUNT_37 = :SALESAMOUNT_37,'
      '  SALESAMOUNT_38 = :SALESAMOUNT_38,'
      '  SALESAMOUNT_39 = :SALESAMOUNT_39,'
      '  SALESAMOUNT_40 = :SALESAMOUNT_40,'
      '  SALESAMOUNT_41 = :SALESAMOUNT_41,'
      '  SALESAMOUNT_42 = :SALESAMOUNT_42,'
      '  SALESAMOUNT_43 = :SALESAMOUNT_43,'
      '  SALESAMOUNT_44 = :SALESAMOUNT_44,'
      '  SALESAMOUNT_45 = :SALESAMOUNT_45,'
      '  SALESAMOUNT_46 = :SALESAMOUNT_46,'
      '  SALESAMOUNT_47 = :SALESAMOUNT_47,'
      '  SALESAMOUNT_48 = :SALESAMOUNT_48,'
      '  SALESAMOUNT_49 = :SALESAMOUNT_49,'
      '  SALESAMOUNT_50 = :SALESAMOUNT_50,'
      '  SALESAMOUNT_51 = :SALESAMOUNT_51,'
      '  SALESAMOUNT_52 = :SALESAMOUNT_52,'
      '  SALESAMOUNT_53 = :SALESAMOUNT_53,'
      '  SALESAMOUNT_54 = :SALESAMOUNT_54,'
      '  SALESAMOUNT_55 = :SALESAMOUNT_55,'
      '  SALESAMOUNT_56 = :SALESAMOUNT_56,'
      '  SALESAMOUNT_57 = :SALESAMOUNT_57,'
      '  SALESAMOUNT_58 = :SALESAMOUNT_58,'
      '  SALESAMOUNT_59 = :SALESAMOUNT_59,'
      '  SALESAMOUNT_60 = :SALESAMOUNT_60,'
      '  SALESAMOUNT_61 = :SALESAMOUNT_61,'
      '  SALESAMOUNT_62 = :SALESAMOUNT_62,'
      '  SALESAMOUNT_63 = :SALESAMOUNT_63,'
      '  SALESAMOUNT_64 = :SALESAMOUNT_64,'
      '  SALESAMOUNT_65 = :SALESAMOUNT_65,'
      '  SALESAMOUNT_66 = :SALESAMOUNT_66,'
      '  SALESAMOUNT_67 = :SALESAMOUNT_67,'
      '  SALESAMOUNT_68 = :SALESAMOUNT_68,'
      '  SALESAMOUNT_69 = :SALESAMOUNT_69,'
      '  SALESAMOUNT_70 = :SALESAMOUNT_70,'
      '  SALESAMOUNT_71 = :SALESAMOUNT_71,'
      '  SALESAMOUNT_72 = :SALESAMOUNT_72,'
      '  SALESAMOUNT_73 = :SALESAMOUNT_73,'
      '  SALESAMOUNT_74 = :SALESAMOUNT_74,'
      '  SALESAMOUNT_75 = :SALESAMOUNT_75,'
      '  SALESAMOUNT_76 = :SALESAMOUNT_76,'
      '  SALESAMOUNT_77 = :SALESAMOUNT_77,'
      '  SALESAMOUNT_78 = :SALESAMOUNT_78,'
      '  SALESAMOUNT_79 = :SALESAMOUNT_79,'
      '  SALESAMOUNT_80 = :SALESAMOUNT_80,'
      '  SALESAMOUNT_81 = :SALESAMOUNT_81,'
      '  SALESAMOUNT_82 = :SALESAMOUNT_82,'
      '  SALESAMOUNT_83 = :SALESAMOUNT_83,'
      '  SALESAMOUNT_84 = :SALESAMOUNT_84,'
      '  SALESAMOUNT_85 = :SALESAMOUNT_85,'
      '  SALESAMOUNT_86 = :SALESAMOUNT_86,'
      '  SALESAMOUNT_87 = :SALESAMOUNT_87,'
      '  SALESAMOUNT_88 = :SALESAMOUNT_88,'
      '  SALESAMOUNT_89 = :SALESAMOUNT_89,'
      '  SALESAMOUNT_90 = :SALESAMOUNT_90,'
      '  SALESAMOUNT_91 = :SALESAMOUNT_91,'
      '  SALESAMOUNT_92 = :SALESAMOUNT_92,'
      '  SALESAMOUNT_93 = :SALESAMOUNT_93,'
      '  SALESAMOUNT_94 = :SALESAMOUNT_94,'
      '  SALESAMOUNT_95 = :SALESAMOUNT_95,'
      '  SALESAMOUNT_96 = :SALESAMOUNT_96,'
      '  SALESAMOUNT_97 = :SALESAMOUNT_97,'
      '  SALESAMOUNT_98 = :SALESAMOUNT_98,'
      '  SALESAMOUNT_99 = :SALESAMOUNT_99,'
      '  SALESAMOUNT_100 = :SALESAMOUNT_100,'
      '  SALESAMOUNT_101 = :SALESAMOUNT_101,'
      '  SALESAMOUNT_102 = :SALESAMOUNT_102,'
      '  SALESAMOUNT_103 = :SALESAMOUNT_103,'
      '  SALESAMOUNT_104 = :SALESAMOUNT_104,'
      '  SALESAMOUNT_105 = :SALESAMOUNT_105,'
      '  SALESAMOUNT_106 = :SALESAMOUNT_106,'
      '  SALESAMOUNT_107 = :SALESAMOUNT_107,'
      '  SALESAMOUNT_108 = :SALESAMOUNT_108,'
      '  SALESAMOUNT_109 = :SALESAMOUNT_109,'
      '  SALESAMOUNT_110 = :SALESAMOUNT_110,'
      '  SALESAMOUNT_111 = :SALESAMOUNT_111,'
      '  SALESAMOUNT_112 = :SALESAMOUNT_112,'
      '  SALESAMOUNT_113 = :SALESAMOUNT_113,'
      '  SALESAMOUNT_114 = :SALESAMOUNT_114,'
      '  SALESAMOUNT_115 = :SALESAMOUNT_115,'
      '  SALESAMOUNT_116 = :SALESAMOUNT_116,'
      '  SALESAMOUNT_117 = :SALESAMOUNT_117,'
      '  SALESAMOUNT_118 = :SALESAMOUNT_118,'
      '  SALESAMOUNT_119 = :SALESAMOUNT_119,'
      '  SALESAMOUNT_120 = :SALESAMOUNT_120'
      'where'
      '  ITEMNO = :OLD_ITEMNO')
    Left = 64
    Top = 296
  end
end
