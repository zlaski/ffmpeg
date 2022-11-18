@echo off
setlocal EnableExtensions EnableDelayedExpansion

set OutDir=%~1

pushd %~dp0

for /F %%H in (ffmpeg-headers.lst) do (
    set QHDR="%OutDir%..\include\%%H"
    echo %%H -^> !QHDR!
    for %%D in (!QHDR!) do set QDIR="%%~dpD"
    mkdir !QDIR! 2>nul
    attrib -R !QHDR! >nul
    echo EMPTY >!QHDR!
    xcopy /s /r /y /q %%H !QHDR! >nul
    attrib +R !QHDR!
)

set AVCONF="%OutDir%..\include\libavutil\avconfig.h"
echo avconfig.h.in -^> %AVCONF%
attrib -R %AVCONF% >nul
echo EMPTY >%AVCONF%
xcopy /s /r /y /q avconfig.h.in %AVCONF% >nul
attrib +R %AVCONF%

popd
