cd ..
dir /s /b *.v *.sv >temp.txt

:: 将\分隔符替换为/

@echo off

(for /f "delims=" %%a in ('type "temp.txt"') do (
    set "str=%%a"
    setlocal enabledelayedexpansion
    set str=!str:\=/!
    echo,!str!
    endlocal
))>./script/filelist_v_sv.txt
del /s /q /f temp.txt