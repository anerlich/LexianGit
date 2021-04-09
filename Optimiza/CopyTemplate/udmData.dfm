inherited dmData: TdmData
  OldCreateOrder = True
  Left = 395
  Top = 172
  Height = 669
  Width = 766
  inherited dbOptimiza: TIBDatabase
    DatabaseName = 'localhost:c:\Optimiza\KingGee\Database\KINGGEE.GDB'
  end
  object qryUser: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from Users'
      '  '
      'where UserName <> :UserName'
      'Order By UserName')
    Left = 128
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UserName'
        ParamType = ptUnknown
      end>
  end
  object srcUser: TDataSource
    DataSet = qryUser
    Left = 128
    Top = 152
  end
  object qryTemplate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select TemplateNo,Description,UserNo from Template'
      'where TemplateType in ('#39'F'#39','#39'O'#39','#39'X'#39','#39'G'#39','#39'N'#39') and UserNo = :UserNo'
      'Order by Description')
    Left = 144
    Top = 232
    ParamData = <
      item
        DataType = ftInteger
        Name = 'UserNo'
        ParamType = ptUnknown
      end>
  end
  object srcTemplate: TDataSource
    DataSet = qryTemplate
    Left = 136
    Top = 288
  end
  object qryCheckProc: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Select * from rdb$procedures where'
      'RDB$PROCEDURE_NAME = "UP_COPYUSERTEMPLATE"')
    Transaction = trnOptimiza
    Left = 200
    Top = 16
  end
  object qryCreateProc: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'CREATE PROCEDURE UP_COPYUSERTEMPLATE('
      '  TEMPLATENO INTEGER,'
      '  USERNOFROM INTEGER,'
      '  USERNOTO INTEGER,'
      '  '
      '  NEWDESCRIPTION VARCHAR(80) CHARACTER SET NONE,'
      'UseDesc Char(1))'
      'AS'
      'DECLARE VARIABLE GROUPTYPE CHAR(1);'
      'DECLARE VARIABLE GROUPNO INTEGER;'
      'DECLARE VARIABLE REPORTCATEGORYTYPE INTEGER;'
      'DECLARE VARIABLE REPORTCATEGORYNO INTEGER;'
      'DECLARE VARIABLE NEWTEMPLATENO INTEGER;'
      'DECLARE VARIABLE USERNO INTEGER;'
      'DECLARE VARIABLE MAJORGROUP CHAR(1);'
      'DECLARE VARIABLE MINORGROUP1 CHAR(1);'
      'DECLARE VARIABLE MINORGROUP2 CHAR(1);'
      'DECLARE VARIABLE PARETO_A CHAR(1);'
      'DECLARE VARIABLE PARETO_B CHAR(1);'
      'DECLARE VARIABLE PARETO_C CHAR(1);'
      'DECLARE VARIABLE PARETO_D CHAR(1);'
      'DECLARE VARIABLE PARETO_E CHAR(1);'
      'DECLARE VARIABLE PARETO_F CHAR(1);'
      'DECLARE VARIABLE PARETO_M CHAR(1);'
      'DECLARE VARIABLE CRITICALITY_1 CHAR(1);'
      'DECLARE VARIABLE CRITICALITY_2 CHAR(1);'
      'DECLARE VARIABLE CRITICALITY_3 CHAR(1);'
      'DECLARE VARIABLE CRITICALITY_4 CHAR(1);'
      'DECLARE VARIABLE CRITICALITY_5 CHAR(1);'
      'DECLARE VARIABLE STOCKED CHAR(1);'
      'DECLARE VARIABLE NONSTOCKED CHAR(1);'
      'DECLARE VARIABLE PARETO_X CHAR(1);'
      'DECLARE VARIABLE SUPPLIER CHAR(1);'
      'DECLARE VARIABLE GENERICPARENTS CHAR(1);'
      'DECLARE VARIABLE GENERICCHILDREN CHAR(1);'
      'DECLARE VARIABLE EXCLUDEMAJOR CHAR(1);'
      'DECLARE VARIABLE EXCLUDEMINOR1 CHAR(1);'
      'DECLARE VARIABLE EXCLUDEMINOR2 CHAR(1);'
      'DECLARE VARIABLE EXCLUDESUPPLIER CHAR(1);'
      'DECLARE VARIABLE TEMPLATETYPE CHAR(1);'
      'DECLARE VARIABLE DESCRIPTION VARCHAR(80);'
      'DECLARE VARIABLE REPORTCATEGORIES CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONTYPE1 CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONTYPE2 CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONTYPE3 CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONTYPE4 CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONTYPE5 CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONTYPE6 CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONTYPE7 CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONTYPE8 CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONNONE CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONPAR CHAR(1);'
      'DECLARE VARIABLE SUPERCESSIONTOP CHAR(1);'
      'DECLARE VARIABLE GENERICNONE CHAR(1);'
      'DECLARE VARIABLE FAMILY CHAR(1);'
      'DECLARE VARIABLE EXCLUDEFAMILY CHAR(1);'
      'DECLARE VARIABLE REVIEW_ABOVE_LIMIT_ORDERS CHAR(1);'
      'DECLARE VARIABLE INCLUDE_ZERO_ORDERS CHAR(1);'
      'DECLARE VARIABLE EXPEDITE CHAR(1);'
      'DECLARE VARIABLE DEEXPEDITE CHAR(1);'
      'DECLARE VARIABLE EXCLUDEREPORTCATEGORY CHAR(1);'
      'DECLARE VARIABLE REPAIRABLE CHAR(1);'
      'DECLARE VARIABLE NONREPAIRABLE CHAR(1);'
      'DECLARE VARIABLE TMPDESC VARCHAR(80);'
      'begin'
      '/*'
      '  Ver 2.0 : Includes exclude filter for report categories.'
      '  Ver 2.1 : Copy as functionality ... Description as input param'
      '*/'
      
        '    for select TEMPLATENO, USERNO, DESCRIPTION, TEMPLATETYPE, MA' +
        'JORGROUP, MINORGROUP1, MINORGROUP2,'
      
        '    PARETO_A, PARETO_B, PARETO_C, PARETO_D, PARETO_E, PARETO_F, ' +
        'PARETO_M,'
      
        '    CRITICALITY_1, CRITICALITY_2, CRITICALITY_3, CRITICALITY_4, ' +
        'CRITICALITY_5,'
      
        '    STOCKED, NONSTOCKED, PARETO_X, SUPPLIER, GENERICPARENTS, GEN' +
        'ERICCHILDREN,'
      
        '    EXCLUDEMAJOR, EXCLUdEMINOR1, EXCLUDEMINOR2, EXCLUDESUPPLIER,' +
        ' REPORTCATEGORIES,'
      
        '    SUPERCESSIONTYPE1, SUPERCESSIONTYPE2, SUPERCESSIONTYPE3, SUP' +
        'ERCESSIONTYPE4,'
      
        '    SUPERCESSIONTYPE5, SUPERCESSIONTYPE6, SUPERCESSIONTYPE7, SUP' +
        'ERCESSIONTYPE8,'
      
        '    SUPERCESSIONNONE, SUPERCESSIONPAR, SUPERCESSIONTOP, GENERICN' +
        'ONE, FAMILY,'
      
        '    EXCLUDEFAMILY, REVIEW_ABOVE_LIMIT_ORDERS, INCLUDE_ZERO_ORDER' +
        'S, '
      
        '    EXPEDITE, DEEXPEDITE, EXCLUDEREPORTCATEGORY, REPAIRABLE, NON' +
        'REPAIRABLE'
      '    from TEMPLATE'
      '    where USERNO = :USERNOFROM and TemplateNo=:TemplateNo'
      
        '    into :TEMPLATENO, :USERNO, :DESCRIPTION, :TEMPLATETYPE, :MAJ' +
        'ORGROUP, :MINORGROUP1, :MINORGROUP2,'
      
        '    :PARETO_A, :PARETO_B, :PARETO_C, :PARETO_D, :PARETO_E, :PARE' +
        'TO_F, :PARETO_M,'
      
        '    :CRITICALITY_1, :CRITICALITY_2, :CRITICALITY_3, :CRITICALITY' +
        '_4, :CRITICALITY_5,'
      
        '    :STOCKED, :NONSTOCKED, :PARETO_X, :SUPPLIER, :GENERICPARENTS' +
        ', :GENERICCHILDREN,'
      
        '    :EXCLUDEMAJOR, :EXCLUDEMINOR1, :EXCLUDEMINOR2, :EXCLUDESUPPL' +
        'IER, :REPORTCATEGORIES,'
      
        '    :SUPERCESSIONTYPE1, :SUPERCESSIONTYPE2, :SUPERCESSIONTYPE3, ' +
        ':SUPERCESSIONTYPE4,'
      
        '    :SUPERCESSIONTYPE5, :SUPERCESSIONTYPE6, :SUPERCESSIONTYPE7, ' +
        ':SUPERCESSIONTYPE8,'
      
        '    :SUPERCESSIONNONE, :SUPERCESSIONPAR, :SUPERCESSIONTOP, :GENE' +
        'RICNONE, :FAMILY,'
      
        '    :EXCLUDEFAMILY, :REVIEW_ABOVE_LIMIT_ORDERS, :INCLUDE_ZERO_OR' +
        'DERS,'
      
        '    :EXPEDITE, :DEEXPEDITE, :EXCLUDEREPORTCATEGORY, :REPAIRABLE,' +
        ' :NONREPAIRABLE'
      '    do begin'
      '        tmpDesc = :DESCRIPTION;'
      '    '
      '      if (UseDesc = '#39'Y'#39') then'
      '    '#9'tmpDesc = NewDescription;'
      '            '
      '        NEWTEMPLATENO = gen_id(TEMPLATE_SEQNO, 1);'
      
        '        insert into TEMPLATE  (TEMPLATENO, USERNO, DESCRIPTION, ' +
        'TEMPLATETYPE, MAJORGROUP, MINORGROUP1, MINORGROUP2,'
      
        '            PARETO_A, PARETO_B, PARETO_C, PARETO_D, PARETO_E, PA' +
        'RETO_F, PARETO_M,'
      
        '            CRITICALITY_1, CRITICALITY_2, CRITICALITY_3, CRITICA' +
        'LITY_4, CRITICALITY_5,'
      
        '            STOCKED, NONSTOCKED, PARETO_X, SUPPLIER, GENERICPARE' +
        'NTS, GENERICCHILDREN,'
      
        '            EXCLUDEMAJOR, EXCLUdEMINOR1, EXCLUDEMINOR2, EXCLUDES' +
        'UPPLIER, REPORTCATEGORIES,'
      
        '            SUPERCESSIONTYPE1, SUPERCESSIONTYPE2, SUPERCESSIONTY' +
        'PE3, SUPERCESSIONTYPE4,'
      
        '            SUPERCESSIONTYPE5, SUPERCESSIONTYPE6, SUPERCESSIONTY' +
        'PE7, SUPERCESSIONTYPE8,'
      
        '            SUPERCESSIONNONE, SUPERCESSIONPAR, SUPERCESSIONTOP, ' +
        'GENERICNONE, FAMILY,'
      
        '            EXCLUDEFAMILY, REVIEW_ABOVE_LIMIT_ORDERS, INCLUDE_ZE' +
        'RO_ORDERS,'
      
        '            EXPEDITE, DEEXPEDITE, EXCLUDEREPORTCATEGORY, REPAIRA' +
        'BLE, NONREPAIRABLE)'
      
        '            values (:NEWTEMPLATENO, :USERNOTO, :tmpDesc, :TEMPLA' +
        'TETYPE, :MAJORGROUP, :MINORGROUP1, :MINORGROUP2,'
      
        '            :PARETO_A, :PARETO_B, :PARETO_C, :PARETO_D, :PARETO_' +
        'E, :PARETO_F, :PARETO_M,'
      
        '            :CRITICALITY_1, :CRITICALITY_2, :CRITICALITY_3, :CRI' +
        'TICALITY_4, :CRITICALITY_5,'
      
        '            :STOCKED, :NONSTOCKED, :PARETO_X, :SUPPLIER, :GENERI' +
        'CPARENTS, :GENERICCHILDREN,'
      
        '            :EXCLUDEMAJOR, :EXCLUDEMINOR1, :EXCLUDEMINOR2, :EXCL' +
        'UDESUPPLIER, :REPORTCATEGORIES,'
      
        '            :SUPERCESSIONTYPE1, :SUPERCESSIONTYPE2, :SUPERCESSIO' +
        'NTYPE3, :SUPERCESSIONTYPE4,'
      
        '            :SUPERCESSIONTYPE5, :SUPERCESSIONTYPE6, :SUPERCESSIO' +
        'NTYPE7, :SUPERCESSIONTYPE8,'
      
        '            :SUPERCESSIONNONE, :SUPERCESSIONPAR, :SUPERCESSIONTO' +
        'P, :GENERICNONE, :FAMILY,'
      
        '            :EXCLUDEFAMILY, :REVIEW_ABOVE_LIMIT_ORDERS, :INCLUDE' +
        '_ZERO_ORDERS,'
      
        '            :EXPEDITE, :DEEXPEDITE, :EXCLUDEREPORTCATEGORY, :REP' +
        'AIRABLE, :NONREPAIRABLE);'
      ''
      '        for select GROUPTYPE, GROUPNO'
      '            from TMPLT_GROUPS'
      '            WHERE TEMPLATENO = :TEMPLATENO'
      '        into :GROUPTYPE, :GROUPNO'
      '        do begin'
      
        '            insert into TMPLT_GROUPS (USERNO, TEMPLATENO, GROUPT' +
        'YPE, GROUPNO)'
      
        '            values (:USERNOTO, :NEWTEMPLATENO, :GROUPTYPE, :GROU' +
        'PNO);'
      '        end'
      ''
      '        for select REPORTCATEGORYTYPE, REPORTCATEGORYNO'
      '            from TMPLT_REPCATS'
      '            WHERE TEMPLATENO = :TEMPLATENO'
      '        into :reportcategorytype, :reportcategoryno'
      '        do begin'
      
        '            insert into TMPLT_REPCATS (TEMPLATENO, REPORTCATEGOR' +
        'YTYPE, REPORTCATEGORYNO)'
      
        '            values (:NEWTEMPLATENO, :REPORTCATEGORYTYPE, :REPORT' +
        'CATEGORYNO);'
      '        end'
      '    end'
      'end;')
    Transaction = trnOptimiza
    Left = 208
    Top = 80
  end
  object prcCopy: TIBStoredProc
    Database = dbOptimiza
    Transaction = trnOptimiza
    StoredProcName = 'UP_COPYUSERTEMPLATE'
    Left = 96
    Top = 24
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TEMPLATENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'USERNOFROM'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'USERNOTO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'NewDescription'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'UseDesc'
        ParamType = ptInput
      end>
  end
  object qryCheckProc1: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Select * from rdb$procedures where'
      'RDB$PROCEDURE_NAME = "UP_GET_TEMPLATES"')
    Transaction = trnOptimiza
    Left = 216
    Top = 184
  end
  object qryCreateProc1: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'create procedure UP_GET_TEMPLATES(aUserName VarChar(30))'
      'returns (UserName VarChar(30),'
      'TemplateDesc VarChar(100),'
      'GroupType VarChar(100),'
      'GroupTypeDesc VarChar(100),'
      'GroupCode VarChar(30),'
      'GroupDesc VarChar(100),'
      '     PARETO_A char(1),'
      '     PARETO_B char(1),'
      '      PARETO_C char(1),'
      '      PARETO_D char(1),'
      '      PARETO_E char(1),'
      '     PARETO_F char(1),'
      '     PARETO_M char(1),'
      '     CRITICALITY_1 char(1),'
      '     CRITICALITY_2 char(1),'
      '     CRITICALITY_3 char(1),'
      '     CRITICALITY_4 char(1),'
      '     CRITICALITY_5 char(1),'
      '     STOCKED char(1),'
      '     NONSTOCKED char(1),'
      '     PARETO_X char(1),'
      '     GENERICPARENTS char(1),'
      '     GENERICCHILDREN char(1),'
      '     EXCLUDEMAJOR char(1),'
      '     EXCLUdEMINOR1 char(1),'
      '     EXCLUDEMINOR2 char(1),'
      '     EXCLUDESUPPLIER char(1),'
      '     TEMPLATETYPE char(1),'
      '     REPORTCATEGORIES char(1),'
      '     GENERICNONE char(1),'
      '     EXPEDITE char(1) ,'
      '     DEEXPEDITE char(1) ,'
      '     EXCLUDEREPORTCATEGORY char(1)'
      ')'
      'as'
      'declare variable Templateno Integer;'
      'declare variable FromUser VarChar(30);'
      'declare variable ToUser VarChar(30);'
      'begin'
      '  /* Ver 2.0 - Get all templates '
      '  */'
      '  '
      '  if (aUserName ="ALL") then'
      '  begin'
      '    FromUser = "A";'
      '    ToUser = "Z";'
      '  end'
      '  else'
      '  begin'
      '    FromUser = :aUserName;'
      '    ToUser = :aUserName;'
      '  end'
      '  '
      '  for select t.templateno,'
      '             u.UserName,'
      '             '#39'Report Category'#39',  '
      '             t.description,'
      '             rct.description,'
      '             rc.ReportCategoryCode, '
      '             rc.Description,'
      '             t.PARETO_A,'
      '             t.PARETO_B ,'
      '             t.PARETO_C ,'
      '             t.PARETO_D ,'
      '             t.PARETO_E ,'
      '             t.PARETO_F ,'
      '             t.PARETO_M,'
      '             t.CRITICALITY_1 ,'
      '             t.CRITICALITY_2 ,'
      '             t.CRITICALITY_3 ,'
      '             t.CRITICALITY_4 ,'
      '             t.CRITICALITY_5 ,'
      '             t.STOCKED ,'
      '             t.NONSTOCKED ,'
      '             t.PARETO_X ,'
      '             t.GENERICPARENTS ,'
      '             t.GENERICCHILDREN ,'
      '             t.EXCLUDEMAJOR ,'
      '             t.EXCLUdEMINOR1 ,'
      '             t.EXCLUDEMINOR2 ,'
      '             t.EXCLUDESUPPLIER ,'
      '             t.TEMPLATETYPE ,'
      '             t.REPORTCATEGORIES ,'
      '             t.GENERICNONE ,'
      '             t.EXPEDITE ,'
      '             t.DEEXPEDITE  ,'
      '             t.EXCLUDEREPORTCATEGORY  '
      '      from template t'
      '      left join users u on u.userno=t.userno'
      '      left join tmplt_repcats tr on t.templateno=tr.templateno'
      
        '      left join reportcategorytype rct on tr.reportcategorytype=' +
        '  rct.reportcategorytype'
      
        '      left join Reportcategory rc on tr.ReportCategoryNo=rc.Repo' +
        'rtcategoryNo and tr.reportcategorytype=rc.reportcategorytype '
      '     '
      
        '     where u.username >= :FromUser and u.username <= :ToUser and' +
        ' t.reportcategories ="Y"'
      
        '     into :TemplateNo, :UserName, :GroupType, :TemplateDesc, :Gr' +
        'oupTypeDesc, :GroupCode, :GroupDesc,'
      '             :PARETO_A,'
      '             :PARETO_B ,'
      '             :PARETO_C, '
      '             :PARETO_D ,'
      '             :PARETO_E ,'
      '             :PARETO_F ,'
      '             :PARETO_M,'
      '             :CRITICALITY_1 ,'
      '             :CRITICALITY_2 ,'
      '             :CRITICALITY_3 ,'
      '             :CRITICALITY_4 ,'
      '             :CRITICALITY_5 ,'
      '             :STOCKED ,'
      '             :NONSTOCKED ,'
      '             :PARETO_X ,'
      '             :GENERICPARENTS ,'
      '             :GENERICCHILDREN ,'
      '             :EXCLUDEMAJOR ,'
      '             :EXCLUdEMINOR1 ,'
      '             :EXCLUDEMINOR2 ,'
      '             :EXCLUDESUPPLIER ,'
      '             :TEMPLATETYPE ,'
      '             :REPORTCATEGORIES ,'
      '             :GENERICNONE ,'
      '             :EXPEDITE ,'
      '             :DEEXPEDITE  ,'
      '             :EXCLUDEREPORTCATEGORY  '
      '     do begin'
      '       suspend;'
      '     end'
      '     '
      '  for select t.templateno,'
      '             u.UserName,'
      '             '#39'Major Group'#39',  '
      '             t.description,'
      '             '#39'Major Group'#39','
      '             gm.GroupCode,'
      '             gm.Description,'
      '             t.PARETO_A,'
      '             t.PARETO_B ,'
      '             t.PARETO_C ,'
      '             t.PARETO_D ,'
      '             t.PARETO_E ,'
      '             t.PARETO_F ,'
      '             t.PARETO_M,'
      '             t.CRITICALITY_1 ,'
      '             t.CRITICALITY_2 ,'
      '             t.CRITICALITY_3 ,'
      '             t.CRITICALITY_4 ,'
      '             t.CRITICALITY_5 ,'
      '             t.STOCKED ,'
      '             t.NONSTOCKED ,'
      '             t.PARETO_X ,'
      '             t.GENERICPARENTS ,'
      '             t.GENERICCHILDREN ,'
      '             t.EXCLUDEMAJOR ,'
      '             t.EXCLUdEMINOR1 ,'
      '             t.EXCLUDEMINOR2 ,'
      '             t.EXCLUDESUPPLIER ,'
      '             t.TEMPLATETYPE ,'
      '             t.REPORTCATEGORIES ,'
      '             t.GENERICNONE ,'
      '             t.EXPEDITE ,'
      '             t.DEEXPEDITE  ,'
      '             t.EXCLUDEREPORTCATEGORY  '
      '      from template t'
      '      left join users u on u.userno=t.userno'
      
        '      left join tmplt_groups tg on t.templateno=tg.templateno an' +
        'd tg.GroupType="M"'
      '      left join GroupMajor gm on tg.GroupNo=gm.GroupNo     '
      
        '     where u.username >= :FromUser and u.username <= :ToUser and' +
        ' t.MajorGroup ="Y"'
      
        '     into :TemplateNo, :UserName, :GroupType, :TemplateDesc, :Gr' +
        'oupTypeDesc, :GroupCode, :GroupDesc,'
      '             :PARETO_A,'
      '             :PARETO_B ,'
      '             :PARETO_C ,'
      '             :PARETO_D ,'
      '             :PARETO_E ,'
      '             :PARETO_F ,'
      '             :PARETO_M,'
      '             :CRITICALITY_1 ,'
      '             :CRITICALITY_2 ,'
      '             :CRITICALITY_3 ,'
      '             :CRITICALITY_4 ,'
      '             :CRITICALITY_5 ,'
      '             :STOCKED ,'
      '             :NONSTOCKED ,'
      '             :PARETO_X ,'
      '             :GENERICPARENTS ,'
      '             :GENERICCHILDREN ,'
      '             :EXCLUDEMAJOR ,'
      '             :EXCLUdEMINOR1 ,'
      '             :EXCLUDEMINOR2 ,'
      '             :EXCLUDESUPPLIER ,'
      '             :TEMPLATETYPE ,'
      '             :REPORTCATEGORIES ,'
      '             :GENERICNONE ,'
      '             :EXPEDITE ,'
      '             :DEEXPEDITE  ,'
      '             :EXCLUDEREPORTCATEGORY  '
      '     do begin'
      '       suspend;'
      '     end'
      ''
      '  for select t.templateno,'
      '             u.UserName,'
      '             '#39'Minor Group1'#39',  '
      '             t.description,'
      '             '#39'Minor Group1'#39','
      '             gm1.GroupCode,'
      '             gm1.Description,'
      '             t.PARETO_A,'
      '             t.PARETO_B ,'
      '             t.PARETO_C, '
      '             t.PARETO_D ,'
      '             t.PARETO_E ,'
      '             t.PARETO_F ,'
      '             t.PARETO_M,'
      '             t.CRITICALITY_1 ,'
      '             t.CRITICALITY_2 ,'
      '             t.CRITICALITY_3 ,'
      '             t.CRITICALITY_4 ,'
      '             t.CRITICALITY_5 ,'
      '             t.STOCKED ,'
      '             t.NONSTOCKED ,'
      '             t.PARETO_X ,'
      '             t.GENERICPARENTS ,'
      '             t.GENERICCHILDREN ,'
      '             t.EXCLUDEMAJOR ,'
      '             t.EXCLUdEMINOR1 ,'
      '             t.EXCLUDEMINOR2 ,'
      '             t.EXCLUDESUPPLIER ,'
      '             t.TEMPLATETYPE ,'
      '             t.REPORTCATEGORIES ,'
      '             t.GENERICNONE ,'
      '             t.EXPEDITE ,'
      '             t.DEEXPEDITE  ,'
      '             t.EXCLUDEREPORTCATEGORY  '
      '      from template t'
      '      left join users u on u.userno=t.userno'
      
        '      left join tmplt_groups tg on t.templateno=tg.templateno an' +
        'd tg.GroupType="1"'
      '      left join GroupMinor1 gm1 on tg.GroupNo=gm1.GroupNo     '
      
        '     where u.username >= :FromUser and u.username <= :ToUser and' +
        ' t.MinorGroup1 ="Y"'
      
        '     into :TemplateNo, :UserName, :GroupType, :TemplateDesc, :Gr' +
        'oupTypeDesc, :GroupCode, :GroupDesc,'
      '             :PARETO_A,'
      '             :PARETO_B ,'
      '             :PARETO_C ,'
      '             :PARETO_D ,'
      '             :PARETO_E ,'
      '             :PARETO_F ,'
      '             :PARETO_M,'
      '             :CRITICALITY_1 ,'
      '             :CRITICALITY_2 ,'
      '             :CRITICALITY_3 ,'
      '             :CRITICALITY_4 ,'
      '             :CRITICALITY_5 ,'
      '             :STOCKED ,'
      '             :NONSTOCKED ,'
      '             :PARETO_X ,'
      '             :GENERICPARENTS ,'
      '             :GENERICCHILDREN ,'
      '             :EXCLUDEMAJOR ,'
      '             :EXCLUdEMINOR1 ,'
      '             :EXCLUDEMINOR2 ,'
      '             :EXCLUDESUPPLIER ,'
      '             :TEMPLATETYPE ,'
      '             :REPORTCATEGORIES ,'
      '             :GENERICNONE ,'
      '             :EXPEDITE ,'
      '             :DEEXPEDITE  ,'
      '             :EXCLUDEREPORTCATEGORY  '
      '     do begin'
      '       suspend;'
      '     end'
      '     '
      '  for select t.templateno,'
      '             u.UserName,'
      '             '#39'Minor Group2'#39',  '
      '             t.description,'
      '             '#39'Minor Group2'#39','
      '             gm2.GroupCode,'
      '             gm2.Description,'
      '             t.PARETO_A,'
      '             t.PARETO_B ,'
      '             t.PARETO_C ,'
      '             t.PARETO_D ,'
      '             t.PARETO_E ,'
      '             t.PARETO_F ,'
      '             t.PARETO_M,'
      '             t.CRITICALITY_1 ,'
      '             t.CRITICALITY_2 ,'
      '             t.CRITICALITY_3 ,'
      '             t.CRITICALITY_4 ,'
      '             t.CRITICALITY_5 ,'
      '             t.STOCKED ,'
      '             t.NONSTOCKED ,'
      '             t.PARETO_X ,'
      '             t.GENERICPARENTS ,'
      '             t.GENERICCHILDREN ,'
      '             t.EXCLUDEMAJOR ,'
      '             t.EXCLUdEMINOR1 ,'
      '             t.EXCLUDEMINOR2 ,'
      '             t.EXCLUDESUPPLIER ,'
      '             t.TEMPLATETYPE ,'
      '             t.REPORTCATEGORIES ,'
      '             t.GENERICNONE ,'
      '             t.EXPEDITE ,'
      '             t.DEEXPEDITE  ,'
      '             t.EXCLUDEREPORTCATEGORY  '
      ''
      '      from template t'
      '      left join users u on u.userno=t.userno'
      
        '      left join tmplt_groups tg on t.templateno=tg.templateno an' +
        'd tg.GroupType="2"'
      '      left join GroupMinor2 gm2 on tg.GroupNo=gm2.GroupNo     '
      
        '     where u.username >= :FromUser and u.username <= :ToUser and' +
        ' t.MinorGroup2 ="Y"'
      
        '     into :TemplateNo, :UserName, :GroupType, :TemplateDesc, :Gr' +
        'oupTypeDesc, :GroupCode, :GroupDesc,'
      '             :PARETO_A,'
      '             :PARETO_B ,'
      '             :PARETO_C, '
      '             :PARETO_D ,'
      '             :PARETO_E ,'
      '             :PARETO_F ,'
      '             :PARETO_M,'
      '             :CRITICALITY_1 ,'
      '             :CRITICALITY_2 ,'
      '             :CRITICALITY_3 ,'
      '             :CRITICALITY_4 ,'
      '             :CRITICALITY_5 ,'
      '             :STOCKED ,'
      '             :NONSTOCKED ,'
      '             :PARETO_X ,'
      '             :GENERICPARENTS ,'
      '             :GENERICCHILDREN ,'
      '             :EXCLUDEMAJOR ,'
      '             :EXCLUdEMINOR1 ,'
      '             :EXCLUDEMINOR2 ,'
      '             :EXCLUDESUPPLIER ,'
      '             :TEMPLATETYPE ,'
      '             :REPORTCATEGORIES ,'
      '             :GENERICNONE ,'
      '             :EXPEDITE ,'
      '             :DEEXPEDITE  ,'
      '             :EXCLUDEREPORTCATEGORY  '
      '     do begin'
      '       suspend;'
      '     end'
      ''
      '  for select t.templateno,'
      '             u.UserName,'
      '             '#39'Supplier'#39',  '
      '             t.description,'
      '             '#39'Supplier'#39','
      '             s.SupplierCode,'
      '             s.SupplierName,'
      '             t.PARETO_A,'
      '             t.PARETO_B ,'
      '             t.PARETO_C ,'
      '             t.PARETO_D ,'
      '             t.PARETO_E ,'
      '             t.PARETO_F ,'
      '             t.PARETO_M,'
      '             t.CRITICALITY_1 ,'
      '             t.CRITICALITY_2 ,'
      '             t.CRITICALITY_3 ,'
      '             t.CRITICALITY_4 ,'
      '             t.CRITICALITY_5 ,'
      '             t.STOCKED ,'
      '             t.NONSTOCKED ,'
      '             t.PARETO_X ,'
      '             t.GENERICPARENTS ,'
      '             t.GENERICCHILDREN ,'
      '             t.EXCLUDEMAJOR ,'
      '             t.EXCLUdEMINOR1 ,'
      '             t.EXCLUDEMINOR2 ,'
      '             t.EXCLUDESUPPLIER ,'
      '             t.TEMPLATETYPE ,'
      '             t.REPORTCATEGORIES ,'
      '             t.GENERICNONE ,'
      '             t.EXPEDITE ,'
      '             t.DEEXPEDITE  ,'
      '             t.EXCLUDEREPORTCATEGORY  '
      '      from template t'
      '      left join users u on u.userno=t.userno'
      
        '      left join tmplt_groups tg on t.templateno=tg.templateno an' +
        'd tg.GroupType="S"'
      '      left join Supplier s on tg.GroupNo=s.Supplierno     '
      
        '     where u.username >= :FromUser and u.username <= :ToUser and' +
        ' t.Supplier ="Y"'
      
        '     into :TemplateNo, :UserName, :GroupType, :TemplateDesc, :Gr' +
        'oupTypeDesc, :GroupCode, :GroupDesc,'
      '             :PARETO_A,'
      '             :PARETO_B ,'
      '             :PARETO_C ,'
      '             :PARETO_D ,'
      '             :PARETO_E ,'
      '             :PARETO_F ,'
      '             :PARETO_M,'
      '             :CRITICALITY_1 ,'
      '             :CRITICALITY_2 ,'
      '             :CRITICALITY_3 ,'
      '             :CRITICALITY_4 ,'
      '             :CRITICALITY_5 ,'
      '             :STOCKED ,'
      '             :NONSTOCKED ,'
      '             :PARETO_X ,'
      '             :GENERICPARENTS ,'
      '             :GENERICCHILDREN ,'
      '             :EXCLUDEMAJOR ,'
      '             :EXCLUdEMINOR1 ,'
      '             :EXCLUDEMINOR2 ,'
      '             :EXCLUDESUPPLIER ,'
      '             :TEMPLATETYPE ,'
      '             :REPORTCATEGORIES ,'
      '             :GENERICNONE ,'
      '             :EXPEDITE ,'
      '             :DEEXPEDITE  ,'
      '             :EXCLUDEREPORTCATEGORY  '
      '     do begin'
      '       suspend;'
      '     end'
      ''
      ''
      '  for select t.templateno,'
      '             u.UserName,'
      '             '#39'None'#39',  '
      '             t.description,'
      '             '#39'None'#39','
      '             '#39'None'#39','
      '             '#39'None'#39','
      '             t.PARETO_A,'
      '             t.PARETO_B ,'
      '             t.PARETO_C ,'
      '             t.PARETO_D ,'
      '             t.PARETO_E ,'
      '             t.PARETO_F ,'
      '             t.PARETO_M,'
      '             t.CRITICALITY_1 ,'
      '             t.CRITICALITY_2 ,'
      '             t.CRITICALITY_3 ,'
      '             t.CRITICALITY_4 ,'
      '             t.CRITICALITY_5 ,'
      '             t.STOCKED ,'
      '             t.NONSTOCKED ,'
      '             t.PARETO_X ,'
      '             t.GENERICPARENTS ,'
      '             t.GENERICCHILDREN ,'
      '             t.EXCLUDEMAJOR ,'
      '             t.EXCLUdEMINOR1 ,'
      '             t.EXCLUDEMINOR2 ,'
      '             t.EXCLUDESUPPLIER ,'
      '             t.TEMPLATETYPE ,'
      '             t.REPORTCATEGORIES ,'
      '             t.GENERICNONE ,'
      '             t.EXPEDITE ,'
      '             t.DEEXPEDITE  ,'
      '             t.EXCLUDEREPORTCATEGORY  '
      '      from template t'
      '      left join users u on u.userno=t.userno'
      
        '     where u.username >= :FromUser and u.username <= :ToUser and' +
        ' (t.Supplier <>"Y" and t.MinorGroup2 <> "Y" and t.MinorGroup1 <>' +
        ' "Y" and t.MajorGroup <> "Y" and t.reportcategories <> "Y")'
      
        '     into :TemplateNo, :UserName, :GroupType, :TemplateDesc, :Gr' +
        'oupTypeDesc, :GroupCode, :GroupDesc,'
      '             :PARETO_A,'
      '             :PARETO_B ,'
      '             :PARETO_C ,'
      '             :PARETO_D ,'
      '             :PARETO_E ,'
      '             :PARETO_F ,'
      '             :PARETO_M,'
      '             :CRITICALITY_1 ,'
      '             :CRITICALITY_2 ,'
      '             :CRITICALITY_3 ,'
      '             :CRITICALITY_4 ,'
      '             :CRITICALITY_5 ,'
      '             :STOCKED ,'
      '             :NONSTOCKED ,'
      '             :PARETO_X ,'
      '             :GENERICPARENTS ,'
      '             :GENERICCHILDREN ,'
      '             :EXCLUDEMAJOR ,'
      '             :EXCLUdEMINOR1 ,'
      '             :EXCLUDEMINOR2 ,'
      '             :EXCLUDESUPPLIER ,'
      '             :TEMPLATETYPE ,'
      '             :REPORTCATEGORIES ,'
      '             :GENERICNONE ,'
      '             :EXPEDITE ,'
      '             :DEEXPEDITE  ,'
      '             :EXCLUDEREPORTCATEGORY  '
      '     do begin'
      '       suspend;'
      '     end'
      '     '
      'end')
    Transaction = trnOptimiza
    Left = 224
    Top = 256
  end
  object qryTemplateByUser: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from up_get_Templates(:aUserName)')
    Left = 40
    Top = 216
    ParamData = <
      item
        DataType = ftString
        Name = 'aUserName'
        ParamType = ptUnknown
      end>
  end
  object qryFindTemplate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select TemplateNo, Description'
      '  From Template'
      'where UserNo = :UserNoTo'
      '          and Description  = (Select Description'
      '  from Template where TemplateNo = :TemplateNo'
      '      and UserNo = :UserNoFrom)')
    Left = 48
    Top = 296
    ParamData = <
      item
        DataType = ftInteger
        Name = 'UserNoTo'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'TemplateNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'UserNoFrom'
        ParamType = ptUnknown
      end>
  end
  object qryDeleteTemplate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Delete from Template where'
      '  TemplateNo = :TemplateNo'
      '  and UserNo = :UserNo')
    Left = 56
    Top = 352
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TemplateNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'UserNo'
        ParamType = ptUnknown
      end>
  end
  object qryDropProc: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Drop procedure up_copyusertemplate ')
    Transaction = trnOptimiza
    Left = 208
    Top = 136
  end
  object qryFindReportTemplate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select '
      '         rt.ReportTemplateNo,'
      '          rt.Description as ReportTemplate, '
      '         r.Description as ReportName'
      '  From ReportTemplate rt'
      'left join Reports r on rt.ReportNo=r.ReportNo'
      'where rt.ItemTemplateNo = :TemplateNo'
      '')
    Left = 176
    Top = 344
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TemplateNo'
        ParamType = ptUnknown
      end>
  end
  object srcRepCats: TDataSource
    DataSet = qryRepCats
    Left = 24
    Top = 104
  end
  object qryRepCats: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from ReportCategoryType'
      'Order By Description')
    Left = 24
    Top = 160
  end
  object qryDelFromTemplate: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Delete from Tmplt_REpCats'
      '  where ReportCategoryType = :RepCatType'
      '   and ReportCategoryNo >= :RepCatNo1'
      '  and ReportCategoryNo <= :RepCatNo2'
      '  ')
    Transaction = trnOptimiza
    Left = 40
    Top = 48
  end
  object qryRepCat: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = srcRepCats
    SQL.Strings = (
      'Select * from ReportCategory'
      '  where ReportCategoryType = :ReportCategoryType'
      'Order by Description')
    Left = 88
    Top = 160
    ParamData = <
      item
        DataType = ftInteger
        Name = 'REPORTCATEGORYTYPE'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object srcRepCat: TDataSource
    DataSet = qryRepCat
    Left = 88
    Top = 112
  end
  object qryAssFromTemplate: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Update Tmplt_REpCats'
      '  Set ReportCategoryType = :RepCatTypeTO,'
      '       ReportCategoryNo = :RepCatNoTO'
      '  where TemplateNo = :TemplateNo'
      '   and ReportCategoryType = :RepCatTypeFM'
      '   and ReportCategoryNo = :RepCatNoFM'
      '  ')
    Transaction = trnOptimiza
    Left = 168
    Top = 408
  end
  object srcRepCats2: TDataSource
    DataSet = qryRepCats2
    Left = 152
    Top = 464
  end
  object qryRepCats2: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from ReportCategoryType'
      'Order By Description')
    Left = 152
    Top = 520
  end
  object srcRepCat2: TDataSource
    DataSet = qryRepCat2
    Left = 216
    Top = 472
  end
  object qryRepCat2: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = srcRepCats2
    SQL.Strings = (
      'Select * from ReportCategory'
      '  where ReportCategoryType = :ReportCategoryType'
      'Order by Description')
    Left = 216
    Top = 520
    ParamData = <
      item
        DataType = ftInteger
        Name = 'REPORTCATEGORYTYPE'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object qryDelFromTmplt: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Delete '
      'from Tmplt_REpCats'
      '  where TemplateNo = :TemplateNo'
      '       and ReportCategoryType = :RepCatTypeFM'
      '       and ReportCategoryNo = :RepCatNoFM')
    Transaction = trnOptimiza
    Left = 312
    Top = 472
  end
  object qryTmpltList: TIBSQL
    Database = dbOptimiza
    ParamCheck = True
    SQL.Strings = (
      'Select TemplateNo '
      'from Tmplt_REpCats'
      '  where ReportCategoryType = :RepCatTypeFM'
      '       and ReportCategoryNo = :RepCatNoFM'
      '')
    Transaction = trnOptimiza
    Left = 304
    Top = 424
  end
  object qryTmpltFind: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select TemplateNo '
      'from Tmplt_REpCats'
      '  where TemplateNo = :TemplateNo'
      '      and ReportCategoryType = :RepCatTypeTO'
      '       and ReportCategoryNo = :RepCatNoTO'
      '')
    Left = 440
    Top = 424
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TemplateNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'RepCatTypeTO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'RepCatNoTO'
        ParamType = ptUnknown
      end>
  end
  object qryDropProc1: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'Drop procedure UP_GET_TEMPLATES')
    Transaction = trnOptimiza
    Left = 240
    Top = 312
  end
  object qryReportTemplate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select rep.DEscription, rt.description as RepTemplateDescr,'
      '       u.UserName,'
      '       t.Description as TemplateDescr '
      '       from Reports rep'
      '       join ReportTemplate rt on rep.ReportNo=rt.ReportNo'
      '       join Users u on rt.UserNo=u.UserNo'
      '       join Template t on rt.ItemTemplateNo=t.TemplateNo'
      'where u.UserNo >= :StartUserNo'
      'and u.UserNo <= :EndUserNo'
      ''
      'Order by 1,2,3')
    Left = 40
    Top = 440
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'StartUserNo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EndUserNo'
        ParamType = ptUnknown
      end>
  end
  object qryUserList: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select u.*, l.description as DefaultLocation '
      'from Users u'
      'left join location l on u.LocationNo=l.LocationNo'
      'Order By UserName')
    Left = 32
    Top = 504
  end
  object qryDeleteReportTemplate: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Delete'
      '  From ReportTemplate'
      'where TemplateNo = :TemplateNo')
    Left = 72
    Top = 392
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TemplateNo'
        ParamType = ptUnknown
      end>
  end
  object qryFindTemplateName: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select TemplateNo, Description'
      '  From Template'
      'where UserNo = :UserNoTo'
      '          and Description  =  :aDescr')
    Left = 320
    Top = 536
    ParamData = <
      item
        DataType = ftInteger
        Name = 'UserNoTo'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'aDescr'
        ParamType = ptUnknown
      end>
  end
end
