@Rem [ Author: [ Бурлачков Василий Александрович) ] ]
@echo off
@rem setlocal enableextensions enabledelayedexpansion
setlocal EnableExtensions
setlocal EnableDelayedExpansion
@chcp 65001>nul
@Title "Create Named Folder"
@rem chcp 1251 >nul
@rem chcp 1252 >nul
@rem chcp 866 >nul
@Rem []
@set Title="Create Named Folder"
@set 7zaKeyString=-ssw -m0=LZMA2:d128m:fb256 -myx9 -mmt=8 -ms=off
@set 7zaKeyString2=-ssw -mmt=8 -ms=off
@set 7zaKeyString3=-ssw -mmt=8
@set 7zaKeyString4=-ssw -mmt=8 -mx9 -ms=off
@cd /D %~dp0
@rem @echo dp0 - %~dp0
@rem @pause
@cd /D ..\
@rem @echo cd - %cd%
@set ScriptsRootPath=%cd%
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	@set 7za=%ScriptsRootPath%\7za\x64\7za.exe
) else (
	@set 7za=%ScriptsRootPath%\7za\7za.exe
)
@set ConfigDir=%~dp0\config
@set IconConfigDir=%~dp0\config\_IconFolderConfigs

@rem Time
@set digit1=%time:~0,1%
@if "%digit1%"==" " (@set digit1=0)
@set BackUpTimeStamp01=!DATE:~-4!.!DATE:~3,2!.!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!
@set BackUpTimeStamp02=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set TimeStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!__!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@set DateStamp=!DATE:~-4!_!DATE:~3,2!_!DATE:~0,2!
@set OnlyTimeStamp=!digit1!!TIME:~1,1!_!TIME:~3,2!_!TIME:~6,2!
@Rem ini
@Rem
@rem @set Letters=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
@set FileType1Ext=ini
@set FileType2Ext=conf_ini
@set FileType3Ext=txt
@set FileType4Ext=tmp
@set TempFolderConfigBeginName=desktop.conf_ini
@set TempFolderName=FolderName.tmp
@set TempFolderIcon=FolderIcon.tmp
@set TempFolderViewState=FolderViewState.tmp
@set TempFolderType=FolderType.tmp
@set FolderConfig=desktop
@set Config=%~dp0\_Temp\desktop.conf_ini
@rem 
@set FolderP=
@set FolderName=
@set FinalFolderName=
@rem 
@cd /D %~dp0\_Temp\
@rem echo Dir 0 - "%~dp0\_Temp\"
@rem echo Dir 1 - "%~dp1\_Temp\"
@rem echo Config - "%Config%"
@rem 
@rem '
@rem "

@rem ChoiceSpecNameOrnot =================================================================================
@title [Choice Spec Name or not]
:ChoiceSpecName
@rem 
@Echo  " Создать папку с обычным именем?"
@Echo.
Echo  [] 1 - Да
Echo  [] 2 - Нет
@Set /p ChoiceSpecName=""
@rem if not defined ChoiceSpecName goto :ChoiceEmpty
@rem if "%ChoiceSpecName%"=="1" ( @rem @set "SpecSufix=" )
@rem @Set /p ChoiceSpecSufix=""
@rem if not defined ChoiceSpecSufix goto :ChoiceEmpty
@rem if "%ChoiceSpecSufix%"=="" ( @goto :ChoiceEmpty )
@Echo.
@goto :ChoiceName

@rem ChoiceName =================================================================================

:ChoiceName
@rem @echo %1
@rem @echo %~dpn1
@Echo  Имя папки:
@Echo.
@rem SET /A Математическое выражение
@rem SET /P variable=[promptString]
@rem Get-Random -Minimum 1 -Maximum 10
@Set /p choice=" : "
if not defined choice goto :ChoiceEmpty
if "%choice%"=="" ( @goto :ChoiceEmpty )
@Echo.
@rem 
@rem 1=Да (Папка с обычным именем) 2=Нет
if not defined ChoiceSpecName ( goto :ClearConfig )
if "%ChoiceSpecName%"=="1" ( @goto :ClearConfig )
if "%ChoiceSpecName%"=="2" ( @goto :ChoiceName2 )

