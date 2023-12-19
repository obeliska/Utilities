@echo off
@setlocal
@prompt $s

::
:: Shows or hides seconds in the Windows system clock in the taskbar.
:: Note that having them shown may cause a slight power drain if running on
:: battery.
::
:: %1: 0 to hide, 1 to show.
::

set key=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
set val=ShowSecondsInSystemClock
set min=0
set max=1

set data=%1
if "%data%" == "" goto usage
for /l %%a in (%min%,1,%max%) do if %data% equ %%a goto ok
goto usage

:ok
for /f "tokens=1,3" %%a in ('reg query %key% /v %val% ^| findstr "%val%"') do set /a current=%%b
if "%current%" equ "%data%" goto already_set

@echo Setting %val% to %data%
reg add %key% /v %val% /t reg_dword /d %data% /f >nul
if %errorlevel% equ 0 (
   @echo Restarting Explorer
   taskkill /f /im explorer.exe >nul
   start explorer.exe
)
goto end

:already_set
@echo %val% already set to %data%
@goto end

:usage
@echo Usage: %~n0 0^|1
@goto end

:end
@call %utils%\pause_if_doubleclicked
