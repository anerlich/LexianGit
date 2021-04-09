unit uSelectField;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls;

type
  TfrmSelectField = class(TForm)
    Panel1: TPanel;
    lblDescription: TLabel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    grdFields: TStringGrid;
    Panel4: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDescription: TEdit;
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
    FShowCheckBox:Boolean;
    procedure SetShowCheckBox(const Value: Boolean);
    procedure SetReturnReportCategories(const Value: Boolean);
    procedure SetReturnUserChar(const Value: Boolean);
    procedure SetReturnUserDouble(const Value: Boolean);
    procedure SetReturnUserDate(const Value: Boolean);
    procedure SetReturnUserInteger(const Value: Boolean);
  public
    { Public declarations }
    {FShowReportCategoriesOnly:Boolean; removed to allow optional selection of all types of fields}
    FShowReportCategories:Boolean;
    FShowUserChar:Boolean;
    FShowUserDouble:Boolean;
    FShowUserDate:Boolean;
    FShowUserInteger:Boolean;
    FReturnReportCategories:Boolean;
    FReturnReportCategoriesNumber:Boolean;
    FReturnUserChar:Boolean;
    FReturnUserDouble:Boolean;
    FReturnUserDate:Boolean;
    FReturnUserInteger:Boolean;
    FSetup:Boolean;
    FJoin, FRC: string;
    procedure populateGrid(ResetCount:Boolean);
    procedure GetSelectedField;
  published
    property ShowCheckBox:Boolean Read FShowCheckBox Write SetShowCheckBox;
    property ReturnReportCategories:Boolean Read FReturnReportCategories Write SetReturnReportCategories;
    property ReturnUserChar:Boolean Read FReturnUserChar Write SetReturnUserChar;
    property ReturnUserDouble:Boolean Read FReturnUserDouble Write SetReturnUserDouble;
    property ReturnUserDate:Boolean Read FReturnUserDate Write SetReturnUserDate;
    property ReturnUserInteger:Boolean Read FReturnUserInteger Write SetReturnUserInteger;
  end;

var
  frmSelectField: TfrmSelectField;

implementation

uses udmData;

{$R *.dfm}
{$undef EnableMemoryLeakReporting}

procedure TfrmSelectField.FormCreate(Sender: TObject);
begin
  FirstShow := True;
  FUseDescription := False;
  FShowReportCategories := False;
  FShowUserChar := False;
  FShowUserDouble := False;
  FShowUserDate := False;
  FShowUserInteger := False;
end;

procedure TfrmSelectField.grdFieldsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if not FSetup then
  begin
    edtDescription.Text := grdFields.Cells[0,ARow];
    edtField.Text := grdFields.Cells[1,ARow];
    if grdFields.Cells[2,ARow] <> '' then
    begin
      FJoin := ' left join ITEM_REPORTCATEGORY rrr'+grdFields.Cells[2,ARow]
              +' on i.ITEMNO = rrr'+grdFields.Cells[2,ARow]+'.ITEMNO and rrr'+grdFields.Cells[2,ARow]+'.REPORTCATEGORYTYPE = '+grdFields.Cells[2,ARow]
              +' left join ReportCategory r'+grdFields.Cells[2,ARow]
              +' on rrr'+grdFields.Cells[2,ARow]+'.ReportCategoryNo= r'+grdFields.Cells[2,ARow]+'.ReportcategoryNo and r'+grdFields.Cells[2,ARow]+'.ReportCategoryType='+grdFields.Cells[2,ARow];
      FRC :=  grdFields.Cells[2,ARow];
    end
    else
    begin
      FJoin := '';
      FRC := '';
    end;
    FCurrentRow := ARow;
  end;
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

  Fsetup := true;
  if FirstShow then
  begin
    FirstShow := False;
    PopulateGrid(True);
  end;

  GetSelectedField;
  Fsetup := false;

end;

procedure TfrmSelectField.populateGrid(ResetCount:Boolean);
var
  RCount,i:Integer;
