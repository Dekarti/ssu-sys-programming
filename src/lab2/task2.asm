	.model small
	.stack 100h 	
	.data
		D_ONE dw 04h
		D_TWO dw 03h
		SPACE db 20h
	.code 	
	
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

	;Вывод первой цифры
	mov	dl, al
	call	printd

	;Вывод пробела
	mov	dl, SPACE
	mov 	ah, 02h
	int 	21h

	;Вывод второй
	mov	dl, bl
	call	printd

	;Переход на новую строку
	call 	enter
	ret
prints 	endp

start:	mov	ax, @data
	mov	ds, ax

	;Запись цифр в регистры
	mov	ax, D_ONE
	add	ax, 30h	
	mov	bx, D_TWO
	add 	bx, 30h

	;Сохранение значений регистров в стэке
	push	ax
	push 	bx

	;Вывод первой строки
	call 	prints

	;Восстановление значений регистров
	pop 	bx
	pop 	ax

	;Обмен значений
	xchg 	ax, bx

	;Вывод второй строки
	call	prints

	;Завершение работы программы
	mov	ax, 4c00h
	int	21h

	end 	start