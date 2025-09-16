@echo off
setlocal

rem Get the current directory
set "CURDIR=%~dp0"
rem Remove backslash
if "%CURDIR:~-1%"=="\" set "CURDIR=%CURDIR:~0,-1%"

rem Source file path shell2ui.ico in the "files" folder
set "SOURCEICON=%CURDIR%\files\shell2ui.ico"
rem Destination path in System32
set "DESTICON=C:\Windows\System32\shell2ui.ico"

rem Copy the .ico file to System32 (requires admin)
echo Copying "%SOURCEICON%" to "%DESTICON%"...
copy /Y "%SOURCEICON%" "%DESTICON%"
if errorlevel 1 (
    echo ERROR: copy failed. Run this script as administrator.
    pause
    exit /b 1
)

rem Source file path installer.reg in the "files" folder
set "REGFILE=%CURDIR%\files\installer.reg"

rem Check if installer.reg exists
if not exist "%REGFILE%" (
    echo ERROR: installer.reg file not found in "%CURDIR%\files".
    pause
    exit /b 1
)

rem Execute the .reg file
echo Importing registry file "%REGFILE%"...
reg import "%REGFILE%"
if errorlevel 1 (
    echo ERROR: registry import failed.
    pause
    exit /b 1
)

rem Copy shell2ui.bat to System32'
set "BATCHFILE=%CURDIR%\files\shell2ui.bat"
set "DESTBATCH=C:\Windows\System32\shell2ui.bat"

echo Copying shell2ui.bat to System32...
copy /Y "%BATCHFILE%" "%DESTBATCH%"
if errorlevel 1 (
    echo ERROR: Failed to copy shell2ui.bat. Run this script as administrator.
    pause
    exit /b 1
)

echo Installation completed successfully.
pause
