unit uFileWait;

interface
uses
  Windows,ShellAPI;

function ExecuteFileWait(CmdLine,CurrentDirectory: string): boolean;
function ShellOpenFile( hWnd : HWND; AFileName, AParams, ADefaultDir : string ) : integer;


implementation

function ExecuteFileWait(CmdLine,CurrentDirectory: string): boolean;
var
 si:TStartupInfo;
 pi:TProcessInformation;
 pCurrentDirectory:pchar;
begin
 if CurrentDirectory<>'' then pCurrentDirectory:=pchar(CurrentDirectory)
 else pCurrentDirectory:=nil;
 ZeroMemory(@si,sizeof(si));
 si.cb:=SizeOf(si);
 if not CreateProcess( nil, // No module name (use command line).
  PChar(cmdline),  // Command line.
  nil,             // Process handle not inheritable.
  nil,             // Thread handle not inheritable.
  False,           // Set handle inheritance to FALSE.
  0,               // No creation flags.
  nil,             // Use parent's environment block.
  pCurrentDirectory,// **Use parent's starting directory.
  si,              // Pointer to STARTUPINFO structure.
  pi )             // Pointer to PROCESS_INFORMATION structure.
 then begin
  Result:=false;//        ShowMessage( 'CreateProcess failed.' );
  Exit;
 end;
 WaitForSingleObject( pi.hProcess, INFINITE );
 CloseHandle( pi.hProcess );
 CloseHandle( pi.hThread );
 Result:=true;//      ShowMessage('Done !');
end;

function ShellOpenFile( hWnd : HWND; AFileName, AParams, ADefaultDir : string ) : integer;
begin
  result := shellapi.ShellExecute( hWnd, 'open', pChar( AFileName ),
                                   pChar(AParams),
                                   pChar(ADefaultDir),
                                   SW_SHOWDEFAULT );
end;

end.