begin

  if FShowReportCategories or FShowUserChar or FShowUserDouble or FShowUserDate or FShowUserInteger then
  begin
    grdFields.RowCount := 1;
    RCount := 1;
  end
  else
  begin
    grdFields.RowCount := 22;
    RCount := 22;
  end;

  grdFields.Cells[0,0] := 'Description';
  grdFields.Cells[1,0] := 'Field';
  if not ((FShowReportCategories) or (FShowUserChar) or (FShowUserDouble) or (FShowUserDate) or (FShowUserInteger)) then
  begin
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
    grdFields.Cells[0,12] := dmData.GetConfigAsString(438);
    grdFields.Cells[0,13] := dmData.GetConfigAsString(439);
    grdFields.Cells[0,14] := dmData.GetConfigAsString(440);
    grdFields.Cells[0,15]:= dmData.GetConfigAsString(441);
    grdFields.Cells[0,16]:= dmData.GetConfigAsString(442);
    grdFields.Cells[0,17] := dmData.GetConfigAsString(443);
    grdFields.Cells[0,18] := dmData.GetConfigAsString(444);
    grdFields.Cells[0,19] := dmData.GetConfigAsString(445);
    grdFields.Cells[0,20]:= dmData.GetConfigAsString(446);
    grdFields.Cells[0,21]:= dmData.GetConfigAsString(447);

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
      grdFields.Cells[1,12] := 'i.UserChar6';
      grdFields.Cells[1,13] := 'i.UserChar7';
      grdFields.Cells[1,14] := 'i.UserChar8';
      grdFields.Cells[1,15]:= 'i.UserChar9';
      grdFields.Cells[1,16]:= 'i.UserChar10';
      grdFields.Cells[1,17] := 'i.UserChar11';
      grdFields.Cells[1,18] := 'i.UserChar12';
      grdFields.Cells[1,19] := 'i.UserChar13';
      grdFields.Cells[1,20]:= 'i.UserChar14';
      grdFields.Cells[1,21]:= 'i.UserChar15';
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
      grdFields.Cells[1,10]:= 'i.UserChar4';
      grdFields.Cells[1,11]:= 'i.UserChar5';
      grdFields.Cells[1,12] := 'i.UserChar6';
      grdFields.Cells[1,13] := 'i.UserChar7';
      grdFields.Cells[1,14] := 'i.UserChar8';
      grdFields.Cells[1,15]:= 'i.UserChar9';
      grdFields.Cells[1,16]:= 'i.UserChar10';
      grdFields.Cells[1,17] := 'i.UserChar11';
      grdFields.Cells[1,18] := 'i.UserChar12';
      grdFields.Cells[1,19] := 'i.UserChar13';
      grdFields.Cells[1,20]:= 'i.UserChar14';
      grdFields.Cells[1,21]:= 'i.UserChar15';
    end;
  end;

  if not dmData.trnOptimiza.InTransaction then
    dmData.trnOptimiza.StartTransaction;

  if FShowUserChar then
  begin
    grdFields.RowCount := RCount;
    for i:=1 to 15 do
    begin
      inc(RCount);
      grdFields.RowCount := RCount;
      If i < 6 then
      begin
        grdFields.Cells[0,RCount-1] := dmData.GetConfigAsString(i+214);
      end
      else
      begin
        grdFields.Cells[0,RCount-1] := dmData.GetConfigAsString(i+437-5);
      end;
      grdFields.Cells[1,RCount-1] := 'i.UserChar'+IntToStr(i);
    end;
  end;

  if FShowUserDouble then
  begin
    grdFields.RowCount := RCount;
    for i:=1 to 15 do
    begin
      inc(RCount);
      grdFields.RowCount := RCount;
      If i < 6 then
      begin
        grdFields.Cells[0,RCount-1] := dmData.GetConfigAsString(i+208);
      end
      else
      begin
        grdFields.Cells[0,RCount-1] := dmData.GetConfigAsString(i+427-5);
      end;
      grdFields.Cells[1,RCount-1] := 'i.UserDouble'+IntToStr(i);
    end;
  end;

  if FShowUserDate then
  begin
    grdFields.RowCount := RCount;
    for i:=1 to 15 do
    begin
      inc(RCount);
      grdFields.RowCount := RCount;
      If i < 6 then
      begin
        grdFields.Cells[0,RCount-1] := dmData.GetConfigAsString(i+220);
      end
      else
      begin
        grdFields.Cells[0,RCount-1] := dmData.GetConfigAsString(i+417-5);
      end;
      grdFields.Cells[1,RCount-1] := 'i.UserDate'+IntToStr(i);
    end;
  end;

  if FShowUserInteger then
  begin
    grdFields.RowCount := RCount;
    for i:=1 to 15 do
    begin
      inc(RCount);
      grdFields.RowCount := RCount;
      If i < 6 then
      begin
        grdFields.Cells[0,RCount-1] := dmData.GetConfigAsString(i+226);
      end
      else
      begin
        grdFields.Cells[0,RCount-1] := dmData.GetConfigAsString(i+447-5);
      end;
      grdFields.Cells[1,RCount-1] := 'i.UserInteger'+IntToStr(i);
    end;
  end;

  if FShowReportCategories then
  begin
    with dmData.qryRepCatType do
    begin
      dmData.qryRepCatType.Close;
      ExecQuery;

      while not eof do
      begin
        inc(RCount);
        grdFields.RowCount := RCount;

        grdFields.Cells[0,RCount-1] := FieldByName('Description').AsString;
        //if CheckBox2.Checked then
        if FUseDescription then
          grdFields.Cells[1,RCount-1] := 'r'+FieldByName('ReportCategoryType').AsString+'.Description'
        else
        begin
          grdFields.Cells[1,RCount-1] := 'r'+FieldByName('ReportCategoryType').AsString+'.ReportCategoryCode';
        end;
        grdFields.Cells[2,RCount-1] := FieldByName('ReportCategoryType').AsString;
        next;
      end;
    end;

    dmData.qryRepCatType.Close;
  end;
  //if not resetCount then GetSelectedField;

