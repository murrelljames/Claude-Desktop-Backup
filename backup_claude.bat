@echo off
setlocal enabledelayedexpansion

:: Claude Desktop Backup Script
:: Backs up all Claude Desktop settings and configurations
echo ========================================
echo    Claude Desktop Backup Script
echo ========================================
echo.

:: Get current date and time for backup folder name
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

:: Set paths
set "CLAUDE_SOURCE=%APPDATA%\Claude"
set "BACKUP_BASE=C:\Backups\Claude"
set "BACKUP_FOLDER=%BACKUP_BASE%\Claude_Backup_%datestamp%"

:: Create backup directory
echo Creating backup directory...
if not exist "%BACKUP_BASE%" mkdir "%BACKUP_BASE%"
mkdir "%BACKUP_FOLDER%"

:: Check if Claude folder exists
if not exist "%CLAUDE_SOURCE%" (
    echo ERROR: Claude folder not found at %CLAUDE_SOURCE%
    echo Make sure Claude Desktop is installed.
    pause
    exit /b 1
)

echo.
echo Source: %CLAUDE_SOURCE%
echo Backup: %BACKUP_FOLDER%
echo.

:: Copy Claude folder contents
echo Copying Claude Desktop settings...
echo.

:: Copy main config files
echo Copying configuration files...
copy "%CLAUDE_SOURCE%\claude_desktop_config.json" "%BACKUP_FOLDER%\" >nul 2>&1
copy "%CLAUDE_SOURCE%\config.json" "%BACKUP_FOLDER%\" >nul 2>&1
copy "%CLAUDE_SOURCE%\window-state.json" "%BACKUP_FOLDER%\" >nul 2>&1
copy "%CLAUDE_SOURCE%\Preferences" "%BACKUP_FOLDER%\" >nul 2>&1
copy "%CLAUDE_SOURCE%\Local State" "%BACKUP_FOLDER%\" >nul 2>&1

:: Copy custom dictionary if it exists
if exist "%CLAUDE_SOURCE%\Custom Dictionary.txt" (
    echo Copying custom dictionary...
    copy "%CLAUDE_SOURCE%\Custom Dictionary.txt" "%BACKUP_FOLDER%\" >nul 2>&1
)

:: Copy extension settings
echo Copying extension settings...
if exist "%CLAUDE_SOURCE%\Claude Extensions Settings" (
    xcopy "%CLAUDE_SOURCE%\Claude Extensions Settings" "%BACKUP_FOLDER%\Claude Extensions Settings" /E /I /H >nul 2>&1
)

:: Copy extensions data
echo Copying extensions data...
if exist "%CLAUDE_SOURCE%\Claude Extensions" (
    xcopy "%CLAUDE_SOURCE%\Claude Extensions" "%BACKUP_FOLDER%\Claude Extensions" /E /I /H >nul 2>&1
)

:: Copy logs (recent only)
echo Copying recent logs...
if exist "%CLAUDE_SOURCE%\logs" (
    xcopy "%CLAUDE_SOURCE%\logs" "%BACKUP_FOLDER%\logs" /E /I /H >nul 2>&1
)

:: Create backup info file
echo Creating backup information file...
echo Claude Desktop Backup Information > "%BACKUP_FOLDER%\backup_info.txt"
echo ================================== >> "%BACKUP_FOLDER%\backup_info.txt"
echo. >> "%BACKUP_FOLDER%\backup_info.txt"
echo Backup Date: %date% %time% >> "%BACKUP_FOLDER%\backup_info.txt"
echo Source Location: %CLAUDE_SOURCE% >> "%BACKUP_FOLDER%\backup_info.txt"
echo Backup Location: %BACKUP_FOLDER% >> "%BACKUP_FOLDER%\backup_info.txt"
echo. >> "%BACKUP_FOLDER%\backup_info.txt"
echo Contents: >> "%BACKUP_FOLDER%\backup_info.txt"
echo - claude_desktop_config.json (MCP server configurations) >> "%BACKUP_FOLDER%\backup_info.txt"
echo - config.json (app preferences) >> "%BACKUP_FOLDER%\backup_info.txt"
echo - window-state.json (window positioning) >> "%BACKUP_FOLDER%\backup_info.txt"
echo - Preferences (user preferences) >> "%BACKUP_FOLDER%\backup_info.txt"
echo - Claude Extensions Settings (extension configurations) >> "%BACKUP_FOLDER%\backup_info.txt"
echo - Claude Extensions (extension data) >> "%BACKUP_FOLDER%\backup_info.txt"
echo - Custom Dictionary.txt (if exists) >> "%BACKUP_FOLDER%\backup_info.txt"
echo - logs (recent application logs) >> "%BACKUP_FOLDER%\backup_info.txt"

:: Optional: Create ZIP file
set /p "createzip=Create ZIP file? (y/n): "
if /i "!createzip!"=="y" (
    echo.
    echo Creating ZIP file...
    powershell -command "Compress-Archive -Path '%BACKUP_FOLDER%' -DestinationPath '%BACKUP_BASE%\Claude_Backup_%datestamp%.zip' -Force"
    if exist "%BACKUP_BASE%\Claude_Backup_%datestamp%.zip" (
        echo ZIP file created: %BACKUP_BASE%\Claude_Backup_%datestamp%.zip
        set /p "deletefolder=Delete backup folder and keep only ZIP? (y/n): "
        if /i "!deletefolder!"=="y" (
            rmdir /s /q "%BACKUP_FOLDER%"
            echo Backup folder deleted, ZIP file retained.
        )
    )
)

echo.
echo ========================================
echo         Backup Complete!
echo ========================================
echo.
echo Your Claude Desktop settings have been backed up to:
if exist "%BACKUP_BASE%\Claude_Backup_%datestamp%.zip" (
    echo %BACKUP_BASE%\Claude_Backup_%datestamp%.zip
) else (
    echo %BACKUP_FOLDER%
)
echo.
echo To restore: Copy files back to %CLAUDE_SOURCE%
echo (Make sure Claude Desktop is closed before restoring)
echo.
pause