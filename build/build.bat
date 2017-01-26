@echo off

set CMAKE=%~dp0../thirdparty/cmake/3.7.2/bin
set PATH=%CMAKE%;%PATH%

set SDL=%~dp0../thirdparty/SDL/2.0.5
set SDL_net=%~dp0../thirdparty/SDL_net/2.0.1
set ZLIB=%~dp0../thirdparty/zlib/1.2.11
set LIBPNG=%~dp0../thirdparty/libpng/1.6.28

set DEVENV="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com"

if not exist %~dp0..\bin mkdir %~dp0..\bin

cd %ZLIB%
if exist build rmdir /q /s build
if not exist build mkdir build
cd build
cmake .. -G"Visual Studio 14 2015" -DCMAKE_INSTALL_PREFIX=%~dp0../bin/zlib
cmake --build . --target install --config Debug
cmake --build . --target install --config Release

cd %LIBPNG%
if exist build rmdir /q /s build
if not exist build mkdir build
cd build
cmake .. -G"Visual Studio 14 2015" -DCMAKE_INSTALL_PREFIX=%~dp0../bin/libpng -DPNG_BUILD_ZLIB=1 -DZLIB_LIBRARY=%~dp0../bin/zlib/lib/zlib.lib -DZLIB_INCLUDE_DIR=%~dp0../bin/zlib/include
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
IF ERRORLEVEL 1 goto ERROR

cd %SDL%
if exist build rmdir /q /s build
if not exist build mkdir build
cd build
cmake .. -G"Visual Studio 14 2015" -DSDL_STATIC=1 -DCMAKE_INSTALL_PREFIX=%~dp0../bin/sdl
cmake --build . --target install --config Debug
cmake --build . --target install --config Release
IF ERRORLEVEL 1 goto ERROR

%DEVENV% %~dp0../thidparty/SDL_net/2.0.1/VisualC/SDL_net.sln /build "Release|Win32"

%DEVENV% %~dp0../visualc_net/dosbox.sln /build "Release|x86"

:ERROR
echo Ran into an error! Error Level: %ERRROLEVEL%
goto END

:END
cd %~dp0