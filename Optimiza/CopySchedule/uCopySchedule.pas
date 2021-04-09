unit uCopySchedule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type

  ScheduleRec = record
    Description: String;
    ExecutablePath: String;
    Executable: String;
    TaskActive: String;
    WaitToFinish: String;
    ExecutableParams: String;
  end;

type
  TfrmCopySchedule = class(TForm)
    Panel2: TPanel;
    cbFromSchedule: TComboBox;
    StatusBar1: TStatusBar;
    lbFromTasks: TListBox;
    cbToSchedule: TComboBox;
    lbToTasks: TListBox;
    btnCopy: TButton;
    GroupBox1: TGroupBox;
    rbBefore: TRadioButton;
    rbAfter: TRadioButton;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbFromScheduleChange(Sender: TObject);
    procedure cbToScheduleChange(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Records: array of ScheduleRec;
  end;

var
  frmCopySchedule: TfrmCopySchedule;
  FirstLoad : Boolean;
  ToCopy : Integer;
implementation

uses uDmCopySchedule, uDmOptimiza;

{$R *.DFM}

procedure TfrmCopySchedule.FormCreate(Sender: TObject);
begin
   FirstLoad := True;

end;

procedure TfrmCopySchedule.FormActivate(Sender: TObject);
begin
   If firstLoad Then
   Begin
     FirstLoad := False;
     StatusBar1.Panels[0].Text := dmCopySchedule.dbOptimiza.DatabaseName;
     cbFromSchedule.Items.AddStrings(dmCopySchedule.LoadScheduleList);
     cbFromSchedule.ItemIndex := 0;
     cbFromScheduleChange(Sender);
     cbToSchedule.Items.AddStrings(dmCopySchedule.LoadScheduleList);
     cbToSchedule.ItemIndex := 0;
     cbToScheduleChange(Sender);
   end;

end;

procedure TfrmCopySchedule.cbFromScheduleChange(Sender: TObject);
begin
  lbFromTasks.Items.clear;
  lbFromTasks.Items.AddStrings(dmCopySchedule.LoadScheduleTasks(dmCopySchedule.listSchedulerSetNo.Strings[cbFromSchedule.Items.Indexof(cbFromSchedule.Text)]));
end;

procedure TfrmCopySchedule.cbToScheduleChange(Sender: TObject);
begin
  lbToTasks.Items.clear;
  lbToTasks.Items.AddStrings(dmCopySchedule.LoadScheduleTasks(dmCopySchedule.listSchedulerSetNo.Strings[cbToSchedule.Items.Indexof(cbToSchedule.Text)]));
end;

procedure TfrmCopySchedule.btnCopyClick(Sender: TObject);
var
  i, posn: Integer;
begin
  ToCopy:=0;
  for i := 0 to lbFromTasks.Items.Count-1 do
  begin
    if lbFromTasks.Selected[i] then
    begin
      inc(ToCopy);
      setLength(Records,ToCopy);
      Records[ToCopy-1] := dmCopySchedule.LoadScheduleTask(dmCopySchedule.listSchedulerSetNo.Strings[cbFromSchedule.Items.Indexof(cbFromSchedule.Text)], intToStr(i+1))
    end;
  end;
  if (ToCopy > 0) then
  begin
    posn := 0;
    for i := 0 to lbToTasks.Items.Count-1 do
    begin
      if lbToTasks.Selected[i] then
      begin
        posn := I + 1;
        break;
      end;
    end;
    if (posn > 0) then
    begin
      if  rbBefore.Checked  then
      begin
        // add selected tasks Before
        //dmCopySchedule.qryTaskMove.Active:= true;
        //dmCopySchedule.qryTaskMove.Close;
        dmCopySchedule.qryTaskMove.Params.ParamByName('SchedulerSetNo').AsString := dmCopySchedule.listSchedulerSetNo.Strings[cbToSchedule.Items.Indexof(cbToSchedule.Text)];
        dmCopySchedule.qryTaskMove.Params.ParamByName('ScheduleSequenceNo').AsString := IntToStr(posn);
        dmCopySchedule.qryTaskMove.Params.ParamByName('TOCOPY').AsString := IntToStr(ToCopy);
        dmCopySchedule.qryTaskMove.ExecSQL;
      end
      else
      begin
        // add selected tasks after
        //dmCopySchedule.qryTaskMove.Active:= true;
        //dmCopySchedule.qryTaskMove.Close;
        dmCopySchedule.qryTaskMove.Params.ParamByName('SchedulerSetNo').AsString := dmCopySchedule.listSchedulerSetNo.Strings[cbToSchedule.Items.Indexof(cbToSchedule.Text)];
        dmCopySchedule.qryTaskMove.Params.ParamByName('ScheduleSequenceNo').AsString := IntToStr(posn+1);
        dmCopySchedule.qryTaskMove.Params.ParamByName('TOCOPY').AsString := IntToStr(ToCopy);
        dmCopySchedule.qryTaskMove.ExecSQL;
        posn := posn + 1;
      end;
      for i := 0 to TOCOPY - 1 do
      begin
        // now copy tasks into schedule
        dmCopySchedule.qryTaskInsert.Params.ParamByName('SchedulerSetNo').AsString := dmCopySchedule.listSchedulerSetNo.Strings[cbToSchedule.Items.Indexof(cbToSchedule.Text)];
        dmCopySchedule.qryTaskInsert.Params.ParamByName('ScheduleSequenceNo').AsString := IntToStr(posn+i);
        dmCopySchedule.qryTaskInsert.Params.ParamByName('Description').AsString := Records[i].Description;
        dmCopySchedule.qryTaskInsert.Params.ParamByName('ExecutablePath').AsString := Records[i].ExecutablePath;
        dmCopySchedule.qryTaskInsert.Params.ParamByName('Executable').AsString := Records[i].Executable;
        dmCopySchedule.qryTaskInsert.Params.ParamByName('TaskActive').AsString := Records[i].TaskActive;
        dmCopySchedule.qryTaskInsert.Params.ParamByName('WaitToFinish').AsString := Records[i].WaitToFinish;
        dmCopySchedule.qryTaskInsert.Params.ParamByName('ExecutableParams').AsString := Records[i].ExecutableParams;
        dmCopySchedule.qryTaskInsert.ExecSQL;
      end;
      cbToScheduleChange(Sender);
    end;
  end;
end;

procedure TfrmCopySchedule.Button1Click(Sender: TObject);
var
  i1,i2,sz: integer;
  xx,xx2, f1,f2: double;
  StartTime:TDateTime;
begin
  sz:=30000;
  StartTime := Now;
  for i1:=0 to sz do
  begin
    for i2:=1 to sz do
    begin
      f1 := i1;
      f2 := i2;
      xx := f1 /f2;
    end;
  end;
  xx2:=xx;
  label1.Caption := Format('Elapsed Time: %.2f seconds %f', [(Now - StartTime) * 86400, xx2]); 

  StartTime := Now;
  for i1:=0 to sz do
  begin
    for i2:=0 to sz do
    begin
      f1 := i1;
      f2 := i2;
      if f2 <> 0 then
      begin
        xx := f1 /f2;
      end
      else
      begin
        xx := 0;
      end;
    end;
  end;
  xx2:=xx;
  label2.Caption := Format('IF Elapsed Time: %.2f seconds %f', [(Now - StartTime) * 86400, xx2]);

  StartTime := Now;
  for i1:=0 to sz do
  begin
    for i2:=0 to sz do
    begin
      try
        f1 := i1;
        f2 := i2;
        xx := f1 / f2;
      except
        on e: exception do begin
          xx := 0;
        end;
      end;
    end;
  end;
  xx2:=xx;
  label3.Caption := Format('TRY Elapsed Time: %.2f seconds %f', [(Now - StartTime) * 86400, xx2]);
end;

end.
