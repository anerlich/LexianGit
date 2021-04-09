unit uCompany;

interface

uses SysUtils,StrUtils,Classes;

Const
  _Holeproof = 0;   // This is underwear Hosiery now...leave identity for now
  _KingGee = 1;
  _DSE = 2;
  _DSA = 3;
  _Bonds = 4;
  _Berlei = 5;
  _Footwear = 6;
  _Leisure = 7;
  _Hosiery = 8;
  _Footwear2 = 9;
  _Tontine = 10;
  _ClothingNZ = 11;
  _Sheridan = 12;
  _Sleepmaker = 13;
  _Stubbies = 14;
  _Workwear = 15;
  _WWForecast  = 16;
  _WWPlan = 17;               //Workwear (King Gee, Yakka, CTE)

  _MaxCompany = 15;

  _MaxLookupField = 10;

  _MaxCust = 200;
  _MaxWarehouse = 200;
  _MaxLocs=300;

type
  TString = class(TObject)
  private
    fStr: String;
  public
    constructor Create(const AStr: String) ;
    property Str: String read FStr write FStr;
  end;

type

  TlookupFieldType = (_lftString,_lftBoolean,_lftFloat);

  TlookupRec = Record
    Name:String;
    Start:Integer;
    Length:Integer;
    Value:String;
    OutStr:String;
    FieldType:TlookupFieldType;
  end;

  TLookupStructure = record
    FieldCount:Integer;
    MaxLocation:Integer;
    ProdIndexNo:Integer;
    LocIndexNo:Integer;
    FlagIndexNo:Integer;
    Fields:Array[0.._MaxLookupField] of TLookupRec;
  end;

  TCustRec = Record
    Category:String;
    LocCode:String;
    Description:String;
    Exception:Boolean;
  end;

  TCustStructure = record
    MaxCust:Integer;
    DefaultLoc:String;
    DefaultException:Boolean;
    Data:Array[0.._MaxCust] of TCustRec;
  end;

  TWarehouseRec = Record
    Warehouse:String;
    State:String;
    LocCode:String;
    Description:String;
    Exception:Boolean;
  end;

  TWarehouseStructure = record
    MaxWarehouse:Integer;
    DefaultLoc:String;
    Data:Array[0.._MaxWarehouse] of TWarehouseRec;
  end;

  TTerritoryStructure = record
    MaxTerritory:Integer;
    DefaultLoc:String;
    Data:Array[0.._MaxWarehouse] of TWarehouseRec;
  end;

  TProductPB = class(TObject)
    Data:Array[0.._MaxLookupField] of String;
  end;

  TLocReturn = (_lrSku,_lrStyle,_lrSkuAndStyle,_lrCategory);

var
  FLookupStructure:TLookupStructure;
  FCustStructure:TCustStructure;
  FCustStructureNZ:TCustStructure;
  FExcludeStyles,FExcludeAccounts,FExcludeFromNational:String;
  FExcludeOrderType,FExcludeNationalType,FIwtAccounts:String;
  FWarehouseStructure:TWarehouseStructure;
  FTerritoryStructure:TTerritoryStructure;
  FFoamsForecastLocsList:TStringList;
  FKIPLocationList:TStringList;

function GetCompanyID(CompanyName:String):Integer;
function GetCompanyName(CompanyID:Integer):String;
function GetCompanyCode(CompanyName:String):String;
procedure ConvertSKUCode(CompanyID:Integer;ProdCode:String;
                         var StyleCode,ColourCode,DimCode,SizeCode:String);
function GetCompanyProdCode(CompanyID:Integer; StyleCode,ColourCode,DimCode,SizeCode:String;UseSwitch:Boolean=false):String;
function Get_OLD_CompanyProdCode(CompanyID:Integer; StyleCode,ColourCode,DimCode,SizeCode:String;UseSwitch:Boolean=false):String;
function Pac_StrToDate(DateStr: String): TDateTime;
function Get_Alt_Lt(LT,ReleaseDate:String;BufferDays:Integer):Integer;
function GetDivCode(CompanyID:Integer;NewCode:String):String;
function GetWarehouseCode(CompanyID:Integer;DivCode,LocCode:String):String;
procedure BuildLookupStructure(CompanyID:Integer);
procedure SetLookupValues(StringOfData:String);
procedure SetLookupFieldTypes;
function NewObjectPB:TProductPB;
function LookupOutFormat:String;
procedure SetLookupStructure(FieldNo:Integer;Name:String;Start,Length:Integer;OutFormat:String);
function GetCustLocationCode(SearchStr:String;var Loc1,Loc2,Loc3:String;ReturnLoc:TLocReturn):Boolean;
function GetCustLocationCodeNZ(SearchStr:String;var Loc1,Loc2,Loc3:String;ReturnLoc:TLocReturn):Boolean;
Procedure set_Exclude_KG(ExcludeStyles,ExcludeAccounts,ExcludeFromNational,ExcludeOrderType,ExcludeNationalType:String);
function GetDesignCode(Style,Colour:String):String;
procedure GetWarehouseLocation_SL(Warehouse:String; var Loc1,Loc2,Loc3,Country:String);
function GetWarehouseLocationCode(SearchStr:String;var Loc1, Country:String):Boolean;
function GetTerritoryLocationCode(SearchStr:String;var Loc1:String):Boolean;
function GetVendorName(Warehouse:String):String;
function IsStyleColour(LocCode: String): Boolean;
procedure ConvertOLDSKUCode(CompanyID:Integer;ProdCode:String;
                         var StyleCode,ColourCode,DimCode,SizeCode:String);
function StateToTerritory(StateCode:String):String;

function CompareTProductPBObjects(ProductObject1:TProductPB; ProductObject2:TProductPB; StartPosition:Integer):Integer;
function GetFoamsDisagLoc(FCLocCode, PlanLocCode:String):String;
function Kip_Processing(Warehouse, Location: string):String ;
Implementation

constructor TString.Create(const AStr: String) ;
begin
   inherited Create;
   FStr := AStr;
end;

function GetCompanyID(CompanyName:String):Integer;
begin
  CompanyName := UpperCase(CompanyName);

  Result := -1;

  if CompanyName = 'HOLEPROOF' then Result := _Holeproof;
  if CompanyName = 'UNDERWEARHOSIERY' then Result := _Holeproof;  //keep this identitiy for now

  //divert these in case
  if CompanyName = 'BERLEI' then Result := _Holeproof;
  if CompanyName = 'HOSIERY' then Result := _Holeproof;
  //----------------------------------------------------------

  //These have been amalgamated
  //if CompanyName = 'DSA' then Result := _DSA;
  //if CompanyName = 'BERLEI' then Result := _Berlei;
  //if CompanyName = 'HOSIERY' then Result := _Hosiery;
  //if CompanyName = 'FOOTWEAR2' then Result := _Footwear2;
  if CompanyName = 'KINGGEE' then Result := _KingGee;
  if CompanyName = 'DSE' then Result := _DSE;
  if CompanyName = 'BONDS' then Result := _Bonds;
  if CompanyName = 'FOOTWEAR' then Result := _Footwear;
  if CompanyName = 'LEISURE' then Result := _Leisure;
  if CompanyName = 'TONTINE' then Result := _Tontine;
  if CompanyName = 'CLOTHINGNZ' then Result := _ClothingNZ;
  if CompanyName = 'SHERIDAN' then Result := _Sheridan;
  if CompanyName = 'SLEEPMAKER' then Result := _SleepMaker;
  if CompanyName = 'STUBBIES' then Result := _Stubbies;
  if CompanyName = 'WORKWEAR' then Result := _Workwear;
end;

