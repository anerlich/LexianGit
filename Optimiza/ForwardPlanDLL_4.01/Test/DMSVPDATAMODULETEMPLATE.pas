unit dmSVPDataModuleTemplate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IBCustomDataSet, IBSQL;

type
  TSVPDataModuleTemplate = class(TDataModule)
    procedure SVPDataModuleTemplateDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SVPDataModuleTemplate: TSVPDataModuleTemplate;

implementation

{$R *.DFM}

procedure TSVPDataModuleTemplate.SVPDataModuleTemplateDestroy(
  Sender: TObject);
var
  n : integer;

begin
  Screen.Cursor := crHourGlass;
  try
    for n := 0 to ComponentCount -1 do
      if Components[n] is TIBSQL then
        TIBSQL(Components[n]).Close
      else
        if Components[n] is TIBDataSet then
          TIBDataSet(Components[n]).Close;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
