unit uSaleAndFC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Buttons, ComCtrls, Grids, DBGrids;

type
  TfrmCopySaleAndFC = class(TForm)
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCopySaleAndFC: TfrmCopySaleAndFC;
  FirstCreate: Boolean;

implementation

uses uDmSaleAndFC;

{$R *.DFM}

procedure TfrmCopySaleAndFC.FormCreate(Sender: TObject);
begin
  FirstCreate := True;
end;

procedure TfrmCopySaleAndFC.FormShow(Sender: TObject);
begin

  if FirstCreate then
  begin
    statusBar1.Panels[1].Text := dmCopySaleAndFC.dbOptimiza.DatabaseName;
    FirstCreate := False;
  end;

end;

procedure TfrmCopySaleAndFC.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCopySaleAndFC.BitBtn1Click(Sender: TObject);
begin

  if dmCopySaleAndFC.SameLocations then
  begin
    MessageDlg('The From and To Locations must be different',mtError,[mbOK],0);
  end
  else
  begin

    if MessageDlg('Add Sales and Forecasts from'#10+
                   DBLookupComboBox1.text+#10+'    to'#10+
                   DBLookupComboBox2.text,mtConfirmation,[mbOK,mbCancel],0) = mrOk then

      dmCopySaleAndFC.UpdateItems;
      Close;
  end;


end;

procedure TfrmCopySaleAndFC.Button1Click(Sender: TObject);
begin
dmCopySaleAndFC.OpenItems;
end;

procedure TfrmCopySaleAndFC.BitBtn3Click(Sender: TObject);
begin
 dmCopySaleAndFC.InsertTheItem(1,1);
end;

end.