function GetCompanyName(CompanyID:Integer):String;
begin
  Result := '';

  //if CompanyID = _Holeproof then Result := 'Holeproof' ;
  if CompanyID = _Holeproof then Result := 'UnderwearHosiery' ;
  //if CompanyID = _UnderwearHosiery then Result := 'UnderwearHosiery' ;

  if CompanyID = _KingGee then Result := 'KingGee';
  if CompanyID = _DSE then Result := 'DSE';
  if CompanyID = _DSA then Result := ''; //'DSA';
  if CompanyID = _Bonds then Result := 'Bonds';
  if CompanyID = _Berlei then Result := ''; //'Berlei';
  if CompanyID = _Footwear then Result := 'Footwear';
  if CompanyID = _Leisure then Result := 'Leisure';
  if CompanyID = _Hosiery then Result := ''; //'Hosiery';
  if CompanyID = _Footwear2 then Result := ''; //'Footwear2';
  if CompanyID = _Tontine then Result := 'Tontine';
  if CompanyID = _ClothingNZ then Result := 'ClothingNZ';
  if CompanyID = _Sheridan then Result := 'Sheridan';
  if CompanyID = _Sleepmaker then Result := 'Sleepmaker';
  if CompanyID = _Stubbies then Result := 'Stubbies';
  if CompanyID = _Workwear then Result := 'Workwear';

end;

function GetCompanyCode(CompanyName:String):String;
const
  _UW = 'UW';
  _FW = 'FW';
  _WK = 'WK';
  _DefaultCompanyCode = 'UW';
  _Unknown = '  ';
begin
  CompanyName := UpperCase(CompanyName);

  Result := 'UW';

  if CompanyName = 'HOLEPROOF' then Result := _UW;
  if CompanyName = 'KINGGEE' then Result := _WK;
  if CompanyName = 'DSE' then Result := _UW;
  if CompanyName = 'DSA' then Result := _FW;
  if CompanyName = 'BONDS' then Result := _UW;
  if CompanyName = 'BERLEI' then Result := _UW;
  if CompanyName = 'FOOTWEAR' then Result := _FW;
  if CompanyName = 'LEISURE' then Result := _UW;
  if CompanyName = 'HOSIERY' then Result := _UW;
  if CompanyName = 'FOOTWEAR2' then Result := _FW;
  if CompanyName = 'TONTINE' then Result := _Unknown;
  if CompanyName = 'CLOTHINGNZ' then Result := _UW;
  if CompanyName = 'SHERIDAN' then Result := _Unknown;
  if CompanyName = 'SLEEPMAKER' then Result := _Unknown;
  if CompanyName = 'STUBBIES' then Result := _UW;
  if CompanyName = 'WORKWEAR' then Result := _Unknown;
end;

procedure ConvertSKUCode(CompanyID:Integer;ProdCode:String;
                         var StyleCode,ColourCode,DimCode,SizeCode:String);
var
  TempStr:String;
begin
  StyleCode := '';
  ColourCode := '';
  DimCode := '';
  SizeCode := '';

  if (CompanyID in [_Holeproof,_Footwear,_KingGee]) then
  begin
    // fixed length style/color with delimiter
    // then Size Dimension
    //  Style_Colour_Size_Dimension

    StyleCode := Copy(ProdCode,1,6);
    ColourCode := Copy(ProdCode,8,3);

    //assume fixed length upto this position then size can vary.
    TempStr := Trim(Copy(ProdCode,12,Length(ProdCode)));

    SizeCode := '';
    DimCode := '';

    //Size could be 3 or more!!!!
    if Pos('_',TempStr)>0 then
    begin
      SizeCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      DimCode := TempStr; //Dimension is the remaining portion
    end
    else
    begin
      //No dimension then use the remaining portion
      SizeCode := TempStr;
      TempStr := '';
    end;



  end;

  if (CompanyID in [_Stubbies]) then
  begin
    // fixed length style/color size with delimiter

    StyleCode := Copy(ProdCode,1,6);
    ColourCode := Copy(ProdCode,8,3);
    DimCode := Copy(ProdCode,12,3);
    SizeCode := Copy(ProdCode,16,3);
  end;

  //Holeproof new format email JT   Thursday, 2 July 2009 6:05 PM
  //   Holeproof removed .... now has delimiter
  if CompanyID in [_Bonds,_Berlei] then
  begin
    // fixed length style/color size NO delimiter

    StyleCode := Copy(ProdCode,1,6);
    ColourCode := Copy(ProdCode,7,3);
    DimCode := Copy(ProdCode,10,3);
    SizeCode := Copy(ProdCode,13,3);
  end;

  if (CompanyID = _DSE) or (CompanyID = _DSA) or (CompanyID = _Leisure)  or
     (CompanyID = _Hosiery) or (CompanyID = _Footwear2) or  (CompanyID = _Tontine) then
  begin

    //No Dimension variable length style/color size

    TempStr := ProdCode;

    if Pos('_',TempStr)>0 then
    begin
      StyleCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      ColourCode := TempStr;
    end
    else
      StyleCode := TempStr;

    if Pos('_',TempStr)>0 then
    begin
      ColourCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      SizeCode := TempStr;
    end;


  end;

  if (CompanyID = _Sheridan) then
  begin

    TempStr := ProdCode;

    if Pos('_',TempStr)>0 then
    begin
      StyleCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      ColourCode := TempStr;
    end
    else
      StyleCode := TempStr;

    if Pos('_',TempStr)>0 then
    begin
      ColourCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      SizeCode := TempStr;
    end;


  end;

  if (CompanyID = _Sleepmaker) then
  begin

    TempStr := ProdCode;

    if Pos('_',TempStr)>0 then
    begin
      StyleCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      SizeCode := TempStr;
    end
    else
      StyleCode := TempStr;

    //if Pos('_',TempStr)>0 then
    //begin
    //  ColourCode := Copy(TempStr,1,Pos('_',TempStr)-1);
    //  TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
    //  SizeCode := TempStr;
    //end;


  end;

  if (CompanyID in [_ClothingNZ,_Workwear]) then
  begin

    //Includes Dimension and variable length style/color size

    TempStr := ProdCode;

    if Pos('_',TempStr)>0 then
    begin
      StyleCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      ColourCode := TempStr;
    end
    else
    begin
      StyleCode := TempStr;
      TempStr := '';
    end;

    if Pos('_',TempStr)>0 then
    begin
      ColourCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      DimCode := TempStr;
    end
    else
    begin
      ColourCode := TempStr;
      TempStr := '';
    end;

    if Pos('_',TempStr)>0 then
    begin
      DimCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      SizeCode := TempStr;
    end
    else
    begin
      DimCode := TempStr;
      TempStr := '';
    end;


  end;

end;

procedure ConvertOldSKUCode(CompanyID:Integer;ProdCode:String;
                         var StyleCode,ColourCode,DimCode,SizeCode:String);
var
  TempStr:String;
begin
  StyleCode := '';
  ColourCode := '';
  DimCode := '';
  SizeCode := '';

  if CompanyID = _Holeproof then
  begin
    //No Dimension fixed length style/color size

    StyleCode := Copy(ProdCode,1,6);
    ColourCode := Copy(ProdCode,8,3);
    DimCode := '';
    SizeCode := Copy(ProdCode,12,3);
  end;

  if (CompanyID in [_KingGee,_Stubbies]) then
  begin
    // fixed length style/color size with delimiter

    StyleCode := Copy(ProdCode,1,6);
    ColourCode := Copy(ProdCode,8,3);
    DimCode := Copy(ProdCode,12,3);
    SizeCode := Copy(ProdCode,16,3);
  end;

  if CompanyID in [_Bonds,_Berlei] then
  begin
    // fixed length style/color size NO delimiter

    StyleCode := Copy(ProdCode,1,6);
    ColourCode := Copy(ProdCode,7,3);
    DimCode := Copy(ProdCode,10,3);
    SizeCode := Copy(ProdCode,13,3);
  end;

  if (CompanyID = _DSE) or (CompanyID = _DSA) or (CompanyID = _Leisure)  or
     (CompanyID = _Hosiery) or (CompanyID = _Footwear2) or  (CompanyID = _Tontine) then
  begin

    //No Dimension variable length style/color size

    TempStr := ProdCode;

    if Pos('_',TempStr)>0 then
    begin
      StyleCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      ColourCode := TempStr;
    end
    else
      StyleCode := TempStr;

    if Pos('_',TempStr)>0 then
    begin
      ColourCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      SizeCode := TempStr;
    end;


  end;

  if (CompanyID = _Sheridan) then
  begin

    TempStr := ProdCode;

    if Pos('_',TempStr)>0 then
    begin
      StyleCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      ColourCode := TempStr;
    end
    else
      StyleCode := TempStr;

    if Pos('_',TempStr)>0 then
    begin
      ColourCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      SizeCode := TempStr;
    end;


  end;

  if (CompanyID = _Sleepmaker) then
  begin

    TempStr := ProdCode;

    if Pos('_',TempStr)>0 then
    begin
      StyleCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      SizeCode := TempStr;
    end
    else
      StyleCode := TempStr;

    //if Pos('_',TempStr)>0 then
    //begin
    //  ColourCode := Copy(TempStr,1,Pos('_',TempStr)-1);
    //  TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
    //  SizeCode := TempStr;
    //end;


  end;

  if (CompanyID in [_Footwear,_ClothingNZ,_Workwear]) then
  begin

    //Includes Dimension and variable length style/color size

    TempStr := ProdCode;

    if Pos('_',TempStr)>0 then
    begin
      StyleCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      ColourCode := TempStr;
    end
    else
    begin
      StyleCode := TempStr;
      TempStr := '';
    end;

    if Pos('_',TempStr)>0 then
    begin
      ColourCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      DimCode := TempStr;
    end
    else
    begin
      ColourCode := TempStr;
      TempStr := '';
    end;

    if Pos('_',TempStr)>0 then
    begin
      DimCode := Copy(TempStr,1,Pos('_',TempStr)-1);
      TempStr := Copy(TempStr,Pos('_',TempStr)+1,Length(TempStr));
      SizeCode := TempStr;
    end
    else
    begin
      DimCode := TempStr;
      TempStr := '';
    end;


  end;

