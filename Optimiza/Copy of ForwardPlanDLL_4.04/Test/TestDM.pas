unit TestDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, IBSQL, IBCustomDataSet, IBDatabase, Registry;

type
  TdmTest = class(TDataModule)
    SVPDatabase: TIBDatabase;
    DefaultTrans: TIBTransaction;
    sqlConfig: TIBSQL;
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
    qryTestDAYNO: TIntegerField;
    dscTest: TDataSource;
    qryLocation: TIBDataSet;
    qryLocationLOCATIONNO: TIntegerField;
    qryLocationDESCRIPTION: TIBStringField;
    qryLocationLOCATIONCODE: TIBStringField;
    qryLocationCURRENCYNO: TIntegerField;
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
    qryItemLOCATIONNO: TIntegerField;
    qryItemABSOLUTEMINIMUMQUANTITY: TFloatField;
    qryItemCALC_IDEAL_ARRIVAL_DATE: TIBStringField;
    qryItemTRANSITLT: TFloatField;
    qryItemSTOCKONORDER: TFloatField;
    qryItemSTOCKONORDERINLT: TFloatField;
    qryItemBACKORDERRATIO: TIntegerField;
    qryItemBOMBACKORDERRATIO: TIntegerField;
    qryItemDRPBACKORDERRATIO: TIntegerField;
    qryItemSTOCK_BUILDNO: TIntegerField;
    dscItem: TDataSource;
    qryPOGrid: TIBDataSet;
    qryPOGridPURCHASEORDERNO: TIntegerField;
    qryPOGridORDERNUMBER: TIBStringField;
    qryPOGridORDERDATE: TDateTimeField;
    qryPOGridEXPECTEDARRIVALDATE: TDateTimeField;
    qryPOGridIDEAL_ARRIVAL_DATE: TDateTimeField;
    qryPOGridQUANTITY: TFloatField;
    qryPOGridEXPEDITED: TIBStringField;
    dscPOGrid: TDataSource;
    qryStockBuild: TIBSQL;
    qryTestNEXTSSPOINT: TIntegerField;
    qryTestNEXTRCPOINT: TIntegerField;
    qryTestNEXTRPPOINT: TIntegerField;
    qryTestPREVLTPOINT: TIntegerField;
    qryTestORIGRCPOINT: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DatabaseDescription : String;
    DaysToExpiry : integer;

    function GetDataPath(var DatabasePath, Password : string) : boolean;

    function ReadConfigInt(ConfigNo : Integer;
                           LocationNo : Integer = -1) : Integer;

    function ReadConfigFloat(ConfigNo : Integer;
                             LocationNo : Integer = -1) : Double;

    function ReadConfigStr(ConfigNo : Integer;
                           LocationNo : Integer = -1) : String;

    function ReadConfigLongStr(ConfigNo : Integer;
                               LocationNo : Integer = -1) : String;

    function ReadConfigDate(ConfigNo : Integer;
                            LocationNo : Integer = -1) : TDateTime;

    procedure OpenDatabase;
    procedure CloseDatabase;
    procedure OpenItemQuery;
    procedure OpenLocation;
  end;

var
  dmTest: TdmTest;

implementation

{$R *.DFM}

procedure TdmTest.OpenItemQuery;
begin
  //DefaultTrans.StartTransaction;
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
 //   DefaultTrans.Commit;
  end;
end;

procedure TdmTest.DataModuleCreate(Sender: TObject);
begin
  OpenDatabase;
end;

procedure TdmTest.OpenDatabase;
var
  DataPath, Password : string;
begin
  with SVPDatabase do begin
    if Connected then
      Close;
    if GetDataPath(DataPath, Password) then begin
      if (length(DataPath) > 2) then
        if (UpCase(DataPath[1]) in ['A'..'Z']) and (DataPath[2] = ':') then // if we are using a direct path in windows then change it to a tcp/ip connection, for multi-threading
          DataPath := 'localhost:' + DataPath;
      DatabaseName := DataPath;
      Params.Clear;
      Params.Add('user_name=SYSDBA');
      if (Password = '') then begin
        Params.Add('password=masterkey');
      end
      else begin
        Params.Add('password=' + Password);
      end;
      Open;
    end;
  end;
end;

function TdmTest.GetDataPath(var DatabasePath, Password : string) : boolean;
var
  Reg : TRegistry;
  MustReadMachine : boolean;

