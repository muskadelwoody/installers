ECHO OFF

REM Remove Agent

REM Installer Files
REM http://dcgeneral.blob.core.windows.net/cep/Clients/v10.3.0.31/DCProtect-10.3.0.31-CarboniteUSRed.msi
REM http://dcgeneral.blob.core.windows.net/cep/Clients/v10.3.0.31/DCProtect-10.3.0.31-CarboniteEMEA.msi

REM Variables
SET msipath=%USERPROFILE%\Desktop\

SET installer=DCProtect-10.3.0.31-CarboniteEMEA.msi
SET vault=https://kamino.mysecuredatavault.com
SET activationtoken1=0966-140B-612B-85E2-1B78
SET activationtoken2=CD3B-61BE-5556-027F-3416


"%msipath%%installer%"

C:\Program Files (x86)\Carbonite\Endpoint

REM msiexec /x "\\bachelet.me\SYSVOL\bachelet.me\scripts\cep\DCProtect-10.3.0.31-Carbonite.msi" /q