end;

function GetCompanyProdCode(CompanyID:Integer; StyleCode,ColourCode,DimCode,SizeCode:String;UseSwitch:Boolean=false):String;
begin
  //Use Switch is compatibility for new data prepares, where King Gee switches size and dim around
  //Format fixed width ones
  if CompanyID in [_Holeproof,_KingGee,_Bonds,_Berlei,_Stubbies,_Footwear,_Hosiery] then
  begin
    StyleCode := Format('%-6s',[StyleCode]);
    ColourCode := Format('%-3s',[ColourCode]) ;
    DimCode := Format('%-3s',[DimCode]);
    if CompanyID = _Footwear then
      SizeCode := Format('%-5s',[SizeCode])
    else
      SizeCode := Format('%-3s',[SizeCode]) ;   // This a minimum of 3. where the size is > 3, then this is not
                                              // truncated.


  end
  else
  begin
    StyleCode := Trim(StyleCode);
    ColourCode := Trim(ColourCode) ;

    if CompanyID <> _DSE then
      SizeCode := Trim(SizeCode);

    DimCode := Trim(DimCode);

    if (CompanyID = _Workwear) and (SizeCode<>'') and (DimCode='') then
      DimCode := 'NA';   //JT email - Tuesday, 2 December 2008 3:58 PM


  end;

  if CompanyID = _Sheridan then
  begin
    SizeCode:='';
    DimCode:='';
  end;

  if CompanyID = _Sleepmaker then
  begin
    DimCode := '';
    ColourCode := '';
  end;

  if not (CompanyID in [_Bonds,_Berlei]) then
  begin

    if CompanyID in [_ClothingNZ] then
    begin

      if Trim(DimCode) <> '' then
      begin
          ColourCode := '_'+ColourCode;
          SizeCode := '_'+SizeCode;
          DimCode := '_'+DimCode;
      end
      else
      begin
        if Trim(SizeCode) <> '' then
        begin
          ColourCode := '_'+Trim(ColourCode);
          SizeCode := '_'+Trim(SizeCode);
        end
        else
        begin
          if Trim(ColourCode) <> '' then ColourCode := '_'+Trim(ColourCode);
        end;
      end;

    end
    else
    begin

      //KingGee now the same as
      if CompanyID in [_Holeproof,_Footwear,_Hosiery,_KingGee] then
      begin

        if Trim(DimCode) <> '' then
        begin
            ColourCode := '_'+ColourCode;
            SizeCode := '_'+SizeCode;
            DimCode := '_'+DimCode;
        end
        else
        begin
          if Trim(SizeCode) <> '' then
          begin
            ColourCode := '_'+ColourCode;
            SizeCode := '_'+Trim(SizeCode);  //only trim last element
          end
          else
          begin
            //style colour
            if Trim(ColourCode) <> '' then ColourCode := '_'+Trim(ColourCode);
          end;
        end;

      end
      //------------------------------
      else
        if Trim(SizeCode) <> '' then
        begin
          ColourCode := '_'+ColourCode;
          SizeCode := '_'+SizeCode;
          DimCode := '_'+DimCode;
        end
        else
        begin

          if Trim(DimCode) <> '' then
          begin
            ColourCode := '_'+ColourCode;
            DimCode := '_'+DimCode;
          end
          else
            if Trim(ColourCode) <> '' then ColourCode := '_'+ColourCode;

        end;
      //----------------

    end;

  end;



    Case CompanyID of
      //_Holeproof: Result := StyleCode+ColourCode+DimCode+SizeCode; //No trimmining
      _Holeproof:Result := StyleCode+ColourCode+SizeCode+Trim(DimCode); //trim dim in case not there
      _Stubbies:  Result := StyleCode+ColourCode+DimCode+SizeCode; //No trimmining
      _KingGee:Result := StyleCode+ColourCode+SizeCode+Trim(DimCode); //trim dim in case not there
      //_KingGee: Begin
      //            if UseSwitch then
      //              Result := StyleCode+ColourCode+DimCode+SizeCode //No trimmining
      //            else
      //              Result := StyleCode+ColourCode+SizeCode+DimCode; //No trimmining
      //          end;
      _Bonds: Begin
                  if UseSwitch then
                    Result := StyleCode+ColourCode+DimCode+SizeCode //No trimmining
                  else
                    Result := StyleCode+ColourCode+SizeCode+DimCode; //No trimmining
                end;
      _Berlei: Begin
                  if UseSwitch then
                    Result := StyleCode+ColourCode+DimCode+SizeCode //No trimmining
                  else
                    Result := StyleCode+ColourCode+SizeCode+DimCode; //No trimmining
                end;
      _DSA:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _DSE:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      //_Footwear:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(DimCode)+Trim(SizeCode);
      _Footwear:Result := StyleCode+ColourCode+SizeCode+Trim(DimCode); //trim dim in case not there
      _Leisure:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _Footwear2:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _Tontine:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _ClothingNZ:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode)+Trim(DimCode);
      _Hosiery:Result :=Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _Sheridan:Result := StyleCode+Trim(ColourCode);
      _Sleepmaker:Result := StyleCode+Trim(SizeCode);
      _Workwear:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(DimCode)+Trim(SizeCode);
    else
      Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode)+Trim(DimCode);
    end;
end;

