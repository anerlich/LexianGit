unit uConvertSys3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, ComCtrls, CheckLst, Gauges;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    CheckListBox1: TCheckListBox;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Button3: TButton;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    CheckListBox2: TCheckListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Gauge1: TGauge;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    procedure BuildList;
  public
    { Public declarations }
    procedure SetMaxRecord(MaxValue: Integer);
    procedure IncrementCount(Increment: Integer);
    procedure SetFilePath(Path: String);
  end;

var
  Form1: TForm1;
  DirCode: Boolean;

implementation

uses uDMConvertSys3;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  nCnt: Integer;
begin
  DirCode := True;
  Panel2.Caption := '';
  Gauge1.Visible := False;

  PageControl1.ActivePage := TabSheet1;

  For nCnt := 0 to CheckListBox1.Items.Count -1 do begin
        CheckListBox1.Checked[nCnt] := True;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DirCode := True;
  dmOptimiza1.OpenLocationList('DIRCDE');
  BuildList;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  DirCode := False;
  dmOptimiza1.OpenLocationList('ORG');
  BuildList;
end;

procedure TForm1.BuildList;
var
  nCnt: Integer;
begin

  with CheckListBox2 do begin
    Items := dmOptimiza1.GetLocationList;

    For nCnt := 0 to (Items.Count - 1) do
      Checked[nCnt] := True;

  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
Var
  UpdateStockOut, UpdateFrozen, UpdateManual: Boolean;
begin
  UpdateStockOut := CheckListBox1.Checked[0];
  UpdateFrozen := CheckListBox1.Checked[1];
  UpdateManual := CheckListBox1.Checked[2];

  //Only update if one is selected
  If UpdateStockout or UpdateFrozen then begin
    dmOptimiza1.UpdateItem(CheckListBox2,UpdateStockOut,UpdateFrozen, UpdateManual);
    Gauge1.Visible := False;
    Panel2.Caption := '';
    MessageDlg('Complete',mtInformation,[mbOK],0);

    //Do this to reestablish link between sys3 and Optimiza
    If DirCode then
        dmOptimiza1.OpenLocationList('DIRCDE')

    Else
        dmOptimiza1.OpenLocationList('ORG');


  end
  else
    MessageDlg('Please select one or more of the update options',
                mtWarning, [mbOK], 0);

end;

procedure TForm1.SetMaxRecord(MaxValue: Integer);
begin
Gauge1.Visible := True;
Gauge1.MaxValue := MaxValue;
Gauge1.Progress := 0;
end;

procedure TForm1.IncrementCount(Increment: Integer);
begin
Gauge1.Progress := Increment;
end;

procedure TForm1.SetFilePath(Path: String);
begin
Panel2.Caption := '  '+Path;
end;


procedure TForm1.Button4Click(Sender: TObject);
var
  nCnt: Integer;
begin

  with CheckListBox2 do begin
    For nCnt := 0 to (Items.Count - 1) do
      Checked[nCnt] := False;

  end;


end;

end.
