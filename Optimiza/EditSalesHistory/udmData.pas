unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery, IBUpdateSQL;

type
  TdmData = class(TdmOptimiza)
    srcSrcProd: TDataSource;
    qrySrcProd: TIBQuery;
    qrySrcLocation: TIBQuery;
    srcSrcLocation: TDataSource;
    qryPeriod: TIBQuery;
    srcPeriod: TDataSource;
    qrySales: TIBQuery;
    srcSales: TDataSource;
    IBUpdateSQL1: TIBUpdateSQL;
  private
    { Private declarations }
    procedure GetProdList(aDataSet:TIBQuery;ProdCode:String;LocNo:Integer);
  public
    { Public declarations }
    procedure GetSrcProdList(ProdCode:String);
    procedure OpenPeriod;
    procedure OpenData;
    procedure OpenSales;
    procedure CommitData;

  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

{ TdmData }



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
      SQLText := 'Select p.ProductCode, p.ProductDescription,i.ItemNo from Product p, Item i '+
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


procedure TdmData.OpenData;
begin
qrySrcLocation.Open;

while not qrySrcLocation.Eof do
begin
  qrySrcLocation.next;
end;

qrySrcLocation.First;

end;

procedure TdmData.OpenPeriod;
var
  StartPeriod, EndPeriod: Integer;
begin
  EndPeriod := GetCurrentPeriod;
  StartPeriod := EndPeriod - 120;

  qryPeriod.Close;
  qryPeriod.ParamByName('StartPeriod').AsInteger := StartPeriod;
  qryPeriod.ParamByName('EndPeriod').AsInteger := EndPeriod;
  qryPeriod.Prepare;
  qryPeriod.Open;

end;


procedure TdmData.OpenSales;
begin

  with qrySales do
  begin
    close;
    ParamByName('ItemNo').AsInteger := qrySrcProd.fieldByName('ItemNo').AsInteger;
    Open;
  end;


end;

end.