function Get_OLD_CompanyProdCode(CompanyID:Integer; StyleCode,ColourCode,DimCode,SizeCode:String;UseSwitch:Boolean=false):String;
begin
  //Use Switch is compatibility for new data prepares, where King Gee switches size and dim around
  //Format fixed width ones
  if CompanyID in [_Holeproof,_KingGee,_Bonds,_Berlei,_Stubbies] then
  begin
    StyleCode := Format('%-6s',[StyleCode]);
    ColourCode := Format('%-3s',[ColourCode]) ;
    DimCode := Format('%-3s',[DimCode]);
    SizeCode := Format('%-3s',[SizeCode]) ;
  end
  else
  begin
    StyleCode := Trim(StyleCode);
    ColourCode := Trim(ColourCode) ;

    if CompanyID <> _DSE then
      SizeCode := Trim(SizeCode);

    DimCode := Trim(DimCode);

    if (CompanyID = _Workwear) and (SizeCode<>'') and (DimCode='') then
      DimCode := 'NA';   //JT email - Tuesday, 2 December 2008 3:58 PM


  end;

  if CompanyID = _Sheridan then
  begin
    SizeCode:='';
    DimCode:='';
  end;

  if CompanyID = _Sleepmaker then
  begin
    DimCode := '';
    ColourCode := '';
  end;

  if not (CompanyID in [_Bonds,_Berlei,_Holeproof]) then
  begin

    if CompanyID = _ClothingNZ then
    begin

      if Trim(DimCode) <> '' then
      begin
          ColourCode := '_'+ColourCode;
          SizeCode := '_'+SizeCode;
          DimCode := '_'+DimCode;
      end
      else
      begin
        if Trim(SizeCode) <> '' then
        begin
          ColourCode := '_'+Trim(ColourCode);
          SizeCode := '_'+Trim(SizeCode);
        end
        else
        begin
          if Trim(ColourCode) <> '' then ColourCode := '_'+Trim(ColourCode);
        end;
      end;

    end
    else
    begin

      if Trim(SizeCode) <> '' then
      begin
        ColourCode := '_'+ColourCode;
        SizeCode := '_'+SizeCode;
        DimCode := '_'+DimCode;
      end
      else
      begin

        if Trim(DimCode) <> '' then
        begin
          ColourCode := '_'+ColourCode;
          DimCode := '_'+DimCode;
        end
        else
          if Trim(ColourCode) <> '' then ColourCode := '_'+ColourCode;

      end;

    end;

  end;



    Case CompanyID of
      _Holeproof: Result := StyleCode+ColourCode+DimCode+SizeCode; //No trimmining
      _Stubbies:  Result := StyleCode+ColourCode+DimCode+SizeCode; //No trimmining
      _KingGee: Begin
                  if UseSwitch then
                    Result := StyleCode+ColourCode+DimCode+SizeCode //No trimmining
                  else
                    Result := StyleCode+ColourCode+SizeCode+DimCode; //No trimmining
                end;
      _Bonds: Begin
                  if UseSwitch then
                    Result := StyleCode+ColourCode+DimCode+SizeCode //No trimmining
                  else
                    Result := StyleCode+ColourCode+SizeCode+DimCode; //No trimmining
                end;
      _Berlei: Begin
                  if UseSwitch then
                    Result := StyleCode+ColourCode+DimCode+SizeCode //No trimmining
                  else
                    Result := StyleCode+ColourCode+SizeCode+DimCode; //No trimmining
                end;
      _DSA:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _DSE:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _Footwear:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(DimCode)+Trim(SizeCode);
      _Leisure:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _Footwear2:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _Tontine:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _ClothingNZ:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode)+Trim(DimCode);
      _Hosiery:Result :=Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode);
      _Sheridan:Result := StyleCode+Trim(ColourCode);
      _Sleepmaker:Result := StyleCode+Trim(SizeCode);
      _Workwear:Result := Trim(StyleCode)+Trim(ColourCode)+Trim(DimCode)+Trim(SizeCode);
    else
      Result := Trim(StyleCode)+Trim(ColourCode)+Trim(SizeCode)+Trim(DimCode);
    end;
end;

function Pac_StrToDate(DateStr: String): TDateTime;
var
  Year, Month, Day: Word;
begin
  Year := StrToInt(Copy(DateStr,1,4));
  Month := StrToInt(Copy(DateStr,5,2));
  Day := StrToInt(Copy(DateStr,7,2));
  Result := EncodeDate(Year,Month,Day);
end;

function Get_Alt_Lt(LT,ReleaseDate:String;BufferDays:Integer):Integer;
var
  NewLT:Integer;
  RDate:TDateTime;
begin
  LT := Trim(LT);
  ReleaseDate := Trim(ReleaseDate);

   Try
    NewLT := StrToInt(LT);
  except
    NewLT := 0;
  end;


  if ReleaseDate <> '' then
  begin
    Rdate := Pac_StrToDate(ReleaseDate);
    RDate := Rdate - BufferDays;

    if Rdate > Now then
    begin
      NewLT := Trunc(Rdate - Now);

    end;

    //Take the max of the two.
    if NewLT < StrToInt(LT) then
      NewLT := StrToInt(LT);

  end;

  Result := NewLT;

end;

function GetDivCode(CompanyID:Integer;NewCode:String):String;
begin

  Case CompanyID of
    _Hosiery    :Result:= 'HO';
    _Berlei     :Result:= 'BE';
    _Bonds      :Result:= 'BO';
    _Leisure    :Result:= 'LF';
    _ClothingNZ :Result:= 'CZ';
    _Tontine    :Result:= 'TB';
    _Sheridan   :Result:= 'SA';
    _Sleepmaker :Result:= 'ZA';
    _Workwear   :Result:= 'WI';
    _Stubbies   :Result:= 'BX';
    _Footwear   :Result:= 'FW';
    _Holeproof  :Result:= 'UW';
    _KingGee    :Result:= 'BA';
  else
    Result := NewCode;
  end;

end;

function GetWarehouseCode(CompanyID:Integer;DivCode,LocCode:String):String;
begin
  Result := '';

  Case CompanyID of
    _Holeproof :Begin
                  //Change accroding to new structure
                  // see email JT Monday, 19 July 2010 3:31 PM
                  //AU DC
                  if LocCode = 'UHG' then
                  begin
                    if (DivCode = 'HP') then Result := 'RV';
                    if (DivCode = 'JA') then Result := 'EC';
                    if (DivCode = 'HO') then Result := 'CL';
                    //if (DivCode = 'BE') then Result := 'MI';      //see email JT Tue 12/09/2011 @11:33am
                    if (DivCode = 'BE') then Result := 'WE';
                    //if (DivCode = 'BN') then Result := '';
                    if (DivCode = 'BO') then Result := '';     //see email JT Tue 13/09/2011 @11:21am
                  end
                  else
                  begin

                    if LocCode = 'PAPSKU' then
                    begin
                      {if (DivCode = 'HP') then Result := 'RV';
                      if (DivCode = 'JA') then Result := 'EC';
                      if (DivCode = 'HO') then Result := 'CL';
                      if (DivCode = 'BE') then Result := 'MI';
                      if (DivCode = 'BN') then Result := '';}
                      
                      //See email - JT  : Friday, 12 November 2010 4:05 PM
                      Result := 'P1';
                    end
                    else
                    begin
                      if (DivCode = 'HP') then Result := 'ET';
                      if (DivCode = 'JA') then Result := 'ET';
                      if (DivCode = 'HO') then Result := 'ET';
                      if (DivCode = 'BE') then Result := '';
                      //if (DivCode = 'BN') then Result := 'ET';
                      if (DivCode = 'BO') then Result := 'ET';    //see email JT Tue 13/09/2011 @11:21am
                    end;

                  end;


                end;
    _Footwear :Begin
                  //
                  // see email JT Tuesday, 28 September 2010 10:01 AM
                  Result := 'AL';

                  if (DivCode = 'S2') then Result := 'BR';
                  if (DivCode = 'S3') then Result := 'EF';



                end;
    _Hosiery   :Result:= 'CL';
    //_Berlei    :Result:= 'MI';
    _Berlei    :Result:= 'WE';   //see email JT Tue 12/09/2011 @11:33am
    _Bonds     :Result:= 'MI';      //this should stay this way for bonds data
    _ClothingNZ:Result:= 'AU';
    _Tontine   :Result:= 'EB';

    _Sheridan  :Begin
                  Result :='PA';
                  if (LocCode = 'WHOSKUNZL') then Result := 'AU';
                  if (LocCode = 'PAPSKU') then Result := 'X1';

                end;



    _Sleepmaker:Result := Copy(LocCode,1,1) + '1';

    //(WorkwearConsol)    _KingGee,_Stubbies
    _Stubbies   : if Copy(LocCode,1,3) = 'NAT' then Result := 'EF'
                            else Result:= Copy(LocCode,1,2);
    _KingGee   :Begin
                  if Copy(LocCode,1,3) = 'NAT' then
                  begin
                    if (DivCode = 'KG') then Result := 'EF';
                    if (DivCode = 'YK') then Result := 'ST';
                    if (DivCode = 'CT') then Result := 'FO';
                  end
                  else
                  begin
                    Result:= Copy(LocCode,1,2);
                  end;
                end;

    _Workwear:Result:= 'U1';

  else
    Result := LocCode;
  end;

  if CompanyID = _Leisure then
  begin
    if Pos('BRISKU',LocCode)>0 then Result := 'AC';
    if Pos('BROSKU',LocCode)>0 then Result := 'BR';
    if Pos('PERSKU',LocCode)>0 then Result := 'WE';
    if Pos('HALSKU',LocCode)>0 then Result := 'HA';
  end;




