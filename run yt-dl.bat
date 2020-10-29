@echo off

:main
set /p url="URL: "
echo.
echo Printing available formats...
timeout 1 >nul
echo.
youtube-dl "%URL%" -F
echo.
echo Specify a format (av01, vp9 or avc1)
set format=vp9
set /p format="Format (default=vp9): "
timeout 1 >nul
echo.
echo Downloading video, please wait...
if %format%==av01 (youtube-dl %URL% -f "bestvideo[vcodec*=%format%]+bestaudio[acodec=opus]") >nul
if %format%==avc1 (youtube-dl %URL% -f "bestvideo[vcodec*=%format%]+bestaudio[acodec=opus]") >nul
if %format%==vp9 (youtube-dl %URL% -f "bestvideo[vcodec*=%format%]+bestaudio[acodec=opus]") >nul
echo.
echo Video downloaded, check the folder for the result
echo.
set loop=n
set /p loop="Want to download another video(y/n): "
if %loop%==y (goto :main) else (timeout 1 >nul & goto :end)

:end
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