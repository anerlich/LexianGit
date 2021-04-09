echo off
rem Version 1.0 - Initial Version
rem %1=Path containing file %2=File to search e.g. *.txt %3=String(s) to look for %4=MatchFolder %5=NonMatchFolder %6=ProcessedFolder
d:

:TryAgain
rem ==================================================================
rem Find the latest file that matches the pattern in %2 in the path %1
rem ==================================================================
O:
cd %1
for /f "eol=: delims=" %%A in ('dir %2 /O-D /B') do (
  set FN=%%A
  Goto :foundFile
)
Goto :byPass



:foundFile

rem ============================
rem remove quotes from path name
rem ============================
for /f "useback tokens=*" %%a in ('%1') do set thepath=%%~a


rem =====================================
rem Keep copy of file in Processed folder
rem =====================================
Copy "%FN%" %6

rem =================================
rem Search for string within the file
rem =================================

findstr /I /E %3 "%FN%"
if %errorlevel%==0 (
	Copy "%FN%" %4
) else (
	Copy "%FN%" %5
)
del "%FN%"

)
Goto :TryAgain

:byPass

"C:\Optimiza\FireEventMP.exe" S

