// 1.1 Add NZ locations
// 1.2 Add processing for kip items
// 1.3 Make sure Kip Master file records get selected in Lookup.txt
// 1.4 Remove VICSKUTMP output

unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils;

Const
    _Warehouse=1;
    _Location=2;
    _SKU=3;
    _Quantity=4;
    _OrderNum=5;
    _OrderDate=6;
    _EAD=7;
    _CustomerNo=8;
    _CustomerCat=9;
    _ItemPrice=10;
    _PromoInd=11;
    _CustomerWarehouse=12;
    _MaxField=12;




type
  TDataRecord = Array[1.._MaxField] of String;

  TDataLength = Array[1.._MaxField] of Integer;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    LogFile : TextFile;
    FirstShow:Boolean;
    ProductList:TStringList;
    FUseLookup:Boolean;
    procedure BuildProdList;
    procedure SaveProdList;
    procedure ProductListFree;
    procedure Say(Line : string);
    procedure StartProcess;
    procedure OpenLogFile;
    function GetParam(ParamName: String): String;
    procedure ReadData(LineOfData: String; var TheRecord: TDataRecord);
    function UpdateLocationCode(ProdCode,SKULoc,StyleLoc,CustLoc,Loc4:String;IndexNo:Integer):String;
    
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

uses udmData, uParameters, uCompany;

{$R *.DFM}

procedure TfrmMain.Say(Line : string);
begin
  Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Application.ProcessMessages;
end;

procedure TfrmMain.StartProcess;
var
    ProdCode, StringOfData:String;
    RecCount, WCount,CCount,ECount,CompanyID,IndexNo:Integer;
    OutStr: String;
    InFile,OutFile, ExceptFile,PoFile,CoFile:TextFile;
    DataRecord:TDataRecord;
    
    StyleColour,ExceptName,ErrMsg,Style:String;
    SKuLoc,StyleLoc,CustLoc,TempLoc1,TempLoc2,TempLoc3,CustCat:String;
    FoundCat,ExcludeHard:Boolean;
    GroupCode,PlnGroup,TheData,DesignCode,ModelCode,OriginalWH:String;
    Loc1,Loc2,Loc3,Loc4,Ret_PO_Name,Ret_CO_Name,SupplyChain,Owner1,Brand,Country:String;

