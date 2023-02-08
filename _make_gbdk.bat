@echo off
@set PROJ=main
@set GBDK=c:\gbdk\
@set GBDKLIB=%GBDK%lib\small\asxxxx\
@set OBJ=obj

@set DRV=hUGEDriver
@set MOD=song

@set CVTFLAGS=-b0

@REM @echo Cleanup...

@REM @if exist %PROJ%.gb del %TGT%/%PROJ%.gb
@REM @if exist %PROJ%.sym del %TGT%/%PROJ%.map
@REM @if exist %PROJ%.sym del %TGT%/%PROJ%.ihx
@REM @if exist %PROJ%.map del %TGT%/%PROJ%.noi

@if not exist %OBJ% mkdir %OBJ%

@REM @echo Assembling song and driver...

tools\rgbasm -DGBDK -o%OBJ%/%DRV%.obj hUGEDriver.asm
py tools\rgb2sdas.py %CVTFLAGS% -o %OBJ%\%DRV%.o %OBJ%\%DRV%.obj
%GBDK%\bin\sdar -ru %OBJ%\hUGEDriver.lib %OBJ%\%DRV%.o

@REM @echo COMPILING WITH GBDK-2020...

%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -c -o Player.o Player.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -c -o %PROJ%.o %PROJ%.c
%GBDK%\bin\lcc -Wl-m -Wl-w -Wl-j -Wl-yp0x143=0x80 -Wm-yS -Wl-k%OBJ% -Wl-lhUGEDriver.lib -o %PROJ%.gb %PROJ%.c %MOD%.c Player.o

@REM @echo DONE!
