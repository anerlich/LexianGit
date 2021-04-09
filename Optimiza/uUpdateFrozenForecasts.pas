unit uUpdateFrozenForecasts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, ComCtrls;

type
  TfrmFrzForecast = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    StatusBar1: TStatusBar;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFrzForecast: TfrmFrzForecast;

implementation

uses uDmFrozenForecasts;

{$R *.DFM}

procedure TfrmFrzForecast.FormActivate(Sender: TObject);
begin
  Statusbar1.Panels[0].Text := dmFrozenForecast.dbOptimiza.DatabaseName;
end;

procedure TfrmFrzForecast.Button1Click(Sender: TObject);
begin
  dmFrozenForecast.UpdateFrz;
end;

end.
