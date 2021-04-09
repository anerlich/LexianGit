unit uSQLFilePath;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Dialogs;

type
  TfrmSQLFilePath = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSQLFilePath: TfrmSQLFilePath;

implementation

{$R *.DFM}

procedure TfrmSQLFilePath.Button1Click(Sender: TObject);
begin
  With OpenDialog1 do begin
    Title := 'Select SQL File';
    FileName := Edit1.Text;
    DefaultExt := '*.sql';

    if Execute then 
      Edit1.text := FileName;

  end;

end;

procedure TfrmSQLFilePath.Edit1Change(Sender: TObject);
begin
  Edit1.Hint := Edit1.Text;
end;

end.
