unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery;

type
  TdmData = class(TdmOptimiza)
    srcSrcProd: TDataSource;
    qrySrcProd: TIBQuery;
    qrySrcLocation: TIBQuery;
    srcSrcLocation: TDataSource;
    qryTgtProd: TIBQuery;
    qryTgtLocation: TIBQuery;
    srcTgtProd: TDataSource;
    srcTgtLocation: TDataSource;
    qryPeriod: TIBQuery;
    srcPeriod: TDataSource;
    qryCheckProc: TIBSQL;
    qryAddStoredProc: TIBSQL;
    prcUpdateSales: TIBStoredProc;
    qryCheckTarget: TIBQuery;
    prcCopyFC: TIBStoredProc;
    qryCheckProc2: TIBSQL;
    qryAddStoredProc2: TIBSQL;
  private
    { Private declarations }
    procedure GetProdList(aDataSet:TIBQuery;ProdCode:String;LocNo:Integer);
  public
    { Public declarations }
    procedure GetSrcProdList(ProdCode:String);
    procedure GetTgtProdList(ProdCode:String);
    procedure OpenPeriod;
    function CheckProcedure:Boolean;
    procedure UpdateSale(SrcLoc, TgtLoc, SrcProd, TgtProd,ReplaceInd: String);
    procedure UpdateFC(SrcLoc, TgtLoc, SrcProd, TgtProd, FreezeInd, AddInd: String;MonthCount,Offset:Integer;Perc:Double);
    function CheckTarget(LocCode, ProdCode: String): Boolean;
    procedure OpenData;
    procedure CommitData;

  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

{ TdmData }

function TdmData.CheckProcedure:Boolean;
var
  Installed:Boolean;
begin

    if not trnOptimiza.InTransaction then
      trnOptimiza.StartTransaction;


    with qryCheckProc do
    begin
      ExecQuery;
      Installed := False;

      if FieldByName('Rdb$Procedure_ID').AsInteger > 0 then
        Installed := True;
      close;
    end;

    //if 1st one installed then make sure 2nd one installed too
    if Installed then
    begin

      with qryCheckProc2 do
      begin
        ExecQuery;

        Installed := False;

        if FieldByName('Rdb$Procedure_ID').AsInteger > 0 then
          Installed := True;
        close;
      end;

    end;

    if not Installed then
    begin

      if MessageDlg('Sales/Forecast Copy Stored Proc not installed, Install Now',mtConfirmation,[mbYes,mbNo],0) = mrYes then
      begin

        try
          with qryAddStoredProc do
          begin
            ExecQuery;
            Close;
          end;

          with qryAddStoredProc2 do
          begin
            ExecQuery;
            Close;
          end;

          trnOptimiza.Commit;
          trnOptimiza.StartTransaction;
          Installed:=true;

          MessageDlg('Stored proc installed',mtInformation,[mbOK],0);
        except
          Installed:=False;
          MessageDlg('Stored proc Failed to install. Contact Optimiza Administrator',mtError,[mbOK],0);
        end;



      end;


    end;

    Result := Installed;

end;

function TdmData.CheckTarget(LocCode, ProdCode: String): Boolean;
begin

  Result := False;

  try
    qryCheckTarget.Close;
    qrycheckTarget.ParamByName('LocCode').AsString := LocCode;
    qrycheckTarget.ParamByName('ProdCode').AsString := ProdCode;
    qryCheckTarget.Prepare;
    qryCheckTarget.Open;

     if qryCheckTarget.FieldByName('ItemNo').AsInteger > 0 then
       Result := True;

  except

    Result := False;
  end;


end;

procedure TdmData.CommitData;
begin

  trnOptimiza.Commit;
  trnOptimiza.StartTransaction;
  
end;

procedure TdmData.GetProdList(aDataSet:TIBQuery;ProdCode: String;LocNo:Integer);
var
  sqltext:String;
begin
  ProdCode := UpperCase(ProdCode);

  if LocNo <= 0 then
    MessageDlg('Please Select a Location',mtInformation,[mbOK],0)
  else
  begin
    with aDataSet do
    begin
      close;
      SQL.Clear;
      SQLText := 'Select p.ProductCode, p.ProductDescription from Product p, Item i '+
                 'where p.ProductNo = i.ProductNo'+
                 ' and p.ProductCode Like "' + Trim(ProdCode)+'%" '+
                 ' and i.LocationNo = '+IntToStr(LocNo)+
                 'Order by p.ProductCode';

      SQL.Add(SQLText);
      Prepare;
      Open;
    end;

  end;


end;

procedure TdmData.GetSrcProdList(ProdCode: String);
begin
  GetProdList(qrySrcProd,ProdCode,qrySrcLocation.fieldByName('LocationNo').AsInteger );
end;

procedure TdmData.GetTgtProdList(ProdCode: String);
begin
  GetProdList(qryTgtProd,ProdCode,qryTgtLocation.fieldByName('LocationNo').AsInteger );
end;

procedure TdmData.OpenData;
begin
  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  qrySrcLocation.Open;
  qryTgtLocation.Open;

  //Scroll top to end to refresh dblookupcombo's
  while not dmData.qrySrcLocation.Eof do
  begin
    dmData.qrySrcLocation.next;
    dmData.qryTgtLocation.next;
  end;

  dmData.qrySrcLocation.first;
  dmData.qryTgtLocation.first;

end;

procedure TdmData.OpenPeriod;
var
  StartPeriod, EndPeriod: Integer;
begin
  StartPeriod := GetCurrentPeriod;
  EndPeriod := StartPeriod + 18;

  qryPeriod.Close;
  qryPeriod.ParamByName('StartPeriod').AsInteger := StartPeriod;
  qryPeriod.ParamByName('EndPeriod').AsInteger := EndPeriod;
  qryPeriod.Prepare;
  qryPeriod.Open;

end;

procedure TdmData.UpdateFC(SrcLoc, TgtLoc,SrcProd, TgtProd, FreezeInd,
  AddInd: String; MonthCount, Offset: Integer;Perc:Double);
begin
  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  with prcCopyFC do
  begin
     ParamByName('SourceLocationCode').AsString := SrcLoc;
     ParamByName('TargetLocationCode').AsString := TgtLoc;
     ParamByName('SourceProductCode').AsString := SrcProd;
     ParamByName('TargetProductCode').AsString := TgtProd;
     ParamByName('FreezeInd').AsString := FreezeInd;
     ParamByName('AddInd').AsString := AddInd;
     ParamByName('MonthCount').AsInteger := MonthCount;
     ParamByName('Offset').AsInteger := Offset;
     ParamByName('Perc').AsFloat := Perc;
     Prepare;
     ExecProc;
  end;



end;

procedure TdmData.UpdateSale(SrcLoc, TgtLoc, SrcProd, TgtProd,
  ReplaceInd: String);
begin

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  with prcUpdateSales do
  begin
     prcUpdateSales.ParamByName('SourceLocationCode').AsString := SrcLoc;
     prcUpdateSales.ParamByName('TargetLocationCode').AsString := TgtLoc;
     prcUpdateSales.ParamByName('SourceProductCode').AsString := SrcProd;
     prcUpdateSales.ParamByName('TargetProductCode').AsString := TgtProd;
     prcUpdateSales.ParamByName('ReplaceInd').AsString := ReplaceInd;
     prcUpdateSales.Prepare;
     prcUpdateSales.ExecProc;
  end;




end;

end.
