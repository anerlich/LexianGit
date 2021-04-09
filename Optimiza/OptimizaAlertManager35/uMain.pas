unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ImgList, ToolWin, Menus, Grids,
  DBGrids, DBCtrls,IniFiles, CheckLst,StrUtils;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ListBox1: TListBox;
    Button2: TButton;
    Label3: TLabel;
    memDrive: TMemo;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Label4: TLabel;
    memShedule: TMemo;
    lblSchedule: TLabel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    edtInterval: TEdit;
    Label6: TLabel;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshDrive;
    procedure RefreshSched;
    procedure RefreshInterval;
  public
    { Public declarations }
    IniFile: TIniFile;
  end;

var
  frmMain: TfrmMain;

implementation

uses uDmdata, uEditSchedule, uEditDrive, uInterval;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  IniFileName: String;
begin
  StatusBar1.Panels[0].Text := dmData.dbOptimiza.DatabaseName;
  IniFileName := ParamStr(0);
  IniFileName := Copy(IniFileName,1,Length(IniFileName)-3) + 'ini';
  IniFile := TIniFile.Create(IniFileName);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  SchedName: String;
begin
  with frmEditSchedule do
  begin
    SchedName := 'SCHEDULE-' + dmData.srcSchedule.DataSet.fieldbyName('Description').AsString;

    Edit1.Text := SchedName;

    edtStart.Text := IniFile.ReadString(SchedName,'StartNoLaterThan','');
    edtEnd.Text :=IniFile.ReadString(SchedName,'EndNoLaterThan','');

    if ShowModal = mrOK then
    begin
      IniFile.WriteString(SchedName,'StartNoLaterThan',edtStart.text);
      IniFile.WriteString(SchedName,'EndNoLaterThan',edtEnd.text);
      RefreshSched;
    end;
  end;

end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  IniFile.UpdateFile;
  Hide;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  LstCount: Integer;
  SelDrive, SelMB: String;
begin
  for LstCount := 0 to listBox1.Count - 1 do
  begin

    if listbox1.Selected[LstCount] then
    begin
      SelDrive := listBox1.Items.Strings[LstCount];
      SelDrive := AnsiReplaceStr(SelDrive,' ','');
      SelDrive := AnsiReplaceStr(SelDrive,':','');
      break;
    end;

  end;

  if SelDrive = '' then
    MessageDlg('Please Select a Drive to Edit',mtWarning,[mbOK],0)
  else
  begin

    with frmEditDrive do
    begin
      SelMB := '';
      Edit1.Text := SelDrive;
      edtMB.Text := Trim(IniFile.ReadString('DiskSpace',SelDrive,''));

      if ShowModal = mrOK then
      begin

        if edtMB.Text <> '' then
          IniFile.WriteString('DiskSpace',SelDrive,Trim(edtMB.text));

        RefreshDrive;
      end;
    end;

  end;

end;

procedure TfrmMain.RefreshDrive;
begin
  MemDrive.Clear;
  IniFile.ReadSectionValues('DiskSpace', MemDrive.Lines);

end;

procedure TfrmMain.RefreshSched;
var
  Sched: String;
begin
  memShedule.clear;

  lblSchedule.Caption := 'SCHEDULE-'+dmData.srcSchedule.DataSet.fieldbyName('Description').AsString;
  IniFile.ReadSectionValues(lblSchedule.Caption, memShedule.Lines);
end;

procedure TfrmMain.DBGrid1CellClick(Column: TColumn);
begin
  RefreshSched;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin

  with frmInterval do
  begin
    edtInterval.Text := IniFile.ReadString('TimeInterval','Time','');

    if ShowModal = mrOK then
    begin
      IniFile.WriteString('TimeInterval','Time',Trim(edtInterval.text));

    end;
  end;

  RefreshInterval;

end;

procedure TfrmMain.RefreshInterval;
begin
  edtInterval.Text := IniFile.ReadString('TimeInterval','Time','');

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  RefreshDrive;
  RefreshSched;
  RefreshInterval;
end;

end.
