unit uFolders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, StrUtils,Buttons;

const
  db_path = 'Database';
  data_path = 'Data';
  prog_path = 'Custom Programs';
  export_path = 'Export';
  reports_path = 'Custom Reports';
  log_path = 'Log Files';
  backup_path = 'Backup';
  software_path = 'Software';

type
  TfrmFolders = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtPrimary: TEdit;
    Label1: TLabel;
    Button1: TButton;
    edtCompany: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtDb: TEdit;
    edtExport: TEdit;
    edtProg: TEdit;
    edtData: TEdit;
    edtReport: TEdit;
    edtBackup: TEdit;
    edtLog: TEdit;
    Label10: TLabel;
    edtSoftware: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure edtPrimaryChange(Sender: TObject);
    procedure edtCompanyChange(Sender: TObject);
  private
    { Private declarations }
    procedure ChangePaths;
  public
    { Public declarations }
  end;

var
  frmFolders: TfrmFolders;

implementation

uses uSelectFolder;

{$R *.dfm}

procedure TfrmFolders.Button1Click(Sender: TObject);
begin

  if frmSelectFolder.showmodal = mrOK then
  begin
    edtPrimary.Text := frmSelectFolder.ShellTreeView1.Path;
    if RightStr(edtPrimary.Text,1) = '\' then
      edtPrimary.Text := Copy(edtPrimary.Text,1,length(edtPrimary.Text)-1);
  end;

end;

procedure TfrmFolders.ChangePaths;
begin
   edtDb.Text := edtPrimary.Text + '\'+ edtCompany.Text + '\' + db_path;
   edtExport.Text := edtPrimary.Text + '\'+ edtCompany.Text + '\' + export_path;
   edtProg.Text := edtPrimary.Text + '\'+ edtCompany.Text + '\' + prog_path;
   edtData.Text := edtPrimary.Text + '\'+ edtCompany.Text + '\' + data_path;
   edtReport.Text := edtPrimary.Text + '\'+ edtCompany.Text + '\' + reports_path;
   edtBackup.Text := edtPrimary.Text + '\'+ edtCompany.Text + '\' + backup_path;
   edtLog.Text := edtPrimary.Text + '\'+ edtCompany.Text + '\' + log_path;
   edtSoftware.Text := edtPrimary.Text + '\'+ edtCompany.Text + '\' + software_path;
end;

procedure TfrmFolders.edtPrimaryChange(Sender: TObject);
begin
  ChangePaths;
end;

procedure TfrmFolders.edtCompanyChange(Sender: TObject);
begin
  ChangePaths;

end;

end.