@rem Choice 2 Name =================================================================================

:ChoiceName2
@Echo  " Добавить к имени папки - (Do not delete this folder) ?"
@Echo.
Echo  [] 1 - Да
Echo  [] 2 - Нет
@Set /p Choice2Name=" : "
if "%Choice2Name%"=="1" ( 
	@set "Sufix= Не удалять (Do not delete this folder)"
)
@Echo.
@goto :ChoiceName3

@rem Choice 3 Name =================================================================================

:ChoiceName3
@Echo  " Добавить к имени папки тип содержимого?"
@Echo.
Echo  [] 1 - Да
Echo  [] 2 - Нет
@Set /p Choice3Name=" : "
@Echo.
@goto :ChoiceName4

@rem Choice 4 Name =================================================================================

:ChoiceName4
@Echo  " Добавить к имени папки рандом?"
@Echo.
Echo  [] 1 - Да
Echo  [] 2 - Нет
@Set /p Choice4Name=" : "
@rem 
@Echo.
if not defined Choice4Name ( goto :ClearConfig )
if "%Choice4Name%"=="1" ( @goto :SetRandomInt )
if "%Choice4Name%"=="2" ( @goto :ClearConfig )

@rem ChoiceIconOfFolder =================================================================================
:ChoiceIconOfFolder
@Echo  Иконка папки:
Echo.
Echo  [] 1 - Обычная папка
Echo  [] 2 - Документы
Echo  [] 3 - Изображения
Echo  [] 4 - Музыка
Echo  [] 5 - Видео
Echo  [] 6 - Загрузки
Echo  [] 7 - Ссылки
Echo  [] 8 - Избранное
Echo  [] 9 - Архив
Echo  [] 10 - BackUps
Echo  [] 11 - Драйвера
Echo  [] 12 - Телефон
Echo  [] 13 - Program Files
Echo  [] 14 - Пользователи
Echo  [] 15 - Категории
Echo  [] 16 - Файлы
Echo  [] 17 - MV
Echo  [] 18 - Поиск
Echo  [] 19 - VHD
Echo  [] 20 - Игры
Echo  [] 21 - Пароли
echo.
Set /p ChoiceFolderIcon=" : "
if not defined ChoiceFolderIcon ( 
	powershell -Command "Get-Content -Path %ConfigDir%\FolderIconConfig.%FileType3Ext% | Add-Content -Path %TempFolderIcon%"
	goto :ChoiceTypeOfFolder
)
@rem if "%ChoiceFolderIcon%"=="" ( @goto :ChoiceTypeOfFolder )
@rem 
if "%ChoiceFolderIcon%"=="1" ( 
	powershell -Command "Get-Content -Path %ConfigDir%\FolderIconConfig.%FileType3Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="2" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderDocs.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="3" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderPictures.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="4" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderMusic.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="5" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderVideo.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="6" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderDownloads.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="7" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderLinks.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="8" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderFavorites.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="9" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderHardDisk.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="10" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderBackUps.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="11" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderDrivers.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="12" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderTelephon.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="13" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderPrograms.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="14" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderUsers.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="15" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderCategory.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="16" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderFiles.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="17" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderMV.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="18" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderSearches2.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="19" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderVHD.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="20" ( 
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderGames.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
)
if "%ChoiceFolderIcon%"=="21" ( 
	@set "FolderP=%ChoiceFolderIcon%"
	powershell -Command "Get-Content -Path %IconConfigDir%\IconFolderP.%FileType1Ext% | Add-Content -Path %TempFolderIcon%"
	@goto :SetRandomInt
)
Echo.
@rem 
@goto :ChoiceTypeOfFolder

