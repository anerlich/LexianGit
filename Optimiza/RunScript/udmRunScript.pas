unit udmRunScript;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery,
  IBUpdateSQL;

type
  TdmRunScript = class(TdmOptimiza)
    qryLastScript: TIBQuery;
    srcLastScript: TDataSource;
    qryUpdate: TIBQuery;
    qryScriptNo: TIBQuery;
    qryUpdateScriptNo: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OpenData;
    procedure CloseData;
  public
    { Public declarations }
    function OpenNew(DBName: String):Boolean;
    function UpdateIt(fName: String; NewNumber: Integer; UpdateScriptNo: Boolean):Boolean;
    function UpdateScriptNo(NewNumber: Integer):Boolean;
  end;

var
  dmRunScript: TdmRunScript;

implementation

{$R *.DFM}

procedure TdmRunScript.DataModuleCreate(Sender: TObject);
begin
  inherited;
  OpenData;
end;

procedure TdmRunScript.OpenData;
begin
  qryLastScript.Open;
end;

procedure TdmRunScript.CloseData;
begin
  qryLastScript.Close;
end;

function TdmRunScript.OpenNew(DBName: String):Boolean;
begin

  Result := True;

  try
    CloseData;
    dbOptimiza.Connected := False;
    dbOptimiza.DatabaseName := DBName;
    dbOptimiza.Connected := True;
    OpenData;
  except
    MessageDlg('Failed to open ' + DBNAME,mtError,[mbOK],0);
    Result := False;
  end;

end;

function TdmRunScript.UpdateIt(fName: String; NewNumber: Integer; UpdateScriptNo: Boolean):Boolean;
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

   qryUpdate.SQL.Clear;
   qryUpdate.SQL.LoadFromFile(fName);
   qryUpdate.Prepare;
   qryUpdate.ExecSQL;

   try
     trnOptimiza.Commit;

     if UpdateScriptNo then
     begin


         qryScriptNo.Active := False;
         qryScriptNo.ParamByName('NewNumber').AsInteger := NewNumber;

        if not trnOptimiza.InTransaction then
          trnOptimiza.StartTransaction;

         qryScriptNo.Prepare;
         qryScriptNo.ExecSQL;
         trnOptimiza.Commit;

     end;

     Result := True;
   except
     Result := False;

   end;


end;

function TdmRunScript.UpdateScriptNo(NewNumber: Integer):Boolean;
begin

  try
       qryScriptNo.Active := False;
         qryScriptNo.ParamByName('NewNumber').AsInteger := NewNumber;

        if not trnOptimiza.InTransaction then
          trnOptimiza.StartTransaction;

         qryScriptNo.Prepare;
         qryScriptNo.ExecSQL;
         trnOptimiza.Commit;
         Result := True;

        if not trnOptimiza.InTransaction then
          trnOptimiza.StartTransaction;

        qryLastScript.Close;
        qryLastScript.Open;

  except
    Result := False;
  end;
end;

end.
