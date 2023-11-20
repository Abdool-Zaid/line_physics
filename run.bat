@echo off
set "script_path=%~dp0"
set "engine=%script_path%engine"
set "main=main"

start /b "app" "%engine%\love.exe" "%main%" 


exit
 