end;


procedure BuildLookupStructure(CompanyID:Integer);
var
  InFile:TextFile;
  InFileName,DataStr,FCLocCode,DisagLocCodes:String;
  RecNo:Integer;
  oDisagLocCodes:TString;
begin
  FLookupStructure.FieldCount := 0;
  FLookupStructure.ProdIndexNo := 0;   //default Prod field pos
  FLookupStructure.LocIndexNo := 999;   //location field pos - this must be set to valid number


  if CompanyID = _Sleepmaker then
  begin
    FLookupStructure.LocIndexNo := 4;    //location field pos
    FLookupStructure.FlagIndexNo := 3;    //Flag field pos
    FLookupStructure.MaxLocation := 200;
    FLookupStructure.FieldCount := 9;
    //          Fieldno,Name,start,length,outformat +Space!!!
    SetLookupStructure(0,'ProdCode',1 ,25, '%-25s ');
    SetLookupStructure(1,'ModelCode',27 ,10 , '%-10s ');
    SetLookupStructure(2,'Warehouse',38 ,15, '%-15s ');
    SetLookupStructure(3,'Flags',54 ,10, '%-10s ');
    SetLookupStructure(4,'LocationIndicator',65,FLookupStructure.MaxLocation,'%-'+IntToStr(FLookupStructure.MaxLocation)+'s');
    SetLookupStructure(5,'ModelCost',65+FLookupStructure.MaxLocation      ,11, '%11.3f'); //no spaces after!!
    SetLookupStructure(6,'ModelSell',65+FLookupStructure.MaxLocation+11   ,11, '%11.3f');
    SetLookupStructure(7,'ModelID',  65+FLookupStructure.MaxLocation+11+11,10, '%-10s');
    SetLookupStructure(8,'ProdClass',65+FLookupStructure.MaxLocation+11+11+10,10, '%-10s');
  end;

  if CompanyID = _Footwear then
  begin
    FLookupStructure.LocIndexNo := 4;    //location field pos
    FLookupStructure.FlagIndexNo := 3;    //Flag field pos
    FLookupStructure.MaxLocation := 50;
    FLookupStructure.FieldCount := 5;
    //          Fieldno,Name,start,length,outformat +Space!!!
    SetLookupStructure(0,'ProdCode',1 ,25, '%-25s ');
    SetLookupStructure(1,'Division',27 ,10, '%-10s ');
    SetLookupStructure(2,'Product No',38 ,15, '%-15s ');
    SetLookupStructure(3,'Flags',54 ,10, '%-10s ');
    SetLookupStructure(4,'LocationIndicator',65,FLookupStructure.MaxLocation,'%-'+IntToStr(FLookupStructure.MaxLocation)+'s');
  end;

  SetLookupFieldTypes;  //set field types i.e. string , float

  InFileName := ExtractFilePath(ParamStr(0))+'CustomerCategory.txt';

  //Where business does not require this, then ignore
  if FileExists(InFileName) then
  begin
    AssignFile(InFile,InFileName);
    Reset(InFile);

    RecNo := -1;
    FCustStructure.DefaultLoc := '';   // where category not in list!!! [99]
    FCustStructure.DefaultException := False;

    While not eof(InFile) do
    begin
      ReadLn(InFile,DataStr);

      //1st record contains headers
      if RecNo >= 0 then
      begin

        //if not a comment line
        if Copy(DataStr,1,1) <> '#' then
        begin
          FCustStructure.Data[RecNo].Category := Trim(Copy(DataStr,1,10));
          FCustStructure.Data[RecNo].LocCode := Trim(Copy(DataStr,11,10));
          FCustStructure.Data[RecNo].Description := Copy(DataStr,21,60);

          if Pos('[',FCustStructure.Data[RecNo].Description) > 0 then
            FCustStructure.Data[RecNo].Exception := True
          else
            FCustStructure.Data[RecNo].Exception := False;

          //default when cat not in list - will generate exception
          if Pos('[',FCustStructure.Data[RecNo].Category) > 0 then
          begin
            //This assigns the default location
            FCustStructure.DefaultLoc := FCustStructure.Data[RecNo].LocCode;

            //Whether we report this as exception or not
            if Pos('[',FCustStructure.Data[RecNo].Description) > 0 then
              FCustStructure.DefaultException := True ;

          end;

        end;

      end;


      Inc(RecNo);



    end;

    FCustStructure.MaxCust := RecNo;

    CloseFile(InFile);

  end;

  InFileName := ExtractFilePath(ParamStr(0))+'CustomerCategoryNZ.txt';

  //Where business does not require this, then ignore
  if FileExists(InFileName) then
  begin
    AssignFile(InFile,InFileName);
    Reset(InFile);

    RecNo := -1;
    FCustStructureNZ.DefaultLoc := '';   // where category not in list!!! [99]
    FCustStructureNZ.DefaultException := False;

    While not eof(InFile) do
    begin
      ReadLn(InFile,DataStr);

      //1st record contains headers
      if RecNo >= 0 then
      begin

        //if not a comment line
        if Copy(DataStr,1,1) <> '#' then
        begin
          FCustStructureNZ.Data[RecNo].Category := Trim(Copy(DataStr,1,10));
          FCustStructureNZ.Data[RecNo].LocCode := Trim(Copy(DataStr,11,10));
          FCustStructureNZ.Data[RecNo].Description := Copy(DataStr,21,60);

          if Pos('[',FCustStructureNZ.Data[RecNo].Description) > 0 then
            FCustStructureNZ.Data[RecNo].Exception := True
          else
            FCustStructureNZ.Data[RecNo].Exception := False;

          //default when cat not in list - will generate exception
          if Pos('[',FCustStructureNZ.Data[RecNo].Category) > 0 then
          begin
            //This assigns the default location
            FCustStructureNZ.DefaultLoc := FCustStructureNZ.Data[RecNo].LocCode;

            //Whether we report this as exception or not
            if Pos('[',FCustStructureNZ.Data[RecNo].Description) > 0 then
              FCustStructureNZ.DefaultException := True ;

          end;

        end;

      end;


      Inc(RecNo);



    end;

    FCustStructureNZ.MaxCust := RecNo;

    CloseFile(InFile);

  end;

  InFileName := ExtractFilePath(ParamStr(0))+'WarehouseLookup.txt';

  //Where business does not require this, then ignore
  if FileExists(InFileName) then
  begin
    AssignFile(InFile,InFileName);
    Reset(InFile);

    RecNo := -1;
    FWarehouseStructure.DefaultLoc := '';   // where not in list

    While not eof(InFile) do
    begin
      ReadLn(InFile,DataStr);

      //1st record contains headers
      if RecNo >= 0 then
      begin
        FWarehouseStructure.Data[RecNo].Warehouse := uppercase(Trim(Copy(DataStr,1,10)));
        FWarehouseStructure.Data[RecNo].State := Trim(Copy(DataStr,11,10));
        FWarehouseStructure.Data[RecNo].LocCode := Trim(Copy(DataStr,21,10));
        FWarehouseStructure.Data[RecNo].Description := Copy(DataStr,31,60);

        if Pos('[',FWarehouseStructure.Data[RecNo].Description) > 0 then
          FWarehouseStructure.Data[RecNo].Exception := True
        else
          FWarehouseStructure.Data[RecNo].Exception := False;

        //default when not in list - will generate exception
        if Pos('[',FWarehouseStructure.Data[RecNo].Warehouse) > 0 then
          FWarehouseStructure.DefaultLoc := FWarehouseStructure.Data[RecNo].LocCode;

      end;


      Inc(RecNo);



    end;

    FWarehouseStructure.MaxWarehouse := RecNo;

    CloseFile(InFile);

  end;

  InFileName := ExtractFilePath(ParamStr(0))+'TerritoryLookup.txt';

  //Where business does not require this, then ignore
  if FileExists(InFileName) then
  begin
    AssignFile(InFile,InFileName);
    Reset(InFile);

    RecNo := -1;
    FTerritoryStructure.DefaultLoc := '';   // where not in list

    While not eof(InFile) do
    begin
      ReadLn(InFile,DataStr);

      //1st record contains headers
      if RecNo >= 0 then
      begin
        FTerritoryStructure.Data[RecNo].Warehouse := Trim(Copy(DataStr,1,10));
        FTerritoryStructure.Data[RecNo].State := Trim(Copy(DataStr,11,10));
        FTerritoryStructure.Data[RecNo].LocCode := Trim(Copy(DataStr,21,10));
        FTerritoryStructure.Data[RecNo].Description := Copy(DataStr,31,60);

        if Pos('[',FTerritoryStructure.Data[RecNo].Description) > 0 then
          FTerritoryStructure.Data[RecNo].Exception := True
        else
          FTerritoryStructure.Data[RecNo].Exception := False;

        //default when not in list - will generate exception
        if Pos('[',FTerritoryStructure.Data[RecNo].Warehouse) > 0 then
          FTerritoryStructure.DefaultLoc := FTerritoryStructure.Data[RecNo].LocCode;

      end;


      Inc(RecNo);



    end;

    FTerritoryStructure.MaxTerritory := RecNo;

    CloseFile(InFile);

  end;

  InFileName := ExtractFilePath(ParamStr(0))+'DisagLocsFoamsLookup.txt';
  if FileExists(InFileName) then
  begin
    AssignFile(InFile,InFileName);
    Reset(InFile);
    RecNo := -1;
    FFoamsForecastLocsList := tStringList.Create;
    While not eof(InFile) do
    begin
      ReadLn(InFile,DataStr);
      //1st record contains headers
      if RecNo >= 0 then
      begin
        FCLocCode := Trim(Copy(DataStr,1,15));
        DisagLocCodes := Trim(Copy(DataStr,17,1000));
        oDisagLocCodes := TString.Create(DisagLocCodes);
        FFoamsForecastLocsList.AddObject(FCLocCode,oDisagLocCodes);
      end;
      Inc(RecNo);
    end;
    CloseFile(InFile);
  end;

  InFileName := ExtractFilePath(ParamStr(0))+'KIP_Lookup.txt';
  if FileExists(InFileName) then
  begin
    AssignFile(InFile,InFileName);
    Reset(InFile);
    RecNo := -1;
    FKIPLocationList := tStringList.Create;
    While not eof(InFile) do
    begin
      ReadLn(InFile,DataStr);
      //1st record contains headers
      if RecNo >= 0 then
      begin
        FCLocCode := Trim(Copy(DataStr,1,15));
        DisagLocCodes := Trim(Copy(DataStr,16,1000));
        oDisagLocCodes := TString.Create(DisagLocCodes);
        FKIPLocationList.AddObject(FCLocCode,oDisagLocCodes);
      end;
      Inc(RecNo);
    end;
    CloseFile(InFile);
  end;

