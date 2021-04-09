echo off
rem Version 1.0 - Initial Version
rem Version 1.1 - Made all directories parameter driven
rem %1=Path containing file %2=File to search(Without leading date and trailing ".log") %3=String to look for %4=Email ini file to use(Full Path) %5=If Y attach the file to the email %6=Path to Specials %7=Path to Optimiza
d:

rem ==================================================================
rem Find the latest file that matches the pattern in %2 in the path %1
rem ==================================================================
cd %1
for /f "eol=: delims=" %%A in ('dir *%2* /O-D /B') do (
  set FN=%%A
  Goto :foundFile
)
Goto :byPass

:foundFile

rem ============================
rem remove quotes from path name
rem ============================
for /f "useback tokens=*" %%a in ('%1') do set thepath=%%~a

rem =================================
rem Search for string within the file
rem =================================
findstr /m /I %3 "%FN%"
if %errorlevel%==0 (
	rem ==========================================
	rem we have found the string so send the email
	rem ==========================================
	if %5==Y (
		rem =======================================
		rem we need to attach the file to the email
		rem =======================================
		setlocal enabledelayedexpansion
		>%4.ini (
		   for /f "delims=" %%A in (%4) do (
			set string=%%A
			if "!string:~0,12!"=="Attachments="  ( 
				echo Attachments="%thepath%\!FN!"
			) else if "!string:~0,8!"=="Subject=" (
				echo Subject=Error string %3 found in Log file "!FN!"
			) else ( 
				echo.!string!
			)
		   )
		)
	) else (
		rem =============================================
		rem we don't need to attach the file to the email
		rem =============================================
		Copy %4 %4.ini
	)
	cd %6
	emailer %4.ini "NOFIREEVENT"
	del %4.ini

)

:byPass
cd %7
"FireEventMP.exe" S
cd %6

