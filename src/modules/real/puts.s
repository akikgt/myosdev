puts:
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
        push    si

    ;----------------------
    ; get parameters
    ;----------------------
        mov     si, [bp + 4]

        ; start processing
        mov     ah, 0x0E
        mov     bx, 0x0000
        cld
.10L:
        lodsb

        cmp     al, 0
        je      .10E

        int     0x10
        jmp     .10L
.10E:
    ;----------------------
    ; restore registers
    ;----------------------
        pop     si
        pop     bx
        pop     ax

    ;----------------------
    ; discard stack frame
    ;----------------------
        mov     sp, bp
        pop     bp
    ret

