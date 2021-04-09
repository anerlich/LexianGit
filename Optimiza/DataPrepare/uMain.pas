unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,StrUtils, ExtCtrls,Clipbrd,Math;

Const
  MAXFIELDS = 200;

type
  TFieldType = (ftCharacter, ftDate, ftNumeric, ftBoolean, ftCalculated);

type
  TFieldData = record
    Name:String;
    Length:Integer;
    Decimal:Integer;
    FieldType:TFieldType;
    Data:String;
    InputSequence:Integer;      //Zero if Calculated
    OutputSequence:Integer;     //Zero if not to be output
  end;

type
  TfrmMain = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    InFile: TextFile;
    OutFile: TextFile;
    ErrorOccured: Boolean;
    CSV:Boolean;
    FirstRun: Boolean;
    SchedulerSetup:Boolean;
    FieldData: Array[1..MAXFIELDS] of TFieldData;
    function GetData(TheData: String;Length,Decimal: Integer; var FieldOffset: Integer): String;
    procedure BuildOutData(var OutData:String;FieldData:String);
    procedure ReadWriteData;
    function DaysToMonths(InStr:String;Len,Decimal: Integer):String;
    procedure SetFieldDefs;
  public
    { Public declarations }
  end;


var
  frmMain: TfrmMain;

implementation

uses uDmData;

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin

  if opendialog1.Execute then
  begin
    edit1.Text := Opendialog1.FileName;
  end;


end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin

  if opendialog1.Execute then
  begin
    edit2.Text := Opendialog1.FileName;
  end;

end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin

  CSV := (RadioGroup1.ItemIndex = 0);

  ErrorOccured := False;

  try
    AssignFile(InFile,Edit1.Text);
    Reset(InFile);
  except
    dmData.FireEvent('F');
    ErrorOccured := True;
    MessageDlg('Error opening file '+Edit1.text,mtError,[mbOK],0);
  end;

  if ErrorOccured = False then
  begin

    try
      AssignFile(OutFile,Edit2.Text);
      ReWrite(OutFile);
    except
      dmData.FireEvent('F');
      ErrorOccured := True;
      MessageDlg('Error creating file '+Edit2.text,mtError,[mbOK],0);
    end;

  end;

  if ErrorOccured = False then
  begin

    try
      ReadWriteData;
    except
      dmData.FireEvent('F');
      ErrorOccured := True;
      MessageDlg('Error writing info to file '+Edit2.text,mtError,[mbOK],0);
    end;

  end;

  CloseFile(InFile);
  CloseFile(OutFile);

  if ParamCount > 0 then
  begin

    if ErrorOccured = False then
      dmData.FireEvent('S');

  end
  else
  begin
    MessageDlg('Complete !',mtInformation,[mbOk],0);
  end;




end;

procedure TfrmMain.SetFieldDefs;
var
  FieldCount: Integer;
begin

  //for FieldCount := 1 to MAXFIELDS do
  //begin

  //end;
  FieldData[1].Name

end;

procedure TfrmMain.ReadWriteData;
var
  InData,OutData: String;
  FieldPos:Integer;
  RecCount:Integer;
  NewRC: Real;
