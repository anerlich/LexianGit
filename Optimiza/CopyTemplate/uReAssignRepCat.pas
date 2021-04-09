unit uReAssignRepCat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Grids, DBGrids;

type
  TfrmReAssignRepCat = class(TForm)
    BitBtn1: TBitBtn;
    edtRepCatTypeFM: TEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    edtRepcatNoFM: TEdit;
    DBGrid1: TDBGrid;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    Label7: TLabel;
    edtRepCatTypeTO: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    DBGrid2: TDBGrid;
    Label10: TLabel;
    edtRepcatNoTO: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure DBLookupComboBox2CloseUp(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid2CellClick(Column: TColumn);
  private
    { Private declarations }
    FirstShow:Boolean;
    procedure Refreshdata;
  public
    { Public declarations }
  end;

var
  frmReAssignRepCat: TfrmReAssignRepCat;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmReAssignRepCat.FormActivate(Sender: TObject);


begin
  FirstShow := True;
  RefreshData;

end;

procedure TfrmReAssignRepCat.FormCreate(Sender: TObject);
begin
  FirstShow := False;

end;

procedure TfrmReAssignRepCat.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  dmData.qryRepCat.Close;
  dmData.qryRepCats.Close;
  dmData.qryRepCat2.Close;
  dmData.qryRepCats2.Close;
end;

procedure TfrmReAssignRepCat.DBLookupComboBox1CloseUp(Sender: TObject);
begin
edtRepCatTypeFM.Text := dmData.qryRepCats.fieldByName('ReportCategoryType').AsString;
end;

procedure TfrmReAssignRepCat.DBLookupComboBox2CloseUp(Sender: TObject);
begin
  //edtRepcatNoFM.Text := dmData.qryRepCat.fieldByName('ReportCategoryNo').AsString;
  edtRepCatTypeTO.Text := dmData.qryRepCats2.fieldByName('ReportCategoryType').AsString;
end;

procedure TfrmReAssignRepCat.BitBtn2Click(Sender: TObject);
var
  RepCatTypeFM,RepCatNoFM:Integer;
  RepCatTypeTO,RepCatNoTO:Integer;
  MsgStr:String;
  Save_Cursor:TCursor;
begin
  if edtRepCatTypeFM.Text = '' then
    MessageDlg('Pls select FROM Report category',mtError,[mbOK],0)
  else
    if edtRepCatTypeTO.Text = '' then
      MessageDlg('Pls select TO Report category',mtError,[mbOK],0)
    else
      if edtRepCatNoFM.Text = '' then
        MessageDlg('Pls select FROM Report category code',mtError,[mbOK],0)
      else
        if edtRepCatNoTO.Text = '' then
          MessageDlg('Pls select TO Report category code',mtError,[mbOK],0)
        else
        begin
          MsgStr := 'Reassigning FROM <' + dmData.qryRepCats.fieldByName('Description').AsString+'>'+#10+
                    '-             TO <'+ dmData.qryRepCats2.fieldByName('Description').AsString+'>'+#10+
                    'FROM Code <' + dmData.qryRepCat.fieldByName('ReportCategoryCode').AsString+'>' + #10+
                    'TO   Code <' + dmData.qryRepCat2.fieldByName('ReportCategoryCode').AsString+'>';

          MsgStr := MsgStr + #10 + ' in all templates. Continue ?';

          RepCatNoFM := StrToInt(edtRepCatNoFM.Text);
          RepCatTypeFM := StrToInt(edtRepCatTypeFM.Text);

          RepCatNoTO := StrToInt(edtRepCatNoTO.Text);
          RepCatTypeTO := StrToInt(edtRepCatTypeTO.Text);


          if MessageDlg(MsgStr,mtConfirmation,[MbYes,MbNo],0) = mrYes then
          begin
            Save_Cursor := Screen.Cursor;

            Screen.Cursor := crHourGlass;    { Show hourglass cursor }

            try
              dmData.AssignRepCat(RepCatTypeFM,RepCatNoFM,RepCatTypeTO,RepCatNoTO);
            finally
              Screen.Cursor := Save_Cursor;  { Always restore to normal }
            end;

            MessageDlg('Done!',mtConfirmation,[mbOK],0);
            RefreshData;

          end;

        end;


end;

procedure TfrmReAssignRepCat.DBGrid1CellClick(Column: TColumn);
begin
  edtRepcatNoFM.Text := dmData.qryRepCat.fieldByName('ReportCategoryNo').AsString;
end;

procedure TfrmReAssignRepCat.Refreshdata;
var
  CCount:Integer;
begin
  dmData.qryRepCat.Close;
  dmData.qryRepCats.Close;
  dmData.qryRepCats.Open;

  dmData.qryRepCat2.Close;
  dmData.qryRepCats2.Close;
  dmData.qryRepCats2.Open;


  for CCount := 1 to 8 do
  begin
    dmData.qryRepCats.next;
    dmData.qryRepCats2.next;
  end;

  dmData.qryRepCats.First;
  DBLookupComboBox1.KeyValue := dmData.qryRepCats.fieldByName('ReportCategoryType').AsInteger;
  edtRepCatTypeFM.Text := dmData.qryRepCats.fieldByName('ReportCategoryType').AsString;

  dmData.qryRepCat.Open;

  edtRepcatNoFM.Text := '';

  dmData.qryRepCats2.First;
  DBLookupComboBox2.KeyValue := dmData.qryRepCats2.fieldByName('ReportCategoryType').AsInteger;
  edtRepCatTypeTO.Text := dmData.qryRepCats2.fieldByName('ReportCategoryType').AsString;

  dmData.qryRepCat2.Open;

  edtRepcatNoTO.Text := '';

end;

procedure TfrmReAssignRepCat.DBGrid2CellClick(Column: TColumn);
begin
  edtRepcatNoTO.Text := dmData.qryRepCat2.fieldByName('ReportCategoryNo').AsString;

end;

end.
