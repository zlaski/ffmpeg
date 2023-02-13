@echo off
setlocal EnableExtensions EnableDelayedExpansion

set OutDir=%~1

pushd %~dp0

::     echo %%H -^> !QHDR!

for /F %%H in (ffmpeg-headers.lst) do (
    set QHDR="%OutDir%..\include\%%H"
    for %%D in (!QHDR!) do set QDIR="%%~dpD"
    mkdir !QDIR! 2>nul
    attrib -R !QHDR! >nul
    echo EMPTY >!QHDR!
    xcopy /s /r /y /q %%H !QHDR! >nul
    attrib +R !QHDR!
)

popd