begin


  RecCount := 0;

  while not eof(InFile) do
  begin
    ReadLn(InFile,InData);

    FieldPos := 1;
    Branch:=GetData(InData,3,0,FieldPos);
    Division:=GetData(InData,2,0,FieldPos);
    Style:=GetData(InData,6,0,FieldPos);
    Colour:=GetData(InData,3,0,FieldPos);
    Dimension:=GetData(InData,3,0,FieldPos);
    Size:=GetData(InData,3,0,FieldPos);
    Descr:=GetData(InData,20,0,FieldPos);
    ProductGroup:=GetData(InData,10,0,FieldPos);
    MajorGroup:=GetData(InData,10,0,FieldPos);
    Cost:=GetData(InData,6,2,FieldPos);
    Stock:=GetData(InData,7,0,FieldPos);
    InTRansit:=GetData(InData,7,0,FieldPos);
    Supplier:=GetData(InData,6,0,FieldPos);
    FreightLT:=GetData(InData,4,0,FieldPos);
    LT:=GetData(InData,4,0,FieldPos);
    UnitOfMeasure:=GetData(InData,1,0,FieldPos);
    Sell:=GetData(InData,6,2,FieldPos);
    Min:=GetData(InData,9,0,FieldPos);
    Multiple:=GetData(InData,7,0,FieldPos);
    RC:=GetData(InData,3,0,FieldPos);

    RC := DaysToMonths(RC,6,2);



    StkIndicator1:=GetData(InData,1,0,FieldPos);
    StkIndicator2:=GetData(InData,1,0,FieldPos);
    Owner1:=GetData(InData,3,0,FieldPos);
    Owner2:=GetData(InData,3,0,FieldPos);
    SupplyChain:=GetData(InData,3,0,FieldPos);
    Source:=GetData(InData,4,0,FieldPos);
    ForecastFlag:=GetData(InData,1,0,FieldPos);
    Factory:=GetData(InData,6,0,FieldPos);
    Section:=GetData(InData,3,0,FieldPos);
    WorkCentre:=GetData(InData,6,0,FieldPos);

    //Minutes:=GetData(InData,7,3,FieldPos);
    Minutes:=GetData(InData,4,3,FieldPos);
    Minutes :=  '1111.111';

    Planner:=GetData(InData,1,0,FieldPos);
    Pareto:=GetData(InData,1,0,FieldPos);
    MultiPack:=GetData(InData,3,0,FieldPos);

    ProdCode := Style+'_'+Colour+'_'+Size;

    if Trim(Division) = 'RR' then
      Division := 'JA ';

    if Trim(SupplyChain) = 'TH' then
      SupplyChain := 'GA ';

    StockingIndicator := 'N';

    if (Trim(StkIndicator1) = 'B') or (Trim(StkIndicator1) = 'S')
        or (Trim(StkIndicator1) = 'X') then
      StockingIndicator := 'Y';

    DivSupplyChain := Copy(Division,1,2) + SupplyChain;
    DivSource:= Copy(Division,1,2) + Source;
    DivOwner1:= Copy(Division,1,2) + Owner1;
    DivPareto:= Copy(Division,1,2) + Pareto;

    DivSupplyChainSource := Copy(Division,1,2) + SupplyChain + Source;
    SupplyChainSource := SupplyChain + Source;
    PlannerDiv := Planner + Copy(Division,1,2);
    ParetoPlanner := Pareto + Planner;
    ParetoSupplyChain := Pareto + SupplyChain;
    ParetoOwner1 := Pareto + Owner1;

    OutData := '';

    BuildOutData(OutData,Branch);
    BuildOutData(OutData,Division);
    BuildOutData(OutData,Style);
    BuildOutData(OutData,Colour);
    BuildOutData(OutData,Dimension);
    BuildOutData(OutData,Size);
    BuildOutData(OutData,Descr);
    BuildOutData(OutData,ProductGroup);
    BuildOutData(OutData,MajorGroup);
    BuildOutData(OutData,Cost);
    BuildOutData(OutData,Stock);
    BuildOutData(OutData,InTRansit);
    BuildOutData(OutData,Supplier);
    BuildOutData(OutData,FreightLT);
    BuildOutData(OutData,LT);
    BuildOutData(OutData,UnitOfMeasure);
    BuildOutData(OutData,Sell);
    //BuildOutData(OutData,Min);
    BuildOutData(OutData,Multiple);
    BuildOutData(OutData,Multiple);
    BuildOutData(OutData,RC);
    BuildOutData(OutData,StkIndicator1);
    BuildOutData(OutData,StkIndicator2);
    BuildOutData(OutData,Owner1);
    BuildOutData(OutData,Owner2);
    BuildOutData(OutData,SupplyChain);
    BuildOutData(OutData,Source);
    BuildOutData(OutData,ForecastFlag);
    BuildOutData(OutData,Factory);
    BuildOutData(OutData,Section);
    BuildOutData(OutData,WorkCentre);
    BuildOutData(OutData,Minutes);
    BuildOutData(OutData,Planner);
    BuildOutData(OutData,Pareto);
    BuildOutData(OutData,MultiPack);
    BuildOutData(OutData,ProdCode);
    BuildOutData(OutData,DivSupplyChain);
    BuildOutData(OutData,DivSource);
    BuildOutData(OutData,DivOwner1);
    BuildOutData(OutData,DivPareto);
    BuildOutData(OutData,DivSupplyCHainSource);
    BuildOutData(OutData,SupplyChainSource);
    BuildOutData(OutData,PlannerDiv);
    BuildOutData(OutData,ParetoPlanner);
    BuildOutData(OutData,ParetoSupplyChain);
    BuildOutData(OutData,ParetoOwner1);
    BuildOutData(OutData,Pareto);
    BuildOutData(OutData,Supplier);
    BuildOutData(OutData,StockingIndicator);

    WriteLn(OutFile,OutData);

    Inc(RecCount);

    if RecCount mod 100 = 0 then
    begin
      Statusbar1.Panels[1].Text := IntToStr(RecCount);
      frmMain.Refresh;
    end;

  end;

