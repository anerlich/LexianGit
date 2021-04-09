unit TestDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DMSVPMAINDATAMODULETEMPLATE, Db, IBSQL, IBCustomDataSet,
  IBDatabase;

type
  TdmTest = class(TSVPMainDataModuleTemplate)
    qryTest: TIBDataSet;
    dscTest: TDataSource;
    qryLocation: TIBDataSet;
    dscLocation: TDataSource;
    qryItem: TIBDataSet;
    qryItemITEMNO: TIntegerField;
    qryItemLOCATIONCODE: TIBStringField;
    qryItemLDESCRIPTION: TIBStringField;
    qryItemPRODUCTCODE: TIBStringField;
    qryItemPDESCRIPTION: TIBStringField;
    qryItemSTOCKINGINDICATOR: TIBStringField;
    qryItemPARETOCATEGORY: TIBStringField;
    qryItemSAFETYSTOCK: TFloatField;
    qryItemLEADTIME: TFloatField;
    qryItemREPLENISHMENTCYCLE: TFloatField;
    qryItemREVIEWPERIOD: TFloatField;
    qryItemSTOCKONHAND: TFloatField;
    qryItemBACKORDER: TFloatField;
    qryItemMINIMUMORDERQUANTITY: TFloatField;
    qryItemORDERMULTIPLES: TFloatField;
    qryItemCONSOLIDATEDBRANCHORDERS: TFloatField;
    qryItemBINLEVEL: TFloatField;
    qryItemSALESAMOUNT_0: TFloatField;
    qryItemFORWARD_SS: TFloatField;
    qryItemFORWARD_SSRC: TFloatField;
    qryItemRECOMMENDEDORDER: TFloatField;
    qryItemTOPUPORDER: TFloatField;
    qryItemIDEALORDER: TFloatField;
    dscItem: TDataSource;
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
    qryItemLOCATIONNO: TIntegerField;
    qryItemABSOLUTEMINIMUMQUANTITY: TFloatField;
    qryItemCALC_IDEAL_ARRIVAL_DATE: TIBStringField;
    qryLocationLOCATIONNO: TIntegerField;
    qryLocationDESCRIPTION: TIBStringField;
    qryLocationLOCATIONCODE: TIBStringField;
    qryLocationCURRENCYNO: TIntegerField;
    qryItemTRANSITLT: TFloatField;
    qryPOGrid: TIBDataSet;
    dscPOGrid: TDataSource;
    qryPOGridPURCHASEORDERNO: TIntegerField;
    qryPOGridORDERNUMBER: TIBStringField;
    qryPOGridORDERDATE: TDateTimeField;
    qryPOGridEXPECTEDARRIVALDATE: TDateTimeField;
    qryPOGridIDEAL_ARRIVAL_DATE: TDateTimeField;
    qryPOGridQUANTITY: TFloatField;
    qryPOGridEXPEDITED: TIBStringField;
    qryTestMINIMUM: TIntegerField;
    qryTestMAXIMUM: TIntegerField;
    qryTestBUILDTOT: TIntegerField;
    qryTestSS: TIntegerField;
    qryItemSTOCKONORDER: TFloatField;
    qryItemSTOCKONORDERINLT: TFloatField;
    qryTestTOT: TIntegerField;
    qryTestFCIN: TIntegerField;
    qryTestFCNEW: TIntegerField;
    qryTestDAYNO: TIntegerField;
    qryItemBACKORDERRATIO: TIntegerField;
    qryItemBOMBACKORDERRATIO: TIntegerField;
    qryItemDRPBACKORDERRATIO: TIntegerField;
    qryStockBuild: TIBSQL;
    qryItemSTOCK_BUILDNO: TIntegerField;
    qryItemSTOCKONORDER_OTHER: TFloatField;
    qryItemSTOCKONORDERINLT_OTHER: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenItemQuery;
    procedure OpenLocation;
  end;

var
  dmTest: TdmTest;

implementation


{$R *.DFM}

procedure TdmTest.OpenItemQuery;
begin
  if not DefaultTrans.InTransaction then
    DefaultTrans.StartTransaction;
  try
    qryItem.Close;
    qryItem.ParamByName('LOCATIONNO').AsInteger := qryLocation.FieldByName('LocationNo').AsInteger;
    qryItem.Open;
  finally
    //DefaultTrans.Commit;
  end;
end;

procedure TdmTest.OpenLocation;
begin
  DefaultTrans.StartTransaction;
  try
    qryLocation.Close;
    qryLocation.Open;
  finally
   // DefaultTrans.Commit;
  end;
end;

end.
