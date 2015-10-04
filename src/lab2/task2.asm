	.model small
	.stack 100h 	
	.data
		D_ONE dw 04h
		D_TWO dw 03h
		SPACE db 20h
	.code 	

;Вывод символа из dl
printd 	proc
	mov 	bh, al
	mov 	ah, 02h
	int 	21h
	mov 	al, bh
	ret
printd 	endp

;Процедура перехода на новую строчку
enter	proc
	mov	dx, 13
	int	21h
	mov	ah, 02h
	mov	dx, 10
	int	21h
	ret
enter	endp

;Процедура вывода значений ax, bx через пробел
prints	proc
	mov	dl, al		;Вывод первой цифры
	call	printd

	mov	dl, SPACE	;Вывод пробела
	mov 	ah, 02h
	int 	21h

	mov	dl, bl		;Вывод второй
	call	printd

	call 	enter		;Переход на новую строку
	ret
prints 	endp

start:	mov	ax, @data	
	mov	ds, ax

	mov	ax, D_ONE	;Запись цифр в регистры
	add	ax, 30h	
	mov	bx, D_TWO
	add 	bx, 30h

	push	ax		;Сохранение значений регистров в стэке
	push 	bx

	call 	prints		;Вывод первой строки
	pop 	bx		;Восстановление значений регистров
	pop 	ax

	xchg 	ax, bx		;Обмен значений
	call	prints		;Вывод второй строки
	mov	ax, 4c00h	;Завершение работы программы
	int	21h

	end 	start