unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  TfrmMain = class(TForm)
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    BitBtn2: TBitBtn;
    edtCompany: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtCompanyPrefix: TEdit;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses udmData, uFolders, uBackup;

{$R *.dfm}

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  if not dmData.trnOptimiza.InTransaction then
  dmData.trnOptimiza.StartTransaction;

  edtCompany.text := dmData.GetConfigAsString(239);
  edtCompanyPrefix.Text := edtCompany.Text;
  
end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
  frmFolders.edtCompany.Text := edtCompanyPrefix.Text;
  frmFolders.ShowModal;
end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
begin
  frmBackup.edtBackupPath.text := frmFolders.edtBackup.Text;
  frmBackup.edtDBPath.text := frmFolders.edtDb.Text;
  frmBackup.edtSoftware.Text := frmFolders.edtSoftware.text;
  frmBackup.showModal;
end;

end.
