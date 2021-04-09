unit uDMConvertSys3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, IBDatabase, IBStoredProc, Db, IBCustomDataSet, IBQuery,
   checklst, FileCtrl;

type
  TdmOptimiza1 = class(TdmOptimiza)
    qryMlsysdir: TQuery;
    srcMlSysdir: TDataSource;
    qryLocationList: TIBQuery;
    srcLocationList: TDataSource;
    qryMasterFile: TQuery;
    srcMasterFile: TDataSource;
    qryUpdateItem: TIBQuery;
    qryUpdateConfiguration: TIBQuery;
    qryImSysPar: TQuery;
    srcImSysPar: TDataSource;
    IBTransaction1: TIBTransaction;
    qryUpdateItemFrozenForecast: TIBQuery;
    qryConfiguration: TIBQuery;
    srcConfiguration: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OpenMasterFile(Directory: String);
    procedure UpdateData(LocationNo, CalendarNo: Integer; UpdateStockout, UpdateFrozen, UpdateManual: Boolean);
    procedure UpdateConfig;
  public
    { Public declarations }
    procedure UpdateItem(LocationList: TCheckListBox; UpdateStockout, UpdateFrozen, UpdateManual: Boolean);
    procedure OpenLocationList(LinkField: String);
    function GetLocationList:TStringList;
  end;

var
  dmOptimiza1: TdmOptimiza1;

implementation

uses uGetMlsysdir, uConvertSys3;

{$R *.DFM}

procedure TdmOptimiza1.DataModuleCreate(Sender: TObject);
var
  cFile: String;
begin
  inherited;

  frmFileName.Edit2.Text := dbOptimiza.DatabaseName;

  if frmFileName.ShowModal = mrCancel then
     Application.Terminate

  else begin


    cFile := frmFileName.Edit1.Text;

    With qryMlsysdir do begin
      Active := False;
      SQL.Clear;
      SQL.Add('Select DIRCDE,ORG,BRANCH,DNAME from "'+cFile+'" ');
      Open;
    end;

  end;

end;

procedure TdmOptimiza1.OpenLocationList(LinkField: String);
begin

  With qryLocationList do begin
    Active := False;
    SQL.Clear;
    SQL.Add('Select * from Location where LocationCode = :'+LinkField);
    Open;
  End;

end;

function TdmOptimiza1.GetLocationList:TStringList;
var
   NewList: TStringList;
begin
   NewList := TStringList.Create;

   With srcMlsysdir.DataSet do begin
     First;

     while not eof do begin
       NewList.Add(srcLocationList.Dataset.Fieldbyname('Description').AsString);
       Next;
     end;

     First;
   end;

   Result := NewList;
end;

procedure TdmOptimiza1.UpdateItem(LocationList: TCheckListBox; UpdateStockout, UpdateFrozen, UpdateManual: Boolean);
Var
  nCnt, nLoc, nCal: Integer;
  cPath: String;
begin
  //get current calendar period no
  qryConfiguration.Active := False;
  qryConfiguration.Active := True;
  nCal := srcConfiguration.DataSet.FieldByName('TypeOfInteger').AsInteger;
  qryConfiguration.Active := False;

  With srcMlsysdir.DataSet do begin
    First;
    nCnt := 0;

    While not Eof Do begin

      if LocationList.Checked[nCnt] then begin
        nLoc := srcLocationList.DataSet.FieldbyName('LocationNo').AsInteger;

        If Copy(frmFileName.Edit1.Text,2,1) = ':' then
          cPath := Copy(frmFileName.Edit1.Text,1,2)
        else
          cPath := '';

        cPath := cPath + FieldByName('DNAME').AsString;

        Form1.SetFilePath('Opening Master for '+cPath);
        Form1.Refresh;

        OpenMasterFile(cPath);
        Form1.SetMaxRecord(srcMasterFile.DataSet.RecordCount);

        Form1.SetFilePath('Processing Master for '+cPath);
        Form1.Refresh;
        UpdateData(nLoc, nCal, UpdateStockout, UpdateFrozen, UpdateManual);
      end;

       Next;
       nCnt := nCnt + 1;

    end;

  end;

  trnOptimiza.Commit;

  trnOptimiza.StartTransaction;
  UpdateConfig;
  trnOptimiza.Commit;



end;

procedure TdmOptimiza1.OpenMasterFile(Directory: String);
var 
  Save_Cursor:TCursor;

begin

  //Add if not there
  if Copy(Directory,Length(Directory)-1,1) <> '\' then
    Directory := Directory + '\';

  With qryMasterFile do begin
    Save_Cursor := Screen.Cursor;

    Screen.Cursor := crSQLWait;    { Show hourglass cursor }

    try
      Active := False;
      SQL.Clear;
      SQL.Add('Select * from "'+Directory+'Master.dbf" where EXCLUDE = "E" or EXCLUDE = " "');

      Open;

    finally
      Screen.Cursor := Save_Cursor;  { Always restore to normal }
    end;

  end;

end;

