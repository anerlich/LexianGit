unit udmPolicyByPareto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, DB, IBCustomDataSet, IBDatabase, IBStoredProc,
  IBQuery, IBUpdateSQL, DBXpress, SqlExpr, IBSQL;

type
  TdmPolicyByPareto = class(TdmOptimiza)
    qryInsertNew: TIBQuery;
    qryPolicyByPareto: TIBQuery;
    srcPolicyByPareto: TDataSource;
    updPolicyByPareto: TIBUpdateSQL;
    qryRP: TIBQuery;
    srcRP: TDataSource;
    qryUpdate: TIBQuery;
    qryGetProc: TIBQuery;
    qryCreateTable: TIBQuery;
    qryCreateProc: TIBSQL;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CreateProc;
    function TableExist(TableName: String):Boolean;
  public
    { Public declarations }
    procedure OpenPolicy;
    procedure SetEditState;
    function inEdit: Boolean;
    procedure CommitData;
    procedure UpdatePolicy(ScheduleRun:Boolean;LocCode:String);
  end;

var
  dmPolicyByPareto: TdmPolicyByPareto;

implementation

uses uStatus;

{$R *.dfm}

{ TdmPolicyByPareto }

procedure TdmPolicyByPareto.OpenPolicy;
begin

  with qryPolicyByPareto do
  begin
    Open;

    if FieldByName('UpdateSL').AsString = '' then
    begin
      Close;
      qryInsertNew.ExecSQL;

      Open;
    end;

  end;

end;

procedure TdmPolicyByPareto.SetEditState;
begin
  if not (qryPolicyByPareto.State in [dsEdit]) then
     qryPolicyByPareto.Edit;

end;

procedure TdmPolicyByPareto.DataModuleCreate(Sender: TObject);
begin
  inherited;

  CreateProc;
  QryRp.Open;

end;

function TdmPolicyByPareto.inEdit: Boolean;
begin
  Result := (qryPolicyByPareto.State in [dsEdit]);

end;

procedure TdmPolicyByPareto.CommitData;
begin
  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  qryPolicyByPareto.Refresh;
  trnOptimiza.Commit;

  OpenPolicy;
  QryRp.Open;


end;

procedure TdmPolicyByPareto.UpdatePolicy(ScheduleRun:Boolean;LocCode:String);
var

  Save_Cursor:TCursor;
begin
  Save_Cursor := Screen.Cursor;

  Screen.Cursor := crSQLWait	;    { Show hourglass cursor }

  try
    qryUpdate.ParamByName('LocCode').AsString := LocCode;
    qryUpdate.Prepare;
    frmStatus.Show;
    frmStatus.refresh;
    qryUpdate.ExecSQL;

    Screen.Cursor := Save_Cursor;  { Always restore to normal }


    if ScheduleRun then
      fireevent('S')
    else
      MessageDlg('Update Complete !'#10#10+
                 'Please note that this update does not update'#10+
                 'Safety Stock, Wizard, Cockpit or any other data in Optimiza.'#10+
                 'Separate processes in the Daily Schedule will update these values.',mtConfirmation,[mbok],0);
  except
    Screen.Cursor := Save_Cursor;  { Always restore to normal }

    if ScheduleRun then
      fireevent('F')
    else
      MessageDlg('Update Failed !',mtError,[mbok],0);
  end;

  frmStatus.Hide;


end;

procedure TdmPolicyByPareto.CreateProc;
var
  Installed:Boolean;
begin

  Installed := False;

  try


    qryGetProc.Open;

    if Trim(qryGetProc.FieldByName('rdb$Procedure_Name').AsString) = 'UP_UPDATEPOLICYBYPARETO' then
      Installed := True;

    qryGetProc.Close;

  except

  end;

  if not Installed then
  begin
    if MessageDlg('Setup - Policy by Pareto'+#10+#10+
                   'This appears to be a new installation !'+#10+
                   'Do you wish to install the new tables and procedures?',
                   mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin

      try

        if not TableExist('UT_POLICYBYPARETO') then
        begin
          qryCreateTable.ExecSQL;
          trnOptimiza.Commit;
        end;


        trnOptimiza.StartTransaction;
        qryCreateProc.ExecQuery;
        trnOptimiza.Commit;
        trnOptimiza.StartTransaction;
        Installed := True;

      except
        Installed := False;
      end;

    end;

    if not Installed then MessageDlg('The installation process has failed!'+#10+
                              'Please Contact your Optimiza Administrator',
                              mtError,[MbOK],0);

  end;

end;

function TdmPolicyByPareto.TableExist(TableName: String): Boolean;
var
  TempList:TStringList;
begin
  Result := False;

  try

    TempList:= TStringList.Create;
    dbOptimiza.GetTableNames(TempList,False);
    Result := (TempList.IndexOf(TableName) >= 0);
  finally
    
    TempList.Free;
  end;

end;

end.
