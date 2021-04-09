unit udmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery;

type
  TdmData = class(TdmOptimiza)
    spCopyDisag: TIBStoredProc;
    qryLocsForModel: TIBQuery;
    spSetDisagRatios: TIBStoredProc;
    qryMiscCheck: TIBQuery;
    spCheckSkuSize: TIBStoredProc;
  private
    { Private declarations }
  public
    function CopyDisag(OrgModelCode,OrgLocCode,Switch,SwitchDate,TgtModelCode,TgtLocCodes:string; var Msg:string; var ValidLocList : TStringList): Boolean;
    function SetDisag (Switch,SwitchDate,TgtModelCode,TgtLocCodes:string;RatioD,RatioG,RatioJ,RatioK,RatioQ,RatioS,RatioT,RatioX:single;var Msg:string; var ValidLocList : TStringList): Boolean;
    function ModelExistsInLocs(ModelCode,LocCodes:string; var Msg: string; var ValidLocList : TStringList) : Boolean;
    function ModelExistsSameLocs(OrgModelCode,TgtModelCode : string; var Msg : string; var ValidLocList : TStringList) : boolean;
    function CheckSkuSizes(OrgModelCode,OrgLocCode,TgtModelCode,TgtLocCodes : string; var Msg : string; var ValidLocList : TStringList) : boolean;
    function CheckSkuSize(OrgModelCode,OrgLocCode,TgtModelCode,TgtLocCode : string; var Msg : string; var ValidLocList : TStringList) : boolean;
    function CheckSkuSizesExist(TgtModelCode,TgtLocCodes: string;RatioD,RatioG,RatioJ,RatioK,RatioQ,RatioS,RatioT,RatioX : single; var Msg : string; var ValidLocList : TStringList) : boolean;
    function CheckSkuSizeExists(TgtModelCode,TgtLocCode,SizeCode: string; var Msg : string; var ValidLocList : TStringList) : boolean;
  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

function TdmData.CopyDisag (OrgModelCode,OrgLocCode,Switch,SwitchDate,TgtModelCode,TgtLocCodes:string; var Msg:string; var ValidLocList : TStringList): Boolean;
var
  i,index,SwitchCalNo: integer;
  TgtLocCodeStrings: TStrings;
begin
  try
    Result := true;
    if AnsiLowerCase(Switch) = 'y' then
    begin
      Switch := 'Y';
      SwitchCalNo := GetCalendarPeriod(SwitchDate);
    end
    else
    begin
      Switch := 'N';
    end;
    if ((AnsiLowerCase(OrgLocCode) = 'all') and (AnsiLowerCase(TgtLocCodes) = 'all')) then
    begin
      //get the locations the the model exists in the disag tables.
      with qryLocsForModel do
      begin
        close;
        ParamByName('prodcode').AsString := OrgModelCode;
        open;
        first;
        while not eof do
        begin
          if ValidLocList.Find(FieldByName('locationcode').AsString,index) then
          begin
            spCopyDisag.ParamByName('ORGMODELCODE').AsString := OrgModelCode;
            spCopyDisag.ParamByName('ORGLOCCODE').AsString := FieldByName('locationcode').AsString;
            spCopyDisag.ParamByName('SWITCH').AsString := Switch;
            spCopyDisag.ParamByName('SWITCHCALNO').AsInteger := SwitchCalNo;
            spCopyDisag.ParamByName('TGTMODELCODE').AsString := TgtModelCode;
            spCopyDisag.ParamByName('TGTLOCCODE').AsString := FieldByName('locationcode').AsString;
            spCopyDisag.execproc;
          end;
          next;
        end;
        close;
      end
    end
    else if ((AnsiLowerCase(OrgLocCode) <> 'all') and(AnsiLowerCase(TgtLocCodes) = 'all')) then
    begin
      //get the locations the the model exists in the disag tables.
      with qryLocsForModel do
      begin
        close;
        ParamByName('prodcode').AsString := TgtModelCode;
        open;
        first;
        while not eof do
        begin
          if ValidLocList.Find(FieldByName('locationcode').AsString,index) then
          begin
            spCopyDisag.ParamByName('ORGMODELCODE').AsString := OrgModelCode;
            spCopyDisag.ParamByName('ORGLOCCODE').AsString := OrgLocCode;
            spCopyDisag.ParamByName('SWITCH').AsString := Switch;
            spCopyDisag.ParamByName('SWITCHCALNO').AsInteger := SwitchCalNo;
            spCopyDisag.ParamByName('TGTMODELCODE').AsString := TgtModelCode;
            spCopyDisag.ParamByName('TGTLOCCODE').AsString := FieldByName('locationcode').AsString;
            spCopyDisag.execproc;
          end;
          next;
        end;
        close;
      end
    end
    else if ((AnsiLowerCase(OrgLocCode) <> 'all') and(AnsiLowerCase(TgtLocCodes) <> 'all')) then
    begin
      TgtLocCodeStrings := TStringList.Create;
      ExtractStrings([','],[],PChar(TgtLocCodes),TgtLocCodeStrings);
      for i:=0 to TgtLocCodeStrings.Count-1 do
      begin
        if ValidLocList.Find(Trim(TgtLocCodeStrings[i]),index) then
        begin
          spCopyDisag.ParamByName('ORGMODELCODE').AsString := OrgModelCode;
          spCopyDisag.ParamByName('ORGLOCCODE').AsString := OrgLocCode;
          spCopyDisag.ParamByName('SWITCH').AsString := Switch;
          spCopyDisag.ParamByName('SWITCHCALNO').AsInteger := SwitchCalNo;
          spCopyDisag.ParamByName('TGTMODELCODE').AsString := TgtModelCode;
          spCopyDisag.ParamByName('TGTLOCCODE').AsString := Trim(TgtLocCodeStrings[i]);
          spCopyDisag.execproc;
        end;
      end;
      TgtLocCodeStrings.Free;
    end;
  except
    on e: exception do begin
      Msg := e.Message;
      Result := False;
    end;
  end;

