unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, ExtCtrls, DBCtrls, DBGrids, StdCtrls, Buttons,
  CustomGrid1, ExtEdit,Db;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    GroupBox5: TGroupBox;
    DBLookupComboBox1: TDBLookupComboBox;
    GroupBox4: TGroupBox;
    Edit2: TEdit;
    BitBtn8: TBitBtn;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox6: TGroupBox;
    DBLookupComboBox2: TDBLookupComboBox;
    GroupBox7: TGroupBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    Splitter1: TSplitter;
    Panel3: TPanel;
    StringGrid1: TStringGrid;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    StatusBar1: TStatusBar;
    Panel4: TPanel;
    CheckBox1: TCheckBox;
    GroupBox2: TGroupBox;
    grpMonth: TRadioGroup;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    grpAdd: TRadioGroup;
    chkFreeze: TCheckBox;
    CheckBox2: TCheckBox;
    GroupBox3: TGroupBox;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    edtPercentage: TExtEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel5: TPanel;
    procedure CheckBox1Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure CheckBox2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FirstShow:Boolean;
    procedure ShowParameters;
    procedure DeleteRow(aRow:Integer);
    procedure DeleteAllRows;
    function FindRow(TgtLoc,TgtProd:String):Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses udmData, uStatus;

{$R *.dfm}

procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
  GroupBox2.Enabled := CheckBox1.Checked;

  if CheckBox1.Checked then
    GroupBox2.Font.Color := clBlack
  else
    GroupBox2.Font.Color := clSilver;
    
end;

procedure TfrmMain.BitBtn8Click(Sender: TObject);
var
  Save_Cursor:TCursor;
Begin
  Save_Cursor := Screen.Cursor;

  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try
    dmData.GetSrcProdList(Edit2.Text);
  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;

end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if FirstShow then
  begin
    dmData.OpenData;
    StatusBar1.Panels[1].Text := dmData.DbDescription;

    if not dmData.CheckProcedure then
      Close;

    StringGrid1.Cells[0,0] := 'Source Location';
    StringGrid1.Cells[1,0] := 'Source Product';
    StringGrid1.Cells[2,0] := 'Target Location';
    StringGrid1.Cells[3,0] := 'Target Product';


    DBLookupComboBox1.KeyValue := dmData.qrySrcLocation.fieldByName('LocationNo').asinteger;
    DBLookupComboBox2.KeyValue := dmData.qryTgtLocation.fieldByName('LocationNo').asinteger;

    ComboBox1.Items.Clear;
    dmData.openPeriod;
    With dmData.srcPeriod.DataSet do
    begin
      First;

      While not Eof do
      begin
        ComboBox1.Items.Add(FieldbyName('Description').asString);
        Next;
      end;

      Close;

      ComboBox1.Text := ComboBox1.Items.Strings[0];
      ComboBox1.ItemIndex := 0;

    end;

    FirstShow := False;
      PageControl1.ActivePage := TabSheet1;
  end;


end;

procedure TfrmMain.Edit2Change(Sender: TObject);
begin
  Edit1.Text := Edit2.Text;

end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  Save_Cursor:TCursor;
Begin
  Save_Cursor := Screen.Cursor;

  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try
    dmData.GetTgtProdList(Edit1.Text);
  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;

end;

procedure TfrmMain.DBGrid1CellClick(Column: TColumn);
begin
  Edit2.Text := dmData.qrySrcProd.fieldByName('ProductCode').asString;
end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
var
  SrcProd:String;
  LCount:Integer;
begin

    if dbGrid1.SelectedRows.Count = 0 then
      MessageDlg('Select Source product',mtInformation,[mbOK],0)
    else
    begin

      if not FindRow(dmData.qryTgtLocation.fieldByName('LocationCode').asString,Edit1.Text) then
      begin
        srcProd := dmData.qrySrcProd.fieldByName('ProductCode').asString;
        lCount := StringGrid1.RowCount;

        Inc(LCount);

        StringGrid1.RowCount := lCount;
        Dec(lCount,2);

        StringGrid1.Cells[0,lCount] := dmData.qrySrcLocation.fieldByName('LocationCode').asString;
        StringGrid1.Cells[1,lCount] := srcProd;
        StringGrid1.Cells[2,lCount] := dmData.qryTgtLocation.fieldByName('LocationCode').asString;
        StringGrid1.Cells[3,lCount] := Edit1.Text;
      end;

    end;

end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
begin
  DeleteRow(StringGrid1.Row);
end;

procedure TfrmMain.DBGrid2CellClick(Column: TColumn);
begin
  Edit1.Text := dmData.qryTgtProd.fieldByName('ProductCode').asString;
end;

procedure TfrmMain.CheckBox2Click(Sender: TObject);
begin
  GroupBox3.Enabled := CheckBox2.Checked;

  if CheckBox2.Checked then
    GroupBox3.Font.Color := clBlack
  else
    GroupBox3.Font.Color := clSilver;

end;

procedure TfrmMain.BitBtn4Click(Sender: TObject);
var
  rCount,MonthCount,OffSet:Integer;
  SrcLoc,TgtLoc,SrcProd,TgtProd,AddInd,ReplaceInd,FreezeInd:String;
  ErrorOccurred:Boolean;
  Perc:Double;
  SaveKey1,SaveKey2:Integer;
