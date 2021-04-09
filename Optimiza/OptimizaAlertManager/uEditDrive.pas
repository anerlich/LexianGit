unit uEditDrive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask;

type
  TfrmEditDrive = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    edtMB: TMaskEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    BitBtn3: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FormResult: Integer;
  end;

var
  frmEditDrive: TfrmEditDrive;

implementation

{$R *.dfm}

procedure TfrmEditDrive.BitBtn3Click(Sender: TObject);
begin
  FormResult := mrYes;
  Close;
end;

procedure TfrmEditDrive.FormShow(Sender: TObject);
begin
 FormResult := mrNone;
end;

end.
