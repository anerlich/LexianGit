unit uSelectFolder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ShellCtrls, ExtCtrls;

type
  TfrmFolder = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ShellTreeView1: TShellTreeView;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    FFolderPath:String;
    function GetFolderPath: String;
    procedure SetFolderPath(const Value: String);
  public
    { Public declarations }

    property FolderPath:String read GetFolderPath write SetFolderPath;
  end;

var
  frmFolder: TfrmFolder;

implementation

{$R *.dfm}

function TfrmFolder.GetFolderPath: String;
begin
  Result := ShellTreeView1.Path;
end;

procedure TfrmFolder.SetFolderPath(const Value: String);
begin

end;

procedure TfrmFolder.ShellTreeView1Change(Sender: TObject;
  Node: TTreeNode);
begin
  FFolderPath := Node.Text;
end;

end.
