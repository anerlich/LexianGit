unit OnlyOpenOnce;
{Add the following to the main project:

This is due to an idea from "The Graphical Gnome" <rdb@ktibv.nl>, found in
source spotted on http://www.gnomehome.demon.nl/uddf/index.htm

This uses a concept called a fileMapping (suggested on the borland delphi technical
pages) so that it is perfectly safe to use in a Multitasking win32 environment.

DO NOT ADD MORE THAN ONE OF THESE TO A FORM - your app will continually crash.}

interface

uses
  Windows, Classes, Dialogs, Forms, SysUtils;
  //Messages, ShellApi, Graphics, Controls;

type
  TOnlyOpenOnce = class(TComponent)
  private
  protected
    { Protected declarations }
  public
    UniqueAppString: string;
    FWhatToDo : integer;
    FTerminateOnMultiple : Boolean;

    Constructor create(Owner: TComponent); override;
    Destructor Destroy;override;
    procedure Loaded;override;
    { Public declarations }
  published
    { Published declarations }
    Property UniqueString: String read UniqueAppString Write UniqueAppString;
    property WhatToDo : integer read FWhatToDo write FWhatToDo;
    property TerminateOnMultiple : Boolean read FTerminateOnMultiple write FTerminateOnMultiple;
  end;

procedure Register;
Function checkMultiple(FWhatToDo : integer) : boolean;
procedure BroadcastFocusMessage(Mess : integer);

implementation

var
  MessageId: Integer;
  FileHandle:THandle=0;
  WProc: TFNWndProc = Nil;
  UniquePChar: PChar;


{******************************************************************************}
procedure Register;
begin
  RegisterComponents('Optimiza', [TOnlyOpenOnce]);
end;

{******************************************************************************}
Constructor TOnlyOpenOnce.create(Owner: TComponent);
{checks that the user has given a correct string, creates a PChar string using this
String, and gets a message ID for this String.  It then calls CheckMultiple}
begin
  Inherited create(Owner);
  if length(UniqueAppString)=0 then
    UniqueAppString:=Application.title;
  if not(csDesigning in ComponentState) then
  begin
    Application.ShowMainForm:=False;
    UniquePChar:=StrAlloc(Length(UniqueAppString)+ 2);
    UniquePChar:=StrPCopy(UniquePChar, UniqueAppString);
    MessageID:=RegisterWindowMessage(UniquePChar);
  end;
end;

procedure TOnlyOpenOnce.Loaded;
begin
  inherited;
  {The RegisterWindowMessage function defines a new window message that is
  guaranteed to be unique throughout the system.  If two apps use the same string,
  the same id will be generated.  The returned message value can be used when
  calling the SendMessage or PostMessage function}
  if not(csDesigning in ComponentState) then begin
    if CheckMultiple(FWhatToDo) then
    begin
      Owner.Tag := 1;
      if FTerminateOnMultiple then begin
        Application.Terminate;//halt;
      end
    end
    else Owner.Tag := 0;
  end;
end;

{******************************************************************************}
Function NewWndProc(Handle: HWND; msg: integer; WParam, lparam: Longint): Longint; StdCall
{the new windo procedure.  Checks the message received and if it is the message that
was registered with the UniqueAppString then it knows that another copy of itself
has been started, otherwise it passes the message on to the old window procedure}
begin
  {check if this is the registered message}
  if Msg=MessageID then
  begin
    if lparam = 0 then begin
      {if main form is minimised then restore it}
      if IsIconic(Application.handle) then
        Application.restore;
      SetForeGroundWindow(Application.MainForm.Handle);
      Result := 0;
    end
    else begin
      Application.Terminate;
      Result := 0;
    end;
  end
  {otherwise pass the message to the old windows message proc}
  else
    result:=CallWindowProc(WProc,Handle,Msg,wParam,lParam);
end;

{******************************************************************************}
Destructor TOnlyOpenOnce.destroy;
{Deallocates the pchar String, and resets the window procedure}
begin
  if not(csDesigning in ComponentState) then
  begin
    StrDispose(UniquePChar);
    if WProc<>nil then
      {restore old window procedure}
      if GetWindowLong(Application.Handle, GWL_WNDPROC) = LongInt(@NewWndProc) then
        SetWindowLong(Application.handle, GWL_WNDPROC, Longint(WProc));
    CloseHandle(FileHandle)
  end;
  inherited destroy;
end;


{******************************************************************************}
Function CheckMultiple(FWhatToDo : integer) : boolean;
{creates a file mapping with a given name.  If a mapping of this name already
exists (the application is already running) then GetLastError will return
ErrorAlreadyExists so we send out a message to the other copies of this app.
If not, then we replace the standard windows procedure with our own and show the
main form}
begin
  FileHandle:=CreateFileMapping(THandle(-1),
                                nil,
                                PAGE_READONLY,
                                0,
                                32,
                                UniquePChar);
  if GetLastError=ERROR_ALREADY_EXISTS then
  begin
    Application.ShowMainForm:=false;
    BroadCastFocusMessage(FWhatToDo);
    Result:=True;
  end
  else begin
    //ShowWindow(Application.Handle, SW_Shownormal);
    //Application.ShowMainForm:=True;
    WProc:= TFNWndProc(SetWindowLong(Application.Handle,GWL_WNDPROC, Longint(@NewWndProc)));
    Result:=false;
  end;
end;

{******************************************************************************}
procedure BroadcastFocusMessage(Mess : integer);
{ This is called when there is already an instance running. It broadcasts the
focus message}
var
  BSMRecipients: DWORD;
begin
  { Don't flash main form }
  Application.ShowMainForm := False;
  { Post message and inform other instance to focus itself }
  BSMRecipients := BSM_APPLICATIONS;
  BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
                         @BSMRecipients, MessageID, 0, Mess);
end;
end.
