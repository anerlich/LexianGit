unit uEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtEdit;

type
  TfrmEdit = class(TForm)
    ExtEdit1: TExtEdit;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEdit: TfrmEdit;

implementation

{$R *.DFM}

procedure TfrmEdit.FormShow(Sender: TObject);
begin
ExtEdit1.SetFocus;
end;

end.
