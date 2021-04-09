//Version 1.0: Original per Colin McCall
//
//Version 1.1: Allow program to work with smtp.Office365.com
//             as well as mail.lexian.com.au by using TLSv1 and including an ini file
//             switch for whether implicit TLS (Lexian) or explicit TLS (Office365)
//             should be used per this article
//             https://stackoverflow.com/questions/38740921/cannot-use-secure-smtp-connection-to-office365-with-delphi-2010-and-indy-10-5-5
//             - Andrew Nerlich
unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils,
   Grids, ValEdit, IdBaseComponent, IdComponent, IdTCPConnection,
   IdTCPClient, IdMessageClient, IdSMTP, IdMessage, ShellApi, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdExplicitTLSClientServerBase, IdSMTPBase, IDAttachment, IDAttachmentFile;

// ======================================================================================
// NOTE: Include  libeay32.dll and ssleay32.dll in the folder that EmailSSL.exe runs from
// ======================================================================================
// Ver 1.0 - Inital version (Compiled with Delpi 10.3)

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Label1: TLabel;
    ListBox1: TListBox;
    vleLastParams: TValueListEditor;
    IdSMTP1: TIdSMTP;
    mailMessage: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    LogFile : TextFile;
    FirstShow:Boolean;
    FFireEvent:Boolean;
    FLast_Host,FLast_UserID:String;
    FLast_Port:Integer;
    procedure Say(Line : string);
    procedure StartProcess;
    procedure OpenLogFile;
    function GetParam(ParamName: String): String;
    procedure LoadDefaults;
    procedure LoadLastParams;
    procedure SaveLastParams;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

const
  _DefaultPort = 25;
  _DefaultString = '[DEFAULT]';

implementation

uses udmData, uParameters, uFileWait;

{$R *.DFM}

procedure TfrmMain.Say(Line : string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Application.ProcessMessages;
end;

procedure TfrmMain.StartProcess;
var
  CmdLine,PathName,aFilePath: string;
begin

  Say('Start');


  try
    frmParameters.LoadParam;

    //Use Params from default if database connection issue
    if dmData.FConnectionIssue then
      LoadLastParams  //attempt to load last set of successful params
    else
      LoadDefaults;   //atempt to load from server.

   //dont cause optimiza scheduler to halt, but rather
   // log error and continue
   try
   //    IdSSLIOHandlerSocketOpenSSL1.Host := GetParam('Host');
   //    IdSSLIOHandlerSocketOpenSSL1.Port := StrToInt(GetParam('Port'));
   //    IdSSLIOHandlerSocketOpenSSL1.Destination :=  Trim(GetParam('Host')) + ':' + Trim(GetParam('Port'));
   //   IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Method := sslvSSLv3;
   // Say('SSL IO Handler Destination:' + IdSSLIOHandlerSocketOpenSSL1.Destination);

    idSMTP1.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(idSMTP1);

    // Explicit TLS must be used for smtp.Office365.com
    // Implicit TLS must be used for mail.lexian.com.au
    if Trim(GetParam('ExplicitTLS'))='Y' then
      idSMTP1.UseTLS := utUseExplicitTLS
    else
       idSMTP1.UseTLS := utUseImplicitTLS;

    //This method will work for both Lexian and office365 mail servers
    TIdSSLIOHandlerSocketOpenSSL(idSMTP1.IOHandler).SSLOptions.Method := sslvTLSv1;

    idSMTP1.Host := GetParam('Host');
    Say('Host:'+idSMTP1.Host);
    idSMTP1.Port := StrToInt(GetParam('Port'));
    idSMTP1.Username := GetParam('User ID');
    idSMTP1.Password := GetParam('Password');

    mailmessage.From.Address := GetParam('Sender Email');
    mailmessage.From.Name := GetParam('Sender Name');
    mailmessage.Subject  := GetParam('Subject');

    Say('Sender :'+GetParam('Sender Email'));

    ListBox1.Items.Clear;
    ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('TO'),';',',');

    mailmessage.Recipients.EMailAddresses:=(ListBox1.Items.DelimitedText);

    Say('To :'+GetParam('TO'));

    ListBox1.Items.Clear;
    ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('BCC'),';',',');

    mailmessage.BccList.FillTStrings(ListBox1.Items);

    ListBox1.Items.Clear;
    ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('CC'),';',',');

    mailmessage.CCList.EMailAddresses:=(ListBox1.Items.DelimitedText);

    Say('CC :'+GetParam('CC'));
    Say('Subject: '+ GetParam('Subject'));

    ListBox1.Items.Clear;
    ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('Attachments'),';',',');

    if (trim(ListBox1.Items.Text)<>'') then tidattachmentFile.Create(mailmessage.MessageParts, ListBox1.Items.CommaText);

    Say('Attachments :'+GetParam('Attachments'));

    ListBox1.Items.Clear;
    ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('Message'),';',',');

    mailmessage.Body.AddStrings(ListBox1.Items);

    try
      try
        idSMTP1.Connect;
        idSMTP1.Authenticate;
        idSMTP1.Send(mailmessage);
      except on E:Exception do
        Say('ERROR: ' + e.Message);
      end;
    finally
      if idSMTP1.Connected then idSMTP1.Disconnect;
    end;


     except
        on e: exception do begin
          Say('******************************************************');
          Say('*** ' + e.Message);
          Say('******************************************************');
        end;
     end;

    Say('Finished');
    if not dmData.FConnectionIssue then
    begin
      SaveLastParams;

      if FFireEvent then
        dmData.FireEvent('S');

    end;

  except
      on e: exception do begin
        Say('***  failed');
        Say('*** ' + e.Message);

        if not dmData.FConnectionIssue then
          if FFireEvent then
            dmData.FireEvent('F');

      end;
  end;


