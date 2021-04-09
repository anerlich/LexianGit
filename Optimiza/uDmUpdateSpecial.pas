unit uDmUpdateSpecial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UDMOPTIMIZA, Db, IBCustomDataSet, IBDatabase, IBStoredProc, IBQuery,
  IBSQL;

type
  TdmUpdateSpecial = class(TdmOptimiza)
    qryAllLocations: TIBQuery;
    srcAllLocations: TDataSource;
    qrySearchProd: TIBQuery;
    srcSearchProd: TDataSource;
    qryUpdateItem: TIBQuery;
    qryProducts: TIBQuery;
    srcProducts: TDataSource;
    qrySuppliers: TIBQuery;
    srcSuppliers: TDataSource;
    qryGroupMajor: TIBQuery;
    qryGroupMinor1: TIBQuery;
    qryGroupMinor2: TIBQuery;
    srcGroupMajor: TDataSource;
    srcGroupMinor1: TDataSource;
    srcGroupMinor2: TDataSource;
    qryUserFields: TIBQuery;
    srcUserFields: TDataSource;
    qryToUpdate: TIBQuery;
    srcToUpdate: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenSearchProd(KeyData: String);
    procedure InsertProd;
    procedure OpenGroups;
    procedure CloseGroups;
    procedure UpdateByProd(SQLUpdate,SQLLoc:TStringList;ProdList:TStrings);
    procedure UpdateByGroup(SQLUpdateStr:TStrings);
    function GetUserFields: TStringList;
    function GetUserCharNames: TStringList;
    function GetConfigAsString(ConfigNo: Integer): String;
    function GetConfigAsInteger(ConfigNo: Integer): Integer;
    procedure ClearDbf;
    procedure OpenAllLocations;
    function OpenToUpdate(SQLUpdateStr:TStrings):Boolean;

  end;

var
  dmUpdateSpecial: TdmUpdateSpecial;

implementation

uses uStatus;

{$R *.DFM}

procedure TdmUpdateSpecial.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryAllLocations.Open;

end;

procedure TdmUpdateSpecial.OpenSearchProd(KeyData: String);
var
  cSql: String;
begin
  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  With qrySearchProd do
  begin
    qrySearchProd.Active := False;
    cSql := 'Select ProductCode, ProductDescription From Product where ProductCode >= "'+KeyData+'" Order by ProductCode';
    qrySearchProd.SQL.Clear;
    qrySearchProd.SQL.Add(cSql);
    qrySearchProd.Active := True;
  end;

end;

procedure TdmUpdateSpecial.InsertProd;
var
  cProdCode: String;
begin

  try
    cProdCode := srcSearchProd.DataSet.FieldByName('ProductCode').AsString;

