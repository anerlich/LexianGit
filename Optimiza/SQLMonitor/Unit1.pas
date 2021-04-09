unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, IBSQLMonitor;

type
  TfrmSQLMonitor = class(TForm)
    IBSQLMonitor1: TIBSQLMonitor;
    Memo1: TMemo;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure IBSQLMonitor1SQL(EventText: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSQLMonitor: TfrmSQLMonitor;

implementation

{$R *.DFM}

procedure TfrmSQLMonitor.BitBtn2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TfrmSQLMonitor.IBSQLMonitor1SQL(EventText: String);
begin
  Memo1.Lines.Add(EventText);
end;

end.
