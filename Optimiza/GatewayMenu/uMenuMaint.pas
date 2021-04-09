unit uMenuMaint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Menus, ActnList, ComCtrls, ExtCtrls,StrUtils,
  Grids;

const
  _cmd_TagNo=1;
  _cmd_Description=2;
  _cmd_Path=3;
  _cmd_Exe=4;
  _cmd_Params=5;
  _cmd_Wizard=6;
  _cmd_Wizard_Mode=7;

  _wiz_None = -1;
  _wiz_Admin_Only = 0;
  _wiz_Always_Run = 1;
  _wiz_Never_Run = 2;
  _wiz_Lexian_Admin_Only = 3;


type
  TfrmMenuMaint = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    ools1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    ListBox2: TListBox;
    ListBox3: TListBox;
    N1: TMenuItem;
    NewSeperator1: TMenuItem;
    MoveDown1: TMenuItem;
    Label3: TLabel;
    MoveUp1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    AssignCommand1: TMenuItem;
    ListBox4: TListBox;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    EditMenuNameandTag1: TMenuItem;
    PopupMenu2: TPopupMenu;
    ShowTagWindow1: TMenuItem;
    procedure Add1Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NewSeperator1Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure MoveDown1Click(Sender: TObject);
    procedure MoveUp1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure AssignCommand1Click(Sender: TObject);
    procedure NullCommandRun(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EditMenuNameandTag1Click(Sender: TObject);
    procedure ShowTagWindow1Click(Sender: TObject);
  private
    { Private declarations }
    FCurrentComponent,FCurrentMenuDesc:String;
    FMainMenuItem,FSubMenuItem,FNextMenuItem:TMenuItem;
    procedure AddMenuItem;
    procedure AddTheNewItem(MenuDesc:String);
    procedure DeleteTheItem(MenuDesc:String);
    procedure LoadListBox;
    procedure MoveDown;
    procedure MoveUp;
    function ReservedMenuName(MenuName:String):Boolean;
    function FirstAvailableCommand:Integer;
    function AddEditCommand(ATagNo:Integer):Integer;
    function GetCommandProperty(ColNo,TagNo:Integer):String;
  public
    { Public declarations }
    function LoadMenuItems:Boolean;
  end;

var
  frmMenuMaint: TfrmMenuMaint;

implementation

uses uCommand, uEditMenu, uViewMenuTags;


{$R *.dfm}

{ TfrmMenuMaint }

Function TfrmMenuMaint.LoadMenuItems:Boolean;
var
  MenuFileName,CmdFileName:String;
  SCount:Integer;
begin
  MenuFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu.dat';
  CmdFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_Cmd.dat';

  //Create if doesnt exist
  If not FileExists(CmdFileName) then
  begin
    ListBox4.Items.Strings[0] := Format('|%3d|Reserved|',[0]);
    
    for SCount := 1 to ListBox4.Count-1 do
      ListBox4.Items.Strings[SCount] := Format('|%3d||',[SCount]);

    WriteComponentResFile(CmdFileName, ListBox4);
  end;
//    WriteComponentResFile(CmdFileName, StringGrid1);

  If FileExists(MenuFileName) then
  begin
    MainMenu1.Free;
    MainMenu1 := Nil;
    MainMenu1 := TMainMenu.Create(frmMenuMaint);

    ReadComponentResFile(MenuFileName, MainMenu1);
    Result := True;

    //StringGRid1.Free;
    //StringGRid1 := nil;
    //StringGRid1 := TStringGrid.Create(frmMenuMaint);
    //ReadComponentResFile(CmdFileName, StringGrid1);
    ReadComponentResFile(CmdFileName, ListBox4);


  end
  else
  begin
    REsult := False;
  end;

  ListBox1.ItemIndex := 0;
end;

procedure TfrmMenuMaint.Add1Click(Sender: TObject);
begin
  AddMenuItem;
end;

procedure TfrmMenuMaint.BitBtn9Click(Sender: TObject);
var
  NewMenuItem:TMenuItem;
begin
  NewMenuItem := TMenuItem.Create(Self);
  NewMenuItem.Caption := 'test';
  MainMenu1.Items.Add(NewMenuItem);
end;

procedure TfrmMenuMaint.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CurRow:Integer;
  APos:TPoint;
begin

  APos.X := X;
  APos.Y := Y;
  CurRow := ListBox1.ItemAtPos(APos,true);

  if CurRow >= 0 then
  begin
    ListBox1.ItemIndex := CurRow;
    FCurrentMenuDesc := ListBox1.Items.Strings[CurRow];
  end;

  FCurrentComponent := ListBox1.Name;

end;

procedure TfrmMenuMaint.AddTheNewItem(MenuDesc: String);
var
  NewMenuItem:TMenuItem;
begin
  NewMenuItem := TMenuItem.Create(Self);
  NewMenuItem.Caption := MenuDesc;

  if FCurrentComponent = 'ListBox1' then
    MainMenu1.Items.Add(NewMenuItem);

  if FCurrentComponent = 'ListBox2' then
    FMainMenuItem.Add(NewMenuItem);

  if FCurrentComponent = 'ListBox3' then
    FSubMenuItem.Add(NewMenuItem);

end;

procedure TfrmMenuMaint.ListBox1Click(Sender: TObject);
var
  CurRow:Integer;
  MCount,sCount:Integer;
  MenuDesc:String;
begin
  CurRow := ListBox1.ItemIndex;
  ListBox2.Clear;
  ListBox3.Clear;
  FMainMenuItem := MainMenu1.Items.Items[CurRow];
  FCurrentMenuDesc := ListBox1.Items.Strings[ListBox1.ItemIndex];

  For MCount := 0 to FMainMenuItem.Count -1 do
  begin
    FSubMenuItem := FMainMenuItem.Items[MCount];
    MenuDesc := FSubMenuItem.Caption;
    ListBox2.Items.Add(MenuDesc);
  end;


end;

procedure TfrmMenuMaint.ListBox2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CurRow:Integer;
  APos:TPoint;
begin

  APos.X := X;
  APos.Y := Y;
  CurRow := ListBox2.ItemAtPos(APos,true);

  if CurRow >= 0 then
  begin
    ListBox2.ItemIndex := CurRow;
    FCurrentMenuDesc := ListBox2.Items.Strings[CurRow];
  end;

  FCurrentComponent := ListBox2.Name;
end;

procedure TfrmMenuMaint.ListBox2Click(Sender: TObject);
var
  MainRow,CurRow,MCount:Integer;
  MenuDesc:String;
begin
  MainRow := ListBox1.ItemIndex;
  CurRow := ListBox2.ItemIndex;
  ListBox3.Clear;
  FMainMenuItem := MainMenu1.Items.Items[MainRow];
  FCurrentMenuDesc := ListBox2.Items.Strings[ListBox2.ItemIndex];

  FSubMenuItem := FMainMenuItem.Items[CurRow];

  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';

  if (FSubMenuItem.Tag > 0) and (FSubMenuItem.Tag < 999) then
  begin
    Edit1.Text := GetCommandProperty(_cmd_Description,FSubMenuItem.Tag);
    Edit2.Text := GetCommandProperty(_cmd_Path,FSubMenuItem.Tag);
    Edit3.Text := GetCommandProperty(_cmd_Exe,FSubMenuItem.Tag);

  end
  else
    For MCount := 0 to FSubMenuItem.Count -1 do
    begin
      MenuDesc := FSubMenuItem.Items[mCount].Caption;
      ListBox3.Items.Add(MenuDesc);
    end;

end;

procedure TfrmMenuMaint.ListBox3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CurRow:Integer;
  APos:TPoint;
begin

  APos.X := X;
  APos.Y := Y;
  CurRow := ListBox3.ItemAtPos(APos,true);

  if CurRow >= 0 then
  begin
    ListBox3.ItemIndex := CurRow;
    FCurrentMenuDesc := ListBox3.Items.Strings[CurRow];
  end;

  FCurrentComponent := ListBox3.Name;
end;

procedure TfrmMenuMaint.NewSeperator1Click(Sender: TObject);
var
  NewMenuItem:TMenuItem;
  CurRow:Integer;
begin
  NewMenuItem := TMenuItem.Create(Self);
  NewMenuItem.Caption := '-';

  if FCurrentComponent = 'ListBox2' then
  begin
    CurRow := ListBox2.ItemIndex;
    if CurRow > 0 then
      if (ListBox2.Items.Strings[CurRow] <> '-') and
           (ListBox2.Items.Strings[CurRow-1] <> '-') then
      begin
        FMainMenuItem.Insert(CurRow,NewMenuItem);
        ListBox2.Items.Insert(CurRow,'-');
      end;

  end;

  if FCurrentComponent = 'ListBox3' then
  begin
    CurRow := ListBox3.ItemIndex;
    if CurRow > 0 then
      if (ListBox3.Items.Strings[CurRow] <> '-') and
           (ListBox3.Items.Strings[CurRow-1] <> '-') then
      begin
        FSubMenuItem.Insert(CurRow,NewMenuItem);
        ListBox3.Items.Insert(CurRow,'-');
      end;
  end;

end;

procedure TfrmMenuMaint.ListBox3Click(Sender: TObject);
begin
  FCurrentMenuDesc := ListBox3.Items.Strings[ListBox3.ItemIndex];

end;

procedure TfrmMenuMaint.PopupMenu1Popup(Sender: TObject);
begin
  if FCurrentMenuDesc = '-' then
    Add1.Enabled := False
  else
    Add1.Enabled := True;

  if FCurrentComponent = 'ListBox1' then
    NewSeperator1.Enabled := False
  else
    NewSeperator1.Enabled := True;

end;

procedure TfrmMenuMaint.FormShow(Sender: TObject);
begin
  LoadListBox;
end;

procedure TfrmMenuMaint.DeleteTheItem(MenuDesc: String);
begin
end;

procedure TfrmMenuMaint.AddMenuItem;
var
  MenuDesc:String;
begin

  if FCurrentMenuDesc <> '-' then
  begin
  MenuDesc := InputBox('Menu','Enter Name','');

  if ReservedMenuName(MenuDesc) then
  begin
    MenuDesc := '';
    MessageDlg('Reserved! Cant use this name',mtError,[mbOK],0);
  end;

  end;


  if (MenuDesc <> '') then
  begin

    if FCurrentComponent = 'ListBox1' then
    begin
      ListBox1.Items.Add(MenuDesc);
      AddTheNewItem(MenuDesc);
    end;

    if FCurrentComponent = 'ListBox2' then
    begin
      ListBox2.Items.Add(MenuDesc);
      AddTheNewItem(MenuDesc);
    end;

    if FCurrentComponent = 'ListBox3' then
    begin
      ListBox3.Items.Add(MenuDesc);
      AddTheNewItem(MenuDesc);
    end;

  end;

end;

procedure TfrmMenuMaint.Delete1Click(Sender: TObject);
var
  MenuDesc:String;
begin

  if FCurrentMenuDesc <> '' then
  begin
    MenuDesc := FCurrentMenuDesc;
  end;


  if (MenuDesc <> '') then
  begin

    if FCurrentComponent = 'ListBox1' then
    begin
      if MainMenu1.Items.Items[ListBox1.ItemIndex].Tag = 999 then
        MessageDlg('Reserved. Cannot Delete.',mtError,[MBOK],0)
      else
      begin
        MainMenu1.Items.Delete(ListBox1.ItemIndex);
        ListBox1.Items.Delete(ListBox1.ItemIndex);
      end;

    end;

    if FCurrentComponent = 'ListBox2' then
    begin

      if FMainMenuItem.Items[ListBox2.ItemIndex].Tag = 999 then
        MessageDlg('Reserved. Cannot Delete.',mtError,[MBOK],0)
      else
      begin
        FMainMenuItem.Delete(ListBox2.ItemIndex);
        ListBox2.Items.Delete(ListBox2.ItemIndex);
      end;

    end;

    if FCurrentComponent = 'ListBox3' then
    begin
      if FSubMenuItem.Items[ListBox3.ItemIndex].Tag = 999 then
        MessageDlg('Reserved. Cannot Delete.',mtError,[MBOK],0)
      else
      begin
        FSubMenuItem.Delete(ListBox3.ItemIndex);
        ListBox3.Items.Delete(ListBox3.ItemIndex);
      end;

    end;

  end;

end;

procedure TfrmMenuMaint.LoadListBox;
var
 mCount:Integer;
begin
 ListBox1.Clear;
 ListBox2.Clear;
 ListBox3.Clear;

 for MCount := 0 to MainMenu1.Items.Count-1 do
 begin
   ListBox1.Items.Add(MainMenu1.Items.Items[MCount].Caption);
 end;

 ListBox1.ItemIndex := -1;

end;

procedure TfrmMenuMaint.MoveDown;
var
  CurRow,TempIndex,NewIndex:Integer;
begin

  if FCurrentComponent = 'ListBox1' then
  begin
    CurRow := ListBox1.ItemIndex;

    if CurRow < ListBox1.Count-1 then
    begin
     TempIndex := MainMenu1.Items.Items[CurRow].MenuIndex;
     NewIndex := MainMenu1.Items.Items[CurRow+1].MenuIndex;
     MainMenu1.Items.Items[CurRow].MenuIndex := NewIndex;
     MainMenu1.Items.Items[CurRow].MenuIndex := TempIndex;
     ListBox1.Items.Move(CurRow,CurRow+1);
     ListBox1.ItemIndex := CurRow+1;

    end;

  end;

  if FCurrentComponent = 'ListBox2' then
  begin
    CurRow := ListBox2.ItemIndex;

    if CurRow < ListBox2.Count-1 then
    begin
     TempIndex := FMainMenuItem.Items[CurRow].MenuIndex;
     NewIndex := FMainMenuItem.Items[CurRow+1].MenuIndex;
     FMainMenuItem.Items[CurRow].MenuIndex := NewIndex;
     FMainMenuItem.Items[CurRow].MenuIndex := TempIndex;
     ListBox2.Items.Move(CurRow,CurRow+1);
     ListBox2.ItemIndex := CurRow+1;

    end;

  end;

  if FCurrentComponent = 'ListBox3' then
  begin
    CurRow := ListBox3.ItemIndex;

    if CurRow < ListBox3.Count-1 then
    begin
     TempIndex := FSubMenuItem.Items[CurRow].MenuIndex;
     NewIndex := FSubMenuItem.Items[CurRow+1].MenuIndex;
     FSubMenuItem.Items[CurRow].MenuIndex := NewIndex;
     FSubMenuItem.Items[CurRow].MenuIndex := TempIndex;
     ListBox3.Items.Move(CurRow,CurRow+1);
     ListBox3.ItemIndex := CurRow+1;

    end;

  end;

end;

procedure TfrmMenuMaint.MoveDown1Click(Sender: TObject);
begin
  MoveDown;
end;

procedure TfrmMenuMaint.MoveUp;
var
  CurRow,TempIndex,NewIndex:Integer;
begin

  if FCurrentComponent = 'ListBox1' then
  begin
    CurRow := ListBox1.ItemIndex;

    if CurRow > 0 then
    begin
     TempIndex := MainMenu1.Items.Items[CurRow].MenuIndex;
     NewIndex := MainMenu1.Items.Items[CurRow-1].MenuIndex;
     MainMenu1.Items.Items[CurRow].MenuIndex := NewIndex;
     MainMenu1.Items.Items[CurRow].MenuIndex := TempIndex;
     ListBox1.Items.Move(CurRow,CurRow-1);
     ListBox1.ItemIndex := CurRow-1;

    end;

  end;

  if FCurrentComponent = 'ListBox2' then
  begin
    CurRow := ListBox2.ItemIndex;

    if CurRow > 0 then
    begin
     TempIndex := FMainMenuItem.Items[CurRow].MenuIndex;
     NewIndex := FMainMenuItem.Items[CurRow-1].MenuIndex;
     FMainMenuItem.Items[CurRow].MenuIndex := NewIndex;
     FMainMenuItem.Items[CurRow].MenuIndex := TempIndex;
     ListBox2.Items.Move(CurRow,CurRow-1);
     ListBox2.ItemIndex := CurRow-1;

    end;

  end;

  if FCurrentComponent = 'ListBox3' then
  begin
    CurRow := ListBox3.ItemIndex;

    if CurRow > 0 then
    begin
     TempIndex := FSubMenuItem.Items[CurRow].MenuIndex;
     NewIndex := FSubMenuItem.Items[CurRow-1].MenuIndex;
     FSubMenuItem.Items[CurRow].MenuIndex := NewIndex;
     FSubMenuItem.Items[CurRow].MenuIndex := TempIndex;
     ListBox3.Items.Move(CurRow,CurRow-1);
     ListBox3.ItemIndex := CurRow-1;

    end;

  end;

end;

procedure TfrmMenuMaint.MoveUp1Click(Sender: TObject);
begin
  MoveUp;
end;

procedure TfrmMenuMaint.Exit1Click(Sender: TObject);
begin
NullCommandRun(nil);
end;

procedure TfrmMenuMaint.NullCommandRun(Sender: TObject);
begin
  MessageDlg('This will run the command ...',mtInformation,[mbOK],0);
end;

procedure TfrmMenuMaint.AssignCommand1Click(Sender: TObject);
var
  MenuDesc:String;
  TagNo:Integer;
begin

  if FCurrentMenuDesc <> '' then
  begin

    MenuDesc := FCurrentMenuDesc;

    if ReservedMenuName(MenuDesc) then
    begin
      MenuDesc := '';
      MessageDlg('Reserved! Cant assign.',mtError,[mbOK],0);
    end;

  end;


  if (MenuDesc <> '') then
  begin

    if FCurrentComponent = 'ListBox1' then
    begin
      MessageDlg('Cant run commands from main menu.',mtError,[mbOK],0)
    end;

    if FCurrentComponent = 'ListBox2' then
    begin

      if FMainMenuItem.Items[ListBox2.ItemIndex].Count > 0 then
        MessageDlg('Menu has sub menu items. Cant run command from here.',mtError,[mbOK],0)
      else
      begin
        TagNo := AddEditCommand(FMainMenuItem.Items[ListBox2.ItemIndex].Tag);

        if TagNo >= 0 then
        begin
          //FMainMenuItem.Items[ListBox2.ItemIndex].OnClick := NullCommandRun;
          FMainMenuItem.Items[ListBox2.ItemIndex].Tag := TagNo;
        end;

      end;

    end;

    if FCurrentComponent = 'ListBox3' then
    begin
        TagNo := AddEditCommand(FSubMenuItem.Items[ListBox3.ItemIndex].Tag);

        if TagNo >= 0 then
        begin
          //FSubMenuItem.Items[ListBox3.ItemIndex].OnClick := NullCommandRun;
          FSubMenuItem.Items[ListBox3.ItemIndex].Tag := TagNo;
        end;
    end;

  end;

end;

procedure TfrmMenuMaint.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  MenuFileName,CmdFileName,AStr:String;
  AFile:TextFile;
begin

  if ModalResult = mrOK then
  begin
  
    MenuFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu.dat';
    CmdFileName := ExtractFilePath(ParamStr(0)) + 'GatewayMenu_Cmd.dat';
    WriteComponentResFile(MenuFileName, MainMenu1);
    //WriteComponentResFile(CmdFileName, StringGrid1);
    WriteComponentResFile(CmdFileName, ListBox4);
    CanClose := True;
  end;

end;

function TfrmMenuMaint.ReservedMenuName(MenuName:String): Boolean;
begin


  MenuName :=UpperCase(AnsiReplaceStr(MenuName,'&',''));
  Result := False;

  if (MenuName = 'FILE') or
     (MenuName = '-') or
     (MenuName = 'REPORTS') or
     (MenuName = 'TOOLS') or
     (MenuName = 'EXIT') or
     (MenuName = 'MENU SETUP') or
     (MenuName = 'USER SETUP') or
     (MenuName = 'OPTIONS')  then
     Result := True;

end;

function TfrmMenuMaint.FirstAvailableCommand: Integer;
var
  sCount:Integer;
begin
  Result :=-1;

  for SCount := 0 to ListBox4.Count-1 do
  begin
    if Copy(ListBox4.Items.Strings[SCount],6,1) = '|' then
    begin
      Result := SCount;
      Break;
    end;
  end;

  
end;

function TfrmMenuMaint.AddEditCommand(ATagNo:Integer):Integer;
var
  TagNo:Integer;
  CmdStr,WizMode:String;
begin
  Result := -1;

  if (ATagNo > 0) and (ATagNo < 999) then
  begin
    TagNo := ATagNo;
    frmCommand.Caption := 'Edit Command';
    frmCommand.Edit1.Text := GetCommandProperty(_cmd_Description,TagNo);
    frmCommand.Edit2.Text := GetCommandProperty(_cmd_Path,TagNo);
    frmCommand.Edit2.Hint := frmCommand.Edit2.Text;
    frmCommand.Edit3.Text := GetCommandProperty(_cmd_Exe,TagNo);
    frmCommand.Edit4.Text := GetCommandProperty(_cmd_Params,TagNo);
    frmCommand.Edit6.Text := GetCommandProperty(_cmd_Wizard,TagNo);
    WizMode := GetCommandProperty(_cmd_Wizard_Mode,TagNo);
    if WizMode = '' then
      frmCommand.ComboBox1.ItemIndex := -1
    else
      frmCommand.ComboBox1.ItemIndex := StrToInt(WizMode);

    frmCommand.Edit5.Text := IntToStr(ATagNo);
  end
  else
  begin
    frmCommand.Caption := 'New Command';
    frmCommand.Edit1.Text := '';
    frmCommand.Edit2.Text := '';
    frmCommand.Edit2.Hint := '';
    frmCommand.Edit3.Text := '';
    frmCommand.Edit4.Text := '';
    frmCommand.Edit6.Text := '';
    frmCommand.ComboBox1.ItemIndex := 0;

    frmCommand.Edit5.Text := 'New';
    TagNo := FirstAvailableCommand;
  end;


  if frmCommand.ShowModal = mrOK then
  begin

    if TagNo >= 0 then
    begin
      //Save Delimitted
      CmdStr := Format('|%3d|',[TagNo])+
               frmCommand.Edit1.Text+'|'+
               frmCommand.Edit2.Text+'|'+
               frmCommand.Edit3.Text+'|'+
               frmCommand.Edit4.Text+'|'+
               frmCommand.Edit6.Text+'|'+
               intToStr(frmCommand.ComboBox1.ItemIndex)+'|';

      ListBox4.Items.Strings[TagNo] := CmdStr;
      {StringGrid1.Cells[_cmd_description,TagNo] := frmCommand.Edit1.Text;
      StringGrid1.Cells[_cmd_Path,TagNo] := frmCommand.Edit2.Text;
      StringGrid1.Cells[_cmd_Exe,TagNo] := frmCommand.Edit3.Text;
      StringGrid1.Cells[_cmd_Params,TagNo] := frmCommand.Edit4.Text;}
      Result := TagNo;
    end;


  end;

end;

function TfrmMenuMaint.GetCommandProperty(ColNo, TagNo: Integer): String;
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


end;


procedure TfrmMenuMaint.EditMenuNameandTag1Click(Sender: TObject);
var
  MenuDesc:String;
begin

  if FCurrentMenuDesc <> '' then
  begin
    MenuDesc := FCurrentMenuDesc;
  end;


  if (MenuDesc <> '') then
  begin
    if frmEditMenu = nil then
      Application.CreateForm(TfrmEditMenu, frmEditMenu);

    if FCurrentComponent = 'ListBox1' then
    begin
      frmEditMenu.Edit1.Text := MainMenu1.Items[ListBox1.itemIndex].Caption;
      frmEditMenu.Edit2.Text := MainMenu1.Items[ListBox1.itemIndex].Hint;
      frmEditMenu.SpinEdit1.Value := MainMenu1.Items[ListBox1.itemIndex].Tag;

      if frmEditMenu.ShowModal = mrOK then
      begin
        MainMenu1.Items[ListBox1.itemIndex].Caption := frmEditMenu.Edit1.Text;
        MainMenu1.Items[ListBox1.itemIndex].Hint := frmEditMenu.Edit2.Text;
        MainMenu1.Items[ListBox1.itemIndex].Tag := frmEditMenu.SpinEdit1.Value; 
      end;

    end;

    if FCurrentComponent = 'ListBox2' then
    begin

      frmEditMenu.Edit1.Text := FMainMenuItem.Items[ListBox2.itemIndex].Caption;
      frmEditMenu.Edit2.Text := FMainMenuItem.Items[ListBox2.itemIndex].Hint;
      frmEditMenu.SpinEdit1.Value := FMainMenuItem.Items[ListBox2.itemIndex].Tag;

      if frmEditMenu.ShowModal = mrOK then
      begin
        FMainMenuItem.Items[ListBox2.itemIndex].Caption := frmEditMenu.Edit1.Text;
        FMainMenuItem.Items[ListBox2.itemIndex].Hint := frmEditMenu.Edit2.Text;
        FMainMenuItem.Items[ListBox2.itemIndex].Tag := frmEditMenu.SpinEdit1.Value;
      end;

    end;

    if FCurrentComponent = 'ListBox3' then
    begin

      frmEditMenu.Edit1.Text := FSubMenuItem.Items[ListBox3.itemIndex].Caption;
      frmEditMenu.Edit2.Text := FSubMenuItem.Items[ListBox3.itemIndex].Hint;
      frmEditMenu.SpinEdit1.Value := FSubMenuItem.Items[ListBox3.itemIndex].Tag;

      if frmEditMenu.ShowModal = mrOK then
      begin
        FSubMenuItem.Items[ListBox3.itemIndex].Caption := frmEditMenu.Edit1.Text;
        FSubMenuItem.Items[ListBox3.itemIndex].Hint := frmEditMenu.Edit2.Text;
        FSubMenuItem.Items[ListBox3.itemIndex].Tag := frmEditMenu.SpinEdit1.Value;
      end;



    end;

  end;

end;

procedure TfrmMenuMaint.ShowTagWindow1Click(Sender: TObject);
begin
  frmViewMenuTags.ListBox1.Clear;

  frmViewMenuTags.ListBox1.Items.AddStrings(ListBox4.Items);
  frmViewMenuTags.showModal;
end;

end.
