unit uSkuCode;

interface

uses SysUtils,StrUtils;

Const
    _MaxLocs=200;    //Use this to set import indicator per location
    _MaxSleepLocs=200; // Careful, the above conflicts with uCompany.pas

type
  TProduct = class(TObject)
    ModelCode:String;
    ProductClass:String;
    Flags:String;
    LocationIndicator:String;
    ModelCost:Real;
    ModelSell:Real;
    ModelID:String;
    State:String;
  end;

  TRMProduct = class(TObject)
    Description:String;
    Cost:Real;
    RM_Ind:String;
    OtherData:String; //Comma separated
    LocationIndicator:String;
  end;

  TStyle = class(TObject)
    StyleCode:String;
    IndexNo:Integer;
  end;

function NewObject(ModelCode,ProductClass,Flags,LocationIndicator,ModelID:String;ModelCost,ModelSell:Real):TProduct;

function NewStyleObject(StyleCode:String;IndexNo:Integer):TStyle;

function NewRMObject(Description,RM_Ind,OtherData,LocInd:String;Cost:Real):TRMProduct;

function GetSkuCode(Style,Colour,DimCode,SizeCode:String):String;

function GetModelCode(Style:String):String;

function GetDesignCodeFromSKU(SkuCode:String):String;

procedure GetLocationCode(Customer,PromInd,ProductClass:String;var Loc1,Loc2,Loc3,Loc4:String);

procedure GetWarehouseLocation(Warehouse:String; var Loc1,Loc2:String);

function GetVendorName(Warehouse:String):String;

implementation

function GetSkuCode(Style,Colour,DimCode,SizeCode:String):String;
begin
  Style := Trim(Style);
  SizeCode := Trim(SizeCode);

  if Trim(SizeCode) <> '' then SizeCode := '_'+Trim(SizeCode);


 Result := Trim(Style)+Trim(SizeCode);


end;

function GetModelCode(Style:String):String;
begin
  Style := Trim(Style);
  Result := Copy(Style,2,4)
end;

function GetDesignCodeFromSKU(SkuCode:String):String;
var
  nPos:Integer;
begin

  Result :=Copy(SkuCode,2,4)

end;

function NewObject(ModelCode, ProductClass,
  Flags,LocationIndicator,ModelID: String;ModelCost,ModelSell:Real): TProduct;
begin
  Result := TProduct.Create;

  Result.ModelCode := ModelCode;
  Result.ProductClass := ProductClass;
  Result.Flags := Flags;
  Result.LocationIndicator := LocationIndicator;
  Result.ModelCost := ModelCost;
  Result.ModelSell := ModelSell;
  Result.ModelID := ModelID;

end;

function NewStyleObject(StyleCode:String;IndexNo:Integer):TStyle;
begin
  Result := TStyle.Create;
  Result.StyleCode := StyleCode;
  Result.IndexNo := IndexNo;

end;

function NewRMObject(Description,RM_Ind,OtherData,LocInd:String;Cost:Real): TRMProduct;
begin
  Result := TRMProduct.Create;

  Result.Description := Description;
  Result.RM_Ind := RM_Ind;
  Result.Cost := Cost;
  Result.OtherData := OtherData;
  Result.LocationIndicator := LocInd;


end;

procedure GetLocationCode(Customer,PromInd,ProductClass:String;var Loc1,Loc2,Loc3,Loc4:String);
begin
  Loc1:='';
  Loc2:='';
  Loc3:='';
  Loc4:='';

  if Pos(Trim(ProductClass),'BS,FW,HN,MY,SM,CS') > 0 then
  begin

    Loc1 :='';


  end;

end;


procedure GetWarehouseLocation(Warehouse:String; var Loc1,Loc2:String);
begin
  Loc1 := '';
  Loc2 := '';

  if Warehouse = 'SA' then
    Warehouse := 'SAU';
  if Warehouse = 'WA' then
    Warehouse := 'WAU';

  if Trim(Warehouse) <> '' then
    Loc1 := Warehouse + 'SKU';

end;

function GetVendorName(Warehouse:String):String;
begin
  Result := 'Unknown';

  if Warehouse = 'PA' then
    Result := 'Adelaide';

end;

end.