procedure TdmOptimiza1.UpdateData(LocationNo, CalendarNo: Integer; UpdateStockout, UpdateFrozen, UpdateManual: Boolean);
Var
  cSql, cFrzHead, cFrzTail, cFrzSql, cStock, cPrev, cPol: String;
  RecCount, FrzCount: Integer;
begin


  srcMasterFile.DataSet.First;
  RecCount := 0;

  While not srcMasterFile.DataSet.eof do begin

    cSql := 'Update Item Set ' ;
    Inc(RecCount);
    Form1.IncrementCount(RecCount);

    if UpdateStockOut then begin
      cStock := srcMasterFile.DataSet.FieldByName('SOTIMES').AsString;
      cPrev := srcMasterFile.DataSet.FieldByName('SOTIMESP').AsString;

      //Some records return NIL !!!
      If cStock = '' then cStock := '0';
      If cPrev = '' then cPrev := '0';

      cSql := cSql + 'StockOutCount = ' + cStock +
                   ', PreviousStockOutCount = ' + cPrev ;

      if UpdateManual then begin
        cPol := Trim(srcMasterFile.DataSet.FieldByName('MANPOL').AsString);

        //Some records return NIL !!!
        If (cPol <> '') and (Trim(srcMasterFile.DataSet.FieldByName('STIND').AsString)='Y') then
        begin

          if (Pos('S',cPol) > 0 ) or (Pos('L',cPol) > 0) then
          begin
            cSql := cSql + ',ManualPolicy = "Y" ' +
                           ',SafetyStock = '+ Trim(srcMasterFile.DataSet.FieldByName('SS').AsString)+
                           ',LeadTime = '+Trim(srcMasterFile.DataSet.FieldByName('LT').AsString);
          end;

        end;

      end;

      cSql := cSql + ' where LocationNo = ' + IntToStr(LocationNo) +
                  ' and ProductNo = (Select ProductNo from Product where' +
                  ' ProductCode = "'+srcMasterFile.DataSet.FieldByName('ITEM').AsString+'")';

      qryUpdateItem.Active := False;
      qryUpdateItem.SQL.Clear;
      qryUpdateItem.SQL.Add(cSql);
      qryUpdateItem.Prepare;
      qryUpdateItem.ExecSQL;

    end;

    if UpdateFrozen then begin
       cFrzSql := '';

      //Build SQL for each Frozen Flag
      For FrzCount := 1 to 12 do begin

        If Copy(srcMasterFile.Dataset.FieldByName('FCSFRZ').AsString,FrzCount,1) = 'Y' then begin


          If cFrzSql <> '' then cFrzSql := cFrzSql + ',';

          cFrzSql := cFrzSql + 'Forecast_'+IntToStr(FrzCount-1)+' = "Y"'
        end;

      end;

      If cFrzSql <> '' then begin
        cFrzHead := 'Update ItemFrozenForecast Set ';
        cFrzTail := ' where CalendarNo = ' + IntToStr(CalendarNo) +
                   ' and ItemNo = (Select ItemNo from Item' +
                   ' where LocationNo = ' + IntToStr(LocationNo) +
                   ' and ProductNo = (Select ProductNo from Product where' +
                   ' ProductCode = "'+srcMasterFile.DataSet.FieldByName('ITEM').AsString+'") )';

        cFrzSql := cFrzHead + cFrzSql + cFrzTail;

        qryUpdateItemFrozenForecast.Active := False;
        qryUpdateItemFrozenForecast.SQL.Clear;
        qryUpdateItemFrozenForecast.SQL.Add(cFrzSql);
        qryUpdateItemFrozenForecast.Prepare;
        qryUpdateItemFrozenForecast.ExecSQL;
      end;


    end;



    srcMasterFile.DataSet.next;

  end;


end;

procedure TdmOptimiza1.UpdateConfig;
var
  cPath,cFle, cCur, cLst: String;
  cDrv: Char;
begin
  ProcessPath(frmFileName.Edit1.Text,cDrv,cPath,cFle);

  With qryImSysPar do begin
    Active := False;
    SQL.Clear;
    SQL.Add('Select CURDNLCNT, LSTDNLCNT from "'+
                      cPath+'\ImSysPar.dbf'+'"');
    Prepare;
    Active := True;
  end;

  cCur := srcImSysPar.DataSet.FieldByName('CURDNLCNT').AsString;
  cLst := srcImSysPar.DataSet.FieldByName('LSTDNLCNT').AsString;

  If cCur = '' then cCur := '0';
  If cLst = '' then cLst := '0';

  with qryUpdateConfiguration do begin
    //Update Current download count
    Active := False;
    SQL.Clear;
    SQL.Add('Update Configuration Set TypeOfInteger = '+cCur+
            ' where ConfigurationNo = 105');
    Prepare;
    ExecSQL;

    //Update previous download count
    Active := False;
    SQL.Clear;
    SQL.Add('Update Configuration Set TypeOfInteger = '+cLst+
            ' where ConfigurationNo = 106');
    Prepare;
    ExecSQL;

  end;

end;

end.
