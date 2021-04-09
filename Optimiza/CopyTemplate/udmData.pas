unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery;

type
  TdmData = class(TdmOptimiza)
    qryUser: TIBQuery;
    srcUser: TDataSource;
    qryTemplate: TIBQuery;
    srcTemplate: TDataSource;
    qryCheckProc: TIBSQL;
    qryCreateProc: TIBSQL;
    prcCopy: TIBStoredProc;
    qryCheckProc1: TIBSQL;
    qryCreateProc1: TIBSQL;
    qryTemplateByUser: TIBQuery;
    qryFindTemplate: TIBQuery;
    qryDeleteTemplate: TIBQuery;
    qryDropProc: TIBSQL;
    qryFindReportTemplate: TIBQuery;
    srcRepCats: TDataSource;
    qryRepCats: TIBQuery;
    qryDelFromTemplate: TIBSQL;
    qryRepCat: TIBQuery;
    srcRepCat: TDataSource;
    qryAssFromTemplate: TIBSQL;
    srcRepCats2: TDataSource;
    qryRepCats2: TIBQuery;
    srcRepCat2: TDataSource;
    qryRepCat2: TIBQuery;
    qryDelFromTmplt: TIBSQL;
    qryTmpltList: TIBSQL;
    qryTmpltFind: TIBQuery;
    qryDropProc1: TIBSQL;
    qryReportTemplate: TIBQuery;
    qryUserList: TIBQuery;
    qryDeleteReportTemplate: TIBQuery;
    qryFindTemplateName: TIBQuery;
  private
    { Private declarations }

  public
    { Public declarations }
     FAdminUser:Boolean;
    procedure OpenTemplate(UserNo:Integer);
    function CheckInstall: Boolean;
    procedure CopyTemplate(FromUserNo,ToUserNo,TemplateNo:Integer;TemplateDescription: String);
    function FindSameTemplate(FromUserNo,ToUserNo,TemplateNo:Integer):Integer;
    function CheckRepInstall: Boolean;
    procedure OpenTemplateByUser(AUserName:String);
    procedure DeleteTemplate(UserNo,TemplateNo:Integer);
    function FindReportTemplate(TemplateNo: Integer):String;
    procedure DelRepCat(RepcatType,RepcatNo1,RepcatNo2:Integer);
    procedure AssignRepCat(RepcatTypeFM,RepcatNoFM,RepcatTypeTO,RepcatNoTO:Integer);
    procedure Upgrade;
    procedure Upgrade1;
    procedure OpenUser;
    procedure OpenReportTemplate(UserNo:Integer);
    procedure OpenUserList;
    function FindSameTemplateName(FromUserNo, ToUserNo:Integer;TemplateDescription: String):Integer;
  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

{ TdmData }

procedure TdmData.OpenTemplate(UserNo: Integer);
begin
  with qryTemplate do
  begin
    Close;
    ParamByName('UserNo').AsInteger := UserNo;
    Open;
  end;

end;

function TdmData.CheckInstall: Boolean;
var
  TempStr:String;
begin

  Result := True;

  try

    if not trnOptimiza.InTransaction then
      trnOptimiza.StartTransaction;

    qryCheckProc.ExecQuery;

    if Trim(qryCheckProc.FieldByName('rdb$Procedure_Name').AsString) <> 'UP_COPYUSERTEMPLATE' then
    begin
      Result := False;

      if MessageDlg('This appears to be a new installation! '#10+
                'Do you wish to install associated procedures?',mtConfirmation,
                [mbYes,mbNo],0) = mrYes then
      begin
        qryCreateProc.ExecQuery;
        qryCreateProc.Close;
        MessageDlg('Procedure installed successfully!',mtConfirmation,[mbOK],0);
        Result := True;
      end;

      qryCheckProc.Close;

    end
    else
    begin
      //does exist check for upgrade
      TempStr := Trim(qryCheckProc.FieldbyName('RDB$Procedure_Source').AsString);
      qryCheckProc.Close;

      if (TempStr = '') or (Pos('Ver 2.1',TempStr) = 0) then
      begin

        if MessageDlg('Older version of UP_COPYUSERTEMPLATE! '#10+
                  'Do you wish to upgrade procedure?',mtConfirmation,
                  [mbYes,mbNo],0) = mrYes then
        begin
          Upgrade;
        end;


      end;

    end;



    trnOptimiza.Commit;
    trnOptimiza.StartTransaction;


  except
    MessageDlg('Error installing tables and procedures, call Optimiza Consultant.',
          mtError,[mbOK],0);
    Result := True;
  end;


