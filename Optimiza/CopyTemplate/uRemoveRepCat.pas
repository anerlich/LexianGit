unit uRemoveRepCat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Grids, DBGrids;

type
  TfrmRemoveRepCat = class(TForm)
    BitBtn1: TBitBtn;
    edtRepCatType: TEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    edtRepcatNo: TEdit;
    DBGrid1: TDBGrid;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure DBLookupComboBox2CloseUp(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
    FirstShow:Boolean;
    procedure Refreshdata;
  public
    { Public declarations }
  end;

var
  frmRemoveRepCat: TfrmRemoveRepCat;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmRemoveRepCat.FormActivate(Sender: TObject);

begin
  FirstShow := True;
  RefreshData;

end;

procedure TfrmRemoveRepCat.FormCreate(Sender: TObject);
begin
  FirstShow := False;

end;

procedure TfrmRemoveRepCat.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  dmData.qryRepCat.Close;
  dmData.qryRepCats.Close;
end;

procedure TfrmRemoveRepCat.DBLookupComboBox1CloseUp(Sender: TObject);
begin
edtRepCatType.Text := dmData.qryRepCats.fieldByName('ReportCategoryType').AsString;
end;

procedure TfrmRemoveRepCat.DBLookupComboBox2CloseUp(Sender: TObject);
begin
  edtRepcatNo.Text := dmData.qryRepCat.fieldByName('ReportCategoryNo').AsString;
end;

procedure TfrmRemoveRepCat.BitBtn2Click(Sender: TObject);
var
  RepCatType,RepCatNo1,RepCatNo2:Integer;
  MsgStr:String;
  Save_Cursor:TCursor;
begin
  if edtRepCatType.Text = '' then
    MessageDlg('Pls select Report category',mtError,[mbOK],0)
  else
  begin

    MsgStr := dmData.qryRepCats.fieldByName('Description').AsString;


    if edtRepCatNo.Text = '' then
    begin
      RepCatNo1 := 0;
      RepCatNo2 := 99999999;
      MsgStr := 'About to remove ALL report category codes for <'+Msgstr+'>';
    end
    else
    begin
      RepCatNo1 := StrToInt(edtRepCatNo.Text);
      RepCatNo2 := StrToInt(edtRepCatNo.Text);
      MsgStr := 'About to remove report category <' + dmData.qryRepCat.fieldByName('Description').AsString +
                 '> for <'+Msgstr+'>';
    end;

    RepCatType := StrToInt(edtRepCatType.Text);

    MsgStr := MsgStr + #10 + ' from all templates. Continue ?';

    if MessageDlg(MsgStr,mtConfirmation,[MbYes,MbNo],0) = mrYes then
    begin
      Save_Cursor := Screen.Cursor;

      Screen.Cursor := crHourGlass;    { Show hourglass cursor }

      try
       dmData.DelRepCat(RepCatType,RepCatNo1,RepCatNo2);
      finally
        Screen.Cursor := Save_Cursor;  { Always restore to normal }
      end;

      MessageDlg('Done!',mtConfirmation,[mbOK],0);
      RefreshData;

    end;

  end;

end;

procedure TfrmRemoveRepCat.DBGrid1CellClick(Column: TColumn);
begin
  edtRepcatNo.Text := dmData.qryRepCat.fieldByName('ReportCategoryNo').AsString;
end;

procedure TfrmRemoveRepCat.Refreshdata;
var
  CCount:Integer;
begin
  dmData.qryRepCat.Close;
  dmData.qryRepCats.Close;
  dmData.qryRepCats.Open;


  for CCount := 1 to 8 do
    dmData.qryRepCats.next;

  dmData.qryRepCats.First;
  DBLookupComboBox1.KeyValue := dmData.qryRepCats.fieldByName('ReportCategoryType').AsInteger;
  edtRepCatType.Text := dmData.qryRepCats.fieldByName('ReportCategoryType').AsString;

  dmData.qryRepCat.Open;

  edtRepcatNo.Text := '';

end;

end.
