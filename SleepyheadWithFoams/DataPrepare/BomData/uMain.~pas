// 1.1 Add NZ locations
// 1.2 Add support for foams

unit uMain;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   ExtCtrls, StdCtrls, ComCtrls, StrUtils,UDMOPTIMIZA,DateUtils;

Const

    _Warehouse=1;
    _FG_SKU=2;
    _RM_SKU=3;
    _Factor=4;
    _UOM=5;
    _PercWaste=6;
    _OperationUsed=7;
    _Eff_Start=8;
    _Eff_End=9;
    _BOMLevel=10;
    _MaxField=10;


type
  TDataRecord = Array[1.._MaxField] of String;


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
    ProductList,RMProductList:TStringList;
    FFreightLt:String;
    procedure Say(Line : string);
    procedure StartProcess;
    procedure OpenLogFile;
    function GetParam(ParamName: String): String;
    procedure ReadData(LineOfData: String; var TheRecord: TDataRecord);
    procedure BuildProdList;
    procedure ProductListFree;
    function UpdateLocationCode(ProdType,ProdCode,SKULoc:String):String;
    procedure SaveProdList;
    function GetMuliPackQty(ProdCode:String):Real;
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
    RM_ProdCode,FG_ProdCode,StringOfData,LocCode:String;
    RecCount, WCount:Integer;
    ExceptName: String;
    InFile,OutFile,ExceptFile,TagFile:TextFile;
    DataRecord:TDataRecord;
    ErrMsg:String;
    CompanyID,ECount:Integer;
    MultiPackQty,OtherFactor,InnerPack,Ratio:Real;
