::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Jorge Anzola                                   ::
:: Anzola@protonmail.com                          ::
:: www.github.com/JorgeAnzola/image-size-reductor ::
::::::::::::::::::::::::::::::::::::::::::::::::::::


@echo off
mkdir processed
xcopy *.jpg processed /y
xcopy *.jpeg processed /y
xcopy ffmpeg.exe processed /y
cd processed
:renameNoSpace  [/R]  [FolderPath]
setlocal disableDelayedExpansion
if /i "%~1"=="/R" (
  set "forOption=%~1 %2"
  set "inPath="
) else (
  set "forOption="
  if "%~1" neq "" (set "inPath=%~1\") else set "inPath="
)
for %forOption% %%F in ("%inPath%* *") do (
  if /i "%~f0" neq "%%~fF" (
    set "folder=%%~dpF"
    set "file=%%~nxF"
    setlocal enableDelayedExpansion
    echo ren "!folder!!file!" "!file: =!"
    ren "!folder!!file!" "!file: =!"
    endlocal
  )
)
mkdir temp
cls
set /p imgQ=1-30 (The smaller the number, the better the quality. 10 recommended): 
for %%F in (*.jpg) do (
    ffmpeg.exe -i %%F -q:v %imgQ% temp/%%F
)
for %%F in (*.jpeg) do (
    ffmpeg.exe -i %%F -q:v %imgQ% temp/%%F
)
xcopy temp\* /y
RD /S /Q temp
del ffmpeg.exe