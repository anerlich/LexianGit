unit uShowMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmShowMessage = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShowMessage: TfrmShowMessage;

implementation

{$R *.dfm}

procedure TfrmShowMessage.Timer1Timer(Sender: TObject);
begin
  

  Close;
end;

procedure TfrmShowMessage.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TfrmShowMessage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled := False;
end;

end.
