memcpy:
    ;----------------------
    ; build stack frame
    ;----------------------

        push    bp,
        mov     bp, sp

    ;----------------------
    ; save registers
    ;----------------------
        push    cx
        push    si
        push    di

    ;----------------------
    ; copy bytes
    ;----------------------
        cld
        mov     di, [bp + 4]
        mov     si, [bp + 6]
        mov     cx, [bp + 8]

        rep movsb

        pop     di
        pop     si
        pop     cx

        mov     sp, bp
        pop     bp
    ret

