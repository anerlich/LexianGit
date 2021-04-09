unit dmFPTestDLL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DMSVPDATAMODULETEMPLATE, IBSQL, Db, IBCustomDataSet;

type
  TFPTestDLLDatamodule = class(TSVPDataModuleTemplate)
    GetItemData: TIBSQL;
    GetFC: TIBSQL;
    GetPOData: TIBDataSet;
    GetCOData: TIBDataSet;
    Calendar: TIBDataSet;
    dscTemplate: TDataSource;
    GetTemplates: TIBDataSet;
    DummyTemplates: TIBDataSet;
    dscDummy: TDataSource;
    GetLocations: TIBDataSet;
    GetLocationsLOCATIONNO: TIntegerField;
    GetLocationsLOCATIONCODE: TIBStringField;
    GetLocationsDESCRIPTION: TIBStringField;
    dscLocations: TDataSource;
    GetStockBuild: TIBSQL;
  private
  public
  end;

var
  FPTestDLLDatamodule: TFPTestDLLDatamodule;

implementation

uses dmSVPMain;

{$R *.DFM}

end.