end;

procedure SetLookupValues(StringOfData:String);
var
  FieldNo:Integer;
begin

  with FLookupStructure do
  begin

    for FieldNo := 0 to FieldCount -1 do
    begin
      Fields[FieldNo].Value := Trim(Copy(StringOfData,
                                         Fields[FieldNo].Start,
                                         Fields[FieldNo].Length));

    end;

  end;

end;

procedure SetLookupFieldTypes;
var
  FieldNo:Integer;
begin

  with FLookupStructure do
  begin

    for FieldNo := 0 to FieldCount -1 do
    begin
      if pos('f',Fields[FieldNo].OutStr) > 0 then
        Fields[FieldNo].FieldType := _lftFloat;
    end;

  end;

end;

function NewObjectPB:TProductPB;
var
  FieldNo:Integer;
begin

  Result := TProductPB.Create;

  for FieldNo := 0 to FLookupStructure.FieldCount -1 do
  begin

    if (FLookupStructure.Fields[FieldNo].FieldType = _lftFloat) and
       (FLookupStructure.Fields[FieldNo].Value = '') then
       Result.Data[FieldNo] := '0'
    else
      Result.Data[FieldNo] := FLookupStructure.Fields[FieldNo].Value;

  end;

end;

function LookupOutFormat:String;
var
  TempStr:String;
  FieldNo:Integer;
begin

  TempStr := '';

  for FieldNo := 0 to FLookupStructure.FieldCount -1 do
    TempStr := TempStr + FLookupStructure.Fields[FieldNo].OutStr;


  Result := TempStr;
end;

procedure SetLookupStructure(FieldNo:Integer;Name:String;Start,Length:Integer;OutFormat:String);
begin
    FLookupStructure.Fields[FieldNo].Name := Name;
    FLookupStructure.Fields[FieldNo].Start := Start;
    FLookupStructure.Fields[FieldNo].Length := Length;
    FLookupStructure.Fields[FieldNo].OutStr := OutFormat;
    FLookupStructure.Fields[FieldNo].FieldType := _lftString;  //default all to string
End;

function GetCustLocationCode(SearchStr:String;var Loc1,Loc2,Loc3:String;ReturnLoc:TLocReturn):Boolean;
var
  RecNo:Integer;
  NotFound,ExceptList:Boolean;
  NewLoc:String;
begin

  Loc1 := '';
  Loc2 := '';
  Loc3 := '';
  NewLoc := '';
  Result := True;
  ExceptList:=False;
  NotFound := True;

  for RecNo := 0 to FCustStructure.MaxCust do
  begin

    if FCustStructure.Data[RecNo].Category = SearchStr then
    begin
      ExceptList := FCustStructure.Data[RecNo].Exception;
      NewLoc := FCustStructure.Data[RecNo].LocCode;
      NotFound := False;
      Break;
    end;

  end;

  //If exception then return False
  if ExceptList then
    Result := False;

  if NotFound then
  begin
    NewLoc := FCustStructure.DefaultLoc;
    if FCustStructure.DefaultException then
      Result := False;
  end;

  if NewLoc <> '' then
  begin

    if ReturnLoc in [_lrSku,_lrSkuAndStyle] then
      Loc1 := NewLoc+'SKU';

    if ReturnLoc in [_lrStyle,_lrSkuAndStyle] then
      Loc2 := NewLoc + 'STL';

    if ReturnLoc in [_lrCategory] then
      Loc3 := NewLoc;

  end;


end;

function GetCustLocationCodeNZ(SearchStr:String;var Loc1,Loc2,Loc3:String;ReturnLoc:TLocReturn):Boolean;
var
  RecNo:Integer;
  NotFound,ExceptList:Boolean;
  NewLoc:String;
begin

  Loc1 := '';
  Loc2 := '';
  Loc3 := '';
  NewLoc := '';
  Result := True;
  ExceptList:=False;
  NotFound := True;

  for RecNo := 0 to FCustStructureNZ.MaxCust do
  begin

    if FCustStructureNZ.Data[RecNo].Category = SearchStr then
    begin
      ExceptList := FCustStructureNZ.Data[RecNo].Exception;
      NewLoc := FCustStructureNZ.Data[RecNo].LocCode;
      NotFound := False;
      Break;
    end;

  end;

  //If exception then return False
  if ExceptList then
    Result := False;

  if NotFound then
  begin
    NewLoc := FCustStructureNZ.DefaultLoc;
    if FCustStructureNZ.DefaultException then
      Result := False;
  end;

  if NewLoc <> '' then
  begin

    if ReturnLoc in [_lrSku,_lrSkuAndStyle] then
      Loc1 := NewLoc+'SKU';

    if ReturnLoc in [_lrStyle,_lrSkuAndStyle] then
      Loc2 := NewLoc + 'STL';

    if ReturnLoc in [_lrCategory] then
      Loc3 := NewLoc;

  end;


end;

procedure GetLocationCode_LF(WarehouseCode,Customer,GroupCode,PlanningGroup:String;
                            var SKULoc,StyleLoc:String);

