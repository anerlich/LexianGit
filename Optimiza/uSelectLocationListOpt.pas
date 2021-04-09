unit uSelectLocationListOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls, StrUtils;

type
  TLocationData = record
    LocationCode: String;
    Description: String;
    Selected: Boolean;
  end;

  TfrmSelectLocationList = class(TForm)
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
    FLocationList: Array of TLocationData;
    FSelectedLocationCodes: String;
    FSelectedLocationDesc: String;
    FirstShow: Boolean;
    FAvailableLocationCodes: String;
    procedure SetLocationCodes(const Value: String);
    procedure SelectACode(LocCode: String);
    procedure BuildCheckList;
    procedure ClearLocList;
    procedure SetAvailableLocationCodes(const Value: String);
    procedure ToggleAllOnOff(ToggleOn: Boolean);
  public
    { Public declarations }
    function GetLocationCode(Index: Integer): String;

  published
    property SelectedLocationCodes: String Read FSelectedLocationCodes
      Write SetLocationCodes;
    property AvailableLocationCodes: String Read FAvailableLocationCodes
      Write SetAvailableLocationCodes;
    property SelectedLocationDesc: String Read FSelectedLocationDesc;

  end;

var
  frmSelectLocationList: TfrmSelectLocationList;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmSelectLocationList.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  SetLength(FLocationList, 0);
  FAvailableLocationCodes := '';
end;

procedure TfrmSelectLocationList.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    FirstShow := False;
    if CheckListBox1.Count <= 0 then
      BuildCheckList;

  end;

end;

procedure TfrmSelectLocationList.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  CCount: Integer;
begin

  if ModalResult = mrOK then
  begin
    FSelectedLocationCodes := '';
    FSelectedLocationDesc := '';

    for CCount := 0 to CheckListBox1.Count - 1 do
    begin

      if CheckListBox1.Checked[CCount] then
      begin
        if FSelectedLocationCodes <> '' then
        begin
          FSelectedLocationCodes := FSelectedLocationCodes + ',';
          FSelectedLocationDesc := FSelectedLocationDesc + ',';
        end;

        FSelectedLocationCodes := FSelectedLocationCodes + FLocationList[CCount]
          .LocationCode;
        FSelectedLocationDesc := FSelectedLocationDesc + '"' +
          CheckListBox1.Items.Strings[CCount] + '"';
      end;

    end;

  end;

end;

procedure TfrmSelectLocationList.SetLocationCodes(const Value: String);
var
  LocCode, TempStr: String;
begin
  FSelectedLocationCodes := Value;
  TempStr := Trim(FSelectedLocationCodes);

  if CheckListBox1.Count <= 0 then
    BuildCheckList
  else
    ClearLocList;

  While TempStr <> '' do
  begin

    if Pos(',', TempStr) > 0 then
    begin
      LocCode := Copy(TempStr, 1, Pos(',', TempStr) - 1);
      TempStr := Copy(TempStr, Pos(',', TempStr) + 1, Length(TempStr));
    end
    else
    begin
      LocCode := TempStr;
      TempStr := '';
    end;

    // Remove quotes and trim
    // LocCode := Trim(AnsiReplaceStr(LocCode,'"',''));

    // Now check the check box and make it "selected"
    SelectACode(LocCode);

  end;

end;

procedure TfrmSelectLocationList.SelectACode(LocCode: String);
var
  pCount: Integer;
begin

  for pCount := 0 to CheckListBox1.Count - 1 do
  begin

    if (Trim(FLocationList[pCount].LocationCode) = Trim(LocCode)) or
      (Trim(AnsiReplaceStr(FLocationList[pCount].LocationCode, '"', ''))
      = Trim(LocCode)) then
    begin
      FLocationList[pCount].Selected := True;
      CheckListBox1.Checked[pCount] := True;
      break;
    end;

  end;

end;

procedure TfrmSelectLocationList.BuildCheckList;
var
  CCount: Integer;
begin
  SetLength(FLocationList, 0);
  CCount := 0;
  CheckListBox1.Items.Clear;

  if not dmData.trnOptimiza.InTransaction then
    dmData.trnOptimiza.StartTransaction;

  with dmData.qrySelectLocation do
  begin
    SQL.Clear;
    SQL.Add(' Select * from Location ');

    if FAvailableLocationCodes <> '' then
      SQL.Add('Where LocationCode in (' + FAvailableLocationCodes + ')');

    SQL.Add('Order by Description');

    Open;

    while not Eof do
    begin
      Inc(CCount);
      SetLength(FLocationList, CCount);

      FLocationList[CCount - 1].LocationCode :=
        '"' + FieldByName('LocationCode').AsString + '"';
      FLocationList[CCount - 1].Description :=
        FieldByName('Description').AsString;
      FLocationList[CCount - 1].Selected := False;

      CheckListBox1.Items.Add(FieldByName('Description').AsString);

      next;
    end;

    close;
  end;

end;

procedure TfrmSelectLocationList.ClearLocList;
var
  CCount: Integer;
begin

  for CCount := 0 to High(FLocationList) do
  begin
    CheckListBox1.Checked[CCount] := False;
    FLocationList[CCount].Selected := False;
  end;

end;

function TfrmSelectLocationList.GetLocationCode(Index: Integer): String;
begin
  Result := '';
  if Index <= High(FLocationList) then
    Result := FLocationList[Index].LocationCode;
end;

procedure TfrmSelectLocationList.SetAvailableLocationCodes(const Value: String);
begin
  FAvailableLocationCodes := Value;
  BuildCheckList;
end;

procedure TfrmSelectLocationList.ToggleAllOnOff(ToggleOn: Boolean);
var
  CCount: Integer;
begin
  for CCount := 0 to CheckListBox1.Count - 1 do
  begin

    CheckListBox1.Checked[CCount] := ToggleOn;

  end;

end;

procedure TfrmSelectLocationList.BitBtn3Click(Sender: TObject);
begin
  ToggleAllOnOff(True);
end;

procedure TfrmSelectLocationList.BitBtn4Click(Sender: TObject);
begin
  ToggleAllOnOff(False);

end;

end.
