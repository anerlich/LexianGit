unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure MoveMouseOverControl(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.MoveMouseOverControl(Sender: TObject);
var x,y: integer;
    StartX,XPos,YPos:Integer;
    point: TPoint; 
begin

  StartX := Screen.DesktopRect.BottomRight.X-300;
  Label2.Caption := intToStr(StartX);
  Application.ProcessMessages;
  YPos := Screen.DesktopRect.BottomRight.Y-15;
  XPos := StartX;

  with TControl(Sender) do
  begin
    x:= left + (width div 2);
    y:= top + (height div 2);
    point:= Parent.ClientToScreen(point);
    for XPos := StartX+500 downto StartX do
    begin
      SetCursorPos(XPos, YPos);
      Sleep(1);
    end;
    //SetCursorPos(point.x, point.y);
  end; 
end;


procedure TForm1.BitBtn2Click(Sender: TObject);
begin
 MoveMouseOverControl(Sender);
 Close;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Show;
  Label1.Caption := IntToStr(Screen.Width);
  Application.ProcessMessages;

  BitBtn2.Click;
end;

end.