begin

  Say('Start');


  try

    frmParameters.LoadParam;
    Say('Parameter File: '+frmParameters.edtIniFile.Text);
    CompanyID := GetCompanyID(GetParam('Company'));
    BuildLookupStructure(CompanyID);
    BuildProdList;

    RecCount := 0;
    WCount := 0;
    ECount := 0;

    Say('Creating : '+GetParam('Output File Name'));
    AssignFile(OutFile,GetParam('Output File Name'));
    Rewrite(OutFile);

    ExceptName :=UpperCase(GetParam('Output File Name'));

    ExceptNAme := AnsiReplaceStr(ExceptNAme,'.CSV','_Except.csv');

    Say('Creating Exceptions : '+ExceptName);
    AssignFile(ExceptFile,ExceptName);
    Rewrite(ExceptFile);
    WriteLn(ExceptFile,'Record Number,Error Message,Product,Order Number, Customer Number,Customer Category,Division');


    Say('Opening : '+GetParam('Input File Name'));
    AssignFile(InFile,GetParam('Input File Name'));
    Reset(InFile);



    //Populate stringlist of location codes so we don't have
    // to lookup on database.
    dmData.BuildLocationList;

    while not eof(InFile) do
    begin

      ReadLn(InFile,StringOfData);

      ReadData(StringOfData,DataRecord);
      Inc(RecCount);

      //if the exclude logic is hardcoded
      ExcludeHard := false;
      if UpperCase(DataRecord[_Warehouse]) = 'EVOM_APP' then
          DataRecord[1] := '';

      OriginalWH := DataRecord[_Warehouse];
      DataRecord[_Warehouse] := Kip_Processing(DataRecord[_Warehouse], DataRecord[_Location]);

      if (DataRecord[1] <> '') and (RecCount > 1) then
      begin


        ProdCode := DataRecord[_SKU];
        StyleColour := '';

        Style := '';
        SKULoc := '';
        StyleLoc := '';
        CustLoc := '';
        FoundCat := True;
        TempLoc1 := '';
        TempLoc2 := '';
        TempLoc3 := '';
        ErrMsg := '';
        DesignCode:='';
        ModelCode:='';
        Loc1:='';
        Loc2:='';
        Loc3:='';
        Loc4:='';
        Owner1:='';
        Brand:='';

        CustCat := Trim(DataRecord[_CustomerCat]);

        if (CustCat = '') then CustCat := 'ZZ';


        if CompanyID in [_Sleepmaker] then
        begin

          IndexNo := ProductList.IndexOf(OriginalWH+'|'+ProdCode);

          if IndexNo >= 0 then
          begin
            ModelCode := (ProductList.Objects[IndexNo] as TProductPB).Data[1];

            GetWarehouseLocation_SL(Trim(DataRecord[_Warehouse]),Loc1,Loc2,Loc3,Country);

            if (ModelCode <> '') then
            //Return valid category in TempLoc3
              if (Country <> 'NZ') then
              begin
                FoundCat := GetCustLocationCode(CustCat,TempLoc1,TempLoc2,TempLoc3,_lrCategory);
              end
              else
              begin
                FoundCat := GetCustLocationCodeNZ(CustCat,TempLoc1,TempLoc2,TempLoc3,_lrCategory);
              end;
            if Loc1 <> '' then
            begin

              if Loc1 = 'SAUSKU' then
                Loc3 := 'VICSKU';

             // if Loc1 = 'VICSKU' then
             //   Loc3 := 'VICSKUTMP';

              Loc4 := Copy(Loc1,1,3) + 'STL' + TempLoc3;
            end;
          end
          else
          begin
            Loc1 := 'Dummy';    //force process to enter lookup routine below,
                                //so it returns error for master record not found.

            IndexNo := -99;
          end;


        end;


        if FUseLookup then
        begin
          if (SkuLoc <> '') or (StyleLoc <> '') or (CustLoc<> '') then
            ErrMsg := UpdateLocationCode(ProdCode,SkuLoc,StyleLoc,CustLoc,Loc4,IndexNo)
          else
          begin
            if (Loc1 <> '') or (Loc2 <> '') or (Loc3<> '') or (Loc4<>'') then
              ErrMsg := UpdateLocationCode(ProdCode,Loc1,Loc2,Loc3,Loc4,IndexNo);

          end;

        end;

        if RecCount mod 50 = 0 then
        begin
          Label1.Caption := IntToStr(REcCount);
          Application.ProcessMessages;
        end;


        OutStr := '';

        for cCount := 1 to 4 do
        begin
           DataRecord[CCount] := Trim(AnsiReplaceStr(DataRecord[CCount],'"',''));
           DataRecord[CCount] := Trim(AnsiReplaceStr(DataRecord[CCount],',',' '));
           TheData := Trim(DataRecord[CCount]);
          OutStr := OutStr+ ',' + TheData;
        end;
        OutStr := OutStr+',In Production';                              //Dummy Customer reference
        DataRecord[5] := Trim(AnsiReplaceStr(DataRecord[5],'"',''));
        DataRecord[5] := Trim(AnsiReplaceStr(DataRecord[5],',',' '));
        TheData := Trim(DataRecord[5]);
        OutStr := OutStr+ ',' + TheData;                                //Order Date
        OutStr := OutStr+ ',' + TheData;                                //Delivery Date
        TheData := Trim(DataRecord[_Location]);
        OutStr := OutStr+ ',,,,' + TheData;                             //Location at end of line
       if SkuLoc <> '' then
          WriteLn(OutFile,SkuLoc + OutStr+ ',' + ProdCode+','+IntToStr(RecCount));

        if CompanyID = _Sleepmaker then
        begin

          if Loc1 <> '' then
            WriteLn(OutFile,Loc1+','+ProdCode + OutStr);

          if Loc3 <> '' then
            WriteLn(OutFile,Loc3+','+ProdCode + OutStr);

          if (Loc4 <> '') and (ModelCode<>'') then
            WriteLn(OutFile,Loc4+','+ModelCode + OutStr);

        end;


        if not FoundCat then
          if CompanyID = _Footwear then
            ErrMsg := 'Invalid Division + Category combination - '+Trim(DataRecord[_Warehouse]) + ' + ' + Trim(DataRecord[_CustomerCat])+'-'+ErrMsg
          else
            ErrMsg := 'Invalid Category - '+Trim(DataRecord[_CustomerCat])+'-'+ErrMsg;

        Inc(WCount);

        if ErrMsg <> '' then
        begin
          Inc(ECount);
          WriteLn(ExceptFile,IntToStr(recCount)+','+ErrMsg+','+ProdCode+','+
                  Trim('In Production') +','+
                  Trim(DataRecord[_CustomerNo]) +','+
                  Trim(DataRecord[_CustomerCat]+ ','+
                  Trim(DataRecord[_Warehouse])) );

        end;




      end
      else
      begin

        if (RecCount>1) then
        begin
          Inc(ECount);
          WriteLn(ExceptFile,IntToStr(RecCount)+',Invalid or null Warehouse Code,,'+
                  Trim('In Production') +','+
                  Trim(DataRecord[_CustomerNo]) +','+
                  Trim(DataRecord[_CustomerCat]+ ','+
                  Trim(DataRecord[_Warehouse])));
        end;

      end;

    end;

    //if no data then write out dummy record so import does not fail
    if WCount =0  then
    begin
        OutStr := '';

        for cCount := 1 to _MaxField do
        begin
          OutStr := OutStr+ ',0';
        end;

        WriteLn(OutFile,'DummyLoc' + OutStr + ',DummyProd,0');

        Inc(ECount);
        WriteLn(ExceptFile,',No Download Data');

    end;

    Say('Records read : '+IntToStr(RecCount));
    Say('Records written : '+IntToStr(WCount));
    CloseFile(InFile);
    CloseFile(OutFile);
    CloseFile(ExceptFile);

    if ECount=0 then
      if FileExists(ExceptName) then DeleteFile(ExceptName);

    if Ret_PO_Name <> '' then
      CloseFile(POFile);

    if Ret_CO_Name <> '' then
      CloseFile(COFile);

    if CompanyID in [_Leisure] then
      CloseFile(COFile);

    SaveProdList;

    ProductListFree;
    dmData.LocationListFree;

    dmData.FireEvent('S');

  except
      on e: exception do begin
        Say('***  failed');
        Say('*** ' + e.Message);
        dmData.FireEvent('F');
      end;
  end;


