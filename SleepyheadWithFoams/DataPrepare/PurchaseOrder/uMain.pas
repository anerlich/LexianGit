//Version 1.2 compiled with update company module to include changed Warehouse and division codes for OMNI
//Version 1.3 Add NZ locations
//Version 1.4 Create extra feed file containing transport orders
//Version 1.5 For transport orders if they are overdue make the EAD the previous month so when the orders are imported they are imported as overdue.
//Version 1.6 Add processing for kip items
// 1.7 Make sure Kip Master file records get selected in Lookup.txt
// 1.8 No VICSKUTMP


unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils,Variants;

Const

    _Warehouse=1;
    _Location=2;
    _SKU=3;
    _PO_Number=4;
    _OrderStatus=5;
    _Qty=6;
    _OrderDate=7;
    _EAD=8;
    _Vendor=9;
    _MaxField=9;



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
    FIndexNo:Integer;
    DownloadDate:TDateTime;
    procedure BuildProdList;
    procedure SaveProdList;
    procedure ProductListFree;
    procedure Say(Line : string);
    procedure StartProcess;
    procedure OpenLogFile;
    function GetParam(ParamName: String): String;
    procedure ReadData(LineOfData: String; var TheRecord: TDataRecord);
    function UpdateLocationCode(ProdCode,SKULoc,StyleLoc,CustLoc,Loc4:String;IndexNo:Integer):String;
    function MyStrToDate(DateStr: String): TDateTime;
  public
    { Public declarations }
    FTransportName: string;
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
    OutStr, OutStrTpt: String;
    InFile,OutFile, ExceptFile,StyleFile,StockFile,OutTransportFile:TextFile;
    DataRecord:TDataRecord;
    EADate:TDate;
    StyleColour,ExceptName,ErrMsg,Style:String;
    SKuLoc,StyleLoc,CustLoc,TempLoc1,TempLoc2,TempLoc3:String;
    UseStyleFile,transport:Boolean;
    DesignCode,OriginalWH:String;
    Loc1,Loc2,Loc3,Loc4,SupplyChain,AddStr,SupCode:String;
    FreightLT:Integer;
    NewEAD:TDateTime;
    GroupCode,PlnGroup,WHouseCode,OrdType,StockFileName,ExcludeSupplier,TempSup:String;
    Brand,Owner1,Country:String;
