unit uSelectSKUFlag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls,StrUtils;

type
  TSKUFlagsData = record
    SKUFlag:String;
    Description:String;
    Selected:Boolean;
  end;

  TfrmSelectSKUFlagList = class(TForm)
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
    FSKUFlagList:Array of TSKUFlagsData;
    FSelectedSKUFlags:String;
    FSelectedLocationDesc:String;
    FirstShow:Boolean;
    FReportingCategory:String;
    procedure SetSKUFlags(const Value: String);
    procedure SelectACode(LocCode:String);
    procedure BuildCheckList;
    procedure ClearSKUFlagList;
    procedure SetReportingCategory(const Value: String);
    procedure ToggleAllOnOff(ToggleOn:Boolean);
  public
    { Public declarations }
    function GetSKUFlag(Index:Integer):String;

  published
    property SelectedSKUFlags:String Read FSelectedSKUFlags Write SetSKUFlags;
    property ReportingCategory:String Read FReportingCategory Write SetReportingCategory;
    property SelectedLocationDesc:String Read FSelectedLocationDesc ;

  end;

var
  frmSelectSKUFlagList: TfrmSelectSKUFlagList;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmSelectSKUFlagList.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  SetLength(FSKUFlagList,0);
  FReportingCategory := '';
end;


procedure TfrmSelectSKUFlagList.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    FirstShow := False;
    if CheckListBox1.Count <= 0 then
      BuildCheckList;


  end;

end;

procedure TfrmSelectSKUFlagList.FormClose(Sender: TObject;
  var Action: TCloseAction);
var CCount : Integer;
begin

  if ModalResult = mrOK then
  begin
    FSelectedSKUFlags := '';
    FSelectedLocationDesc := '';

    for CCount := 0 to CheckListBox1.Count - 1 do
    begin

      if CheckListBox1.Checked[cCount] then
      begin
        if FSelectedSKUFlags <> '' then
        begin
          FSelectedSKUFlags := FSelectedSKUFlags + ',';
          FSelectedLocationDesc := FSelectedLocationDesc + ',';
        end;

        FSelectedSKUFlags := FSelectedSKUFlags + FSKUFlagList[CCount].SKUFlag;
        FSelectedLocationDesc := FSelectedLocationDesc + '"'+CheckListBox1.Items.Strings[cCount]+'"';
      end;

    end;



  end;

end;

procedure TfrmSelectSKUFlagList.SetSKUFlags(const Value: String);
var
  LocCode,TempStr:String;
begin
  FSelectedSKUFlags := Value;
  TempStr := Trim(FSelectedSKUFlags);

  if CheckListBox1.Count <= 0 then
    BuildCheckList
  else
    ClearSKUFlagList;


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

procedure TfrmSelectSKUFlagList.SelectACode(LocCode: String);
var
  pCount:Integer;
begin

  for PCount := 0 to CheckListBox1.Count -1 do
  begin

    if (Trim(FSKUFlagList[PCount].SKUFlag) = Trim(LocCode)) or
        (Trim(AnsiReplaceStr(FSKUFlagList[PCount].SKUFlag,'"','')) = Trim(LocCode))
     then
    begin
      FSKUFlagList[PCount].Selected := True;
      CheckListBox1.Checked[PCount] := True;
      break;
    end;

  end;

end;

procedure TfrmSelectSKUFlagList.BuildCheckList;
var
  cCount:Integer;
begin
  SetLength(FSKUFlagList,0);
  cCount := 0;
  CheckListBox1.Items.Clear;

  if not dmData.trnOptimiza.InTransaction then
    dmData.trnOptimiza.StartTransaction;

  with dmData.qrySKUFlag do
  begin
    SQL.Clear;
    SQL.Add(' Select * from ReportCategory ');
    SQL.Add('Where ReportCategoryType = '+FReportingCategory);

    SQL.Add('Order by ReportCategoryCode');

    Open;

    while not Eof do
    begin
      Inc(CCOunt);
      SetLength(FSKUFlagList,cCount);

      FSKUFlagList[CCount-1].SKUFlag := '"'+FieldByName('ReportCategoryCode').AsString+'"';
      FSKUFlagList[CCount-1].Description := FieldByName('Description').AsString;
      FSKUFlagList[CCount-1].Selected := False;

      CheckListBox1.Items.Add(FieldByName('Description').AsString);

      next;
    end;

    close;
  end;

end;

procedure TfrmSelectSKUFlagList.ClearSKUFlagList;
var
  cCount:Integer;
begin

  for CCount:= 0 to High(FSKUFlagList) do
  begin
    CheckListBox1.Checked[cCount] := False;
    FSKUFlagList[CCount].Selected := False;
  end;

end;

function TfrmSelectSKUFlagList.GetSKUFlag(Index: Integer): String;
begin
  Result := '';
  if Index <= High(FSKUFlagList)then
    Result := FSKUFlagList[Index].SKUFlag;
end;

procedure TfrmSelectSKUFlagList.SetReportingCategory(
  const Value: String);
begin
  FReportingCategory := Value;
  BuildCheckList;
end;

procedure TfrmSelectSKUFlagList.ToggleAllOnOff(ToggleOn: Boolean);
var
  CCount:Integer;
begin
    for CCount := 0 to CheckListBox1.Count - 1 do
    begin

      CheckListBox1.Checked[cCount] := ToggleOn;

    end;

end;

procedure TfrmSelectSKUFlagList.BitBtn3Click(Sender: TObject);
begin
  ToggleAllOnOff(True);
end;

procedure TfrmSelectSKUFlagList.BitBtn4Click(Sender: TObject);
begin
  ToggleAllOnOff(False);

end;

end.