@rem ChoiceTypeOfFolder =================================================================================

:ChoiceTypeOfFolder
@Echo  Тип папки:
Echo.
Echo  [] 1 - Общее
Echo  [] 2 - Документы
Echo  [] 3 - Изображения
Echo  [] 4 - Музыка
Echo  [] 5 - Видео
Echo  [] 6 - Музыка и Видео
echo.
Set /p ChoiceFolderType=" : "
if not defined ChoiceFolderType (
	@echo FolderType=Generic>%TempFolderType%
	powershell -Command "Get-Content -Path %ConfigDir%\FolderTypeConfig.txt | Add-Content -Path %TempFolderViewState%"
	powershell -Command "Get-Content -Path %TempFolderType% | Add-Content -Path %TempFolderViewState%"
	@goto :ChangeFolderName
)
@rem if "%ChoiceFolderType%"=="" ( @goto :ChangeFolderName )
@rem 
if "%ChoiceFolderType%"=="1" ( 
	@echo FolderType=Generic>%TempFolderType%
	powershell -Command "Get-Content -Path %ConfigDir%\FolderTypeConfig.txt | Add-Content -Path %TempFolderViewState%"
	powershell -Command "Get-Content -Path %TempFolderType% | Add-Content -Path %TempFolderViewState%"
)
if "%ChoiceFolderType%"=="2" ( 
	@echo FolderType=Documents>%TempFolderType%
	powershell -Command "Get-Content -Path %ConfigDir%\FolderTypeConfig.txt | Add-Content -Path %TempFolderViewState%"
	powershell -Command "Get-Content -Path %TempFolderType% | Add-Content -Path %TempFolderViewState%"
)
if "%ChoiceFolderType%"=="3" ( 
	@echo FolderType=Pictures>%TempFolderType%
	powershell -Command "Get-Content -Path %ConfigDir%\FolderTypeConfig.txt | Add-Content -Path %TempFolderViewState%"
	powershell -Command "Get-Content -Path %TempFolderType% | Add-Content -Path %TempFolderViewState%"
	if "%Choice3Name%"=="1" ( 
		@set "Sufix02=%Sufix% (Изображения)"
	)
)
if "%ChoiceFolderType%"=="4" ( 
	@echo FolderType=Music>%TempFolderType%
	powershell -Command "Get-Content -Path %ConfigDir%\FolderTypeConfig.txt | Add-Content -Path %TempFolderViewState%"
	powershell -Command "Get-Content -Path %TempFolderType% | Add-Content -Path %TempFolderViewState%"
	if "%Choice3Name%"=="1" ( 
		@set "Sufix02=%Sufix% (Музыка)"
	)
)
if "%ChoiceFolderType%"=="5" ( 
	@echo FolderType=Videos>%TempFolderType%
	powershell -Command "Get-Content -Path %ConfigDir%\FolderTypeConfig.txt | Add-Content -Path %TempFolderViewState%"
	powershell -Command "Get-Content -Path %TempFolderType% | Add-Content -Path %TempFolderViewState%"
	if "%Choice3Name%"=="1" ( 
		@set "Sufix02=%Sufix% (Видео)"
	)
)
if "%ChoiceFolderType%"=="6" ( 
	@echo FolderType=Generic>%TempFolderType%
	powershell -Command "Get-Content -Path %ConfigDir%\FolderTypeConfig.txt | Add-Content -Path %TempFolderViewState%"
	powershell -Command "Get-Content -Path %TempFolderType% | Add-Content -Path %TempFolderViewState%"
	if "%Choice3Name%"=="1" ( 
		@set "Sufix02=%Sufix% (Музыка и Видео)"
	)
)
Echo.
@rem 
@goto :ChangeFolderName

@rem ChoiceEmptyOther =================================================================================

:ChoiceEmptyOther
@goto :ClearConfig

:ChoiceEmpty
@goto :Exit2

