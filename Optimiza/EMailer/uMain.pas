unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils,
  //NMsmtp,
  Grids, ValEdit, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient, IdSMTP, IdMessage, ShellApi,
  IdExplicitTLSClientServerBase, IdSMTPBase,IDAttachment, IDAttachmentFile;

// Ver 2.2 - Added subject into log file
//         - redirected path of log file.
// Ver 2.3 - Failure when ini file does not exist and wizard does not load.
// Ver 3.1 - Use Gmail SMTP relay to send messages
// Ver 3.2 - Swann is not authenticated in idSMTP1
// Ver 3.3 - Correct the log file name

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

    if (GetParam('Use Gmail SMTP')<>'Yes') then
    begin
     //dont cause optimiza scheduler to halt, but rather
     // log error and continue
     try
      idSMTP1.Host := GetParam('Host');
      Say('Host:'+GetParam('Host'));
      idSMTP1.Port := StrToInt(GetParam('Port'));
      idSMTP1.UserName := GetParam('User ID');
      idSMTP1.Password := GetParam('Password');

      mailmessage.From.Address := GetParam('Sender Email');
      mailmessage.From.Name := GetParam('Sender Name');
      mailmessage.Subject  := GetParam('Subject');

      //idSMTP1.PostMessage.FromAddress := GetParam('Sender Email');
      //idSMTP1.PostMessage.FromName := GetParam('Sender Name');
      //idSMTP1.PostMessage.Subject := GetParam('Subject');

      Say('Sender :'+GetParam('Sender Email'));

      ListBox1.Items.Clear;
      ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('TO'),';',',');

      mailmessage.Recipients.EMailAddresses:=(ListBox1.Items.DelimitedText);

      //idSMTP1.PostMessage.ToAddress.Clear;
      //idSMTP1.PostMessage.ToAddress.AddStrings(ListBox1.Items);
      Say('To :'+GetParam('TO'));

      ListBox1.Items.Clear;
      ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('BCC'),';',',');

      mailmessage.BccList.FillTStrings(ListBox1.Items);

      //idSMTP1.PostMessage.ToBlindCarbonCopy.AddStrings(ListBox1.Items);

      ListBox1.Items.Clear;
      ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('CC'),';',',');

      mailmessage.CCList.EMailAddresses:=(ListBox1.Items.DelimitedText);

      //idSMTP1.PostMessage.ToCarbonCopy.AddStrings(ListBox1.Items);
      Say('CC :'+GetParam('CC'));
      Say('Subject: '+ GetParam('Subject'));

      ListBox1.Items.Clear;
      ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('Attachments'),';',',');

      if (trim(ListBox1.Items.Text)<>'') then tidattachmentFile.Create(mailmessage.MessageParts, ListBox1.Items.CommaText);

      //idSMTP1.PostMessage.Attachments.AddStrings(ListBox1.Items);
      Say('Attachments :'+GetParam('Attachments'));

      ListBox1.Items.Clear;
      ListBox1.Items.CommaText := AnsiReplaceStr(GetParam('Message'),';',',');

      mailmessage.Body.AddStrings(ListBox1.Items);

      //idSMTP1.PostMessage.Body.AddStrings(ListBox1.Items);

      //idSMTP1.SendMail;

      //idSMTP1.Disconnect;
      try
        try
          idSMTP1.Connect;
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
    end
    else
    begin
      // Run program to use Gmail SMTP relay
      //ShellExecute(Handle,'open','SMTP.exe',PChar(ParamStr(1)),nil,SW_SHOWNORMAL);
      //see if parameter is setup
      aFilePath := Trim(dmData.ReadConfigLongStr(286));

      //if not then use the exe path
      if aFilePath = '' then
        aFilePath := Trim(ExtractFilePath(ParamStr(0)));

      //if RightStr(aFilePath,1) <> '\' then AFilePath := aFilePath + '\';
      PathName := Trim(ExtractFilePath(ParamStr(0)));
      if RightStr(PathName,1) <> '\' then PathName := Pathname + '\';
      CmdLine := PathName+'SMTP.exe "'+frmParameters.edtIniFile.Text+'" "'+aFilePath+'"';
      ExecuteFileWait(CmdLine,'');
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
