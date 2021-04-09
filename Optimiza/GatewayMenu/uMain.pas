unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls,StrUtils, ComCtrls, Grids, ValEdit;

//Ver 1.5 - frmUserMaint - Increase screen display on user maint
//        - frmSelectUser - User selection - change from dbgrid to listbox to allow shift click option
//Ver 1.6 - Start Jobs in their own shell

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    ools1: TMenuItem;
    Reports1: TMenuItem;
    Run1: TMenuItem;
    Setup1: TMenuItem;
    UserSetup1: TMenuItem;
    ListBox4: TListBox;
    vleUserList: TValueListEditor;
    vleMenuGroup: TValueListEditor;
    StatusBar1: TStatusBar;
    procedure Exit1Click(Sender: TObject);
    procedure Setup1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RunMenuOption(Sender: TObject);
    procedure UserSetup1Click(Sender: TObject);
  private
    { Private declarations }
    FirstShow:Boolean;
    FUserName,FMenuGroup,FDisabledItems:String;
    procedure LoadMenu;
    procedure RunTheCommand(TagNo:Integer);
    function GetCommandProperty(ColNo, TagNo: Integer): String;
    procedure AssignCommands;
    procedure AssignMenuItem(AMenuItem:TMenuItem);
    function kfVersionInfo: String;
    procedure GetBuildInfo(var V1, V2, V3, V4: Word);
    function GetUserParam:String;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses uMenuMaint, uFileWait, uUserMaint, uPassword, uCommand, uDBconnection;

{$R *.dfm}

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.LoadMenu;
var
  MenuFileName,CmdFileName:String;
  GroupFileName,UserFileName,AStr:String;
  IRow:Integer;
