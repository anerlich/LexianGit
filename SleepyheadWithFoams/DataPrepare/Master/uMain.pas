// Version 1.3 add functionality to include model codes to customer locations based on product class using a lookup file.
// Version 1.4 add functionality to include sku codes to all state sku locations.  Incorporated in the same process as above.
// Version 1.5 - Version 1.4 functionality reversed out.
// Version 1.6 - Reenabled  default sku to make output identical to 1.3.
// Version 1.7 - 18/6/2012 - Add Bunks and Pillows as models
// Version 1.8 - Increase model codes from 4 to 6 characters
// Version 1.9 - Add new processing to populate Model Sku flags
// Version 1.10 - Add Accessories as models (Seasoncode 'Accessories')
// Version 2.0 - Add Vendor Code and description
// Version 2.1 - Add NZ locations
// Version 2.2 - Update SKU State items with the model State Sku Flag and stocking indicator
// Version 2.3 - Added ability to modify the lookup table using items in the database
// Version 2.4 - Add season code W to model list
// Version 2.5 - Add items that are mapped between locations
// Version 2.6 - Allow for dropped locations in Product class processing
// Version 2.7 - Added support for Foams business
// Version 2.8 - Added a function to ensure that items exist at all the appropriate disag locations. Procedure GenerateFoamsDisagItems()
// Version 2.9 - Added a check to ignore header row which gets added when adding foams and bedding data together
// Version 2.10 - Bug fix when distinguishing _JBA and _App records case was wrong.
// Version 2.11 - Bug fix identifying country for adding model locations.
// Version 3.0  - Run in a customer forecast import mode (set up new items)
// Version 3.1  - Fix problem with find product codes when in customer forecast mode
// Version 3.2  - Add headboards to model list
// Version 3.3  - remove output to VICSKUTMP
// Version 3.4  - include MinSSUnits field
// Version 3.5  - include 5 more fields IMSSITE,IMSWHSE,IMFGMODEL,IMFGRANGE,IMUWEIGHT, only 4 used (not IMSWHSE) trim first 4 to 30 characters

unit uMain;
interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils,DB;

Const
    _Warehouse=1;
    _Seas=2;
    _SKU=3;
    _Description=4;
    _Cost=5;
    _Selling=6;
    _ASP=7;
    _ProductGroup=8;
    _ProdClass=9;
    _Planc=10;
    _GenCode=11;
    _GenDesc=12;
    _UOM=13;
    _FC_Flag=14;
    _SKU_Flag=15;
    _ProdType=16;
    _SeasonCode=17;
    _StockingInd=18;
    _TotalLT=19;
    _FGRM=20;
    _MaxField=21;

    _Supplier=22;
    _SupplierName=23;
    _MinSSUnits=24;
    _SSite=25; //DRP Source
    _SWhse=26; //not in use at 04/2021
    _FGModel=27;
    _FGRange=28;
    _UWeight=29;
    _AllFields=29;

type
  TString = class(TObject)
  private
    fStr: String;
  public
    constructor Create(const AStr: String) ;
    property Str: String read FStr write FStr;
  end;


type
  TDataRecord = Array[1.._AllFields] of String;
  TDataLength = Array[1.._AllFields] of Integer;

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
    FirstShow, CustomerForecastMode:Boolean;
    ProductList, MappedAusList, MappedNZList:TStringList;
    ModelLocnList:TStringList;
    FUseLookup:Boolean;
    procedure BuildProdList;
    procedure SaveProdList;
    procedure ProductListFree;
    procedure ModelLocnListFree;
    procedure Say(Line : string;ToScreen:Boolean=True);
    procedure StartProcess;
    procedure OpenLogFile;
    function GetParam(ParamName: String): String;
    procedure ReadData(LineOfData: String; var TheRecord: TDataRecord);
    function DaysToMonths(InStr: String; Len,  Decimal: Integer): String;
    function MyStrToDate(DateStr: String;BufferDays:Integer): TDateTime;
    function Retail_Release(DateStr: String;BufferDays:Integer): Real;
    function GetStkInd(CompanyID:Integer;StkInd:String):String;
    function GetOutStr_SL(OutStr,Desc1,Desc2,ColourDesc,FF,SF,PLC,Season,StkInd:String;NewLT:Integer;RetLt,Cost,Sell:Real):String;
    procedure NewItems(CompanyID:Integer);
    function UpdateLocationInd(CompanyID:Integer;ProdCode,LocCode:String):Boolean;
    function UpdateLocationIndOffset(LocationOffset:Integer;ProdCode:String):Boolean;
    function getCountry(SearchStr:String):String;

    function FindProd(ProdCode,LocCode:String):Integer;
    function FindMOQ(WorkCentre,MOQ: String): String;
    procedure CalcModelData;
    procedure ModelCostSellOverride;
    procedure AddCustLocsFromProdClass;
    procedure AddCustLocsFromProdClassNZ;
    procedure UpdateLookupFromDB();
    procedure GenerateFoamsDisagItems();

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

uses udmData, uParameters, uCompany;

{$R *.DFM}

constructor TString.Create(const AStr: String) ;
begin
   inherited Create;
   FStr := AStr;
end;

procedure TfrmMain.Say(Line : string;ToScreen:Boolean=True);
begin
  if ToScreen then
    Memo1.Lines.Add(Line);
  WriteLn(LogFile, Line);
  Application.ProcessMessages;
end;

procedure TfrmMain.StartProcess;
var
    ProdCode, StringOfData:String;
    RecCount, WCount,CCount,CompanyID:Integer;
    OutStr: String;
    InFile,OutFile:TextFile;
    DataRecord:TDataRecord;

    StyleColour,ErrMsg,Style:String;
    SKuLoc,StyleLoc,CustLoc,TempLoc1,TempLoc2,TempLoc3:String;
    TheData:String;
    Loc1,Loc2,Loc3,Loc4,LocInd,ImportInd,Country:String;
    CreateLookup,ProcessNewItems,UseDBForLookup:Boolean;
    LocNo,RecordNo,StartPos, ModelRecNo:Integer;
    TmpStyleCol,StyleColLoc,StyleOutStr,SKUOutStr:String;
    NewLT:Integer;
    OtherLT:Real;
    StkInd,FF,SF,PLC,Season:String;
    StyleFcInd,StyleColFCInd,WholeSale,Contract,GroupCombo,FG_Code,TmpPareto,TempGroup:String;
    ForceItemCreate,OutputOne:Boolean;
