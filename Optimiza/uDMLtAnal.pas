unit uDMLtAnal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, IBDatabase, IBStoredProc, Db, IBCustomDataSet, IBQuery,
   IBSQL;

type
  TdmLTAnal = class(TdmOptimiza)
    tblLTAnal: TTable;
    srcLTAnal: TDataSource;
    qryItem: TIBQuery;
    srcItem: TDataSource;
    qryUpdateLT: TIBQuery;
    qryLTAnal: TQuery;
    qryGetSeqNo: TIBQuery;
    srcGetSeqNo: TDataSource;
    qrySetSeqNo: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure UpdateLTAnalysis;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmLTAnal: TdmLTAnal;

implementation

uses uGetLTFile, uLTStatus;

{$R *.DFM}

procedure TdmLTAnal.DataModuleCreate(Sender: TObject);
begin
  inherited;

  if frmGetLTFile.ShowModal = mrCancel then
     Application.Terminate

  else begin


    With qryLTAnal do begin
      Active := False;
      SQL.Clear;
      SQL.Add('Select * from "'+ frmGetLTFile.Edit1.text+ '"');
      Active := True;
    end;

  end;
end;


procedure TdmLTAnal.UpdateLTAnalysis;
var
   DownDate, cInsSql, cSql, cDue, cOrd: String;
   DeliverPeriod, SeqNo, RCount: Integer;
   ActualLT, LTVariance, ItemLT: Real;
begin

qryGetSeqNo.Active := True;
SeqNo := srcGetSeqNo.DataSet.FieldbyName('LeadTimeAnalysisNo').AsInteger;
qryGetSeqNo.Active := False;

frmStatus.Show;
RCount := 0;

DownDate := GetDownLoadDate;
cInsSql :=  'Insert into LEADTIMEANALYSIS ' +
            ' (LEADTIMEANALYSISNO'+
            ', FINALDELIVERYDATE'+
            ', DELIVEREDCALENDARNO'+
            ', ACTUALLEADTIME'+
            ', LEADTIMEVARIANCE'+
            ', CURRENTLEADTIMEVARIANCE'+
            ', ITEMNO'              +
            ', ORDERNUMBER'         +
            ', ORIGINALEAD'         +
            ', SUPPLIERNO'          +
            ', LEADTIMECATEGORY'    +
            ', LEADTIME'            +
            ', COSTPRICE'           +
            ', COSTPER'             +
            ', ORDERSUPPLIERNO'     +
            ', ORDERDATE'           +
            ', EXPECTEDARRIVALDATE' +
            ', ORIGINALQUANTITY'    +
            ', STATUS) Values(';


With srcLTAnal.Dataset do begin
  First;

  While not Eof do begin

    qryItem.Active := False;
    qryItem.ParamByName('ProductCode').AsString := FieldByName('ITEM').AsString;
    qryItem.ParamByName('LocationCode').AsString := FieldByName('BRANCH').AsString;
    qryItem.Active := True;

    If srcItem.DataSet.FieldByName('ITEMNO').AsInteger > 0 then begin
      DeliverPeriod := GetCalendarPeriod(FieldByName('DELDATE').AsString);
      ActualLT := (FieldByName('DELDATE').AsDateTime - FieldByName('ORDDATE').AsDateTime ) / 30;
      LTVariance := ActualLT - srcItem.DataSet.FieldByName('LEADTIME').AsFloat;
      Inc(SeqNo);

      cSql := cInsSql +
            IntToStr(SeqNo)+
            ',"'+FormatDateTime('mm/dd/yyyy',FieldByName('DELDATE').AsDateTime) +'"'+
            ','+IntToStr(DeliverPeriod)+
            ','+FormatFloat('0.00',ActualLT)+
            ','+FormatFloat('0.00',LTVariance)+
            ','+FormatFloat('0.00',LTVariance)+
            ','+ srcItem.DataSet.FieldByName('ITEMNO').AsString +
            ',"'+ FieldByName('ORDERNO').AsString + '"'+
            ',"'+ FormatDateTime('mm/dd/yyyy',FieldByName('EAD').AsDateTime) + '"'+
            ','+ srcItem.DataSet.FieldByName('SUPPLIERNO1').AsString +
            ',"'+ srcItem.DataSet.FieldByName('LEADTIMECATEGORY').AsString + '"'+
            ','+ srcItem.DataSet.FieldByName('LEADTIME').AsString +
            ','+ srcItem.DataSet.FieldByName('COSTPRICE').AsString +
            ','+ srcItem.DataSet.FieldByName('COSTPER').AsString +
            ','+ srcItem.DataSet.FieldByName('SUPPLIERNO1').AsString +
            ',"'+ FormatDateTime('mm/dd/yyyy',FieldByName('ORDDATE').AsDateTime) + '"'+
            ',"'+ FormatDateTime('mm/dd/yyyy',FieldByName('EAD').AsDateTime) + '"'+
            ','+ FieldByName('QTY').AsString +
            ',"D")' ;

      try
        qryUpdateLT.Active := False;
        qryUpdateLT.SQL.Clear;
        qryUpdateLT.SQL.add(cSql);
        qryUpdateLT.Prepare;
        qryUpdateLT.ExecSQL;
      except
        ShowMessage(cSql);
      end;

    end;


    Inc(Rcount);

    if (RCount mod 100)=0 then
    begin
      frmStatus.Panel1.Caption := IntToStr(RCount);
      frmStatus.Refresh;
    end;

    Next;
  end;


  frmStatus.Hide;


end;

qrysetSeqNo.SQL.Clear;
qrysetSeqNo.SQL.Add('SET GENERATOR LEADTIMEANALYSIS_SEQNO TO ' +
                     IntToStr(SeqNo));
qrysetSeqNo.Active := True;

qrysetSeqNo.Close;
trnOptimiza.Commit;

end;


end.
