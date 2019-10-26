get_font_adr:
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
        push    es
        push    bp

    ;----------------------
    ; start processing
    ;----------------------
        mov     si, [bp + 4] 

        ; get font address from BIOS
        mov     ax, 0x1130
        mov     bh, 0x06
        int     10h


        mov     [si + 0], es
        mov     [si + 2], bp

    ;----------------------
    ; restore registers
    ;----------------------
        pop     bp
        pop     es
        pop     si
        pop     bx
        pop     ax

    ;----------------------
    ; discard stack frame
    ;----------------------
        mov     sp, bp
        pop     bp
    ret

