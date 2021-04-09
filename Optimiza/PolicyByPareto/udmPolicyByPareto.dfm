inherited dmPolicyByPareto: TdmPolicyByPareto
  OldCreateOrder = True
  Left = 470
  Top = 222
  inherited dbOptimiza: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Program Files\Execulink\Optimiza\Berlei\Database\BERLEI.GDB'
    AllowStreamedConnected = True
  end
  object qryInsertNew: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Insert Into'
      '  UT_PolicyByPareto (UPDATESL, UPDATERC, UPDATERP, '
      '        SL_A, SL_B, SL_C, SL_D, SL_E, SL_F, '
      '        RC_A,RC_B, RC_C, RC_D, RC_E, RC_F, '
      '       RP_A, RP_B, RP_C, RP_D, RP_E, RP_F)'
      'values'
      '  ('#39'N'#39','#39'N'#39','#39'N'#39',65,65,65,65,65,65,1,1,1,1,1,1,1,1,1,1,1,1)')
    Left = 120
    Top = 88
  end
  object qryPolicyByPareto: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from UT_PolicyByPareto')
    UpdateObject = updPolicyByPareto
    Left = 88
    Top = 144
  end
  object srcPolicyByPareto: TDataSource
    DataSet = qryPolicyByPareto
    Left = 184
    Top = 152
  end
  object updPolicyByPareto: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  UPDATESL,'
      '  UPDATERC,'
      '  UPDATERP,'
      '  SL_A,'
      '  SL_B,'
      '  SL_C,'
      '  SL_D,'
      '  SL_E,'
      '  SL_F,'
      '  RC_A,'
      '  RC_B,'
      '  RC_C,'
      '  RC_D,'
      '  RC_E,'
      '  RC_F,'
      '  RP_A,'
      '  RP_B,'
      '  RP_C,'
      '  RP_D,'
      '  RP_E,'
      '  RP_F'
      'from UT_PolicyByPareto ')
    ModifySQL.Strings = (
      'update UT_PolicyByPareto'
      'set'
      '  UPDATESL = :UPDATESL,'
      '  UPDATERC = :UPDATERC,'
      '  UPDATERP = :UPDATERP,'
      '  SL_A = :SL_A,'
      '  SL_B = :SL_B,'
      '  SL_C = :SL_C,'
      '  SL_D = :SL_D,'
      '  SL_E = :SL_E,'
      '  SL_F = :SL_F,'
      '  RC_A = :RC_A,'
      '  RC_B = :RC_B,'
      '  RC_C = :RC_C,'
      '  RC_D = :RC_D,'
      '  RC_E = :RC_E,'
      '  RC_F = :RC_F,'
      '  RP_A = :RP_A,'
      '  RP_B = :RP_B,'
      '  RP_C = :RP_C,'
      '  RP_D = :RP_D,'
      '  RP_E = :RP_E,'
      '  RP_F = :RP_F')
    InsertSQL.Strings = (
      'insert into UT_PolicyByPareto'
      
        '  (UPDATESL, UPDATERC, UPDATERP, SL_A, SL_B, SL_C, SL_D, SL_E, S' +
        'L_F, '
      'RC_A, '
      
        '   RC_B, RC_C, RC_D, RC_E, RC_F, RP_A, RP_B, RP_C, RP_D, RP_E, R' +
        'P_F)'
      'values'
      
        '  (:UPDATESL, :UPDATERC, :UPDATERP, :SL_A, :SL_B, :SL_C, :SL_D, ' +
        ':SL_E, '
      
        '   :SL_F, :RC_A, :RC_B, :RC_C, :RC_D, :RC_E, :RC_F, :RP_A, :RP_B' +
        ', :RP_C, '
      '   :RP_D, :RP_E, :RP_F)')
    DeleteSQL.Strings = (
      'delete from UT_PolicyByPareto')
    Left = 168
    Top = 216
  end
  object qryRP: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'Select 1 as SortSeq, 1.00 as RC, "Monthly    " as Description fr' +
        'om Configuration'
      '  where ConfigurationNo = 100'
      
        '  Union Select 2 as SortSeq, 0.50 as RC, "Fortnightly" as Descri' +
        'ption from Configuration'
      '  where ConfigurationNo = 100'
      
        '  Union Select 3 as SortSeq, 0.25 as RC, "Weekly     " as Descri' +
        'ption from Configuration'
      '  where ConfigurationNo = 100'
      
        '  Union Select 4 as SortSeq, 0.05 as RC, "Daily      " as Descri' +
        'ption from Configuration'
      '  where ConfigurationNo = 100')
    Left = 184
    Top = 288
  end
  object srcRP: TDataSource
    DataSet = qryRP
    Left = 184
    Top = 336
  end
  object qryUpdate: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'execute procedure up_UpdatePolicyByPareto(:LocCode)')
    Left = 96
    Top = 272
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'LocCode'
        ParamType = ptUnknown
      end>
  end
  object qryGetProc: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select * from rdb$procedures where'
      'RDB$PROCEDURE_NAME = "UP_UPDATEPOLICYBYPARETO"')
    UniDirectional = True
    Left = 208
    Top = 24
  end
  object qryCreateTable: TIBQuery
    Database = dbOptimiza
    Transaction = trnOptimiza
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'create table ut_policybypareto('
      '     UPDATESL char(1),'
      '     UPDATERC char(1),'
      '     UPDATERP char(1),'
      '     SL_A double precision,'
      '     SL_B double precision,'
      '     SL_C double precision,'
      '     SL_D double precision,'
      '     SL_E double precision,'
      '     SL_F double precision,'
      '     RC_A double precision,'
      '     RC_B double precision,'
      '     RC_C double precision,'
      '     RC_D double precision,'
      '     RC_E double precision,'
      '     RC_F double precision,'
      '     RP_A double precision,'
      '     RP_B double precision,'
      '     RP_C double precision,'
      '     RP_D double precision,'
      '     RP_E double precision,'
      '     RP_F double precision);')
    Left = 32
    Top = 80
  end
  object qryCreateProc: TIBSQL
    Database = dbOptimiza
    ParamCheck = False
    SQL.Strings = (
      'create procedure up_updatepolicybypareto(LocCode VarChar(15)) '
      'as'
      'declare variable xUpdateSL char(1);'
      'declare variable xUpdateRC char(1);'
      'declare variable xUpdateRP char(1);'
      'declare variable xSL_A double precision;'
      'declare variable xSL_B double precision;'
      'declare variable xSL_C double precision;'
      'declare variable xSL_D double precision;'
      'declare variable xSL_E double precision;'
      'declare variable xSL_F double precision;'
      'declare variable xRC_A double precision;'
      'declare variable xRC_B double precision;'
      'declare variable xRC_C double precision;'
      'declare variable xRC_D double precision;'
      'declare variable xRC_E double precision;'
      'declare variable xRC_F double precision;'
      'declare variable xRP_A double precision;'
      'declare variable xRP_B double precision;'
      'declare variable xRP_C double precision;'
      'declare variable xRP_D double precision;'
      'declare variable xRP_E double precision;'
      'declare variable xRP_F double precision;'
      'declare variable xLocNo Integer;'
      ''
      'begin'
      '  Select '
      '    UPDATESL, UPDATERC, UPDATERP,'
      '    SL_A, SL_B, SL_C, SL_D, SL_E, SL_F,'
      '    RC_A, RC_B, RC_C, RC_D, RC_E, RC_F,'
      '    RP_A, RP_B, RP_C, RP_D, RP_E, RP_F'
      '   from UT_PolicyByPareto '
      '    into'
      '      :xUPDATESL, :xUPDATERC, :xUPDATERP,'
      '      :xSL_A, :xSL_B, :xSL_C, :xSL_D, :xSL_E, :xSL_F,'
      '      :xRC_A, :xRC_B, :xRC_C, :xRC_D, :xRC_E, :xRC_F,'
      '      :xRP_A, :xRP_B, :xRP_C, :xRP_D, :xRP_E, :xRP_F;'
      '  '
      '  Select LocationNo from Location'
      '    where LocationCode = :LocCode'
      '    into xLocNo;'
      '          '
      '  if (xUpdateSL = '#39'Y'#39') then'
      '  begin'
      '    Update Item Set ServiceLevel = :xSL_A'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'A'#39';'
      '    Update Item Set ServiceLevel = :xSL_B'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'B'#39';'
      '    Update Item Set ServiceLevel = :xSL_C'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'C'#39';'
      '    Update Item Set ServiceLevel = :xSL_D'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'D'#39';'
      '    Update Item Set ServiceLevel = :xSL_E'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'E'#39';'
      '    Update Item Set ServiceLevel = :xSL_F'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'F'#39';'
      '  '
      '  '
      '  end'
      '  '
      '  if (xUpdateRC = '#39'Y'#39') then'
      '  begin'
      '    Update Item Set ReplenishmentCycle = :xRC_A'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'A'#39';'
      '    Update Item Set ReplenishmentCycle = :xRC_B'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'B'#39';'
      '    Update Item Set ReplenishmentCycle = :xRC_C'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'C'#39';'
      '    Update Item Set ReplenishmentCycle = :xRC_D'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'D'#39';'
      '    Update Item Set ReplenishmentCycle = :xRC_E'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'E'#39';'
      '    Update Item Set ReplenishmentCycle = :xRC_F'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'F'#39';'
      '  '
      '  end'
      '        '
      '  if (xUpdateRP = '#39'Y'#39') then'
      '  begin'
      '    Update Item Set ReviewPeriod = :xRP_A'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'A'#39';'
      '    Update Item Set ReviewPeriod= :xRP_B'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'B'#39';'
      '    Update Item Set ReviewPeriod = :xRP_C'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'C'#39';'
      '    Update Item Set ReviewPeriod = :xRP_D'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'D'#39';'
      '    Update Item Set ReviewPeriod = :xRP_E'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'E'#39';'
      '    Update Item Set ReviewPeriod = :xRP_F'
      
        '      where LocationNo = :xLocNo and ManualPolicy <> '#39'Y'#39' and Par' +
        'etoCategory = '#39'F'#39';'
      '  '
      '  end'
      ''
      ''
      'end'
      '')
    Transaction = trnOptimiza
    Left = 208
    Top = 80
  end
end