end;

procedure TfrmSelectField.CheckBox2Click(Sender: TObject);
begin
  FUseDescription := CheckBox2.Checked;
  if not Fsetup then
  begin
   PopulateGrid(False);
   if FCurrentRow > 0 then
    if CheckBox1.Checked then
      edtField.Text := ''
    else
    begin
      edtField.Text := grdFields.Cells[1,FCurrentRow];
      if grdFields.Cells[2,FCurrentRow] <> '' then
      begin
        FJoin := ' left join ITEM_REPORTCATEGORY rrr'+grdFields.Cells[2,FCurrentRow]
              +' on i.ITEMNO = rrr'+grdFields.Cells[2,FCurrentRow]+'.ITEMNO and rrr'+grdFields.Cells[2,FCurrentRow]+'.REPORTCATEGORYTYPE = '+grdFields.Cells[2,FCurrentRow]
              +' left join ReportCategory r'+grdFields.Cells[2,FCurrentRow]
              +' on rrr'+grdFields.Cells[2,FCurrentRow]+'.ReportCategoryNo= r'+grdFields.Cells[2,FCurrentRow]+'.ReportcategoryNo and r'+grdFields.Cells[2,FCurrentRow]+'.ReportCategoryType='+grdFields.Cells[2,FCurrentRow];
        FRC :=  grdFields.Cells[2,FCurrentRow];
      end
      else
      begin
        FJoin := '';
        FRC := '';
      end;
    end;
  end;
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
      //if not CheckBox2.Checked then
        PopulateGrid(False);

    end
    else
    begin
      FUseDescription := False;

      //Toggle grid if needed
      //if CheckBox2.Checked then
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
    //if (FUseDescription) and (not CheckBox2.Checked) then
    //  CheckBox2.Checked := True;

    //if (not FUseDescription) and (CheckBox2.Checked) then
    //  CheckBox2.Checked := False;

  end;

end;

procedure TfrmSelectField.SetShowCheckBox(const Value: Boolean);
var
  LocCode,TempStr:String;
begin
  FShowCheckBox := Value;

  If  FShowCheckBox then
  begin
    CheckBox1.Visible:=True;
  end
  else
  begin
    CheckBox1.Visible:=False;
    edtField.Enabled := False;
  end;

end;

procedure TfrmSelectField.SetReturnReportCategories(const Value: Boolean);
var
  LocCode,TempStr:String;
begin
  FReturnReportCategories := Value;

  If FReturnReportCategories then
  begin
    //CheckBox2.Visible:=False;
    FShowReportCategories := true;
  end
  else
  begin
    //CheckBox2.Visible:=True;
    FShowReportCategories := false;
  end;

end;

procedure TfrmSelectField.SetReturnUserChar(const Value: Boolean);
var
  LocCode,TempStr:String;
begin
  FReturnUserChar := Value;

  If FReturnUserChar then
  begin
    //CheckBox2.Visible:=False;
    FShowUserChar := true;
  end
  else
  begin
    //CheckBox2.Visible:=True;
    FShowUserChar := false;
  end;

end;

procedure TfrmSelectField.SetReturnUserDouble(const Value: Boolean);
var
  LocCode,TempStr:String;
begin
  FReturnUserDouble := Value;

  If FReturnUserDouble then
  begin
    //CheckBox2.Visible:=False;
    FShowUserDouble := true;
  end
  else
  begin
    //CheckBox2.Visible:=True;
    FShowUserDouble := false;
  end;
end;

procedure TfrmSelectField.SetReturnUserDate(const Value: Boolean);
var
  LocCode,TempStr:String;
begin
  FReturnUserDate := Value;

  If FReturnUserDate then
  begin
    //CheckBox2.Visible:=False;
    FShowUserDate := true;
  end
  else
  begin
    //CheckBox2.Visible:=True;
    FShowUserDate := false;
  end;
end;

procedure TfrmSelectField.SetReturnUserInteger(const Value: Boolean);
var
  LocCode,TempStr:String;
begin
  FReturnUserInteger := Value;

  If FReturnUserInteger then
  begin
    //CheckBox2.Visible:=False;
    FShowUserInteger := true;
  end
  else
  begin
    //CheckBox2.Visible:=True;
    FShowUserInteger := false;
  end;
end;

end.