end;

function TdmData.SetDisag (Switch,SwitchDate,TgtModelCode,TgtLocCodes:string;RatioD,RatioG,RatioJ,RatioK,RatioQ,RatioS,RatioT,RatioX:single;var Msg:string; var ValidLocList : TStringList): Boolean;
var
 i,index,SwitchCalNo: integer;
 TgtLocCodeStrings: TStrings;
begin
  try
    Result := true;
    if AnsiLowerCase(Switch) = 'y' then
    begin
      Switch := 'Y';
      SwitchCalNo := GetCalendarPeriod(SwitchDate);
    end
    else
    begin
      Switch := 'N';
    end;
    if (AnsiLowerCase(TgtLocCodes) = 'all') then
    begin
      //get the locations the model exists in the disag tables.
      with qryLocsForModel do
      begin
        close;
        ParamByName('prodcode').AsString := TgtModelCode;
        open;
        first;
        while not eof do
        begin
          if ValidLocList.Find(FieldByName('locationcode').AsString,index) then
          begin
            spSetDisagRatios.ParamByName('SWITCH').AsString := Switch;
            spSetDisagRatios.ParamByName('SWITCHCALNO').AsInteger := SwitchCalNo;
            spSetDisagRatios.ParamByName('TGTMODELCODE').AsString := TgtModelCode;
            spSetDisagRatios.ParamByName('TGTLOCCODE').AsString := FieldByName('locationcode').AsString;
            spSetDisagRatios.ParamByName('RATIO_D').AsFloat := RatioD/100;
            spSetDisagRatios.ParamByName('RATIO_G').AsFloat := RatioG/100;
            spSetDisagRatios.ParamByName('RATIO_J').AsFloat := RatioJ/100;
            spSetDisagRatios.ParamByName('RATIO_K').AsFloat := RatioK/100;
            spSetDisagRatios.ParamByName('RATIO_Q').AsFloat := RatioQ/100;
            spSetDisagRatios.ParamByName('RATIO_S').AsFloat := RatioS/100;
            spSetDisagRatios.ParamByName('RATIO_T').AsFloat := RatioT/100;
            spSetDisagRatios.ParamByName('RATIO_X').AsFloat := RatioX/100;
            spSetDisagRatios.execproc;
          end;
          next;
        end;
        close;
      end
    end
    else
    begin
      TgtLocCodeStrings := TStringList.Create;
      ExtractStrings([','],[],PChar(TgtLocCodes),TgtLocCodeStrings);
      for i:=0 to TgtLocCodeStrings.Count-1 do
      begin
        if ValidLocList.Find(Trim(TgtLocCodeStrings[i]),index) then
        begin
          spSetDisagRatios.ParamByName('SWITCH').AsString := Switch;
          spSetDisagRatios.ParamByName('SWITCHCALNO').AsInteger := SwitchCalNo;
          spSetDisagRatios.ParamByName('TGTMODELCODE').AsString := TgtModelCode;
          spSetDisagRatios.ParamByName('TGTLOCCODE').AsString := Trim(TgtLocCodeStrings[i]);
          spSetDisagRatios.ParamByName('RATIO_D').AsFloat := RatioD/100;
          spSetDisagRatios.ParamByName('RATIO_G').AsFloat := RatioG/100;
          spSetDisagRatios.ParamByName('RATIO_J').AsFloat := RatioJ/100;
          spSetDisagRatios.ParamByName('RATIO_K').AsFloat := RatioK/100;
          spSetDisagRatios.ParamByName('RATIO_Q').AsFloat := RatioQ/100;
          spSetDisagRatios.ParamByName('RATIO_S').AsFloat := RatioS/100;
          spSetDisagRatios.ParamByName('RATIO_T').AsFloat := RatioT/100;
          spSetDisagRatios.ParamByName('RATIO_X').AsFloat := RatioX/100;
          spSetDisagRatios.execproc;
        end;
      end;
      TgtLocCodeStrings.Free;
    end;
  except
    on e: exception do begin
      Msg := e.Message;
      Result := False;
    end;
  end;