begin

  Say('Start');


  try

    frmParameters.LoadParam;
    Say('Parameter File: '+frmParameters.edtIniFile.Text);
    CompanyID := GetCompanyID(GetParam('Company'));

    //Only to check for master records
    BuildLookupStructure(CompanyID);
    BuildProdList;

    RecCount := 0;
    WCount := 0;
    ECount := 0;
    TempSup := '';

    Say('Creating : '+GetParam('Output File Name'));
    AssignFile(OutFile,GetParam('Output File Name'));
    Rewrite(OutFile);

    FTransportName:=trim(GetParam('Output Transport File Name'));
    if  FTransportName <> '' then
    begin
      AssignFile(OutTransportFile,FTransportName);
      Rewrite(OutTransportFile);
      DownloadDate := dmData.GetDownloadDateAsDate;
    end;

    ExcludeSupplier := '';


    ExceptName :=UpperCase(GetParam('Output File Name'));

    ExceptNAme := AnsiReplaceStr(ExceptNAme,'.CSV','_Except.csv');

    dmData.BuildLocationList;

    Say('Creating Exceptions : '+ExceptName);
    AssignFile(ExceptFile,ExceptName);
    Rewrite(ExceptFile);
    WriteLn(ExceptFile,'Record Number,Error Message,Product,Warehouse,PO Number,Qty,Order Date,Expected Date,Vendor');


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

      if (DataRecord[1] <> '') and (Reccount >1) then
      begin


        ProdCode := trim(DataRecord[_SKU]);
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


        if CompanyID = _Sleepmaker then
        begin

          //Loc2 returns nothing for now ....
          GetWarehouseLocation_SL(Trim(DataRecord[_Warehouse]),Loc1,Loc2,Loc3,Country);

        end;

        IndexNo := ProductList.IndexOf(OriginalWH+'|'+ProdCode);

        if FUseLookup then
        begin
          if (SkuLoc <> '') or (StyleLoc <> '') or (CustLoc<> '') then
            ErrMsg := UpdateLocationCode(ProdCode,SkuLoc,StyleLoc,CustLoc,Loc4,IndexNo)
          else
          begin
            if (Loc1 <> '') or (Loc2 <> '') or (Loc3<> '') or (Loc4<>'') then
              ErrMsg := UpdateLocationCode(ProdCode,Loc1,Loc2,Loc3,Loc4,IndexNo)
           else
              ErrMsg := ErrMsg + 'No match for Warehouse-Location Code in Optimiza';

          end;

        end;

        if RecCount mod 50 = 0 then
        begin
          Label1.Caption := IntToStr(REcCount);
          Application.ProcessMessages;
        end;



        OutStr := '';
        OutStrTpt := '';

        transport := (copy(upperCase(DataRecord[_PO_Number]),1,1)='X');

        for cCount := 1 to _MaxField do
        begin
          DataRecord[CCount] := Trim(AnsiReplaceStr(DataRecord[CCount],'"',''));
          DataRecord[CCount] := Trim(AnsiReplaceStr(DataRecord[CCount],',',' '));
          OutStr := OutStr+ ',' + DataRecord[CCount];
          if  (FTransportName <> '') and transport then
          begin
            if CCount = _EAD then
            begin
              try
                EADate := EncodeDate(StrToInt(Copy(DataRecord[CCount],1,4)),StrToInt(Copy(DataRecord[CCount],5,2)),StrToInt(Copy(DataRecord[CCount],7,2)));
                if EADate < DownloadDate then
                begin
                  EADate := IncMonth(EADate,-1); //Make the expected arrival date the previous month so it is put input overdue orders by optimiza.
                end;
              finally
                OutStrTpt := OutStrTpt+ ',' + FormatDateTime('yyyymmdd', EADate);
              end;
            end
            else
            begin
              OutStrTpt := OutStrTpt+ ',' + DataRecord[CCount];
            end;

          end;
        end;

        if  (FTransportName <> '') and transport then
          OutStrTpt := OutStrTpt + ',' + AddStr;
        OutStr := OutStr + ',' + AddStr;

        if SkuLoc <> '' then
        begin
          WriteLn(OutFile,SkuLoc + OutStr+ ',' + ProdCode+','+IntToStr(RecCount));
          if  (FTransportName <> '') and transport then
          begin
            WriteLn(OutTransportFile,SkuLoc + OutStrTpt+ ',' + ProdCode+','+IntToStr(RecCount));
          end;
        end;


        if CompanyID = _Sleepmaker then
        begin

          if Loc1 <> '' then
          begin
            WriteLn(OutFile,Loc1 + ','+ProdCode+OutStr+','+IntToStr(RecCount));
            if  (FTransportName <> '') and transport then
            begin
              WriteLn(OutTransportFile,Loc1 + ','+ProdCode+OutStrTpt+','+IntToStr(RecCount));
            end;
          end;

          if Loc2 <> '' then
          begin
            WriteLn(OutFile,Loc2 + ','+ProdCode+OutStr+','+IntToStr(RecCount));
            if  (FTransportName <> '') and transport then
            begin
              WriteLn(OutTransportFile,Loc2 + ','+ProdCode+OutStrTpt+','+IntToStr(RecCount));
            end;
          end;

          if Loc3 <> '' then
          begin
            WriteLn(OutFile,Loc3 + ','+StyleColour+OutStr+','+IntToStr(RecCount));
            if  (FTransportName <> '') and transport then
            begin
              WriteLn(OutTransportFile,Loc3 + ','+StyleColour+OutStrTpt+','+IntToStr(RecCount));
            end;
          end;

        end;

        Inc(WCount);

        if ErrMsg <> '' then
        begin
          Inc(ECount);
          WriteLn(ExceptFile,IntToStr(WCount)+','+ErrMsg+','+ProdCode
              +','+DataRecord[_Warehouse]
              +','+DataRecord[_PO_Number]
              +','+DataRecord[_Qty]
              +','+DataRecord[_OrderDate]
              +','+DataRecord[_EAD]
              +','+DataRecord[_Vendor]);


        end;




      end;

    end;

    Say('Records read : '+IntToStr(RecCount));
    Say('Records written : '+IntToStr(WCount));
    CloseFile(InFile);
    CloseFile(OutFile);
    CloseFile(ExceptFile);
    if  FTransportName <> '' then
    begin
      CloseFile(OutTransportFile);
    end;

    if UseStyleFile then
      CloseFile(StyleFile);

    if StockFileName <> '' then
      CloseFile(StockFile);

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

        ProductList.AddObject(LocCode + '|' + ProdCode,NewObjectPB);
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
 FIndexNo := IndexNo;

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

function TfrmMain.MyStrToDate(DateStr: String): TDateTime;
var
  Year, Month, Day: Word;
begin
  Year := StrToInt(Copy(DateStr,1,4));
  Month := StrToInt(Copy(DateStr,5,2));
  Day := StrToInt(Copy(DateStr,7,2));
  Result := EncodeDate(Year,Month,Day);

end;


end.
