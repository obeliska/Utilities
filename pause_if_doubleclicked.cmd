:: Pauses if the calling script is being executed in a terminating command 
:: prompt window, i.e., run by double-clicking on it in Explorer.
@setlocal
@set _cmdline=%cmdcmdline:"=%
@set _cmdline=%_cmdline:&=%
@echo %_cmdline% | findstr /i /c:"cmd.exe /c" >nul
@if %errorlevel% equ 0 (echo. & pause)
