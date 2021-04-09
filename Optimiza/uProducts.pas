unit uProducts;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, DBCtrls, Grids, DBGrids, Dialogs, PgCSV;

type
  TfrmProducts = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    PgCSV1: TPgCSV;
    SaveDialog1: TSaveDialog;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProducts: TfrmProducts;

implementation

uses uDmUpdateSpecial;

{$R *.DFM}

procedure TfrmProducts.BitBtn2Click(Sender: TObject);
var F: TextFile;
  Save_Cursor:TCursor;

begin

  if SaveDialog1.Execute then
  begin

    AssignFile(F, SaveDialog1.FileName);
    Rewrite(F);
    CloseFile(F);
    PGCsv1.CSVFile := SaveDialog1.FileName;

    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crSQLWait;

    try
      PgCsv1.DatasetToCSV;
      MessageDlg('Output Saved to :'+ SaveDialog1.FileName,mtInformation,[mbOk],0);

    finally
        Screen.Cursor := Save_Cursor;
    end;



  end;


end;

end.
