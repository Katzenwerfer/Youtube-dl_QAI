@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
cd /d "%~dp0"
:: echo %cd%

set startup=yes
set /p startup=<startup.txt
cls
if %startup%==yes (goto :first) else (goto :startup)

:first
del /q "%CD%\output.txt"
del /q "%CD%\height.txt"
cls
timeout 1 >nul
echo First time running the script?
timeout 1 >nul
echo Well, don't worry!
timeout 1 >nul
echo Lets just setup some things and you will be ready to download as many videos as you want
pause
cls
timeout 1 >nul
echo Set a download folder (add the folder without quotes "" and/or spaces)
timeout 1 >nul
echo Default is the script's current directory
timeout 1 >nul
set var1=%CD%
set /p var1="Output folder: "
echo %var1% >output.txt
attrib +h "%CD%\output.txt"
timeout 1 >nul
cls
timeout 1 >nul
echo Set a max download resolution
timeout 1 >nul
echo This is useful to avoid downloading a 4k video instead of its 1080p versiom, etc.
timeout 1 >nul
echo The default is set to 10000 pixels of width to avoid limiting the max resolution in case you don't want to
timeout 1 >nul
set var2=10000
set /p var2="Max height: "
echo %var2% >height.txt
attrib +h "%CD%\height.txt"
timeout 1 >nul
cls
timeout 1 >nul
echo Yeah...there isn't anything else to setup
timeout 1 >nul
echo I'm out of ideas
timeout 1 >nul
echo But anyways, you finished setting up things, enjoy downloading a lot of files!
set var3=no
echo %var3% >startup.txt
pause

:startup
set /p output=<output.txt
set output=%output: =%
set /p resolution=<height.txt
set resolution=%resolution: =%

:main
cls
set /p URL="URL: "
echo.
echo Printing available formats...
timeout 1 >nul
echo.
"%cd%/yt-dlp" "%URL%" -F
echo.
echo Specify a format (avc, vp9 or av1) (type "a" for audio only)
set format=best
set /p format="Format (default=best): "
timeout 1 >nul
echo.
echo Downloading file, please wait...
if %format%==best ("%cd%/yt-dlp" %URL% -f "bv[height<=%resolution%]+ba]" -o "%output%\%%(title)s")
if %format%==a ("%cd%/yt-dlp" %URL% -f "ba[acodec=opus]" -o "%output%\%%(title)s.ogg")
if %format%==avc ("%cd%/yt-dlp" %URL% -f "bv[vcodec*=avc1][height<=%resolution%]+ba[acodec*=opus]" -o "%output%\%%(title)s")
if %format%==av1 ("%cd%/yt-dlp" %URL% -f "bv[vcodec*=av01][height<=%resolution%]+ba[acodec*=opus]" -o "%output%\%%(title)s")
if %format%==vp9 ("%cd%/yt-dlp" %URL% -f "bv[vcodec*=vp9][height<=%resolution%]+ba[acodec*=opus]" -o "%output%\%%(title)s")
echo.
echo File downloaded, check the folder for the result
echo.
set loop=y
set /p loop="Want to download another file(y/n): "
if %loop%==y (goto :main) else (timeout 1 >nul & goto :end)

:end
cls
%SystemRoot%\explorer.exe "%output%"
echo.
echo Thanks for wasting my time!
timeout 1 >nul
echo.
echo Script written by Katzenwerfer
timeout 1 >nul
echo.
echo Closing in 3
timeout 1 >nul
echo            2
timeout 1 >nul
echo            1
timeout 1 >nul
exit

rem Remember to add this things
rem - Support for batch downloading with text file of URLs or something
rem - Support for Advanced Downloading, using those f[number] things
rem - yeah...I can't think of something else...ah!, port this shit to powershell
rem - oh, and also add a yt-dlp.exe installer/updater check at start
rem - new idea, add a menu similar to the one in BudHUD updater