unit uDmData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDMOPTIMIZA, IBSQL, DB, IBCustomDataSet, IBDatabase,
  IBStoredProc, IBQuery;

type
  TdmData = class(TdmOptimiza)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmData: TdmData;

implementation

{$R *.dfm}

end.
