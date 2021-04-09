unit uStatus;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TfrmStatus = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
     LogFile : TextFile;
  public
    { Public declarations }
  end;

var
  frmStatus: TfrmStatus;

implementation

{$R *.DFM}

procedure TfrmStatus.BitBtn1Click(Sender: TObject);
begin
  ListBox1.Items.Clear;
  Close;
end;

end.