begin

  if (CheckBox1.Checked = False) and (CheckBox2.Checked = False) then
    MessageDlg('Please select "Copy Forecasts" or "Copy Sales" on criteria tab',mtError,[mbOK],0)
  else
  begin

    frmStatus.OpenLogFile;
    frmStatus.Show;

    ShowParameters;

    //Forecast
    if grpAdd.ItemIndex = 0 then
      AddInd := 'R'
    else
      addInd := 'A';

    if chkFreeze.Checked then
      FreezeInd := 'Y'
    else
      FreezeInd := 'N';

    MonthCount := 12;

    Case grpMonth.ItemIndex  of
      0: MonthCount := 6;
      1: MonthCount := 12;
      2: MonthCount := 18;
      3: MonthCount := 24;
    end;

    Offset := ComboBox1.ItemIndex;

    //Sales
    if RadioGroup1.ItemIndex = 0 then
      ReplaceInd := 'R'
    else
      ReplaceInd := 'A';

    ErrorOccurred := False;

    Perc := StrToFloat(edtPercentage.Text);

    for rCount := 1 to StringGrid1.RowCount-2 do
    begin
      srcLoc  := StringGrid1.Cells[0,rCount];
      srcProd := StringGrid1.Cells[1,rCount];
      tgtLoc  := StringGrid1.Cells[2,rCount];
      tgtProd := StringGrid1.Cells[3,rCount];

      if not dmData.CheckTarget(TgtLoc,TgtProd) then
      begin
        ErrorOccurred := True;
        frmStatus.Say('*** Error, Product : '+TgtProd + ' NOT Found in Location : '+TgtLoc);
      end
      else
      begin

        if CheckBox1.Checked then
          dmData.UpdateFC(SrcLoc,TgtLoc,SrcProd,TgtProd,FreezeInd,AddInd,MonthCount,Offset,Perc);

        if CheckBox2.Checked then
          dmData.UpdateSale(SrcLoc,TgtLoc,SrcProd,TgtProd,ReplaceInd);

        frmStatus.Say('Product : '+SrcProd + ', Location : '+SrcLoc+' Copied to '+
                      'Product : '+TgtProd + ', Location : '+TgtLoc);
      end;

      frmStatus.Label1.Caption := IntToStr(rCount);
      frmStatus.ProgressBar1.StepIt;
      application.ProcessMessages;

    end;

    frmStatus.closeLogFile;
    frmStatus.ProgressBar1.Position := 100;

    SaveKey1 := DBLookupComboBox1.KeyValue;
    SaveKey2 := DBLookupComboBox2.KeyValue;

    dmData.CommitData;
    dmData.OpenData;    //re-open necessary tables

    if ErrorOccurred then
      MessageDlg('An error occurred during the update. Please check the log file',mtError,[mbOK],0)
    else
      MessageDlg('Update Complete',mtInformation,[mbOK],0);

    frmStatus.ProgressBar1.Position := 0;
    frmStatus.Label1.Caption := 'Complete';
    DeleteAllRows;

    DBLookupComboBox1.KeyValue := SaveKey1;
    DBLookupComboBox2.KeyValue := SaveKey2;

    dmData.srcSrcLocation.DataSet.Locate('LocationNo',SaveKey1,[loCaseInsensitive]);
    dmData.srcTgtLocation.DataSet.Locate('LocationNo',SaveKey2,[loCaseInsensitive]);
  end;


end;

procedure TfrmMain.ShowParameters;
begin
  frmStatus.Say('Parameters');
  frmStatus.Say('----------');

  if CheckBox1.Checked then
  begin
    frmStatus.Say('Copy Forecasts using following criteria:');
    frmStatus.Say(grpMonth.Caption + ' : ' + grpMonth.Items.Strings[RadioGroup1.ItemIndex]);
    frmStatus.Say(GroupBox1.Caption + ' : ' + ComboBox1.Text);
    frmStatus.Say('Copy % : ' + edtPercentage.Text);
    if chkFreeze.Checked then
      frmStatus.Say('Forecast : ' + chkFreeze.Caption);
    frmStatus.Say(' Forecast : ' + grpAdd.Items.Strings[grpAdd.ItemIndex]);

    frmStatus.Say('----------------------------------------');
  end;

  if CheckBox2.Checked then
  begin
    frmStatus.Say('Copy Sales using following criteria:');
    frmStatus.Say(' Sales : ' + RadioGroup1.Items.Strings[RadioGroup1.ItemIndex]);
  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TfrmMain.DeleteRow(aRow: Integer);
var
  RCount:Integer;
begin

  if aRow <> StringGrid1.RowCount -1 then
  begin
    //Move all rows 1 up to overwrite the deleted row
    for rCount := aRow to (StringGrid1.RowCount - 2) do
    begin
      StringGrid1.Cells[0,rCount] := StringGrid1.Cells[0,rCount+1];
      StringGrid1.Cells[1,rCount] := StringGrid1.Cells[1,rCount+1];
      StringGrid1.Cells[2,rCount] := StringGrid1.Cells[2,rCount+1];
      StringGrid1.Cells[3,rCount] := StringGrid1.Cells[3,rCount+1];
    end;

    //then remove last row if needed
    rCount := StringGrid1.RowCount;
    Dec(rCount);

    if rCount > 1 then
      StringGrid1.RowCount := rCount;

  end;


end;

procedure TfrmMain.DeleteAllRows;
begin
 StringGrid1.RowCount := 3;
 DeleteRow(1);

end;

function TfrmMain.FindRow(TgtLoc, TgtProd: String): Boolean;
var
  rCount:Integer;
begin

  Result := False;

  for rCount := 1 to StringGrid1.RowCount-2 do
  begin

    if (TgtLoc+TgtProd) = (StringGrid1.Cells[2,rCount]+StringGrid1.Cells[3,rCount]) then
    begin
      MessageDlg(TgtLoc + ':'+TgtProd+ ' already in the list.',mtError,[mbOK],0);
      Result := True;
    end;

  end;

end;

end.