end;

function TdmData.ModelExistsInLocs(ModelCode,LocCodes : string;var Msg : string; var ValidLocList : TStringList) : Boolean;
var
  LocCodeStrings : TStrings;
  i,index : integer;
begin
  Result := True;
  qryMiscCheck.SQL.Clear;
  qryMiscCheck.Params.Clear;
  if AnsiLowerCase(LocCodes) = 'any' then
  begin
      qryMiscCheck.SQL.Add('select count(i.itemno) as itemcount ');
      qryMiscCheck.SQL.Add('from item i ');
      qryMiscCheck.SQL.Add('inner join location l on i.locationno = l.locationno ');
      qryMiscCheck.SQL.Add('inner join product p on i.productno = p.productno ');
      qryMiscCheck.SQL.Add('inner join ut_disaglevel0 dl0 on dl0.itemno = i.itemno ');
      qryMiscCheck.SQL.Add('where p.productcode = ''' + Trim(ModelCode) + '''');
      qryMiscCheck.Open;
      qryMiscCheck.First;
      if qryMiscCheck['itemcount'] = 0 then
      begin
        Result := false;
        Msg := Msg + 'Model ' + Trim(ModelCode) + ' does not exist in any valid locations; ';
      end;
      qryMiscCheck.Close;
  end
  else
  begin
      LocCodeStrings := TStringList.Create;
      ExtractStrings([','],[],PChar(LocCodes),LocCodeStrings);
      for i:=0 to LocCodeStrings.Count-1 do
      begin
        if ValidLocList.Find(Trim(LocCodeStrings[i]),index) then
        begin
          qryMiscCheck.Params.Clear;
          qryMiscCheck.SQL.Add('select count(i.itemno) as itemcount ');
          qryMiscCheck.SQL.Add('from item i ');
          qryMiscCheck.SQL.Add('inner join location l on i.locationno = l.locationno ');
          qryMiscCheck.SQL.Add('inner join product p on i.productno = p.productno ');
          qryMiscCheck.SQL.Add('inner join ut_disaglevel0 dl0 on dl0.itemno = i.itemno ');
          qryMiscCheck.SQL.Add('where p.productcode = ''' + Trim(ModelCode) + ''' and l.locationcode = ''' + Trim(LocCodeStrings[i]) + '''');
          qryMiscCheck.Open;
          qryMiscCheck.First;
          if qryMiscCheck['itemcount'] = 0 then
          begin
            Result := false;
            Msg := Msg + 'Model ' + Trim(ModelCode) + ' does not exist in location: ' + Trim(LocCodeStrings[i]) + '; ';
          end;
          qryMiscCheck.Close;
        end;
      end;
  end;
end;

function TdmData.ModelExistsSameLocs(OrgModelCode,TgtModelCode : string; var Msg : string; var ValidLocList : TStringList) : boolean;
var
  index : integer;
begin
  Result := True;
  if (ValidLocList.Find(Trim(OrgModelCode),index)) and (ValidLocList.Find(Trim(TgtModelCode),index)) then
  begin
    qryMiscCheck.SQL.Clear;
    qryMiscCheck.Params.Clear;
    qryMiscCheck.SQL.Add('select COUNT(*) as itemcount ');
    qryMiscCheck.SQL.Add('from ');
    qryMiscCheck.SQL.Add('(select i.locationno ');
    qryMiscCheck.SQL.Add('from item i ');
    qryMiscCheck.SQL.Add('inner join product p on i.productno = p.productno ');
    qryMiscCheck.SQL.Add('inner join ut_disaglevel0 dl0 on dl0.itemno = i.itemno ');
    qryMiscCheck.SQL.Add('where p.productcode = ''' + OrgModelCode + ''') as orglocnos ');
    qryMiscCheck.SQL.Add('full outer join ');
    qryMiscCheck.SQL.Add('(select i.locationno ');
    qryMiscCheck.SQL.Add('from item i ');
    qryMiscCheck.SQL.Add('inner join product p on i.productno = p.productno ');
    qryMiscCheck.SQL.Add('inner join ut_disaglevel0 dl0 on dl0.itemno = i.itemno ');
    qryMiscCheck.SQL.Add('where p.productcode = ''' + TgtModelCode + ''') as tgtlocnos ');
    qryMiscCheck.SQL.Add('on orglocnos.locationno = tgtlocnos.locationno ');
    qryMiscCheck.SQL.Add('where orglocnos.locationno is null or tgtlocnos.locationno is null ');
    if qryMiscCheck['itemcount'] > 0 then
    begin
      Result := false;
      Msg := Msg + 'Model ' + Trim(OrgModelCode) + ' does not exist in all the same locations as model: ' + Trim(TgtModelCode) + '; ';
    end;
    qryMiscCheck.Close;
  end;
end;

function TdmData.CheckSkuSizes(OrgModelCode,OrgLocCode,TgtModelCode,TgtLocCodes : string; var Msg : string; var ValidLocList : TStringList) : boolean;
var
  LocCodeStrings : TStrings;
  i, index : integer;
begin
  Result := True;
  if (AnsiLowerCase(OrgLocCode) = 'all') and (AnsiLowerCase(TgtLocCodes) = 'all') then
  begin
    with qryLocsForModel do
      begin
        close;
        ParamByName('prodcode').AsString := OrgModelCode;
        open;
        first;
        while not eof do
        begin
          if ValidLocList.Find(FieldByName('locationcode').AsString,index)  then
          begin
            if not CheckSkuSize(OrgModelCode,FieldByName('locationcode').AsString,TgtModelCode,FieldByName('locationcode').AsString,Msg,ValidLocList) then
            begin
              Result := false;
            end;
          end;
          next;
        end;
        close;
      end;
  end
  else if (AnsiLowerCase(OrgLocCode) <> 'all') and (AnsiLowerCase(TgtLocCodes) = 'all') then
  begin
    with qryLocsForModel do
      begin
        close;
        ParamByName('prodcode').AsString := TgtModelCode;
        open;
        first;
        while not eof do
        begin
          if ValidLocList.Find(FieldByName('locationcode').AsString,index)  then
          begin
            if not CheckSkuSize(OrgModelCode,OrgLocCode,TgtModelCode,FieldByName('locationcode').AsString,Msg,ValidLocList) then
            begin
              Result := false;
            end;
          end;
          next;
        end;
        close;
      end;
  end
  else if (AnsiLowerCase(OrgLocCode) <> 'all') and (AnsiLowerCase(TgtLocCodes) <> 'all') then
  begin
    LocCodeStrings := TStringList.Create;
    ExtractStrings([','],[],PChar(TgtLocCodes),LocCodeStrings);
    for i:=0 to LocCodeStrings.Count-1 do
    begin
      if (ValidLocList.Find(Trim(OrgLocCode),index)) and (ValidLocList.Find(Trim(LocCodeStrings[i]),index))  then
      begin
        if not CheckSkuSize(OrgModelCode,OrgLocCode,TgtModelCode,LocCodeStrings[i],Msg,ValidLocList) then
        begin
          Result := false;
        end;
      end;
    end;
  end;

end;

function TdmData.CheckSkuSize(OrgModelCode,OrgLocCode,TgtModelCode,TgtLocCode : string; var Msg : string; var ValidLocList : TStringList) : boolean;
var
  spResult : string;
begin
  Result := true;
  spCheckSkuSize.ParamByName('ORGMODELCODE').AsString := OrgModelCode;
  spCheckSkuSize.ParamByName('ORGLOCCODE').AsString := OrgLocCode;
  spCheckSkuSize.ParamByName('TGTMODELCODE').AsString := TgtModelCode;
  spCheckSkuSize.ParamByName('TGTLOCCODE').AsString := TgtLocCode;
  spCheckSkuSize.execproc;
  spResult :=  spCheckSkuSize.ParamByName('RESULT').AsString;
  if AnsiLowerCase(spResult) = 'n' then
  begin
     Msg := Msg + 'No skus exist for origin model: ' +  OrgModelCode + ' in location: ' +  OrgLocCode + '; ';
     Result := false;
  end
  else if AnsiLowerCase(spResult) = 'f' then
  begin
    Msg := Msg + 'Sku sizes do not match for origin model: ' + OrgModelCode + ' origin location: ' + OrgLocCode + ' target model: ' + TgtModelCode + ' target location: ' + TgtLocCode + '; ';
    Result := false;
  end;
end;

function TdmData.CheckSkuSizesExist(TgtModelCode,TgtLocCodes: string;RatioD,RatioG,RatioJ,RatioK,RatioQ,RatioS,RatioT,RatioX : single; var Msg : string; var ValidLocList : TStringList) : boolean;
var
  LocCodeStrings : TStrings;
  i, index : integer;
begin
  Result := true;
  if AnsiLowerCase(TgtLocCodes) = 'all' then
  begin
  with qryLocsForModel do
  begin
    close;
    ParamByName('prodcode').AsString := TgtModelCode;
    open;
    first;
    while not eof do
    begin
      if ValidLocList.Find(FieldByName('locationcode').AsString,index)  then
        begin
          if(RatioD > 0) then
          begin
            if not CheckSkuSizeExists(TgtModelCode,FieldByName('locationcode').AsString,'d',Msg,ValidLocList) then
            begin
            Result := false;
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    LocCodeStrings := TStringList.Create;
    ExtractStrings([','],[],PChar(TgtLocCodes),LocCodeStrings);
    for i:=0 to LocCodeStrings.Count-1 do
    begin
      if ValidLocList.Find(Trim(LocCodeStrings[i]),index) then
      begin
        if(RatioD > 0) then
        begin
          if not CheckSkuSizeExists(TgtModelCode,Trim(LocCodeStrings[i]),'d',Msg,ValidLocList) then
          begin
          Result := false;
          end;
        end;
      end;
    end;
  end;
end;

function TdmData.CheckSkuSizeExists(TgtModelCode,TgtLocCode,SizeCode: string; var Msg : string; var ValidLocList : TStringList) : boolean;
var
  repcatno : string;
begin
    Result := true;
    qryMiscCheck.SQL.Clear;
    qryMiscCheck.Params.Clear;
    SizeCode := AnsiLowerCase(SizeCode);
    if SizeCode = 'd' then repcatno := '11'
    else if SizeCode = 'g' then repcatno := '12'
    else if SizeCode = 'j' then repcatno := '13'
    else if SizeCode = 'k' then repcatno := '25'
    else if SizeCode = 'q' then repcatno := '14'
    else if SizeCode = 's' then repcatno := '15'
    else if SizeCode = 't' then repcatno := '16'
    else if SizeCode = 'x' then repcatno := '18';
    qryMiscCheck.SQL.Add('select COUNT(*) as itemcount ');
    qryMiscCheck.SQL.Add('from UT_DISAGLEVEL1 dl1 ');
    qryMiscCheck.SQL.Add('left outer join ITEM_REPORTCATEGORY ircskuflag on dl1.itemno = ircskuflag.itemno and ircskuflag.reportcategorytype = 42 '); //Sku Flag
    qryMiscCheck.SQL.Add('left outer join ITEM_REPORTCATEGORY ircprodtype on dl1.itemno = ircprodtype.itemno and ircprodtype.reportcategorytype = 43 '); //Product Type
    qryMiscCheck.SQL.Add('where LEVEL0_DISAGITEMNO = ( ');
    qryMiscCheck.SQL.Add('select first 1 dl0.disagitemno ');
    qryMiscCheck.SQL.Add('from item i ');
    qryMiscCheck.SQL.Add('inner join location l on i.locationno = l.locationno ');
    qryMiscCheck.SQL.Add('inner join product p on i.productno = p.productno ');
    qryMiscCheck.SQL.Add('inner join ut_disaglevel0 dl0 on dl0.itemno = i.itemno ');
    qryMiscCheck.SQL.Add('where p.productcode = ''' + Trim(TgtModelCode) + '''  and l.locationcode = ''' + Trim(TgtLocCode) + ''')' );
    qryMiscCheck.SQL.Add('and ircskuflag.reportcategoryno = 1 and ircprodtype.reportcategoryno = ' + repcatno + ';');
    qryMiscCheck.Open;
    qryMiscCheck.First;
    if qryMiscCheck['itemcount'] <> 1 then
    begin
      Result := false;
      Msg := Msg + 'Model: ' + Trim(TgtModelCode) + ' size: ' + Trim(SizeCode) + ' does not exist in location: ' + Trim(TgtLocCode) + '; ';
    end;
    qryMiscCheck.Close;

end;



end.