end;

procedure TdmData.CopyTemplate(FromUserNo, ToUserNo, TemplateNo: Integer;TemplateDescription: String);
begin
  with prcCopy do
  begin
    if TemplateDescription = '' then
      ParamByName('UseDesc').AsString := 'N'
    else
      ParamByName('UseDesc').AsString := 'Y';

    ParamByName('TemplateNo').AsInteger := TemplateNo;
    ParamByName('UserNoFrom').AsInteger := FromUserNo;
    ParamByName('UserNoTo').AsInteger := ToUserNo;
    ParamByName('NewDescription').AsString := TemplateDescription;
    ExecProc;
    Close;
  end;

end;

function TdmData.CheckRepInstall: Boolean;
var
  TempStr:String;
begin

  Result := True;

  try
    if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

    qryCheckProc1.ExecQuery;

    if Trim(qryCheckProc1.FieldByName('rdb$Procedure_Name').AsString) <> 'UP_GET_TEMPLATES' then
    begin
      qryCreateProc1.ExecQuery;
      qryCreateProc1.Close;
      Result := True;
    end
    else
    begin
      //does exist check for upgrade
      TempStr := Trim(qryCheckProc1.FieldbyName('RDB$Procedure_Source').AsString);
      qryCheckProc1.Close;

      if (TempStr = '') or (Pos('Ver 2.0',TempStr) = 0) then
      begin

        if MessageDlg('Older version of UP_GET_TEMPLATES! '#10+
                  'Do you wish to upgrade procedure?',mtConfirmation,
                  [mbYes,mbNo],0) = mrYes then
        begin
          Upgrade1;
        end;


      end;

    end;




    trnOptimiza.Commit;
    trnOptimiza.StartTransaction;


  except
    MessageDlg('Error installing tables and procedures, call Optimiza Consultant.',
          mtError,[mbOK],0);
    Result := True;
  end;


end;

procedure TdmData.OpenTemplateByUser(AUserName: String);
begin
  with qryTemplateByUser do
  begin
    Close;
    ParamByNAme('AUserName').asString := UpperCase(AUserName);
    Open;
  end;

end;

function TdmData.FindSameTemplate(FromUserNo, ToUserNo,
  TemplateNo: Integer):Integer;
begin
  Result := -1;

  with qryFindTemplate do
  begin
    ParamByName('TemplateNo').AsInteger := TemplateNo;
    ParamByName('UserNoFrom').AsInteger := FromUserNo;
    ParamByName('UserNoTo').AsInteger := ToUserNo;
    Open;

    if not FieldByName('TemplateNo').IsNull then
      Result := FieldByName('TemplateNo').asInteger;

    Close;
  end;

end;

function TdmData.FindSameTemplateName(FromUserNo, ToUserNo:Integer;
  TemplateDescription: String):Integer;
begin
  Result := -1;

  with qryFindTemplateName do
  begin
    ParamByName('aDescr').AsString := TemplateDescription;
    //ParamByName('UserNoFrom').AsInteger := FromUserNo;
    ParamByName('UserNoTo').AsInteger := ToUserNo;
    Open;

    if not FieldByName('TemplateNo').IsNull then
      Result := FieldByName('TemplateNo').asInteger;

    Close;
  end;

end;

procedure TdmData.DeleteTemplate(UserNo, TemplateNo: Integer);
begin
todo need to check that no reports are using the template
  with qryDeleteTemplate do
  begin
    ParamByName('TemplateNo').AsInteger := TemplateNo;
    ParamByName('UserNo').AsInteger := UserNo;
    ExecSQL;
    Close;
  end;

end;

procedure TdmData.Upgrade;
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  qryDropProc.ExecQuery;
  trnOptimiza.Commit;
  trnOptimiza.StartTransaction;

  qryCreateProc.ExecQuery;
  trnOptimiza.Commit;
  trnOptimiza.StartTransaction;

  ShowMessage('Upgrade Complete');
end;

procedure TdmData.Upgrade1;
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  qryDropProc1.ExecQuery;
  trnOptimiza.Commit;
  trnOptimiza.StartTransaction;

  qryCreateProc1.ExecQuery;
  trnOptimiza.Commit;
  trnOptimiza.StartTransaction;

  ShowMessage('Upgrade Complete');
end;

