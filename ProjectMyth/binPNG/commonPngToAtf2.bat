::png2atf.exe -i sky_spritesheet.png -o sky_spritesheet.atf
@echo off
SET TOOL_PATH="L:\Development\projects\as3\ATF Tools\tools\"


copy /y nul common.atf
call %TOOL_PATH%png2atf.exe -c -r -e -i common.png -o common.atf
pause