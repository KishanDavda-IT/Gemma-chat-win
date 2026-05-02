@echo off
cd /d "%~dp0"
setlocal EnableDelayedExpansion

echo ===============================================
echo   Gemma Chat - Windows Auto-Setup
echo ===============================================
echo.

echo [STEP 1/4] Checking Node.js...
where.exe node >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Node.js 20+ was not found.
    echo         Install it from https://nodejs.org/en/download/
    pause
    exit /b 1
)
node --version

echo.
echo [STEP 2/4] Checking Ollama...
set "OLLAMA_CMD="
where.exe ollama >nul 2>nul
if not errorlevel 1 set "OLLAMA_CMD=ollama"

if not defined OLLAMA_CMD (
    if exist "%LOCALAPPDATA%\Programs\Ollama\ollama.exe" (
        set "OLLAMA_CMD=%LOCALAPPDATA%\Programs\Ollama\ollama.exe"
    )
)

if not defined OLLAMA_CMD (
    if exist "%ProgramFiles%\Ollama\ollama.exe" (
        set "OLLAMA_CMD=%ProgramFiles%\Ollama\ollama.exe"
    )
)

if not defined OLLAMA_CMD (
    echo [ERROR] Ollama was not found. Gemma Chat uses Ollama as its Windows local model runtime.
    echo         Install it from https://ollama.com/download/windows
    pause
    exit /b 1
)

"%OLLAMA_CMD%" --version

powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-RestMethod -Uri 'http://127.0.0.1:11434/api/version' -TimeoutSec 2 ^| Out-Null; exit 0 } catch { exit 1 }"
if errorlevel 1 (
    echo [INFO] Starting Ollama server...
    start "Ollama" /min "%OLLAMA_CMD%" serve

    for /L %%I in (1,1,30) do (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-RestMethod -Uri 'http://127.0.0.1:11434/api/version' -TimeoutSec 2 ^| Out-Null; exit 0 } catch { exit 1 }"
        if !errorlevel! equ 0 goto :ollama_ready
        timeout /t 1 >nul
    )

    echo [ERROR] Ollama did not start. Open Ollama manually, then run this script again.
    pause
    exit /b 1
)

:ollama_ready
echo [OK] Ollama is running.

echo.
echo [STEP 3/4] Installing Node dependencies...
call npm install
if errorlevel 1 (
    echo [ERROR] npm install failed. Check the output above.
    pause
    exit /b 1
)

echo.
echo [STEP 4/4] Starting Gemma Chat...
call npm run dev
if errorlevel 1 (
    echo [ERROR] Gemma Chat failed to start. Check the output above.
    pause
    exit /b 1
)

endlocal
