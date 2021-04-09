unit uNewHost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmNewHost = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FIPAddress:String;
    FHostName:String;
  end;

var
  frmNewHost: TfrmNewHost;

implementation

{$R *.dfm}

procedure TfrmNewHost.BitBtn2Click(Sender: TObject);
begin
  FIpAddress := '';
  FHostName:='';
  Close;
end;

procedure TfrmNewHost.FormCreate(Sender: TObject);
begin
  FIpAddress := '';
  FHostName:='';
end;

procedure TfrmNewHost.BitBtn1Click(Sender: TObject);
begin
  FIpAddress := Edit1.Text;
  FHostName:=Edit2.Text;
  Close;
end;

end.
