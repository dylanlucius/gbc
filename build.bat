@echo off
@set PROJ=main
@set GBDK=c:\gbdk\
@set GBDKLIB=%GBDK%lib\small\asxxxx\
@set OBJ=obj

@set DRV=hUGEDriver
@set MOD=song

@set CVTFLAGS=-b0

@if exist %PROJ%.gb del %TGT%/%PROJ%.gb
@if exist %PROJ%.sym del %TGT%/%PROJ%.map
@if exist %PROJ%.sym del %TGT%/%PROJ%.ihx
@if exist %PROJ%.map del %TGT%/%PROJ%.noi

@if not exist %OBJ% mkdir %OBJ%

tools\rgbasm -DGBDK -o%OBJ%/%DRV%.obj hUGEDriver.asm
py tools\rgb2sdas.py %CVTFLAGS% -o %OBJ%\%DRV%.o %OBJ%\%DRV%.obj
%GBDK%\bin\sdar -ru %OBJ%\hUGEDriver.lib %OBJ%\%DRV%.o

%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -c -o Player.o Player.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -c -o %PROJ%.o %PROJ%.c
%GBDK%\bin\lcc -Wl-m -Wl-w -Wl-j -Wl-yp0x143=0x80 -Wm-yS -Wl-k%OBJ% -Wl-lhUGEDriver.lib -o gbc.gb %PROJ%.c c:/gbc/song/C/%MOD%.c Player.o

move hUGEDriver.asm obj

del *.lst *.o *.sym *.map *.noi *.asm

cd obj

move hUGEDriver.asm ..

cd ..
