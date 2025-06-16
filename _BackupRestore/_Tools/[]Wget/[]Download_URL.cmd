@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@Title "Download file from URL"
@set Title="Download file from URL"
@cd /D %~dp0
@cd /D ..\..\
@rem @echo cd - %cd%
@rem [============][============][============]
@set ScriptsRootPath=%cd%
@set LogsDir=%ScriptsRootPath%\__Logs
@set ListDir=%ScriptsRootPath%\__Lists
@set TempDir1=%ScriptsRootPath%\_Temp
@set UtilsDir=%ScriptsRootPath%\_Utils
@set WgetDir=%ScriptsRootPath%\_Tools\[]Wget
@set DownloadsDir=%userprofile%\Downloads
@set DownloadsDir2=C:\[]TempDownloads
@set UserAgent="Mozilla/5.0 (Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36"
@rem [============][============][============]
@echo ScriptsRootPath - %ScriptsRootPath%
@rem @cd /D %~dp0
@rem @echo cd - %cd%
@rem [============][============][============]
for /f "usebackq delims=" %%I in (`@cscript //Nologo %UtilsDir%\[]TextinputFileName.wsf`) do set "InputFileName=%%I"
@rem @echo Input - %Input%
if /i "%InputFileName%"=="" (
	@goto :EOF
)
for /f "usebackq delims=" %%I in (`@cscript //Nologo %UtilsDir%\[]TextinputURL.wsf`) do set "Input=%%I"
@rem @echo Input - %Input%
if /i "%Input%"=="" (
	@goto :EOF
)
@rem C:\_BackupRestore\_Tools\[]Wget\wget.exe -t 0 --retry-connrefused -c -x --no-check-certificate -O C:\Games\12345\12345.mkv --user-agent="Mozilla/5.0 (Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36" "https://vk6-15.vkuser.net/?srcIp=185.161.253.65&pr=40&expires=1748201712926&srcAg=CHROME&fromCache=1&ms=95.142.206.174&type=5&subId=5922730281662&sig=YkCgbeGyDwk&ct=0&urls=185.226.52.201%3B45.136.20.167&clientType=13&appId=512000384397&zs=43&id=7946279324210"

%WgetDir%\wget.exe -t 0 --retry-connrefused -c --no-check-certificate --auth-no-challenge --http-user Anonimous --user Anonimous -O "%DownloadsDir%\%InputFileName%" --user-agent="Mozilla/5.0 (Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36" "%Input%"

:EOF

@pause
	