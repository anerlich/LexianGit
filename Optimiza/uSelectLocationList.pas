unit uSelectLocationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls,StrUtils;

type
  TLocationData = record
    LocationCode:String;
    Description:String;
    Selected:Boolean;
  end;

  TfrmSelectLocationList = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CheckListBox1: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FLocationList:Array of TLocationData;
    FSelectedLocationCodes:String;
    FirstShow:Boolean;
    procedure SetLocationCodes(const Value: String);
    procedure SelectACode(LocCode:String);
    procedure BuildCheckList;
  public
    { Public declarations }

  published
    property SelectedLocationCodes:String Read FSelectedLocationCodes Write SetLocationCodes;

  end;

var
  frmSelectLocationList: TfrmSelectLocationList;

implementation

uses udmMainDLL;

{$R *.dfm}
{$undef EnableMemoryLeakReporting}

procedure TfrmSelectLocationList.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  SetLength(FLocationList,0);
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
var CCount : Integer;
begin

  if ModalResult = mrOK then
  begin
    FSelectedLocationCodes := '';

    for CCount := 0 to CheckListBox1.Count - 1 do
    begin

      if CheckListBox1.Checked[cCount] then
      begin
        if FSelectedLocationCodes <> '' then
          FSelectedLocationCodes := FSelectedLocationCodes + ',';

        FSelectedLocationCodes := FSelectedLocationCodes + FLocationList[CCount].LocationCode;
      end;

    end;



  end;

end;

procedure TfrmSelectLocationList.SetLocationCodes(const Value: String);
var
  LocCode,TempStr:String;
begin
  FSelectedLocationCodes := Value;
  TempStr := Trim(FSelectedLocationCodes);

  if CheckListBox1.Count <= 0 then
    BuildCheckList;

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

procedure TfrmSelectLocationList.SelectACode(LocCode: String);
var
  pCount:Integer;
begin

  for PCount := 0 to CheckListBox1.Count -1 do
  begin

    if Trim(FLocationList[PCount].LocationCode) = Trim(LocCode) then
    begin
      FLocationList[PCount].Selected := True;
      CheckListBox1.Checked[PCount] := True;
      break;
    end;

  end;

end;

procedure TfrmSelectLocationList.BuildCheckList;
var
  cCount:Integer;
begin
  SetLength(FLocationList,0);
  cCount := 0;
  CheckListBox1.Items.Clear;

  if not dmMainDll.trnOptimiza.InTransaction then
    dmMainDll.trnOptimiza.StartTransaction;

  with dmMainDll.qrySelectLocation do
  begin
    Open;

    while not Eof do
    begin
      Inc(CCOunt);
      SetLength(FLocationList,cCount);

      FLocationList[CCount-1].LocationCode := '"'+FieldByName('LocationCode').AsString+'"';
      FLocationList[CCount-1].Description := FieldByName('Description').AsString;
      FLocationList[CCount-1].Selected := False;

      CheckListBox1.Items.Add(FieldByName('Description').AsString);

      next;
    end;

    close;
  end;

end;

end.
