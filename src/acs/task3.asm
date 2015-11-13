.MODEL small
.STACK 100h
.DATA
	a_count db 0		;счётчик выводимых байтов
	nln db '', 10,13,'$' 	;перевод строки
.CODE
start:
	mov ax, @data
	mov ds, ax
	mov si,0 		
	mov cx, offset exit		
	sub cx, offset start	;определяем размер памяти

lab1:
	mov dl, cs:[si]

	mov bl, dl    
	shr dl, 04		;осуществляем сдвиг на 4 разряда вправо
	add dl, 30h
	cmp dl, 39h		;сравниваем с 9
	jle m1
	add dl, 7h
	
m1:	mov ah, 02h		;выводим старшую цифру
	int 21h
	
	mov dl, bl
	and dl, 0Fh		;обнуляем старшую цифру
	add dl, 30h
	cmp dl, 39h
	jle m2
	add dl, 7h

m2:	mov ah, 02h		;выводим младшую цифру
	int 21h

	inc si
	mov dl, 20h		;выводим пробел	
	mov al, 02h
	int 21h
	
	inc a_count		;увеличиваем счётчик байтов
	cmp a_count, 16		;сравниваем с 16
	jne m3			;если не равно, то переходим на m2
	mov a_count, 0h		;иначе обнуляем счётчик
	lea dx, nln		;и переводим на новую строку
	mov ah, 09h
	int 21h
m3: loop lab1
	
	mov  AH,00     		;Функция ввода
   	int  16H       		;ожидание клавиши
	cmp al, 0dh		;проверяем, нажата клавиша Enter?
	je exit			;если да, то выходим

exit:
	mov ah, 05h		;при выходе возращаемся на нулевую страницу
	mov al, 00
	int 10h
	mov ax, 4c00h
	int 21h
END start
