unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    SaveDialog1: TSaveDialog;
    DBEdit1: TDBEdit;
    DBNavigator1: TDBNavigator;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FirstShow:Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses uCalculateRequirement, udmMainDLL;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Edit1.Text := SaveDialog1.FileName;
    
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  frmCalculateRequirement.Show;
  frmCalculateRequirement.FName := edit1.Text;
  frmCalculateRequirement.FLocationNo := dmMainDLL.srcSelectLocation.DataSet.fieldByName('LocationNo').AsInteger;
  
  frmCalculateRequirement.RunTheProcess;
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FirstShow := True;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin

  if FirstShow then
  begin
    FirstShow := False;
    dmMainDll.qrySelectLocation.Open;

  end;


end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    dmMainDll.qrySelectLocation.Close;

end;

end.
