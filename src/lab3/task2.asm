	.model small
	.stack 100h 	
	.386
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
	mov	eax, 65536
	mov 	bx, 16
	xor	edx, edx
 _lbl2:	div	ebx
 	push	edx
 	xor	edx, edx
 	inc	cx
	cmp	eax, 00h
 	jne	_lbl2

_lbl3:	pop	edx
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