end;

function TfrmMain.GetData(TheData: String; Length, Decimal: Integer;
  var FieldOffset: Integer): String;
begin

Result := Copy(TheData,FieldOffset,Length);

if Decimal > 0 then
  REsult := Copy(Result,1,Length - Decimal) + '.' + RightStr(Result,Decimal);

FieldOffset := FieldOffSet + Length;

end;

procedure TfrmMain.BuildOutData(var OutData: String; FieldData: String);
begin

  if CSV then
  begin
    FieldData := Trim(FieldData);
    FieldData := AnsiReplaceStr(FieldData,'"',' ');
    FieldData := AnsiReplaceStr(FieldData,',',' ');

    If OutData <> '' then
      FieldData := ','+FieldData;

  end;

  OutData := OutData + FieldData;


end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstRun := True;

end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  ParamOffset:Integer;
begin

  if FirstRun then
  begin
    FirstRun := False;
    SchedulerSetup := False;

    if ParamCount > 0 then
    begin

      if UpperCase(ParamStr(1)) = '-Z' then
      begin
        SchedulerSetup := True ;
        ParamOffset := 2;
      end
      else
      begin
        ParamOffset := 0;
      end;

      Edit1.Text := ParamStr(ParamOffset+1);
      Edit2.Text := ParamStr(ParamOffset+2);

      if UpperCase(ParamStr(ParamOffset+3)) = 'CSV' then
        RadioGroup1.ItemIndex := 0
      else
        RadioGroup1.ItemIndex := 1;

      if UpperCase(ParamStr(1)) <> '-Z' then
      begin
        BitBtn1Click(Sender);
        Close;
      end;



    end;



  end;



end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
var
  CsvText:String;
begin

  if SchedulerSetup then
  begin
    if RadioGroup1.ItemIndex  = 0 then
      CsvText := '"CSV"'
    else
      CsvText := '"FlatFile"';

    Clipboard.AsText := 'Optimiza:"' + Edit1.text + '" "'+Edit2.Text+'" '+CsvText ;
  end;

  Close;

end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
Close;

end;

function TfrmMain.DaysToMonths(InStr: String; Len,
  Decimal: Integer): String;
var
  NumVal: Real;
begin

  NumVal := StrToInt(InStr) / 30;

  Result := Format('%'+IntToStr(Len)+'.'+IntToStr(Decimal)+'f',[NumVal]);

  Result := Result;
end;


end.
