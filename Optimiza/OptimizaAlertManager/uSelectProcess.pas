unit uSelectProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Buttons, ExtCtrls;

type
  TfrmSelectProcess = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBLookupComboBox1: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    FDescription:String;
  end;

var
  frmSelectProcess: TfrmSelectProcess;

implementation

uses uDmdata;

{$R *.dfm}

procedure TfrmSelectProcess.FormShow(Sender: TObject);
begin
dmData.qrySchedule.Active := True;
DBLookupComboBox1.Enabled :=True;
dbnavigator1.BtnClick(nbLast);
DBLookupComboBox1.KeyValue := FDescription;
//FDescription := '';
end;

procedure TfrmSelectProcess.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
FDescription := dmData.srcSchedule.DataSet.fieldbyname('Description').AsString;
//dmData.qrySchedule.Active := False;
end;

end.
