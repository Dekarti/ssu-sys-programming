		.model small
		.stack 100h
		.186
		.data
			row		db 30
			col		db 20
			color		db 00001010b
			mode 		db ?
			char 		db 'C'
		.code

; Получение/установка видеорежима
b10mode 	proc       
		pusha
		mov 	ah, 0Fh
		int 	10h
		mov	mode, al
		mov	ax, 0003h
		int	10h
		popa
		ret 
b10mode		endp

; Очистка экрана 
c10clear	proc      
		pusha
		mov 	ax, 0600h
		mov	bh, 07
		mov 	cx, 0000  ;от 00:00 до 
		mov 	dx, 184fh ;24:79 (весь экран) 
		int	10h       ;Вызвать обработчик прерывания
		popa
		ret 
c10clear	endp

; Установка курсора 
d10cursor	proc 
		mov	ah, 02
		mov	bh, 00
		mov	dh, col
		mov	dl, row
		int 	10h
		ret
d10cursor	endp

; Вывод символа на экран
e10display 	proc
		pusha
		mov 	ah, 09h 	;запросить вывод (в текстовом режиме) 
		mov	al, char 	;выводимый символ 
		mov	bh, 00	 	;страница 0 
		mov 	bl, color 	;синий фон, коричневые символы 
		mov 	cx, 9	  	;число выводимых символов 
		int 	10h    		;вызвать обработчик прерывания
		popa
		ret 
e10display 	endp

; Начало программы
start:		mov	ax, @data
		mov	ds, ax

		mov 	ax, 0b900h
		mov 	es, ax     

		call	b10mode
		call	c10clear

		mov	cx, 5
_loop:		call	d10cursor
		call	e10display

		inc	col
		inc	char
		inc	color
		loop 	_loop


		mov 	ah, 01h
		int 	21h

		call	c10clear

		mov 	ah, 05h 
		mov 	al, 01h 
		int 	10h    

		mov	ax, 4c00h
		int 	21h

		end	start