begin
  SKULoc := '';
  StyleLoc := '';

  //No need for postCode use warehouse in feed only
  //Janice Keen 05/05/05 See Spec
  {if (GroupCode = 'B080') and (Copy(PostCode,1,1)='3') then
  begin
    WareHouseCode := 'BR';
  end;

  if (GroupCode = 'B080') and (Copy(PostCode,1,1)='4') then
  begin
    WareHouseCode := 'AQ';
  end;

  if (GroupCode = 'B080') and (Copy(PostCode,1,1)='6') then
  begin
    WareHouseCode := 'WE';
  end;
   }

  //Group Code
  //B080  Bikes
  //B081  Helmets
  //B082  Parts and Accessories
  //B083  Bike Parts
  //B084  Fitness
  //B085  Others ( Sundries)

  //Whouse codes
  //BQ Brooklyn
  //BR Brooklyn
  //HA Hallam
  //WE Welsh pool - Perth
  //WQ Welsh pool - Perth
  //AC New Market - Brisbane
  //AQ New Market - Brisbane
  //CP 3PL - Brisbane
  //IW  Interwarehouse transfer

  //Customer Codes
  // 1 BigW
  // 3 KMart
  // 5 IBD Helmets
  //98 IBD Bikes
  //99 Other Helmets

  //Brisbane
  //Revision JT email 1/7/08 for warehouse TC
  if (WarehouseCode = 'AC') or (WarehouseCode = 'AQ') or (WarehouseCode = 'CP')
     or (WarehouseCode = 'TC') then
  begin
    SKULoc := 'BRISKU';

    //Bikes
    if GroupCode = 'B080' then
    begin
      StyleLoc := 'TOTSTL';
    end;

    //Helmets
    if GroupCode = 'B081' then
    begin

      if (PlanningGroup <> 'OTHER') and (Trim(Customer) <> '') then
      begin
        Customer := 'B' + RightStr('0'+Customer,2);
        StyleLoc := Customer + 'STL';
      end;

    end;

  end;

  //Brooklyn
  if (WarehouseCode = 'BQ') or (WarehouseCode = 'BR') then
  begin
    SKULoc := 'BROSKU';

    if GroupCode = 'B080' then
    begin
      StyleLoc := 'TOTSTL';
    end;

    //Helmets
    if GroupCode = 'B081' then
    begin
      if (PlanningGroup <> 'OTHER') and (Trim(Customer) <> '') then
      begin
        Customer := 'K' + RightStr('0'+Customer,2);

        //Old Hallan stuff was diverted by the business to these locations
        //  now we need it to go into actual locations again.

        if Customer = 'K01' then  //if Big W then put in Hallam Big W
          Customer := 'H01';

        //if Customer = 'K01' then  //if Big W then put in other
        //  Customer := 'K99';

        //if Customer = 'K03' then  //if KMART then put in other
        //  Customer := 'K99';

        StyleLoc := Customer + 'STL';
      end;

    end;

  end;

  //Welsh pool
  if (WarehouseCode = 'WE') or (WarehouseCode = 'WQ') then
  begin
    SKULoc := 'PERSKU';

    //Bikes
    if GroupCode = 'B080' then
    begin
      StyleLoc := 'TOTSTL';
    end;

    //Helmets
    if (PlanningGroup <> 'OTHER') and (GroupCode = 'B081') then
    begin
      if Trim(Customer) <> '' then
      begin
        Customer := 'P' + RightStr('0'+Customer,2);
        StyleLoc := Customer + 'STL';
      end;

    end;

  end;

  //Hallam
  // redirect to Brooklyn SKU only SG ...--- 15/12/2010
  //    sales and Co's go to usuall locations, and consolidation is changed
  //
  if (WarehouseCode = 'HA') then
  begin
    //SKULoc := 'HALSKU';
    SKULoc := 'BROSKU';

    //Helmets
    if (PlanningGroup <> 'OTHER') and (GroupCode = 'B081') then
    begin
      if Trim(Customer) <> '' then
      begin

        Customer := 'H' + RightStr('0'+Customer,2);

        //if Customer = 'H05' then
        //  Customer := 'H99';

        //We want this there until Hallam is completely disolved.
        // but don't have IBD so redirect to Brooklyn
        if Customer = 'H05' then
          Customer := 'K05';

        if Customer = 'H99' then Customer := 'K99'; // These 2 are now combined

        StyleLoc := Customer + 'STL';
      end;

    end;

  end;

  if (WarehouseCode = 'IW') then
  begin
    SKULoc := 'IWTSKU';
    StyleLoc := '';
  end;


end;

procedure GetLocationCode_KG(Division,Warehouse,Style,AccountRef,OrderStatus:String;var Loc1,Loc2,Loc3,ErrMsg:String);
var
  Exclude,ExcludeNat:Boolean;
begin

  Loc1 := '';
  Loc2 := '';
  Loc3 := '';
  ErrMsg := '';
  Exclude := False;
  ExcludeNat := False;

  //Exclude styles
  if Pos(Trim(Style),FExcludeStyles) > 0 then
    Exclude := True;

  //Exclude these special cust P.Lee 9-Jul-2004
  //
  if Pos(AccountRef,FExcludeAccounts) > 0 then
    Exclude := True;

  //OLD Logic - Filter at national level for PO's
  //
  //if Pos(OrderType,'Z,I') = 0 then
  //begin
  //    WriteLn(OutFile,'NAT-SKU,'+ProdCode+OutStr);
  //    WriteLn(OutFile,'NAT-STCLR,'+Style+Col+OutStr);
  //end;

  //Exclude from National
   if Pos(Trim(OrderStatus),FExcludeNationalType) > 0 then
     ExcludeNat := True;

   if Pos(Trim(OrderStatus),FExcludeOrderType) > 0 then
     Exclude := True;

  //Exclude from National
  if Pos(AccountRef,FExcludeFromNational) > 0 then
    ExcludeNat := True;

  if not Exclude then
  begin
      //Stubbies Only
      //KG + WE + NM into NM
      //WA + WG into WG
      //XW + X1 into X1

      //if Trim(Division) = 'ST' then
      //begin
      // Revision add TC .. JT email 1/7/2008 .... WAIT
      // Revision add TC .. JT email Monday, 28 July 2008 3:26 PM
      // Revision add EF ....JT email Thursday, 23 September 2010 12:18 PM
        if Pos(Warehouse,'WE,TC,EF,NM') > 0 then
          Warehouse := 'EF';
         // Warehouse := 'NM';

        //if Warehouse = 'WA' then
        //  Warehouse := 'WG';

        //See email - JT Thursday, 14 October 2010 5:06 PM
        if Warehouse = 'WG' then
          Warehouse := 'WA';

        if Warehouse = 'XW' then
          Warehouse := 'X1';

        //Add yakka and CTE Warehouses (WorkwearConsol)
        if Pos(Warehouse,'ST,SQ,FO,WE') > 0 then
          Warehouse := 'ST';

        if Warehouse = 'BM' then
          Warehouse := 'WA';

        if Pos(Warehouse,'AF,BT,CN,CP,CS,HL,KI,KT,MB,NO,NR,RE,RM,SC,TB,TT,WC,WF,WL,WN') > 0 then
          Warehouse := 'RE';

      //end;

      if Pos(Warehouse,'EF,NM,WA,XW,IW,KG,WG,X1,ST,SQ,FO,WE,BM,AF,BT,CN,CP,CS,HL,KI,KT,MB,NO,NR,RE,RM,SC,TB,TT,WC,WF,WL,WN') = 0 then
      begin
        //need to notify that we have diverted a warehouse
        Warehouse := 'X1';
        ErrMsg := 'Warehouse not found in Optimiza. Diverted to X1/';
      end;

      //Make sure these go into national and nowhere else
      // email 27/06/08 JT
      if Pos(Warehouse,'KG,WG') > 0 then
            Warehouse := '';

      if not ExcludeNat then
      begin

        //if Warehouse = 'EF' then
        //begin
          Loc2 := 'NAT-SKU';
          Loc3 := 'NAT-STL';

          //Loc3 := 'NAT-STCLR';
        //end;

      end;

      if WareHouse <> '' then
        Loc1 := Warehouse+'-SKU';

  end;


end;

Procedure set_Exclude_KG(ExcludeStyles,ExcludeAccounts,ExcludeFromNational,ExcludeOrderType,ExcludeNationalType:String);
begin
  FExcludeStyles := ExcludeStyles;
  FExcludeAccounts := ExcludeAccounts;
  FExcludeFromNational:=ExcludeFromNational;
  FExcludeOrderType := ExcludeOrderType;
  FExcludeNationalType := ExcludeNationalType;