begin
  Result := False;
  Reg := TRegistry.Create;
  try
    with Reg do begin
      Access := KEY_READ;
      RootKey := HKEY_CURRENT_USER;
      if KeyExists('Software\Execulink\optimiza\database') then begin
        if OpenKey('Software\Execulink\optimiza\database', False) then begin
          DatabasePath := Reg.ReadString('Path');
          if DatabasePath <> '' then begin
            DatabaseDescription := Reg.ReadString('Name');
            Result := True;
            MustReadMachine := False;
          end
          else begin
            MustReadMachine := True;
            CloseKey;
          end;
        end
        else begin
          MessageDlg('Cannot find the database path in the local registry. Please run the Database Manager to configure at least one database', mtError, [mbOk], 0);
          DatabaseDescription := 'Undefined database';
          Result := False;
          MustReadMachine := False;
        end;
      end
      else
        MustReadMachine := True;

      if MustReadMachine then begin
        RootKey := HKEY_LOCAL_MACHINE;
        if OpenKey('Software\Execulink\SVP\Database', False) then begin
          DatabasePath := Reg.ReadString('Path');
          DatabaseDescription := Reg.ReadString('Name');
          Result := True;
        end
        else begin
          MessageDlg('Cannot find the database path in the local registry. Please run the Database Manager to configure at least one database', mtError, [mbOk], 0);
          DatabaseDescription := 'Undefined database';
          Result := False;
        end;
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TdmTest.ReadConfigInt(ConfigNo : Integer;
                                                  LocationNo : Integer = -1) : integer;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFINTEGER ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := FieldByName('TYPEOFINTEGER').AsInteger;
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFINTEGER ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := FieldByName('TYPEOFINTEGER').AsInteger;
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TdmTest.ReadConfigFloat(ConfigNo : Integer;
                                                    LocationNo : Integer = -1) : Double;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFFLOAT ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := FieldByName('TYPEOFFLOAT').AsFloat;
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFFLOAT ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := FieldByName('TYPEOFFLOAT').AsFloat;
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TdmTest.ReadConfigStr(ConfigNo : Integer;
                                                  LocationNo : Integer = -1) : String;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFSTRING ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := trim(FieldByName('TYPEOFSTRING').AsString);
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFSTRING ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := trim(FieldByName('TYPEOFSTRING').AsString);
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TdmTest.ReadConfigLongStr(ConfigNo : Integer;
                                                      LocationNo : Integer = -1) : String;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFLONGSTRING ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO ';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := trim(FieldByName('TYPEOFLONGSTRING').AsString);
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFLONGSTRING ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO ';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := trim(FieldByName('TYPEOFLONGSTRING').AsString);
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TdmTest.ReadConfigDate(ConfigNo : Integer;
                                                   LocationNo : Integer = -1) : TDateTime;
var
  InTrans : Boolean;
begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    if LocationNo = -1 then begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select DESCRIPTION, TYPEOFSTRING, TYPEOFINTEGER, TYPEOFFLOAT, TYPEOFDATE, TYPEOFLONGSTRING ' +
                    'from CONFIGURATION ' +
                    'where CONFIGURATIONNO = ?CONFIGURATIONNO ';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        ExecQuery;
        Result := FieldByName('TYPEOFDATE').AsDateTime;
      end;
    end  {if}
    else begin
      with sqlConfig do begin
        Close;
        SQL.Text := 'select TYPEOFSTRING, TYPEOFINTEGER, TYPEOFFLOAT, TYPEOFDATE,TYPEOFLONGSTRING ' +
                    'from LOCATION_CONFIGURATION ' +
                    'where LOCATIONNO = ?LOCATIONNO ' +
                    '  and CONFIGURATIONNO = ?CONFIGURATIONNO';
        Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
        Params.ByName('LOCATIONNO').AsInteger := LocationNo;
        ExecQuery;
        Result := FieldByName('TYPEOFDATE').AsDateTime;
      end;
    end;  {else}
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

procedure TdmTest.DataModuleDestroy(Sender: TObject);
begin
  CloseDatabase;
end;

procedure TdmTest.CloseDatabase;
begin
  if DefaultTrans.InTransaction then
    DefaultTrans.Commit;

  if SVPDatabase.Connected then
    SVPDatabase.Close;
end;

end.
