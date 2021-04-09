unit uDBconnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Registry, StdCtrls,Winsock,StrUtils, ComCtrls;

type
  TfrmDBconnection = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Edit2: TEdit;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    Animate1: TAnimate;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FHostName:String;
    function GetIPFromHost(const HostName: string): String;
    function CreateConnectionInfo: Boolean;
    function GetIPaddress:Boolean;
  public
    { Public declarations }
    function CheckConnectionInfo:Boolean;
    function SetupDBconnection:Boolean;
    
  end;

var
  frmDBconnection: TfrmDBconnection;

implementation

{$R *.dfm}

{ TfrmDBconnection }

function TfrmDBconnection.CheckConnectionInfo: Boolean;
var
  cVar, cPth: String;
  SvpReg: TRegistry;
Const svpPath = 'Path';
begin
   svpReg := Tregistry.Create;
   svpReg.Access := KEY_READ;
   svpreg.RootKey :=   HKEY_CURRENT_USER;
   cVar := 'SOFTWARE\Execulink\Optimiza\Database' ;
   cPth := '';

   If svpReg.OpenKey(cVar,False) = True then Begin
     cPth := svpReg.ReadString(svpPath);
   End;

   if cPth = '' then
   begin
     svpreg.RootKey :=   HKEY_LOCAL_MACHINE;
     cVar := 'SOFTWARE\Execulink\Svp\Database' ;
     cPth := '';

     If svpReg.OpenKey(cVar,False) = True then Begin
       cPth := svpReg.ReadString(svpPath);
     End;
   end;

   svpReg.CloseKey;
   svpReg.Free;

   if cPth = '' then
     Result := False
   else
     Result := True;

end;

procedure TfrmDBconnection.Button1Click(Sender: TObject);
begin
  SetupDBconnection;
end;

function TfrmDBconnection.GetIPFromHost(const HostName: string): String;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  i: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := '';
  phe := GetHostByName(PChar(HostName));
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  while pPtr^[i] <> nil do
  begin
    Result := inet_ntoa(pptr^[i]^);
    Inc(i);
  end;
  WSACleanup;

end;

function TfrmDBconnection.CreateConnectionInfo: Boolean;
var
  cVar, cPth,NewPath: String;
  SvpReg: TRegistry;
begin
   Result := False;

   try
     svpReg := Tregistry.Create;

     try

       svpReg.Access := KEY_WRITE;
       svpreg.RootKey :=   HKEY_LOCAL_MACHINE;


       if SvpReg.OpenKey('SOFTWARE',False) then
         if SvpReg.CreateKey('Execulink') then
           if SvpReg.OpenKey('Execulink',False) then
             if SvpReg.CreateKey('Svp') then
               if SvpReg.OpenKey('Svp',False) then
                 if SvpReg.CreateKey('Database') then
                   if SvpReg.OpenKey('Database',False) then
                   begin
                     NewPath := Edit3.Text + ':'+Edit2.Text;
                     SvpReg.WriteString('Path',NewPath);
                     SvpReg.WriteString('Name','Optimiza');

                     if SvpReg.CreateKey('Optimiza') then
                       if SvpReg.OpenKey('Optimiza',False) then
                       begin
                         SvpReg.WriteString('Path',NewPath);
                         Result := True;
                       end;

                   end;

       svpReg.CloseKey;

     except
       Result := False;
     end;




   finally
     svpReg.Free;
   end;

   if not Result then
     MessageDlg('Unable to store database path in the system registry.'#10+
                'Possibly due to insufficient privileges.'#10+
                'Please contact support.',mtError,[mbOK],0);

end;

function TfrmDBconnection.SetupDBconnection: Boolean;
var
  IpAddStr,NewPath:String;
begin
  Edit1.Text := AnsiReplaceStr(Edit1.Text,'\','');
  Result := False;

  if Edit3.Text = '' then
  begin
    GetIPAddress;   //Make sure we get IP address
  end;

  if Edit3.Text <> '' then
  begin
    if CreateConnectionInfo then
    begin
      Result := True;
      MessageDlg('Database setup complete.',mtConfirmation,[mbOK],0);
      Close;

    end;

  end;




end;

function TfrmDBconnection.GetIPaddress: Boolean;
begin
  Animate1.Active := True;
  Animate1.Visible := True;

  Label3.Caption := 'Getting IP Address for ' + Edit1.Text;
  Application.ProcessMessages;
  Edit3.Text := GetIPFromHost(Edit1.Text);
  Animate1.Active := False;
  Animate1.Visible := False;
  Label3.Caption := '';
  Application.ProcessMessages;
  Result := True;

  if Edit3.Text = '' then
  begin
    Result := False;
    MessageDlg('Cannot find server on the network! Contact Support for Help!',mtError,[mbOK],0);
  end;


end;

procedure TfrmDBconnection.Button2Click(Sender: TObject);
begin
  GetIPaddress;
end;

end.
