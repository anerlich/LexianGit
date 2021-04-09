unit uImportLTAnalysis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses uDMLtAnal;

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
begin
  statusbar1.Panels[0].Text := dmLTAnal.dbOptimiza.DatabaseName;

  
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  dbNavigator1.Hide;
  dbgrid1.Hide;

  dmLtAnal.UpdateLTAnalysis;

  MessageDlg('Complete',mtInformation,[mbOK],0);
  dbNavigator1.Visible := True;
  dbgrid1.Visible := True;
end;

end.
