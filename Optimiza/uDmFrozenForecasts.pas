unit uDmFrozenForecasts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBDatabase, IBStoredProc, IBCustomDataSet, IBQuery,
  ;

type
  TdmFrozenForecast = class(TdmOptimiza)
    qryFrzFile: TQuery;
    srcFrzFile: TDataSource;
    qryItem: TIBQuery;
    srcItem: TDataSource;
    qryUpdateFrz: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Function GetItemNo(LocationNo: Integer; ProdCode: String):Integer;
    Function GetFrz(InChar: String):string;
  public
    { Public declarations }
    procedure UpdateFrz;
  end;

var
  dmFrozenForecast: TdmFrozenForecast;

implementation

uses uGetFrzFile;

{$R *.DFM}

procedure TdmFrozenForecast.DataModuleCreate(Sender: TObject);
begin
  inherited;

  if frmGetFrzFile.ShowModal = mrCancel then
     Application.Terminate

  else begin


    With qryFrzFile do begin
      Active := False;
      SQL.Clear;
      SQL.Add('Select * from "'+ frmGetFrzFile.Edit1.text+ '"');
      Active := True;
    end;

  end;
end;

procedure TdmFrozenForecast.UpdateFrz;
var
 ItemNumber, LocNumber: Integer;
 LocCode, cSql, cFrz: String;

begin
  srcFrzFile.DataSet.First;
  LocCode := '';
  LocNumber := 0;

  While not srcFrzFile.DataSet.Eof do begin

    cFrz := srcFrzFile.DataSet.FieldByName('FRZ').AsString;

    If Pos('Y',cFrz) > 0 Then Begin

    if LocCode <> srcFrzFile.DataSet.FieldByName('ORIG').AsString Then begin
        LocCode := srcFrzFile.DataSet.FieldByName('ORIG').AsString;
        LocNumber := GetLocationNo(LocCode);
    end;

    ItemNumber := GetItemNo(LocNumber,srcFrzFile.DataSet.FieldByName('ITEM').AsString);

    cSql := 'Update ItemFrozenForecast Set ';
    cSql := cSql + 'Forecast_0 = "'+ GetFrz(Copy(cFrz,1,1)) +'",';
    cSql := cSql + 'Forecast_1 = "'+ GetFrz(Copy(cFrz,2,1)) +'",';
    cSql := cSql + 'Forecast_2 = "'+ GetFrz(Copy(cFrz,3,1)) +'",';
    cSql := cSql + 'Forecast_3 = "'+ GetFrz(Copy(cFrz,4,1)) +'",';
    cSql := cSql + 'Forecast_4 = "'+ GetFrz(Copy(cFrz,5,1)) +'",';
    cSql := cSql + 'Forecast_5 = "'+ GetFrz(Copy(cFrz,6,1)) +'",';
    cSql := cSql + 'Forecast_6 = "'+ GetFrz(Copy(cFrz,7,1)) +'",';
    cSql := cSql + 'Forecast_7 = "'+ GetFrz(Copy(cFrz,8,1)) +'",';
    cSql := cSql + 'Forecast_8 = "'+ GetFrz(Copy(cFrz,9,1)) +'",';
    cSql := cSql + 'Forecast_9 = "'+ GetFrz(Copy(cFrz,10,1)) +'",';
    cSql := cSql + 'Forecast_10 = "'+ GetFrz(Copy(cFrz,11,1)) +'",';
    cSql := cSql + 'Forecast_11 = "'+ GetFrz(Copy(cFrz,12,1)) +'"';
    cSql := cSql + ' Where ItemNo = '+IntTostr(ItemNumber);

      try
        qryUpdateFRZ.Active := False;
        qryUpdateFRZ.SQL.Clear;
        qryUpdateFRZ.SQL.add(cSql);
        qryUpdateFRZ.Prepare;
        qryUpdateFRZ.ExecSQL;
      except
      end;

    end;

    srcFrzFile.DataSet.Next;
  end;

trnOptimiza.Commit;

end;

Function TdmFrozenForecast.GetItemNo(LocationNo: Integer; ProdCode: String):Integer;
begin

 With qryItem do begin
   active := False;
   SQL.Clear;
   SQL.Add('Select * from Item where Locationno = '+IntTostr(LocationNo));
   SQL.Add(' and ProductNo = (Select ProductNo from Product where ProductCode = "'+ProdCode+'")');
   Active := True;
 end;

   Result := srcItem.Dataset.FieldByName('ItemNo').AsInteger;

end;

Function TdmFrozenForecast.GetFrz(InChar: string):String;
begin

   If InChar = 'Y' then
     Result := 'Y'
   Else
     Result := 'N';

end;
end.
