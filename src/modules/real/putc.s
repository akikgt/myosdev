putc:
    ;----------------------
    ; build stack frame
    ;----------------------

        push    bp,
        mov     bp, sp

    ;----------------------
    ; save registers
    ;----------------------
        push    ax
        push    bx

    ;----------------------
    ; get parameters
    ;----------------------
        mov     al, [bp + 4]
        mov     ah, 0x0E
        mov     bx, 0x0000
        int     0x10

    ;----------------------
    ; restore registers
    ;----------------------
        pop     bx
        pop     ax

    ;----------------------
    ; discard stack frame
    ;----------------------
        mov     sp, bp
        pop     bp
    ret

