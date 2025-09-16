@echo off
setlocal

rem Get the directory of this script
set "CURDIR=%~dp0"
if "%CURDIR:~-1%"=="\" set "CURDIR=%CURDIR:~0,-1%"

rem Delete the icon copied by the installer
set "DESTICON=C:\Windows\System32\shell2ui.ico"

if exist "%DESTICON%" (
    echo Deleting "%DESTICON%"...
    del /F /Q "%DESTICON%"
    if errorlevel 1 (
        echo ERROR: Failed to delete "%DESTICON%". Run this script as administrator.
        pause
        exit /b 1
    )
) else (
    echo "%DESTICON%" not found. Skipping deletion.
)

rem Import the uninstaller registry file
set "REGFILE=%CURDIR%\files\uninstaller.reg"

if not exist "%REGFILE%" (
    echo ERROR: uninstaller.reg not found in "%CURDIR%\files".
    pause
    exit /b 1
)

echo Importing registry file "%REGFILE%"...
reg import "%REGFILE%"
if errorlevel 1 (
    echo ERROR: Registry import failed. Run this script as administrator.
    pause
    exit /b 1
)

:: Path to the shell2ui alias in System32
set "BATCHPATH=C:\Windows\System32\shell2ui.bat"

if exist "%BATCHPATH%" (
    echo Deleting shell2ui alias...
    del /F /Q "%BATCHPATH%"
    if errorlevel 1 (
        echo ERROR: Failed to delete shell2ui.bat. Run this script as administrator.
        pause
        exit /b 1
    )
    echo shell2ui alias removed successfully.
) else (
    echo shell2ui alias not found. Nothing to do.
)

echo Uninstallation completed successfully.
pause
