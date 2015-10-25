	.model small
	.stack 100h 	
	.data
		result		db '     $'
		newline		db 0Ah, 0Dh, '$'
 	.code 	

; Вывод символа из dl
printd 	proc
	push	ax
	mov 	ah, 02h
	add	dl, 48
	cmp	dl, 39h
	jle	_lbl1
	add	dl, 07
_lbl1:	int 	21h
	pop 	ax
	ret
printd 	endp

toasc	proc
	; Заносим цифры числа поочередно в стек
	xor	cx, cx
	mov 	bx, 10
	xor	dx, dx
 _lbl2:	div	bx
 	push 	dx
 	xor	dx, dx
 	inc	cx
	cmp	ax, 00h
 	jne	_lbl2

 	mov	si, 0
_lbl3:	pop	dx
	;call	printd
	push	ax
	add	dl, 48
	cmp	dl, 39h
	jle	_lbl4
	add	dl, 07
_lbl4:	mov 	result[si], dl
	pop 	ax
	inc	si
	loop	_lbl3
	ret
toasc	endp

start:	mov	ax, @data	
	mov	ds, ax

	mov	ax, 12
	call	toasc

	mov 	ah, 09h
	mov	dx, offset result
	int	21h
	
	mov 	dx, offset newline
	int 	21h

	mov	ax, 4c00h	;Завершение работы программы
	int	21h


	end 	start