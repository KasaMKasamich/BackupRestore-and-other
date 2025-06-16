c:
cls
@Echo off
color 0b

:change
cls
echo #################################################################
echo #  Выберете действие которое хотить выполнить с ярлыками :      #
echo #################################################################
rem echo ##################
echo # 1. Внести в исключения файлов популярные расширения MS Office #
echo # 2. Удалить настройки доверенных файлов (default)              #
echo # 3. Просто выйти без внесения изменений                        #
echo ########################geekteam.pro#############################


set /p var="Подтверждение выбора: "
if %var%==1 goto :makeit
if %var%==3 goto :noaction
if %var%==2 (
             goto :restorelink
            ) 
else (
        echo Увы такого выбора нет, повторите ввод:
                   )
pause


goto :change


:noaction
cls
@echo off
echo Изменения не проводились...
pause
goto :end


:makeit
reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /f
reg add hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /t reg_dword /d 1
reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /f
reg add hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /t reg_sz /d .xlsx,.docx,.xls,.doc,.ppt,.pptx
cls
@echo off
echo В исключения добавлены следующие файлы: .xlsx, .docx, .xls, .doc, .ppt, .pptx
pause
goto :end

:restorelink
reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /f
reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /f
cls
@echo off
echo Вы удалили настройки из реестра...
pause
goto :end

color 0a

:end



