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
    lblSchedule: TLabel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    edtInterval: TEdit;
    Label6: TLabel;
    Button3: TButton;
    edtEventLog: TEdit;
    Label7: TLabel;
    Label4: TLabel;
    Button1: TButton;
    memDaily: TMemo;
    Label2: TLabel;
    memMonthly: TMemo;
    GroupBox4: TGroupBox;
    edtPath: TEdit;
    Button5: TButton;
    GroupBox5: TGroupBox;
    Button8: TButton;
    memEmail: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshDrive;
    procedure RefreshInterval;
    procedure RefreshSched;
    procedure RefreshPath;
    procedure RefreshEmail;
    procedure UpdateSchedule(SchedType: String);
  public
    { Public declarations }
    IniFile: TIniFile;
  end;

var
  frmMain: TfrmMain;

implementation

uses uDmdata, uEditSchedule, uEditDrive, uInterval, uSelectFolder, uEmail;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  IniFileName: String;
begin
  StatusBar1.Panels[0].Text := dmData.dbOptimiza.DatabaseName;
  IniFileName  := StringReplace(ParamStr(0), 'OptimizaAlertManager.exe', 'OptimizaAlertService.ini',
                           [rfIgnoreCase]);

  //IniFileName := Copy(IniFileName,1,Length(IniFileName)-3) + 'ini';
  IniFile := TIniFile.Create(IniFileName);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  SchedName: String;
begin
  UpdateSchedule('Daily');
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  IniFile.UpdateFile;
  Close;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  LstCount: Integer;
  SelDrive, SelMB: String;
  TheResult: Integer;
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
      TheResult := ShowModal;

      if TheREsult = mrOK then
      begin

        if edtMB.Text <> '' then
          IniFile.WriteString('DiskSpace',SelDrive,Trim(edtMB.text));

        RefreshDrive;
      end;

      if FormResult = mrYes then
      begin

        IniFile.DeleteKey('DiskSpace',SelDrive);

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

procedure TfrmMain.DBGrid1CellClick(Column: TColumn);
begin
  RefreshSched;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin

  with frmInterval do
  begin
    edtInterval.Text := IniFile.ReadString('TimeInterval','Time','');
    chkEventLog.Checked := IniFile.ReadString('EventLog','Write','')='Yes';

    if ShowModal = mrOK then
    begin
      IniFile.WriteString('TimeInterval','Time',Trim(edtInterval.text));

      if ChkEventLog.Checked then
        IniFile.WriteString('EventLog','Write','Yes')
      else
        IniFile.WriteString('EventLog','Write','No');

    end;

  end;

  RefreshInterval;

end;

procedure TfrmMain.RefreshInterval;
begin
  edtInterval.Text := IniFile.ReadString('TimeInterval','Time','');
  edtEventLog.Text := IniFile.ReadString('EventLog','Write','');
end;

procedure TfrmMain.RefreshSched;
begin
  memDaily.clear;
  IniFile.ReadSectionValues('Daily', MemDaily.Lines);
  memMonthly.clear;
  IniFile.ReadSectionValues('Monthly', MemMonthly.Lines);

end;

procedure TfrmMain.Button8Click(Sender: TObject);
begin

  if frmSelectFolder.showmodal = mrOK then
  begin
    edtPath.Text := frmSelectFolder.ShellTreeView1.SelectedFolder.PathName;
    IniFile.WriteString('Paths','LogFiles',edtPath.Text);
  end;

end;

procedure TfrmMain.RefreshPath;
begin
  edtPath.Text := IniFile.ReadString('Paths','LogFiles','');
end;

procedure TfrmMain.Button9Click(Sender: TObject);
begin
  with frmEmail do
  begin
    CheckBox1.Checked :=  UpperCase(IniFile.ReadString('Email','Send email when error occurs',''))='YES';
    Edit1.Text := IniFile.ReadString('Email','Path for Emailer.exe','');
    Edit2.Text := IniFile.ReadString('Email','Parameter File for Emailer.exe','');

    if ShowModal = mrOK then
    begin
      if CheckBox1.Checked then
        IniFile.WriteString('Email','Send email when error occurs','Yes')
      else
        IniFile.WriteString('Email','Send email when error occurs','No');

      IniFile.WriteString('Email','Path for Emailer.exe',Edit1.text);
      IniFile.WriteString('Email','Parameter File for Emailer.exe',Edit2.text);


      RefreshEmail;
    end;
  end;
end;

procedure TfrmMain.RefreshEmail;
begin
  MemEmail.Clear;
  IniFile.ReadSectionValues('Email', MemEmail.Lines);
end;

procedure TfrmMain.UpdateSchedule(SchedType: String);

begin

  with frmEditSchedule do
  begin
    Edit1.Text := IniFile.ReadString('Daily','Process','');
    Edit2.Text := IniFile.ReadString('Monthly','Process','');
    edtStart.Text := IniFile.ReadString('Daily','StartNoLaterThan','');
    edtDayEnd.Text :=IniFile.ReadString('Daily','EndNoLaterThan','');
    edtMthEnd.Text :=IniFile.ReadString('Monthly','EndNoLaterThan','');

    if ShowModal = mrOK then
    begin
      IniFile.WriteString('Daily','Process',Edit1.text);
      IniFile.WriteString('Monthly','Process',Edit2.text);
      IniFile.WriteString('Daily','StartNoLaterThan',edtStart.text);
      IniFile.WriteString('Monthly','StartNoLaterThan',edtStart.text);
      IniFile.WriteString('Daily','EndNoLaterThan',edtDayEnd.text);
      IniFile.WriteString('Monthly','EndNoLaterThan',edtMthEnd.text);
      RefreshSched;
    end;
  end;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  dmData.srcSchedule.DataSet.Open;
  RefreshDrive;
  RefreshSched;
  RefreshInterval;
  RefreshPath;
  RefreshEmail;
end;

end.