begin

  Say('Start');


  try
    OutputOne := true;
    frmParameters.LoadParam;
    Say('Parameter File: '+frmParameters.edtIniFile.Text);
    CompanyID := GetCompanyID(GetParam('Company'));

    CreateLookup := UpperCase(GetParam('Create Lookup'))='YES';
    ProcessNewItems := UpperCase(GetParam('Process New Item Files'))='YES';
    UseDBForLookup := UpperCase(GetParam('Generate Lookup From DB'))='YES';
    CustomerForecastMode := UpperCase(GetParam('Customer Forecast Mode'))='YES';
    BuildLookupStructure(CompanyID);

    //Populate stringlist of location codes so we don't have
    // to lookup on database.
    dmData.BuildLocationList;



    ModelLocnList := TStringList.Create;
    ModelLocnList.Sorted := true;
    if not CreateLookup then
    begin
      Say('Creating Master File and reading Lookup File');
      Say('--------------------------------------------');
      BuildProdList;
      GenerateFoamsDisagItems;
      Say('Creating : '+GetParam('Output File Name'));
      AssignFile(OutFile,GetParam('Output File Name'));
      Rewrite(OutFile);

      //List Location Codes vs Offset for validation purposes
      with dmData.qrySelectLocation do
      begin
        SQL.Clear;
        SQL.Add('Select * from Location Order by LocationNo');
        Open;
        Say('Location List');
        LocNo := 0;

        while not eof do
        begin
          inc(LocNo);
          Say( Format('%3s - ',[IntToStr(LocNo)])+FieldByName('LocationCode').AsString);
          next;
        end;

        Say('------------');
        Close;

      end;

    end
    else
    begin
      ProductList := TStringList.Create;
      ProductList.Sorted := true;
      ProductList.Duplicates := dupError;
      FUseLookup := True;

    end;

    if not CreateLookup then
    begin
      if ProcessNewItems then
        NewItems(CompanyId);

    end;


    RecCount := 0;
    WCount := 0;


    Say('Opening : '+GetParam('Input File Name'));
    AssignFile(InFile,GetParam('Input File Name'));
    Reset(InFile);



    while not eof(InFile) do
    begin

      ReadLn(InFile,StringOfData);

      ReadData(StringOfData,DataRecord);
      Inc(RecCount);



      //Filter here
      //if CompanyID = _KingGee then
      //begin
      if UpperCase(DataRecord[_Warehouse]) = 'EVOM_APP' then
          DataRecord[1] := '';
      //end;
      if UpperCase(DataRecord[_Warehouse]) = 'IMAPP' then
          DataRecord[1] := '';

      if (DataRecord[1] <> '') and (RecCount > 1) then
      begin

        ProdCode := Trim(DataRecord[_SKU]);

        StyleColour := '';

        Style := '';

        SKULoc := '';
        StyleLoc := '';
        CustLoc := '';
        //FoundCat := True;
        TempLoc1 := '';
        TempLoc2 := '';
        TempLoc3 := '';
        ErrMsg := '';
        Loc1:='';
        Loc2:='';
        Loc3:='';
        Loc4:='';

        //Get the default SKU location
        GetWarehouseLocation_SL(Trim(DataRecord[_Warehouse]),SKULoc,TempLoc1,TempLoc2,Country);

        {if (Trim(DataRecord[_MOQ]) = '') or (StrToFloat(Trim(DataRecord[_MOQ]))= 0) then
          DataRecord[_MOQ] := '1';
        if (Trim(DataRecord[_OrdMult]) = '') or (StrToFloat(Trim(DataRecord[_OrdMult]))= 0) then
          DataRecord[_OrdMult] := '1';

        if (Trim(DataRecord[_Style_MOQ]) = '') or (StrToFloat(Trim(DataRecord[_Style_MOQ]))= 0) then
          DataRecord[_Style_MOQ] := '1';
        if (Trim(DataRecord[_SKU_MOQ]) = '') or (StrToFloat(Trim(DataRecord[_SKU_MOQ]))= 0) then
          DataRecord[_SKU_MOQ] := '1';

        if Trim(DataRecord[_LT_Manuf]) = '' then
          DataRecord[_LT_Manuf] := '0';
        if Trim(DataRecord[_LT_Freight]) = '' then
          DataRecord[_LT_Freight] := '0';
        if Trim(DataRecord[_LT_Total]) = '' then
          DataRecord[_LT_Total] := '0';
        if Trim(DataRecord[_LT_Offset]) = '' then
          DataRecord[_LT_Offset] := '0';
        }

        if (Trim(DataRecord[_Cost]) = '') then
          DataRecord[_Cost] := '0';

        if (Trim(DataRecord[_Selling]) = '') then
          DataRecord[_Selling] := '0';

        if (Trim(DataRecord[_ASP]) = '') then
          DataRecord[_ASP] := '0';


        {if Trim(DataRecord[_RP])='' then
          DataRecord[_RP]:='0';

        DataRecord[_RP] := DaysToMonths(Trim(DataRecord[_RP]),6,2);

        if Trim(DataRecord[_SSDays])='' then
          DataRecord[_SSDays]:='0';

        if Trim(DataRecord[_Pareto_SKU])='' then
          DataRecord[_Pareto_SKU] := 'F';

        //In case we import this like Tontine
        if Trim(DataRecord[_ForecastFlag]) = '' then
          DataRecord[_ForecastFlag] := '_';            }

        //Convert Stocking indicator where necessary
        StkInd := GetStkInd(CompanyID,Datarecord[_StockingInd]);




        OutStr := '';


        for cCount := 1 to _MaxField do
        begin

          DataRecord[CCount] := Trim(AnsiReplaceStr(DataRecord[CCount],'"',''));

          DataRecord[CCount] := AnsiReplaceStr(DataRecord[CCount],',',' ');

          TheData := Trim(DataRecord[CCount]) ;

          if (cCount > 1) then OutStr := Outstr + ',';
          OutStr := OutStr+ TheData;
        end;

        
        if not CreateLookup then
        begin

          RecordNo := ProductList.IndexOf(DataRecord[_Warehouse] + '|' + ProdCode);
          //RecordNo := ProductList.IndexOf(ProdCode);

          if RecordNo >= 0 then
          begin

            LocInd := (ProductList.Objects[RecordNo] as TProductPB).Data[FLookupStructure.LocIndexNo];

            SkuOutStr := '';
            StyleOutStr := '';

            if CompanyID = _Sleepmaker then
            begin

              //Model Code
              StyleColour := (ProductList.Objects[RecordNo] as TProductPB).Data[1];

              StkInd := Copy((ProductList.Objects[RecordNo] as TProductPB).Data[FLookupStructure.FlagIndexNo],5,1);
              SF := Trim(Copy((ProductList.Objects[RecordNo] as TProductPB).Data[FLookupStructure.FlagIndexNo],6,1));
              if SF = '' then SF:= '_';

              PLC := Trim(Copy((ProductList.Objects[RecordNo] as TProductPB).Data[FLookupStructure.FlagIndexNo],4,1));
              if PLC = '' then PLC := '_';

              SkuOutStr := GetOutStr_SL(OutStr,
                                         DataRecord[_Description],
                                         '',
                                         '',
                                         FF,SF,PLC,Datarecord[_Seas],StkInd,NewLT,OtherLT,
                                         StrToFloat(DataRecord[_Cost]),
                                         StrToFloat(DataRecord[_Asp]));

              StkInd := Copy((ProductList.Objects[RecordNo] as TProductPB).Data[FLookupStructure.FlagIndexNo],1,1);
              SF := Trim(Copy((ProductList.Objects[RecordNo] as TProductPB).Data[FLookupStructure.FlagIndexNo],3,1));
              if SF = '' then SF := '_';



              SkuOutStr := SkuOutStr + ',' + StyleColour + ',' + Datarecord[_Supplier] + ','  + Datarecord[_SupplierName]
                    + ','  + SF
                    + ','  + StkInd
                    + ',' + DataRecord[_MinSSUnits].Substring(0,30)
                    + ',' + DataRecord[_SSite].Substring(0,30)
                    + ',' + DataRecord[_SWhse].Substring(0,30)
                    + ',' + DataRecord[_FGModel].Substring(0,30)
                    + ',' + DataRecord[_FGRange].Substring(0,30)
                    + ',' + DataRecord[_UWeight];

              StyleOutStr := GetOutStr_SL(OutStr,
                                         DataRecord[_Description],
                                         '',
                                         '',
                                         FF,SF,PLC,Datarecord[_Seas],StkInd,NewLT,OtherLT,
                                         StrToFloat((ProductList.Objects[RecordNo] as TProductPB).Data[5]),
                                         StrToFloat((ProductList.Objects[RecordNo] as TProductPB).Data[6]));
              StyleOutStr := StyleOutStr + ',' + StyleColour+ ',' + Datarecord[_Supplier] + ','  + Datarecord[_SupplierName]
                    + ','  + SF
                    + ','  + StkInd
                    + ',' + DataRecord[_MinSSUnits].Substring(0,30)
                    + ',' + DataRecord[_SSite].Substring(0,30)
                    + ',' + DataRecord[_SWhse].Substring(0,30)
                    + ',' + DataRecord[_FGModel].Substring(0,30)
                    + ',' + DataRecord[_FGRange].Substring(0,30)
                    + ',' + DataRecord[_UWeight];
            end;

 //-----------------------------------------------

            //default SKU
            if (not CustomerForecastMode) or (OutputOne) then
            begin
              if SkuLoc <> 'VICSKUTMP' then
              begin
                WriteLn(OutFile,SKULoc+','+ProdCode+','+SKUOutStr);
                OutputOne := false;
              end;
            end;

            StartPos := Pos('Y',LocInd);

            if  StartPos > 0 then  
            begin

              for LocNo := StartPos to FLookupStructure.MaxLocation do
              begin
                ImportInd := Copy(LocInd,LocNo,1);

                if ImportInd = 'Y' then
                begin
                  Loc1 := dmData.GetLocationCodeAt(LocNo-1);

                    //style Colour OR sku ?
                    if IsStyleColour(Loc1) then
                    begin

                      if TmpStyleCol <> StyleColour then
                      begin
                        StyleColLoc := DupeString('-',FLookupStructure.MaxLocation);
                        TmpStyleCol := StyleColour;
                      end;

                      if Copy(StyleColLoc,LocNo,1) = '-' then
                      begin
                          ModelRecNo := ModelLocnList.IndexOf(Loc1 + '|' + StyleColour);
                          if ModelRecNo < 0 then
                          begin
                            if Loc1<> 'VICSKUTMP' then
                            begin
                            WriteLn(OutFile,Loc1+','+StyleColour+','+StyleOutStr);
                            ModelLocnList.Add(Loc1 + '|' + StyleColour)
                            end;
                          end;

                          StyleColLoc := StuffString(StyleColLoc,LocNo,1,'Y');
                      end;

                    end
                    else
                    begin
                      //if Loc1 <> SkuLoc then
                      if Loc1 <> 'VICSKUTMP' then
                        WriteLn(OutFile,Loc1+','+ProdCode+','+SKUOutStr);


                    end;

                end;  //end import ind

              end; // end for startpos

            end;  //if startpos

          end;  //if recordno

        end; //if not createlookup

        if RecCount mod 50 = 0 then
        begin
          Label1.Caption := IntToStr(REcCount);
          Application.ProcessMessages;
        end;

        Inc(WCount);




        if CreateLookup then
        begin
          FLookupStructure.Fields[0].Value := ProdCode;
          FLookupStructure.Fields[FLookupStructure.LocIndexNo].Value := DupeString('-',FLookupStructure.MaxLocation);


          if CompanyID = _Sleepmaker then
          begin
            FLookupStructure.Fields[FLookupStructure.FlagIndexNo].Value :=
                                     Format('%-1s%-1s%-1s%-1s%-1s%-1s',[StkInd,
                                              ' ',              //Pareto
                                              DataRecord[_SKU_Flag],
                                              '',       //PLC flag
                                              StkInd,
                                              DataRecord[_SKU_Flag]
                                              ]);
            if (UpperCase(StrUtils.RightStr(Trim(DataRecord[_Warehouse]),4)) = '_APP') then
            begin
              //if (Pos(DataRecord[_Seas],'B,M') >0) then
              //if ((Pos(DataRecord[_Seas],'B,M,W' Not Yet) >0) or (Pos(UpperCase(DataRecord[_SeasonCode]),'BUNKS') >0)) then
              if  (Pos(UpperCase(DataRecord[_SeasonCode]),'HEADBOARDS') >0)
                  and  ((UpperCase(Trim(DataRecord[_Warehouse])) = 'AUCK_APP')
                        or (UpperCase(Trim(DataRecord[_Warehouse])) = 'CHCH_APP'))  then
              begin
                FLookupStructure.Fields[1].Value := rightstr(DataRecord[_SKU],6);
              end
              else if ((Pos(DataRecord[_Seas],'B,M,W') >0) or (Pos(UpperCase(DataRecord[_SeasonCode]),'BUNKS') >0)) then
              begin
                FLookupStructure.Fields[1].Value := Copy(DataRecord[_SKU],1,6);
              end
              else if ((Pos(UpperCase(DataRecord[_SeasonCode]),'PILLOWS') >0)
                        or (Pos(UpperCase(DataRecord[_SeasonCode]),'ACCESSORIES') >0)
                        ) then
              begin
                FLookupStructure.Fields[1].Value := rightstr(DataRecord[_SKU],6);
              end
              else
                FLookupStructure.Fields[1].Value := '';
            end
            else if (UpperCase(StrUtils.RightStr(Trim(DataRecord[_Warehouse]),4)) = '_JBA') then
            begin
                FLookupStructure.Fields[1].Value := '';
            end;

            FLookupStructure.Fields[2].Value := DataRecord[_Warehouse];

            FLookupStructure.Fields[5].Value := Trim(DataRecord[_Cost]);
            FLookupStructure.Fields[6].Value := Trim(DataRecord[_ASP]);
            FLookupStructure.Fields[7].Value := '';//Trim(Copy(DataRecord[_DesignItem],1,6));
            FLookupStructure.Fields[8].Value := Trim(DataRecord[_ProdClass]);
          end;

          ProductList.AddObject(DataRecord[_Warehouse]+ '|'+ProdCode,NewObjectPB);
          //ProductList.AddObject(ProdCode,NewObjectPB);
        end;


      end;

    end;

    Say('Records read : '+IntToStr(RecCount));
    Say('Records written : '+IntToStr(WCount));
    CloseFile(InFile);

    if not CreateLookup then
    begin
      CloseFile(OutFile);
    end;

    if (CreateLookup and UseDBForLookup) then
    begin
      UpdateLookupFromDB();
    end;


    SaveProdList;
    ProductListFree;
    ModelLocnListFree;

    if CreateLookup and (not CustomerForecastMode) then
    begin
      AddCustLocsFromProdClass;
      AddCustLocsFromProdClassNZ;
    end;

    dmData.LocationListFree;

    dmData.FireEvent('S');

  except
      on e: exception do begin
        Say('***  failed, '+ProdCode);
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

    Caption := Caption + ' ' + dmData.DbDescription;
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
      frmParameters.Caption := 'Parameter Setup';

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
  Year,Month,Day:Word;
  FCount:Integer;
