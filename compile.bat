@echo off
setlocal enabledelayedexpansion

:: Capture the start time
set "start_time=!time!"
set "script_path=%~dp0"
set "engine=%script_path%engine"
set "main=main"
set "love=%script_path%engine\love.exe"
set "zip=C:\Program Files (x86)\7-Zip\7z.exe"
for %%A in ("%CD%") do set "name=%%~nxA"
set "to_zip=%script_path%%main%"
mkdir output
set "out=%script_path%output\%name%.love"
set "fin=%script_path%output\%name%.exe"

"%zip%" a -tzip "%out%" "%to_zip%\*"

copy /b "%love%" + "%out%" "%fin%"
del /f "%out%"

for /r "%engine%" %%F in (*.dll) do (
    set "dll_files=!dll_files! "%%F""
)

for %%D in (%dll_files%) do (
    copy /y "%%~D" "%script_path%output\%%~nxD"
)

set "to_zip=%script_path%output"
set "out=%script_path%\export.zip"

"%zip%" a -tzip "%out%" "%to_zip%\*"






:: Capture the end time
set "end_time=!time!"

:: Calculate the time difference
set "start_seconds=!start_time:~6,1!"
set "start_milliseconds=!start_time:~9,2!"
set "end_seconds=!end_time:~6,1!"
set "end_milliseconds=!end_time:~9,2!"

set /a "elapsed_time_seconds=end_seconds-start_seconds"
set /a "elapsed_time_milliseconds=end_milliseconds-start_milliseconds"

echo Execution time: !elapsed_time_seconds!.!elapsed_time_milliseconds! seconds

endlocal

pause
