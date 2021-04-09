unit uSelectUserList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls,StrUtils;

type
  TUserData = record
    UserCode:String;
    Description:String;
    Selected:Boolean;
  end;

  TfrmUserList = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CheckListBox1: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
    FUserList:Array of TUserData;
    FSelectedUserCodes:String;
    FSelectedUserDesc:String;
    FirstShow:Boolean;
    FAvailableUserCodes:String;
    procedure SetUserCodes(const Value: String);
    procedure SelectACode(LocCode:String);
    procedure BuildCheckList;
    procedure ClearLocList;
    procedure SetAvailableUserCodes(const Value: String);
    procedure ToggleAllOnOff(ToggleOn:Boolean);
  public
    { Public declarations }
    function GetUserCode(Index:Integer):String;

  published
    property SelectedUserCodes:String Read FSelectedUserCodes Write SetUserCodes;
    property AvailableUserCodes:String Read FAvailableUserCodes Write SetAvailableUserCodes;
    property SelectedUserDesc:String Read FSelectedUserDesc ;

  end;

var
  frmUserList: TfrmUserList;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmUserList.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  SetLength(FUserList,0);
  FAvailableUserCodes := '';
end;


procedure TfrmUserList.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    FirstShow := False;
    if CheckListBox1.Count <= 0 then
      BuildCheckList;


  end;

end;

procedure TfrmUserList.FormClose(Sender: TObject;
  var Action: TCloseAction);
var CCount : Integer;
begin

  if ModalResult = mrOK then
  begin
    FSelectedUserCodes := '';
    FSelectedUserDesc := '';

    for CCount := 0 to CheckListBox1.Count - 1 do
    begin

      if CheckListBox1.Checked[cCount] then
      begin
        if FSelectedUserCodes <> '' then
        begin
          FSelectedUserCodes := FSelectedUserCodes + ',';
          FSelectedUserDesc := FSelectedUserDesc + ',';
        end;

        FSelectedUserCodes := FSelectedUserCodes + FUserList[CCount].UserCode;
        FSelectedUserDesc := FSelectedUserDesc + '"'+CheckListBox1.Items.Strings[cCount]+'"';
      end;

    end;



  end;

end;

procedure TfrmUserList.SetUserCodes(const Value: String);
var
  LocCode,TempStr:String;
begin
  FSelectedUserCodes := Value;
  TempStr := Trim(FSelectedUserCodes);

  if CheckListBox1.Count <= 0 then
    BuildCheckList
  else
    ClearLocList;


  While TempStr <> '' do
  begin

    if Pos(',',TempStr) > 0 then
    begin
      LocCode := Copy(TempStr,1,Pos(',',TempStr)-1);
      TempStr:=Copy(TempStr,Pos(',',TempStr)+1,Length(TempStr));
    end
    else
    begin
      LocCode := TempStr;
      TempStr:='';
    end;

    //Remove quotes and trim
    //LocCode := Trim(AnsiReplaceStr(LocCode,'"',''));

    //Now check the check box and make it "selected"
    SelectACode(LocCode);

  end;


end;

procedure TfrmUserList.SelectACode(LocCode: String);
var
  pCount:Integer;
begin

  for PCount := 0 to CheckListBox1.Count -1 do
  begin

    if (Trim(FUserList[PCount].UserCode) = Trim(LocCode)) or
        (Trim(AnsiReplaceStr(FUserList[PCount].UserCode,'"','')) = Trim(LocCode))
     then
    begin
      FUserList[PCount].Selected := True;
      CheckListBox1.Checked[PCount] := True;
      break;
    end;

  end;

end;

procedure TfrmUserList.BuildCheckList;
var
  cCount:Integer;
begin
  SetLength(FUserList,0);
  cCount := 0;
  CheckListBox1.Items.Clear;

  if not dmData.trnOptimiza.InTransaction then
    dmData.trnOptimiza.StartTransaction;

  with dmData.qrySelectUser do
  begin
    SQL.Clear;
    SQL.Add(' Select * from User ');

    if FAvailableUserCodes <> '' then
      SQL.Add('Where UserCode in ('+FAvailableUserCodes+')');

    SQL.Add('Order by Description');

    Open;

    while not Eof do
    begin
      Inc(CCOunt);
      SetLength(FUserList,cCount);

      FUserList[CCount-1].UserCode := '"'+FieldByName('UserCode').AsString+'"';
      FUserList[CCount-1].Description := FieldByName('Description').AsString;
      FUserList[CCount-1].Selected := False;

      CheckListBox1.Items.Add(FieldByName('Description').AsString);

      next;
    end;

    close;
  end;

end;

procedure TfrmUserList.ClearLocList;
var
  cCount:Integer;
begin

  for CCount:= 0 to High(FUserList) do
  begin
    CheckListBox1.Checked[cCount] := False;
    FUserList[CCount].Selected := False;
  end;

end;

function TfrmUserList.GetUserCode(Index: Integer): String;
begin
  Result := '';
  if Index <= High(FUserList)then
    Result := FUserList[Index].UserCode;
end;

procedure TfrmUserList.SetAvailableUserCodes(
  const Value: String);
begin
  FAvailableUserCodes := Value;
  BuildCheckList;
end;

procedure TfrmUserList.ToggleAllOnOff(ToggleOn: Boolean);
var
  CCount:Integer;
begin
    for CCount := 0 to CheckListBox1.Count - 1 do
    begin

      CheckListBox1.Checked[cCount] := ToggleOn;

    end;

end;

procedure TfrmUserList.BitBtn3Click(Sender: TObject);
begin
  ToggleAllOnOff(True);
end;

procedure TfrmUserList.BitBtn4Click(Sender: TObject);
begin
  ToggleAllOnOff(False);

end;

end.
