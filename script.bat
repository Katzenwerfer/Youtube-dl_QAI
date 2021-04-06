@echo off
cd /d "%~dp0"

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
"%cd%/youtube-dl" "%URL%" -F
echo.
echo Specify a format (av01, vp9 or avc1) (type "a" for audio only)
set format=vp9
set /p format="Format (default=vp9): "
timeout 1 >nul
echo.
echo Downloading file, please wait...
if %format%==a ("%cd%/youtube-d"l %URL% -f "bestaudio[acodec=opus]" -o "%output%\%%(title)s.webm")
if %format%==av01 ("%cd%/youtube-dl" %URL% -f "bestvideo[vcodec*=%format%][height<=%resolution%]+bestaudio[acodec=opus]" -o "%output%\%%(title)s")
if %format%==avc1 ("%cd%/youtube-dl" %URL% -f "bestvideo[vcodec*=%format%][height<=%resolution%]+bestaudio[acodec=opus]" -o "%output%\%%(title)s")
if %format%==vp9 ("%cd%/youtube-dl" %URL% -f "bestvideo[vcodec*=%format%][height<=%resolution%]+bestaudio[acodec=opus]" -o "%output%\%%(title)s")
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
