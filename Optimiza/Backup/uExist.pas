unit uExist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TfrmExist = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    edtOld: TEdit;
    edtNew: TEdit;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExist: TfrmExist;

implementation

{$R *.DFM}

end.
