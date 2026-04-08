@echo off
REM GitHub Actions Setup Script
REM (c) 2026 Qorix
REM
REM This script helps you copy GitHub Actions workflow files to your repository

echo.
echo ========================================
echo   GitHub Actions Setup for PR Dashboard
echo ========================================
echo.

REM Check if repository path is provided
if "%~1"=="" (
    echo Usage: setup-github-actions.bat "C:\path\to\your\repository"
    echo.
    echo Example:
    echo   setup-github-actions.bat "C:\repos\myproject"
    echo.
    pause
    exit /b 1
)

set REPO_PATH=%~1
set SOURCE_PATH=%~dp0.github\workflows

echo Target repository: %REPO_PATH%
echo Source path: %SOURCE_PATH%
echo.

REM Check if repository path exists
if not exist "%REPO_PATH%" (
    echo Error: Repository path does not exist!
    echo Path: %REPO_PATH%
    pause
    exit /b 1
)

REM Create .github\workflows directory if it doesn't exist
if not exist "%REPO_PATH%\.github\workflows" (
    echo Creating .github\workflows directory...
    mkdir "%REPO_PATH%\.github\workflows"
)

REM Copy workflow files
echo.
echo Copying workflow files...
echo.

if exist "%SOURCE_PATH%\collect-pr-data.yml" (
    echo [1/3] Copying collect-pr-data.yml...
    copy "%SOURCE_PATH%\collect-pr-data.yml" "%REPO_PATH%\.github\workflows\" >nul
    if %ERRORLEVEL% EQU 0 (
        echo       ✓ Success
    ) else (
        echo       ✗ Failed
    )
) else (
    echo [1/3] ✗ collect-pr-data.yml not found
)

if exist "%SOURCE_PATH%\sync-all-prs.yml" (
    echo [2/3] Copying sync-all-prs.yml...
    copy "%SOURCE_PATH%\sync-all-prs.yml" "%REPO_PATH%\.github\workflows\" >nul
    if %ERRORLEVEL% EQU 0 (
        echo       ✓ Success
    ) else (
        echo       ✗ Failed
    )
) else (
    echo [2/3] ✗ sync-all-prs.yml not found
)

if exist "%~dp0.github-workflows-pr-quality-check.yml" (
    echo [3/3] Copying pr-quality-check.yml...
    copy "%~dp0.github-workflows-pr-quality-check.yml" "%REPO_PATH%\.github\workflows\pr-quality-check.yml" >nul
    if %ERRORLEVEL% EQU 0 (
        echo       ✓ Success
    ) else (
        echo       ✗ Failed
    )
) else (
    echo [3/3] ✗ pr-quality-check.yml not found
)

echo.
echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo Next steps:
echo   1. Navigate to your repository:
echo      cd "%REPO_PATH%"
echo.
echo   2. Commit and push the workflow files:
echo      git add .github\workflows\
echo      git commit -m "Add PR Report Card automation"
echo      git push origin main
echo.
echo   3. Verify in GitHub:
echo      - Go to your repository on GitHub
echo      - Click the "Actions" tab
echo      - You should see 3 new workflows
echo.
echo   4. Test it:
echo      - Create a new PR
echo      - Check Actions tab for workflow runs
echo      - Download the artifact and import to dashboard
echo.
echo For detailed instructions, see:
echo   %~dp0GITHUB-ACTIONS-SETUP.md
echo.
pause
