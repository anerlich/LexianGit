unit uSelectFolder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ShellCtrls, ExtCtrls;

type
  TfrmSelectFolder = class(TForm)
    ShellTreeView1: TShellTreeView;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelectFolder: TfrmSelectFolder;

implementation

{$R *.dfm}

end.
