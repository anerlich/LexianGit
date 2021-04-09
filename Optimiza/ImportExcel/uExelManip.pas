unit uExelManip;

interface
  uses ComObj, Variants;
  procedure StartExcel;
  procedure StopExcel;
  function OpenWorkBook(FilePath:String):Variant;
  function OpenTemplate(FilePath:String):Variant;
  var oExcel:variant;

implementation
  procedure StartExcel;
  begin
    oExcel:=UnAssigned;
    oExcel:=CreateOleObject('Excel.Application');
    oExcel.Visible:=false;
    oExcel.DisplayAlerts:=false;
  end;

  procedure StopExcel;
  begin
    try
      oExcel.Quit;
    finally
      oExcel:=Unassigned;
    end;
  end;

  function OpenWorkBook(FilePath:String):Variant;
  begin
    try
      Result := oExcel.Workbooks.Open(FilePath);
    except
      //say('Workbook '+ FilePath + 'not found.';
      Result := false;
    end;
  end;

  function OpenTemplate(FilePath:String):Variant;
  begin
    try
      Result := oExcel.Workbooks.Add(FilePath);
    except
      //say('Workbook '+ FilePath + 'not found.';
      Result := false;
    end;
  end;
end.


