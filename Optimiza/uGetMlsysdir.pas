unit uGetMlsysdir;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UGETFILEPATH, StdCtrls, ExtCtrls;

type
  TfrmFileName = class(TfrmGetFilePath)
    Label2: TLabel;
    Edit2: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFileName: TfrmFileName;

implementation

{$R *.DFM}

procedure TfrmFileName.FormCreate(Sender: TObject);
begin
  inherited;
  Edit1.Text := 'Mlsysdir.dbf'; 
end;

end.
