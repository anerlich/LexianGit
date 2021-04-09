//   original system: PBJustOne by Patrick Brisacier (PBrisacier@mail.dotcom.fr)
//   using of Atom: Ken Hale and Coda Hale (kenhale@dcalcoda.com)
//   DCR contained bitmap: Troels S Eriksen (TSErikse@post8.tele.dk)
//   assembler: Paul Sitkei(sitkei@elender.hu)

unit MainInstance;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms;

type
  TMainInstance = class(TComponent)
  public
    constructor Create(aOwner: TComponent); override;
  end;

const wmMainInstanceMessage = WM_USER+ 101;            //new

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TMainInstance]);
end;

var
  MyAppName, MyClassName: array[0..255] of Char;
  NumFound: Integer;
  LastFound, MyPopup: HWND;

function LookAtAllWindows(Handle: HWND; Temp: LongInt): BOOL; stdcall;
var
  WindowName, ClassName: Array[0..255] of Char;
begin
  if (GetClassName(Handle, ClassName, SizeOf(ClassName)) > 0) and
     (StrComp(ClassName, MyClassName) = 0) and
     (GetWindowText(Handle, WindowName, SizeOf(WindowName)) > 0) and
     (StrComp(WindowName, MyAppName) = 0) then
  begin
    Inc(NumFound);
    if Handle <> Application.Handle then LastFound := Handle;
  end;
  Result:= True;
end;

function SendParam(aHandle: hWND): Boolean;             //new
var S: String;
    i: Integer;
    Atom: tAtom;
begin
  Result:= False;
  S:= '';
  for i:= 1 to ParamCount do
  begin
    S:= S+ ParamStr(i)+ ' ';
    if Pos('.EXE', UpperCase(S))<>0 then S:= '';
  end;
  if S='' then Exit;
  Atom := GlobalAddAtom(PChar(S));
  SendMessage(aHandle, wmMainInstanceMessage, Atom, 0);
  GlobalDeleteAtom(Atom);
  Result:= True;
end;

constructor TMainInstance.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  NumFound := 0;
  LastFound := 0;
  GetWindowText(Application.Handle, MyAppName, SizeOf(MyAppName));
  GetClassName(Application.Handle, MyClassName, SizeOf(MyClassName));
  EnumWindows(@LookAtAllWindows, 0);
  if NumFound> 1 then
  begin
    MyPopup := GetLastActivePopup(LastFound);
    SendParam(MyPopup);                                //new
    BringWindowToTop(LastFound);
    if IsIconic(MyPopup)
      then ShowWindow(MyPopup, SW_RESTORE)
      else SetForegroundWindow(MyPopup);
    Application.Terminate;
  end
end;

end.
