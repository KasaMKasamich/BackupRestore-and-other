c:
cls
@Echo off
color 0b

:change
cls
echo #################################################################
echo #  �롥�� ����⢨� ���஥ ���� �믮����� � ��몠�� :      #
echo #################################################################
rem echo ##################
echo # 1. ����� � �᪫�祭�� 䠩��� ������� ���७�� MS Office #
echo # 2. ������� ����ன�� ����७��� 䠩��� (default)              #
echo # 3. ���� ��� ��� ���ᥭ�� ���������                        #
echo ########################geekteam.pro#############################


set /p var="���⢥ত���� �롮�: "
if %var%==1 goto :makeit
if %var%==3 goto :noaction
if %var%==2 (
             goto :restorelink
            ) 
else (
        echo ��� ⠪��� �롮� ���, ������ ����:
                   )
pause


goto :change


:noaction
cls
@echo off
echo ��������� �� �஢�������...
pause
goto :end


:makeit
reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /f
reg add hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /t reg_dword /d 1
reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /f
reg add hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /t reg_sz /d .xlsx,.docx,.xls,.doc,.ppt,.pptx
cls
@echo off
echo � �᪫�祭�� ��������� ᫥���騥 䠩��: .xlsx, .docx, .xls, .doc, .ppt, .pptx
pause
goto :end

:restorelink
reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments /v SaveZoneInformation /f
reg delete hkcu\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v LowRiskFileTypes /f
cls
@echo off
echo �� 㤠���� ����ன�� �� ॥���...
pause
goto :end

color 0a

:end



