unit uUserMaint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ValEdit, CheckLst, ExtCtrls;

type
  TfrmUserMaint = class(TForm)
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    vleMenuGroup: TValueListEditor;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit2: TEdit;
    lstUser: TListBox;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    vleUserList: TValueListEditor;
    CheckListBox1: TCheckListBox;
    Panel4: TPanel;
    Edit1: TEdit;
    Label2: TLabel;
    procedure vleMenuGroupSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure BitBtn3Click(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetUsersForMenu(MenuGroup:String);
    procedure ApplyMenuItems(MenuGroup:String);
    procedure DisableMenuItems(MenuGroup: String);
    function RemoveIndent(AMenu:String):String;
  public
    { Public declarations }
    procedure LoadUserData;
  end;

var
  frmUserMaint: TfrmUserMaint;

implementation

uses uSelectUser, udmData;

{$R *.dfm}

procedure TfrmUserMaint.vleMenuGroupSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  Edit1.Text := vleMenuGroup.Cells[0,ARow];
  Edit2.Text := Edit1.Text;
  GetUsersForMenu(Edit2.text);
  DisableMenuItems(Edit1.Text);
end;

procedure TfrmUserMaint.BitBtn3Click(Sender: TObject);
var
  AUser:String;
  iRow,CCount:Integer;
begin

 if dmData = nil then
  Application.CreateForm(TdmData, dmData);

  frmSelectUser.ListBox1.Items := lstUser.Items;

  if frmSelectUser.ShowModal = mrOK then
  begin
    //first reset previous users to basic, so if they are deleted then
    // they will receive a default
    for CCount := 0 to lstUser.Count-1 do
    begin
      AUser := lstUser.Items.Strings[CCount];

      if vleUserList.FindRow(AUser,iRow) then
        vleUserList.Values[AUser] := '';

    end;

    lstUser.Clear;

    for CCount := 0 to frmSelectUser.ListBox1.Count-1 do
    begin
      AUser := frmSelectUser.ListBox1.Items.Strings[CCount];

      if vleUserList.FindRow(AUser,iRow) then
        vleUserList.Values[AUser] := Edit2.Text
      else
        vleUserList.InsertRow(Auser,Edit2.text,True);

      lstUser.Items.Add(AUser);

    end;

  end;

end;

procedure TfrmUserMaint.GetUsersForMenu(MenuGroup:String);
var
  CCount:Integer;
begin
  lstUser.Clear;

  for cCount := 0 to vleUserList.RowCount-1 do
  begin

    if vleUserList.Cells[1,CCount] = MenuGroup then
    begin
      lstUser.Items.Add(vleUserList.Cells[0,CCount]);
    end;

  end;

end;

procedure TfrmUserMaint.ApplyMenuItems(MenuGroup: String);
var
  CCount:Integer;
  DisabledItems,Amenu:String;
begin

  DisabledItems := '|';

  for cCount := 0 to CheckListBox1.Count-1 do
  begin

    if not CheckListBox1.Checked[CCount] then
    begin
      //Get the string value for the menu item, i.e. remove --- from the
      //  beginning
      Amenu := RemoveIndent(CheckListBox1.Items.Strings[CCount]);



      DisabledItems := DisabledItems +  Amenu + '|';
    end;

  end;

  vleMenuGroup.Values[MenuGroup] := DisabledItems;

end;

procedure TfrmUserMaint.CheckListBox1Click(Sender: TObject);
begin
  ApplyMenuItems(Edit1.Text);
end;

procedure TfrmUserMaint.DisableMenuItems(MenuGroup: String);
var
  CCount:Integer;
  DisabledItems,Amenu:String;
begin

  DisabledItems := vleMenuGroup.Values[Edit1.Text];

  for cCount := 0 to CheckListBox1.Count-1 do
  begin
    CheckListBox1.Checked[CCount] := True;

    Amenu :=RemoveIndent(CheckListBox1.Items.Strings[CCount]);

    if Pos(AMenu,DisabledItems) > 0 then
      CheckListBox1.Checked[CCount] := False;

  end;

end;

function TfrmUserMaint.RemoveIndent(AMenu: String): String;
begin
  Result := AMenu;

  //Strip out indentation
  if Copy(Amenu,1,5) = '-----' then
    Result := Copy(Amenu,6,Length(Amenu))
  else
    if Copy(Amenu,1,3) = '---' then
      Result := Copy(Amenu,4,Length(Amenu))
    else
      Result := Copy(Amenu,2,Length(Amenu));

end;

procedure TfrmUserMaint.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  GroupFileName,UserFileName,AStr:String;
  AFile:TextFile;
begin

  if ModalResult = mrOK then
  begin
    GroupFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_mnu.dat';
    UserFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_usr.dat';

    vleMenuGroup.Strings.SaveToFile(GroupFileName);
    vleUserList.Strings.SaveToFile(UserFileName);
    CanClose := True;
  end;

end;

procedure TfrmUserMaint.LoadUserData;
var
  GroupFileName,UserFileName,AStr:String;
  AFile:TextFile;
begin

    GroupFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_mnu.dat';
    UserFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_usr.dat';

    //Create if they don't exist.
    if not FileExists(GroupFileName) then
      vleMenuGroup.Strings.SaveToFile(GroupFileName)
    else
    begin
      vleMenuGroup.Strings.LoadFromFile(GroupFileName);
    end;

    if not FileExists(UserFileName) then
      vleUserList.Strings.SaveToFile(UserFileName)

    else
    begin
      vleUserList.Strings.LoadFromFile(UserFileName);
    end;

end;

procedure TfrmUserMaint.FormActivate(Sender: TObject);
begin
  GetUsersForMenu(Edit2.text);
  DisableMenuItems(Edit1.Text);

end;

procedure TfrmUserMaint.BitBtn6Click(Sender: TObject);
begin

  if vleMenuGroup.Row < 6 then
    MessageDlg('Cannot delete reserved menu groups',mtError,[mbOK],0)
  else
    if MessageDlg('Delete '+vleMenuGroup.Cells[0,vleMenuGroup.Row],mtConfirmation,[mbYes,MbNo],0) = mrYes then
    begin
      vleMenuGroup.DeleteRow(vleMenuGroup.Row);
    end;

end;

procedure TfrmUserMaint.BitBtn4Click(Sender: TObject);
var
  NewGroup:String;
begin

  While True do
  begin
    NewGroup := InputBox('New Group','Enter New Group','');

    if NewGroup <> '' then
    begin
      try
        vleMenuGroup.InsertRow(NewGroup,'',True);
        Break;
      except
        MessageDlg(NewGroup+' Already Exists!',mtError,[mbOK],0);
      end;

    end
    else
      break;

  end;

end;

procedure TfrmUserMaint.BitBtn5Click(Sender: TObject);
var
  NewName,OldName:String;
begin

  if vleMenuGroup.Row < 6 then
    MessageDlg('Cannot change reserved menu groups',mtError,[mbOK],0)
  else
  begin
    OldName := vleMenuGroup.Cells[0,vleMenuGroup.Row];

    While True do
    begin
      NewName := InputBox('Rename','Rename ['+OldName+'] to','');

      if NewName <> '' then
      begin
        try
          vleMenuGroup.Cells[0,vleMenuGroup.Row]:=NewName;
          Break;
        except
          MessageDlg(NewName+' Already Exists!',mtError,[mbOK],0);
        end;

      end
      else
        break;

    end;


  end;


end;

end.
