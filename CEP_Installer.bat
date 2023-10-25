ECHO OFF


REM Remove Agent
REM msiexec /x "\\bachelet.me\SYSVOL\bachelet.me\scripts\cep\DCProtect-10.3.0.31-Carbonite.msi" /q


REM Installer Files
REM http://dcgeneral.blob.core.windows.net/cep/Clients/v10.3.0.31/DCProtect-10.3.0.31-CarboniteUSRed.msi
REM http://dcgeneral.blob.core.windows.net/cep/Clients/v10.3.0.31/DCProtect-10.3.0.31-CarboniteEMEA.msi

REM Variables
SET msipath=%USERPROFILE%\Desktop\
SET installer=DCProtect-10.3.0.31-CarboniteEMEA.msi
SET vault=https://kamino.mysecuredatavault.com
SET activationtoken1=0966-140B-612B-85E2-1B78
SET activationtoken2=CD3B-61BE-5556-027F-3416

curl http://dcgeneral.blob.core.windows.net/cep/Clients/v10.3.0.31/%installer% --output %msipath%%installer%

SET user=%USERNAME%@muskadel.com
SET displayname=%COMPUTERNAME%

CLS
REM Installation
ECHO Installation
ECHO ----------------------
ECHO.
ECHO Installing: 		%msipath%%installer%
ECHO Logging:    		%msipath%install.log
ECHO.
REM SET PATH=%PATH%;C:\WINDOWS\SYSTEM32
msiexec.exe /i "%msipath%%installer%" /qn /L*vx "%msipath%install.log" Silent=1 ActivationURL=%vault% ActivationCode=%activationtoken2% InstallDesktopShortCut=1 runserviceaslocalsystem=1 RUNACTIVATEPOSTINSTALL=0

if exist c:\DCProtectData\Service\Service.config.xml (
    rem Is Installed
    ECHO Agent is Installed...
) else (
    rem Is Not Installed
    ECHO Agent is Not Installed... exiting.
    EXIT
)

ECHO.
PAUSE >nul

REM Activation
ECHO Activation
ECHO ----------------------
ECHO.
ECHO Acivation URL: 	%vault%
ECHO Activation Token:  %activationtoken%
ECHO Matching User: 	%user%
ECHO Display Name:  	%displayname%
ECHO.
"c:\program files (x86)\carbonite\endpoint\dcprotect.exe" -autoactivation -email "%user%" -displayname "%displayname%"

if exist “c:\DCProtectData\Service\ServerStatus.xml” (
	rem Is Activated
	ECHO Agent is Activated...
) else (
    rem Is Not Activated
    ECHO Agent is Not Activated... exiting.
    EXIT
)

ECHO.
REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\DCProtect /v BuildInstalled
ECHO Done.
ECHO.