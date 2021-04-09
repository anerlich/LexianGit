unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery;

type
  TdmData = class(TdmOptimiza)
    qryUsers: TIBQuery;
    qryTemplate: TIBQuery;
    srcTemplate: TDataSource;
    srcUsers: TDataSource;
    qryTemplateName: TIBQuery;
    qryAlter: TIBSQL;
    qryExec: TIBSQL;
    qryGetLocalAdmin: TIBQuery;
    qryDrop: TIBSQL;
    trnOther: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    WhereClause, JoinClause : TStringList;
    FProcExists:Boolean;
    FCount:Integer;
  public
    { Public declarations }
    function BuildStart(TemplateNo:Integer):String;
    procedure BuildBody(LocNo:Integer;LT,RC,RP,TSL,SS,MOQ,ORM:Real;ResetTSL:Boolean=False);
    procedure BuildEnd;
    procedure ExecuteProcedure;
    function GetLocalAdminNo:Integer;
    function GetLocationNo(Location: String):Integer;
  end;

var
  dmData: TdmData;

implementation

uses uStatus;

{$R *.dfm}


{ TdmData }

function TdmData.BuildStart(TemplateNo:Integer):String;
var
  UserNo:Integer;
begin

  Result := '';

  UserNo := -1;
  WhereClause := TStringList.Create;
  JoinClause := TStringList.Create;

  if TemplateNo >= 0 then
  begin

    with dmData.qryTemplateName do
    begin
      ParamByName('TemplateNo').AsInteger := TemplateNo;
      Open;

      if not FieldByName('UserNo').IsNull then
        UserNo := FieldByName('UserNo').asInteger;

      Close;

    end;


    //Call this with locno =-1 so the where clause does not return
    //   location statement as we will deal with locations in our own way
    //

    //Must be valid user
    if UserNo >= 0 then
      dmData.CreateTemplateSQL(TemplateNo,
                        UserNo,
                        -1,
                        WhereClause,
                        JoinClause)
    else
      Result := 'Template not found';


  end
  else
  begin
    WhereClause.Add('Where 1 = 1 ')
  end;


  if Result='' then
  begin
    //Create proc if needed
    try

      FProcExists := true;

      if not trnOptimiza.InTransaction then
        trnOptimiza.StartTransaction;

      if not FProcExists then
      begin

        with qryAlter do
        begin
          SQL.Clear;
          SQL.Add('Create procedure up_policy_dynamic');
          SQL.Add('as                               ');
          SQL.Add('declare variable ItemNo Integer; ');
          SQL.Add('begin                            ');
          SQL.Add('   suspend;                    ');
          SQL.Add('end                            ');

          qryAlter.ExecQuery;

        end;

        trnOptimiza.Commit;
        trnOptimiza.StartTransaction;
        FProcExists := True;
      end;


    except
        FProcExists := True;
        trnOptimiza.Commit;
        trnOptimiza.StartTransaction;
    end;

    //Build header only
    with qryAlter do
    begin
      SQL.Clear;
      SQL.Add('Alter procedure up_policy_dynamic');
      Inc(FCount);
      //SQL.Add('Create procedure up_policy_dynamic');
      SQL.Add('as                               ');
      SQL.Add('declare variable ItemNo Integer; ');
      SQL.Add('begin                            ');

    end;


  end;


end;

procedure TdmData.BuildBody(LocNo:Integer;LT,RC,RP,TSL,SS,MOQ,ORM:Real;ResetTSL:Boolean=False);
var
  PolicyStr:String;
begin
  PolicyStr := '';

  if LT > -1 then
    PolicyStr := '        LeadTime='+FloatToStr(LT);

  if RC > -1 then
  begin
    if PolicyStr <> '' then PolicyStr := PolicyStr + ',';

    PolicyStr := PolicyStr + 'ReplenishmentCycle='+FloatToStr(RC);

  end;

  if MOQ > -1 then
  begin
    if PolicyStr <> '' then PolicyStr := PolicyStr + ',';

    PolicyStr := PolicyStr +  '        MINIMUMORDERQUANTITY='+FloatToStr(MOQ);
  end;

  if ORM > -1 then
  begin
    if PolicyStr <> '' then PolicyStr := PolicyStr + ',';

    PolicyStr := PolicyStr + '        ORDERMULTIPLES='+FloatToStr(ORM);
  end;

  if RP> -1 then
  begin
    if PolicyStr <> '' then PolicyStr := PolicyStr + ',';

    PolicyStr := PolicyStr + 'ReviewPeriod='+FloatToStr(RP);

  end;

  if TSL> -1 then
  begin
    if PolicyStr <> '' then PolicyStr := PolicyStr + ',';

    PolicyStr := PolicyStr + 'ServiceLevel='+FloatToStr(TSL);

  end;

  if SS> -1 then
  begin
    if PolicyStr <> '' then PolicyStr := PolicyStr + ',';

    PolicyStr := PolicyStr + 'SafetyStock='+FloatToStr(SS);
    PolicyStr := PolicyStr + ',SafetyStockCalcInd="G"';

  end;

  if ResetTSL then
    PolicyStr := 'SafetyStockCalcInd="T"';


  with qryAlter do
  begin
    //Body loop
    SQL.Add('                                 ');
    SQL.Add('  for Select ItemNo from         ');
    SQL.Add('    Item i                       ');
    SQL.AddStrings(JoinClause);

    SQL.Add('                                 ');

    SQL.AddStrings(WhereClause);

    if LocNo > 0 then   //if -1 then all locations
      SQL.Add(' and i.locationNo='+IntToStr(LocNo));

    SQL.Add('    into :ItemNo                 ');
    SQL.Add('    do begin                     ');

    SQL.Add('      update Item set            ');
    SQL.Add(PolicyStr);
    SQL.Add('        where ItemNo = :ItemNo;  ');
    SQL.Add('    end                          ');
    SQL.Add('                                 ');
  end;
end;

procedure TdmData.BuildEnd;
begin

  with qryAlter do
  begin
    // End Body loop
    SQL.Add('end;                              ');
  end;

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  qryAlter.ExecQuery;
  trnOptimiza.Commit;
  trnOptimiza.StartTransaction;

  dbOptimiza.Close;
  dbOptimiza.Open;
end;

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  inherited;
  fProcExists := False;
  Fcount := 0;
end;

procedure TdmData.ExecuteProcedure;
begin
  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  qryExec.ExecQuery;

  trnOptimiza.Commit;
  trnOptimiza.StartTransaction;

end;

function TdmData.GetLocalAdminNo: Integer;
begin

  Result := -1;

  with qryGetLocalAdmin do
  begin
    Open;

    if FieldByName('UserNo').AsInteger > 0 then
      Result := FieldByName('UserNo').AsInteger;


    Close;
  end;

end;

function TdmData.GetLocationNo(Location: String):Integer;
begin
    With qryLocation do begin
      dmData.qryLocation.Active := False;
      ParamByName('iLocation').AsString := Location;
      Active := True;
      Result := FieldByName('LocationNo').AsInteger;
      Active := False;
    end;
end;

end.
