::&cls&::   Made with ❤️ by Watashi o yūwaku suru   -- Эта строчка должна быть первой. Скрывает ошибку из-за метки BOM, если батник "UTF-8 c BOM"
@echo off
chcp 65001 >nul
cd /d "%~dp0"
set xOS=x64& (If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86)

:: Если этот батник запущен без прав администратора, то перезапуск этого батника с запросом прав администратора.
reg query "HKU\S-1-5-19\Environment" >nul 2>&1 & cls
if "%Errorlevel%" NEQ "0" PowerShell.exe -WindowStyle Hidden -NoProfile -NoLogo -Command "Start-Process -Verb RunAS -FilePath '%0'"&cls&exit

:: Используется PowerShell.

setlocal EnableDelayedExpansion

echo.
echo.---------------------------------------------------------------------------------------------------
echo.  ^> Установка всех зависимых пакетов .AppX из папки \Files ^(VCLibs, .NET.Native и др.^)
echo.
set isExist=
for /f "tokens=1* delims=" %%I in (' 2^>nul dir /b /a:-d "Files\*.Appx" ^| findstr /i "[.]VCLibs[.].*[.]Appx\> [.]NET[.].*[.]Appx\> [.]Xaml_.*[.]Appx\> [.]WinJS[.].*[.]Appx\>" ') do (
   set isExist=1
   Call :InstallDependences "%%I"
)

if not defined isExist ( echo.&echo.    Нет файлов VCLib.AppX или .NET.Native.AppX ^^^!^^^!^^^!&echo. )


echo.
echo.---------------------------------------------------------------------------------------------------
echo.  ^> Установка всех основных приложений .AppX из папки \Files
echo.
set isExist=
for /f "tokens=1* delims=" %%I in (' 2^>nul dir /b /a:-d "Files\*.Appx" ^| findstr /i /v "[.]VCLibs[.].*[.]Appx\> [.]NET[.].*[.]Appx\> [.]Xaml_.*[.]Appx\> [.]WinJS[.].*[.]Appx\>" ') do (
  set isExist=1
  set Lic=
  for /f "tokens=1 delims=_" %%J in ("%%I") do (
    for /f "tokens=1* delims=" %%K in (' 2^>nul dir /b /a:-d "Files\%%J*.xml" ^| findstr /i "[.]xml\>" ') do set Lic=%%K
  )
  if "!Lic!" NEQ "" ( Call :InstallWithLic "%%I" "!Lic!" ) else ( Call :InstallNoLic "%%I" )
)

if not defined isExist ( echo.&echo.    Нет других файлов .AppX ^^^!^^^!^^^!&echo. )


echo.---------------------------------------------------------------------------------------------------
echo.  ^> Установка всех основных приложений .AppxBundle и MsixBundle из папки \Files
echo.
set isExist=
for /f "tokens=1* delims=" %%I in (' 2^>nul dir /b /a:-d "Files\*.AppxBundle" "Files\*.msixbundle" ^| findstr /i "[.]AppxBundle\> [.]msixbundle\>" ') do (
  set isExist=1
  set Lic=
  for /f "tokens=1 delims=_" %%J in ("%%I") do (
    for /f "tokens=1* delims=" %%K in (' 2^>nul dir /b /a:-d "Files\%%J*.xml" ^| findstr /i "[.]xml\>" ') do set Lic=%%K
  )
  if "!Lic!" NEQ "" ( Call :InstallWithLic "%%I" "!Lic!" ) else ( Call :InstallNoLic "%%I" )
)

if not defined isExist ( echo.&echo.    Нет файлов .AppxBundle в папке \Files ^^^!^^^!^^^!&echo. )
echo.---------------------------------------------------------------------------------------------------
echo.
echo.    Завершено
echo.
echo.Для выхода нажмите любую клавишу ...
TIMEOUT /T -1 >nul
exit


:InstallDependences
:: Пропуск файлов неподходящей разрядности. Для Windows х64: Пропуск arm и arm64, а для x86 пропуск arm, arm64 и x64
if "%xOS%"=="x86" ( echo.%1| findstr /i "_arm_ _arm64_ _x64_" >nul && exit /b )
if "%xOS%"=="x64" ( echo.%1| findstr /i "_arm_ _arm64_" >nul && exit /b )
echo        Пакет: %~1
chcp 866 >nul
PowerShell.exe Add-AppxPackage -Path '%~dp0Files\%~1' -ErrorAction Continue
chcp 65001 >nul
exit /b

:InstallWithLic
:: Пропуск файлов неподходящей разрядности. Для Windows х64: Пропуск arm и arm64, а для x86 пропуск arm, arm64 и x64
if "%xOS%"=="x86" ( echo.%1| findstr /i "_arm_ _arm64_ _x64_" >nul && exit /b )
if "%xOS%"=="x64" ( echo.%1| findstr /i "_arm_ _arm64_" >nul && exit /b )
echo   Приложение: %~1
echo     Лицензия: %~2
chcp 866 >nul
PowerShell.exe try { Add-AppxProvisionedPackage -Online -PackagePath '%~dp0Files\%~1' -LicensePath '%~dp0Files\%~2' -ErrorAction Stop } catch { Add-AppxPackage -Path '%~dp0Files\%~1' -ErrorAction Continue }
chcp 65001 >nul
exit /b

:InstallNoLic
:: Пропуск файлов неподходящей разрядности. Для Windows х64: Пропуск arm и arm64, а для x86 пропуск arm, arm64 и x64
if "%xOS%"=="x86" ( echo.%1| findstr /i "_arm_ _arm64_ _x64_" >nul && exit /b )
if "%xOS%"=="x64" ( echo.%1| findstr /i "_arm_ _arm64_" >nul && exit /b )
echo   Приложение: %~1
echo   Без лицензии
chcp 866 >nul
PowerShell.exe try { Add-AppxProvisionedPackage -Online -PackagePath '%~dp0Files\%~1' -SkipLicense -ErrorAction Stop } catch { Add-AppxPackage -Path '%~dp0Files\%~1' -ErrorAction Continue }
chcp 65001 >nul
exit /b


