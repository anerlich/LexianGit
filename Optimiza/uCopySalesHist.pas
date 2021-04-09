unit uCopySalesHist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, DBCtrls, CheckLst, Buttons, ExtCtrls;

type
  TfrmCopySalesHist = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Label1: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    CheckListBox1: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCopySalesHist: TfrmCopySalesHist;
  FirstShow:Boolean;

implementation

uses uDmCopySalesHist, uLookupProd;

{$R *.DFM}

procedure TfrmCopySalesHist.FormShow(Sender: TObject);
begin

  if FirstShow then
  begin
    StatusBar1.Panels[1].Text := dmCopySalesHist.dbOptimiza.DatabaseName;

    CheckListBox1.Items.Clear;

    with dmCopySalesHist.srcAllLocations.DataSet do
    begin
      First;
      while not eof do
      begin

      ChecklistBox1.Items.Add(FieldByName('LocationCode').AsString + ' - ' + FieldByName('Description').AsString);
        next;
      end;

      first;


    end;

  end;

  FirstShow := False;

end;

procedure TfrmCopySalesHist.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmCopySalesHist.Button1Click(Sender: TObject);
begin

  if frmLookupProduct.ShowModal = mrOK then
  begin
    Edit1.Text := dmCopySalesHist.srcSearchProduct.DataSet.FieldByName('ProductCode').AsString;
  end;

end;

procedure TfrmCopySalesHist.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCopySalesHist.Button2Click(Sender: TObject);
begin

  if frmLookupProduct.ShowModal = mrOK then
  begin
    Edit2.Text := dmCopySalesHist.srcSearchProduct.DataSet.FieldByName('ProductCode').AsString;
  end;

end;

procedure TfrmCopySalesHist.BitBtn1Click(Sender: TObject);
var
  CountItem: Integer;
  LocList: TStringList;
  LocCode: String;

begin

  LocList := TStringList.Create;

  for CountItem := 0 to CheckListBox1.Items.Count -1 do
  begin
     if CheckListBox1.Checked[CountItem] then
     begin
       LocCode := Trim(Copy(CheckListBox1.Items.Strings[CountItem],1,Pos('-',CheckListBox1.Items.Strings[CountItem])-1));

       //check for same locations
       if LocCode = Trim(DBLookupComboBox1.Text) then
       begin
         MessageDlg('Cannot Copy Sales History for Location '+DBLookupComboBox1.Text +' To '+LocCode,mtError,[mbOK],0);
         LocList.Clear;
         Break;
       end;

       //check if prod exists in target loc
       if not dmCopySalesHist.CheckTarget(LocCode,Edit2.text) then
       begin
         LocList.Clear;
         Break;
       end;


       LocList.Add(LocCode);

     end;
  end;

  //check that prod exists in source location
  if not dmCopySalesHist.CheckTarget(DBLookupComboBox1.Text,Edit1.text) then
    LocList.Clear;


  for CountItem := 0 to LocList.Count -1 do
  begin
       dmCopySalesHist.UpdateSale(DBLookupComboBox1.Text,
                                   LocList.Strings[CountItem],
                                   Edit1.Text, Edit2.text);
  end;

  if LocList.Count > 0 then
    dmCopySalesHist.CommitSale
  else
    MessageDlg('No Sales History was Copied !',mtWarning,[mbOK],0);
    

  LocList.Free;

end;

end.
