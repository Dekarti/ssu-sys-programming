	.model	tiny
	.code
	.386
	org	100h

beg:	jmp	start	
	curr_date_msg	db "Current time $"
	hours_set_msg	db "Enter hours: $"
	mins_set_msg	db "Enter minutes: $"
	secs_set_msg	db "Enter seconds: $"
	nl		db 0Ah, 0Dh, '$'					 
									 

start:	lea 	dx, curr_date_msg
	mov	ah, 09
	int 	21h

	mov	ah, 02h
	int	1ah
	push 	dx

	mov	bx, 10h

	xor	ax, ax
	mov	al, ch
	call	printax
	xor	ax, ax
	mov	dx, ":"
	mov	ah, 02h
	int	21h

	xor	ax, ax
	mov	al, cl
	call	printax
	mov	dx, ":"
	mov	ah, 02h
	int	21h

	xor	ax, ax
	pop 	dx
	mov	al, dh
	call	printax

	lea	dx, nl
	mov	ah, 09
	int	21h
	int	21h

	lea 	dx, hours_set_msg
	int 	21h
	call	scan
	xor	ax, ax
	push	dx
	lea	dx, nl
	mov	ah, 09h
	int 	21h

	lea 	dx, mins_set_msg
	int 	21h
	call	scan
	push	dx
	xor	ax, ax
	mov	cl, dl
	lea	dx, nl
	mov	ah, 09h
	int 	21h

	lea 	dx, secs_set_msg
	int 	21h
	call	scan
	push	dx
	xor	ax, ax
	mov	dh, dl
	lea	dx, nl
	mov	ah, 09h
	int 	21h

	xor	bx, bx
	pop	bx
	mov	dh, bl
	xor	bx, bx
	pop	bx
	mov	cl, bl
	xor	bx, bx
	pop	bx
	mov	ch, bl
	
	
	
	mov	ah, 03h
	int	1ah
	jmp	start

	mov	ax, 4c00h
	int	21h

;Вывод символа из dl
printax proc
	pusha

	xor	dx, dx
	div	bx
	push 	dx

	xor	dx, dx
	div	bx
	push 	dx

	xor	cx, cx
	mov	cx, 2
	mov     ah, 02h
_lbl5:  pop     dx
	add	dl, 30h
	int     21h
	loop    _lbl5

	popa
	ret

printax endp

; Считывание числа в dl
scan	proc
	mov	ah, 01h
	int	21h
	mov	dl, al
	sub	dl, 30h
	mov	cl, 04h
	shl	dl, cl
	int	21h
	sub	al, 30h
	add	dl, al
	ret
scan	endp
	
	end	beg
