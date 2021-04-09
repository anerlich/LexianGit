unit udmTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, DB, IBCustomDataSet, IBSQL, IBDatabase,
  IBStoredProc, IBQuery;

type
  TdmTest = class(TdmOptimiza)
    qryTest: TIBDataSet;
    qryTestCALENDARNO: TIntegerField;
    qryTestSTARTDATE: TDateTimeField;
    qryTestWEEKNO: TIntegerField;
    qryTestDVAL: TIntegerField;
    qryTestFACTOR: TIntegerField;
    qryTestOPENING: TIntegerField;
    qryTestCLOSING: TIntegerField;
    qryTestORDERS: TIntegerField;
    qryTestRECEIPTS: TIntegerField;
    qryTestEXCESS: TIntegerField;
    qryTestBO: TIntegerField;
    qryTestLOSTSALES: TIntegerField;
    qryTestFWDPO: TIntegerField;
    qryTestPO: TIntegerField;
    qryTestCO: TIntegerField;
    qryTestFC: TIntegerField;
    qryTestDRPFC: TIntegerField;
    qryTestBOMFC: TIntegerField;
    qryTestMINIMUM: TIntegerField;
    qryTestMAXIMUM: TIntegerField;
    qryTestBUILDTOT: TIntegerField;
    qryTestSS: TIntegerField;
    qryTestTOT: TIntegerField;
    qryTestFCIN: TIntegerField;
    qryTestFCNEW: TIntegerField;
    qryTestDAYNO: TIntegerField;
    dscTest: TDataSource;
    qryPOGrid: TIBDataSet;
    qryPOGridPURCHASEORDERNO: TIntegerField;
    qryPOGridORDERNUMBER: TIBStringField;
    qryPOGridORDERDATE: TDateTimeField;
    qryPOGridEXPECTEDARRIVALDATE: TDateTimeField;
    qryPOGridIDEAL_ARRIVAL_DATE: TDateTimeField;
    qryPOGridQUANTITY: TFloatField;
    qryPOGridEXPEDITED: TIBStringField;
    dscPOGrid: TDataSource;
    qryGetLocation: TIBDataSet;
    qryLocationLOCATIONNO: TIntegerField;
    qryLocationDESCRIPTION: TIBStringField;
    qryLocationLOCATIONCODE: TIBStringField;
    qryLocationCURRENCYNO: TIntegerField;
    dscLocation: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenLocation;
  end;

var
  dmTest: TdmTest;

implementation

{$R *.dfm}

procedure TdmTest.OpenLocation;
begin
  trnOptimiza.StartTransaction;
  try
    qryGetLocation.Close;
    qryGetLocation.Open;
  finally
  end;
end;

end.
