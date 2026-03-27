@echo off
:: Claude Code Security Agents — Installer (Windows)
:: 1. Copies agent definitions to %USERPROFILE%\.claude\agents\
:: 2. Installs the skill reference files via npx skills

setlocal

set "AGENTS_DIR=%USERPROFILE%\.claude\agents"
set "SOURCE_DIR=%~dp0agents"

echo.
echo Claude Code Security Agents Installer
echo ======================================

:: Check that agents/ folder exists
if not exist "%SOURCE_DIR%" (
    echo Error: agents\ folder not found. Make sure you're running this from the repo root.
    exit /b 1
)

:: ── Step 1: Install agents ──────────────────────────────────────────────────
if not exist "%AGENTS_DIR%" mkdir "%AGENTS_DIR%"

echo.
echo Step 1/2 -- Installing agents to %AGENTS_DIR% ...
echo.

for %%f in ("%SOURCE_DIR%\*.md") do (
    copy /Y "%%f" "%AGENTS_DIR%\%%~nxf" >nul
    echo   OK %%~nxf
)

:: ── Step 2: Install skills ──────────────────────────────────────────────────
echo.
echo Step 2/2 -- Installing skill reference files (requires Node.js) ...
echo.

where npx >nul 2>&1
if errorlevel 1 (
    echo   ! Node.js / npx not found. Skipping skill installation.
    echo     Install Node.js from https://nodejs.org and then run:
    echo     npx skills add PabloOchoa-maker/claude-security-skills@code-security -g
    echo     npx skills add PabloOchoa-maker/claude-security-skills@secrets-management -g
    echo     npx skills add PabloOchoa-maker/claude-security-skills@dependency-management-deps-audit -g
) else (
    call npx skills add PabloOchoa-maker/claude-security-skills@code-security -g -y
    echo   OK code-security skill
    call npx skills add PabloOchoa-maker/claude-security-skills@secrets-management -g -y
    echo   OK secrets-management skill
    call npx skills add PabloOchoa-maker/claude-security-skills@dependency-management-deps-audit -g -y
    echo   OK dependency-management-deps-audit skill
)

:: ── Done ────────────────────────────────────────────────────────────────────
echo.
echo Done! Restart Claude Code to load the agents.
echo.
echo Agents installed:
echo   - code-security   -- scans source code for OWASP vulnerabilities
echo   - config-security -- detects hardcoded secrets and insecure configs
echo   - deps-security   -- audits dependencies for CVEs
echo   - api-security    -- reviews API endpoints for auth and input issues
echo.

endlocal
pause