begin
  FName := dmdata.GetLogFileName;

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

  // in case MinSSUnits is not provided, initialise it to 0.0
  TheRecord[_MinSSUnits] := '0.00000000';

  if Length(LineOfData) > 15 then
  begin
    repeat
      aChar := Copy(LineOfData,PCount,1);

      if Copy(LineOfData,PCount,1) = '|' then
      begin

        Inc(ArrCount);

        if ArrCount <= _AllFields then
          TheRecord[ArrCount] := ''

      end
      else
      begin

         if aChar <> #133 then
          TheRecord[ArrCount] := TheRecord[ArrCount] + aChar;

      end;

      inc(PCount);

    until (ArrCount > _AllFields) or (aChar = '') or (aChar = #133);

  end;

end;


procedure TfrmMain.BuildProdList;
var
  ProdCode,StringOfData,LocCode,LocationIndicator:String;
  LookupFile:TextFile;
  RecCount, mIndx, lIndx, LocationOffset:Integer;
  AUSLocn, NZLocn:TStringList;
  CustomerForecastMode: Boolean;
begin
    CustomerForecastMode := UpperCase(GetParam('Customer Forecast Mode'))='YES';

    // Make sure Mapped items get created in the selected locations
    AUSLocn := TStringList.Create;
    AUSLocn.Add('NSWSKU');
    AUSLocn.Add('QLDSKU');
    AUSLocn.Add('TASSKU');
    AUSLocn.Add('VICSKU');
    AUSLocn.Add('WAUSKU');

    NZLocn := TStringList.Create;
    NZLocn.Add('NTHSKU');
    NZLocn.Add('STHSKU');

    MappedAusList := TStringList.Create;
    MappedAusList.Sorted := true;
    MappedAusList.Duplicates := dupError;

    MappedNZList := TStringList.Create;
    MappedNZList.Sorted := true;
    MappedNZList.Duplicates := dupError;

    dmData.qryMappedList.Close;
    dmData.qryMappedList.ExecQuery;
    while not dmData.qryMappedList.Eof do
    begin
      // Need to swap to and from so we create dummy items in the correct location!!!!
      MappedAUSList.Add(dmData.qryMappedList.fieldByName('NZ_PRODUCTCODE').AsString);
      MappedNZList.Add(dmData.qryMappedList.fieldByName('AUS_PRODUCTCODE').AsString);
      dmData.qryMappedList.Next;
    end;


    ProductList := TStringList.Create;
    ProductList.Sorted := true;
    ProductList.Duplicates := dupError;
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

        // Check if this Product code is mapped, if so need to tick associated location
        if CustomerForecastMode then mIndx := -1
        else mIndx := MappedAUSList.IndexOf(ProdCode);

        if mIndx >= 0 then
        begin
          LocationIndicator := FLookupStructure.Fields[FLookupStructure.LocIndexNo].value;
          For lIndx:=0 to AUSLocn.Count -1 do
          begin
            LocationOffset := dmData.GetLocationOffset(AUSLocn.Strings[lIndx]);

            if LocationOffset > 0 then
            begin
              LocationIndicator := StuffString(LocationIndicator,LocationOffset,1,'Y');
            end ;
          end;
          FLookupStructure.Fields[FLookupStructure.LocIndexNo].value := LocationIndicator;
        end;

        if CustomerForecastMode then mIndx := -1
        else mIndx := MappedNZList.IndexOf(ProdCode);
        if mIndx >= 0 then
        begin
          LocationIndicator := FLookupStructure.Fields[FLookupStructure.LocIndexNo].value;
          For lIndx:=0 to NZLocn.Count -1 do
          begin
            LocationOffset := dmData.GetLocationOffset(NZLocn.Strings[lIndx]);

            if LocationOffset > 0 then
            begin
              LocationIndicator := StuffString(LocationIndicator,LocationOffset,1,'Y');
            end ;
          end;
          FLookupStructure.Fields[FLookupStructure.LocIndexNo].value := LocationIndicator;
        end;

        ProductList.AddObject(LocCode + '|' + ProdCode,NewObjectPB);
        //ProductList.AddObject(ProdCode,NewObjectPB);
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


    While MappedAUSList.Count > 0 do
    begin
      mIndx := MappedAUSList.Count-1;
      MappedAUSList.Objects[mIndx].Free;
      MappedAUSList.Delete(mIndx);
    end;

    MappedAUSList.Free;

    While MappedNZList.Count > 0 do
    begin
      mIndx := MappedNZList.Count-1;
      MappedNZList.Objects[mIndx].Free;
      MappedNZList.Delete(mIndx);
    end;

    MappedNZList.Free;

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


procedure TfrmMain.ModelLocnListFree;
var
  CCount:Integer;
begin

    While ModelLocnList.Count > 0 do
    begin
      cCount := ModelLocnList.Count-1;
      ModelLocnList.Objects[cCount].Free;
      ModelLocnList.Delete(cCount);
    end;

    ModelLocnList.Free;
end;

procedure TfrmMain.SaveProdList;
var
  LookupFile:TextFile;
  RecCount,FieldNo:Integer;
  OutFormat,OutStr,ProdCode:String;
begin

    if FUseLookup then
    begin

      Say('Saving Lookup : '+GetParam('Lookup File'));
      AssignFile(LookupFile,GetParam('Lookup File'));
      Rewrite(LookupFile);

      ProductList.Sorted := True;
      ProdCode := '';
      try

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

        if ProdCode <> ProductList.Strings[Reccount] then
        begin
          WriteLn(LookupFile,OutStr);
          flush(LookupFile);
          ProdCode := ProductList.Strings[Reccount];

        end;

      end;

      except
       on e: exception do begin
        Say('***  failed, '+ProductList.Strings[Reccount]);
        Say('*** ' + e.Message);
        dmData.FireEvent('F');
       end;
      end;

      CloseFile(LookupFile);

    end;

end;



function TfrmMain.DaysToMonths(InStr: String; Len,
  Decimal: Integer): String;
var
  NumVal: Real;
begin

  NumVal := StrToInt(InStr) / 30;

  Result := Format('%'+IntToStr(Len)+'.'+IntToStr(Decimal)+'f',[NumVal]);

  Result := Result;
end;


function TfrmMain.MyStrToDate(DateStr: String;BufferDays:Integer): TDateTime;
var
  Year, Month, Day: Word;
begin
  try
    Year := StrToInt(Copy(DateStr,1,4));
    Month := StrToInt(Copy(DateStr,5,2));
    Day := StrToInt(Copy(DateStr,7,2));
    Result := EncodeDate(Year,Month,Day) + BufferDays;  //use negative if subtraction required
  except
    Result := EncodeDate(1980,01,01);
  end;


end;

function TfrmMain.Retail_Release(DateStr: String;BufferDays:Integer): Real;
var
  Year, Month, Day: Word;
begin
  Year := StrToInt(Copy(DateStr,1,4));
  Month := StrToInt(Copy(DateStr,5,2));
  Day := StrToInt(Copy(DateStr,7,2));
  Result := 0;

  if EncodeDate(Year,Month,Day) > Now then
    Result := (EncodeDate(Year,Month,Day)-Now)+BufferDays;    //Add 5 days

  if Result < 0 then
    Result := 0
  else
    Result := Result / 30;

end;
function TfrmMain.GetStkInd(CompanyID:Integer;StkInd: String): String;
begin

  Result := Trim(StkInd);

  if (StkInd <> 'Y') then
    Result := 'N'
  else
    Result := 'Y';

end;


procedure TfrmMain.NewItems(CompanyID:Integer);
var
  ImportPath,FNum,InFileName,LineOfData,ProdCode,LocCode:String;
  InFile:TextFile;
  FCount:Integer;
begin
    Say('Checking New Items');

    ImportPath := ExtractFilePath(GetParam('Lookup File'));
    Say('Checking New Items in :'+ImportPath);

    for FCount := 1 to 9999 do
    begin
      FNum := RightStr('000'+IntToStr(FCount),4);

      InFileName :=ImportPath+ 'New_Item_'+FNum+'.txt';

      if FileExists(InFileName) then
      begin
        Say('---------------------------');
        Say('New Items .. Reading : '+InFileName);
        AssignFile(InFile,InFileName);
        Reset(InFile);

        while not eof(InFile) do
        begin
          Readln(InFile,LineOfData);
          Say(LineOfData);
          ProdCode := Trim(Copy(LineOfData,1,25));
          LocCode := Trim(Copy(LineOfData,58,30));

          UpdateLocationInd(CompanyID,ProdCode,LocCode);


        end;

        CloseFile(InFile);
        DeleteFile(InFileName);
        Say('---------------------------');
      end;

    end;


end;

function TfrmMain.UpdateLocationInd(CompanyID:Integer;ProdCode,LocCode:String):Boolean;
var
  LocationIndicator:String;
  IndexNo,LocationOffset:Integer;
begin

 IndexNo := FindProd(ProdCode,LocCode);
 Result := False;

 if IndexNo >= 0 then
 begin
   LocationIndicator := (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo];

   LocationOffset := dmData.GetLocationOffset(LocCode);

   if LocationOffset > 0 then
   begin
     LocationIndicator := StuffString(LocationIndicator,LocationOffset,1,'Y');
     (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator;
     Result := True;
   end;

 end;

end;

function TfrmMain.UpdateLocationIndOffset(LocationOffset:Integer;ProdCode:String):Boolean;
var
  LocationIndicator:String;
  IndexNo:Integer;
begin

 IndexNo := FindProd(ProdCode,'SKU');
 Result := False;

 if IndexNo >= 0 then
 begin
   LocationIndicator := (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo];

   if LocationOffset > 0 then
   begin
     LocationIndicator := StuffString(LocationIndicator,LocationOffset,1,'Y');
     (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator;
     Result := True;
   end;

 end;

end;


function TfrmMain.FindProd(ProdCode,LocCode:String):Integer;
var
  PCount{,nLen}:Integer;
  TempStr:String;
begin
  Result := -1;

  //if SKU location then simply lookup
  if (CustomerForecastMode) then
  begin

      //nLen := Length(ProdCode);

      for PCount := 0 to ProductList.Count-1 do
      begin

         TempStr := (ProductList.Objects[pCount] as TProductPB).Data[0];

         if (ProdCode = TempStr) then
         begin
           Result := PCount;
           Break;
         end;
         TempStr := (ProductList.Objects[pCount] as TProductPB).Data[1];

         if (ProdCode = TempStr) then
         begin
           Result := PCount;
           Break;
         end;
      end;
  end
  else
  if (Pos('STL',LocCode)=0) then
  begin
    //Result := ProductList.IndexOf(ProdCode);
    for PCount := 0 to ProductList.Count-1 do
    begin

       TempStr := (ProductList.Objects[pCount] as TProductPB).Data[0];

       if (ProdCode = TempStr) then
       begin
         Result := PCount;
         Break;
       end;
    end;
    if Result = -1 then
    begin
      for PCount := 0 to ProductList.Count-1 do
      begin

        TempStr := (ProductList.Objects[pCount] as TProductPB).Data[1];

        if (ProdCode = TempStr) then
        begin
          Result := PCount;
          Break;
        end;
      end;
    end;
  end
  else
  begin

      //nLen := Length(ProdCode);

      for PCount := 0 to ProductList.Count-1 do
      begin

         TempStr := (ProductList.Objects[pCount] as TProductPB).Data[1];

         if (ProdCode = TempStr) then
         begin
           Result := PCount;
           Break;
         end;
      end;


  end;

end;


function TfrmMain.FindMOQ(WorkCentre,MOQ: String): String;
var
 IRow:Integer;
begin

  if frmParameters.vleSource.FindRow(WorkCentre,IRow) then
  begin
    Result := frmParameters.vleSource.Values[Trim(WorkCentre)];
    if Result = '' then Result := '1';
  end
  else
    Result := MOQ;    // if not found in the list then use master value


end;

procedure TfrmMain.CalcModelData;
var
  RecCount,CurPos,NewCount:Integer;
  CurModel,SizeCode,ProdCode:String;
  ModelCost,ModelSell,MaxCost,MaxSell:Real;
  FoundQSize:Boolean;
begin

  CurModel := '';
  CurPos := -1;
  FoundQSize:=False;

  Say('Calculating Model Data');

  for RecCount := 0 to ProductList.Count - 1 do
  begin
    ProdCode := ProductList.Strings[RecCount];

    if CurModel <> (ProductList.Objects[RecCount] as TProductPB).Data[1] then
    begin

      if CurModel <> '' then
      begin

        if not FoundQSize then
        begin
          ModelCost := MaxCost;
          ModelSell := MaxSell;
        end;

        For NewCount := CurPos to RecCount-1 do
        begin
          (ProductList.Objects[NewCount] as TProductPB).Data[6] := FloatToStr(ModelSell);
        end;

      end;

      FoundQSize:=False;
      ModelCost := 0.00;
      ModelSell := 0.00;
      MaxCost:=0.00;
      MaxSell:=0.00;
      CurModel := (ProductList.Objects[RecCount] as TProductPB).Data[1];
      CurPos := RecCount;
    end;

    if RecCount mod 50 = 0 then
    begin
      Label1.Caption := IntToStr(REcCount);
      Application.ProcessMessages;
    end;

    SizeCode := '';

    if Pos('_',ProductList.Strings[RecCount])>0 then
    begin
      SizeCode := Trim(Copy(ProductList.Strings[RecCount],
                       Pos('_',ProductList.Strings[RecCount])+1,
                       Length(ProductList.Strings[RecCount])));
    end;

    if SizeCode = 'Q' then
    begin
      FoundQSize := True;
      ModelCost := StrToFloat((ProductList.Objects[RecCount] as TProductPB).Data[5]);
      ModelSell := StrToFloat((ProductList.Objects[RecCount] as TProductPB).Data[6]);
    end;

    if StrToFloat((ProductList.Objects[RecCount] as TProductPB).Data[5]) > MaxCost then
    begin
      MaxCost := StrToFloat((ProductList.Objects[RecCount] as TProductPB).Data[5]);
      MaxSell := StrToFloat((ProductList.Objects[RecCount] as TProductPB).Data[6]);
    end;

  end;

  //Do last set!
  if not FoundQSize then
  begin
    ModelCost := MaxCost;
    ModelSell := MaxSell;
  end;

    For NewCount := CurPos to RecCount-1 do
    begin
      (ProductList.Objects[NewCount] as TProductPB).Data[6] := FloatToStr(ModelSell);
    end;

  Say('Model Data Calc - Complete.');

end;

procedure TfrmMain.ModelCostSellOverride;
var
  ModelCode,ProdCode:String;
  SumCost,SumExtCost,AveCost:Real;
  SumSell,SumExtSell,AveSell,SumWeighting,SalesOrFC:Real;
  ItemCount,IndexNo,RecNum,Hits:Integer;
  SavePlace: TBookmark;
  DisplayedError:Boolean;

begin

  dmData.OpenItem;
  RecNum := 0;
  Label1.Caption := '0';
  DisplayedError := False;

  Say('Calculating Average Cost and Sell');

  with dmData.qryItem do
  begin

    while not Eof do
    begin
      ModelCode := FieldByName('GroupCode').asString;
      SumWeighting := 0;
      SumExtCost:=0;
      SumExtSell:=0;
      ItemCount := 0;
      SumCost:=0;
      SumSell:=0;
      SavePlace := GetBookMark;

      while (ModelCode = FieldByName('GroupCode').asString) and (not Eof) do
      begin
        ProdCode := Trim(FieldByName('ProductCode').asString);

        IndexNo :=  ProductList.IndexOf(ProdCode);

        if IndexNo >= 0 then
        begin
          SumCost := SumCost + StrToFloat((ProductList.Objects[IndexNo] as TProductPB).Data[5]);
          SumSell := SumSell + StrToFloat((ProductList.Objects[IndexNo] as TProductPB).Data[6]);

          Hits:=0;

          //if FieldByName('Last6Sales').AsFloat > 0 then
          //begin
          //  if FieldByName('SalesAmount_1').AsFloat > 0 then Inc(Hits);
          //  if FieldByName('SalesAmount_2').AsFloat > 0 then Inc(Hits);
          //  if FieldByName('SalesAmount_3').AsFloat > 0 then Inc(Hits);
          //  if FieldByName('SalesAmount_4').AsFloat > 0 then Inc(Hits);
          //  if FieldByName('SalesAmount_5').AsFloat > 0 then Inc(Hits);
          //  if FieldByName('SalesAmount_6').AsFloat > 0 then Inc(Hits);
          //end;

          //as per JT - email - Tuesday, 7 October 2008 1:29 PM
          if FieldByName('Age').asInteger < 3 then
            SalesOrFC := FieldByName('FC6').AsFloat
          else
            SalesOrFC := FieldByName('Last6Sales').AsFloat;

          SumWeighting := SumWeighting + SalesOrFC;

          SumExtCost := SumExtCost + (StrToFloat((ProductList.Objects[IndexNo] as TProductPB).Data[5]) *
                                       SalesOrFC);

          SumExtSell := SumExtSell + (StrToFloat((ProductList.Objects[IndexNo] as TProductPB).Data[6]) *
                                       SalesOrFC);

          //   we only want to average based on a valid cost for a sKU
          if StrToFloat((ProductList.Objects[IndexNo] as TProductPB).Data[5]) > 0 then
            Inc(ItemCount);

          Inc(RecNum);

          if RecNum mod 50 = 0 then
          begin
            Label1.Caption := IntToStr(REcNum);
            Application.ProcessMessages;
          end;


        end;



        next;
      end;

      AveCost := 0;
      AveSell := 0;

      if ItemCount > 0 then
      begin
        if SumWeighting > 0 then
        begin
          AveCost := SumExtCost / SumWeighting;
          AveSell := SumExtSell / SumWeighting;
        end
        else
        begin
          AveCost := 0;
          AveSell := 0;
          //Say('Model ,'+ModelCode+',average cost = 0 for this model',false);

        end

      end
      else
      begin
        if not DisplayedError then
        begin
          Say('### Check Log File for Errors ###');
          DisplayedError := True;
        end;

        Say('Model ,'+ModelCode+',cannot calculate average cost, no costs > 0 exist for this model',false);
      end;


      //if AveCost > 0 then
      if ItemCount > 0 then
      begin

        dmData.qryItem.GotoBookmark(SavePlace);

        while (ModelCode = FieldByName('GroupCode').asString) and (not Eof) do
        begin
          ProdCode := Trim(FieldByName('ProductCode').asString);

          IndexNo :=  ProductList.IndexOf(ProdCode);

          if IndexNo >= 0 then
          begin
            (ProductList.Objects[IndexNo] as TProductPB).Data[5] := FloatToStr(AveCost);
            (ProductList.Objects[IndexNo] as TProductPB).Data[6] := FloatToStr(AveSell);
          end;

          next;
        end;

      end;




    end;

  end;

  Say('Closing');
  Application.ProcessMessages;
  dmData.qryItem.Close;
  Say('Calculating Average Cost and Sell - Complete');
  Application.ProcessMessages;

end;

function TfrmMain.GetOutStr_SL(OutStr,Desc1,Desc2,ColourDesc,FF,SF,PLC,Season,StkInd:String;NewLT:Integer;RetLt,Cost,Sell:Real):String;
var
  SeasGroup,PlcSeasGroup:String;
begin
  if Season = '' then
    Season := '_';

  SeasGroup := Season;

  if (Season='M') or (Season='B') or (Season='W') then
    SeasGroup := 'MB';

  //if (Season='A') or (Season='T') then
  //  SeasGroup := 'AT';

  PlcSeasGroup := PLC+'_'+SeasGroup;

  Result := OutStr + ',' + StkInd;
  Result := Result + ',' + StkInd;  //REpeat for rep cat
  Result := Result + ',' + IntToStr(NewLT);
  Result := Result + ',Y'; //Import Indicator

  Result := Result + ','+PLC+SF; //for excess combo
  Result := Result + ','+Season+SF;
  Result := Result + ','+PLC;
  Result := Result + ','+SF;
  Result := Result + ',' + SeasGroup;
  Result := Result + ',' + PLCSeasGroup;
  Result := Result  + ','+Trim(Desc1)+'('+Trim(Desc2)+')';
  Result := Result  + ','+Trim(Desc1) + ' '+ ColourDesc;
  Result := Result + ',' + Format('%7.2f',[RetLT]);
  Result := Result  + ',' + Format('%11.3f',[Cost]);
  Result := Result  + ',' + Format('%11.3f',[Sell]);
end;

procedure TfrmMain.AddCustLocsFromProdClass();
var
  ImportPath,FNum,InFileName,LineOfData,ProdClass,LocCode,ProdCode,ModelCode,ModelLoc,SkuCode,SkuLoc,LocationIndicator,ProdListKey,LocAppCode:String;
  InFile:TextFile;
  RecNo,FCount,Index,SIndex,PCIndex,ModelLocOffset,SkuLocOffset:Integer;
  oLocCode:TString;
  ProdClassList:TStringList;
  StateArray:Array[0..5] of String;

begin

  Say('Adding customer locations from Product Class');
  Say('--------------------------------------------');
  InFileName := ExtractFilePath(ParamStr(0))+'ProdClassLookup.txt';

  if FileExists(InFileName) then
  begin
    Say('Creating Product Class Lookup');
    Say('-----------------------------');
    AssignFile(InFile,InFileName);
    Reset(InFile);
    RecNo := -1;
    ProdClassList := tStringList.Create;
    While not eof(InFile) do
    begin
      ReadLn(InFile,LineOfData);
      //1st record contains headers
      if RecNo >= 0 then
      begin
        ProdClass := Trim(Copy(LineOfData,1,15));
        LocCode := Trim(Copy(LineOfData,17,10));
        oLocCode := TString.Create(LocCode);
        ProdClassList.AddObject(ProdClass,oLocCode);
      end;
      Inc(RecNo);
    end;
    CloseFile(InFile);
    Say('Reading Lookup File');
    Say('--------------------------------------------');
    BuildProdList;
    Say('Creating model locations');
    Say('------------------------');
    StateArray[0] := 'NSW';
    StateArray[1] := 'QLD';
    StateArray[2] := 'SAU';
    StateArray[3] := 'TAS';
    StateArray[4] := 'VIC';
    StateArray[5] := 'WAU';

    ProdClass := '';
    LocCode := '';
    //Loop through the UProductList
    for Index := 0 to ProductList.Count - 1 do
    begin
      LocAppCode :=  Trim((ProductList.Objects[Index] as TProductPB).Data[2]);
      if (UpperCase(StrUtils.RightStr(LocAppCode,4)) = '_APP') then //Sleepmaker business
      begin
        if (getCountry(LocAppCode) <> 'NZ') then
        begin
              ProdCode := Trim((ProductList.Objects[Index] as TProductPB).Data[0]);
              //Add to the customer model location in all states if it has a model code.
              ModelCode := Trim((ProductList.Objects[Index] as TProductPB).Data[1]);
              //if ModelCode =  'T22205' then
                //ModelCode := 'T22205';  //For debugging only
              if ModelCode <> '' then
              begin
                ProdClass := Trim((ProductList.Objects[Index] as TProductPB).Data[8]);
                //Lookup the product Class in the lookup
                if ProdClass <> '' then
                begin
                  PCIndex := ProdClassList.IndexOf(ProdClass);
                  if PCIndex >= 0 then
                  begin
                    LocCode := TString(ProdClassList.Objects[PCIndex]).Str;
                  end
                  else
                  begin
                    LocCode := 'ZZ';
                  end;
                end
                else
                begin
                  LocCode := 'ZZ';
                end;
                LocationIndicator := (ProductList.Objects[Index] as TProductPB).Data[FLookupStructure.LocIndexNo];
                for SIndex := 0 to 5 do
                begin
                    ModelLoc := StateArray[SIndex]+ 'STL' + LocCode;
                    ModelLocOffset := dmData.GetLocationOffset(ModelLoc);
                    if ModelLocOffset > 0 then
                    begin
                      LocationIndicator := StuffString(LocationIndicator,ModelLocOffset,1,'Y');
                    end
                    else
                    begin
                      ModelLoc := StateArray[SIndex]+ 'STLZZ';
                      ModelLocOffset := dmData.GetLocationOffset(ModelLoc);
                      if ModelLocOffset > 0 then
                      begin
                        LocationIndicator := StuffString(LocationIndicator,ModelLocOffset,1,'Y');
                      end
                    end;
                    (ProductList.Objects[Index] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator;
                  end;
                end;
              end;
            end;
       if Index mod 50 = 0 then
       begin
        Label1.Caption := IntToStr(Index);
        Application.ProcessMessages;
       end;
    end;
    SaveProdList;
    ProductListFree;
    ProdClassList.Free;
  end;
end;

procedure TfrmMain.AddCustLocsFromProdClassNZ();
var
  ImportPath,FNum,InFileName,LineOfData,ProdClass,LocCode,ProdCode,ModelCode,ModelLoc,SkuCode,SkuLoc,LocationIndicator,ProdListKey,LocAppCode:String;
  InFile:TextFile;
  RecNo,FCount,Index,SIndex,PCIndex,ModelLocOffset,SkuLocOffset:Integer;
  oLocCode:TString;
  ProdClassList:TStringList;
  StateArray:Array[0..1] of String;

begin

  Say('Adding customer locations from Product Class NZ');
  Say('-----------------------------------------------');
  InFileName := ExtractFilePath(ParamStr(0))+'ProdClassLookupNZ.txt';

  if FileExists(InFileName) then
  begin
    Say('Creating Product Class Lookup NZ');
    Say('--------------------------------');
    AssignFile(InFile,InFileName);
    Reset(InFile);
    RecNo := -1;
    ProdClassList := tStringList.Create;
    While not eof(InFile) do
    begin
      ReadLn(InFile,LineOfData);
      //1st record contains headers
      if RecNo >= 0 then
      begin
        ProdClass := Trim(Copy(LineOfData,1,15));
        LocCode := Trim(Copy(LineOfData,17,10));
        oLocCode := TString.Create(LocCode);
        ProdClassList.AddObject(ProdClass,oLocCode);
      end;
      Inc(RecNo);
    end;
    CloseFile(InFile);
    Say('Reading Lookup File');
    Say('--------------------------------------------');
    BuildProdList;
    Say('Creating model locations');
    Say('------------------------');
    StateArray[0] := 'NTH';
    StateArray[1] := 'STH';
 
    ProdClass := '';
    LocCode := '';
    //Loop through the ProductList
    for Index := 0 to ProductList.Count - 1 do
    begin
      LocAppCode :=  Trim((ProductList.Objects[Index] as TProductPB).Data[2]);
      if (UpperCase(StrUtils.RightStr(LocAppCode,4)) = '_APP') then //Sleepmaker business
      begin
        if (getCountry(LocAppCode) = 'NZ') then
        begin
              ProdCode := Trim((ProductList.Objects[Index] as TProductPB).Data[0]);
              //Add to the customer model location in all states if it has a model code.
              ModelCode := Trim((ProductList.Objects[Index] as TProductPB).Data[1]);
              //if ModelCode =  'T22205' then
                //ModelCode := 'T22205';  //For debugging only
              if ModelCode <> '' then
              begin
                ProdClass := Trim((ProductList.Objects[Index] as TProductPB).Data[8]);
                //Lookup the product Class in the lookup
                if ProdClass <> '' then
                begin
                  PCIndex := ProdClassList.IndexOf(ProdClass);
                  if PCIndex >= 0 then
                  begin
                    LocCode := TString(ProdClassList.Objects[PCIndex]).Str;
                  end
                  else
                  begin
                    LocCode := 'ZZ';
                  end;
                end
                else
                begin
                  LocCode := 'ZZ';
                end;
                LocationIndicator := (ProductList.Objects[Index] as TProductPB).Data[FLookupStructure.LocIndexNo];
                for SIndex := 0 to 1 do
                begin
                    ModelLoc := StateArray[SIndex]+ 'STL' + LocCode;
                    ModelLocOffset := dmData.GetLocationOffset(ModelLoc);
                    if ModelLocOffset > 0 then
                    begin
                      LocationIndicator := StuffString(LocationIndicator,ModelLocOffset,1,'Y');
                    end
                    else
                    begin
                      ModelLoc := StateArray[SIndex]+ 'STLZZ';
                      ModelLocOffset := dmData.GetLocationOffset(ModelLoc);
                      if ModelLocOffset > 0 then
                      begin
                        LocationIndicator := StuffString(LocationIndicator,ModelLocOffset,1,'Y');
                      end
                    end;
                    (ProductList.Objects[Index] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator;
                end;
              end;
          end;
       end;
       if Index mod 50 = 0 then
       begin
        Label1.Caption := IntToStr(Index);
        Application.ProcessMessages;
       end;
    end;
    SaveProdList;
    ProductListFree;
    ProdClassList.Free;
  end;
end;

function TfrmMain.getCountry(SearchStr:String):String;
var
  RecNo:Integer;
begin

  Result := 'AUS';
  SearchStr := uppercase(SearchStr);

  for RecNo := 0 to FWarehouseStructure.MaxWarehouse-1 do
  begin

    if FWarehouseStructure.Data[RecNo].Warehouse = SearchStr then
    begin
      Result := FWarehouseStructure.Data[RecNo].Description;
      Break;
    end;

  end;

end;

procedure TfrmMain.UpdateLookupFromDB();
var
  LineOfData,LocCodeSect,SlhLocCode,WhLkupRevFileName,ProductCode,LocationCode:String;
  ModelCode,WarehouseCode,ProductKey,ModelKey,CurKey,LocIndicator,TempStr:String;
  LocOffset:Integer;
  WhLkupRevFile:TextFile;
  oSlhLocCode:TString;
  WhLkupRevList,ModelList:TStringList;
  WhLkupRevIndex,ProductIndex,ModelIndex,Index,i:Integer;
begin
  try
    Say('Updating Lookup File from Database');
    Say('--------------------------------------------');
    Say('CreatingModelList');
    Say('--------------------------------------------');
    ModelList := tStringList.Create;
    ModelList.Sorted := True;
    ModelList.Duplicates := dupIgnore;
    for Index := 0 to ProductList.Count - 1 do
    begin
      ModelCode := Trim((ProductList.Objects[Index] as TProductPB).Data[1]);
      if ModelCode <> '' then
      begin
        WarehouseCode := Trim((ProductList.Objects[Index] as TProductPB).Data[2]);
        ModelKey := WarehouseCode + '|' + ModelCode;
        ModelList.AddObject(ModelKey, ProductList.Objects[Index]);
      end;
      if Index mod 50 = 0 then
      begin
        Label1.Caption := IntToStr(Index);
        Application.ProcessMessages;
      end;
    end;
    Say('Getting Item List');
    Say('--------------------------------------------');
    dmData.qryItemProdLocAll.Open;
    dmData.qryItemProdLocAll.First;
    i:=0;
    CurKey := '';
    Say('Updating Lookup List');
    Say('--------------------------------------------');
    while (not dmData.qryItemProdLocAll.eof) do
    begin
      inc(i);
      LocationCode := dmData.qryItemProdLocAll['LOCATIONCODE'];
      LocOffset := dmData.GetLocationOffset(LocationCode);
      ProductCode := dmData.qryItemProdLocAll['PRODUCTCODE'];
      SlhLocCode := dmData.qryItemProdLocAll['SLHWAREHOUSECODE'];
      ProductKey := dmData.qryItemProdLocAll['PRODUCTKEY'];
      if ProductKey <> CurKey then
      begin
        CurKey := ProductKey;
        //Try and find the product in the main lookup
        ProductIndex := ProductList.IndexOf(ProductKey);
        if (ProductIndex < 0) then
        begin
          //Try and find the product in the model lookup
          ModelIndex := ModelList.IndexOf(ProductKey);
        end;
      end;
      if (ProductIndex >= 0) then
      begin
        LocIndicator := (ProductList.Objects[ProductIndex] as TProductPB).Data[FLookupStructure.LocIndexNo];
        if LocOffset > 0 then
        begin
          LocIndicator := StuffString(LocIndicator,LocOffset,1,'Y');
          (ProductList.Objects[ProductIndex] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocIndicator;
        end;
      end
      else if (ModelIndex >= 0) then
      begin
        LocIndicator := (ModelList.Objects[ModelIndex] as TProductPB).Data[FLookupStructure.LocIndexNo];
        if LocOffset > 0 then
        begin
          LocIndicator := StuffString(LocIndicator,LocOffset,1,'Y');
          (ModelList.Objects[ModelIndex] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocIndicator;
        end;
      end;
      dmData.qryItemProdLocAll.Next;
      if i mod 50 = 0 then
      begin
        Label1.Caption := IntToStr(i);
        Application.ProcessMessages;
      end;
    end;
  finally
    ModelList.Free;
  end;
end;

procedure TfrmMain.GenerateFoamsDisagItems();
var
  LocAppCode,InFileName,LineOfData,FCLocCode,DisagLocCodes,DisagLocCode,LocIndicators,LocIndicator:String;
  InFile:TextFile;
  RecNo,Index,i,j,FCLocOffset,DisagLocOffset,DelimPos:Integer;
  FCLocsList,DisagLocsList:TStringList;
  oDisagLocCodes:TString;
begin
  Say('Adding intermediate disag locations for foams forecast locations');
  Say('----------------------------------------------------------------');
  InFileName := ExtractFilePath(ParamStr(0))+'DisagLocsFoamsLookup.txt';
  if FileExists(InFileName) then
  begin
    Say('Creating Disag Location Lookup');
    Say('--------------------------------');
    AssignFile(InFile,InFileName);
    Reset(InFile);
    RecNo := -1;
    FCLocsList := tStringList.Create;
    DisagLocsList := tStringList.Create;
    While not eof(InFile) do
    begin
      ReadLn(InFile,LineOfData);
      //1st record contains headers
      if RecNo >= 0 then
      begin
        FCLocCode := Trim(Copy(LineOfData,1,15));
        DisagLocCodes := Trim(Copy(LineOfData,17,1000));
        oDisagLocCodes := TString.Create(DisagLocCodes);
        FCLocsList.AddObject(FCLocCode,oDisagLocCodes);
      end;
      Inc(RecNo);
    end;
    CloseFile(InFile);
    //Loop through the ProductList
    for Index := 0 to ProductList.Count - 1 do
    begin
      LocAppCode :=  Trim((ProductList.Objects[Index] as TProductPB).Data[2]);
      if (UpperCase(StrUtils.RightStr(LocAppCode,4)) = '_JBA') then //Foams business
      begin
        //Loop through the FC Loc Codes
        for i:=0 to FCLocsList.Count - 1 do
        begin
          FCLocCode := FCLocsList.Strings[i];
          FCLocOffset := dmData.GetLocationOffset(FCLocCode);
          LocIndicators := (ProductList.Objects[Index] as TProductPB).Data[FLookupStructure.LocIndexNo];
          LocIndicator := LocIndicators[FCLocOffset];
          if LocIndicator = 'Y' then  //The FC location exists for this product so must create disag locations
          begin
            //create an array of disag locations from the comma delimited string
            DisagLocCodes := TString(FCLocsList.Objects[i]).Str;
            DisagLocsList.Clear;
            ExtractStrings([','], [], PChar(DisagLocCodes), DisagLocsList);
            for j:=0 to DisagLocsList.Count - 1 do
            begin
              DisagLocCode := DisagLocsList.Strings[j];
              DelimPos := AnsiPos('|', DisagLocCode);
              if DelimPos > 0 then
                DisagLocCode := Copy(DisagLocCode,1, DelimPos - 1);
              DisagLocOffset := dmData.GetLocationOffset(DisagLocCode);
              LocIndicators := StuffString(LocIndicators,DisagLocOffset,1,'Y');
            end;
            (ProductList.Objects[Index] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocIndicators;
          end;
        end;
      end;
    end;
    FCLocsList.Free;
    DisagLocsList.Free;
  end;
end;

end.
