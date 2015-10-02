set filepath=%1
set filename=%2
set fullpath=%filepath%%filename%
tasm.exe %fullpath%.asm /l
tlink.exe /x %fullpath%.obj %3
%filename%
 
