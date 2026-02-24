@echo off
title Yeet Injector - Setup
color 0A

echo.
echo  ============================================
echo    YEET INJECTOR - Setup
echo    github.com/boogiegainz/yeet-injector
echo  ============================================
echo.

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo  [!] Requesting Administrator privileges...
    echo.
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo  [*] Running as Administrator. Good.
echo.

:: Check if .NET 8 Desktop Runtime is installed
echo  [*] Checking for .NET 8 Desktop Runtime...
dotnet --list-runtimes 2>nul | findstr /C:"Microsoft.WindowsDesktop.App 8." >nul 2>&1
if %errorlevel% equ 0 (
    echo  [OK] .NET 8 Desktop Runtime is already installed.
    goto :install
)

echo  [!] .NET 8 Desktop Runtime not found.
echo  [*] Downloading installer from Microsoft...
echo.

:: Download .NET 8 Desktop Runtime installer
powershell -Command "& { $url = 'https://download.visualstudio.microsoft.com/download/pr/6f6d8dc4-16ad-4cf3-8484-f3e2c6af2b5e/b2c21a3f68e5e24c0a5e3cbed3dd1d76/windowsdesktop-runtime-8.0.13-win-x64.exe'; $out = '%TEMP%\dotnet8-desktop-runtime.exe'; Write-Host '  Downloading...'; Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing; Write-Host '  Download complete.' }"

if not exist "%TEMP%\dotnet8-desktop-runtime.exe" (
    echo.
    echo  [ERROR] Download failed. Please install .NET 8 Desktop Runtime manually:
    echo  https://dotnet.microsoft.com/en-us/download/dotnet/8.0
    echo.
    pause
    exit /b 1
)

echo  [*] Installing .NET 8 Desktop Runtime silently...
"%TEMP%\dotnet8-desktop-runtime.exe" /install /quiet /norestart
echo  [OK] .NET 8 Desktop Runtime installed.
del /f /q "%TEMP%\dotnet8-desktop-runtime.exe" >nul 2>&1

:install
echo.
echo  [*] Installing Yeet Injector...

:: Create install folder
set INSTALLDIR=%LOCALAPPDATA%\YeetInjector
if not exist "%INSTALLDIR%" mkdir "%INSTALLDIR%"

:: Copy exe
copy /Y "%~dp0YeetInjector.exe" "%INSTALLDIR%\YeetInjector.exe" >nul
echo  [OK] Copied to: %INSTALLDIR%\YeetInjector.exe

:: Create Desktop shortcut
echo  [*] Creating Desktop shortcut...
powershell -Command "& { $ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\Yeet Injector.lnk'); $s.TargetPath = '%INSTALLDIR%\YeetInjector.exe'; $s.Description = 'Yeet Injector - DLL Injector'; $s.WorkingDirectory = '%INSTALLDIR%'; $s.Save() }"
echo  [OK] Desktop shortcut created: "Yeet Injector.lnk"

:: Create Start Menu shortcut
echo  [*] Creating Start Menu shortcut...
set STARTMENU=%APPDATA%\Microsoft\Windows\Start Menu\Programs
powershell -Command "& { $ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%STARTMENU%\Yeet Injector.lnk'); $s.TargetPath = '%INSTALLDIR%\YeetInjector.exe'; $s.Description = 'Yeet Injector - DLL Injector'; $s.WorkingDirectory = '%INSTALLDIR%'; $s.Save() }"
echo  [OK] Start Menu shortcut created.

echo.
echo  ============================================
echo    Setup complete!
echo  ============================================
echo.
echo    Yeet Injector has been installed to:
echo    %INSTALLDIR%
echo.
echo    A shortcut was added to your Desktop.
echo    Always run it as Administrator.
echo.

set /p LAUNCH=  Launch Yeet Injector now? (Y/N): 
if /i "%LAUNCH%"=="Y" (
    start "" "%INSTALLDIR%\YeetInjector.exe"
)

echo.
pause