@rem ClearConfig =================================================================================

:ClearConfig
@Rem Clear Config (delete temp files)
@rem 
@del /f /q %FolderConfig%.%FileType4Ext%
@rem @del /f /q %Config%
@del /f /q %TempFolderName%
@del /f /q %TempFolderIcon%
@del /f /q %TempFolderViewState%
@del /f /q %TempFolderType%
@timeout /t 1 >nul
@rem === Create .tmp
@copy %ConfigDir%\%TempFolderConfigBeginName% %FolderConfig%.%FileType4Ext%
@copy %ConfigDir%\%TempFolderConfigBeginName% %TempFolderName%
@copy %ConfigDir%\%TempFolderConfigBeginName% %TempFolderIcon%
@copy %ConfigDir%\%TempFolderConfigBeginName% %TempFolderViewState%
@copy %ConfigDir%\%TempFolderConfigBeginName% %TempFolderType%
@timeout /t 1 >nul
@rem 
@goto :ChoiceIconOfFolder

@rem Set Random Int =================================================================================

:SetRandomInt
@set "RandomInt01=!DATE:~-4!!DATE:~3,2!!DATE:~0,2!!TIME:~1,1!!TIME:~3,2!!TIME:~6,2!"
@set "RandomInt02=!DATE:~-4!!DATE:~3,2!!DATE:~0,2!!TIME:~1,1!!TIME:~3,2!"
@set "RandomInt03=!DATE:~-4!!DATE:~3,2!!DATE:~0,2!"
@set "RandomInt04=!DATE:~-4!!TIME:~1,1!!TIME:~3,2!!TIME:~6,2!"
@set "RandomInt05=!TIME:~1,1!!DATE:~-4!!TIME:~3,2!!TIME:~6,2!"
@rem 
@if defined Choice2Name ( @set "Int02=%Choice2Name%" )
@if defined Choice3Name ( @set "Int03=%Choice3Name%" )
@if defined Choice4Name ( @set "Int04=%Choice4Name%" )
@if defined ChoiceFolderIcon ( @set "Int05=%ChoiceFolderIcon%" )
@if defined ChoiceFolderType ( @set "Int06=%ChoiceFolderType%" )
@rem 
@if not defined Choice2Name ( @set "Int02=1" )
@if not defined Choice3Name ( @set "Int03=1" )
@if not defined Choice4Name ( @set "Int04=1" )
@if not defined ChoiceFolderIcon ( @set "Int05=1" )
@if not defined ChoiceFolderType ( @set "Int06=1" )
@rem 
@set "Int01=2*%Int02%+%Int03%+%Int04%+%Int05%+%Int06%*%RANDOM%"
@rem @Echo [Int02] = %Int02% _ [Int03] = %Int03% _ [Int04] = %Int04% _ [ChoiceFolderIcon] = %Int05% _ [ChoiceFolderType] = %Int06%
@set "Int=%DATE:~-4%*%RANDOM%"
@set /a Int=%Int%+%Int01%*%Int01%
@set /a RandomInt=%RandomInt03%+%Int%*%Int01%+%Int01%*%Int01%
@if %~z1 GEQ 0 ( @set /a RandomInt=%RandomInt%+%RandomInt03%+%Int%*%~z1 )
@rem 
@set /a RandomInt=%RandomInt%+%Int%
@rem @echo Int = %Int%
@rem %RANDOM% — Принимает значение случайного десятичного числа
@set "RandomInt=%RandomInt04%%RandomInt%%RandomInt05%%RANDOM%"
@rem @echo Random Int = %RandomInt%
@rem @Set "IntRandom=powershell -Command Get-Random -Minimum 1 -Maximum 10"
@rem @echo %IntRandom%
@rem 
if "%ChoiceFolderIcon%"=="21" ( 
	@goto :ChoiceTypeOfFolder
)
@rem 
@goto :ClearConfig

@rem ChangeFolderName =================================================================================

