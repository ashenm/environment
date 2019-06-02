@REM
@REM Setup Environment
@REM Configure Windows Environment
@REM https://github.com/ashenm/environment
@REM
@REM Ashen Gunaratne
@REM mail@ashenm.ml
@REM

@ECHO OFF

:: install alias shims
BITSADMIN /TRANSFER environment-aliases /DOWNLOAD ^
    https://raw.githubusercontent.com/ashenm/environment/releases/windows/aliases.cab %TEMP%\environment-aliases.cab >> NUL && (
  MKDIR %USERPROFILE%\.environment\aliases
  EXPAND -R %TEMP%\environment-aliases.cab %USERPROFILE%\.environment\aliases >> NULL
  DEL /F /Q %TEMP%\environment-aliases.cab
)

:: clinch user PATH
:: setx path modifies aggregated path and hence avoiding
FOR /F "tokens=3 skip=2" %%d IN ('REG QUERY HKCU\Environment /v Path') DO (
  REG ADD HKCU\Environment /f /v Path /t REG_EXPAND_SZ /d "%%USERPROFILE%%\.environment\aliases;%%d" >> NULL
)

:: customise command prompt
REG ADD HKCU\Environment /f /v PROMPT /d "$D$S$T$S$P$G"

:: propagate registry changes
MSG %USERNAME% /W You're about to be signed out! && ^
  LOGOFF %SESSIONNAME%
