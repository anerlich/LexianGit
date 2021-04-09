unit uDmData;

interface

uses
  SysUtils, Classes, DB, IBDatabase,Dialogs,Controls, IBCustomDataSet,
  IBTable, IBQuery;

type
  TdmData = class(TDataModule)
    dbMain: TIBDatabase;
    trnMain: TIBTransaction;
    srcMailTypes: TDataSource;
    srcCustomer: TDataSource;
    qryCustomer: TIBQuery;
    qryMailTypes: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CreateNewDatabase;
  public
    { Public declarations }
    procedure ConnectDatabase;
    procedure CommitData;
    procedure CommitAndClose;
  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

{ TdmData }

procedure TdmData.CommitAndClose;
begin

  if trnMain.InTransaction then
    trnMain.Commit;
    
  dbMain.Close;
end;

procedure TdmData.CommitData;
begin

  if trnMain.InTransaction then
    trnMain.Commit;

  trnMain.StartTransaction;

end;

procedure TdmData.ConnectDatabase;
begin

 With dbMain do Begin
    Connected := False;
    LoginPrompt := False;
    Params.Clear;
    Params.Add('user_name=SYSDBA');
    Params.Add('password=masterkey');
    Connected := True;
  End;

  qryCustomer.Open;
  qryMailTypes.Open;

  if not trnMain.InTransaction then
    trnMain.StartTransaction;

end;

procedure TdmData.CreateNewDatabase;
begin
  dbMain.CreateDatabase;
end;

procedure TdmData.DataModuleCreate(Sender: TObject);
var
  AFileName,ADbName:String;
begin
 { AFileName := ExtractFilePath(ParamStr(0))+ 'MailChecker.gdb';
  ADbName := 'localhost:'+ AFileName;
  dbMain.DatabaseName := ADbName;

  if not FileExists(AFileName) then
  begin

    if MessageDlg('This appears to be a new installation. Create Necessary Files ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      AFileName := InputBox('Confirm','Please confirm the database criteria',ADbName);
      dbMain.DatabaseName := ADbName;
      CreateNewDataBase;
    end;

  end;
    }
end;

end.
