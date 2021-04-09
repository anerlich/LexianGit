unit ufrmTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus;

type
  TfrmTest = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    AMainMenu1: TMainMenu;
  public
    { Public declarations }
  end;

var
  frmTest: TfrmTest;

implementation

{$R *.dfm}

procedure TfrmTest.Button1Click(Sender: TObject);
begin

  AMainMenu1 := TMainMenu.Create(frmTest);
  ReadComponentResFile('MenuTest.dfm', AMainMenu1);
end;

end.