end;

function GetDesignCode(Style,Colour:String):String;
begin
  Style := Trim(Style);
  Colour := Trim(Colour);

  if Trim(Colour) <> '' then Colour := '_'+Trim(Colour);

  Result := Copy(Style,1,4)+Trim(Colour);


end;

procedure GetWarehouseLocation_SL(Warehouse:String; var Loc1,Loc2,Loc3,Country:String);
begin
  Loc1 := '';
  Loc2 := '';  //Loc2 returns nothing for now !!!!!
  Loc3 := '';

  if GetWarehouseLocationCode(Warehouse,Loc1,Country) then
  begin

     //if in these then also ensure we add to other location
     //  VICSKU = VICSKUTMP + SAUSKU (consolidation)
     //
     if Loc1 = 'SAUSKU' then
       Loc3 := 'VICSKU';

    // if Loc1 = 'VICSKU' then
    //   Loc3 := 'VICSKUTMP';

  end;

end;

function GetWarehouseLocationCode(SearchStr:String;var Loc1, Country:String):Boolean;
var
  RecNo:Integer;
  NotFound,ExceptList:Boolean;
  NewLoc:String;
begin

  Loc1 := '';
  Country := '';
  NewLoc := '';
  Result := True;
  ExceptList:=False;
  NotFound := True;
  SearchStr := uppercase(SearchStr);

  for RecNo := 0 to FWarehouseStructure.MaxWarehouse-1 do
  begin

    if FWarehouseStructure.Data[RecNo].Warehouse = SearchStr then
    begin
      ExceptList := FWarehouseStructure.Data[RecNo].Exception;
      NewLoc := FWarehouseStructure.Data[RecNo].LocCode;
      Country := FWarehouseStructure.Data[RecNo].Description;
      NotFound := False;
      Break;
    end;

  end;

  //If exception then return False
  if ExceptList then
    Result := False;

  if NotFound then
  begin
    Result := False; //Exception
    NewLoc := FWarehouseStructure.DefaultLoc;
  end;

  if NewLoc <> '' then
    Loc1 := NewLoc;

end;


function GetVendorName(Warehouse:String):String;
begin
  Result := 'Unknown';

  if Warehouse = 'PA' then
    Result := 'Adelaide';
  if Warehouse = 'HE' then
    Result := 'Adelaide';
  if Warehouse = 'E1' then
    Result := 'Direct_Asia';
  if Warehouse = 'E2' then
    Result := 'Direct_AUS';
  if Warehouse = 'NZ' then
    Result := 'Direct_NZ';
  if Warehouse = 'UK' then
    Result := 'Direct_UK';
  if Warehouse = 'X1' then
    Result := 'PickAndPack';
  if Warehouse = 'X2' then
    Result := 'PickAndPack';
  if Warehouse = 'X3' then
    Result := 'PickAndPack';
  if Warehouse = 'D1' then
    Result := 'PickAndPack';
  if Warehouse = 'AU' then
    Result := 'Auckland';
  if Warehouse = 'TL' then
    Result := 'Auckland';

end;


function IsStyleColour(LocCode: String): Boolean;
begin
  Result := False;

  //King Gee - NAT-STCLR - non standard convention - proj start before naming convention
  if (Pos('STL',LocCode) > 0) or (LocCode='NAT-STCLR') then
    Result := True;

end;

function GetStyleCol_PB(CompanyID:Integer;ProdCode: String): String;
var
  Style,Col:String;
begin
  Style := ProdCode;
  Col := '';

  if Pos('_',ProdCode) > 0 then
  begin
    Style := Copy(ProdCode,1,Pos('_',ProdCode)-1);
    ProdCode := Copy(ProdCode,Pos('_',ProdCode)+1,Length(ProdCode));
  end;

  if Pos('_',ProdCode) > 0 then
  begin
    Col := '_'+Copy(ProdCode,1,Pos('_',ProdCode)-1);
  end
  else
  begin
    Col := ProdCode;
  end;

  Result := Style+Col;

end;

function GetTerritoryLocationCode(SearchStr:String;var Loc1:String):Boolean;
var
  RecNo:Integer;
  NotFound,ExceptList:Boolean;
  NewLoc:String;
begin

  Loc1 := '';
  NewLoc := '';
  Result := True;
  ExceptList:=False;
  NotFound := True;

  for RecNo := 0 to FTerritoryStructure.MaxTerritory do
  begin

    if FTerritoryStructure.Data[RecNo].Warehouse = SearchStr then
    begin
      ExceptList := FTerritoryStructure.Data[RecNo].Exception;
      NewLoc := FTerritoryStructure.Data[RecNo].LocCode;
      NotFound := False;
      Break;
    end;

  end;

  //If exception then return False
  if ExceptList then
    Result := False;

  if NotFound then
  begin
    Result := False; //Exception
    NewLoc := FTerritoryStructure.DefaultLoc;
  end;

  if NewLoc <> '' then
    Loc1 := NewLoc;

end;

function StateToTerritory(StateCode:String):String;
begin
Result := '';

if StateCode = 'NT'  then Result := '0';
if StateCode = 'NSW' then Result := '2';
if StateCode = 'VIC' then Result := '3';
if StateCode = 'QLD' then Result := '4';
if StateCode = 'SA'  then Result := '5';
if StateCode = 'WA'  then Result := '6';
if StateCode = 'TAS' then Result := '7';
if StateCode = 'ACT' then Result := '8';

end;

function CompareTProductPBObjects(ProductObject1:TProductPB; ProductObject2:TProductPB; StartPosition:Integer):Integer;  //Compares the elements in the array and returns an integer representing the array position where a mismatch was found.  If matched returns -1
var
  i:Integer;
//  Matched:Boolean;
begin
  Result:= -1;
  if StartPosition <= _MaxLookupField then
  begin
    for i:= StartPosition to _MaxLookupField do
    begin
      if ProductObject1.Data[i] <> ProductObject2.Data[i] then
      begin
        Result := i;
        break;
      end;
    end;
  end;
end;

function GetFoamsDisagLoc(FCLocCode, PlanLocCode:String):String;
var
  FoundIndex,i,DelimPos:integer;
  DisagLocsList:TStringList;
  DisagLocCodes,DisagLocCode,FoundPlanLocCode:String;
begin
  Result := '';
  if ((Assigned(FFoamsForecastLocsList)) And (FFoamsForecastLocsList.Count > 0))  then
  begin
    //is the FCLocCode in the list?
    FoundIndex := FFoamsForecastLocsList.IndexOf(FCLocCode);
    if FoundIndex >= 0 then
    begin
      //create an array of disag locations from the comma delimited string
      DisagLocCodes := TString(FFoamsForecastLocsList.Objects[FoundIndex]).Str;
      DisagLocsList := tStringList.Create;
      DisagLocsList.Clear;
      ExtractStrings([','], [], PChar(DisagLocCodes), DisagLocsList);
      for i:=0 to DisagLocsList.Count - 1 do
      begin
        DisagLocCode := DisagLocsList.Strings[i];
        DelimPos := AnsiPos('|', DisagLocCode);
        if DelimPos > 0 then
        begin
          FoundPlanLocCode := Copy(DisagLocCode,DelimPos+1,MaxInt);
          if FoundPlanLocCode = PlanLocCode then
          begin
            Result :=  Copy(DisagLocCode,1, DelimPos - 1);
            Break;
          end;
        end;
      end;
      DisagLocsList.Free;
    end;
  end;
end;

function Kip_Processing(Warehouse, Location: string):String;
var
  FoundIndex,i:integer;
  DisagLocsList:TStringList;
  DisagLocCodes,DisagLocCode,FoundPlanLocCode:String;
begin
  Result := Warehouse;
  if ((Assigned(FKIPLocationList)) And (FKIPLocationList.Count > 0))  then
  begin
    //is the Location in the list?
    FoundIndex := FKIPLocationList.IndexOf(Location);
    if FoundIndex >= 0 then
    begin
      //create an array of disag locations from the comma delimited string
      Result := TString(FKIPLocationList.Objects[FoundIndex]).Str;
    end;
  end;
end;

end.
