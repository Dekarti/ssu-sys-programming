	.model	tiny
	.code
	.386
	org	100h

_beg:	jmp	_start							  ; 1100100000100011
									  ; FEDCBA9876543210
	msg_printers	db "Number of printers installed . . . . . . . $" ; xx..............
	msg_modem	db "Internal modem installed . . . . . . . . . $" ; ..x.............
	msg_gameadpt	db "Game adapter installed . . . . . . . . . . $" ; ...x............
	msg_ports	db "Number of serial ports . . . . . . . . . . $" ; ....xxx.........
	rsrvd2		db "Reserved . . . . . . . . . . . . . . . . . $" ; .......x........
	msg_diskettes	db "Number of diskettes  . . . . . . . . . . . $" ; ........xx......
	msg_vmode	db "Initial video mode . . . . . . . . . . . . $" ; ..........xx....
	rsrvd1		db "Reserved . . . . . . . . . . . . . . . . . $" ; ............x...
	rsrvd0		db "Reserved . . . . . . . . . . . . . . . . . $" ; .............x..
	msg_soprocc	db "Math coprocessor . . . . . . . . . . . . . $" ; ..............x.
	msg_fdisk	db "Floppy drive installed . . . . . . . . . . $" ; ...............x

	msg_mem 	db "Memory size  . . . . . . . . . . . . . . . $"
 
	msgs 		dw offset msg_printers	
			dw offset msg_modem	
			dw offset msg_gameadpt	
			dw offset msg_ports	
			dw offset rsrvd2		
			dw offset msg_diskettes	
			dw offset msg_vmode	
			dw offset rsrvd1		
			dw offset rsrvd0		
			dw offset msg_soprocc	
			dw offset msg_fdisk	

	bits		db 1, 1, 1, 1, 2, 2, 1, 3, 1, 1, 2
	nl		db 0Ah, 0Dh, '$'

_start:
	int 	11h
	;mov ax, 1100100000100011b

	mov	si, msgs
	mov	di, 0
	mov	cx, 11
_lbl1: 	push	cx
	mov	cl, bits[di]
	shld	bx, ax, cl
	inc	di
	pop	cx
	add	bx, 30h
	push	bx
	xor	bx, bx
	loop	_lbl1

	mov	cx, 11
	mov	si, 0
	mov 	ah, 09h
	mov	dx, offset nl
	int 	21h
_lbl2:	mov	ah, 09h
	mov	dx, msgs[si]
	add	si, 2
	int 	21h
	mov	ah, 02h
	pop	dx
	int 	21h
	mov	ah, 09h
	mov	dx, offset nl
	int 	21h
	loop	_lbl2

	mov	ah, 09h
	lea	dx, msg_mem
	int 	21h
	int 	12h
	mov	bx, 10
	call	printax
	mov	ah, 09h
	lea	dx, nl
	int 	21h

toasc proc
        add     dl, 30h
        cmp     dl, 39h
        jle     _d2a
        add     dl, 07h
_d2a:   ret
toasc endp

; Вывод символа из dl
printax proc
        pusha
        xor     cx, cx

        cmp     ax, 0
        jne     _lbl3
        push    "0"
        inc     cx

_lbl3:  cmp     ax, 0
        je      _lbl4
        xor     dx, dx
        div     bx
        call    toasc
        push    dx
        inc     cx
        jmp     _lbl3 
_lbl4:  mov     ah, 02h
        
_lbl5:  pop     dx
        int     21h
        loop    _lbl5

	popa
        ret
printax endp

	end	_beg



