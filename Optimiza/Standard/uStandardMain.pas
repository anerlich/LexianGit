unit uStandardMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ExtCtrls, ImgList;

type
  TfrmStandardMain = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Tools1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Panel1: TPanel;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
    FirstShow: Boolean;
  public
    { Public declarations }

  end;

var
  frmStandardMain: TfrmStandardMain;

implementation

uses uDmOptimiza, uAbout;

{$R *.DFM}

procedure TfrmStandardMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmStandardMain.FormShow(Sender: TObject);
begin

  if FirstShow then
  begin
    StatusBar1.Panels[1].Text := dmOptimiza.dbOptimiza.DatabaseName;
    FirstShow := True;
  end;

end;

procedure TfrmStandardMain.About1Click(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmStandardMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

end.