end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  StartTime : TDateTime;
  RunProcess:Boolean;
  FName:String;
begin

  if FirstShow then
  begin

    Caption := Caption + ' ' + dmData.DbDescription + ' Ver ' +dmData.kfVersionInfo;
    FirstShow := False;

    if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) then
    begin
      frmParameters.edtIniFile.Text := ParamStr(1);
      RunProcess := True;
      frmParameters.LoadParam;

    end
    else
    Begin

      Memo1.Lines.add('Parameter Setup');
      frmParameters.Caption := 'Parameter Setup - Ver ' +dmData.kfVersionInfo;

       if UpperCase(ParamStr(1)) = '-Z' then
       begin

        frmParameters.edtIniFile.Text := ParamStr(3);


       end;

      frmParameters.ShowModal;

      RunProcess := frmParameters.CreateOutput;

    end;

    if RunProcess then
    begin
      OpenLogFile;

      StartTime := Now;
      Say(FName+' started on ' + DateTimeToStr(StartTime));

      StartProcess;

      Say(FName+' finished on ' + DateTimeToStr(Now));
      Say(Format('Elapsed Time: %.2f seconds', [(Now - StartTime) * 86400]));

      CloseFile(LogFile);
      Close;
    end
    else
      Close;


  end;



end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;



procedure TfrmMain.OpenLogFile;
var
  FName:String;
  
  
begin
  FName := dmData.GetLogFileName;
  AssignFile(LogFile,FName );
  Rewrite(LogFile);

end;

function TfrmMain.GetParam(ParamName: String): String;
begin
  Result := frmParameters.vleParameters.Values[ParamName];
end;

procedure TfrmMain.ReadData(LineOfData: String;
  var TheRecord: TDataRecord);
var
  ArrCount, PCount: Integer;
  aChar:String;
