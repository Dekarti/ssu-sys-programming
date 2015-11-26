        .model small
       
        .stack 100h
 
        .386
 
        .data
 
        .code
 
; Печатает содержимое регистра AL
prntchr proc    near
        push    cx
 
        mov     cx, 2
        mov     bh, al
       
        ; В цикле из двух итераций выводим
        ; сначала старший разряд числа, потом - младший
 
        shr     al, 04
       
_m1:    ; Перевод в ASCII код
        add     al, 30h
        cmp     al, 39h
        jle     _l1
        add     al, 07h
 
_l1:    mov     es:[si], ax
        mov     al, bh
        and     al, 00001111b
        add     si, 2
        loop    _m1
 
        add     di, 01h
 
        pop     cx
        ret
prntchr endp
 
; Очищает экран
clrscr  proc    near
        pushad
        mov     ah, 06h
        mov     bh, 07h
        mov     cx, 0
        mov     dx, 184Fh
        int     10h
        popad
        ret
clrscr  endp
 
_start:
        mov     ax, @data
        mov     ds, ax
 
        mov     ax, 0B800h
        mov     es, ax
        mov     si, 0
        mov     di, 0
        mov     ah, 07h
 
        ; Получение размера программы
        mov     cx, offset _end
        sub     cx, offset _start
 
        call    clrscr
 
_loop:  mov     al, cs:[di]
        call    prntchr
        loop    _loop
 
        mov     ah, 01h         ; ожидание нажатия любой клавиши,
        int     21h             ; после чего можно очищать
        call    clrscr          ; экран и выходить из программы
 
        mov     ax, 4C00h
_end:   int     21h
 
        end     _start