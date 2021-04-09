unit dmSVPMainDataModuleTemplate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, IBDatabase, IBSQL, Db;

type
  TSVPMainDataModuleTemplate = class(TDataModule)
    SVPDatabase: TIBDatabase;
    DefaultTrans: TIBTransaction;
    ReadConfig: TIBSQL;
    ReadConfigLoc: TIBSQL;
    procedure SVPMainDataModuleTemplateCreate(Sender: TObject);
    procedure SVPMainDataModuleTemplateDestroy(Sender: TObject);
  private
  public
    function ReadConfigInt(ConfigNo : integer) : integer;overload;
    function ReadConfigInt(ConfigNo,LocationNo : integer) : integer;overload;
    function ReadConfigFloat(ConfigNo : integer) : double;overload;
    function ReadConfigStr(ConfigNo : integer) : string;
    function ReadConfigLongStr(ConfigNo : integer) : string;
    function ReadConfigDate(ConfigNo : integer) : TDateTime;
    function ReadConfigFloat(ConfigNo,LocationNo : integer) : double;overload;
  end;

var
  SVPMainDataModuleTemplate: TSVPMainDataModuleTemplate;

implementation

{$R *.DFM}

procedure TSVPMainDataModuleTemplate.SVPMainDataModuleTemplateCreate(
  Sender: TObject);
var
  Reg : TRegistry;

begin
  Reg := TRegistry.Create;
  try
    with Reg do begin
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKey('Software\Execulink\SVP\Database', False) then begin
        with SVPDatabase do begin
          if Connected then
            Close;
          DatabaseName := Reg.ReadString('Path');
          Open;
        end;
      end
      else begin
        MessageDlg('Cannot find the database path in the local registry. Run the configuration tool', mtError, [mbOk], 0);
      end;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TSVPMainDataModuleTemplate.SVPMainDataModuleTemplateDestroy(
  Sender: TObject);
begin
  if DefaultTrans.InTransaction then
    DefaultTrans.Commit;
  if SVPDatabase.Connected then
    SVPDatabase.Close;
end;

function TSVPMainDataModuleTemplate.ReadConfigInt(ConfigNo : integer) : integer;
var
  InTrans : boolean;

begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFINTEGER').AsInteger;
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TSVPMainDataModuleTemplate.ReadConfigFloat(ConfigNo : integer) : double;
var
  InTrans : boolean;

begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFFLOAT').AsFloat;
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TSVPMainDataModuleTemplate.ReadConfigStr(ConfigNo : integer) : string;
var
  InTrans : boolean;

begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFSTRING').AsString;
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TSVPMainDataModuleTemplate.ReadConfigDate(ConfigNo : integer) : TDateTime;
var
  InTrans : boolean;

begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFDATE').AsDateTime;
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TSVPMainDataModuleTemplate.ReadConfigFloat(ConfigNo,
  LocationNo: integer): double;
var
  InTrans : boolean;

begin

  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    with ReadConfigLoc do begin
      Close;
      Params.ByName('LocationNO').AsInteger := LocationNo;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFFLOAT').AsFloat;
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;

end;

function TSVPMainDataModuleTemplate.ReadConfigInt(ConfigNo,
  LocationNo: integer): integer;
var
  InTrans : boolean;

begin
  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    with ReadConfigLoc do begin
      Close;
      Params.ByName('LocationNO').AsInteger := LocationNo;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFINTEGER').AsInteger;
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;
end;

function TSVPMainDataModuleTemplate.ReadConfigLongStr(
  ConfigNo: integer): string;
var
  InTrans : boolean;
begin

  InTrans := DefaultTrans.InTransaction;
  if not InTrans then
    DefaultTrans.StartTransaction;
  try
    with ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := ReadConfig.FieldByName('TYPEOFLONGSTRING').AsString;
  finally
    if not InTrans then
      DefaultTrans.Commit;
  end;

end;

end.
