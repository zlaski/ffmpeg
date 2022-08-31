@echo off

set OutDir=%~1

pushd %~dp0

echo Installing FFMPEG headers into "%OutDir%..\include" . . .

for /F "usebackq tokens=*" %%H in ("ffmpeg-headers.lst") do (
    xcopy /s /r /y "%%H" "%OutDir%..\include\%%H*" >nul
    attrib +R "%OutDir%..\include\%%H"
)

popd
