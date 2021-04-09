unit uSelectField;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls;

type
  TfrmSelectField = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    lblDescription: TLabel;
    Label2: TLabel;
    edtDescription: TEdit;
    Label3: TLabel;
    grdFields: TStringGrid;
    edtField: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure grdFieldsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
    FirstShow:Boolean;
    FCurrentRow:Integer;
    FUseDescription:Boolean;
    procedure populateGrid(ResetCount:Boolean);
    procedure GetSelectedField;
  public
    { Public declarations }
  end;

var
  frmSelectField: TfrmSelectField;

implementation

uses udmData;

{$R *.dfm}

procedure TfrmSelectField.FormCreate(Sender: TObject);
begin

  FirstShow := True;
  FUseDescription := False;

end;

procedure TfrmSelectField.grdFieldsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  edtDescription.Text := grdFields.Cells[0,ARow];
  edtField.Text := grdFields.Cells[1,ARow];
  FCurrentRow := ARow;
end;

procedure TfrmSelectField.CheckBox1Click(Sender: TObject);
begin

  if CheckBox1.Checked then
  begin
    edtDescription.Text := '';
    edtField.Text := '';
    edtDescription.Enabled := False;
    edtField.Enabled := False;
    grdFields.Enabled := False;
  end
  else
  begin
    edtDescription.Enabled := True;
    edtField.Enabled := True;
    grdFields.Enabled := True;
  end;

end;

procedure TfrmSelectField.FormActivate(Sender: TObject);
var
  RepCatType:String;
  RCount:Integer;
begin

  if FirstShow then
  begin
    FirstShow := False;
    PopulateGrid(True);
  end;

  GetSelectedField;

end;

procedure TfrmSelectField.populateGrid(ResetCount:Boolean);
var
  RCount:Integer;
begin

  if ResetCount then
    grdFields.RowCount := 12;

  grdFields.Cells[0,0] := 'Description';
  grdFields.Cells[1,0] := 'Field';
  grdFields.Cells[0,1] := 'Stocking Indicator';
  grdFields.Cells[0,2] := 'Pareto';
  grdFields.Cells[0,3] := 'Major Group';
  grdFields.Cells[0,4] := 'Minor Group 1';
  grdFields.Cells[0,5] := 'Minor Group 2';
  grdFields.Cells[0,6] := 'Supplier';
  grdFields.Cells[0,7] := dmData.GetConfigAsString(215);
  grdFields.Cells[0,8] := dmData.GetConfigAsString(216);
  grdFields.Cells[0,9] := dmData.GetConfigAsString(217);
  grdFields.Cells[0,10]:= dmData.GetConfigAsString(218);
  grdFields.Cells[0,11]:= dmData.GetConfigAsString(219);

  //if CheckBox2.Checked then
  if FUseDescription then
  begin
    grdFields.Cells[1,1] := 'i.StockingIndicator';
    grdFields.Cells[1,2] := 'i.ParetoCategory';
    grdFields.Cells[1,3] := 'gm.Description';
    grdFields.Cells[1,4] := 'gm1.Description';
    grdFields.Cells[1,5] := 'gm2.Description';
    grdFields.Cells[1,6] := 's.SupplierName';
    grdFields.Cells[1,7] := 'i.UserChar1';
    grdFields.Cells[1,8] := 'i.UserChar2';
    grdFields.Cells[1,9] := 'i.UserChar3';
    grdFields.Cells[1,10]:= 'i.UserChar4';
    grdFields.Cells[1,11]:= 'i.UserChar5';
  end
  else
  begin
    grdFields.Cells[1,1] := 'i.StockingIndicator';
    grdFields.Cells[1,2] := 'i.ParetoCategory';
    grdFields.Cells[1,3] := 'gm.GroupCode';
    grdFields.Cells[1,4] := 'gm1.GroupCode';
    grdFields.Cells[1,5] := 'gm2.GroupCode';
    grdFields.Cells[1,6] := 's.SupplierCode';
    grdFields.Cells[1,7] := 'i.UserChar1';
    grdFields.Cells[1,8] := 'i.UserChar2';
    grdFields.Cells[1,9] := 'i.UserChar3';
    grdFields.Cells[1,10]:= 'i.UserChar4';
    grdFields.Cells[1,11]:= 'i.UserChar5';
  end;

  if not dmData.trnOptimiza.InTransaction then
    dmData.trnOptimiza.StartTransaction;

  with dmData.qryRepCatType do
  begin
    ExecQuery;

    if ResetCount then
      RCount := grdFields.RowCount
    else
      RCount := 12;


    while not eof do
    begin
      inc(RCount);

      if ResetCount then
        grdFields.RowCount := RCount;

      grdFields.Cells[0,RCount-1] := FieldByName('Description').AsString;

      //if CheckBox2.Checked then
      if FUseDescription then
        grdFields.Cells[1,RCount-1] := 'r'+FieldByName('ReportCategoryType').AsString+'.Description'
      else
        grdFields.Cells[1,RCount-1] := 'r'+FieldByName('ReportCategoryType').AsString+'.ReportCategoryCode';

      next;
    end;

    Close;
  end;

end;

procedure TfrmSelectField.CheckBox2Click(Sender: TObject);
begin
  FUseDescription := CheckBox2.Checked;
  PopulateGrid(False);
  if FCurrentRow > 0 then
    if CheckBox1.Checked then
      edtField.Text := ''
    else
      edtField.Text := grdFields.Cells[1,FCurrentRow];
end;

procedure TfrmSelectField.GetSelectedField;
var
  cCount:Integer;
  myRect: TGridRect;
  TempStr:String;
begin

  if edtField.Text <> '' then
  begin
    TempStr := UpperCase(edtField.Text);

    if (Pos('DESCRIPTION',Tempstr)>0) or (Pos('NAME',TempStr)>0) then
    begin
      FUseDescription := True;

      //Toggle grid if needed
      if not CheckBox2.Checked then
        PopulateGrid(False);

    end
    else
    begin
      FUseDescription := False;

      //Toggle grid if needed
      if CheckBox2.Checked then
        PopulateGrid(False);
    end;


    for CCount := 0 to grdFields.Cols[1].Count - 1 do
    begin

      if grdFields.Cols[1].Strings[CCount] = edtField.Text then
      begin
        myRect.Left := 0;
        myRect.Top := CCount;
        myRect.Right := 1;
        myRect.Bottom := CCount;
        grdFields.Selection := myRect;
        FCurrentRow := CCount;
        grdFields.Row := cCount;
        grdFields.TopRow := cCount;
      end;


    end;


    //Change the state if needed
    if (FUseDescription) and (not CheckBox2.Checked) then
      CheckBox2.Checked := True;

    if (not FUseDescription) and (CheckBox2.Checked) then
      CheckBox2.Checked := False;

  end;

end;

end.