end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  StartTime : TDateTime;
  RunProcess:Boolean;
  FName:String;
begin

  if FirstShow then
  begin
    Caption := AnsiReplaceStr(ExtractFileName(ParamStr(0)),'.exe','');

    if not dmData.FConnectionIssue then
      Caption := Caption + ' ' + dmData.DbDescription
    else
      Caption := Caption + 'Not Connected';

    FirstShow := False;

    if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) then
    begin
      frmParameters.edtIniFile.Text := ParamStr(1);

      If UpperCase(ParamStr(2)) = 'NOFIREEVENT' then
        FFireEvent := False;

      RunProcess := True;

    end
    else
    Begin

      Memo1.Lines.add('Parameter Setup');
      frmParameters.Caption := 'Parameter Setup';

       if UpperCase(ParamStr(1)) = '-Z' then
       begin

        frmParameters.edtIniFile.Text := ParamStr(3);
        frmParameters.LoadParam;


       end;

      frmParameters.ShowModal;

      RunProcess := frmParameters.CreateOutput;

    end;

    if RunProcess then
    begin
      OpenLogFile;

      StartTime := Now;
      Say(FName+' started on ' + DateTimeToStr(StartTime));

      StartProcess;

      Say(FName+' finished on ' + DateTimeToStr(Now));
      Say(Format('Elapsed Time: %.2f seconds', [(Now - StartTime) * 86400]));

      CloseFile(LogFile);
      Close;
    end
    else
      Close;


  end;



end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  FFireEvent := True;
end;



procedure TfrmMain.OpenLogFile;
var
  FName,aFilePath:String;
  Year,Month,Day:Word;
  FCount:Integer;
begin
  //see if parameter is setup
  aFilePath := Trim(dmData.ReadConfigLongStr(286));

  //if not then use the exe path
  if aFilePath = '' then
    aFilePath := Trim(ExtractFilePath(ParamStr(0)));

  if RightStr(aFilePath,1) <> '\' then AFilePath := aFilePath + '\';

  FName := FName + ExtractFileName(ParamStr(0));
  FName := AnsiReplaceStr(FName,'.exe','');
  DecodeDate(Now, Year, Month, Day);
  FName := aFilePath + Format('%d%2.2d%2.2d '+FName+'.log', [Year, Month, Day]);

  for FCount := 1 to 100 do
  begin

    If FileExists(FName) then
    begin

      if FCount = 1 then
        FName := AnsiReplaceStr(FName,'.log','.'+IntToStr(FCount)+'.log')
      else
        FName := AnsiReplaceStr(FName,'.'+IntToStr(FCount-1)+'.log','.'+IntToStr(FCount)+'.log');


    end
    else
      Break;

  end;

  AssignFile(LogFile,FName );
  Rewrite(LogFile);

end;

function TfrmMain.GetParam(ParamName: String): String;
begin
  Result := frmParameters.vleParameters.Values[ParamName];
end;



procedure TfrmMain.LoadDefaults;
begin

  if UpperCase(GetParam('Host')) = _DefaultString then
    frmParameters.VleParameters.Values['Host'] := dmData.GetHostName;

  if UpperCase(GetParam('User ID')) = _DefaultString then
    frmParameters.VleParameters.Values['User ID'] := dmData.GetUserID;

  if UpperCase(GetParam('Port')) = _DefaultString then
    frmParameters.VleParameters.Values['Port'] := '25';

end;

procedure TfrmMain.LoadLastParams;
var
  ParamFile:String;
begin

  ParamFile := ExtractFilePath(ParamStr(0)) + 'email_default.dat';

  if FileExists(ParamFile) then
    vleLastParams.Strings.LoadFromFile(ParamFile);

  FLast_Host := vleLastParams.Values['Host'];
  FLast_UserID := vleLastParams.Values['User ID'];
  FLast_Port:= StrToInt(vleLastParams.Values['Port']);

end;

procedure TfrmMain.SaveLastParams;
var
  ParamFile:String;
begin
  vleLastParams.Values['Host']:= GetParam('Host');
  vleLastParams.Values['User ID']:=GetParam('User ID');
  vleLastParams.Values['Password']:=GetParam('Password');
  vleLastParams.Values['Port']:= GetParam('Port');

  ParamFile := ExtractFilePath(ParamStr(0)) + 'email_default.dat';
  vleLastParams.Strings.SaveToFile(ParamFile);

end;

end.
