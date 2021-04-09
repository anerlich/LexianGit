// 1.3 Add NZ locations
// 1.4 Add processing for kip items
// 1.5 Make sure Kip Master file records get selected in Lookup.txt
// 1.6 No VICSKUTMP

unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils;

Const

    _Warehouse=1;
    _Location=2;
    _SKU=3;
    _StockOnHand=4;
    _UnAllocated=5;
    _Vendor=6;
    _VendorName=7;
    _TotalLT=8;
    _MOQ=9;
    _OrdMult=10;
    _StockingInd=11;
    _MaxField=25;



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
    procedure ProductListFree;
    procedure Say(Line : string);
    procedure StartProcess;
    procedure OpenLogFile;
    function GetParam(ParamName: String): String;
    procedure ReadData(LineOfData: String; var TheRecord: TDataRecord);
    function UpdateLocationCode(ProdCode,SKULoc,StyleLoc,CustLoc,Loc4:String;IndexNo:Integer):String;
    procedure SaveProdList;
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
    InFile,OutFile, ExceptFile,AnotherFile:TextFile;
    DataRecord:TDataRecord;

    StyleColour,ExceptName,ErrMsg,Style:String;
    SKuLoc,StyleLoc,CustLoc,TempLoc1,TempLoc2,TempLoc3:String;
    TheData,DesignCode, OriginalWH:String;
    Loc1,Loc2,Loc3,Loc4,SupplyChain,AddStr,StkInd,Country:String;
    GroupCode,PlnGroup,WHouseCode:String;
    TmpProdCode, Brand, Owner1:String;
