	.model small
	.stack 100h 	
	.data
 	.code 	

;Вывод символа из dl
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

start:	mov	ax, @data	
	mov	ds, ax


	; Заносим цифры числа поочередно в стек
	xor	cx, cx
	mov	ax, 0AABCh
	mov 	bx, 16
	xor	dx, dx
 _lbl2:	div	bx
 	push	dx
 	xor	dx, dx
 	inc	cx
	cmp	ax, 00h
 	jne	_lbl2

_lbl3:	pop	dx
	call	printd
	loop	_lbl3

	mov	ah, 02h
	mov	dx, 13
	int	21h
	mov	dx, 10
	int	21h

	mov	ax, 4c00h	;Завершение работы программы
	int	21h

	end 	start