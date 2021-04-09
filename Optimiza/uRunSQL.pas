unit uRunSQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    Edit1: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FirstLoad: Boolean;

implementation

uses udmRunSql, uSQLFilePath, uMonitor;

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
begin
  If FirstLoad Then begin
    StatusBar1.Panels[0].Text := dmOptimiza2.dbOptimiza.DatabaseName;
    Form1.Refresh;

    If frmSQLFilePath.ShowModal = mrOK then begin
       Edit1.Text := frmSQLFilePath.Edit1.Text;
       memo1.Lines.LoadFromFile(Edit1.text);
    end;

    FirstLoad := False;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FirstLoad := True;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  dmOptimiza2.UpdateIt(memo1.lines);

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//  if dmOptimiza2.IBTransaction1.InTransaction then
    dmOptimiza2.IBTransaction1.StartTransaction;

  dmOptimiza2.IBSQL1.ExecQuery;
end;

end.
