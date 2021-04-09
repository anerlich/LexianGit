unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery, IBTable,StrUtils;

type
  TdmData = class(TdmOptimiza)
    qryUpdate: TIBQuery;
  private
    { Private declarations }

  public
    { Public declarations }
    procedure UpdateSupplier(SupplierCode,SupplierName:String;LT_Short,LT_Medium, LT_Long:Real);


  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

{ TdmExport }



{ TdmExport }



{ TdmData }


{ TdmData }

procedure TdmData.UpdateSupplier(SupplierCode, SupplierName: String;
  LT_Short, LT_Medium, LT_Long: Real);
begin

  with qryUpdate do
  begin
    ParamByName('SupplierCode').AsString := SupplierCode;
    ParamByName('SupplierName').AsString := SupplierName;
    ParamByName('LT_Short').AsFloat := LT_Short;
    ParamByName('LT_Medium').AsFloat := LT_Medium;
    ParamByName('LT_Long').AsFloat := LT_Long;
    ExecSql;
    Close;
  end;

end;

end.