begin

  GroupFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_mnu.dat';
  UserFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_usr.dat';

  if FileExists(GroupFileName) then
    vleMenuGroup.Strings.LoadFromFile(GroupFileName);


  if FileExists(UserFileName) then
    vleUserList.Strings.LoadFromFile(UserFileName);

  FMenuGroup := vleUserList.Values[FUserName];
  StatusBar1.Panels[1].Text := FUserName;

  if (FUserName <> 'ADMIN') and (FMenuGroup = '') then
  begin
    FMenuGroup := 'Basic';
    MessageDlg('Your profile is not registered.'+
                 #10+'Please ask the Optimiza adminstrator'+
                 #10+'to setup your menu profile.',mtInformation,[mbOK],0);

    Close;
  end;

  if FUserName = 'ADMIN' then
    FDisabledItems := ''
  else
  begin
    //Make sure this group does exist, we don't want to grant rights to
    // any old sod.
    if not vleMenuGroup.FindRow(FMenuGroup,IRow) then
    begin
      FMenuGroup := 'Basic';
      MessageDlg('Your profile is not registered.'+
                 #10+'Please ask the Optimiza adminstrator'+
                 #10+'to setup your menu profile.',mtInformation,[mbOK],0);
    end;

    FDisabledItems := UpperCase(vleMenuGroup.Values[FMenuGroup]);
    //Only allow admin to access menu setup!
    FDisabledItems := '|MENU SETUP'+FDisabledItems;
  end;

  StatusBar1.Panels[3].Text := FMenuGroup;

  MenuFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu.dat';
  CmdFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_cmd.dat';

  if FileExists(MenuFileName) then
  begin
    MainMenu1.Free;
    MainMenu1 := Nil;
    MainMenu1 := TMainMenu.Create(frmMain);
    ReadComponentResFile(MenuFileName, MainMenu1);
  end;

  if FileExists(CmdFileName) then
  begin
    ReadComponentResFile(CmdFileName, ListBox4);
  end;

  AssignCommands;

  if not frmDBConnection.CheckConnectionInfo then
  begin
    if MessageDlg('The system was unable to find the connection information for the Optimiza Database.'#10+
                   'The menu system cannot function without the connection information.'#10+
                   'Do you want the system to attempt the Optimiza database connection setup operation now.',
                   mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      frmCommand.LoadVariables;
      frmDBConnection.edit1.text := frmCommand.vleVariables.Values['Network Folder'];
      frmDBConnection.edit2.text := 'D:\'+
                                    frmCommand.vleVariables.Values['Company Folder']+
                                    frmCommand.vleVariables.Values['Database'];
      frmDBConnection.Show;

      if not frmDBConnection.SetupDBconnection then
      begin
        frmDBConnection.Close;
        Close;
      end;



    end
    else
      Close;

  end;

end;

procedure TfrmMain.Setup1Click(Sender: TObject);
var
  MenuFileName,CmdFileName,AStr:String;
  OutputFile:TextFile;
begin
  MenuFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu.dat';
  CmdFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_Cmd.dat';

  //Create new file if one doesn't exist
  if not FileExists(MenuFileName) then
  begin
    WriteComponentResFile(MenuFileName, MainMenu1);
  end;

  frmMenuMaint.LoadMenuItems;

  if frmMenuMaint.showmodal = mrOK then
  begin
    LoadMenu;

  end;

end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  UserName:String;
begin
  if FirstShow then
  begin
    FirstShow := False;

    Caption := Caption + ' Ver '+kfVersionInfo;

    //see if user name was passed on as param
    UserName := GetUserParam;

    if UserName <> '' then
      FUserName := UserName
    else
    begin
      if frmPassword.ShowModal <> mrOK then
        Close;

      FUserName := UpperCase(frmPassword.Edit1.Text);
    end;

    LoadMenu;
    frmCommand.LoadVariables;
    
  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmMain.RunTheCommand(TagNo: Integer);
var
  CmdLine,ClipText,WizMode,WizStr,WParms:String;
  WizNo:Integer;
  UseShellOpen:Boolean;
begin
  //_cmd_Description=2;
  //_cmd_Path=3;
  //_cmd_Exe=4;
  //_cmd_Params=5;
  //_cmd_Wizard=6;
  //_cmd_Wizard_Mode=7;

  //_wiz_None = -1;
  //_wiz_Admin_Only = 0;
  //_wiz_Always_Run = 1;
  //_wiz_Never_Run = 2;
  //_wiz_Lexian_Admin_Only = 3;

  WizMode := GetCommandProperty(_cmd_Wizard_Mode, TagNo);

  if WizMode = '' then
    WizNo := -1
  else
    WizNo := StrToInt(WizMode);

  WizStr := GetCommandProperty(_cmd_Wizard, TagNo)+' ';

  if (Wizno = _wiz_None) or (WizNo=_wiz_Never_Run) then
    WizStr := '';

  if (Wizno = _wiz_Lexian_Admin_Only) and (FUserName <> 'ADMIN') then
    WizStr := '';

  if (Wizno = _wiz_Admin_Only) and (FUserName <> 'ADMIN') then
    WizStr := '';

  CmdLine := Trim(GetCommandProperty(_cmd_Path, TagNo)+
             GetCommandProperty(_cmd_Exe, TagNo));
  WParms := trim(WizStr +
             GetCommandProperty(_cmd_Params, TagNo)) ;

  UseShellOpen := True;

  if Pos('.EXE',UpperCase(CmdLine))>0 then UseShellOpen := False;

  //if UseShellOpen then
  //begin
    ShellOpenFile( self.Handle, cmdLine, WParms, '' );
    Sleep(3000);
  //end
  //else
  //  ExecuteFileWait(CmdLine,'');



end;

function TfrmMain.GetCommandProperty(ColNo, TagNo: Integer): String;
var
  TestStr:String;
  CCount,DCount:Integer;
begin
  Result := '';

  if TagNo >= 0 then
  begin
    TestStr := ListBox4.Items.Strings[TagNo];
    DCount := 0;

    for cCount:= 1 to length(TestStr) do
    begin

      if Copy(TestStr,cCount,1) = '|' then
        inc(DCount)
      else
      begin
        if DCount = ColNo then
          Result := Result + Copy(TestStr,cCount,1);

        if DCount > ColNo then
          break;
      end;

    end;

  end;

  if Result <> '' then
    Result := frmCommand.ConvertVariablesToStr(Result);

end;

procedure TfrmMain.AssignCommands;
var
  ICount,JCount,KCount:Integer;
begin

  for ICount := 0 to MainMenu1.Items.Count -1 do
  begin
    AssignMenuItem(MainMenu1.items[iCount]);

    For JCount := 0 to MainMenu1.items[iCount].Count-1 do
    begin
      AssignMenuItem(MainMenu1.items[iCount].Items[JCount]);

        For KCount := 0 to MainMenu1.items[iCount].Items[JCount].Count-1 do
        begin
          AssignMenuItem(MainMenu1.items[iCount].Items[JCount].Items[KCount]);


        end;

    end;

  end;

end;

procedure TfrmMain.RunMenuOption(Sender: TObject);
var
  CmdLine:String;
  TagNo:Integer;
begin

  TagNo := (Sender as TMenuItem).Tag;
  RunTheCommand(TagNo);

end;

procedure TfrmMain.AssignMenuItem(AMenuItem: TMenuItem);
var
  ACaption:String;
begin
  ACaption := AMenuItem.Caption;

  ACaption := UpperCase(AnsiReplaceStr(ACaption,'&',''));

  if Pos(ACaption,FDisabledItems) > 0 then
    AMenuItem.Enabled := False
  else
  begin

    if (ACaption = 'MENU SETUP') and (AMenuItem.Tag = 999) then
      AMenuItem.OnClick := Setup1Click
    else
      if (ACaption = 'USER SETUP') and (AMenuItem.Tag = 999) then
        AMenuItem.OnClick := UserSetup1Click
      else
        if (ACaption = 'EXIT') and (AMenuItem.Tag = 999) then
          AMenuItem.OnClick := Exit1Click
        else
          if (AMenuItem.Tag > 0) and (AMenuItem.Tag < 999) then
          begin
            AMenuItem.OnClick := RunMenuOption;
          end;

    end;

end;

procedure TfrmMain.UserSetup1Click(Sender: TObject);
var
  ICount,JCount,KCount:Integer;
  MenuCaption:String;
begin

  frmUserMaint.CheckListBox1.Clear;
  frmUserMaint.LoadUserData;

  if FUserName = 'ADMIN' then
    frmUserMaint.vleMenuGroup.ColWidths[0] := 100;

  for ICount := 0 to MainMenu1.Items.Count -1 do
  begin

    frmUserMaint.CheckListBox1.Items.Add('-'+AnsiReplaceStr(MainMenu1.items[iCount].Caption,'&',''));
    frmUserMaint.CheckListBox1.ItemEnabled[frmUserMaint.CheckListBox1.Count-1] := False;
    frmUserMaint.CheckListBox1.Checked[frmUserMaint.CheckListBox1.Count-1] := True;

    For JCount := 0 to MainMenu1.items[iCount].Count-1 do
    begin
      MenuCaption := AnsiReplaceStr(MainMenu1.items[iCount].Items[JCount].Caption,'&','');

      frmUserMaint.CheckListBox1.Items.Add('---'+MenuCaption);

      if MenuCaption = 'Menu Setup' then
      begin
        frmUserMaint.CheckListBox1.ItemEnabled[frmUserMaint.CheckListBox1.Count-1] := False;
        frmUserMaint.CheckListBox1.Checked[frmUserMaint.CheckListBox1.Count-1] := False;
      end;

      if MenuCaption = '-' then
      begin
        frmUserMaint.CheckListBox1.ItemEnabled[frmUserMaint.CheckListBox1.Count-1] := False;
        frmUserMaint.CheckListBox1.Checked[frmUserMaint.CheckListBox1.Count-1] := True;
      end;

      if MenuCaption = 'Exit' then
      begin
        frmUserMaint.CheckListBox1.ItemEnabled[frmUserMaint.CheckListBox1.Count-1] := False;
        frmUserMaint.CheckListBox1.Checked[frmUserMaint.CheckListBox1.Count-1] := True;
      end;

      For KCount := 0 to MainMenu1.items[iCount].Items[JCount].Count-1 do
      begin
        frmUserMaint.CheckListBox1.Items.Add('-----'+AnsiReplaceStr(MainMenu1.items[iCount].Items[JCount].Items[KCount].Caption,'&',''));
      end;

    end;

  end;


  frmUserMaint.ShowModal;
end;

procedure TfrmMain.GetBuildInfo(var V1, V2, V3, V4: Word);
var
   VerInfoSize, VerValueSize, Dummy : DWORD;
   VerInfo : Pointer;
   VerValue : PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

  With VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;

  FreeMem(VerInfo, VerInfoSize);

end;

function TfrmMain.kfVersionInfo: String;
var
  V1,       // Major Version
  V2,       // Minor Version
  V3,       // Release
  V4: Word; // Build Number
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.'
            + IntToStr(V2); // + '.';
            //+ IntToStr(V3) + '.'
            //+ IntToStr(V4);
end;

function TfrmMain.GetUserParam: String;
var
  PCount:Integer;
begin
  Result := '';

  for PCount := 0 to ParamCount do
  begin
    //MessageDlg(ParamStr(pCount),mtConfirmation,[mbOK],0);
    if UpperCase(leftStr(ParamStr(pCount),2)) = '-U' then
    begin
      Result := Copy(ParamStr(pCount),3,length(ParamStr(pCount)));

      Result := Trim(Result);
      Break;

    end;

  end;

end;

end.
