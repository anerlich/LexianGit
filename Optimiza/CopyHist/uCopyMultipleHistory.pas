// Ver 1.0 - Updated to add optional copying of FC history and some item table field
// Ver 1.1 - Remove log file for Actrol as users don't have write access to Optimiza server.

unit uCopyMultipleHistory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, DBCtrls, CheckLst, Buttons, ExtCtrls, Grids, DBGrids,
  MyDBGrid, db, Spin, strUtils;

type
  TfrmCopySalesHist = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btnDeleteProductCodeLine: TBitBtn;
    grdFromToProductCodes: TStringGrid;
    btnAddProductCodeLine: TBitBtn;
    Panel2: TPanel;
    btnCopy: TBitBtn;
    btnCancel: TBitBtn;
    grdProductCodes: TMyDBGrid;
    dbnProductCodes: TDBNavigator;
    edtProductCode: TEdit;
    btnFind: TBitBtn;
    btnHelp: TBitBtn;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    cbCopySales: TCheckBox;
    Shape1: TShape;
    rgSalesAdd: TRadioGroup;
    rgSalesReplaceAdd: TRadioGroup;
    gbSalesMthFromTo: TGroupBox;
    Label2: TLabel;
    cbSalesStartMth: TComboBox;
    cbSalesBacktoMth: TComboBox;
    gbSalesMonths: TGroupBox;
    seSalesMths: TSpinEdit;
    GroupBox4: TGroupBox;
    Shape2: TShape;
    cbCopyForecast: TCheckBox;
    rgFC_Add: TRadioGroup;
    rgFC_ReplaceAdd: TRadioGroup;
    gbFC_MthFromTo: TGroupBox;
    Label4: TLabel;
    cbFC_StartMth: TComboBox;
    cbFC_ForwardToMth: TComboBox;
    gbFC_Months: TGroupBox;
    seFC_Mths: TSpinEdit;
    GroupBox7: TGroupBox;
    cbPareto: TCheckBox;
    cbStockingIndicator: TCheckBox;
    cbCriticality: TCheckBox;
    cbBinLevel: TCheckBox;
    cbMOQ: TCheckBox;
    cbSupplier: TCheckBox;
    Label5: TLabel;
    clbLocations: TCheckListBox;
    btnAllFrom: TButton;
    btnClearFrom: TButton;
    procedure OpenLogFile(Fname:String);
    procedure CloseLogFile;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddProductCodeLineClick(Sender: TObject);
    procedure btnDeleteProductCodeLineClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure edtProductCodeExit(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure grdFromToProductCodesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure grdFromToProductCodesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure grdProductCodesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnHelpClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure rgSalesReplaceAddClick(Sender: TObject);
    procedure cbSalesStartMthChange(Sender: TObject);
    procedure seSalesMthsChange(Sender: TObject);
    procedure clbLocationsClickCheck(Sender: TObject);
    procedure ToggleAllOnOff(ToggleOn: Boolean);
    procedure btnAllFromClick(Sender: TObject);
    procedure btnClearFromClick(Sender: TObject);
    procedure cbCopySalesClick(Sender: TObject);
    procedure cbCopyForecastClick(Sender: TObject);
    procedure rgFC_ReplaceAddClick(Sender: TObject);
    procedure seFC_MthsChange(Sender: TObject);
    procedure cbFC_StartMthChange(Sender: TObject);
    procedure edtProductCodeKeyPress(Sender: TObject; var Key: Char);
    procedure Say(Line : string);
    function GetLogFileName:String;
    function ReadConfigLongStr(ConfigNo : integer) : string;
  private
    { Private declarations }
    FirstShow:Boolean;
    procedure CalcEndMonth;
    procedure CalcFC_EndMonth;

  public
    //LogFile : TextFile;
    { Public declarations }
  end;

var
  frmCopySalesHist: TfrmCopySalesHist;
  _Lastcb: integer;


implementation

uses uDmCopySalesHist, uStatus, uHelp, uDmOptimiza;

{$R *.DFM}

procedure TfrmCopySalesHist.CloseLogFile;
begin
  //CloseFile(LogFile);
end;

procedure TfrmCopySalesHist.OpenLogFile(Fname: String);
var
  Year,Month,Day:Word;
  FCount:Integer;
begin

  //FName := GetLogFileName;

  //AssignFile(LogFile,FName );
  //Rewrite(LogFile);

end;


procedure TfrmCopySalesHist.Say(Line : string);
begin
  //WriteLn(LogFile, Line);
  //flush(LogFile);
  Application.ProcessMessages;
end;

procedure TfrmCopySalesHist.FormShow(Sender: TObject);
begin

  if FirstShow then
  begin

    _Lastcb := -1;

    StatusBar1.Panels[1].Text := dmCopySalesHist.dbOptimiza.DatabaseName;


    clbLocations.Items.Clear;
    with dmCopySalesHist.srcAllLocations.DataSet do
    begin
      First;
      while not eof do
      begin
        clbLocations.Items.Add(FieldByName('LocationCode').AsString + ' - ' + FieldByName('Description').AsString);
        next;
      end;
      first;
    end;

  end;

  PageControl1.ActivePage := TabSheet1;

  grdFromToProductCodes.Cells[0,0] := 'Source';
  grdFromToProductCodes.Cells[1,0] := 'Target';


end;

procedure TfrmCopySalesHist.FormCreate(Sender: TObject);
begin
  if not FirstShow then
  begin
    FirstShow := True;
  end;
end;

procedure TfrmCopySalesHist.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCopySalesHist.btnAddProductCodeLineClick(Sender: TObject);
begin
  grdFromToProductCodes.RowCount := grdFromToProductCodes.RowCount + 1;

end;

procedure TfrmCopySalesHist.btnDeleteProductCodeLineClick(Sender: TObject);
var
  DeleteRow, Count: Integer;
begin
  DeleteRow := grdFromToProductCodes.Row;

  If DeleteRow > 0 then
  begin
    grdFromToProductCodes.Cells[0,DeleteRow] := '';
    grdFromToProductCodes.Cells[1,DeleteRow] := '';
  end;

  if grdFromToProductCodes.RowCount  > 2 then
  begin
    For Count := DeleteRow to grdFromToProductCodes.RowCount do
    begin
      grdFromToProductCodes.Rows[Count] := grdFromToProductCodes.Rows[Count+1];
    end;

    grdFromToProductCodes.RowCount := grdFromToProductCodes.RowCount -1;
  end;

end;

procedure TfrmCopySalesHist.btnCopyClick(Sender: TObject);
var
  CountItem, CountLoc, UpdCnt: Integer;
  LocList: TStringList;
  LocCode,ReplaceInd: String;
  StartTime:TDateTime;
  FName:String;

begin
  
  LocList := TStringList.Create;

  for CountItem := 0 to clbLocations.Items.Count -1 do
  begin
     if clbLocations.Checked[CountItem] then
     begin
       LocCode := Trim(Copy(clbLocations.Items.Strings[CountItem],1,Pos('-',clbLocations.Items.Strings[CountItem])-1));

       LocList.Add(LocCode);

     end;
  end;

  If (LocList.Count = 0) then
  begin
    MessageDlg('You must select at least one location!',mtError,[mbOK],0);
    pageControl1.ActivePageIndex := 0;
    exit;
  end;

  if (not cbCopySales.Checked) and  (not cbCopyForecast.Checked)
    and (not cbPareto.Checked) and (not cbStockingIndicator.Checked)
    and (not cbCriticality.Checked) and (not cbBinLevel.Checked)
    and (not cbMOQ.Checked) and (not cbSupplier.Checked) then
  begin
    MessageDlg('You have not selected any Sales, Forecast or Item details to be copied!',mtError,[mbOK],0);
    pageControl1.ActivePageIndex := 0;
    exit;
  end;

  OpenLogFile('');

  StartTime := Now;
  Say(FName+'Started on ' + DateTimeToStr(StartTime));
  Say(' ');
  Say('============================================================================================');

  dmCopySalesHist.UpdateItemProc();

  UpdCnt := 0;
  for CountLoc := 0 to LocList.Count -1 do
  begin


    for CountItem := 1 to grdFromToProductCodes.RowCount -1 do
    begin

     if dmCopySalesHist.CheckTarget(LocList.Strings[CountLoc],grdFromToProductCodes.Cells[0,CountItem]) then
     begin

       if dmCopySalesHist.CheckTarget(LocList.Strings[CountLoc],grdFromToProductCodes.Cells[1,CountItem])then
       begin
         {ReplaceInd := 'R';

         if rgSalesAdd.ItemIndex = 1 then
           ReplaceInd := 'A';

         if rgSalesReplaceAdd.ItemIndex = 0 then
         begin
           dmCopySalesHist.UpdateSale(LocList.Strings[CountLoc],
                                     LocList.Strings[CountLoc],
                                     grdFromToProductCodes.Cells[0,CountItem],
                                     grdFromToProductCodes.Cells[1,CountItem],ReplaceInd,False);
         end
         else
         begin
           dmCopySalesHist.UpdateSale(LocList.Strings[CountLoc],
                                     LocList.Strings[CountLoc],
                                     grdFromToProductCodes.Cells[0,CountItem],
                                     grdFromToProductCodes.Cells[1,CountItem],ReplaceInd,True);

         end; }
          dmCopySalesHist.UpdateItemDetails(LocList.Strings[CountLoc],
                                     LocList.Strings[CountLoc],
                                     grdFromToProductCodes.Cells[0,CountItem],
                                     grdFromToProductCodes.Cells[1,CountItem]);
          UpdCnt := UpdCnt +1;

       end;

     end;

    end;

  end;

  if (LocList.Count > 0) and (UpdCnt > 0) then
    dmCopySalesHist.CommitSale
  else
  begin
    frmStatus.ListBox1.Items.Add('No Details were Copied !');
    Say('    No Details were Copied !');
    pageControl1.ActivePageIndex := 1;
  end;

  Say(' ');
  Say('============================================================================================');
  Say(' ');

  Say(FName+'Finished on ' + DateTimeToStr(Now));
  Say(Format('Elapsed Time: %.2f seconds', [(Now - StartTime) * 86400]));

  //CloseFile(LogFile);

  LocList.Free;
  frmStatus.Show;

end;

procedure TfrmCopySalesHist.edtProductCodeExit(Sender: TObject);
begin
  edtProductCode.text := UpperCase(edtProductCode.text);
end;

procedure TfrmCopySalesHist.btnFindClick(Sender: TObject);
begin
  DmCopySalesHist.OpenSearchProd(edtProductCode.text);
end;

procedure TfrmCopySalesHist.grdFromToProductCodesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := True;
end;

procedure TfrmCopySalesHist.grdFromToProductCodesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  MCord: TGridCoord;
  StringRow, StringCol: Integer;
begin
  //Get Cell under mouse pointer
  MCord := grdFromToProductCodes.MouseCoord(X,Y);

  //if co-ordinates are outside the range then
  // use physical x,y to detemine which column to add
  //  new record
  if (MCord.x < 0) or (MCord.Y < 1) then
  begin
    if  x < 102 then
    begin
      StringCol := 0;
    end
    else
    begin
      StringCol := 1;
    end;

    if grdFromToProductCodes.Cells[StringCol,grdFromToProductCodes.RowCount-1] <> '' then
    begin
        grdFromToProductCodes.RowCount := grdFromToProductCodes.RowCount + 1;       
    end;

    StringRow := grdFromToProductCodes.RowCount - 1;

  end
  else
  begin
    StringRow := MCord.Y;
    StringCol := MCord.X;
  end;

  try
    grdFromToProductCodes.Cells[StringCol, StringRow] := grdProductCodes.DataSource.DataSet.FieldByName('ProductCode').AsString;
  except
    MessageDlg('Invalid Product Code',mtError,[mbOK],0);
  end;


end;

procedure TfrmCopySalesHist.grdProductCodesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Getx, Gety: Integer;
begin
  Getx := x;
  Gety := y;
  grdProductCodes.BeginDrag(False,10);
end;

procedure TfrmCopySalesHist.btnHelpClick(Sender: TObject);
begin
  frmHelp.ShowModal;
end;

procedure TfrmCopySalesHist.FormActivate(Sender: TObject);
begin
  //if not dmCopySalesHist.CheckProcedure then
  //  Close;

  if FirstShow then
  begin
    FirstShow := False;
    Caption := 'Copy Product details to Multiple Locations (Ver'+DmOptimiza.kfVersionInfo+') ';

    cbSalesStartMth.Items.Clear;
    cbSalesBacktoMth.Items.Clear;
    dmCopySalesHist.openPeriod;

    With dmCopySalesHist.srcPeriod.DataSet do
    begin
      First;

      While not Eof do
      begin
        cbSalesStartMth.Items.Add(FieldbyName('Description').asString);
        Next;
      end;

      Close;

      cbSalesStartMth.Text := cbSalesStartMth.Items.Strings[0];
      cbSalesStartMth.ItemIndex := 0;

    end;

    cbSalesBacktoMth.Items.AddStrings(cbSalesStartMth.Items);

    CalcEndMonth;

    cbFC_StartMth.Items.Clear;
    cbFC_ForwardToMth.Items.Clear;
    dmCopySalesHist.openFC_Period;

    With dmCopySalesHist.srcPeriod.DataSet do
    begin
      First;

      While not Eof do
      begin
        cbFC_StartMth.Items.Add(FieldbyName('Description').asString);
        Next;
      end;

      Close;

      cbFC_StartMth.Text := cbFC_StartMth.Items.Strings[0];
      cbFC_StartMth.ItemIndex := 0;

    end;

    cbFC_ForwardToMth.Items.AddStrings(cbFC_StartMth.Items);

    CalcFC_EndMonth;
  end;

end;

procedure TfrmCopySalesHist.rgSalesReplaceAddClick(Sender: TObject);
begin
  if rgSalesReplaceAdd.ItemIndex = 0 then
  begin
    cbSalesStartMth.Enabled := False;
    seSalesMths.Enabled := False;
  end
  else
  begin
    cbSalesStartMth.Enabled := True;
    seSalesMths.Enabled := True;
  end;

end;

procedure TfrmCopySalesHist.CalcEndMonth;
var
  offset,Mult:Integer;
begin

  Offset := seSalesMths.Value-1;
  Offset := Offset + cbSalesStartMth.itemIndex;

  if Offset < cbSalesBacktoMth.Items.Count then cbSalesBacktoMth.ItemIndex := offset
  else
  begin
    cbSalesBacktoMth.ItemIndex := cbSalesBacktoMth.Items.Count - 1;
  end;
  seSalesMths.Value := cbSalesBacktoMth.itemIndex - cbSalesStartMth.ItemIndex + 1
end;

procedure TfrmCopySalesHist.cbSalesStartMthChange(Sender: TObject);
begin
  CalcEndMonth;

end;

procedure TfrmCopySalesHist.seSalesMthsChange(Sender: TObject);
begin
  CalcEndMonth;
end;






procedure TfrmCopySalesHist.clbLocationsClickCheck(Sender: TObject);
var i, xx : integer;
begin
  //xx := -1;
  //for i := 0 to clbLocations.Items.Count - 1 do
  //if clbLocations.Checked[i] then
  //begin
  //  if  i = _Lastcb then
  //  begin
  //    clbLocations.Checked[i] := false;
  //  end
  //  else
  //  begin
    //ShowMessage('Selected: ' + clbLocations.Items[i]);
  //  xx := i;
  //  end;
  //end;

  //_Lastcb := xx;

end;

procedure TfrmCopySalesHist.ToggleAllOnOff(ToggleOn: boolean);
var
  CCount:Integer;
begin
    for CCount := 0 to clbLocations.Count - 1 do
    begin
      clbLocations .Checked[cCount] := ToggleOn;
    end;

end;

procedure TfrmCopySalesHist.btnAllFromClick(Sender: TObject);
begin
  ToggleAllOnOff(True);
end;

procedure TfrmCopySalesHist.btnClearFromClick(Sender: TObject);
begin
  ToggleAllOnOff(False);

end;

procedure TfrmCopySalesHist.cbCopySalesClick(Sender: TObject);
begin
  if cbCopySales.Checked then
  begin
    rgSalesAdd.Enabled := true;
    rgSalesReplaceAdd.Enabled := true;
    gbSalesMonths.Enabled := true;
    gbSalesMthFromTo.Enabled := true;
  end
  else
  begin
    rgSalesAdd.Enabled := false;
    rgSalesReplaceAdd.Enabled := false;
    gbSalesMonths.Enabled := false;
    gbSalesMthFromTo.Enabled := false;
  end;
end;

procedure TfrmCopySalesHist.cbCopyForecastClick(Sender: TObject);
begin
  if cbCopyForecast.Checked then
  begin
    rgFC_Add.Enabled := true;
    rgFC_ReplaceAdd.Enabled := true;
    gbFC_Months.Enabled := true;
    gbFC_MthFromTo.Enabled := true;
  end
  else
  begin
    rgFC_Add.Enabled := false;
    rgFC_ReplaceAdd.Enabled := false;
    gbFC_Months.Enabled := false;
    gbFC_MthFromTo.Enabled := false;
  end;
end;


procedure TfrmCopySalesHist.rgFC_ReplaceAddClick(Sender: TObject);
begin
  if rgFC_ReplaceAdd.ItemIndex = 0 then
  begin
    cbFC_StartMth.Enabled := False;
    seFC_Mths.Enabled := False;
  end
  else
  begin
    cbFC_StartMth.Enabled := True;
    seFC_Mths.Enabled := True;
  end;

end;

procedure TfrmCopySalesHist.seFC_MthsChange(Sender: TObject);
begin
  CalcFC_EndMonth;
end;

procedure TfrmCopySalesHist.cbFC_StartMthChange(Sender: TObject);
begin
  CalcFC_EndMonth;
end;

procedure TfrmCopySalesHist.CalcFC_EndMonth;
var
  offset,Mult:Integer;
begin

  Offset := seFC_Mths.Value-1;
  Offset := Offset + cbFC_StartMth.itemIndex;

  cbFC_ForwardToMth.ItemIndex := offset;

  if Offset < cbFC_ForwardtoMth.Items.Count then cbFC_ForwardtoMth.ItemIndex := offset
  else
  begin
    cbFC_ForwardtoMth.ItemIndex := cbFC_ForwardtoMth.Items.Count - 1;
  end;
  seFC_Mths.Value := cbFC_ForwardtoMth.itemIndex - cbFC_StartMth.ItemIndex + 1
end;

procedure TfrmCopySalesHist.edtProductCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    edtProductCode.text := UpperCase(edtProductCode.text);
    DmCopySalesHist.OpenSearchProd(edtProductCode.text);
  end;
end;

function TfrmCopySalesHist.GetLogFileName: String;
var
  Year,Month,Day:Word;
  FCount:Integer;
  aFileName, aFilePath:String;
  MonthStr,DayStr,LogPath:String;
begin

  aFileName := ExtractFileName(ParamStr(0));
  aFileName := AnsiReplaceStr(aFileName,'.exe','');

  //see if parameter is setup
  aFilePath := Trim(ReadConfigLongStr(286));

  //if not then use the exe path
  if aFilePath = '' then
    aFilePath := Trim(ExtractFilePath(ParamStr(0)));

  if RightStr(aFilePath,1) <> '\' then AFilePath := aFilePath + '\';

  DecodeDate(Now, Year, Month, Day);
  MonthStr := RightStr('0'+IntToStr(Month),2); //Pad with 0
  DayStr := RightStr('0'+IntToStr(Day),2);

  aFileName := aFilePath+Format('%d%s%s '+aFileName+'.log', [Year, Monthstr, DayStr]);

  //if all 100 files exist then we will use 100
  for FCount := 1 to 100 do
  begin

    If FileExists(aFileName) then
    begin

      if FCount = 1 then
        aFileName := AnsiReplaceStr(aFileName,'.log',IntToStr(FCount)+'.log')
      else
        aFileName := AnsiReplaceStr(aFileName,IntToStr(FCount-1)+'.log',IntToStr(FCount)+'.log');


    end
    else
      Break;

  end;

  Result := aFileName;

end;

function TfrmCopySalesHist.ReadConfigLongStr(
  ConfigNo: integer): string;
var
  InTrans : boolean;
begin

  InTrans := dmCopySalesHist.trnOptimiza.InTransaction;
  if not InTrans then
    dmCopySalesHist.trnOptimiza.StartTransaction;
  try
    with dmCopySalesHist.ReadConfig do begin
      Close;
      Params.ByName('CONFIGURATIONNO').AsInteger := ConfigNo;
      ExecQuery;
    end;
    Result := dmCopySalesHist.ReadConfig.FieldByName('TYPEOFLONGSTRING').AsString;
  finally
    if not InTrans then
      dmCopySalesHist.trnOptimiza.Commit;
  end;

end;

end.