function TdmData.FindReportTemplate(TemplateNo: Integer):String;
begin
  Result := '';

  with qryFindReportTemplate do
  begin
    ParamByName('TemplateNo').AsInteger := TemplateNo;
    Open;

    if not FieldByName('ReportTemplateNo').IsNull then
      Result := 'It is Asociated with Report: ' + FieldByName('ReportName').asString + #10 +
                'Report Template: ' +FieldByName('ReportTemplate').asString;

    Close;
  end;

end;

procedure TdmData.DelRepCat(RepcatType,RepcatNo1,RepcatNo2:Integer);
begin

  with qryDelFromTemplate do
  begin
    ParamByName('RepCatType').AsInteger := RepCatTYpe;
    ParamByName('RepCatNo1').AsInteger := RepCatNo1;
    ParamByName('RepCatNo2').AsInteger := RepCatNo2;

    ExecQuery;
    trnOptimiza.Commit;
    trnOptimiza.StartTransaction;


  end;

end;

procedure TdmData.AssignRepCat(RepcatTypeFM,RepcatNoFM,RepcatTypeTO,RepcatNoTO:Integer);
var
  TemplateNo:Integer;
  FoundTemplate:Boolean;
begin


  //Get all the listed changes
  qryTmpltList.close;
  qryTmpltList.ParamByName('RepCatTypeFM').AsInteger := RepCatTypeFM;
  qryTmpltList.ParamByName('RepCatNoFM').AsInteger := RepCatNoFM;

  qryTmpltList.ExecQuery;

  while not qryTmpltList.eof do
  begin

    with qryTmpltFind do
    begin
      TemplateNo := qryTmpltList.FieldByName('TemplateNo').AsInteger;
      FoundTemplate := False;
      Close;
      //First See if target one already exist
      ParamByName('TemplateNo').AsInteger := qryTmpltList.FieldByName('TemplateNo').AsInteger;
      ParamByName('RepCatTypeTO').AsInteger := RepCatTypeTO;
      ParamByName('RepCatNoTO').AsInteger := RepCatNoTO;
      Open;

      if not qryTmpltFind.FieldByName('TemplateNo').isNull then
        if qryTmpltFind.FieldByName('TemplateNo').AsInteger > 0 then
        begin
          TemplateNo := qryTmpltFind.FieldByName('TemplateNo').AsInteger ;
          FoundTemplate := True;
        end;

    end;


    //if dound then simply remove old one
    if FoundTemplate then
    begin
        with qryDelFromTmplt do
        begin
          Close;
          ParamByName('TemplateNo').AsInteger := TemplateNo;
          ParamByName('RepCatTypeFM').AsInteger := RepCatTYpeFM;
          ParamByName('RepCatNoFM').AsInteger := RepCatNoFM;

          ExecQuery;

        end;


    end
    else
    begin

        with qryAssFromTemplate do
        begin
          Close;
          ParamByName('TemplateNo').AsInteger := qryTmpltList.FieldByName('TemplateNo').AsInteger;
          ParamByName('RepCatTypeFM').AsInteger := RepCatTYpeFM;
          ParamByName('RepCatNoFM').AsInteger := RepCatNoFM;
          ParamByName('RepCatTypeTO').AsInteger := RepCatTYpeTO;
          ParamByName('RepCatNoTO').AsInteger := RepCatNoTO;

          ExecQuery;


        end;

    end;

    qryTmpltList.Next;

  end;

  trnOptimiza.Commit;
  trnOptimiza.StartTransaction;

end;

procedure TdmData.OpenUser;
begin
  qryUser.Close;

  //query uses <>
  //  therefore when FAdminuser is false then display all users <> ADMIN.
  if (FAdminUser = False) then
    qryUser.ParamByName('UserName').AsString := 'ADMIN'   //query uses <>
  else
    qryUser.ParamByName('UserName').AsString := 'ALLOW_ALL_USERS_X';

  qryUser.Open;

end;

procedure TdmData.OpenReportTemplate(UserNo: Integer);
var
  StartUserNo, EndUserNo:Integer;
begin

  if (UserNo = -1) then
  begin
    StartUserNo := 0;
    EndUserNo := 999999;
  end
  else
  begin
    StartUserNo := UserNo;
    EndUserNo := UserNo;

  end;

  with qryReportTemplate do
  begin
    Close;
    ParamByName('StartUserNo').AsInteger := StartUserNo;
    ParamByName('EndUserNo').AsInteger := EndUserNo;
    Open;
  end;

end;

procedure TdmData.OpenUserList;
begin

  with qryUserList do
  begin
    Open;
  end;

end;

end.
