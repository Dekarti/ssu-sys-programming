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

start:	mov	ax, @data
	mov	ds, ax

	;Запись цифр в регистры
	mov	ax, D_ONE
	add	ax, 30h	
	mov	bx, D_TWO
	add 	bx, 30h

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

	mov	ax, 4c00h
	int	21h

	end 	start