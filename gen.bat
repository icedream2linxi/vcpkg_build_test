if "%ENV_SETED%" == "1" goto go
set PATH=f:\vcpkg\downloads\tools\cmake-3.11.4-windows\cmake-3.11.4-win32-x86\bin;f:\vcpkg\downloads\tools\ninja\ninja-1.8.2;%PATH%
set ENV_SETED=1

:go
set BUILD_DIR=build
if not exist "%BUILD_DIR%" mkdir %BUILD_DIR%
cd %BUILD_DIR%
cmake -G "Ninja" ^
      -DCMAKE_BUILD_TYPE=Debug ^
      -DVCPKG_APPLOCAL_DEPS=ON ^
      -DVCPKG_TARGET_TRIPLET=x64-windows-static ^
      -DCMAKE_TOOLCHAIN_FILE=d:/my_vcpkg/scripts/buildsystems/vcpkg.cmake ^
      ..

cd %~dp0