begin

  Say('Start');


  try

    frmParameters.LoadParam;
    Say('Parameter File: '+frmParameters.edtIniFile.Text);
    CompanyID := GetCompanyID(GetParam('Company'));

    //Populate stringlist of location codes so we don't have
    // to lookup on database.
    dmData.BuildLocationList;

    //Only to check for master records
    BuildLookupStructure(CompanyID);
    BuildProdList;
    TmpProdCode := '';

    RecCount := 0;
    WCount := 0;
    ECount := 0;

    Say('Creating : '+GetParam('Output File Name'));
    AssignFile(OutFile,GetParam('Output File Name'));
    Rewrite(OutFile);

    ExceptName :=UpperCase(GetParam('Output File Name'));

    ExceptNAme := AnsiReplaceStr(ExceptNAme,'.CSV','_Except.csv');

    //dmData.BuildLocationList;

    Say('Creating Exceptions : '+ExceptName);
    AssignFile(ExceptFile,ExceptName);
    Rewrite(ExceptFile);
    WriteLn(ExceptFile,'Record Number,Error Message,Product,Warehouse,Location,StockOnHand');


    Say('Opening : '+GetParam('Input File Name'));
    AssignFile(InFile,GetParam('Input File Name'));
    Reset(InFile);



    while not eof(InFile) do
    begin

      ReadLn(InFile,StringOfData);

      ReadData(StringOfData,DataRecord);
      Inc(RecCount);

      if UpperCase(DataRecord[_Warehouse]) = 'EVOM_APP' then
          DataRecord[1] := '';

      OriginalWH := DataRecord[_Warehouse];
      DataRecord[_Warehouse] := Kip_Processing(DataRecord[_Warehouse], DataRecord[_Location]);


      if (DataRecord[1] <> '') and (RecCount>1) then
      begin


        ProdCode := Datarecord[_SKU];
        StyleColour := '';

        Style := '';
        SKULoc := '';
        StyleLoc := '';
        CustLoc := '';
        TempLoc1 := '';
        TempLoc2 := '';
        TempLoc3 := '';
        ErrMsg := '';
        DesignCode:='';
        Loc1:='';
        Loc2:='';
        Loc3:='';
        Loc4:='';
        AddStr := '';
        StkInd:='';

        if Trim(DataRecord[_StockOnHand])='' then DataRecord[_StockOnHand] := '0';
        if DataRecord[_TotalLT]='' then DataRecord[_TotalLT] := '0';

        if (DataRecord[_MOQ]='') or (DataRecord[_MOQ]='0') then
          DataRecord[_MOQ] := '1';

        if (DataRecord[_OrdMult]='') or (DataRecord[_OrdMult]='0') then
          DataRecord[_OrdMult] := '1';

        DataRecord[_VendorName] := Trim(AnsiReplaceStr(DataRecord[_VendorName],'"',''));
        DataRecord[_VendorName] := AnsiReplaceStr(DataRecord[_VendorName],',',' ');



        if CompanyID = _Sleepmaker then
        begin
           //Loc2 returns nothing for now!!!!
          GetWarehouseLocation_SL(Trim(DataRecord[_Warehouse]),Loc1,Loc2,Loc3,Country);
        end;


        if RecCount mod 50 = 0 then
        begin
          Label1.Caption := IntToStr(REcCount);
          Application.ProcessMessages;
        end;

        if DataRecord[_StockOnHand] = '' then
          DataRecord[_StockOnHand] := '0';


        IndexNo := ProductList.IndexOf(OriginalWH+'|'+ProdCode);

        if (IndexNo < 0) then
          ErrMsg := 'warehouse + Product not found';

        if ErrMsg = '' then
        begin
          OutStr := '';
           if Trim(DataRecord[_StockingInd])='Y' then
             DataRecord[_StockingInd]:='Y';

           if Pos(Trim(DataRecord[_StockingInd]),'Y,N') = 0 then
              DataRecord[_StockingInd]:='N';


            for cCount := 1 to _MaxField do
            begin
              TheData := Trim(AnsiReplaceStr(DataRecord[CCount],'"',''));
              TheData := AnsiReplaceStr(TheData,',',' ');
              OutStr := OutStr+ ',' + TheData;
            end;


          if SkuLoc <> '' then
            WriteLn(OutFile,SkuLoc + OutStr+ ',' + ProdCode+','+IntToStr(RecCount));



          if CompanyID = _Sleepmaker then
          begin

            If Loc1 <> '' then
            begin
            WriteLn(OutFile,Loc1 + OutStr+ ',' + ProdCode+','+IntToStr(RecCount));
            end;

            If Loc2 <> '' then
            begin
            WriteLn(OutFile,Loc2 + OutStr+ ',' + ProdCode+','+IntToStr(RecCount));
            end;

            If Loc3 <> '' then
            begin
            WriteLn(OutFile,Loc3 + OutStr+ ',' + ProdCode+','+IntToStr(RecCount));
            end;


            if FUseLookup and (OriginalWH <> DataRecord[_Warehouse]) then
            begin
              if (Loc1 <> '') or (Loc2 <> '') or (Loc3<> '') or (Loc4<>'') then
                ErrMsg := UpdateLocationCode(ProdCode,Loc1,Loc2,Loc3,Loc4,IndexNo);
            end;


          end;

          Inc(WCount);


//----------------------------------------------------
        end
        else
        begin

          if trim(DataRecord[_StockOnHand])<>'0' then
          begin
            Inc(ECount);
            WriteLn(ExceptFile,IntToStr(RecCount)+','+ErrMsg+','+ProdCode+','+
                  DataRecord[_Warehouse]+','+DataRecord[_Location]+','+DataRecord[_StockOnHand]);
          end;


        end;




      end;

    end;

    Say('Records read : '+IntToStr(RecCount));
    Say('Records written : '+IntToStr(WCount));
    CloseFile(InFile);
    CloseFile(OutFile);
    CloseFile(ExceptFile);


    if ECount=0 then
      if FileExists(ExceptName) then DeleteFile(ExceptName);


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

        ProductList.AddObject(LocCode+ '|' + ProdCode,NewObjectPB);
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

 //IndexNo := ProductList.IndexOf(ProdCode);
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



end.
