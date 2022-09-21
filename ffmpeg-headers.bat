@echo off

set OutDir=%~1

pushd %~dp0

echo Installing FFMPEG headers into "%OutDir%..\include" . . .

for /F "usebackq tokens=*" %%H in ("ffmpeg-headers.lst") do (
    xcopy /s /r /y "%%H" "%OutDir%..\include\%%H*"
    attrib +R "%OutDir%..\include\%%H"
)

xcopy /r /y ffmpeg-headers.avconfig.h.in "%OutDir%..\include\libavutil\avconfig.h*"
attrib +R "%OutDir%..\include\libavutil\avconfig.h"

popd