:ChangeFolderName
@Rem SufixRandomInt01 (Только если выбрана иконка папки для паролей )
@set "FolderName=%choice%%Sufix02%"
if "%Choice4Name%"=="1" ( @set "SufixRandomInt02= %RandomInt%" )
@rem @echo [] FolderP = %FolderP%
@rem @echo [] ChoiceFolderIcon = %ChoiceFolderIcon%
if not "%FolderP%"=="" (
	if "%ChoiceFolderIcon%"=="%FolderP%" (
		@set "SufixRandomInt02= %RandomInt%"
		@set "SufixRandomInt01=%RandomInt%_"
	)
)
@rem @echo [] SufixRandomInt02 = %SufixRandomInt02% __ SufixRandomInt01 = %SufixRandomInt01%
@rem 1=Да (Папка с обычным именем) 2=Нет
if not defined ChoiceSpecName (
	@set "SpecSufix="
	@set "SpecName="
)
if "%ChoiceSpecName%"=="1" (
	@set "SpecSufix="
	@set "SpecName="
)
if "%ChoiceSpecName%"=="2" (
	@set "SpecSufix=_"
	@set "SpecName=[]"
)
@set "FinalFolderName=%SpecSufix%%SufixRandomInt01%%choice%%Sufix%%SufixRandomInt02%"
@rem ================================================================================
@Echo [] ============================================================================
@Echo [] choice - %choice%
@Echo [] Sufix - %Sufix%
@Echo [] Sufix02 - %Sufix02%
@Echo [] FolderName - %FolderName%
@Echo [] ============================================================================
@Echo [] SpecSufix - %SpecSufix%
@Echo [] SufixRandomInt01 (Только если выбрана иконка папки для паролей ) - %SufixRandomInt01%
@Echo [] SufixRandomInt02 - %SufixRandomInt02%
@Echo [] FinalFolderName - %FinalFolderName%
@Echo [] ============================================================================
@rem ================================================================================
@rem @pause
@rem 
@rem _%BackUpTimeStamp02%
@goto :BuildTempConfigFile

@rem BuildTempConfigFile =================================================================================
@title [Build Temp Config File]
:BuildTempConfigFile
@rem 
@rem Build config file
powershell -Command "Get-Content -Path %ConfigDir%\FolderConfigBegin.txt | Add-Content -Path %FolderConfig%.%FileType4Ext%"
@rem 
@chcp 1251 >nul
@rem 
echo LocalizedResourceName=%SpecName% %FolderName%>"%TempFolderName%"
@chcp 65001>nul
powershell -Command "Get-Content -Path "%TempFolderName%" | Add-Content -Path %FolderConfig%.%FileType4Ext%"
powershell -Command "Get-Content -Path "%TempFolderIcon%" | Add-Content -Path %FolderConfig%.%FileType4Ext%"
powershell -Command "Get-Content -Path "%TempFolderViewState%" | Add-Content -Path %FolderConfig%.%FileType4Ext%"
@rem 
@goto :CreateNamedFolder

:CreateNamedFolder
@rem @pause
@MKDIR "%~dpn1\%FinalFolderName%"
@copy %FolderConfig%.%FileType4Ext% "%~dpn1\%FinalFolderName%\%FolderConfig%.%FileType1Ext%"
ATTRIB +S +H "%~dpn1\%FinalFolderName%\%FolderConfig%.%FileType1Ext%"
@rem MOVE /Y %~dpn1\%FinalFolderName% %~dp1\%FinalFolderName%
@rem @echo %~dp1

:EOF
@rem @pause
@Rem Clear Config (delete temp files)
@timeout /t 1 >nul
@rem @del /f /q %Config%
@del /f /q %FolderConfig%.%FileType4Ext%
@del /f /q %TempFolderName%
@del /f /q %TempFolderIcon%
@del /f /q %TempFolderViewState%
@del /f /q %TempFolderType%

:Exit
@rem pause

