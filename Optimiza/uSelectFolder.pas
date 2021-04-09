unit uSelectFolder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ShellCtrls, ExtCtrls, StrUtils,
  Grids, Outline, DirOutln, Vcl.FileCtrl;

type
  TfrmFolder = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DirectoryOutline1: TDirectoryOutline;
    DriveComboBox1: TDriveComboBox;
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure DirectoryOutline1Change(Sender: TObject);
  private
    { Private declarations }
    FFolderPath: String;
    function GetFolderPath: String;
    procedure SetFolderPath(const Value: String);
  public
    { Public declarations }

    property FolderPath: String read GetFolderPath write SetFolderPath;
  end;

var
  frmFolder: TfrmFolder;

implementation

{$R *.dfm}
{$UNDEF EnableMemoryLeakReporting}

procedure TfrmFolder.DirectoryOutline1Change(Sender: TObject);
begin
     FFolderPath := DirectoryOutline1.Directory;
end;

procedure TfrmFolder.DriveComboBox1Change(Sender: TObject);
begin
  DirectoryOutline1.Drive := DriveComboBox1.Drive;
end;

function TfrmFolder.GetFolderPath: String;
begin
  //Result := ShellTreeView1.Path;
  Result := FFolderPath;
end;

procedure TfrmFolder.SetFolderPath(const Value: String);
begin

end;

procedure TfrmFolder.ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  FFolderPath := Node.Text;

end;

end.