begin

  Say('Start');


  try


    begin

      frmParameters.LoadParam;
      Say('Parameter File: '+frmParameters.edtIniFile.Text);

      RecCount := 0;
      WCount := 0;
      ECount := 0;

      CompanyID := GetCompanyID(GetParam('Company'));
      BuildLookupStructure(CompanyID);
      BuildProdList;

      ExceptName :=UpperCase(GetParam('Output File Name'));

      ExceptNAme := AnsiReplaceStr(ExceptNAme,'.CSV','_Except.csv');

      Say('Creating Exceptions : '+ExceptName);
      AssignFile(ExceptFile,ExceptName);
      Rewrite(ExceptFile);
      WriteLn(ExceptFile,'Record Number,Error Message,Product');
      
      Say('Creating : '+GetParam('Output File Name'));
      AssignFile(OutFile,GetParam('Output File Name'));
      Rewrite(OutFile);

      if GetParam('Tag File Name') <> '' then
      begin
        Say('Creating : '+GetParam('Tag File Name'));
        AssignFile(TagFile,GetParam('Tag File Name'));
        Rewrite(TagFile);
      end;

      Say('Opening : '+GetParam('Input File Name'));
      AssignFile(InFile,GetParam('Input File Name'));
      Reset(InFile);



      if not dmData.trnOptimiza.InTransaction then
        dmData.trnOptimiza.StartTransaction;

      dmData.BuildLocationList;

      while not eof(InFile) do
      begin

        ReadLn(InFile,StringOfData);

        ReadData(StringOfData,DataRecord);
        Inc(RecCount);

        if (DataRecord[1] <> '') then
        begin


          FG_ProdCode := DataRecord[_FG_SKU];
          RM_ProdCode := DataRecord[_RM_SKU];
          LocCode :=  DataRecord[_Warehouse];


          ErrMsg := '';

          if uppercase(LocCode) = 'SYDN_APP' then LocCode := 'NSWSKU';
          if uppercase(LocCode) = 'MELB_APP' then LocCode := 'VICSKU';
          if uppercase(LocCode) = 'BRIS_APP' then LocCode := 'QLDSKU';
          if uppercase(LocCode) = 'PERTH_APP' then LocCode := 'WASKU';
          if uppercase(LocCode) = 'TASM_APP' then LocCode := 'TASSKU';
          if uppercase(LocCode) = 'AUCK_APP' then LocCode := 'NTHSKU';
          if uppercase(LocCode) = 'CHCH_APP' then LocCode := 'STHSKU';

          if  uppercase(LocCode) = 'ADEL_JBA' then LocCode := 'SAUFP';
          if  uppercase(LocCode) = 'BRIS_JBA' then LocCode := 'QLDFP';
          if  uppercase(LocCode) = 'MELB_JBA' then LocCode := 'VICFP';
          if  uppercase(LocCode) = 'PERTH_JBA' then LocCode := 'WAUFP';
          if  uppercase(LocCode) = 'SYDN_JBA' then LocCode := 'NSWFP';
          if  uppercase(LocCode) = 'TASM_JBA' then LocCode := 'TASFP';

          if RecCount mod 50 = 0 then
          begin
            Label1.Caption := IntToStr(REcCount);
            Application.ProcessMessages;
          end;


          if ErrMsg = '' then
          begin


            WriteLn(OutFile,
                LocCode+','+FG_ProdCode+','+
                RM_ProdCode+','+
                Trim(DataRecord[_Factor]));


            Inc(WCount);
          end
          else
          begin
            Inc(ECount);
            WriteLn(ExceptFile,IntToStr(RecCount)+','+ErrMsg+','+FG_ProdCode+','+RM_ProdCode);
          end;


        end;

      end;


      Say('Records read : '+IntToStr(RecCount));
      Say('Records written : '+IntToStr(WCount));
      CloseFile(InFile);
      CloseFile(OutFile);
      if GetParam('Tag File Name') <> '' then
        CloseFile(TagFile);

      CloseFile(ExceptFile);

      if ECount=0 then
        if FileExists(ExceptName) then DeleteFile(ExceptName);
      SaveProdList;

      ProductListFree;
      dmData.LocationListFree;

      dmData.FireEvent('S');
    end;

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
    Caption := AnsiReplaceStr(ExtractFileName(ParamStr(0)),'.exe','');

    Caption := Caption + ' ' + dmData.DbDescription;
    FirstShow := False;

    if (ParamCount > 0) and (UpperCase(ParamStr(1)) <> '-Z' ) then
    begin
      frmParameters.edtIniFile.Text := ParamStr(1);
      RunProcess := True;

    end
    else
    Begin

      Memo1.Lines.add('Parameter Setup');
      frmParameters.Caption := 'Parameter Setup';

       if UpperCase(ParamStr(1)) = '-Z' then
       begin

        frmParameters.edtIniFile.Text := ParamStr(3);
        frmParameters.LoadParam;


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
  ProdCode,StringOfData:String;
  LookupFile:TextFile;
  RecCount:Integer;
begin
    ProductList := TStringList.Create;
    RecCount := 0;

    if Trim(GetParam('Lookup File')) <> '' then
    begin
      Say('Opening and building lookup : '+GetParam('Lookup File'));
      AssignFile(LookupFile,GetParam('Lookup File'));
      Reset(LookupFile);

      while not eof(LookupFile) do
      begin
        ReadLn(LookupFile,StringOfData);

        SetLookupValues(StringOfData);
        ProdCode := FLookupStructure.Fields[FLookupStructure.ProdIndexNo].Value;

        ProductList.AddObject(ProdCode,NewObjectPB);
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


    RMProductList := TStringList.Create;
    RecCount := 0;

    if Trim(GetParam('RM Lookup File')) <> '' then
    begin
      Say('Opening and building RM lookup : '+GetParam('RM Lookup File'));
      AssignFile(LookupFile,GetParam('RM Lookup File'));
      Reset(LookupFile);

      while not eof(LookupFile) do
      begin
        ReadLn(LookupFile,StringOfData);

        SetLookupValues(StringOfData);
        ProdCode := FLookupStructure.Fields[FLookupStructure.ProdIndexNo].Value;

        RMProductList.AddObject(ProdCode,NewObjectPB);
        Inc(RecCount);

        if RecCount mod 50 = 0 then
        begin
          Label1.Caption := IntToStr(REcCount);
          Application.ProcessMessages;
        end;

      end;

      CloseFile(LookupFile);
      Say('Records in RM Lookup: '+IntToStr(RecCount));
    end
    else
      Say('Lookup File not in use.');

    RMProductList.Sorted := True;

