@echo off
set filepath=%1
set filename=%2
set fullpath=%filepath%%filename%
tasm %fullpath%.asm /l
tlink /x %filename%.obj %3
%filename%
del %filename%.obj



