unit uFolderSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, Buttons;

type
  TfrmFolder = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Edit1: TEdit;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFolder: TfrmFolder;

implementation

{$R *.DFM}

end.
