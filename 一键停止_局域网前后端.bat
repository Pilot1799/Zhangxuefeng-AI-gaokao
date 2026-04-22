@echo off
setlocal
powershell -NoLogo -NoExit -ExecutionPolicy Bypass -File "%~dp0_stop_lan_stack.ps1"
