@echo off
rem Windows variant of setup-entropy-data-ce.sh - works in cmd and PowerShell.
rem The actual logic lives in setup-entropy-data-ce.ps1 (cmd has no cookie/regex support).
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup-entropy-data-ce.ps1"