begin

  ArrCount := 1;
  PCount := 1;
  TheRecord[1] := '';


  if Length(LineOfData) > 15 then
  begin
    repeat
      aChar := Copy(LineOfData,PCount,1);

      if Copy(LineOfData,PCount,1) = '|' then
      begin

        Inc(ArrCount);

        if ArrCount <= _MaxField then
          TheRecord[ArrCount] := ''

      end
      else
      begin

         if aChar <> #133 then
          TheRecord[ArrCount] := TheRecord[ArrCount] + aChar;

      end;

      inc(PCount);

    until (ArrCount > _MaxField) or (aChar = '') or (aChar = #133);

  end;

end;


procedure TfrmMain.BuildProdList;
var
  ProdCode,StringOfData,LocCode:String;
  LookupFile:TextFile;
  RecCount:Integer;
begin
    ProductList := TStringList.Create;
    RecCount := 0;
    FUseLookup := False;

    if Trim(GetParam('Lookup File')) <> '' then
    begin
      FUseLookup := True;
      Say('Opening and building lookup : '+GetParam('Lookup File'));
      AssignFile(LookupFile,GetParam('Lookup File'));
      Reset(LookupFile);

      while not eof(LookupFile) do
      begin
        ReadLn(LookupFile,StringOfData);

        SetLookupValues(StringOfData);
        ProdCode := FLookupStructure.Fields[FLookupStructure.ProdIndexNo].Value;
        LocCode := FLookupStructure.Fields[2].Value;

        ProductList.AddObject(LocCode+'|'+ProdCode,NewObjectPB);
        Inc(RecCount);

        if RecCount mod 50 = 0 then
        begin
          Label1.Caption := IntToStr(REcCount);
          Application.ProcessMessages;
        end;

      end;

      CloseFile(LookupFile);
      Say('Records in Lookup: '+IntToStr(RecCount));
    end
    else
      Say('Lookup File not in use.');

    ProductList.Sorted := True;

end;


procedure TfrmMain.ProductListFree;
var
  CCount:Integer;
begin

    While ProductList.Count > 0 do
    begin
      cCount := ProductList.Count-1;
      ProductList.Objects[cCount].Free;
      ProductList.Delete(cCount);
    end;

    ProductList.Free;
end;

function TfrmMain.UpdateLocationCode(ProdCode,SKULoc,StyleLoc,CustLoc,Loc4:String;IndexNo:Integer):String;
var
  LocationIndicator:String;
  LocationOffset:Integer;
begin


 Result := '';

 if IndexNo >= 0 then
 begin

   LocationIndicator := (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo];

   if SkuLoc <> '' then
   begin
     LocationOffset := dmData.GetLocationOffset(SkuLoc);

     if LocationOffset > 0 then
     begin
       LocationIndicator := StuffString(LocationIndicator,LocationOffset,1,'Y');
       (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator;
     end
     else
       Result := 'Invalid Location ' + SkuLoc;

   end;

   if (StyleLoc <> '') then
   begin
     LocationOffset := dmData.GetLocationOffset(StyleLoc);

     if LocationOffset > 0 then
     begin
       LocationIndicator := StuffString(LocationIndicator,LocationOffset,1,'Y');
       (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator;
     end
     else
       Result := Result + ' Invalid Location ' + StyleLoc;

   end;

   if (CustLoc <> '') then
   begin
     LocationOffset := dmData.GetLocationOffset(CustLoc);

     if LocationOffset > 0 then
     begin
       LocationIndicator := StuffString(LocationIndicator,LocationOffset,1,'Y');
       (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator;
     end
     else
       Result := Result + ' Invalid Location ' + CustLoc;

   end;

   if (Loc4 <> '') then
   begin
     LocationOffset := dmData.GetLocationOffset(Loc4);

     if LocationOffset > 0 then
     begin
       LocationIndicator := StuffString(LocationIndicator,LocationOffset,1,'Y');
       (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator;
     end
     else
       Result := Result + ' Invalid Location ' + Loc4;

   end;


 end
 else
   Result := 'Master Record not found ' + ProdCode;

end;

procedure TfrmMain.SaveProdList;
var
  LookupFile:TextFile;
  RecCount,FieldNo:Integer;
  OutFormat,OutStr:String;
begin

    if FUseLookup then
    begin

      Say('Updating Lookup : '+GetParam('Lookup File'));
      AssignFile(LookupFile,GetParam('Lookup File'));
      Rewrite(LookupFile);

      for RecCount := 0 to ProductList.Count - 1 do
      begin
        //Write out Data for Lookup info for other prepares
        OutStr := '';

        for FieldNo := 0 to FLookupStructure.FieldCount-1 do
        begin
          OutFormat := FLookupStructure.Fields[FieldNo].OutStr;

          //Only check for Float Type for now
          if FLookupStructure.Fields[FieldNo].FieldType = _lftFloat then
            OutStr := OutStr + Format(OutFormat,[ StrToFloat((ProductList.Objects[RecCount] as TProductPB).Data[FieldNo]) ])
          else
            OutStr := OutStr + Format(OutFormat,[ (ProductList.Objects[RecCount] as TProductPB).Data[FieldNo]]);

        end;

        if RecCount mod 50 = 0 then
        begin
          Label1.Caption := IntToStr(REcCount);
          Application.ProcessMessages;
        end;

        WriteLn(LookupFile,OutStr);
      end;

      CloseFile(LookupFile);

    end;

end;


end.
