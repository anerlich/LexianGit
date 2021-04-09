unit uUpdateSpecial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ComCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Mask,
  Menus, ImgList, ExtEdit, Spin;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    shtData: TTabSheet;
    shtLocations: TTabSheet;
    shtCriteria: TTabSheet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CheckBox1: TCheckBox;
    RadioGroup1: TRadioGroup;
    CheckBox2: TCheckBox;
    RadioGroup2: TRadioGroup;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ListBox3: TListBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox4: TListBox;
    PageControl2: TPageControl;
    shtProducts: TTabSheet;
    shtOther: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    BitBtn4: TBitBtn;
    chkProducts: TCheckBox;
    chkOther: TCheckBox;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    Label3: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    RadioGroup3: TRadioGroup;
    CheckBox3: TCheckBox;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    MaskEdit2: TMaskEdit;
    GroupBox5: TGroupBox;
    CheckBox4: TCheckBox;
    MaskEdit1: TMaskEdit;
    GroupBox6: TGroupBox;
    ComboBox2: TComboBox;
    MaskEdit3: TMaskEdit;
    GroupBox7: TGroupBox;
    ComboBox3: TComboBox;
    GroupBox8: TGroupBox;
    ComboBox4: TComboBox;
    GroupBox9: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox5: TCheckBox;
    GroupBox10: TGroupBox;
    ComboBox5: TComboBox;
    MaskEdit6: TMaskEdit;
    Label6: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    Bevel1: TBevel;
    LoadSQL1: TMenuItem;
    SaveSQL1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Version1: TMenuItem;
    About2: TMenuItem;
    ImageList1: TImageList;
    About3: TMenuItem;
    BitBtn20: TBitBtn;
    lstProd: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    BitBtn21: TBitBtn;

   
    edtMin: TExtEdit;
    edtMult: TExtEdit;
    GroupBox11: TGroupBox;
    CheckBox6: TCheckBox;
    edtBinLevel: TExtEdit;
    GroupBox12: TGroupBox;
    ComboBox6: TComboBox;
    MaskEdit4: TMaskEdit;
    GroupBox13: TGroupBox;
    CheckBox7: TCheckBox;
    SpinEdit1: TSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkProductsClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure chkOtherClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure shtDataExit(Sender: TObject);
    procedure shtLocationsExit(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure LoadSQL1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About3Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure lstProdDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lstProdDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBGrid2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Version1Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
  private
    { Private declarations }
    function Validatedata:Boolean;
    procedure AddUpdateSql(SqlString: String);
    procedure BuildAllSql;
    procedure SetTabs;
    procedure BuildLocationList;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FirstShow: Boolean;
  SQLUpdate, SQLLoc, SQLGroup: TStringList;


implementation

uses uDmUpdateSpecial, uGroup, uAndOr, uAbout, uAddRec, uProducts;

{$R *.DFM}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := Caption + dmUpdateSpecial.kfVersionInfo;

  PageControl1.ActivePage := shtData;
  PageControl2.ActivePage := shtProducts;
  shtOther.TabVisible := False;
  FirstShow := True;
  SQLUpdate := TStringList.Create;
  SQLLoc := TStringList.Create;
  SQLGroup := TStringList.Create;
  lstProd.Items.Clear;

  if FileExists('ProdList.txt') then
  begin
    lstProd.Items.LoadFromFile('ProdList.txt');
    lstProd.ItemIndex := 0;
  end;

end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  RadioGroup1.Enabled := not RadioGroup1.Enabled;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  RadioGroup2.Enabled := not RadioGroup2.Enabled;

end;

procedure TForm1.FormShow(Sender: TObject);
begin

if Firstshow then
begin
  statusBar1.Panels[1].Text := dmUpdateSpecial.dbOptimiza.DatabaseName;

  BuildLocationList;
end
Else
  FirstShow := False;


end;

procedure TForm1.BuildLocationList;
begin
  ListBox1.Clear;
  ListBox2.Clear;
  ListBox3.Clear;
  ListBox4.Clear;

  dmUpdateSpecial.OpenAllLocations;

  With dmUpdateSpecial.srcAllLocations.DataSet do
  begin
    first;

    while not eof do
    begin
      ListBox1.Items.Add(FieldByName('DESCRIPTION').AsString);
      ListBox3.Items.Add(FieldByName('LOCATIONNO').AsString);
      next;
    end;

  end;
end;

procedure TForm1.chkProductsClick(Sender: TObject);
begin
  shtProducts.TabVisible := not shtProducts.TabVisible;
  chkOther.Checked := not chkProducts.Checked;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
  cProdCode: String;
begin

  try
    cProdCode := dmUpdateSpecial.srcSearchProd.DataSet.FieldByName('ProductCode').AsString;
    lstProd.Items.Add(cProdCode);
    lstProd.ItemIndex := lstProd.items.Count-1;
    dmUpdateSpecial.srcSearchProd.DataSet.Next;

  except
    MessageDlg('No Products in search list to add.'+#10+'Click on the Find button to search',mtError,[mbOk],0);
  end;


end;

procedure TForm1.chkOtherClick(Sender: TObject);
begin
  shtOther.TabVisible := not shtOther.TabVisible;
  chkProducts.Checked := not chkOther.Checked;
end;

function TForm1.Validatedata:Boolean;
begin

  Result := True;

  If SQLUpdate.Count <= 1 then
  begin
    PageControl1.ActivePage := shtData;
    MessageDlg('Please select indicators to update'+#10+'on "Data to Update" Tab',mtError,[mbOK],0);
    Result := False;
  end;

  if (Result) and (ListBox4.Items.count <= 0) then
  begin
    PageControl1.ActivePage := shtLocations;
    MessageDlg('Select Locations to update'+#10+'on "Locations" Tab',mtError,[mbOK],0);
    Result := False;
  end;

  if (Result = True) and (MessageDlg('Do you wish to run the update now ?',mtConfirmation,[mbYes,mbNo],0) = mrNo) then
    Result := False;

end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var
  SQLResult: TModalResult;
begin

  If SQLGroup.Count = 0 then
    SQLGroup.Add('AND ( ')
  Else
    if frmAndOr.ShowModal = mrOK then
         SQLGroup.Add(' ' + frmAndOr.RadioGroup1.Items[frmAndOr.RadioGroup1.ItemIndex]+ ' ');

  While True do
  begin

    SQLResult := frmGroup.ShowModal;

    if  (SQLResult = mrYes) or (SQLResult = mrOK) then
      SQLGroup.Add(frmGroup.SQLString);

    if (SQLResult = mrYes) then
      if frmAndOr.ShowModal = mrOK then
         SQLGroup.Add(' ' + frmAndOr.RadioGroup1.Items[frmAndOr.RadioGroup1.ItemIndex]+ ' ')
      else
        break;

    if  (SQLResult = mrCancel) or (SQLResult = mrOK) then
      break;

  end;

  BuildAllSql;

end;

procedure TForm1.BitBtn8Click(Sender: TObject);
Var
  SaveIt: Word;
begin

  SaveIt := mrYes;

  if BitBtn7.Enabled then
  begin
    SaveIt := MessageDlg('The SQL text was changed !'#10#10'Do you wish to save it ?',mtInformation,[mbYes,mbNo,mbCancel],0);

    If SaveIt = mrYes then
      BitBtn7Click(nil);
  end;

  if SaveIt <> mrCancel then
  begin
    SQLGroup.Clear;
    BitBtn7.Enabled := False;
    BuildAllSql;
  end;


end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  BitBtn7.Enabled := True;
  SaveSQL1.Enabled := True;
  Version1.Enabled := True;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
  if Memo1.CanUndo then
  begin
    Memo1.Undo;
    Memo1.ClearUndo;
  end
  else
    Memo1.Lines.Delete(Memo1.Lines.Count-1);

  if SQLGroup.Count > 0 then
    SQLGroup.Delete(SQLGroup.Count-1);


  if Memo1.Lines.Count = 0 then
  begin
    BitBtn7.Enabled := False;
    SaveSQL1.Enabled := False;
  end;

end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
    BitBtn7.Enabled := False;
    SaveSQL1.Enabled := False;

  end;

end;

procedure TForm1.BitBtn6Click(Sender: TObject);
Var
  SaveIt: Word;
begin

  SaveIt := mrYes;

  if BitBtn7.Enabled then
  begin
    SaveIt := MessageDlg('The SQL text was changed !'#10#10'Do you wish to save it ?',mtInformation,[mbYes,mbNo,mbCancel],0);

    If SaveIt = mrYes then
      BitBtn7Click(nil);
  end;

  if SaveIt <> mrCancel then
  begin

    if OpenDialog1.Execute then
    begin
      Memo1.Lines.LoadFromFile(OpenDialog1.FileName);

      BitBtn7.Enabled := False;
      SaveSQL1.Enabled := False;
      BuildLocationList;
      SetTabs;
      chkOther.Checked := True;
    end;


  end;


end;

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
  PageControl1.ActivePage := shtLocations;
end;

procedure TForm1.BitBtn11Click(Sender: TObject);
begin
  PageControl1.ActivePage := shtCriteria;

end;

procedure TForm1.BitBtn12Click(Sender: TObject);
begin
 PageControl1.ActivePage := shtData;
end;

procedure TForm1.BitBtn13Click(Sender: TObject);
begin
  PageControl1.ActivePage := shtLocations;

end;

procedure TForm1.BitBtn14Click(Sender: TObject);
var
  cPareto, cStock: String;
  Save_Cursor:TCursor;
begin

  If ValidateData then
  begin

    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crSQLWait;

    try

      if chkProducts.Checked then
      begin
        lstProd.Items.SaveToFile('ProdList.txt');
        dmUpdateSpecial.UpdateByProd(SQLUpdate,SQLLoc,lstProd.Items);
      end
      else
        dmUpdateSpecial.UpdateByGroup(Memo1.Lines);

    finally
        Screen.Cursor := Save_Cursor;
    end;


  end;



end;

procedure TForm1.BitBtn15Click(Sender: TObject);
begin
  dmUpdateSpecial.OpenSearchProd(Edit1.text);

end;

procedure TForm1.BitBtn16Click(Sender: TObject);
var
  Count: Integer;
begin

  for Count := 0 to (ListBox1.Items.Count - 1) do
  begin

    if ListBox1.Selected[Count] then
    begin
      ListBox2.Items.Add(ListBox1.Items.Strings[Count]);
      ListBox4.Items.Add(ListBox3.Items.Strings[Count]);
    end;

  end;

  for Count := (ListBox1.Items.Count - 1) downto 0 do
  begin

    if ListBox1.Selected[Count] then
    begin
      ListBox1.Items.delete(Count);
      ListBox3.Items.delete(Count);
    end;

  end;




end;

procedure TForm1.BitBtn18Click(Sender: TObject);
var
  Count: Integer;
begin

  While ListBox1.Items.Count - 1 >= 0 do
  begin
    ListBox2.Items.Add(ListBox1.Items.Strings[0]);
    ListBox1.Items.Delete(0);
    ListBox4.Items.Add(ListBox3.Items.Strings[0]);
    ListBox3.Items.Delete(0);
  end;



end;

procedure TForm1.BitBtn19Click(Sender: TObject);
var
  Count: Integer;
begin

  While ListBox2.Items.Count - 1 >= 0 do
  begin
    ListBox1.Items.Add(ListBox2.Items.Strings[0]);
    ListBox2.Items.Delete(0);
    ListBox3.Items.Add(ListBox4.Items.Strings[0]);
    ListBox4.Items.Delete(0);
  end;



end;

procedure TForm1.BitBtn17Click(Sender: TObject);
var
  Count: Integer;
begin

  for Count := 0 to (ListBox2.Items.Count - 1) do
  begin

    if ListBox2.Selected[Count] then
    begin
      ListBox1.Items.Add(ListBox2.Items.Strings[Count]);
      ListBox3.Items.Add(ListBox4.Items.Strings[Count]);
    end;

  end;

  for Count := (ListBox2.Items.Count - 1) downto 0 do
  begin

    if ListBox2.Selected[Count] then
    begin
      ListBox2.Items.delete(Count);
      ListBox4.Items.delete(Count);
    end;

  end;


end;

procedure TForm1.shtDataExit(Sender: TObject);
begin
  SQLUpdate.Clear;

  SQLUpdate.Add('Update Item Set ');

  If CheckBox1.checked then
    AddUpdateSql('ParetoCategory = "'+RadioGroup1.Items.Strings[RadioGroup1.ItemIndex]+'"');

  If CheckBox2.checked then
    If RadioGroup2.ItemIndex = 0 then
      AddUpdateSql('StockingIndicator = "Y"')
    else
      AddUpdateSql('StockingIndicator = "N"');

  If CheckBox3.checked then
    AddUpdateSql('LeadTimeCategory = "'+Copy(RadioGroup3.Items.Strings[RadioGroup3.ItemIndex],1,1)+'"');

  If ComboBox3.ItemIndex > 0 then
    AddUpdateSql('ManualPolicy = "'+Copy(ComboBox3.Items.Strings[Combobox3.ItemIndex],1,1)+'"');

  If ComboBox4.ItemIndex > 0 then
    AddUpdateSql('ManualForecast = "'+Copy(ComboBox4.Items.Strings[Combobox4.ItemIndex],1,1)+'"');

  If CheckBox4.checked then
    AddUpdateSql('LeadTime = '+MaskEdit1.EditText);

  If CheckBox6.checked then
    AddUpdateSql('BinLevel = '+edtBinLevel.Text);

  If ComboBox2.ItemIndex > 0 then
    AddUpdateSql('ReplenishmentCycle = '+MaskEdit3.EditText);

  If ComboBox6.ItemIndex > 0 then
    AddUpdateSql('SafetyStock = '+MaskEdit4.EditText);

  If CheckBox7.checked then
    AddUpdateSql('Criticality = '+SpinEdit1.Text);

  If ComboBox5.ItemIndex > 0 then
    AddUpdateSql('ServiceLevel = '+MaskEdit6.EditText);

  if ComboBox1.ItemIndex > 0 then
  begin

    if ComboBox1.ItemIndex = 5 then
      AddUpdateSql('ReviewPeriod = '+MaskEdit2.EditText)
    else
    begin

      Case ComboBox1.ItemIndex of
        1: AddUpdateSql('ReviewPeriod = 0.04');
        2: AddUpdateSql('ReviewPeriod = 0.25');
        3: AddUpdateSql('ReviewPeriod = 0.50');
        4: AddUpdateSql('ReviewPeriod = 1.00');
      end;

    end;

  end;

  If CheckBox5.checked then
  begin
    AddUpdateSql('MinimumOrderQuantity = '+edtMin.Text);
    AddUpdateSql('OrderMultiples = '+edtMult.Text)       ;

  end;


  BuildAllSql();
end;

procedure TForm1.AddUpdateSql(SqlString: String);
begin

  if SQLUpdate.Count > 1 then
    SQLUpdate.Add('  ,'+SqlString)
  else
    SQLUpdate.Add('  '+SqlString);

end;


procedure TForm1.BuildAllSql;
begin
  memo1.Clear;
  memo1.Lines.AddStrings(SQLUpdate);
  memo1.Lines.AddStrings(SQLLoc);
  memo1.Lines.AddStrings(SQLGroup);

  if SQLGroup.Count > 0 then
    memo1.Lines.Add(' )');
end;

procedure TForm1.shtLocationsExit(Sender: TObject);
Var
 cLocs: String;
 I: Integer;
begin
  SQLLoc.Clear;
  SQLLoc.Add('Where ');

  cLocs := '';

  For I := 0 to ListBox4.Items.Count -1 do
  begin
    If cLocs <> '' then
      cLocs := cLocs + ', ' ;
    

    cLocs := cLocs + ListBox4.Items.Strings[I];
  end;

  SQLLoc.Add('  LocationNo in ('+cLocs+')') ;

  BuildAllSql;


end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  RadioGroup3.Enabled := not RadioGroup3.Enabled;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  MaskEdit1.Enabled := not MaskEdit1.Enabled;

end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  MaskEdit2.Visible := (ComboBox1.ItemIndex = 5);
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  MaskEdit3.Visible := (ComboBox2.ItemIndex = 1);


end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  GroupBox9.Enabled := not Groupbox9.Enabled;
end;

procedure TForm1.ComboBox5Change(Sender: TObject);
begin
  MaskEdit6.Visible := (ComboBox5.ItemIndex = 1);
  Label6.Visible := (ComboBox5.ItemIndex = 1);
end;

procedure TForm1.SetTabs;
var
 SqlString, FieldData, cChar, cLocNum: String;
 I, nPos, LocNum: Integer;
 LocList: TStringList;
 GroupData: Boolean;

begin

  GroupData := False;

  LocList := TStringList.Create;
  try

    //----------------------------------------------------
    with memo1.Lines do
    begin
      CheckBox1.Checked := False;   //Status
      CheckBox2.Checked := False;   //Stind
      CheckBox3.Checked := False;   //Lt Cat
      CheckBox4.Checked := False;   //LT
      CheckBox6.Checked := False;   //BinLevel
      CheckBox5.Checked := False;   //Order Multiples
      ComboBox3.ItemIndex := 0;     //Manual Policy
      ComboBox4.ItemIndex := 0;     //Manaul FC
      ComboBox2.ItemIndex := 0;     //Rc
      MaskEdit3.Visible := False;   //Rc
      ComboBox6.ItemIndex := 0;     //ss
      MaskEdit4.Visible := False;   //ss
      ComboBox1.ItemIndex := 0;     //Rp
      MaskEdit2.Visible := False;   //Rp
      ComboBox5.ItemIndex := 0;     //Service
      MaskEdit6.Visible := False;   //Service
      Label6.Visible := False;      //Service
      SQLGroup.Clear;

    For I := 1 to Count - 1 do
    begin
      SqlString := Strings[I];

      If Pos('ParetoCategory',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('"',Strings[I])+1,1);
       RadioGroup1.ItemIndex := RadioGroup1.Items.IndexOf(FieldData);

       If RadioGroup1.ItemIndex < 0 then
         RadioGroup1.ItemIndex := 0   //give it some value
       else
         CheckBox1.Checked := True;
      end ;

      If Pos('StockingIndicator',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('"',Strings[I])+1,1);

       if FieldData = 'Y' then
         RadioGroup2.ItemIndex := 0
       else
         RadioGroup2.ItemIndex := 1;

       CheckBox2.Checked := True;
      end  ;

      If Pos('LeadTimeCategory',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('"',Strings[I])+1,1);

       if FieldData = 'S' then
         RadioGroup3.ItemIndex := 0
       else
         if FieldData = 'M' then
           RadioGroup3.ItemIndex := 1
         else
           RadioGroup3.ItemIndex := 2;

       CheckBox3.Checked := True;
      end  ;

      If Pos('ManualPolicy',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('"',Strings[I])+1,1);

       if FieldData = 'Y' then
         ComboBox3.ItemIndex := 1
       else
         ComboBox3.ItemIndex := 2;

      end  ;

      If Pos('ManualForecast',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('"',Strings[I])+1,1);

       if FieldData = 'Y' then
         ComboBox4.ItemIndex := 1
       else
         ComboBox4.ItemIndex := 2;

      end  ;

      If Pos('LeadTime',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('=',Strings[I])+1,Length(Strings[I]));
       MaskEdit1.Text := Trim(FieldData);
       CheckBox4.Checked := True;
      end;

      If Pos('BinLevel',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('=',Strings[I])+1,Length(Strings[I]));
       edtBinLevel.Text := Trim(FieldData);
       CheckBox6.Checked := True;
      end;

      If Pos('ReplenishmentCycle',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('=',Strings[I])+1,Length(Strings[I]));
       MaskEdit3.Text := Trim(FieldData);
       ComboBox2.ItemIndex := 1;
       MaskEdit3.Visible := True;
      end;

      If Pos('SafetyStock',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('=',Strings[I])+1,Length(Strings[I]));
       MaskEdit4.Text := Trim(FieldData);
       ComboBox6.ItemIndex := 1;
       MaskEdit4.Visible := True;
      end;

      If Pos('ReviewPeriod',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('=',Strings[I])+1,Length(Strings[I]));
       MaskEdit2.Text := Trim(FieldData);

       if MaskEdit2.EditText = '0.04' then
         nPos := 1
       else
         if MaskEdit2.EditText = '0.25' then
           nPos := 2
         else
           if MaskEdit2.EditText = '0.50' then
             nPos := 3
           else
             if MaskEdit2.EditText = '1.00' then
               nPos := 4
             Else
               nPos := 5;


        ComboBox1.ItemIndex := nPos;

        MaskEdit2.Visible := (nPos = 5);

      end;

      If Pos('ServiceLevel',Strings[I]) > 0 then
      begin
        FieldData := Copy(Strings[i],Pos('=',Strings[I])+1,Length(Strings[I]));
        MaskEdit6.Text := Trim(FieldData);
        ComboBox5.ItemIndex := 1;
        MaskEdit6.Visible := True;
        Label6.Visible := True;
      end;

      If Pos('MinimumOrderQuantity',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('=',Strings[I])+1,Length(Strings[I]));
       edtMin.Text := Trim(FieldData);
       CheckBox5.Checked := True;
      end;

      If Pos('OrderMultiples',Strings[I]) > 0 then
      begin
       FieldData := Copy(Strings[i],Pos('=',Strings[I])+1,Length(Strings[I]));
       edtMult.Text := Trim(FieldData);
       CheckBox5.Checked := True;
      end;

      //Locations -------------------------------------
      If Pos('LocationNo in',Strings[I]) > 0 then
      begin
        FieldData := Copy(Strings[i],Pos(#40,Strings[I])+1,Length(Strings[I]));
        cLocNum := '';

        While Length(FieldData) > 0 do
        begin
          cChar := Copy(FieldData,1,1);

          if (cChar = ',') or (cChar = #41) then
          begin

          if cLocNum <> '' then
            LocList.Add(Trim(cLocNum));

            cLocNum := '';
          end
          else
            cLocNum := cLocNum + cChar;

          FieldData := Copy(FieldData,2,Length(FieldData));


        end;

        //Now build up the list boxes


        for nPos := 0 to (LocList.Count - 1) do
        begin
          LocNum := ListBox3.Items.IndexOf(LocList.Strings[nPos]);
          ListBox2.Items.Add(ListBox1.Items.Strings[LocNum]);
          ListBox4.Items.Add(ListBox3.Items.Strings[LocNum]);
        end;

        for nPos := (LocList.Count - 1) downto 0 do
        begin
          LocNum := ListBox3.Items.IndexOf(LocList.Strings[nPos]);
          ListBox1.Items.delete(LocNum);
          ListBox3.Items.delete(LocNum);
        end;


      end; // End Locations

      if GroupData or (Pos('AND '#40,Strings[I]) > 0) then
      begin
        GroupData := True;

        if not ((Length(Strings[I]) = 2) and (Pos(' '#41,Strings[I]) > 0)) then
          SQLGroup.Add(Strings[I]);
      end;

    end; // End For

    end; // End With

  except
    MessageDlg('Some or All of the SQL settings were NOT loaded'+#10+
               ' into the Data Tab',mtError,[mbOk],0);
  end;

end;


procedure TForm1.LoadSQL1Click(Sender: TObject);
begin
  BitBtn6Click(nil);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.About3Click(Sender: TObject);
begin
  frmAbout.ShowModal;

end;

procedure TForm1.BitBtn20Click(Sender: TObject);
var
  Save_Cursor:TCursor;
begin

   if MessageDlg('Clear All Products in the List?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
   begin
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crSQLWait;

    try

      lstProd.Items.Clear;
      
    finally
        Screen.Cursor := Save_Cursor;
    end;

  end;




end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  lstProd.ItemIndex := 0;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  lstProd.ItemIndex := lstProd.Items.Count - 1;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if lstProd.ItemIndex > 0 then
    lstProd.ItemIndex := lstProd.ItemIndex - 1;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  if lstProd.ItemIndex < lstProd.Items.Count -1 then
    lstProd.ItemIndex := lstProd.ItemIndex + 1;

end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
var
  RecPos: Integer;
begin
  if lstProd.ItemIndex > -1 then
  begin

    if MessageDlg('Delete Record ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      RecPos := lstProd.ItemIndex;

      if RecPos = lstProd.Items.Count -1 then
       Dec(RecPos);
       
      lstProd.Items.Delete(lstProd.ItemIndex);

      if RecPos <= lstProd.Items.Count -1 then
        lstProd.ItemIndex := RecPos;
    end;

  end;

end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  if frmAddRec.ShowModal = mrOK then
  begin
    lstProd.Items.Add(frmaddRec.Edit1.text);
    lstProd.ItemIndex := lstProd.items.Count-1;
  end;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
  lstProd.Items.SaveToFile('ProdList.txt');
  MessageDlg('Product List Saved to: Prodlist.txt',mtInformation,[mbOK],0);
end;

procedure TForm1.lstProdDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Source is TDBGrid then
    Accept := True
  else
    Accept := False;
    

end;

procedure TForm1.lstProdDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  cProdCode: String;
begin

  try
    cProdCode := dmUpdateSpecial.srcSearchProd.DataSet.FieldByName('ProductCode').AsString;
    lstProd.Items.Add(cProdCode);
    lstProd.ItemIndex := lstProd.items.Count-1;
  except
    MessageDlg('No Products in search list to add.'+#10+'Click on the Find button to search',mtError,[mbOk],0);
  end;


end;

procedure TForm1.DBGrid2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft)  then
    with Sender as TDBGrid do
    begin
      if SelectedRows.Count > 0 then
        BeginDrag(False);
    end;

end;

procedure TForm1.DBGrid2DblClick(Sender: TObject);
begin
  BitBtn4Click(nil);
end;

procedure TForm1.Version1Click(Sender: TObject);
begin
BitBtn9Click(nil);
end;

procedure TForm1.BitBtn21Click(Sender: TObject);
var
  Save_Cursor:TCursor;
  Success: Boolean;
begin

    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crSQLWait;

    try

      if dmUpdateSpecial.OpenToUpdate(Memo1.Lines) then
        frmProducts.ShowModal;

    finally
        Screen.Cursor := Save_Cursor;
    end;


end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  edtBinLevel.Enabled := not edtBinLevel.Enabled;
end;

procedure TForm1.ComboBox6Change(Sender: TObject);
begin
 MaskEdit4.Visible := (ComboBox6.ItemIndex = 1);
end;

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
  SpinEdit1.Enabled := not SpinEdit1.Enabled;

end;

end.
