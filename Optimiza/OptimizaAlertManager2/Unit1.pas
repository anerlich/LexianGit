unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainInstance, ExtCtrls;

type
  TForm1 = class(TForm)
    MainInstance1: TMainInstance;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
     procedure IBShutDown(var Msg: tMessage); message wmMainInstanceMessage;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.IBShutDown(var Msg: tMessage);
var S: String;
    PC: array[0..MAX_PATH]of Char;
begin
  GlobalGetAtomName(Msg.wParam, PC, MAX_PATH);
  S:= StrPas(PC);
MessageDlg(S,mtInformation,[mbOK],0);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 MessageDlg('timer',mtInformation,[mbok],0);
 
end;

end.
