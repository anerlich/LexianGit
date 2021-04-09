unit uSelectDayListOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, ExtCtrls,StrUtils;

Const
  Days: array[1..7] of string =
           ('Sunday', 'Monday', 'Tuesday',
            'Wednesday', 'Thursday',
            'Friday', 'Saturday');

type
  TDayData = record
    DayOfWeek:String;
    Selected:Boolean;
  end;

  TfrmSelectDayList = class(TForm)
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
    FDayList:Array of TDayData;
    FSelectedDays:String;
    FirstShow:Boolean;
    FAvailableDays:String;
    procedure SetDays(const Value: String);
    procedure SelectADay(Day:String);
    procedure BuildCheckList;
    //procedure ClearDayList;
    procedure ToggleAllOnOff(ToggleOn:Boolean);
  public
    { Public declarations }
    function GetDay(Index:Integer):String;
    function OKToRun(OKDayList: string) :Boolean;

  published
    property SelectedDays:String Read FSelectedDays Write SetDays;

  end;

var
  frmSelectDayList: TfrmSelectDayList;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmSelectDayList.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  SetLength(FDayList,7);
  FAvailableDays := '';
end;


procedure TfrmSelectDayList.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    FirstShow := False;

    //BuildCheckList;
  end;

end;

procedure TfrmSelectDayList.FormClose(Sender: TObject;
  var Action: TCloseAction);
var CCount : Integer;
begin

  if ModalResult = mrOK then
  begin
    FSelectedDays := '';

    for CCount := 0 to CheckListBox1.Count - 1 do
    begin

      if CheckListBox1.Checked[cCount] then
      begin
        if FSelectedDays <> '' then
        begin
          FSelectedDays := FSelectedDays + ',';
        end;

        FSelectedDays := FSelectedDays + FDayList[CCount].DayOfWeek;
      end;

    end;



  end;

end;

procedure TfrmSelectDayList.SetDays(const Value: String);
var
  DayOfWeek,TempStr:String;
begin
  FSelectedDays := Value;
  TempStr := Trim(FSelectedDays);

  //if CheckListBox1.Count <= 0 then
    BuildCheckList;
  //else
  //  ClearDayList;


  While TempStr <> '' do
  begin

    if Pos(',',TempStr) > 0 then
    begin
      DayOfWeek := Copy(TempStr,1,Pos(',',TempStr)-1);
      TempStr:=Copy(TempStr,Pos(',',TempStr)+1,Length(TempStr));
    end
    else
    begin
      DayOfWeek := TempStr;
      TempStr:='';
    end;

    SelectADay(DayOfWeek);

  end;


end;

procedure TfrmSelectDayList.SelectADay(Day: String);
var
  pCount:Integer;
begin

  for PCount := 0 to CheckListBox1.Count -1 do
  begin

    if (Trim(FDayList[PCount].DayOfWeek) = Trim(Day)) or
        (Trim(AnsiReplaceStr(FDayList[PCount].DayOfWeek,'"','')) = Trim(Day))
     then
    begin
      FDayList[PCount].Selected := True;
      CheckListBox1.Checked[PCount] := True;
      break;
    end;

  end;

end;

procedure TfrmSelectDayList.BuildCheckList;
var
  cCount:Integer;
begin
  SetLength(FDayList,7);
  cCount := 0;

  for CCount:= 0 to CheckListBox1.Count-1 do
  begin
    CheckListBox1.Checked[cCount] := False;
    FdayList[CCount].DayOfWeek := checkListBox1.Items[cCount];
    FDayList[CCount].Selected := False;
  end;
end;

//procedure TfrmSelectDayList.ClearDayList;
//var
//  cCount:Integer;
//begin

//  for CCount:= 0 to High(FDayList) do
//  begin
//    CheckListBox1.Checked[cCount] := False;
//    FDayList[CCount].Selected := False;
//  end;

//end;

function TfrmSelectDayList.GetDay(Index: Integer): String;
begin
  Result := '';
  if Index <= High(FDayList)then
    Result := FDayList[Index].DayOfWeek;
end;

procedure TfrmSelectDayList.ToggleAllOnOff(ToggleOn: Boolean);
var
  CCount:Integer;
begin
    for CCount := 0 to CheckListBox1.Count - 1 do
    begin

      CheckListBox1.Checked[cCount] := ToggleOn;

    end;

end;

procedure TfrmSelectDayList.BitBtn3Click(Sender: TObject);
begin
  ToggleAllOnOff(True);
end;

procedure TfrmSelectDayList.BitBtn4Click(Sender: TObject);
begin
  ToggleAllOnOff(False);

end;

function TfrmSelectDayList.OKToRun(OKDayList: string) :Boolean;
var
  dow: string;
begin
  dow := Days[DayOfWeek(date)];
  if (pos(dow,OKDayList)>0) then
  begin
    Result := true;
  end
  else
  begin
    Result := false;
  end;
end;

end.