//    with srcProdList.DataSet do
 //   begin
 //
  //    Insert;
    //  FieldByName('PRODCODE').AsString := cProdCode;
      //Post;

    //end;

  except
    MessageDlg('No Products in search list to add.'+#10+'Click on the Find button to search',mtError,[mbOk],0);
  end;


end;

procedure TdmUpdateSpecial.UpdateByProd(SQLUpdate,SQLLoc:TStringList;ProdList:TStrings);
var
 cSetSql, cLocs, cSql, cLocDsc,cProd: String;
 I, ProdCount, ProdNo: Integer;
begin
  frmStatus.ListBox1.Items.Clear;
  frmStatus.ListBox1.Items.Add('Running SQL: ');

  cSetSql := 'Update Item Set ';
  frmStatus.ListBox1.Items.Add(cSetSql);

  for I := 1 to SQLUpdate.Count - 1 do
  begin
    cSetSql := cSetSql + SQLUpdate.Strings[I];
    frmStatus.ListBox1.Items.Add(SQLUpdate.Strings[I]);
  end;

  cLocs := ' where ';
  frmStatus.ListBox1.Items.Add(cLocs);

  for I := 1 to SQLLoc.Count - 1 do
  begin
    cLocs := cLocs + SQLLoc.Strings[I];
    frmStatus.ListBox1.Items.Add(SQLLoc.Strings[I]);
  end;


  frmStatus.Show;
  frmStatus.Refresh;

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  //srcProdList.DataSet.First;
  I := 0;

  qryUpdateItem.Close;
  qryUpdateItem.SQL.Clear;
  cSql := cSetSql + cLocs + ' and ProductNo = :ProdNo';
  qryUpdateItem.SQL.Add(cSQl);
  frmStatus.ListBox1.Items.Add(cSql);

  for ProdCount := 0 to ProdList.Count - 1 do
  begin
    cProd := Trim(ProdList.Strings[ProdCount]);
    cProd := 'Select ProductNo From Product Where ProductCode = "'+cProd+'"';
    qryProducts.Close;
    qryProducts.SQL.Clear;
    qryProducts.SQL.Add(cProd);

    Try
      qryProducts.Open;
      ProdNo := srcProducts.DataSet.FieldByName('ProductNo').asInteger;

      If ProdNo > 0 then
      begin
        //cSql := cSetSql + cLocs + ' and ProductNo = '+IntToStr(ProdNo);
        //frmStatus.ListBox1.Items.Add(cSql);
        //qryUpdateItem.Close;
        //qryUpdateItem.SQL.Clear;
        //qryUpdateItem.SQL.Add(cSQl);
        //qryUpdateItem.Prepare;
        qryUpdateItem.ParamByName('ProdNo').AsInteger := ProdNo;
        qryUpdateItem.ExecSQL;


        Inc(I);
      end
      else
        frmStatus.ListBox1.Items.Add('Product Not Found: '+ProdList.Strings[ProdCount]);


    except

    end;


    If I mod 10 = 0 then
    begin
      frmStatus.StatusBar1.Panels[1].Text := IntToStr(I);
      Application.ProcessMessages;
    end;
  end;

   qryProducts.Close;

   trnOptimiza.Commit;
   frmStatus.ListBox1.Items.Add('');
   frmStatus.ListBox1.Items.Add('');
   frmStatus.ListBox1.Items.Add(IntToStr(I)+' Products were updated');
   frmStatus.ListBox1.Items.Add('Done !!');
   frmStatus.ListBox1.Items.Add(DateToStr(Date())+' '+TimeToStr(Time()));
   frmStatus.StatusBar1.Panels[1].Text := IntToStr(I);
   frmStatus.StatusBar1.Refresh;
   frmStatus.ListBox1.Items.SaveToFile('UpdateSpecial.log');
   MessageDlg('Done !',mtInformation,[mbOk],0);

end;

procedure TdmUpdateSpecial.UpdateByGroup(SQLUpdateStr:TStrings);
begin
  frmStatus.ListBox1.Items.Clear;
  frmStatus.ListBox1.Items.AddStrings(SQLUpdateStr);

  frmStatus.Show;
  frmStatus.Refresh;

  if not trnOptimiza.InTransaction then
    trnOptimiza.StartTransaction;

  qryUpdateItem.Close;
  qryUpdateItem.SQL.Clear;
  qryUpdateItem.SQL.AddStrings(SQLUpdateStr);
  qryUpdateItem.Prepare;
  qryUpdateItem.ExecSQL;


   trnOptimiza.Commit;
   frmStatus.ListBox1.Items.Add('');
   frmStatus.ListBox1.Items.Add('');
   frmStatus.ListBox1.Items.Add('Done !!');
   frmStatus.ListBox1.Items.Add(DateToStr(Date())+' '+TimeToStr(Time()));
   frmStatus.StatusBar1.Refresh;
   frmStatus.ListBox1.Items.SaveToFile('UpdateSpecial.log');
   MessageDlg('Done !',mtInformation,[mbOk],0);

end;

procedure TdmUpdateSpecial.OpenGroups;
begin
  qrySuppliers.Open;
  qryGroupMajor.Open;
  qryGroupMinor1.Open;
  qryGroupMinor2.Open;
end;

procedure TdmUpdateSpecial.CloseGroups;
begin
  qrySuppliers.Close;
  qryGroupMajor.Close;
  qryGroupMinor1.Close;
  qryGroupMinor2.Close;
end;


function TdmUpdateSpecial.GetUserFields:TStringList;
var
  UserFields: TStringList;
  NumFields, FldCount, Count: Integer;
  FieldDesc: String;
begin
  UserFields := TStringList.Create;

  qryUserFields.Open;

  with srcUserFields.DataSet do
  begin
    First;

    for Count := 1 to 4 do
    begin
      //Get number og user fields for data type
      NumFields := FieldByName('TypeOfInteger').AsInteger;
      FldCount := 0;

      Case Count of
        1: FieldDesc := 'UserDouble';
        2: FieldDesc := 'UserChar';
        3: FieldDesc := 'UserDate';
        4: FieldDesc := 'UserInteger';
      end;

      Next; //Skip past the count


      While FldCount < 5 do   //Max of 5 user fields per data type
      begin

        If FldCount < NumFields then // only add relevant ones
        begin
          UserFields.Add(FieldByName('TypeOfString').AsString+'('+
                         FieldDesc+IntToStr(FldCount+1)+')');
        end;

        Inc(FldCount);
        Next;

      end; //While

    end; // For

  end; //With

  qryUserFields.Close;

  Result := UserFields;
end;


function TdmUpdateSpecial.GetUserCharNames:TStringList;
var
  UserCharNames: TStringList;
  NumFields, FldCount, Count: Integer;
  FieldDesc: String;
begin
  UserCharNames := TStringList.Create;

  NumFields := GetConfigAsInteger(214);

  count := 1;
  while (count <= NumFields) do
  begin
    if (count <= 5) then
    begin
      UserCharNames.Add(GetConfigAsString(214+count));
    end
    else
    begin
      UserCharNames.Add(GetConfigAsString((438-6)+count));
    end;
    count := count + 1;
  end;

  Result := UserCharNames;
end;

function TdmUpdateSpecial.GetConfigAsString(ConfigNo: Integer): String;
begin

  Result := '';

  with qryGetConfiguration do
  begin
    ParamByName('ConfigurationNo').AsInteger := ConfigNo;
    Open;

    if FieldByName('ConfigurationNo').AsInteger > 0 then
      Result := FieldByName('TypeOfString').AsString;

    Close;
  end;

end;

function TdmUpdateSpecial.GetConfigAsInteger(ConfigNo: Integer): Integer;
begin

  Result := -1;

  with qryGetConfiguration do
  begin
    ParamByName('ConfigurationNo').AsInteger := ConfigNo;
    Open;

    if FieldByName('ConfigurationNo').AsInteger > 0 then
      Result := FieldByName('TypeOfInteger').AsInteger;

    Close;
  end;

end;

procedure TdmUpdateSpecial.ClearDbf;
begin
end;
procedure TdmUpdateSpecial.OpenAllLocations;
begin
  qryAllLocations.Close;
  qryAllLocations.Open;
End;

function TdmUpdateSpecial.OpenToUpdate(SQLUpdateStr:TStrings):Boolean;
var
  SCount:Integer;
  AddIt: Boolean;
begin

  qryToUpdate.Close;

  with qryToUpdate.SQL do
  begin
    Clear;
    Add('Select l.locationcode ,p.ProductCode ,s.suppliercode');
    Add(',mj.Groupcode as MajorGroup ,m1.GroupCode as MinorGroup1');
    Add(',m2.GroupCode as MinorGroup2 ,i.ParetoCategory, i.Criticality');
    Add(',i.StockingIndicator ,i.LeadTimeCategory ,i.ManualPolicy');
    Add(',i.ManualForecast, i.LeadTime, i.ReplenishmentCycle');
    Add(',i.ServiceLevel ,i.ReviewPeriod ,i.MinimumOrderQuantity');
    Add(',i.OrderMultiples');
    Add('from item i left outer join Product P on i.ProductNo = P.ProductNo');
    Add('left outer join Location L on i.LocationNo = L.LocationNo');
    Add('left outer join Supplier S on i.Supplierno1 = S.SupplierNo');
    Add('left outer join GroupMajor mj on i.GroupMajor = mj.GroupNo');
    Add('left outer join GroupMinor1 m1 on i.GroupMinor1 = m1.GroupNo');
    Add('left outer join GroupMinor2 m2 on i.GroupMinor2 = m2.GroupNo');

    AddIt := False;

    For SCount :=  0 to SQLUpdateStr.Count - 1 do
    begin
      if Pos('WHERE',UpperCase(SQLUpdateStr.Strings[SCount])) > 0 then
        AddIt := True;

      If AddIt then
        Add(SQLUpdateStr.Strings[SCount]);

    end;


  end;

  Result := True;

  try
    qryToUpdate.Prepare;
    qryToUpdate.Open;
  except
     on E: Exception do
     begin
       MessageDlg(E.Message,mtError,[mbOK],0);

       frmStatus.ListBox1.Items.Clear;
       frmStatus.ListBox1.Items.AddStrings(qryToUpdate.SQL);
       frmStatus.Show;
       frmStatus.Refresh;
       Result := False;
     end;
  end;


end;



end.