end;

procedure TfrmMain.ProductListFree;
var
  CCount:Integer;
begin

    While ProductList.Count > 0 do
    begin
      cCount := ProductList.Count-1;
      ProductList.Delete(cCount);
    end;

    ProductList.Free;

    While RMProductList.Count > 0 do
    begin
      cCount := RMProductList.Count-1;
      RMProductList.Delete(cCount);
    end;

    RMProductList.Free;
end;

function TfrmMain.UpdateLocationCode(ProdType,ProdCode,SKULoc:String):String;
var
  LocationIndicator:String;
  IndexNo,LocationOffset:Integer;
begin

 if ProdType = 'FG' then
   IndexNo := ProductList.IndexOf(ProdCode)
 else
   IndexNo := RMProductList.IndexOf(ProdCode);

 Result := '';

 if IndexNo >= 0 then
 begin
   //Also update the FG indicator
   if ProdType = 'FG' then
   begin
     (ProductList.Objects[IndexNo] as TProductPB).Data[2] := 'FG';
     LocationIndicator := (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo];
     FFreightLt := Trim((ProductList.Objects[IndexNo] as TProductPB).Data[5]);
   end
   else
     LocationIndicator := (RMProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo];

   if SkuLoc <> '' then
   begin
     LocationOffset := dmData.GetLocationOffset(SkuLoc);

     if LocationOffset > 0 then
     begin
       LocationIndicator := StuffString(LocationIndicator,LocationOffset,1,'Y');
       if ProdType = 'FG' then
         (ProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator
       else
         (RMProductList.Objects[IndexNo] as TProductPB).Data[FLookupStructure.LocIndexNo] := LocationIndicator;
     end
     else
       Result := 'Invalid Location ' + SkuLoc;

   end;

 end
 else
   Result := ProdType+' Master Record not found ' + ProdCode;

end;

procedure TfrmMain.SaveProdList;
var
  LookupFile:TextFile;
  RecCount,FieldNo:Integer;
  OutFormat,OutStr:String;
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

  if Trim(GetParam('RM Lookup File')) <> '' then
  begin
    Say('Updating RM Lookup : '+GetParam('RM Lookup File'));
    AssignFile(LookupFile,GetParam('RM Lookup File'));
    Rewrite(LookupFile);

    for RecCount := 0 to RMProductList.Count - 1 do
    begin
      //Write out Data for Lookup info for other prepares
      OutStr := '';

      for FieldNo := 0 to FLookupStructure.FieldCount-1 do
      begin
        OutFormat := FLookupStructure.Fields[FieldNo].OutStr;
        //Only check for Float Type for now
        if FLookupStructure.Fields[FieldNo].FieldType = _lftFloat then
          OutStr := OutStr + Format(OutFormat,[ StrToFloat((RMProductList.Objects[RecCount] as TProductPB).Data[FieldNo]) ])
        else
          OutStr := OutStr + Format(OutFormat,[ (RMProductList.Objects[RecCount] as TProductPB).Data[FieldNo]]);
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

function TfrmMain.GetMuliPackQty(ProdCode:String): Real;
var
  MultiPack:String;
  IndexNo:Integer;
begin
  IndexNo := ProductList.IndexOf(ProdCode);

  Result := 0;

  if IndexNo >= 0 then
  begin
    MultiPack := Trim((ProductList.Objects[IndexNo] as TProductPB).Data[1]);

    if MultiPack = '' then MultiPack := '0';

    try
      Result := StrToFloat(MultiPack);
    except
      Result := 0;
    end;

  end;


end;

end.
