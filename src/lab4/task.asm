		.model	small
		.stack	100h
		.186
		.386
		.data
			arr1	dw 20 dup(?)		; массив чисел
			result	db '     $'		; формат вывода
			nl	dw 0Ah, 0Dh, '$'	; новая строка
		.code

;==============================================================================
; Процедура преобразования числа в форматированную строку
;==============================================================================
toasc		proc
		; Сохраняем значения регистров
		pusha

		; Выделяем цифры из числа и помещаем в стек
		xor	cx, cx
		mov 	bx, 10
		xor	dx, dx
 _lbl2:		div	bx
 		push 	dx
 		xor	dx, dx
 		inc	cx
		cmp	ax, 00h
 		jne	_lbl2
	
		; Преобразуем цифры числа в ascii код
		; и помещаем в результат
		mov	bx, cx
		mov	si, 5
		sub	si, cx
_lbl3:		pop	dx
		push	ax
		add	dl, 48
		cmp	dl, 39h
		jle	_lbl4
		add	dl, 07
_lbl4:		mov	result[si], dl
		inc	si
		pop 	ax
		loop	_lbl3

		; Заполняем пробелами незначащие символы
		mov 	cx, 5
		sub	cx, bx
		mov 	si, 0
 _null:		mov	result[si], ' '
 		inc 	si
 		loop 	_null

 		; Восстанавливаем значения регистров
		popa

		ret
toasc		endp
;==============================================================================
; НАЧАЛО ПРОГРАММЫ
;==============================================================================
start:		mov	ax, @data 
		mov	ds, ax

		; Формирование массива
		mov 	cx, 10
		mov 	bx, 3
		mov 	si, 0
_fill_arr1:	mov 	arr1[si], bx
		xor	ax, ax
		mov	ax, arr1[si]
		mul	ax
		mov	arr1[si+20], ax
		add	bl, 3
		add 	si, 2
		loop 	_fill_arr1


 		mov 	ah, 09h
		mov	dx, offset nl
		int 	21h

		mov	cx, 20
		mov 	si, 0
_loop1:		mov	ax, arr1[si]
		call	toasc
		mov 	ah, 09h
		cmp	cx, 10
		je 	_nl
		mov	dx, offset result
		jmp	_print
_nl:		mov	dx, offset nl
		int	21h
		mov	dx, offset result
_print:		int 	21h
		add	si, 2
 		loop 	_loop1

 		mov 	ah, 09h
		mov	dx, offset nl
		int 	21h

		mov	ax, 4c00h
		int 	21h

		end 	start








