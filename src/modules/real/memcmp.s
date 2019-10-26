memcpy:
    ;----------------------
    ; build stack frame
    ;----------------------

        push    bp,
        mov     bp, sp

    ;----------------------
    ; save registers
    ;----------------------
        push    bx
        push    cx
        push    dx
        push    si
        push    di

    ;----------------------
    ; get parameters
    ;----------------------
        cld
        mov     di, [bp + 4]
        mov     si, [bp + 6]
        mov     cx, [bp + 8]

    ;----------------------
    ; compare
    ;----------------------
        repe cmpsb
        jnz     .10F
        mov     ax, 0
        jmp     .10E
.10F:
        mov     ax, -1
.10E:
    ;----------------------
    ; restore registers
    ;----------------------
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx

        mov     sp, bp
        pop     bp
    ret

